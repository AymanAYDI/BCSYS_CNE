codeunit 50200 "BC6_CNE_EventsMgt"
{

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnCreateCustomerOnBeforeCustomerModify', '', false, false)]
    local procedure T5050_OnCreateCustomerOnBeforeCustomerModify_Contact(var Customer: Record Customer; Contact: Record Contact)
    var
        CustTemplate: Record "Customer Template";
    begin
        Customer."BC6_Submitted to DEEE" := CustTemplate."BC6_Submitted to DEEE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnBeforeValidateQtyToHandle', '', false, false)]
    local procedure T5767_OnBeforeValidateQtyToHandle_WarehouseActivityLine(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        RecLUserSetup: Record "User Setup";
        CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
        CstL002: Label 'Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée.';
        Text002: Label 'You cannot handle more than the outstanding %1 units.';
    begin
        if WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."Qty. Outstanding" then
            Error(Text002, WarehouseActivityLine."Qty. Outstanding");
        IF RecLUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecLUserSetup."BC6_Autorize Qty. to Handle Change" THEN
                ERROR(CstL001);
            IF RecLUserSetup."BC6_Aut. Qty. to Han. Test PickQty" THEN
                IF WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."BC6_Qty. Picked" THEN
                    ERROR(CstL002);

        END ELSE
            ERROR(CstL001);

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line Discount", 'OnAfterInsertEvent', '', false, false)]
    local procedure T7014_OnAfterInsertEvent_PurchaseLineDiscount(var Rec: Record "Purchase Line Discount"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec.BC6_Type <> Rec.BC6_Type::"All items" THEN
            Rec.TESTFIELD("Item No.");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line Discount", 'OnAfterRenameEvent', '', false, false)]
    local procedure T7014_OnAfterRenameEvent_PurchaseLineDiscount(var Rec: Record "Purchase Line Discount"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec.BC6_Type <> Rec.BC6_Type::"All items" THEN
            Rec.TESTFIELD("Item No.");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bin Content", 'OnBeforeCalcQtyAvailToTake', '', false, false)]
    local procedure T7302_OnBeforeCalcQtyAvailToTake_BinContent(var BinContent: Record "Bin Content"; ExcludeQtyBase: Decimal; var QtyAvailToTake: Decimal; var IsHandled: Boolean)
    begin
        // IsHandled := true;
        // GetBin("Location Code","Bin Code");
        // IF Bin."Exclude Inventory Pick" THEN // TODO: procedure local Getbin , Bin variable global
        //     EXIT(0);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeSendEmailDirectly', '', false, false)]
    local procedure T77_OnBeforeSendEmailDirectly_ReportSelections(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        DocumentMailing: codeunit "Document-Mailing";
    begin
        CASE ReportUsage OF
            ReportUsage::"S.Order", ReportUsage::"S.Quote":
                BEGIN
                    SalesHeader := RecordVariant;
                    //   DocumentMailing.SetYourReference(SalesHeader."Your Reference"); //TODO: missing function SetYourReference
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnSendEmailDirectlyOnBeforeSaveReportAsPDFInTempBlob', '', false, false)]
    local procedure T77_OnSendEmailDirectlyOnBeforeSaveReportAsPDFInTempBlob_ReportSelection(ReportSelection: Record "Report Selections"; RecordVariant: Variant; ReportUsage: Enum "Report Selection Usage"; var TempBlob: Codeunit "Temp Blob"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        // IF ReportUsage IN [ReportUsage::"S.Order", ReportUsage::"S.Quote"] THEN BEGIN  TODO:
        //       SalesHeader := RecordVariant;
        //       IF SalesHeader."Sell-to E-Mail Address" <> '' THEN
        //         EmailAddress := SalesHeader."Sell-to E-Mail Address";
        //     END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure T81_OnAfterCopyGenJnlLineFromPurchHeader_GenJournalLine(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."BC6_Pay-to No." := PurchaseHeader."BC6_Pay-to Vend. No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Payment Method Code" := SalesHeader."Payment Method Code";
        GenJournalLine."BC6_Pay-to No." := SalesHeader."BC6_Pay-to Customer No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure T83_OnAfterCopyItemJnlLineFromSalesLine_ItemJournalLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."BC6_DEEE Category Code" := SalesLine."BC6_DEEE Category Code";
        ItemJnlLine."BC6_DEEE Unit Price" := SalesLine."BC6_DEEE Unit Price";
        ItemJnlLine."BC6_DEEE HT Amount" := SalesLine."BC6_DEEE HT Amount";
        ItemJnlLine."BC6_DEEE VAT Amount" := SalesLine."BC6_DEEE VAT Amount";
        ItemJnlLine."BC6_DEEE TTC Amount" := SalesLine."BC6_DEEE TTC Amount";
        ItemJnlLine."BC6_Eco partner DEEE" := SalesLine."BC6_Eco partner DEEE";
        ItemJnlLine."BC6_DEEE HT Amount (LCY)" := SalesLine."BC6_DEEE HT Amount (LCY)";
        ItemJnlLine."BC6_DEEE Unit Price (LCY)" := SalesLine."BC6_DEEE Unit Price (LCY)";
        ItemJnlLine."BC6_DEEE Amount (LCY) for Stat" := SalesLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnValidateItemNoOnBeforeSetDescription', '', false, false)]
    local procedure T83_OnValidateItemNoOnBeforeSetDescription_ItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    begin
        ItemJournalLine."BC6_DEEE Category Code" := Item."BC6_DEEE Category Code";
        ItemJournalLine."BC6_Eco partner DEEE" := Item."BC6_Eco partner DEEE";
        ItemJournalLine.CalculateDEEE('');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnBeforeCheckReservedQtyBase', '', false, false)]
    local procedure T83_OnBeforeCheckReservedQtyBase_ItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; var Item: Record Item; var IsHandled: Boolean)
    begin
        ItemJournalLine.CalculateDEEE('');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Planning Assignment", 'OnBeforeChkAssignOne', '', false, false)]
    local procedure OnBeforeChkAssignOne(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; UpdateDate: Date; var IsHandled: Boolean)
    var
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
        ReorderingPolicy: Enum "Reordering Policy";
        planAssign: Record "Planning Assignment";
    begin
        ReorderingPolicy := Item."Reordering Policy"::" ";

        if SKU.Get(LocationCode, ItemNo, VariantCode) then
            ReorderingPolicy := SKU."Reordering Policy"
        else
            if Item.Get(ItemNo) then
                ReorderingPolicy := Item."Reordering Policy";

        if ReorderingPolicy <> Item."Reordering Policy"::"Maximum Qty." then
            planAssign.AssignOne(ItemNo, VariantCode, LocationCode, UpdateDate);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCalcVATAmountLinesOnBeforeQtyTypeGeneralCase', '', false, false)]
    local procedure T37_OnCalcVATAmountLinesOnBeforeQtyTypeGeneralCase_SalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line"; IncludePrepayments: Boolean; QtyType: Option; var QtyToHandle: Decimal; var AmtToHandle: Decimal)
    var
        Currency: Record Currency;
    begin
        VATAmountLine."BC6_DEEE HT Amount" += SalesLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" += ROUND(SalesLine."BC6_DEEE VAT Amount"
              , Currency."Amount Rounding Precision");
        VATAmountLine."Bc6_DEEE TTC Amount" += ROUND(SalesLine."BC6_DEEE TTC Amount"
              , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE Amount (LCY) for Stat" += SalesLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmounts', '', false, false)]
    local procedure T37_OnAfterUpdateAmounts_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine.CalcDiscountUnitPrice();
        SalesLine.CalcProfit();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceOnBeforeFindPrice', '', false, false)]
    local procedure T37_OnUpdateUnitPriceOnBeforeFindPrice_SalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        PriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
        PriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, CalledByFieldNo);
        // PriceCalcMgt.FindVeryBestPrice(SalesLine, SalesHeader); TODO:
        SalesLine.FctGCalcLineDiscount();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckBinCodeRelation', '', false, false)]
    local procedure T37_OnBeforeCheckBinCodeRelation_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        WMSManagement: Codeunit "WMS Management";
    begin
        if ((SalesLine."Document Type" IN [SalesLine."Document Type"::Invoice]) AND (SalesLine.Quantity >= 0)) or
                                                                     ((SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"]) AND (SalesLine.Quantity < 0))
                                                                  THEN
            WMSManagement.FindBinContent(SalesLine."Location Code", SalesLine."Bin Code", SalesLine."No.", SalesLine."Variant Code", '')
        else
            WMSManagement.FindBin(SalesLine."Location Code", SalesLine."Bin Code", '');

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateLineDiscountPercent', '', false, false)]
    local procedure T37_OnAfterValidateLineDiscountPercent_SalesLine(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    var
        L_Item: Record Item;
        L_Vendor: Record Vendor;
        L_UserSetup: Record "User Setup";
        L_IncrPurchCost: Decimal;
        L_IncrProfit: Decimal;
        UpdateProfitErr: Label '%1 cannot be less than %2 in %3 %4';
    begin
        SalesLine.CalcDiscountUnitPrice();
        IF ((SalesLine."Document Type" = SalesLine."Document Type"::Quote) OR (SalesLine."Document Type" = SalesLine."Document Type"::Order)) AND
           NOT SalesLine.GetSkipPurchCostVerif THEN BEGIN
            IF L_UserSetup.GET(USERID) AND L_UserSetup."BC6_Activ. Mini Margin Control" THEN BEGIN
                IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                    L_Item.GET(SalesLine."No.");
                    IF L_Vendor.GET(L_Item."Vendor No.") AND (L_Vendor."BC6_% Mini Margin" <> 0) THEN BEGIN
                        SalesLine.CalcIncreasePurchCost(L_IncrPurchCost);
                        SalesLine.CalcIncreaseProfit(L_IncrProfit, L_IncrPurchCost);
                        IF L_IncrProfit < L_Vendor."BC6_% Mini Margin" THEN
                            ERROR(UpdateProfitErr, SalesLine.FIELDCAPTION(SalesLine."Profit %"), L_Vendor.FIELDCAPTION("BC6_% Mini Margin"), L_Vendor.TABLECAPTION, L_Vendor."No.");
                    END;
                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQtyToShipAfterInitQty', '', false, false)]
    local procedure T37_OnValidateQtyToShipAfterInitQty_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        Text007: Label 'You cannot ship more than %1 units.';
        Text008: Label 'You cannot ship more than %1 base units.';
    begin
        if (((SalesLine."Qty. to Ship" < 0) xor (SalesLine.Quantity < 0)) and (SalesLine.Quantity <> 0) and (SalesLine."Qty. to Ship" <> 0)) or
                      (Abs(SalesLine."Qty. to Ship") > Abs(SalesLine."Outstanding Quantity")) or
                      (((SalesLine.Quantity < 0) xor (SalesLine."Outstanding Quantity" < 0)) and (SalesLine.Quantity <> 0) and (SalesLine."Outstanding Quantity" <> 0))
                   then
            Error(Text007, SalesLine."Outstanding Quantity");
        if (((SalesLine."Qty. to Ship (Base)" < 0) xor (SalesLine."Quantity (Base)" < 0)) and (SalesLine."Qty. to Ship (Base)" <> 0) and (SalesLine."Quantity (Base)" <> 0)) or
           (Abs(SalesLine."Qty. to Ship (Base)") > Abs(SalesLine."Outstanding Qty. (Base)")) or
           (((SalesLine."Quantity (Base)" < 0) xor (SalesLine."Outstanding Qty. (Base)" < 0)) and (SalesLine."Quantity (Base)" <> 0) and (SalesLine."Outstanding Qty. (Base)" <> 0))
        then
            Error(Text008, SalesLine."Outstanding Qty. (Base)");

        SalesLine."BC6_Qty. To Order" := SalesLine."Qty. to Ship";

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateLocationCodeOnBeforeSetShipmentDate', '', false, false)]
    local procedure T37_OnValidateLocationCodeOnBeforeSetShipmentDate_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesLine."BC6_Invoiced Date (Expected)" := SalesLine."Shipment Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeUpdateDates', '', false, false)]
    local procedure T37_OnValidateNoOnBeforeUpdateDates_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CallingFieldNo: Integer; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."BC6_Customer Sales Profit Group" := SalesHeader."BC6_Customer Sales Profit Group";

        SalesLine."BC6_External Document No." := SalesHeader."External Document No.";

        SalesLine."BC6_Invoiced Date (Expected)" := SalesLine."Shipment Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterHasTypeToFillMandatoryFields', '', false, false)]
    local procedure T37_OnAfterHasTypeToFillMandatoryFields_SalesLine(var SalesLine: Record "Sales Line"; var ReturnValue: Boolean)
    begin
        if ReturnValue then
            SalesLine.SetSkipPurchCostVerif(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', false, false)]
    local procedure T37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine.CalcProfit;
        SalesLine.CalcDiscountUnitPrice;
        SalesLine.FctGCalcLineDiscount();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterTestStatusOpen', '', false, false)]
    local procedure T37_OnAfterTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        RecLPurchLine: Record "Purchase Line";
        textg002: Label 'You will lost link between Sales document No %1 line %2 \ and purchase document of type %3, No %4 ,  line %5 \ Are you sure?';
    begin
        IF (SalesLine."BC6_Purch. Order No." <> '') OR (SalesLine."BC6_Purch. Line No." <> 0) THEN
            IF NOT CONFIRM(textg002, FALSE, SalesLine."Document No.", SalesLine."Line No.", SalesLine."BC6_Purch. Document Type", SalesLine."BC6_Purch. Order No.", SalesLine."BC6_Purch. Line No.") THEN
                ERROR('')
            ELSE BEGIN
                RecLPurchLine.RESET;
                RecLPurchLine.SETFILTER("BC6_Sales Document Type", '%1', SalesHeader."Document Type");
                RecLPurchLine.SETFILTER("BC6_Sales Line No.", '%1', SalesLine."Line No.");
                RecLPurchLine.SETFILTER("BC6_Sales No.", SalesLine."Document No.");
                IF RecLPurchLine.FIND('-') THEN
                    REPEAT
                        RecLPurchLine."BC6_Sales No." := '';
                        RecLPurchLine."BC6_Sales Line No." := 0;
                        SalesLine."BC6_Purch. Order No." := '';
                        SalesLine."BC6_Purch. Line No." := 0;
                        RecLPurchLine.MODIFY(TRUE);
                    UNTIL RecLPurchLine.NEXT = 0;
            END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure T37_OnBeforeTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)
    begin
        SalesLine.TestStatusLocked;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T37_OnAfterInsertEvent_SalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        "---DEEE1.00---": Integer;
        RecLItem: Record Item;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF ((Rec.Type = Rec.Type::Item) AND (RecLItem.GET(Rec."No."))) THEN
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");

        Rec.UpdateReturnOrderTypeFromSalesHeader;
        Rec.Modify();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T39_OnAfterInsertEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        "---DEEE1.00---": Integer;
        RecLItem: Record Item;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF ((Rec.Type = Rec.Type::Item) AND (RecLItem.GET(Rec."No."))) THEN
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");
        Rec.UpdateReturnOrderTypeFromSalesHeader;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T39_OnAfterModifyEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.CalcDiscountDirectUnitCost;
        ;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure T39_OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order THEN BEGIN
            PurchaseLine.LOCKTABLE;
            SalesOrderLine.LOCKTABLE;
            SalesOrderLine.RESET;
            SalesOrderLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Document Type", PurchaseLine."Document Type");
            SalesOrderLine.SETRANGE("BC6_Purch. Order No.", PurchaseLine."Document No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Line No.", PurchaseLine."Line No.");
            IF SalesOrderLine.FIND('-') THEN
                REPEAT
                    SalesOrderLine."BC6_Purch. Document Type" := 0;
                    SalesOrderLine."BC6_Purch. Order No." := '';
                    SalesOrderLine."BC6_Purch. Line No." := 0;
                    SalesOrderLine.MODIFY();
                UNTIL SalesOrderLine.NEXT = 0;
        END;

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    begin
        PurchLine.VALIDATE("BC6_DEEE Category Code", Item."BC6_DEEE Category Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure T39_OnAfterUpdateAmountsDone_PurchLine(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        PurchLine.CalcDiscountDirectUnitCost();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine', '', false, false)]
    local procedure OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine(PurchaseLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line"; QtyType: Option General,Invoicing,Shipping; var PurchaseLine2: Record "Purchase Line")
    var
        Currency: Record Currency;
    begin
        VATAmountLine."BC6_DEEE HT Amount" += PurchaseLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" += ROUND(PurchaseLine."BC6_DEEE VAT Amount"
            , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE TTC Amount" += ROUND(PurchaseLine."BC6_DEEE TTC Amount"
            , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE Amount (LCY) for Stat" += PurchaseLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", 'OnPurchaseReferenceNoLookupOnBeforeValidateDirectUnitCost', '', false, false)]
    local procedure OnPurchaseReferenceNoLookupOnBeforeValidateDirectUnitCost(var PurchaseLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    var
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        FctMngt: Codeunit BC6_FctMangt;
    begin
        FctMngt.FindVeryBestCost(PurchaseLine, PurchHeader);
    end;
}
