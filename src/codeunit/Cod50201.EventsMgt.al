codeunit 50201 "BC6_EventsMgt"
{
    //TAB111
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    local procedure T111_OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine_SalesShipmentLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean; TempSalesLine: Record "Sales Line" temporary; SalesInvHeader: Record "Sales Header")
    var
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
        CstG1000000000: label '%1 of %2 - %3', Comment = 'FRA="%1 du %2 - %3"';
        CstG1000000001: label 'Your Reference : ', Comment = 'FRA="Votre Référence : "';
        CstG1000000002: label '%1 %2', Comment = 'FRA="%1 %2"';
    begin
        RecLSalesShipmentHeader.GET(SalesShptLine."Document No.");
        SalesLine.Description := COPYSTR(
                                   STRSUBSTNO(CstG1000000000,
                                       SalesShptLine."Document No.",
                                         RecLSalesShipmentHeader."Posting Date", SalesShptLine."Order No."
                                        ), 1, 100);
        SalesLine.Insert();
        NextLineNo := NextLineNo + 10000;

        // Line number 2 //
        SalesLine.Init();
        SalesLine."Line No." := NextLineNo;
        SalesLine."Document Type" := TempSalesLine."Document Type";
        SalesLine."Document No." := TempSalesLine."Document No.";

        SalesLine.Description := COPYSTR(
                                   STRSUBSTNO(CstG1000000002,
                                     CstG1000000001,
                                     RecLSalesShipmentHeader."Your Reference"), 1, 100);
        SalesLine.Insert();
        NextLineNo := NextLineNo + 10000;

        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure T111_OnAfterInitFromSalesLine_SalesShipmentLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine."BC6_Ordered Quantity" := SalesLine.Quantity;
        SalesShptLine."BC6_Outstanding Quantity" := SalesLine."Outstanding Quantity" - SalesLine."Qty. to Ship";
        SalesShptLine."BC6_Qty Shipped" := SalesLine."Quantity Shipped" + SalesLine."Qty. to Ship";
    end;

    //TAB290
    //TODO:check code
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchInvLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchInvLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchInvLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchInvLine."BC6_DEEE TTC Amount";
        if PurchInvLine."Allow Invoice Disc." then
            VATAmountLine."Inv. Disc. Base Amount" := VATAmountLine."Inv. Disc. Base Amount" + PurchInvLine."BC6_DEEE HT Amount";
    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchCrMemoLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchCrMemoLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchCrMemoLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchCrMemoLine."BC6_DEEE TTC Amount";

        if PurchCrMemoLine."Allow Invoice Disc." then
            VATAmountLine."Inv. Disc. Base Amount" := PurchCrMemoLine."Line Amount";
    end;

    //TAB5765
    //TODO: check si No. appartient au record commentLine
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Request", 'OnAfterDeleteRequest', '', false, false)]
    procedure T5765_OnAfterDeleteRequest_WarehouseReq(SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20])
    var
        RecLAffairStep: Record "BC6_Affair Steps";
        CommentLine: Record "Comment Line";

    begin
        RecLAffairStep.SETRANGE("Affair No.", CommentLine."No.");
        RecLAffairStep.DELETEALL();
    end;

    //TAB36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]

    procedure T36_OnAfterOnInsert_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.ID := USERID;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', false, false)]
    procedure OnDeleteOnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        CompanyInfo: Record "Company Information";
        TextG003: label 'Warning: you have already placed this order purchase.';
    begin
        CompanyInfo.FINDFIRST();
        //TODO: i must have IsDeleteFromReturnOrder ( codeunit 50052 & we need to find G_ReturnOrderMgt )
        // IF CompanyInfo."BC6_Branch Company" THEN
        //     IF SalesHeader."BC6_Purchase No. Order Lien" <> '' THEN
        //         ERROR(TextG003);
        // IF NOT IsDeleteFromReturnOrder THEN BEGIN
        //     G_ReturnOrderMgt.DeleteRelatedDocument(SalesHeader);

        //     G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(SalesHeader);
        // END;
    end;
    //TAB27
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterOnInsert', '', false, false)]
    procedure t27_OnAfterOnInsert_Item(var Item: Record Item; var xItem: Record Item)
    var
        NaviSetup: Record "BC6_Navi+ Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //TODO
        // "Creation Date" := WORKDATE;
        // Item.User := USERID;
        NaviSetup.GET();
        NaviSetup.TESTFIELD(NaviSetup."Base Unit of Measure");
        NaviSetup.TESTFIELD(NaviSetup."Gen. Prod. Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."VAT Prod. Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."Inventory Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."Sales Unit of Measure");

        ItemUnitOfMeasure."Item No." := Item."No.";
        ItemUnitOfMeasure.Code := NaviSetup."Base Unit of Measure";
        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
        ItemUnitOfMeasure.INSERT();
        Item."Base Unit of Measure" := NaviSetup."Base Unit of Measure";
        Item."Purch. Unit of Measure" := NaviSetup."Base Unit of Measure";

        Item."Costing Method" := NaviSetup."Costing Method";
        Item.VALIDATE("Gen. Prod. Posting Group", NaviSetup."Gen. Prod. Posting Group");
        Item.VALIDATE("VAT Prod. Posting Group", NaviSetup."VAT Prod. Posting Group");
        Item.VALIDATE("Inventory Posting Group", NaviSetup."Inventory Posting Group");
        Item.VALIDATE("Sales Unit of Measure", NaviSetup."Sales Unit of Measure");
        Item.VALIDATE("Replenishment System", NaviSetup."Replenishment System");
        Item.VALIDATE("Lead Time Calculation", NaviSetup."Lead Time Calculation Item");
        Item.VALIDATE("Reordering Policy", NaviSetup."Reordering Policy");
        Item.VALIDATE("Include Inventory", NaviSetup."Include Inventory");
        Item.VALIDATE(Reserve, NaviSetup."Reserve Item");
        Item.VALIDATE("Order Tracking Policy", NaviSetup."Order Tracking Policy");
        Item.VALIDATE("Unit Price");
        Item."BC6_Number of Units DEEE" := 1;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeModifyEvent', '', false, false)]
    procedure OnBeforeModifyEvent(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    begin
        if not (UPPERCASE(USERID) in ['CNE\BCSYS']) then
            Rec.TESTFIELD(Rec."Vendor No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Vendor No.', false, false)]
    procedure t27_OnAfterValidateEvent(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        Vend: Record Vendor;
    begin
        Vend.get(Vend."No.");
        if (xRec."Vendor No." <> Rec."Vendor No.") and
           (Rec."Vendor No." <> '')
                then
            if Vend.Get(Rec."Vendor No.") then begin
                Rec."Lead Time Calculation" := Vend."Lead Time Calculation";
                Vend.TESTFIELD(Blocked, 0);
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Blocked', false, false)]
    procedure t27_OnAfterValidateEvent_Item(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        RecLAccessControl: Record "Access Control";
        CstG001: Label 'You are not authorized to perform this operation.', comment = 'FRA="Vous n''avez pas l''autorisation d''effectuer cette opération."';
    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'MODIFART');
        IF NOT RecLAccessControl.FINDFIRST() THEN
            ERROR(CstG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Price/Profit Calculation', false, false)]
    procedure t27_OnAfterValidateEvent_Item1(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        InvSetup: Record "Inventory Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //TODO case Rec."Price/Profit Calculation" of
        //     Rec."Price/Profit Calculation"::"Price=Cost+Profit":
        //         if Rec."Unit Price" <> 0 then
        //             if Rec."Unit Cost" = 0 then
        //                 Rec."Profit %" := 0
        //             else
        //                 Rec."Profit %" :=
        //                   Round(
        //                     100 * (1 - Rec."Unit Cost" /
        //                            (Rec."Unit Price" / (1 + CalcVAT))), 0.00001)
        //         else
        //             Rec."Profit %" := 0;
        //     Rec."Price/Profit Calculation"::"Profit=Price-Cost":
        //         if Rec."Profit %" < 100 then begin
        //             GetGLSetup();
        //             Rec."Unit Price" :=
        //                Round(
        //                  (Rec."Unit Cost" / (1 - Rec."Profit %" / 100)) *
        //                  (1 + CalcVAT),
        //                  GLSetup."Unit-Amount Rounding Precision");
        //         end;
        // end;
        // // CNE4.03
        // IF NOT "Price Includes VAT" THEN
        //     //>>TI287704
        //     IF "VAT Prod. Posting Group" <> '' THEN
        //                                                           BEGIN
        //         "Unit Price Includes VAT" := 0;
        //         GetGLSetup;
        //         InvSetup.GET;
        //         IF InvSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN BEGIN
        //             VATPostingSetup2.GET(InvSetup."VAT Bus. Posting Gr. (Price)", "VAT Prod. Posting Group");
        //             "Unit Price Includes VAT" := ROUND("Unit Price" * (1 + VATPostingSetup2."VAT %" / 100), GLSetup."Unit-Amount Rounding Precision")
        //         END;
        //     END;
    end;

    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeModify', '', false, false)]

    procedure T290_OnInsertLineOnBeforeModify_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + FromVATAmountLine."BC6_DEEE TTC Amount";
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeInsert', '', false, false)]

    procedure T290_OnInsertLineOnBeforeInsert_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; var FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := FromVATAmountLine."BC6_DEEE TTC Amount";
    end;

    //Tab36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    procedure T36_OnAfterInsertEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    procedure T36_OnAfterDeleteEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record "Company Information";
        TextG003: label 'Warning:This purchase order is linked to a sales order.';
    //TODO:Codeunit // G_ReturnOrderMgt: Codeunit 50052;
    begin
        CompanyInfo.FINDFIRST();
        if CompanyInfo."BC6_Branch Company" then
            if Rec."BC6_Purchase No. Order Lien" <> '' then
                ERROR(TextG003);
        //TODO: codeunint
        // IF NOT IsDeleteFromReturnOrder THEN BEGIN
        //          G_ReturnOrderMgt.DeleteRelatedDocument(Rec);

        //          G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(Rec);
        //        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]

    procedure T36_OnAfterCheckSellToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
    begin
        if CurrentFieldNo <> 0 then
            if RecGParamNavi.FIND() then begin
                if RecGParamNavi."Used Post-it" <> '' then begin
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", SalesHeader."Sell-to Customer No.");
                    if RecGCommentLine.FIND('-') then begin
                        FrmGLignesCommentaires.EDITABLE(false);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        if FrmGLignesCommentaires.RUNMODAL() = ACTION::OK then;
                    end;
                end;
                RecGCommentLine.SETRANGE(Code, '');
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]

    procedure T36_OnAfterCopySellToCustomerAddressFieldsFromCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean)
    begin
        SellToCustomer."BC6_Combine Shipments by Order" := SellToCustomer."BC6_Combine Shipments by Order";
        SellToCustomer."BC6_Pay-to Customer No." := SellToCustomer."BC6_Pay-to Customer No.";
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order:
                SellToCustomer."BC6_Copy Sell-to Address" := SellToCustomer."BC6_Copy Sell-to Address";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]

    procedure T36_OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.UpdateIncoterm();  //procedure specifique
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            SalesHeader."Posting Description" := COPYSTR(FORMAT(SalesHeader."Sell-to Customer Name") + ' : ' + FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No."
                                       , 1, MAXSTRLEN(SalesHeader."Posting Description"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestStatusOpen', '', false, false)]

    procedure T36_OnAfterTestStatusOpen_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        SalesHeader.GetCust(Cust."Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", false, false);
        Cust.TESTFIELD("Customer Posting Group");
        //TODO  // SalesHeader.CheckCrLimit;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetSalespersonCode', '', false, false)]

    procedure T36_OnBeforeSetSalespersonCode_SalesHeader(var SalesHeader: Record "Sales Header"; SalesPersonCodeToCheck: Code[20]; var SalesPersonCodeToAssign: Code[20]; var IsHandled: Boolean)
    var
        Cust: Record Customer;
    begin
        Cust.Get();
        SalesHeader."BC6_Salesperson Filter" := Cust."BC6_Salesperson Filter";
        SalesHeader."BC6_Customer Sales Profit Group" := Cust."BC6_Custom. Sales Profit Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeShouldSearchForCustomerByName', '', false, false)]

    procedure T36_OnBeforeShouldSearchForCustomerByName_SalesHeader(CustomerNo: Code[20]; var Result: Boolean; var IsHandled: Boolean; var CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestNoSeries', '', false, false)]

    procedure OnAfterTestNoSeries(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":

                if SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV then
                    SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."BC6_SAV Return Order Nos.")
                else
                    SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', false, false)]

    procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":
                //>>BC6
                // OLD STD NoSeriesCode := SalesSetup."Return Order Nos.";
                //>>BC6
                // OLD STD NoSeriesCode := SalesSetup."Return Order Nos.";

                if SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV then
                    NoSeriesCode := SalesReceivablesSetup."BC6_SAV Return Order Nos."
                else
                    NoSeriesCode := SalesReceivablesSetup."Return Order Nos.";
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSalesLineByChangedFieldName', '', false, false)]

    procedure OnUpdateSalesLineByChangedFieldName(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldNo of
            SalesLine.FieldNo("Bin Code"):
                if SalesLine."No." <> '' then
                    if (SalesLine."Location Code" = SalesHeader."Location Code") then
                        SalesLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCont', '', false, false)]

    procedure OnAfterUpdateSellToCont(var SalesHeader: Record "Sales Header"; Customer: Record Customer; Contact: Record Contact; HideValidationDialog: Boolean)
    begin
        SalesHeader.UpdateSellToFax(SalesHeader."Sell-to Contact No.");
        SalesHeader.UpdateSellToMail(SalesHeader."Sell-to Contact No.");
    end;

    //TODO:not sure
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCust', '', false, false)]
    procedure OnAfterUpdateSellToCust(var SalesHeader: Record "Sales Header"; Contact: Record Contact)
    var
        ContactNo: Code[20];
    begin
        Contact.GET(ContactNo);
        SalesHeader.UpdateSellToFax(ContactNo);
        SalesHeader.UpdateSellToMail(ContactNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateOutboundWhseHandlingTime', '', false, false)]
    procedure OnBeforeUpdateOutboundWhseHandlingTime(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
        Location: Record location;
    begin
        IsHandled := true;
        if SalesHeader."Location Code" <> '' then begin
            if Location.Get(SalesHeader."Location Code") then
                SalesHeader."Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            SalesHeader.VALIDATE(SalesHeader."Shipment Method Code");
            if SalesHeader."BC6_Bin Code" = '' then
                SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        end else begin
            if InvtSetup.Get() then
                SalesHeader."Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            SalesHeader."BC6_Bin Code" := '';
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitFromSalesHeader', '', false, false)]
    procedure OnBeforeInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    begin
        SalesHeader.VALIDATE("Order Date", WORKDATE());
        SalesHeader.VALIDATE("Posting Date", WORKDATE());
        if SalesHeader."Shipment Date" < WORKDATE() then
            SalesHeader.VALIDATE("Shipment Date", WORKDATE())
        else
            SalesHeader."Shipment Date" := SourceSalesHeader."Shipment Date";
        SalesHeader."External Document No." := SourceSalesHeader."External Document No.";
        SalesHeader."BC6_Document description" := SourceSalesHeader."BC6_Document description";
    end;

    procedure OnAfterInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    var
        Location: Record Location;
    begin
        if SourceSalesHeader."Location Code" <> '' then begin
            if Location.GET(SalesHeader."Location Code") then
                if SourceSalesHeader."BC6_Bin Code" = '' then
                    SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        end else
            SalesHeader."BC6_Bin Code" := '';
    end;

    // COD
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Instruction Mgt.", 'OnBeforeIsUnpostedEnabledForRecord', '', false, false)]
    procedure OnBeforeIsUnpostedEnabledForRecord(RecVariant: Variant; var Enabled: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //TAB38
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    procedure T38_OnAfterInsertEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    procedure T38_OnAfterDeleteEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record "Company Information";
        TextG003: label 'Warning:This purchase order is linked to a sales order.';
    //TODO:Codeunit // G_ReturnOrderMgt: Codeunit 50052;
    begin
        CompanyInfo.FINDFIRST();
        if CompanyInfo."BC6_Branch Company" then
            if Rec."BC6_Sales No. Order Lien" <> '' then
                ERROR(TextG003);
        //    TODO:Codeunit
        // IF Rec."Document Type" = Rec."Document Type"::Order THEN
        //G_ReturnOrderMgt.DeleteRelatedPurchOrderNo(Rec)
        // ELSE
        // IF (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
        //     G_ReturnOrderMgt.DeleteRelatedPurchReturnOrderNo(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterRecreateLines', '', false, false)]
    procedure OnValidateBuyFromVendorNoOnAfterRecreateLines(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer)
    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
    //To check
    begin

        if CallingFieldNo <> 0 then
            if RecGParamNavi.FIND() then begin
                if RecGParamNavi."Used Post-it" <> '' then begin
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", PurchaseHeader."Buy-from Vendor No.");
                    if RecGCommentLine.FIND('-') then begin
                        FrmGLignesCommentaires.EDITABLE(false);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        if FrmGLignesCommentaires.RUNMODAL() = ACTION::OK then;
                    end;
                end;
                RecGCommentLine.SETRANGE(Code, '');
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEmptySellToCustomerAndLocation', '', false, false)]

    procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."BC6_Pay-to Vend. No." := Vendor."BC6_Pay-to Vend. No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]

    procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    begin
        //TODO  // UpdateIncoterm;
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] then
            PurchaseHeader."Posting Description" := COPYSTR(FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' : ' + FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No."
                                       , 1, MAXSTRLEN(PurchaseHeader."Posting Description"));
    end;

    //cod427
    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICOutBoxSalesHeaderTransferFields', '', false, false)]

    procedure OnAfterICOutBoxSalesHeaderTransferFields(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesHeader: Record "Sales Header")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesHeader."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader', '', false, false)]

    procedure OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesInvHdr: Record "Sales Invoice Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesInvHdr."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader', '', false, false)]

    procedure OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesCrMemoHdr: Record "Sales Cr.Memo Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesCrMemoHdr."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader', '', false, false)]

    procedure OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader(var ICOutboxPurchHeader: Record "IC Outbox Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        ICOutBoxPurchHeader."BC6_Ship-to Contact" := PurchHeader."Ship-to Contact";
    end;

    //TODO: to check if the event is true
    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesDocumentOnBeforeSalesHeaderInsert', '', false, false)]

    procedure OnCreateSalesDocumentOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header"; ICInboxSalesHeader: Record "IC Inbox Sales Header")
    begin
        SalesHeader."Your Reference" := ICInboxSalesHeader."External Document No.";
        SalesHeader."Ship-to Contact" := ICInboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesLinesOnAfterValidateNo', '', false, false)]
    procedure OnCreateSalesLinesOnAfterValidateNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; ICInboxSalesLine: Record "IC Inbox Sales Line")
    begin
        SalesLine."BC6_Purchase No. Order Lien" := ICInboxSalesLine."Document No.";
        SalesLine."BC6_Purchase No. Line Lien" := ICInboxSalesLine."Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreatePurchDocumentOnBeforePurchHeaderInsert', '', false, false)]
    procedure OnCreatePurchDocumentOnBeforePurchHeaderInsert(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    begin
        PurchaseHeader."Ship-to Contact" := ICInboxPurchaseHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxPurchHeaderInsert', '', false, false)]
    procedure OnBeforeICInboxPurchHeaderInsert(var ICInboxPurchaseHeader: Record "IC Inbox Purchase Header"; ICOutboxSalesHeader: Record "IC Outbox Sales Header")
    begin
        ICInboxPurchaseHeader."BC6_Ship-to Contact" := ICOutboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesHeaderInsert', '', false, false)]
    procedure OnBeforeICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."BC6_Ship-to Contact" := ICOutboxPurchaseHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICInboxSalesHeaderInsert', '', false, false)]

    procedure OnAfterICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."External Document No." := ICOutboxPurchaseHeader."Your Reference";
    end;
    //COD550
    [EventSubscriber(ObjectType::Codeunit, codeunit::"VAT Rate Change Conversion", 'OnBeforeUpdateItem', '', false, false)]

    procedure COD550_OnBeforeUpdateItem(var Item: Record Item; var VATRateChangeSetup: Record "VAT Rate Change Setup"; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
        VATRateChangeConv: Codeunit "VAT Rate Change Conversion";
        RecRef: RecordRef;
    begin
        IsHandled := true;
        if VATRateChangeSetup."Item Filter" <> '' then
            Item.SETFILTER("No.", VATRateChangeSetup."Item Filter");
        Item.SETRANGE(Blocked, false);
        if Item.FindSet() then
            repeat
                RecRef.GETTABLE(Item);
                fctMgt.UpdateRec(RecRef, VATRateChangeConv.ConvertVATProdPostGrp(VATRateChangeSetup."Update Items"), VATRateChangeConv.ConvertGenProdPostGrp(VATRateChangeSetup."Update Items"));
            until Item.NEXT() = 0;
    end;

    //COD841
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Cash Flow Management", 'OnBeforeGetTaxAmountFromSalesOrder', '', false, false)]

    procedure COD841_OnBeforeGetTaxAmountFromSalesOrder(SalesHeader: Record "Sales Header"; var VATAmount: Decimal; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IsHandled := true;
        fctMgt.GetTaxAmountFromSalesOrder_CNE(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Cash Flow Management", 'OnBeforeGetTaxAmountFromPurchaseOrder', '', false, false)]

    procedure OnBeforeGetTaxAmountFromPurchaseOrder(PurchaseHeader: Record "Purchase Header"; var VATAmount: Decimal; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IsHandled := true;
    end;

    //COD1302
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterIsBillToAddressEqualToSellToAddress', '', false, false)]
    procedure OnAfterIsBillToAddressEqualToSellToAddress(SellToSalesHeader: Record "Sales Header"; BillToSalesHeader: Record "Sales Header"; var Result: Boolean)
    begin
        Result := Result and (BillToSalesHeader."Bill-to Name" = SellToSalesHeader."Sell-to Customer Name");
    end;
    //COD1330

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Instruction Mgt.", 'OnAfterIsEnabled', '', false, false)]

    procedure OnAfterIsEnabled(InstructionType: Code[50]; var Result: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        if InstructionType = fctMgt.ShowPostedConfirmationMessageCode() then
            Result := false;
    end;
    //COD5063

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]

    procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
        SalesHeader.MODIFY();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnRestoreSalesDocumentOnAfterSalesHeaderInsert', '', false, false)]
    procedure OnRestoreSalesDocumentOnAfterSalesHeaderInsert(var SalesHeader: Record "Sales Header"; SalesHeaderArchive: Record "Sales Header Archive");
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Warehouse Document-Print", 'OnBeforePrintInvtPickHeader', '', false, false)]

    procedure OnBeforePrintInvtPickHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean; var HideDialog: Boolean)
    var
    //TODO:report   //  WhsePick : Report 50047;
    begin
        IsHandled := true;
        WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
        //TODO:report
        //   WhsePick.SETTABLEVIEW(WarehouseActivityHeader);
        //   WhsePick.InitRequest(1,FALSE,TRUE);
        //   WhsePick.USEREQUESTPAGE(NOT HideDialog);
        //   WhsePick.RUNMODAL;
    end;
    //COD5813
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Purchase Receipt Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]

    procedure COD5813_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(PurchRcptLine: Record "Purch. Rcpt. Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        PurchLine: Record "Purchase Line";
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";

    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Purch. Rcpt. Header",
  0,
  PurchRcptLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Rcpt.",
  DATABASE::"Purchase Line",
 PurchLine."Document Type"::Order,
  PurchRcptLine."Order No.",
  PurchRcptLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);
    end;

    //COD5814
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Return Shipment Line", 'OnAfterCopyItemJnlLineFromReturnShpt', '', false, false)]
    procedure OnAfterCopyItemJnlLineFromReturnShpt(var ItemJournalLine: Record "Item Journal Line"; ReturnShipmentHeader: Record "Return Shipment Header"; ReturnShipmentLine: Record "Return Shipment Line"; var WhseUndoQty: Codeunit "Whse. Undo Quantity")

    var
        PurchLine: Record "Purchase Line";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        //TODO: à verifier srtt les declarations
        fctMgt: Codeunit "BC6_FctMangt";
        NextLineNo: Integer;
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJournalLine,
          DATABASE::"Return Shipment Header",
          0,
          PurchLine."Document No.",
          0,
          TempWhseJnlLine."Reference Document"::"Posted Rtrn. Shipment",
          DATABASE::"Purchase Line",
          PurchLine."Document Type"::"Return Order",
          ReturnShipmentLine."Return Order No.",
          ReturnShipmentLine."Return Order Line No.",
          TempWhseJnlLine, NextLineNo);
    end;
    //COD5815
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnCodeOnBeforeUndoLoop', '', false, false)]
    procedure OnCodeOnBeforeUndoLoop(var SalesShptLine: Record "Sales Shipment Line")
    var
        TempWhseJnlLine: Record "Warehouse Journal Line" TEMPORARY;

    begin
        IF NOT TempWhseJnlLine.ISEMPTY THEN
            TempWhseJnlLine.DELETEALL();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]
    procedure COD5815_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(SalesShptLine: Record "Sales Shipment Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Sales Shipment Header",
  0,
ItemJnlLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Shipment",
  DATABASE::"Sales Line",
  SalesLine."Document Type"::Order,
  ItemJnlLine."Order No.",
  ItemJnlLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);
    end;
    //COD5817
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestPostedInvtPutAwayLine', '', false, false)]

    procedure OnBeforeTestPostedInvtPutAwayLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean; UndoType: Integer; UndoID: Code[20])
    var
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        Text002: Label 'You cannot undo line %1 because warehouse put-away lines have already been created.';
        Text008: label 'You cannot undo line %1 because warehouse receipt lines have already been posted.';
    begin
        IsHandled := true;
        IF NOT ((SourceType = 39) AND (SourceSubtype = 1)) AND
           NOT ((SourceType = 37) AND (SourceSubtype = 5)) THEN
            //la partie du TestPostedInvtPutAwayLine
            with RegisteredWhseActivityLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, -1, true);
                SetRange("Activity Type", "Activity Type"::"Put-away");
                if not IsEmpty() then
                    Error(Text002, UndoLineNo);
            end;
        //la partie du TestPostedInvtPutAwayLine

        IF NOT ((SourceType = 39) AND (SourceSubtype = 5)) AND NOT ((SourceType = 37) AND (SourceSubtype = 1)) THEN
            //la partie du TestWhseWorksheetLine
            with WhseWorksheetLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, true);
                if not IsEmpty() then
                    Error(Text008, UndoLineNo);
            end;
        //la partie du TestWhseWorksheetLine
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestWhseWorksheetLine', '', false, false)]

    procedure OnBeforeTestWhseWorksheetLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean)
    begin
        //la partie du TestWhseWorksheetLine
        IsHandled := true;
    end;

    //COD6620
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert', '', false, false)]
    procedure OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert(var ToPurchaseHeader: Record "Purchase Header"; FromSalesHeader: Record "Sales Header")
    var
        IsSAVReturnOrder: Boolean;
    begin
        IF (FromSalesHeader."Document Type" = FromSalesHeader."Document Type"::"Return Order") THEN
            IsSAVReturnOrder := TRUE;
        ToPurchaseHeader."BC6_Return Order Type" := FromSalesHeader."BC6_Return Order Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeAssignDescriptionsFromSalesLine', '', false, false)]

    procedure OnBeforeAssignDescriptionsFromSalesLine(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    begin
        PurchaseLine."BC6_Return Order Type" := SalesLine."BC6_Return Order Type";
        //TODO: je dois avoir la valeur du IsSAVReturnOrder pour faire le test
        // IF IsSAVReturnOrder THEN BEGIN
        //   "Solution Code" := FromSalesLine."Solution Code";
        //   "Return Comment" := FromSalesLine."Return Comment";
        //   "Return Order-Shpt Sales Order" := FromSalesLine."Return Order-Shpt Sales Order";
        //   "Series No." := FromSalesLine."Series No.";
        // END;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCheckFromSalesHeader', '', false, false)]

    procedure OnBeforeCheckFromSalesHeader(SalesHeaderFrom: Record "Sales Header"; SalesHeaderTo: Record "Sales Header"; var IsHandled: Boolean)
    var
        BoolGCopyLinesExactly: Boolean;
        SalesDocType: enum "Sales Document Type";

    begin
        IsHandled := true;
        CASE SalesHeaderFrom."Document Type" OF
            SalesDocType::Quote,
  SalesDocType::"Blanket Order",
  SalesDocType::Order,
  SalesDocType::Invoice,
  SalesDocType::"Return Order",
  SalesDocType::"Credit Memo":
                IF NOT BoolGCopyLinesExactly THEN BEGIN
                    SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                    SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                END ELSE BEGIN
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                    SalesHeaderFrom."Your Reference" := SalesHeaderTo."Your Reference";
                    SalesHeaderFrom."BC6_Affair No." := SalesHeaderTo."BC6_Affair No.";
                    // IF NOT SalesHeaderFrom.MODIFY THEN;      //TODO:then what ?
                END;
            ELSE BEGIN
                SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
            END;
        end;
    end;
    //TAB113
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnBeforeCalcVATAmountLines', '', false, false)]

    local procedure TAB13_OnBeforeCalcVATAmountLines(SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin
        TempVATAmountLine."BC6_DEEE HT Amount" := TempVATAmountLine."BC6_DEEE HT Amount" + SalesInvLine."BC6_DEEE HT Amount";
        TempVATAmountLine."BC6_DEEE VAT Amount" := TempVATAmountLine."BC6_DEEE VAT Amount" + SalesInvLine."BC6_DEEE VAT Amount";
        TempVATAmountLine."BC6_DEEE TTC Amount" := TempVATAmountLine."BC6_DEEE TTC Amount" + SalesInvLine."BC6_DEEE TTC Amount";
        IF SalesInvLine."Allow Invoice Disc." THEN
            TempVATAmountLine."Inv. Disc. Base Amount" := TempVATAmountLine."Inv. Disc. Base Amount" + TempVATAmountLine."BC6_DEEE HT Amount";
    end;
    //TAB115 à vérifier l'event
    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnBeforeCalcVATAmountLines', '', false, false)]
    local procedure TAB115_OnBeforeCalcVATAmountLines(SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin

        if SalesCrMemoLine.Find('-') then
            repeat
                TempVATAmountLine.Init();
                TempVATAmountLine.CopyFromSalesCrMemoLine(SalesCrMemoLine);
                TempVATAmountLine."BC6_DEEE HT Amount" := TempVATAmountLine."BC6_DEEE HT Amount" + SalesCrMemoLine."BC6_DEEE HT Amount";
                TempVATAmountLine."BC6_DEEE VAT Amount" := TempVATAmountLine."BC6_DEEE VAT Amount" + SalesCrMemoLine."BC6_DEEE VAT Amount";
                TempVATAmountLine."BC6_DEEE TTC Amount" := TempVATAmountLine."BC6_DEEE TTC Amount" + SalesCrMemoLine."BC6_DEEE TTC Amount";

                TempVATAmountLine.InsertLine();
            until SalesCrMemoLine.Next() = 0;
    end;
    //TAB25
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]

    local procedure TAB25_OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
        VendorLedgerEntry."BC6_Payment Terms Code" := GenJournalLine."Payment Terms Code";
        VendorLedgerEntry."BC6_Pay-to Vend. No." := GenJournalLine."BC6_Pay-to No.";
    end;
    //TAB 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Expected Receipt Date', false, false)]
    procedure T39_OnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        CustomCalendarChange: Array[2] of Record "Customized Calendar Change";
        CalChange: Record "Customized Calendar Change";
        RecLSalesLine: Record "Sales Line";
        PurchHeader: Record "Purchase Header";
    BEGIN
        PurchHeader.get(PurchHeader."Document Type", PurchHeader."No.");
        CalChange.get(CalChange."Source Type", CalChange."Source Code", CalChange."Additional Source Code", CalChange."Base Calendar Code", CalChange."Recurring System", CalChange.Date, CalChange.Day, CalChange."Entry No.");
        if Rec."Expected Receipt Date" <> 0D then begin
            CustomCalendarChange[1].SetSource(CalChange."Source Type"::Location, Rec."Location Code", '', '');
        end else
            Rec.Validate(Rec."Planned Receipt Date", Rec."Expected Receipt Date");
        //>>MIGRATION NAV 2013
        //>>ACHAT-200706-18-A.001:GR
        IF Rec."Expected Receipt Date" <> 0D THEN BEGIN
            RecLSalesLine.RESET;
            //>>CorrectionSOBI
            RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            //<<CorrectionSOBI
            RecLSalesLine.SETRANGE("BC6_Purch. Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("BC6_Purch. Order No.", Rec."Document No.");
            RecLSalesLine.SETRANGE("BC6_Purch. Line No.", Rec."Line No.");
            IF RecLSalesLine.FIND('-') THEN BEGIN
                REPEAT
                    RecLSalesLine.VALIDATE("BC6_Purchase Receipt Date", Rec."Expected Receipt Date");
                    //>> CNE6.01
                    RecLSalesLine."BC6_Promised Purchase Receipt Date" := (PurchHeader."Expected Receipt Date" <> 0D);
                    RecLSalesLine.MODIFY;
                UNTIL RecLSalesLine.NEXT = 0;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateDirectUnitCost', '', false, false)]
    local procedure T39_OnAfterUpdateDirectUnitCost(var PurchLine: Record "Purchase Line"; xPurchLine: Record "Purchase Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    var
        RecGVendor: Record Vendor;
        Currency: Record Currency;
    begin
        PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", 0);
        PurchLine."BC6_DEEE VAT Amount" := 0;
        PurchLine."BC6_DEEE TTC Amount" := 0;
        PurchLine."BC6_DEEE Amount (LCY) for Stat" := 0;
        RecGVendor.GET(PurchLine."Buy-from Vendor No.");
        IF RecGVendor."BC6_Posting DEEE" THEN BEGIN
            PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", PurchLine."BC6_DEEE Unit Price" * PurchLine."Quantity (Base)");
            Currency.get(Currency.Code);
            PurchLine."BC6_DEEE VAT Amount" := ROUND(PurchLine."BC6_DEEE HT Amount" * PurchLine."VAT %" / 100, Currency."Amount Rounding Precision");
            PurchLine."BC6_DEEE TTC Amount" := PurchLine."BC6_DEEE HT Amount" + PurchLine."BC6_DEEE VAT Amount";
            PurchLine."BC6_DEEE Amount (LCY) for Stat" := PurchLine."Quantity (Base)" * PurchLine."BC6_DEEE Unit Price (LCY)";
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    procedure T39_OnAfterValidateEvent_UnitPost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        RecGPurchPrice: record "Purchase Price";
        RecGPurchsetup: Record "Purchases & Payables Setup";
        Tectg003: label 'ENU="Do you want to create a Purchase Price ?"', comment = '"FRA=Voulez-vous creer un prix d''achat négocier ?"';

    begin

        //>>MIGRATION NAV 2013
        //>>FE025/26 FLGR 26/12/06
        IF (xRec."Direct Unit Cost" <> Rec."Direct Unit Cost") AND (xRec."Direct Unit Cost" <> 0) THEN BEGIN
            RecGPurchsetup.GET;
            IF RecGPurchsetup."BC6_Ask custom purch price" THEN BEGIN

                IF CONFIRM(Tectg003, FALSE) THEN BEGIN
                    RecGPurchPrice.RESET;
                    RecGPurchPrice.SETFILTER("Vendor No.", Rec."Buy-from Vendor No.");
                    RecGPurchPrice.SETFILTER("Item No.", Rec."No.");
                    RecGPurchPrice.SETFILTER("Starting Date", '%1', WORKDATE);
                    IF NOT RecGPurchPrice.FIND('-') THEN BEGIN
                        RecGPurchPrice.INIT;
                        RecGPurchPrice.VALIDATE("Item No.", Rec."No.");
                        RecGPurchPrice.VALIDATE("Vendor No.", Rec."Buy-from Vendor No.");
                        RecGPurchPrice.VALIDATE("Starting Date", WORKDATE);
                        RecGPurchPrice.VALIDATE("Direct Unit Cost", Rec."Direct Unit Cost");
                        RecGPurchPrice.INSERT(TRUE);
                    END;
                    RecGPurchPrice.SETFILTER("Starting Date", '');
                    PAGE.RUN(Page::"Purchase Prices", RecGPurchPrice);
                END;
            END;

        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure T39_OnCopyFromItemOnAfterCheck(PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin
        PurchaseLine."BC6_Public Price" := Item."Unit Price";
    end;
    //TAB383
    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure T383_OnAfterCopyFromGenJnlLine(var DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line")
    begin
        DtldCVLedgEntryBuffer."BC6_DEEE HT Amount" := GenJnlLine."BC6_DEEE HT Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE VAT Amount" := GenJnlLine."BC6_DEEE VAT Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE TTC Amount" := GenJnlLine."BC6_DEEE TTC Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE HT Amount (LCY)" := GenJnlLine."BC6_DEEE HT Amount (LCY)";
        DtldCVLedgEntryBuffer."BC6_Eco partner DEEE" := GenJnlLine."BC6_Eco partner DEEE";
    end;


}


