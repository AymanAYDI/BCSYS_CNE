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
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        InsertPurchHeaderOk: Boolean;
        NewHeaderOk: Boolean;
        VendorNo: Code[20];
        Window: Dialog;
        NextLineNo: Integer;
        SalesLineNo: Integer;

        Text001: label 'Processing...  #1##########\', Comment = 'FRA="Traitement... #1###########\"';
        Text002: label 'Line No.       #3###########\', Comment = 'FRA="N° ligne       #2###########\"';
        Text003: label 'Purchase Header          #3##########\', Comment = 'FRA="Commande achat         #3###########\"';
        Text004: label 'Nothing to Post', Comment = 'FRA="Il n''y a rien à valider"';

    procedure "Code"()
    var
        Txt12: label '%1 %2';
    begin
        SalesSetup.GET();
        CLEAR(VendorNo);
        CLEAR(SalesLineNo);
        CLEAR(InsertPurchHeaderOk);

        Window.OPEN(Text001 +
                    Text002 +
                    Text003);

        SalesLine.SETCURRENTKEY("BC6_To Order", "BC6_Buy-from Vendor No.", "Document No.", "Line No.", "BC6_Qty. To Order");
        SalesLine.SETFILTER("BC6_Buy-from Vendor No.", '<>%1', '');
        SalesLine.SETFILTER("BC6_Qty. To Order", '<>%1', 0);
        SalesLine.SETRANGE("BC6_To Order", true);
        if not SalesLine.FINDFIRST() then
            ERROR(Text004);

        PurchLine.LOCKTABLE();
        if not SalesLine.RECORDLEVELLOCKING then
            PurchHeader.LOCKTABLE(true, true);
        SalesLine.LOCKTABLE();

        if SalesLine.FINDSET() then
            repeat

                Window.UPDATE(1, STRSUBSTNO(Txt12, SalesLine."Document Type", SalesLine."Document No."));
                Window.UPDATE(2, SalesLine."Line No.");

                SalesLine.TESTFIELD("BC6_Buy-from Vendor No.");
                SalesLine.TESTFIELD("BC6_Qty. To Order");
                SalesLine.TESTFIELD("BC6_To Order", true);

                NewHeaderOk := not (SalesLine."BC6_Buy-from Vendor No." = VendorNo);
                if NewHeaderOk then begin
                    FinalizePurchHeader(PurchHeader);
                    InsertPurchHeader(PurchHeader, SalesLine."BC6_Buy-from Vendor No.");
                    VendorNo := SalesLine."BC6_Buy-from Vendor No.";

                    NextLineNo := 10000;
                end;

                InsertPurchLine(SalesLine);

                SalesLine."BC6_Purch. Document Type" := SalesLine."BC6_Purch. Document Type"::Order;
                SalesLine."BC6_Purch. Order No." := PurchLine."Document No.";
                SalesLine."BC6_Purch. Line No." := PurchLine."Line No.";
                SalesLine."BC6_Purchase Receipt Date" := PurchLine."Expected Receipt Date";
                SalesLine."BC6_Qty. To Order" := 0;
                SalesLine."BC6_To Order" := false;
                SalesLine.MODIFY(false);

            until SalesLine.NEXT() = 0;
        FinalizePurchHeader(PurchHeader);

        Window.CLOSE();
    end;

    procedure InsertPurchHeader(var FromPurchHeader: Record "Purchase Header"; FromVendorNo: Code[20])
    begin
        // Insert Purchase Header
        FromPurchHeader.INIT();
        FromPurchHeader.VALIDATE("Document Type", FromPurchHeader."Document Type"::Order);
        FromPurchHeader.VALIDATE("No.", '');
        FromPurchHeader.INSERT(true);
        Window.UPDATE(3, FromPurchHeader."No.");

        FromPurchHeader.VALIDATE("Document Date", WORKDATE());
        FromPurchHeader.VALIDATE("Buy-from Vendor No.", FromVendorNo);
        FromPurchHeader.MODIFY(true);

        InsertPurchHeaderOk := true;
    end;

    procedure InsertPurchLine(var SaleLine: Record "Sales Line")
    begin
        // Insert Purchase Line
        PurchLine.INIT();
        PurchLine.VALIDATE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.VALIDATE("Document No.", PurchHeader."No.");
        PurchLine.VALIDATE("Line No.", NextLineNo);
        PurchLine.VALIDATE(Type, SaleLine.Type);
        PurchLine.VALIDATE("No.", SaleLine."No.");
        PurchLine.VALIDATE("Variant Code", SaleLine."Variant Code");
        PurchLine.VALIDATE("Location Code", SaleLine."Location Code");
        PurchLine.VALIDATE("Unit of Measure Code", SaleLine."Unit of Measure Code");
        if (PurchLine.Type = PurchLine.Type::Item) and (PurchLine."No." <> '') then
            PurchLine.UpdateUOMQtyPerStockQty();
        PurchLine.VALIDATE("Expected Receipt Date", SaleLine."Shipment Date");
        PurchLine.VALIDATE(Quantity, SaleLine."BC6_Qty. To Order");
        PurchLine.VALIDATE("Return Reason Code", SaleLine."Return Reason Code");
        PurchLine.VALIDATE("Direct Unit Cost", SaleLine."BC6_Purchase cost");
        PurchLine.VALIDATE("Purchasing Code", SaleLine."Purchasing Code");

        PurchLine.VALIDATE("BC6_Sales No.", SaleLine."Document No.");
        PurchLine.VALIDATE("BC6_Sales Line No.", SaleLine."Line No.");
        PurchLine.VALIDATE("BC6_Sales Document Type", SaleLine."Document Type");

        PurchLine.VALIDATE("Line Discount %", 0);
        PurchLine.INSERT(true);

        NextLineNo += 10000;
    end;

    procedure FinalizePurchHeader(FromPurchHeader: Record "Purchase Header")
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        Unconditionally: Boolean;
    begin
        if not InsertPurchHeaderOk then
            exit;

        Unconditionally := true;

        // Insert extended text
        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", FromPurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", FromPurchHeader."No.");
        if PurchLine.FINDSET() then
            repeat
                if TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, Unconditionally) then begin
                    COMMIT();
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    FunctionMgt.InsertPurchExtTextSpe(PurchLine);
                end;
            until PurchLine.NEXT() = 0;
        InsertPurchHeaderOk := false;
    end;
}

