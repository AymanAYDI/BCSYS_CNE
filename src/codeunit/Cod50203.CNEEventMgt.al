codeunit 50203 "BC6__CNEEventMgt"
{

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Header", 'OnAfterValidateEvent', 'Destination No.', false, false)]
    local procedure T5766_OnAfterValidate(var Rec: Record "Warehouse Activity Header"; var xRec: Record "Warehouse Activity Header")
    var
        Customer: Record Customer;
    begin
        case Rec."Destination Type" of
            Rec."Destination Type"::Customer:
                BEGIN
                    Customer.GET(Rec."Destination No.");
                    case Customer.Blocked of
                        1, 3:
                            Customer.TESTFIELD(Blocked, 0);
                    end;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnAfterValidateEvent', 'Sales Code', false, false)]
    local procedure T7002_OnAfterValidateEvent(var Rec: Record "Sales Price"; var xRec: Record "Sales Price")
    var
        "-FE25-26.001:SEBC-": Integer;
        RecGSalesSetup: Record "Sales & Receivables Setup";
        CustPriceGr: Record "Customer Price Group";
        Cust: Record Customer;
        Campaign: Record Campaign;
        Text001: Label '%1 must be blank.', Comment = 'FRA="%1 doit être blanc."';
    begin
        RecGSalesSetup.GET;
        if Rec."Sales Code" <> '' then
            case Rec."Sales Type" of
                Rec."Sales Type"::"All Customers":
                    Error(Text001, Rec.FieldCaption(Rec."Sales Code"));
                Rec."Sales Type"::"Customer Price Group":
                    begin
                        CustPriceGr.Get(Rec."Sales Code");
                        Rec."Price Includes VAT" := CustPriceGr."Price Includes VAT";
                        Rec."VAT Bus. Posting Gr. (Price)" := CustPriceGr."VAT Bus. Posting Gr. (Price)";
                        IF RecGSalesSetup."BC6_Upd. Price AllowLine disc." THEN
                            Rec."Allow Line Disc." := CustPriceGr."Allow Line Disc."
                        else
                            Rec."Allow Line Disc." := xRec."Allow Line Disc.";
                        Rec."Allow Invoice Disc." := CustPriceGr."Allow Invoice Disc.";
                    end;
                Rec."Sales Type"::Customer:
                    begin
                        Cust.Get(Rec."Sales Code");
                        Rec."Currency Code" := Cust."Currency Code";
                        Rec."Price Includes VAT" := Cust."Prices Including VAT";
                        Rec."VAT Bus. Posting Gr. (Price)" := Cust."VAT Bus. Posting Group";
                        IF RecGSalesSetup."BC6_Upd. Price AllowLine disc." THEN
                            Rec."Allow Line Disc." := Cust."Allow Line Disc."
                        else
                            Rec."Allow Line Disc." := xRec."Allow Line Disc.";
                    end;
                Rec."Sales Type"::Campaign:
                    begin
                        Campaign.Get(Rec."Sales Code");
                        Rec."Starting Date" := Campaign."Starting Date";
                        Rec."Ending Date" := Campaign."Ending Date";
                    end;
            end;
        Rec.Modify();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnDeleteFromBinContentOnBeforeFieldError', '', false, false)]
    local procedure CU7301_OnDeleteFromBinContentOnBeforeFieldError_WhseJnlRegisterLine(BinContent: Record "Bin Content"; WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    var
        Text003: Label 'Article %1, content %2 of %3 insufficient.', Comment = 'FRA="Article %1, contenu %2 de %3 insuffisant."';
    begin
        ERROR(Text003, WarehouseEntry."Item No.", WarehouseEntry."Bin Code", BinContent.Quantity);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", 'OnAfterCreateWhseJnlLine', '', false, false)]
    local procedure CU7302_OnAfterCreateWhseJnlLine_WMSManagement(var WhseJournalLine: Record "Warehouse Journal Line"; ItemJournalLine: Record "Item Journal Line"; ToTransfer: Boolean)
    begin
        // TODO: Check
        WhseJournalLine."BC6_Whse. Document Type 2" := ItemJournalLine."BC6_Whse. Document Type";
        WhseJournalLine."BC6_Whse. Document No. 2" := ItemJournalLine."BC6_Whse. Document No.";
        WhseJournalLine."BC6_Whse. Document Line No. 2" := ItemJournalLine."BC6_Whse. Document Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Put-away", 'OnBeforeFindReservationFromPurchaseLine', '', false, false)]
    local procedure OnBeforeFindReservationFromPurchaseLine(var PurchLine: Record "Purchase Line"; var WhseItemTrackingSetup: Record "Item Tracking Setup"; var ItemTrackingMgt: Codeunit "Item Tracking Management"; var ReservationFound: Boolean; var IsHandled: Boolean)
    var
        TmpSalesLine: Record "Sales Line" temporary;
        SalesLine: Record "Sales Line";
        SalesOrder: Record "Sales Header";
        QtyBaseToAssign: Decimal;
    begin
        ReservationFound := FALSE;
        TmpSalesLine.RESET;
        TmpSalesLine.DELETEALL;
        IF PurchLine."Document Type" = PurchLine."Document Type"::Order THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            SalesLine.SETRANGE("BC6_Purch. Document Type", PurchLine."Document Type");
            SalesLine.SETRANGE("BC6_Purch. Order No.", PurchLine."Document No.");
            SalesLine.SETRANGE("BC6_Purch. Line No.", PurchLine."Line No.");
            IF SalesLine.FIND('-') THEN
                REPEAT
                    SalesLine.CALCFIELDS("BC6_Pick Qty.");
                    QtyBaseToAssign := SalesLine."Outstanding Qty. (Base)" - SalesLine."BC6_Pick Qty.";
                    IF QtyBaseToAssign > 0 THEN BEGIN
                        TmpSalesLine.INIT;
                        TmpSalesLine := SalesLine;
                        TmpSalesLine."Outstanding Qty. (Base)" := QtyBaseToAssign;

                        //>> 19.03.2012 TL05 Warehouse Comment
                        CLEAR(SalesOrder);
                        IF SalesOrder.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                            TmpSalesLine."Description 2" := SalesOrder."BC6_Warehouse Comments";

                        TmpSalesLine.INSERT;
                    END;
                UNTIL SalesLine.NEXT = 0;
        END;
        IF TmpSalesLine.FIND('-') THEN
            ReservationFound := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Put-away", 'OnBeforeNewWhseActivLineInsertFromPurchase', '', false, false)]
    local procedure OnBeforeNewWhseActivLineInsertFromPurchase(var WarehouseActivityLine: Record "Warehouse Activity Line"; PurchaseLine: Record "Purchase Line")
    var
        FctMgt: codeunit "BC6_FctMangt";
    begin
        FctMgt.SetBinCode(WarehouseActivityLine."Bin Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnAfterGetSourceDocHeader', '', false, false)]
    local procedure OnAfterGetSourceDocHeader(var WarehouseRequest: Record "Warehouse Request"; var PostingDate: Date; var VendorDocNo: Code[35])
    var
        SalesHeader: Record "Sales Header";
    begin

        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order" then begin
            SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");
            BinCode := SalesHeader."BC6_Bin Code";
            YourRef := SalesHeader."Your Reference";
            DestName := SalesHeader."Sell-to Customer Name";
            DestName2 := SalesHeader."Sell-to Customer Name 2";
            WhseComments := SalesHeader."BC6_Warehouse Comments";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnAfterUpdateWhseActivHeader', '', false, false)]
    local procedure CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    begin
        if WarehouseActivityHeader."Source Document" <> WarehouseActivityHeader."Source Document"::" " then begin
            WarehouseActivityHeader."BC6_Your Reference" := YourRef;
            WarehouseActivityHeader."BC6_Destination Name" := DestName;
            WarehouseActivityHeader."BC6_Destination Name 2" := DestName2;
            WarehouseActivityHeader.BC6_Comments := WhseComments;
            WarehouseActivityHeader."BC6_Bin Code" := BinCode;
        end
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnBeforeCreatePickOrMoveLineFromSalesLoop', '', false, false)] // TODO:
    // local procedure OnBeforeCreatePickOrMoveLineFromSalesLoop(var WarehouseActivityHeader: Record "Warehouse Activity Header"; SalesHeader: Record "Sales Header"; var IsHandled: Boolean; SalesLine: Record "Sales Line")
    // var
    //     NewWhseActivLine: Record "Warehouse Activity Line";
    //     RemQtyToPickBase: Decimal;
    // begin
    //     if not NewWhseActivLine.ActivityExists(DATABASE::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", SalesLine."Line No.", 0, 0) then begin
    //                     NewWhseActivLine.Init();
    //                     NewWhseActivLine."Activity Type" := WarehouseActivityHeader.Type;
    //                     NewWhseActivLine."No." := WarehouseActivityHeader."No.";
    //                     if Location."Bin Mandatory" then
    //                         NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
    //                     NewWhseActivLine.SetSource(DATABASE::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", SalesLine."Line No.", 0);
    //                     NewWhseActivLine."Location Code" := SalesLine."Location Code";
    //                     NewWhseActivLine."Bin Code" := SalesLine."Bin Code";
    //                     NewWhseActivLine."Item No." := SalesLine."No.";
    //                     NewWhseActivLine."Variant Code" := SalesLine."Variant Code";
    //                     NewWhseActivLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
    //                     NewWhseActivLine."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
    //                     NewWhseActivLine."Qty. Rounding Precision" := SalesLine."Qty. Rounding Precision";
    //                     NewWhseActivLine."Qty. Rounding Precision (Base)" := SalesLine."Qty. Rounding Precision (Base)";
    //                     NewWhseActivLine.Description := SalesLine.Description;
    //                     NewWhseActivLine."Description 2" := SalesLine."Description 2";
    //                     NewWhseActivLine."Due Date" := SalesLine."Planned Shipment Date";
    //                     NewWhseActivLine."Shipping Advice" := SalesHeader."Shipping Advice";
    //                     NewWhseActivLine."Shipping Agent Code" := SalesLine."Shipping Agent Code";
    //                     NewWhseActivLine."Shipping Agent Service Code" := SalesLine."Shipping Agent Service Code";
    //                     NewWhseActivLine."Shipment Method Code" := SalesHeader."Shipment Method Code";
    //                     NewWhseActivLine."Destination Type" := NewWhseActivLine."Destination Type"::Customer;
    //                     NewWhseActivLine."Destination No." := SalesHeader."Sell-to Customer No.";

    //                     if  SalesLine."Document Type" = SalesLine."Document Type"::Order then begin
    //                         NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Sales Order";
    //                         RemQtyToPickBase :=  SalesLine."Qty. to Ship (Base)";
    //                     end else begin
    //                         NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Sales Return Order";
    //                         RemQtyToPickBase := -SalesLine."Return Qty. to Receive (Base)";
    //                     end;
    //                     SalesLine.CalcFields(SalesLine."Reserved Quantity");
    //                     CreatePickOrMoveLine(
    //                       NewWhseActivLine, RemQtyToPickBase, SalesLine."Outstanding Qty. (Base)", SalesLine."Reserved Quantity" <> 0);

    //                     if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Complete then begin
    //                         if RemQtyToPickBase < 0 then begin
    //                             if AutoCreation then begin
    //                                 if WarehouseActivityHeader.Delete(true) then
    //                                     LineCreated := false;
    //                                 exit;
    //                             end;
    //                             Error(Text001, SalesHeader."Shipping Advice", SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
    //                         end;
    //                         if (RemQtyToPickBase = 0) and not CompleteShipment then begin
    //                             if ShowError then
    //                                 Error(Text001, SalesHeader."Shipping Advice", SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
    //                             if WarehouseActivityHeader.Delete(true) then;
    //                             LineCreated := false;
    //                             exit;
    //                         end;
    //                     end;
    //                 end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Act.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure CU7323_OnBeforeConfirmPost(var WhseActivLine: Record "Warehouse Activity Line"; var HideDialog: Boolean; var Selection: Integer; var DefaultOption: Integer; var IsHandled: Boolean; var PrintDoc: Boolean)
    var
        WhseActivityPost: Codeunit "Whse.-Activity-Post";
        FctMangt: Codeunit "BC6_FctMangt";
        Text001: Label '&Ship,Ship &and Invoice';
        Text002: Label 'Do you want to post the %1 and %2?';
    begin
        DefaultOption := 1;
        HideDialog := false;
        WITH WhseActivLine DO BEGIN
            IF "Activity Type" = "Activity Type"::"Invt. Put-away" THEN BEGIN
                IF ("Source Document" = "Source Document"::"Prod. Output") OR
                   ("Source Document" = "Source Document"::"Inbound Transfer") OR
                   ("Source Document" = "Source Document"::"Prod. Consumption")
                THEN BEGIN
                    IF NOT CONFIRM(Text002, FALSE, "Activity Type", "Source Document") THEN
                        EXIT;
                END ELSE BEGIN
                    Selection := STRMENU(Text001, 1);
                    IF Selection = 0 THEN
                        EXIT;
                    HideDialog := ("Source Document" = "Source Document"::"Purchase Order");
                END;
            END ELSE
                IF ("Source Document" = "Source Document"::"Prod. Consumption") OR
                   ("Source Document" = "Source Document"::"Outbound Transfer")
                THEN BEGIN
                    IF NOT CONFIRM(Text002, FALSE, "Activity Type", "Source Document") THEN
                        EXIT;
                END ELSE BEGIN
                    Selection := STRMENU(Text002, 1);
                    IF Selection = 0 THEN
                        EXIT;
                    HideDialog := ("Source Document" = "Source Document"::"Sales Order");
                END;
            IF HideDialog THEN
                FctMangt.SetPostingDate(WORKDATE());

            WhseActivityPost.SetInvoiceSourceDoc(Selection = 2);
            WhseActivityPost.PrintDocument(PrintDoc);
            WhseActivityPost.RUN(WhseActivLine);
            CLEAR(WhseActivityPost);
        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnAfterCreateWhseJnlLine', '', false, false)]
    local procedure CU7324_OnAfterCreateWhseJnlLine(var WarehouseJournalLine: Record "Warehouse Journal Line"; WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
        WarehouseJournalLine."BC6_Source Type 2" := WarehouseActivityLine."Source Type";
        WarehouseJournalLine."BC6_Source Subtype 2" := WarehouseActivityLine."Source Subtype";
        WarehouseJournalLine."BC6_Source No. 2" := WarehouseActivityLine."Source No.";
        WarehouseJournalLine."BC6_Source Line No. 2" := WarehouseActivityLine."Source Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment Management", 'OnGenerInvPostingBufferOnBeforeUpdtBuffer', '', false, false)]
    local procedure OnGenerInvPostingBufferOnBeforeUpdtBuffer(var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger")
    var
        FctMangt: Codeunit BC6_FctMangt;
    begin
        IF InvPostingBuffer[1]."Account Type" IN [InvPostingBuffer[1]."Account Type"::Customer] THEN
            IF FctMangt.VerifTierPayeur(InvPostingBuffer[1]."Account Type", InvPostingBuffer[1]."Account No.",
                               InvPostingBuffer[1]."Applies-to ID") THEN
                FctMangt.CreateEntryTierPayeurCustomer(InvPostingBuffer[1], StepLedger.Description);

        IF InvPostingBuffer[1]."Account Type" IN [InvPostingBuffer[1]."Account Type"::Vendor] THEN
            IF FctMangt.VerifTierPayeur(InvPostingBuffer[1]."Account Type", InvPostingBuffer[1]."Account No.",
                               InvPostingBuffer[1]."Applies-to ID") THEN
                FctMangt.CreateEntryTierPayeurVendor(InvPostingBuffer[1], StepLedger.Description);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment Management", 'OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck', '', false, false)]
    local procedure CU10860_OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; var PaymentHeader: Record "Payment Header"; var PaymentClass: Record "Payment Class")
    begin
        // GenJnlLine."BC6_Pay-to No." := InvPostingBuffer[1]."Pay-to No.";  TODO: 
        IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) AND
            (GenJnlLine."BC6_Pay-to No." = '') THEN
            GenJnlLine."BC6_Pay-to No." := GenJnlLine."Account No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnAfterCheckPurchaseReleaseRestrictions', '', false, false)]
    local procedure CU415_OnCodeOnAfterCheckPurchaseReleaseRestrictions(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        Fctmangt: Codeunit "BC6_FctMangt";
    begin
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            Fctmangt.SetHideValidationDialog(Fctmangt.GetHideValidationDialog());
            IF PurchaseHeader.ControleMinimMNTandQTE THEN
                EXIT;
        end;
        Fctmangt.CheckReturnOrderMandatoryFields(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure CU415OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        COMMIT();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', false, false)]
    local procedure CU415_OnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        RecLPurchLine2: Record "Purchase Line";
        RecLSalesLine: Record "Sales Line";
        RelPruchDoc: Codeunit "Release Purchase Document";
    begin
        RecLPurchLine2.RESET;
        RecLPurchLine2.SETRANGE(RecLPurchLine2."Document Type", PurchaseHeader."Document Type");
        RecLPurchLine2.SETRANGE(RecLPurchLine2."Document No.", PurchaseHeader."No.");
        IF RecLPurchLine2.FIND('-') THEN BEGIN
            REPEAT
                IF (RecLPurchLine2."BC6_Sales No." <> '') AND (RecLPurchLine2."BC6_Sales Line No." <> 0) THEN BEGIN
                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document Type", RecLPurchLine2."BC6_Sales Document Type");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document No.", RecLPurchLine2."BC6_Sales No.");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Line No.", RecLPurchLine2."BC6_Sales Line No.");
                    IF RecLSalesLine.FIND('-') THEN BEGIN
                        RecLSalesLine.SuspendStatusCheck(TRUE);
                        RecLSalesLine.VALIDATE("BC6_Purchase cost", RecLPurchLine2."BC6_Discount Direct Unit Cost");
                        RecLSalesLine.MODIFY;
                    END;
                END;
            UNTIL RecLPurchLine2.NEXT = 0;
        END;

        LinesWereModified := LinesWereModified or RelPruchDoc.CalcAndUpdateVATOnLines(PurchaseHeader, PurchaseLine);
        Commit();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforePerformManualRelease', '', false, false)]
    local procedure CU415_OnBeforePerformManualRelease(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        Commit();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterCheckCustomerCreated', '', false, false)]
    local procedure CU414_OnCodeOnAfterCheckCustomerCreated(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        RecGSalesLine: Record "Sales Line";
        FctMangt: Codeunit BC6_FctMangt;
    begin
        SalesSetup.GET;
        IF SalesSetup."BC6_Promised Delivery Date" THEN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                SalesHeader.TESTFIELD(SalesHeader."Promised Delivery Date");
        IF SalesSetup."BC6_Requested Delivery Date" THEN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                SalesHeader.TESTFIELD(SalesHeader."Requested Delivery Date");
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
            RecGSalesLine.RESET;
            RecGSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            RecGSalesLine.SETRANGE(RecGSalesLine."Document Type", SalesHeader."Document Type");
            RecGSalesLine.SETRANGE(RecGSalesLine.Type, RecGSalesLine.Type::Item);
            RecGSalesLine.SETRANGE(RecGSalesLine."Document No.", SalesHeader."No.");
            IF RecGSalesLine.FINDFIRST THEN
                REPEAT
                    RecGSalesLine.TESTFIELD("Purchasing Code");
                UNTIL RecGSalesLine.NEXT = 0;
        END;
        FctMangt.CheckReturnOrderMandatoryFields(SalesHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeCheckSalesLines', '', false, false)]
    local procedure CU414_OnBeforeCheckSalesLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
        Text001: Label 'There is nothing to release for the document of type %1 with the number %2.';
    begin
        with SalesHeader do begin
            SalesLine.SetRange("Document Type", "Document Type");
            SalesLine.SetRange("Document No.", "No.");
            SalesLine.SetFilter(Type, '>0');
            SalesLine.SetFilter(Quantity, '<>0');
            if not SalesLine.Find('-') then
                IF NOT "BC6_Sales Counter" THEN
                    Error(Text001, "Document Type", "No.");
            InvtSetup.Get();
            if InvtSetup."Location Mandatory" then begin
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindSet() then
                    repeat
                        if SalesLine.IsInventoriableItem then
                            SalesLine.TestField("Location Code");
                    until SalesLine.Next() = 0;
                SalesLine.SetFilter(Type, '>0');
            end;
        end;
    end;


    var
        BinCode: Code[20]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        YourRef: Text[35]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        DestName: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        DestName2: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        WhseComments: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
}