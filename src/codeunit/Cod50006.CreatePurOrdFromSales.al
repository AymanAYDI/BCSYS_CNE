codeunit 50006 "BC6_Create Pur. Ord From Sales"
{

    TableNo = "Sales Line";

    trigger OnRun()
    begin
        SalesLine.COPYFILTERS(Rec);
        Code();
        Rec := SalesLine;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";

        Text001: Label 'Processing...  #1##########\';
        Text002: Label 'Line No.       #3###########\';
        Text003: Label 'Purchase Header          #3##########\';
        Window: Dialog;
        NewHeaderOk: Boolean;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
        Text004: Label 'Nothing to Post';
        VendorNo: Code[20];
        SalesLineNo: Integer;
        NextLineNo: Integer;
        InsertPurchHeaderOk: Boolean;


    procedure "Code"()
    begin
        SalesSetup.GET();
        CLEAR(VendorNo);
        CLEAR(SalesLineNo);
        CLEAR(InsertPurchHeaderOk);

        Window.OPEN(Text001 +
                    Text002 +
                    Text003);

        WITH SalesLine DO BEGIN

            SETCURRENTKEY("BC6_To Order", "BC6_Buy-from Vendor No.", "Document No.", "Line No.", "BC6_Qty. To Order");
            SETFILTER("BC6_Buy-from Vendor No.", '<>%1', '');
            SETFILTER("BC6_Qty. To Order", '<>%1', 0);
            SETRANGE("BC6_To Order", TRUE);
            IF NOT FINDFIRST() THEN
                ERROR(Text004);

            PurchLine.LOCKTABLE();
            IF NOT RECORDLEVELLOCKING THEN
                PurchHeader.LOCKTABLE(TRUE, TRUE);
            LOCKTABLE();

            IF FINDSET() THEN
                REPEAT

                    Window.UPDATE(1, STRSUBSTNO('%1 %2', "Document Type", "Document No."));
                    Window.UPDATE(2, "Line No.");

                    TESTFIELD("BC6_Buy-from Vendor No.");
                    TESTFIELD("BC6_Qty. To Order");
                    TESTFIELD("BC6_To Order", TRUE);

                    NewHeaderOk := NOT ("BC6_Buy-from Vendor No." = VendorNo);
                    IF NewHeaderOk THEN BEGIN
                        FinalizePurchHeader(PurchHeader);
                        InsertPurchHeader(PurchHeader, "BC6_Buy-from Vendor No.");
                        VendorNo := "BC6_Buy-from Vendor No.";

                        NextLineNo := 10000;
                    END;

                    InsertPurchLine(SalesLine);

                    "BC6_Purch. Document Type" := "BC6_Purch. Document Type"::Order;
                    "BC6_Purch. Order No." := PurchLine."Document No.";
                    "BC6_Purch. Line No." := PurchLine."Line No.";
                    "BC6_Purchase Receipt Date" := PurchLine."Expected Receipt Date";
                    "BC6_Qty. To Order" := 0;
                    "BC6_To Order" := FALSE;
                    MODIFY(FALSE);

                UNTIL NEXT() = 0;
            FinalizePurchHeader(PurchHeader);

        END;

        Window.CLOSE();
    end;


    procedure InsertPurchHeader(var FromPurchHeader: Record "Purchase Header"; var FromVendorNo: Code[20])
    begin
        // Insert Purchase Header
        WITH FromPurchHeader DO BEGIN
            INIT();
            VALIDATE("Document Type", "Document Type"::Order);
            VALIDATE("No.", '');
            INSERT(TRUE);
            Window.UPDATE(3, FromPurchHeader."No.");

            VALIDATE("Document Date", WORKDATE());
            VALIDATE("Buy-from Vendor No.", FromVendorNo);
            MODIFY(TRUE);

            InsertPurchHeaderOk := TRUE;
        END;
    end;


    procedure InsertPurchLine(var SalesLine: Record "Sales Line")
    begin
        // Insert Purchase Line
        WITH PurchLine DO BEGIN
            INIT();
            VALIDATE("Document Type", "Document Type"::Order);
            VALIDATE("Document No.", PurchHeader."No.");
            VALIDATE("Line No.", NextLineNo);
            VALIDATE(Type, SalesLine.Type);
            VALIDATE("No.", SalesLine."No.");
            VALIDATE("Variant Code", SalesLine."Variant Code");
            VALIDATE("Location Code", SalesLine."Location Code");
            VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
            IF (Type = Type::Item) AND ("No." <> '') THEN
                UpdateUOMQtyPerStockQty();
            VALIDATE("Expected Receipt Date", SalesLine."Shipment Date");
            VALIDATE(Quantity, SalesLine."BC6_Qty. To Order");
            VALIDATE("Return Reason Code", SalesLine."Return Reason Code");
            VALIDATE("Direct Unit Cost", SalesLine."BC6_Purchase cost");
            VALIDATE("Purchasing Code", SalesLine."Purchasing Code");

            VALIDATE("BC6_Sales No.", SalesLine."Document No.");
            VALIDATE("BC6_Sales Line No.", SalesLine."Line No.");
            VALIDATE("BC6_Sales Document Type", SalesLine."Document Type");

            VALIDATE("Line Discount %", 0);
            INSERT(TRUE);

            NextLineNo += 10000;

        END;
    end;


    procedure FinalizePurchHeader(FromPurchHeader: Record "Purchase Header")
    var
        //TODO  TransferExtendedText: Codeunit "Transfer Extended Text";
        Unconditionally: Boolean;
    begin
        IF NOT InsertPurchHeaderOk THEN
            EXIT;

        Unconditionally := TRUE;

        // Insert extended text
        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", FromPurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", FromPurchHeader."No.");
        IF PurchLine.FINDSET() THEN
            REPEAT
            //TODO IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, Unconditionally) THEN BEGIN
            //     COMMIT();
            //     TransferExtendedText.InsertPurchExtText(PurchLine);
            //     TransferExtendedText.InsertPurchExtTextSpe(PurchLine);
            // END;
            UNTIL PurchLine.NEXT() = 0;
        InsertPurchHeaderOk := FALSE;
    end;
}

