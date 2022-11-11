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
    //COD12
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCalcPmtDiscPossible', '', false, false)]

    local procedure COD12_OnBeforeCalcPmtDiscPossible(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var IsHandled: Boolean; RoundingPrecision: Decimal)
    var
        PaymentDiscountDateWithGracePeriod: Date;
        GLSetup: Record "General Ledger Setup";
        FctMngt: Codeunit BC6_FctMangt;

    begin
        IsHandled := true;
        with GenJnlLine do
            if "Amount (LCY)" <> 0 then begin
                PaymentDiscountDateWithGracePeriod := CVLedgEntryBuf."Pmt. Discount Date";
                GLSetup.GetRecordOnce();
                if PaymentDiscountDateWithGracePeriod <> 0D then
                    PaymentDiscountDateWithGracePeriod :=
                      CalcDate(GLSetup."Payment Discount Grace Period", PaymentDiscountDateWithGracePeriod);
                if (PaymentDiscountDateWithGracePeriod >= CVLedgEntryBuf."Posting Date") or
                   (PaymentDiscountDateWithGracePeriod = 0D)
                then begin
                    if GLSetup."Pmt. Disc. Excl. VAT" then begin
                        if "Sales/Purch. (LCY)" = 0 then
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" := ("Amount (LCY)" + FctMngt.TotalVATAmountOnJnlLines(GenJnlLine)) * (Amount - "BC6_DEEE HT Amount") / ("Amount (LCY)" - "BC6_DEEE HT Amount (LCY)")
                        else
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" := "Sales/Purch. (LCY)" * (Amount - "BC6_DEEE HT Amount") / ("Amount (LCY)" - "BC6_DEEE HT Amount (LCY)")
                    end else
                        CVLedgEntryBuf."Original Pmt. Disc. Possible" := (Amount - "BC6_DEEE HT Amount");
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure COD12_OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."BC6_Pay-to Customer No." := GenJournalLine."BC6_Pay-to No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure COD12_OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldVendLedgEntry."BC6_Pay-to Vend. No." := GenJournalLine."BC6_Pay-to No.";
    end;

    //COD21
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckInTransitLocations', '', false, false)]

    local procedure COD21_OnBeforeCheckInTransitLocations(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        Location: Record Location;
        FctMngt: Codeunit BC6_FctMangt;
    begin
        IsHandled := true;
        with ItemJournalLine do
            if (("Entry Type" <> "Entry Type"::Transfer) or ("Order Type" <> "Order Type"::Transfer)) and
               not Adjustment
            then begin
                FctMngt.CheckInTransitLocation("Location Code");
                Location.TESTFIELD("BC6_Blocked", FALSE);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckPhysInventory', '', false, false)]

    local procedure COD21_OnBeforeCheckPhysInventory(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        Text005: Label 'must be %1 or %2 when %3 is %4';
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        IsHandled := true;
        with ItemJnlLine do begin
            if not
               ("Entry Type" in
                ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."])
            then begin
                ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
                ItemJnlLine3."Entry Type" := ItemJnlLine3."Entry Type"::"Negative Adjmt.";
                FieldError(
                    "Entry Type",
                    ErrorInfo.Create(
                        StrSubstNo(
                            Text005, ItemJnlLine2."Entry Type", ItemJnlLine3."Entry Type", FieldCaption("Phys. Inventory"), true),
                        true));
            end;
            IF ("Entry Type" IN
              ["Entry Type"::"Positive Adjmt.",
               "Entry Type"::"Negative Adjmt."]) THEN
                IF ItemJournalBatch.GET("Journal Template Name", ItemJnlLine."Journal Batch Name") THEN
                    ItemJournalBatch.TESTFIELD("BC6_Phys. Inv. Survey", FALSE);

        end;
    end;

    //COD22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure COD22_OnBeforeInsertItemLedgEntry_ItemJnlPostLine(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        RecLDEEEEntry: Record "BC6_DEEE Ledger Entry";
    begin
        IF (ItemJournalLine."BC6_DEEE Category Code" <> '') THEN BEGIN
            RecLDEEEEntry.TRANSFERFIELDS(ItemJournalLine);
            RecLDEEEEntry."DEEE Category Code" := ItemJournalLine."BC6_DEEE Category Code";
            RecLDEEEEntry."DEEE Unit Tax" := ItemJournalLine."BC6_DEEE Unit Price";
            RecLDEEEEntry."DEEE HT Amount" := ItemJournalLine."BC6_DEEE HT Amount";
            RecLDEEEEntry."DEEE VAT Amount" := ItemJournalLine."BC6_DEEE VAT Amount";
            RecLDEEEEntry."DEEE TTC Amount" := ItemJournalLine."BC6_DEEE TTC Amount";
            RecLDEEEEntry."Eco partner DEEE" := ItemJournalLine."BC6_Eco partner DEEE";
            RecLDEEEEntry."DEEE HT Amount (LCY)" := ItemJournalLine."BC6_DEEE HT Amount (LCY)";
            RecLDEEEEntry."DEEE Unit Price (LCY)" := ItemJournalLine."BC6_DEEE Unit Price (LCY)";
            RecLDEEEEntry."Gen. Bus. Posting Group" := ItemJournalLine."Gen. Bus. Posting Group";
            RecLDEEEEntry."DEEE Amount (LCY) for Stat" := ItemJournalLine."BC6_DEEE Amount (LCY) for Stat";
            RecLDEEEEntry.INSERT;
        END;
    end;

    //COD23
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeOpenProgressDialog', '', false, false)]
    local procedure COD23_OnBeforeOpenProgressDialog(var ItemJnlLine: Record "Item Journal Line"; var Window: Dialog; var WindowIsOpen: Boolean; var IsHandled: Boolean)
    var
        ItemJnlTemplate: Record "Item Journal Template";
        Text001: Label 'Journal Batch Name    #1##########\\';
        Text002: Label 'Checking lines        #2######\';
        Text003: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        Text004: Label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text101: Label 'ENU=Jnl. Batch #1###\\';
        Text102: Label 'ENU=Chec. lines #2###\';
        Text105: label 'ENU=Post. #3### @4@;FRA=Valid.#3### @4@@@';
        InvtSetup: Record "Inventory Setup";  //NOT SUREE
    begin
        IsHandled := true;
        ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");

        if ItemJnlTemplate.Recurring then
            Window.Open(
              Text001 +
              Text002 +
              Text003 +
              Text004)
        else
            IF (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 1") OR
               (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 2") THEN
                Window.OPEN(
                  Text101 +
                  Text102 +
                  Text105)
            ELSE
                Window.Open(
                  Text001 +
                  Text002 +
                  Text005);
        Window.Update(1, ItemJnlLine."Journal Batch Name");
        WindowIsOpen := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnItemJnlPostSumLineOnAfterGetItem', '', false, false)]
    //TODO: not sure of it(ItemJournalLine was ItemJournalLine4 in the old code)
    local procedure COD23_OnItemJnlPostSumLineOnAfterGetItem(var Item: Record Item; ItemJournalLine: Record "Item Journal Line")
    var
        IncludeExpectedCost: Boolean;
    begin
        IncludeExpectedCost :=
    (Item."Costing Method" = Item."Costing Method"::Average) and
    (ItemJournalLine."Inventory Value Per" <> ItemJournalLine."Inventory Value Per"::" ");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeWhseJnlPostLineRun', '', false, false)]
    local procedure COD23_OnBeforeWhseJnlPostLineRun(ItemJournalLine: Record "Item Journal Line"; var TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary; var IsHandled: Boolean)
    var
        InvtToReclass: Codeunit "BC6_Invt. Pick To Reclass.";
    begin
        InvtToReclass.RUN(TempWarehouseJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeCheckItemAvailabilityHandled', '', false, false)]
    local procedure COD23_OnBeforeCheckItemAvailabilityHandled(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
    begin
        InvtSetup.GET; //To check this event(InvtSetup is declared as a global variable)
    end;

    //COD 57 to be continued .. 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterSalesLineSetFilters', '', false, false)]
    local procedure COD57_OnAfterSalesLineSetFilters(var TotalSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line")
    begin
        TotalSalesLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", TotalSalesLine."BC6_DEEE HT Amount", TotalSalesLine."BC6_DEEE VAT Amount", TotalSalesLine."BC6_DEEE TTC Amount", TotalSalesLine."BC6_DEEE HT Amount (LCY)");
        TotalSalesLine."Amount Including VAT" := TotalSalesLine."Amount Including VAT" + TotalSalesLine."BC6_DEEE TTC Amount";
        TotalSalesLine.Amount := TotalSalesLine.Amount + TotalSalesLine."BC6_DEEE HT Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterPurchaseLineSetFilters', '', false, false)]
    local procedure COD57_OnAfterPurchaseLineSetFilters(var TotalPurchaseLine: Record "Purchase Line"; PurchaseLine: Record "Purchase Line")
    begin
        //BC6>>
        TotalPurchaseLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", TotalPurchaseLine."BC6_DEEE HT Amount", TotalPurchaseLine."BC6_DEEE VAT Amount", TotalPurchaseLine."BC6_DEEE TTC Amount", TotalPurchaseLine."BC6_DEEE HT Amount (LCY)");
        TotalPurchaseLine."Amount Including VAT" := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."BC6_DEEE TTC Amount";
        TotalPurchaseLine.Amount := TotalPurchaseLine.Amount + TotalPurchaseLine."BC6_DEEE HT Amount";
        //BC6<<
    end;

    //COD80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure COD80_OnAfterPostSalesLines(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        FctMngt: Codeunit BC6_FctMangt;
    begin
        IF SalesHeader.Invoice THEN BEGIN
            IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] THEN BEGIN
                FctMngt.xUpdateShipmentInvoiced(SalesInvoiceHeader);
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterReverseAmount', '', false, false)]
    local procedure COD80_OnAfterReverseAmount(var SalesLine: Record "Sales Line")
    begin
        SalesLine."BC6_Purchase cost" := -SalesLine."BC6_Purchase cost";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostDropOrderShipment', '', false, false)]
    local procedure COD80_OnBeforePostDropOrderShipment(var SalesHeader: Record "Sales Header"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary)
    var
        TotalSalesLineLCY: Record "sales line";
    begin
        TotalSalesLineLCY.get(TotalSalesLineLCY."Document Type", TotalSalesLineLCY."Document No.", TotalSalesLineLCY."Line No.");
        if not SalesHeader.IsCreditDocType then begin
            TotalSalesLineLCY."Unit Cost (LCY)" := -TotalSalesLineLCY."Unit Cost (LCY)";
            TotalSalesLineLCY."BC6_Purchase cost" := -TotalSalesLineLCY."BC6_Purchase cost";
        end;
    end; //TO CHECK which is more coherent 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCalcItemJnlAmountsFromQtyToBeShipped', '', false, false)]
    local procedure COD80_OnBeforeCalcItemJnlAmountsFromQtyToBeShipped(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; QtyToBeShipped: Decimal; var IsHandled: Boolean)
    begin
        SalesLine."BC6_DEEE Category Code" := SalesLine."BC6_DEEE Category Code";

        IF SalesLine."Qty. to Ship" <> 0 THEN
            SalesLine."BC6_DEEE HT Amount" :=
              ROUND(
                SalesLine."BC6_DEEE HT Amount" *
                (QtyToBeShipped / SalesLine."Qty. to Ship"));

        IF SalesLine."Qty. to Ship" <> 0 THEN
            SalesLine."BC6_DEEE TTC Amount" :=
              ROUND(
              SalesLine."BC6_DEEE TTC Amount" *
              (QtyToBeShipped / SalesLine."Qty. to Ship"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateWhseDocuments', '', false, false)]
    local procedure COD80_OnAfterUpdateWhseDocuments(SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; EverythingInvoiced: Boolean)
    var
        FctMngt: Codeunit BC6_FctMangt;
        RecGParmNavi: Record "BC6_Navi+ Setup";
        RecGArchiveManagement: Codeunit ArchiveManagement;
        SalesInvHeader: Record "sales invoice header";
    begin
        SalesInvHeader.get();
        IF RecGParmNavi.GET THEN
            IF RecGParmNavi."Filing Sales Orders" THEN
                RecGArchiveManagement.StoreSalesDocument(SalesHeader, FALSE);
        FctMngt.xUpdateShipmentInvoiced(SalesInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeRoundAmount', '', false, false)]
    local procedure COD80_OnBeforeRoundAmount(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesLineQty: Decimal; var CurrExchRate: Record "Currency Exchange Rate")
    begin

        if SalesHeader."Currency Code" <> '' then begin
            //>>MIGRATION NAV 2013 - 2017
            SalesLine."BC6_DEEE Unit Price" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                   SalesHeader.GetUseDate(), SalesHeader."Currency Code",
                  SalesLine."BC6_DEEE Unit Price", SalesHeader."Currency Factor")) -
                    SalesLine."BC6_DEEE Unit Price";
            //<<MIGRATION NAV 2013 - 2017
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRoundAmountOnBeforeIncrAmount', '', false, false)]
    local procedure COD80_OnRoundAmountOnBeforeIncrAmount(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesLineQty: Decimal; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    var
        FctMngt: Codeunit BC6_FctMangt;
        EnableIncrPurchCost: Boolean; //(variable globale que je la déclaré locale, car elle est utilisée slmnt dans cette partie)
        L_Item: Record Item;
    begin

        // FctMngt.Increment(TotalSalesLine."BC6_Purchase cost",ROUND(SalesLineQty * TotalSalesLine."BC6_Purchase cost"));
        // IF EnableIncrPurchCost THEN
        //   IF L_Item.Type = L_Item.Type::Item THEN BEGIN
        //     L_Item.GET("No.");
        //     FctMngt.Increment(SalesLine."BC6_Purchase cost", ROUND(TotalSalesLine."BC6_Purchase cost" * L_Item."BC6_Cost Increase Coeff %" / 100) * SalesLineQty);
        //   END; //TODO: Item n'existe plus dans la liste des options de l'enum Type
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterIncrAmount', '', false, false)]
    local procedure COD80_OnAfterIncrAmount(var TotalSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        FctMngt: Codeunit BC6_FctMangt;

    begin
        FctMngt.Increment(TotalSalesLine."BC6_DEEE HT Amount", TotalSalesLine."BC6_DEEE HT Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE TTC Amount", TotalSalesLine."BC6_DEEE TTC Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE VAT Amount", TotalSalesLine."BC6_DEEE VAT Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE HT Amount (LCY)", TotalSalesLine."BC6_DEEE HT Amount (LCY)");
    end;


    //COD81
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnConfirmPostOnBeforeSetSelection', '', false, false)]
    local procedure COD81_OnConfirmPostOnBeforeSetSelection(var SalesHeader: Record "Sales Header")
    begin
        //>>MIGRATION NAV 2013
        //FG
        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice THEN
            SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Released);
        //<<MIGRATION NAV 2013
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]

    local procedure COD81_OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLNaviSetup: Record "BC6_Navi+ Setup";
        AssmPost: Codeunit "Assembly-Post"; // Procedure moved from CDU80 to CDU900 and changed arguments .. 
    begin
        RecLNaviSetup.GET();
        IF RecLNaviSetup."Date jour en factur/livraison" THEN
            AssmPost.SetPostingDate(TRUE, WORKDATE);
    end;
    //COD82
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure COD82_OnBeforeConfirmPostProcedure(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        FctMngt: Codeunit BC6_FctMangt;
        ConfirmManagement: Codeunit "Confirm Management";
        SalesPostPrint: Codeunit "Sales-Post + Print";
        RecLNaviSetup: Record "BC6_Navi+ Setup";
        AsmPost: Codeunit "Assembly-Post";
    begin
        IsHandled := true;
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;
        with SalesHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit;
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit;
                        Receive := Selection in [1, 3];
                        IF Ship THEN FctMngt.CalcProfit2(SalesHeader);
                        Invoice := Selection in [2, 3];

                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(SalesPostPrint.ConfirmationMessage, "Document Type"), true)
                    then
                        exit;

            end;
            "Print Posted Documents" := true;
            //>>MIGRATION NAV 2013
            //>> NavEasy Correction FRGO 14/03/2007
            IF RecLNaviSetup.GET THEN BEGIN
                IF RecLNaviSetup."Date jour en factur/livraison" THEN
                    AsmPost.SetPostingDate(TRUE, WORKDATE);
            END;
            //<<NavEasy Correction FRGO 14/03/2007
            //<<MIGRATION NAV 2013

        end;
    end;
    //COD83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeConfirmConvertToOrder', '', false, false)]
    local procedure COD83_OnBeforeConfirmConvertToOrder(SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLSalesLine: Record "Sales Line";
        RecLItem: Record Item;

    begin
        //>>MIGRATION NAV 2013
        SalesHeader.TESTFIELD("Shipment Method Code", '');
        //>> MODIF HL 17/05/2011 SU-LALE cf appel TI046353
        // on vient v‚rifier si dans le devis les articles ne sont pas bloqu‚s.
        RecLSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        RecLSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        RecLSalesLine.SETRANGE(Type, RecLSalesLine.Type::Item);
        RecLSalesLine.SETFILTER("No.", '<>%1', '');
        IF RecLSalesLine.FINDFIRST THEN
            REPEAT
                RecLItem.GET(RecLSalesLine."No.");
                RecLItem.TESTFIELD(Blocked, FALSE);
            UNTIL RecLSalesLine.NEXT = 0;
        //<< MODIF HL 17/05/2011 SU-LALE cf appel TI046353
        //<<MIGRATION NAV 2013
    end;

    //COD 86

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure COD86_OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        FctMngt: Codeunit BC6_FctMangt;
    begin
        FctMngt.UpdatePurchasedoc(SalesQuoteLine, SalesQuoteLine);
    end;



}
