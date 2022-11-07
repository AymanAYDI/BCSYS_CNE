codeunit 50089 "PurchaseFunction Mgt"
{
    // MGTS10.035 :  18.03.2022  Create codeunit AND Add function : UpdateSalesOrderPrices
    // 
    // MGTS10.036 :  03.06.2022  Add Event : OnBeforePostPurchaseDoc
    // MGTS10.037 :  26.07.2022  Add Events : OnAfterInsertEventPurchaseLine
    //                                       OnAfterModifyEventPurchaseLine
    //                           Add function : CheckExitOtherItemInPurchaseLines


    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure UpdatePurchaseOrderPrices(PurchaseHeader: Record "38")
    var
        PurchaseLine: Record "39";
        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        PriceCalcMgt: Codeunit "7010";
        Win: Dialog;
        UpdatePricesInProgress: Label 'Updating prices...';
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
    begin
        IF NOT CONFIRM(CofirmMessage) THEN
            EXIT;
        PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        IF PurchaseLine.ISEMPTY THEN
            ERROR(NothingToHandleErr);
        IF GUIALLOWED THEN
            Win.OPEN(UpdatePricesInProgress);
        PurchaseLine.FINDSET;
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindPurchLineLineDisc(PurchaseHeader, PurchaseLine);
            PriceCalcMgt.FindPurchLinePrice(PurchaseHeader, PurchaseLine, PurchaseLine.FIELDNO(Quantity));
            PurchaseLine.VALIDATE("Direct Unit Cost");
            PurchaseLine.MODIFY(TRUE);
        UNTIL PurchaseLine.NEXT = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "38")
    var
        PurchaseLine: Record "39";
        ErrPurchOrderPostingWithOutItems: Label 'You cannot posr a purchase order without receiving items. (Purchase order: %1)';
    begin
        //>>MGTS10.036
        IF (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order) THEN
            EXIT;
        IF PurchaseHeader.Receive THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            PurchaseLine.SETFILTER("No.", '<>%1', '');
            IF PurchaseHeader.Invoice THEN BEGIN
                PurchaseLine.SETFILTER("Qty. to Invoice", '<>%1', 0);
                IF NOT PurchaseLine.ISEMPTY THEN
                    EXIT;
                PurchaseLine.SETRANGE("Qty. to Invoice");
            END;
            PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            IF PurchaseLine.ISEMPTY THEN
                ERROR(STRSUBSTNO(ErrPurchOrderPostingWithOutItems, PurchaseHeader."No."));
        END;
        //<<MGTS10.036
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventPurchaseLine(var Rec: Record "39"; RunTrigger: Boolean)
    begin
        //>>MGTS10.037
        IF NOT RunTrigger THEN
            EXIT;

        IF Rec.ISTEMPORARY THEN
            EXIT;

        CheckExitOtherItemInPurchaseLines(Rec);
        //<<MGTS10.037
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventPurchaseLine(var Rec: Record "39"; var xRec: Record "39"; RunTrigger: Boolean)
    begin
        //>>MGTS10.037
        IF NOT RunTrigger THEN
            EXIT;

        IF Rec.ISTEMPORARY THEN
            EXIT;

        CheckExitOtherItemInPurchaseLines(Rec);
        //<<MGTS10.037
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEventPurchaseLineNo(var Rec: Record "39"; var xRec: Record "39"; CurrFieldNo: Integer)
    begin
        //>>MGTS10.037
        IF CurrFieldNo <> Rec.FIELDNO("No.") THEN
            EXIT;

        IF Rec.Type <> Rec.Type::Item THEN
            EXIT;

        CheckExitOtherItemInPurchaseLines(Rec);
        //<<MGTS10.037
    end;

    local procedure CheckExitOtherItemInPurchaseLines(_PurchaseLine: Record "39")
    var
        PurchaseLine: Record "39";
        ExistOtherItemErr: Label 'The same item %1 already exists in the lines of %2 - %3.';
    begin
        //>>MGTS10.037
        IF NOT (_PurchaseLine."Document Type" IN [_PurchaseLine."Document Type"::Order, _PurchaseLine."Document Type"::Invoice]) THEN
            EXIT;

        PurchaseLine.SETRANGE("Document Type", _PurchaseLine."Document Type");
        PurchaseLine.SETRANGE("Document No.", _PurchaseLine."Document No.");
        PurchaseLine.SETFILTER("Line No.", '<>%1', _PurchaseLine."Line No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.", _PurchaseLine."No.");
        IF NOT PurchaseLine.ISEMPTY THEN
            ERROR(ExistOtherItemErr, _PurchaseLine."No.", _PurchaseLine."Document Type", _PurchaseLine."Document No.")
        //<<MGTS10.037
    end;
}

