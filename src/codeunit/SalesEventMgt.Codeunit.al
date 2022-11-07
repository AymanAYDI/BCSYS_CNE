codeunit 50058 "Sales Event Mgt."
{
    // MGTS10.033 :  11.02.2022  Create codeunit
    // MGTS10.034 :  15.02.2022  Add function : UpdateSalesOrderPrices
    // MGTS10.037 :  26.07.2022  Add Events : OnAfterInsertEventSalesLine
    //                                        OnAfterModifyEventSalesLine
    //                                        OnAfterValidateEventSalesLineNo
    //                           Add Function : CheckExitOtherItemInSalesLines
    // MGTS10.040 | 05.09.2022 | Update Events : OnValidateSalesHeaderBillToCustomer  add "Document Type"::"Credit Memo"
    //                                           OnValidateSalesHeaderSellToCustomer
    //                                           Automatic Linked Shipment


    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderBillToCustomer(var Rec: Record "36"; var xRec: Record "36"; CurrFieldNo: Integer)
    var
        Customer: Record "18";
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo"]) THEN //>>MGTS10.040
            EXIT;
        IF (Rec."Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Bill-to Customer No.") THEN
                EXIT;
            Rec."Mention Under Total" := Customer."Mention Under Total";
            Rec."Amount Mention Under Total" := Customer."Amount Mention Under Total";
        END;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderSellToCustomer(var Rec: Record "36"; var xRec: Record "36"; CurrFieldNo: Integer)
    var
        Customer: Record "18";
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo"]) THEN //>>MGTS10.040
            EXIT;
        IF (Rec."Sell-to Customer No." <> xRec."Sell-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Sell-to Customer No.") THEN
                EXIT;
            Rec."Mention Under Total" := Customer."Mention Under Total";
            Rec."Amount Mention Under Total" := Customer."Amount Mention Under Total";
        END;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventSalesLine(var Rec: Record "37"; RunTrigger: Boolean)
    begin
        //>>MGTS10.037
        /*
        IF NOT RunTrigger THEN
          EXIT;
        
        IF Rec.ISTEMPORARY THEN
          EXIT;
        
        CheckExitOtherItemInSalesLines(Rec);
        */
        //<<MGTS10.037

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventSalesLine(var Rec: Record "37"; var xRec: Record "37"; RunTrigger: Boolean)
    begin
        //>>MGTS10.037
        /*
        IF NOT RunTrigger THEN
          EXIT;
        
        IF Rec.ISTEMPORARY THEN
          EXIT;
        
        
        CheckExitOtherItemInSalesLines(Rec);
        */
        //<<MGTS10.037

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEventSalesLineNo(var Rec: Record "37"; var xRec: Record "37"; CurrFieldNo: Integer)
    begin
        //>>MGTS10.037
        IF CurrFieldNo <> Rec.FIELDNO("No.") THEN
            EXIT;

        IF Rec.Type <> Rec.Type::Item THEN
            EXIT;

        IF (Rec."No." = xRec."No.") OR (Rec."No." = '') THEN
            EXIT;

        CheckExitOtherItemInSalesLines(Rec);
        //<<MGTS10.037
    end;

    [Scope('Internal')]
    procedure UpdateSalesOrderPrices(SalesHeader: Record "36")
    var
        SalesLine: Record "37";
        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        PriceCalcMgt: Codeunit "7000";
        Win: Dialog;
        UpdatePricesInProgress: Label 'Updating prices...';
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
    begin
        IF NOT CONFIRM(CofirmMessage) THEN
            EXIT;
        SalesHeader.TESTFIELD(Status, SalesHeader.Status::Open);
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.ISEMPTY THEN
            ERROR(NothingToHandleErr);
        IF GUIALLOWED THEN
            Win.OPEN(UpdatePricesInProgress);
        SalesLine.FINDSET;
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
            PriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, SalesLine.FIELDNO(Quantity));
            SalesLine.VALIDATE("Unit Price");
            SalesLine.MODIFY(TRUE);
        UNTIL SalesLine.NEXT = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;

    local procedure CheckExitOtherItemInSalesLines(_SalesLine: Record "37")
    var
        SalesLine: Record "37";
        ExistOtherItemErr: Label 'The same item %1 already exists in the lines of %2 - %3. Do you want to continue?';
    begin
        //>>MGTS10.037
        IF NOT GUIALLOWED THEN
            EXIT;
        IF NOT (_SalesLine."Document Type" IN [_SalesLine."Document Type"::Order, _SalesLine."Document Type"::Invoice]) THEN
            EXIT;

        SalesLine.SETRANGE("Document Type", _SalesLine."Document Type");
        SalesLine.SETRANGE("Document No.", _SalesLine."Document No.");
        SalesLine.SETFILTER("Line No.", '<>%1', _SalesLine."Line No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", _SalesLine."No.");
        IF NOT SalesLine.ISEMPTY THEN
            IF NOT CONFIRM(ExistOtherItemErr, FALSE, _SalesLine."No.", _SalesLine."Document Type", _SalesLine."Document No.") THEN
                ERROR('');
        //<<MGTS10.037
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopySalesDocument', '', false, false)]
    [Scope('Internal')]
    procedure OnAfterCopySalesDocument(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToSalesHeader: Record "36")
    var
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        DealShipmentSelection: Record "50031";
        Deal: Record "50020";
        DealShipment: Record "50030";
    begin
        //>>MGTS10.040
        IF (FromDocumentType = SalesDocType::"Posted Invoice") AND (ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::"Credit Memo") THEN
            LinkedShipment(FromDocumentNo, ToSalesHeader);
        //<<MGTS10.040
    end;

    local procedure LinkedShipment(FromDocumentNo: Code[20]; ToSalesHeader: Record "36")
    var
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        DealShipmentSelection: Record "50031";
        Deal: Record "50020";
        DealShipment: Record "50030";
    begin
        //on cherche si des lignes ont déjà été générée pour cette facture
        DealShipmentSelection.RESET();
        DealShipmentSelection.SETRANGE(DealShipmentSelection."Document No.", ToSalesHeader."No.");
        DealShipmentSelection.SETRANGE("Document Type", DealShipmentSelection."Document Type"::"Sales Cr. Memo");
        DealShipmentSelection.DELETEALL();

        //Lister les deal, puis les livraisons qui y sont rattachées
        Deal.RESET();
        Deal.SETFILTER(Status, '<>%1', Deal.Status::Closed);
        IF Deal.FIND('-') THEN
            REPEAT
                DealShipment.RESET();
                DealShipment.SETRANGE(Deal_ID, Deal.ID);
                DealShipment.SETRANGE("Sales Invoice No.", FromDocumentNo);
                IF DealShipment.FINDFIRST THEN BEGIN
                    DealShipmentSelection.INIT();
                    DealShipmentSelection."Document Type" := DealShipmentSelection."Document Type"::"Sales Cr. Memo";
                    DealShipmentSelection."Document No." := ToSalesHeader."No.";
                    DealShipmentSelection.Deal_ID := Deal.ID;
                    DealShipmentSelection."Shipment No." := DealShipment.ID;
                    DealShipmentSelection.USER_ID := USERID;
                    DealShipmentSelection."BR No." := DealShipment."BR No.";
                    DealShipmentSelection."Purchase Invoice No." := DealShipment."Purchase Invoice No.";
                    DealShipmentSelection."Sales Invoice No." := DealShipment."Sales Invoice No.";
                    DealShipmentSelection.Checked := TRUE;
                    DealShipmentSelection.INSERT();
                END;
            UNTIL (Deal.NEXT() = 0);
    end;
}

