codeunit 50006 "Create Purch. Order From Sales"
{
    // //>> CNE6.01
    // TDL:EC11 12.12.2014 : Not Group By Item

    TableNo = 37;

    trigger OnRun()
    begin
        SalesLine.COPYFILTERS(Rec);
        Code;
        Rec := SalesLine;
    end;

    var
        BooGExcDropShipFilter: Boolean;
        BooGExcQuoteFilter: Boolean;
        BooGNegForecastInv: Boolean;
        BooGExcShipOrders: Boolean;
        BooGOneTimeOrdering: Boolean;
        CodGVendorFilter: Code[20];
        TxtGShipmentDateFilter: Text[50];
        OptGSort: Option;
        "<<<PRODWARE>>>": Integer;
        Text001: Label 'Processing...  #1##########\';
        Text002: Label 'Line No.       #3###########\';
        Text003: Label 'Purchase Header          #3##########\';
        "CNE6.01": Integer;
        Window: Dialog;
        NewHeaderOk: Boolean;
        NewLineOk: Boolean;
        SalesSetup: Record "311";
        PurchHeader: Record "38";
        PurchLine: Record "39";
        SalesHeader: Record "36";
        SalesLine: Record "37";
        SalesLineTmp: Record "37" temporary;
        Text004: Label 'Nothing to Post';
        Item: Record "27";
        Vendor: Record "23";
        Purchasing: Record "5721";
        VendorNo: Code[20];
        SalesLineNo: Integer;
        NextLineNo: Integer;
        TotalQty: Decimal;
        InsertPurchHeaderOk: Boolean;

    [Scope('Internal')]
    procedure "Code"()
    begin
        SalesSetup.GET;
        // Init vars
        CLEAR(VendorNo);
        CLEAR(SalesLineNo);
        CLEAR(InsertPurchHeaderOk);

        Window.OPEN(Text001 +
                    Text002 +
                    Text003);

        WITH SalesLine DO BEGIN

            SETCURRENTKEY("To Order", "Buy-from Vendor No.", "Document No.", "Line No.", "Qty. To Order");
            SETFILTER("Buy-from Vendor No.", '<>%1', '');
            SETFILTER("Qty. To Order", '<>%1', 0);
            SETRANGE("To Order", TRUE);
            IF NOT FINDFIRST THEN
                ERROR(Text004);

            PurchLine.LOCKTABLE;
            IF NOT RECORDLEVELLOCKING THEN
                PurchHeader.LOCKTABLE(TRUE, TRUE);
            LOCKTABLE;

            IF FINDSET THEN
                REPEAT

                    Window.UPDATE(1, STRSUBSTNO('%1 %2', "Document Type", "Document No."));
                    Window.UPDATE(2, "Line No.");

                    TESTFIELD("Buy-from Vendor No.");
                    TESTFIELD("Qty. To Order");
                    TESTFIELD("To Order", TRUE);
                    // TESTFIELD(Type,Type::Item);

                    NewHeaderOk := NOT ("Buy-from Vendor No." = VendorNo);
                    IF NewHeaderOk THEN BEGIN
                        FinalizePurchHeader(PurchHeader);
                        InsertPurchHeader(PurchHeader, "Buy-from Vendor No.");
                        VendorNo := "Buy-from Vendor No.";

                        // Init vars
                        NextLineNo := 10000;
                    END;

                    InsertPurchLine(SalesLine);

                    // Modify Line
                    "Purch. Document Type" := "Purch. Document Type"::Order;
                    "Purch. Order No." := PurchLine."Document No.";
                    "Purch. Line No." := PurchLine."Line No.";
                    "Purchase Receipt Date" := PurchLine."Expected Receipt Date";
                    "Qty. To Order" := 0;
                    "To Order" := FALSE;
                    MODIFY(FALSE);

                UNTIL NEXT = 0;
            FinalizePurchHeader(PurchHeader);

        END;

        Window.CLOSE;
    end;

    [Scope('Internal')]
    procedure InsertPurchHeader(var FromPurchHeader: Record "38"; var FromVendorNo: Code[20])
    begin
        // Insert Purchase Header
        WITH FromPurchHeader DO BEGIN
            INIT;
            VALIDATE("Document Type", "Document Type"::Order);
            VALIDATE("No.", '');
            INSERT(TRUE);
            Window.UPDATE(3, FromPurchHeader."No.");

            VALIDATE("Document Date", WORKDATE);
            VALIDATE("Buy-from Vendor No.", FromVendorNo);
            MODIFY(TRUE);

            InsertPurchHeaderOk := TRUE;
        END;
    end;

    [Scope('Internal')]
    procedure InsertPurchLine(var SalesLine: Record "37")
    begin
        // Insert Purchase Line
        WITH PurchLine DO BEGIN
            INIT;
            VALIDATE("Document Type", "Document Type"::Order);
            VALIDATE("Document No.", PurchHeader."No.");
            VALIDATE("Line No.", NextLineNo);
            VALIDATE(Type, SalesLine.Type);
            VALIDATE("No.", SalesLine."No.");
            VALIDATE("Variant Code", SalesLine."Variant Code");
            VALIDATE("Location Code", SalesLine."Location Code");
            VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
            IF (Type = Type::Item) AND ("No." <> '') THEN
                UpdateUOMQtyPerStockQty;
            VALIDATE("Expected Receipt Date", SalesLine."Shipment Date");
            // RecLPurchLine.VALIDATE("Bin Code",RecLSalesLines."Bin Code");
            VALIDATE(Quantity, SalesLine."Qty. To Order");
            VALIDATE("Return Reason Code", SalesLine."Return Reason Code");
            VALIDATE("Direct Unit Cost", SalesLine."Purchase cost");
            VALIDATE("Purchasing Code", SalesLine."Purchasing Code");

            VALIDATE("Sales No.", SalesLine."Document No.");
            VALIDATE("Sales Line No.", SalesLine."Line No.");
            VALIDATE("Sales Document Type", SalesLine."Document Type");

            VALIDATE("Line Discount %", 0);
            INSERT(TRUE);

            NextLineNo += 10000;

        END;
    end;

    [Scope('Internal')]
    procedure FinalizePurchHeader(FromPurchHeader: Record "38")
    var
        TransferExtendedText: Codeunit "378";
        Unconditionally: Boolean;
    begin
        IF NOT InsertPurchHeaderOk THEN
            EXIT;

        Unconditionally := TRUE;

        // Insert extended text
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", FromPurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", FromPurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, Unconditionally) THEN BEGIN
                    COMMIT;
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    TransferExtendedText.InsertPurchExtTextSpe(PurchLine);
                END;
            UNTIL PurchLine.NEXT = 0;
        InsertPurchHeaderOk := FALSE;
    end;
}

