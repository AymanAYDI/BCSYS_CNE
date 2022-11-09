codeunit 50052 "BC6_Return Order Mgt."
{
    Permissions = TableData 50016 = rimd;

    trigger OnRun()
    begin
    end;

    var

        ComfirmDeleteAllRelatedDocuments: Label 'Souhaitez-vous supprimer tous les documents associés?';
        NoyExistingRelatedDocuments: Label 'Aucun document associé n''est crée pour ce retour vente.';
        ErrValidateReturnPurchOrder: Label 'Validation Impossible. \Le retour vente associé %1 n''a pas été validé.';

    procedure DeleteRelatedDocument(P_SalesHeader: Record 36)
    var
        "-BCSYS-": Integer;
        L_ReturnOrderRelation: Record 50016;
        L_SalesHeader: Record 36;
        L_RealedPurchReturn: Record 38;
        L_RelatedPurchOrder: Record 38;
        Confirm: Boolean;
        L_ReturnOrderRelation1: Record 50016;
    begin
        WITH P_SalesHeader DO BEGIN
            IF ("Document Type" = "Document Type"::"Return Order") AND ("BC6_Return Order Type" = "BC6_Return Order Type"::SAV) THEN
                IF L_ReturnOrderRelation.GET("No.") THEN
                    Confirm := DIALOG.CONFIRM(ComfirmDeleteAllRelatedDocuments, FALSE);
            IF Confirm THEN BEGIN
                //Delete Related Sales Order
                IF L_ReturnOrderRelation."Sales Order No." <> '' THEN BEGIN
                    L_SalesHeader.RESET;
                    L_SalesHeader.SETRANGE("Document Type", L_SalesHeader."Document Type"::Order);
                    L_SalesHeader.SETRANGE("No.", L_ReturnOrderRelation."Sales Order No.");
                    IF L_SalesHeader.FINDFIRST THEN BEGIN
                        L_SalesHeader.IsDeleteFromReturn(TRUE);
                        L_SalesHeader.DELETE(TRUE);
                    END;
                END;

                //Delete Related Purchase Return Order
                IF L_ReturnOrderRelation."Purchase Return Order" <> '' THEN BEGIN
                    L_RealedPurchReturn.RESET;
                    L_RealedPurchReturn.SETRANGE("Document Type", L_RealedPurchReturn."Document Type"::"Return Order");
                    L_RealedPurchReturn.SETRANGE("No.", L_ReturnOrderRelation."Purchase Return Order");
                    IF L_RealedPurchReturn.FINDFIRST THEN
                        L_RealedPurchReturn.DELETE(TRUE);
                END;


                //Delete Related Purchase Return Order
                IF L_ReturnOrderRelation."Purchase Order No." <> '' THEN BEGIN
                    L_RelatedPurchOrder.RESET;
                    L_RelatedPurchOrder.SETRANGE("Document Type", L_RelatedPurchOrder."Document Type"::Order);
                    L_RelatedPurchOrder.SETRANGE("No.", L_ReturnOrderRelation."Purchase Order No.");
                    IF L_RelatedPurchOrder.FINDFIRST THEN
                        L_RelatedPurchOrder.DELETE(TRUE);
                END;
            END;
        END;
    end;

    procedure DisableRelatedDocuments(P_ReturnOrderNo: Code[20])
    var
        L_ReturnOrderRelation: Record 50016;
        TempRetRelDoc: Record 6670 temporary;
    begin
        TempRetRelDoc.DELETEALL;

        IF L_ReturnOrderRelation.GET(P_ReturnOrderNo) THEN BEGIN
            IF L_ReturnOrderRelation."Sales Order No." <> '' THEN BEGIN
                TempRetRelDoc."Entry No." := 3;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Sales Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Sales Order No.";
                TempRetRelDoc.INSERT;
            END;

            IF L_ReturnOrderRelation."Purchase Return Order" <> '' THEN BEGIN
                TempRetRelDoc."Entry No." := 1;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Return Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Purchase Return Order";
                TempRetRelDoc.INSERT;
            END;

            IF L_ReturnOrderRelation."Purchase Order No." <> '' THEN BEGIN
                TempRetRelDoc."Entry No." := 2;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Purchase Order No.";
                TempRetRelDoc.INSERT;
            END;

            IF TempRetRelDoc.FINDFIRST THEN
                PAGE.RUN(PAGE::"Returns-Related Documents", TempRetRelDoc);
        END;
    end;

    local procedure ExtractOrderNo(P_SalesInvoiceLine: Record 113): Code[20]
    var
        SalesShptLine: Record 111;
        ItemLedgEntry: Record 32;
        ValueEntry: Record 5802;
        SalesShptHeader: Record 110;
        L_SalesHeader: Record 36;
    begin
        IF P_SalesInvoiceLine.Type <> P_SalesInvoiceLine.Type::Item THEN
            EXIT;

        FilterPstdDocLineValueEntries(P_SalesInvoiceLine, ValueEntry);
        IF ValueEntry.FINDFIRST THEN BEGIN
            ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
            IF ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Sales Shipment" THEN
                IF SalesShptLine.GET(ItemLedgEntry."Document No.", ItemLedgEntry."Document Line No.") THEN
                    IF SalesShptHeader.GET(SalesShptLine."No.") THEN;

        END;
        EXIT(SalesShptHeader."Order No.");
    end;


    procedure FilterPstdDocLineValueEntries(P_SalesInvoiceLine: Record 113; var ValueEntry: Record 5802)
    begin
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", P_SalesInvoiceLine."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", P_SalesInvoiceLine."Line No.");
    end;


    procedure DeleteRelatedSalesOrderNo(var P_SalesHeader: Record 36)
    var
        L_ReturnOrderRelation: Record 50016;
    begin
        WITH P_SalesHeader DO BEGIN
            IF ("Document Type" = "Document Type"::Order) THEN BEGIN
                L_ReturnOrderRelation.RESET;
                L_ReturnOrderRelation.SETRANGE("Sales Order No.", P_SalesHeader."No.");
                IF L_ReturnOrderRelation.FINDFIRST THEN BEGIN
                    L_ReturnOrderRelation."Sales Order No." := '';
                    L_ReturnOrderRelation.MODIFY;
                END;
            END;
        END;
    end;

    procedure DeleteRelatedPurchOrderNo(var P_PurchaseHeader: Record 38)
    var
        L_ReturnOrderRelation: Record 50016;
    begin
        WITH P_PurchaseHeader DO BEGIN
            IF ("Document Type" = "Document Type"::Order) THEN BEGIN
                L_ReturnOrderRelation.RESET;
                L_ReturnOrderRelation.SETRANGE("Purchase Order No.", P_PurchaseHeader."No.");
                IF L_ReturnOrderRelation.FINDFIRST THEN BEGIN
                    L_ReturnOrderRelation."Purchase Order No." := '';
                    L_ReturnOrderRelation.MODIFY;
                END;
            END;
        END;
    end;


    procedure DeleteRelatedPurchReturnOrderNo(var P_PurchaseHeader: Record 38)
    var
        L_ReturnOrderRelation: Record 50016;
    begin
        WITH P_PurchaseHeader DO BEGIN
            IF ("Document Type" = "Document Type"::"Return Order") THEN BEGIN
                L_ReturnOrderRelation.RESET;
                L_ReturnOrderRelation.SETRANGE("Purchase Return Order", P_PurchaseHeader."No.");
                IF L_ReturnOrderRelation.FINDFIRST THEN BEGIN
                    L_ReturnOrderRelation."Purchase Return Order" := '';
                    L_ReturnOrderRelation.MODIFY;
                END;
            END;
        END;
    end;

    local procedure DeleteSalesAndPurchDoc(var P_SalesHeader: Record 36)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]

    procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record 38)
    var
        L_ReturnOrderRelation: Record 50016;
        L_SalesCrMemoHeader: Record 114;
    begin
        WITH PurchaseHeader DO BEGIN
            IF "Document Type" <> "Document Type"::"Return Order" THEN
                EXIT;

            IF "BC6_Return Order Type" <> "BC6_Return Order Type"::SAV THEN
                EXIT;

            L_ReturnOrderRelation.RESET;
            L_ReturnOrderRelation.SETRANGE("Purchase Return Order", "No.");
            IF L_ReturnOrderRelation.FINDFIRST THEN BEGIN
                L_SalesCrMemoHeader.RESET;
                L_SalesCrMemoHeader.SETRANGE("Return Order No.", L_ReturnOrderRelation."Sales Return Order");
                IF L_SalesCrMemoHeader.ISEMPTY THEN
                    ERROR(STRSUBSTNO(ErrValidateReturnPurchOrder, L_ReturnOrderRelation."Sales Return Order"));
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterModifyEvent', '', false, false)]

    procedure OnAfterModifySalesHeader(var Rec: Record 36; var xRec: Record 36; RunTrigger: Boolean)
    var
        RecLModifiedSalesHeader: Record 36;
        RecLSalesReceivablesSetup: Record 311;
        RecLNoSeries: Record 308;
        CduNoSeriesMgt: Codeunit 396;
    begin
        WITH Rec DO BEGIN
            IF "Document Type" <> "Document Type"::"Return Order" THEN
                EXIT;

            IF ("BC6_Return Order Type" <> xRec."BC6_Return Order Type") AND ("BC6_Return Order Type" = "BC6_Return Order Type"::Location) THEN BEGIN
                RecLSalesReceivablesSetup.GET;
                RecLNoSeries.GET(RecLSalesReceivablesSetup."Return Order Nos.");
                RecLModifiedSalesHeader.GET("Document Type", "No.");
                RecLModifiedSalesHeader.RENAME("Document Type", CduNoSeriesMgt.GetNextNo(RecLNoSeries.Code, "Posting Date", TRUE));
            END;
        END;
    end;
}

