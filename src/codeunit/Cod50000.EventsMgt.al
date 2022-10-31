codeunit 50000 "BC6_EventsMgt"
{
    //TAB290
    //TODO:check code
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    local procedure T290_OnAfterCopyFromPurchInvLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line")
    begin
        VATAmountLine."DEEE HT Amount" := VATAmountLine."DEEE HT Amount" + PurchInvLine."BC6_DEEE HT Amount";
        VATAmountLine."DEEE VAT Amount" := VATAmountLine."DEEE VAT Amount" + PurchInvLine."BC6_DEEE VAT Amount";
        VATAmountLine."DEEE TTC Amount" := VATAmountLine."DEEE TTC Amount" + PurchInvLine."BC6_DEEE TTC Amount";
        IF PurchInvLine."Allow Invoice Disc." THEN
            VATAmountLine."Inv. Disc. Base Amount" := VATAmountLine."Inv. Disc. Base Amount" + PurchInvLine."BC6_DEEE HT Amount";
    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    local procedure T290_OnAfterCopyFromPurchCrMemoLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        VATAmountLine."DEEE HT Amount" := VATAmountLine."DEEE HT Amount" + PurchCrMemoLine."BC6_DEEE HT Amount";
        VATAmountLine."DEEE VAT Amount" := VATAmountLine."DEEE VAT Amount" + PurchCrMemoLine."BC6_DEEE VAT Amount";
        VATAmountLine."DEEE TTC Amount" := VATAmountLine."DEEE TTC Amount" + PurchCrMemoLine."BC6_DEEE TTC Amount";

        IF PurchCrMemoLine."Allow Invoice Disc." THEN
            VATAmountLine."Inv. Disc. Base Amount" := PurchCrMemoLine."Line Amount";

    end;

    //TAB5765 
    //TODO: check si No. appartient au record commentLine 
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Request", 'OnAfterDeleteRequest', '', false, false)]
    local procedure T5765_OnAfterDeleteRequest_WarehouseReq(SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20])
    var
        RecLAffairStep: Record "BC6_Affair Steps";
        CommentLine: Record "Comment Line";

    begin
        RecLAffairStep.SETRANGE("Affair No.", CommentLine."No.");
        RecLAffairStep.DELETEALL();
    end;

    //TAB36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]

    local procedure T36_OnAfterOnInsert_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.ID := USERID;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', false, false)]
    local procedure OnDeleteOnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.FINDFIRST;
        IF CompanyInfo."Branch Company" THEN BEGIN
            IF "Purchase No. Order Lien" <> '' THEN
                ERROR(TextG003);
        END;

        IF NOT IsDeleteFromReturnOrder THEN BEGIN
            G_ReturnOrderMgt.DeleteRelatedDocument(SalesHeader);

            G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(SalesHeader);
        END;
    end;


}