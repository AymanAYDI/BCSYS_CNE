codeunit 50203 "BC6__CNEEventMgt"
{
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Act.-Post (Yes/No)", 'OnBeforeSetParamsAndRunWhseActivityPost', '', false, false)]
    local procedure CU7323_OnBeforeSetParamsAndRunWhseActivityPost_WhseActPostYesN(var WarehouseActivityLine: Record "Warehouse Activity Line"; HideDialog: Boolean; PrintDoc: Boolean; Selection: Integer; var IsHandled: Boolean)
    var
        WhseActivityPost: Codeunit "Whse.-Activity-Post";
    begin
        IF HideDialog THEN
            // WhseActivityPost.SetPostingDate(HideDialog); // TODO: missing function
            WhseActivityPost.SetInvoiceSourceDoc(Selection = 2);
        WhseActivityPost.PrintDocument(PrintDoc);
        WhseActivityPost.Run(WarehouseActivityLine);
        Clear(WhseActivityPost);
    end;


    var
        BinCode: Code[20]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        YourRef: Text[35]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        DestName: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        DestName2: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
        WhseComments: Text[50]; // TODO: Related to function CU7322_OnAfterUpdateWhseActivHeader_CreateInventoryPickMovement of Codeunit 7322
}