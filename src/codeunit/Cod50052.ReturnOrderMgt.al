codeunit 50052 "BC6_Return Order Mgt."
{
    Permissions = tabledata "BC6_Return Order Relation" = rimd;

    var

        ComfirmDeleteAllRelatedDocuments: label 'Souhaitez-vous supprimer tous les documents associés?';
        ErrValidateReturnPurchOrder: label 'Validation Impossible. \Le retour vente associé %1 n''a pas été validé.';

    procedure DeleteRelatedDocument(P_SalesHeader: Record "Sales Header")
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
        L_RealedPurchReturn: Record "Purchase Header";
        L_RelatedPurchOrder: Record "Purchase Header";
        L_SalesHeader: Record "Sales Header";
        Confirm: Boolean;
    begin
        if (P_SalesHeader."Document Type" = P_SalesHeader."Document Type"::"Return Order") and (P_SalesHeader."BC6_Return Order Type" = P_SalesHeader."BC6_Return Order Type"::SAV) then
            if L_ReturnOrderRelation.GET(P_SalesHeader."No.") then
                Confirm := DIALOG.CONFIRM(ComfirmDeleteAllRelatedDocuments, false);
        if Confirm then begin
            //Delete Related Sales Order
            if L_ReturnOrderRelation."Sales Order No." <> '' then begin
                L_SalesHeader.RESET();
                L_SalesHeader.SETRANGE("Document Type", L_SalesHeader."Document Type"::Order);
                L_SalesHeader.SETRANGE("No.", L_ReturnOrderRelation."Sales Order No.");
                if L_SalesHeader.FINDFIRST() then begin
                    L_SalesHeader.IsDeleteFromReturn(true);
                    L_SalesHeader.DELETE(true);
                end;
            end;

            if L_ReturnOrderRelation."Purchase Return Order" <> '' then begin
                L_RealedPurchReturn.RESET();
                L_RealedPurchReturn.SETRANGE("Document Type", L_RealedPurchReturn."Document Type"::"Return Order");
                L_RealedPurchReturn.SETRANGE("No.", L_ReturnOrderRelation."Purchase Return Order");
                if L_RealedPurchReturn.FINDFIRST() then
                    L_RealedPurchReturn.DELETE(true);
            end;

            if L_ReturnOrderRelation."Purchase Order No." <> '' then begin
                L_RelatedPurchOrder.RESET();
                L_RelatedPurchOrder.SETRANGE("Document Type", L_RelatedPurchOrder."Document Type"::Order);
                L_RelatedPurchOrder.SETRANGE("No.", L_ReturnOrderRelation."Purchase Order No.");
                if L_RelatedPurchOrder.FINDFIRST() then
                    L_RelatedPurchOrder.DELETE(true);
            end;
        end;
    end;

    procedure DisableRelatedDocuments(P_ReturnOrderNo: Code[20])
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
        TempRetRelDoc: Record "Returns-Related Document" temporary;
    begin
        TempRetRelDoc.DELETEALL();

        if L_ReturnOrderRelation.GET(P_ReturnOrderNo) then begin
            if L_ReturnOrderRelation."Sales Order No." <> '' then begin
                TempRetRelDoc."Entry No." := 3;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Sales Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Sales Order No.";
                TempRetRelDoc.INSERT();
            end;

            if L_ReturnOrderRelation."Purchase Return Order" <> '' then begin
                TempRetRelDoc."Entry No." := 1;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Return Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Purchase Return Order";
                TempRetRelDoc.INSERT();
            end;

            if L_ReturnOrderRelation."Purchase Order No." <> '' then begin
                TempRetRelDoc."Entry No." := 2;
                TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Order";
                TempRetRelDoc."No." := L_ReturnOrderRelation."Purchase Order No.";
                TempRetRelDoc.INSERT();
            end;

            if TempRetRelDoc.FINDFIRST() then
                PAGE.RUN(PAGE::"Returns-Related Documents", TempRetRelDoc);
        end;
    end;

    procedure FilterPstdDocLineValueEntries(P_SalesInvoiceLine: Record "Sales Invoice Line"; var ValueEntry: Record "Value Entry")
    begin
        ValueEntry.RESET();
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", P_SalesInvoiceLine."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", P_SalesInvoiceLine."Line No.");
    end;

    procedure DeleteRelatedSalesOrderNo(var P_SalesHeader: Record "Sales Header")
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
    begin
        if (P_SalesHeader."Document Type" = P_SalesHeader."Document Type"::Order) then begin
            L_ReturnOrderRelation.RESET();
            L_ReturnOrderRelation.SETRANGE("Sales Order No.", P_SalesHeader."No.");
            if L_ReturnOrderRelation.FINDFIRST() then begin
                L_ReturnOrderRelation."Sales Order No." := '';
                L_ReturnOrderRelation.MODIFY();
            end;
        end;
    end;

    procedure DeleteRelatedPurchOrderNo(var P_PurchaseHeader: Record "Purchase Header")
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
    begin
        if (P_PurchaseHeader."Document Type" = P_PurchaseHeader."Document Type"::Order) then begin
            L_ReturnOrderRelation.RESET();
            L_ReturnOrderRelation.SETRANGE("Purchase Order No.", P_PurchaseHeader."No.");
            if L_ReturnOrderRelation.FINDFIRST() then begin
                L_ReturnOrderRelation."Purchase Order No." := '';
                L_ReturnOrderRelation.MODIFY();
            end;
        end;
    end;

    procedure DeleteRelatedPurchReturnOrderNo(var P_PurchaseHeader: Record "Purchase Header")
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
    begin
        if (P_PurchaseHeader."Document Type" = P_PurchaseHeader."Document Type"::"Return Order") then begin
            L_ReturnOrderRelation.RESET();
            L_ReturnOrderRelation.SETRANGE("Purchase Return Order", P_PurchaseHeader."No.");
            if L_ReturnOrderRelation.FINDFIRST() then begin
                L_ReturnOrderRelation."Purchase Return Order" := '';
                L_ReturnOrderRelation.MODIFY();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    Local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        L_ReturnOrderRelation: Record "BC6_Return Order Relation";
        L_SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TextError: Text;
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Return Order" then
            exit;

        if PurchaseHeader."BC6_Return Order Type" <> PurchaseHeader."BC6_Return Order Type"::SAV then
            exit;

        L_ReturnOrderRelation.RESET();
        L_ReturnOrderRelation.SETRANGE("Purchase Return Order", PurchaseHeader."No.");
        if L_ReturnOrderRelation.FINDFIRST() then begin
            L_SalesCrMemoHeader.RESET();
            L_SalesCrMemoHeader.SETRANGE("Return Order No.", L_ReturnOrderRelation."Sales Return Order");
            if L_SalesCrMemoHeader.ISEMPTY then begin
                TextError := STRSUBSTNO(ErrValidateReturnPurchOrder, L_ReturnOrderRelation."Sales Return Order");
                ERROR(TextError);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterModifyEvent', '', false, false)]
    Local procedure OnAfterModifySalesHeader(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean)
    var
        RecLNoSeries: Record "No. Series";
        RecLSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecLModifiedSalesHeader: Record "Sales Header";
        CduNoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Rec."Document Type" <> Rec."Document Type"::"Return Order" then
            exit;

        if (Rec."BC6_Return Order Type" <> xRec."BC6_Return Order Type") and (Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::Location) then begin
            RecLSalesReceivablesSetup.GET();
            RecLNoSeries.GET(RecLSalesReceivablesSetup."Return Order Nos.");
            RecLModifiedSalesHeader.GET(Rec."Document Type", Rec."No.");
            RecLModifiedSalesHeader.RENAME(Rec."Document Type", CduNoSeriesMgt.GetNextNo(RecLNoSeries.Code, Rec."Posting Date", true));
        end;
    end;
}
