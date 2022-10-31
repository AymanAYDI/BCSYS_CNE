codeunit 50200 "BC6_CNE_EventsMgt"
{

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnCreateCustomerOnBeforeCustomerModify', '', false, false)]
    local procedure T5050_OnCreateCustomerOnBeforeCustomerModify_Contact(var Customer: Record Customer; Contact: Record Contact)
    var
        CustTemplate: Record "Customer Template";
    begin
        Customer."Submitted to DEEE" := CustTemplate."BC6_Submitted to DEEE";
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
            IF NOT RecLUserSetup."Autorize Qty. to Handle Change" THEN
                ERROR(CstL001);
            IF RecLUserSetup."Aut. Qty. to Han. Test PickQty" THEN
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
        GenJournalLine."BC6_Pay-to No." := PurchaseHeader."Pay-to Vend. No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Payment Method Code" := SalesHeader."Payment Method Code";
        GenJournalLine."BC6_Pay-to No." := SalesHeader."Pay-to Customer No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure T83_OnAfterCopyItemJnlLineFromSalesLine_ItemJournalLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."BC6_DEEE Category Code" := SalesLine."DEEE Category Code";
        ItemJnlLine."BC6_DEEE Unit Price" := SalesLine."DEEE Unit Price";
        ItemJnlLine."BC6_DEEE HT Amount" := SalesLine."DEEE HT Amount";
        ItemJnlLine."BC6_DEEE VAT Amount" := SalesLine."DEEE VAT Amount";
        ItemJnlLine."BC6_DEEE TTC Amount" := SalesLine."DEEE TTC Amount";
        ItemJnlLine."BC6_Eco partner DEEE" := SalesLine."Eco partner DEEE";
        ItemJnlLine."BC6_DEEE HT Amount (LCY)" := SalesLine."DEEE HT Amount (LCY)";
        ItemJnlLine."BC6_DEEE Unit Price (LCY)" := SalesLine."DEEE Unit Price (LCY)";
        ItemJnlLine."BC6_DEEE Amount (LCY) for Stat" := SalesLine."DEEE Amount (LCY) for Stat";
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


}
