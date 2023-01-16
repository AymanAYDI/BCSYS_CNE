pageextension 50135 "BC6_PurchaseQuote" extends "Purchase Quote" //49
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field(BC6_ID; Rec.ID)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Contact No.")
        {
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Buy-from E-Mail Address"; Rec."BC6_Buy-from E-Mail Address")
            {
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Importance = Promoted;
        }
        addafter("Control5")
        {
            part("BC6_Purch His. By-From FactBox"; "BC6_Purch His. By-From FactBox")
            {
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                            "No." = FIELD("No."),
                            "Line No." = FIELD("Line No.");
            }
        }
    }
    actions
    {
        addafter("Make Order")
        {
            group(BC6_Print)
            {
                Caption = 'Print', comment = 'FRA="Envoyer/Imprimer"';
                Image = Administration;
                action(BC6_Imprimer)
                {
                    ApplicationArea = All;
                    Caption = 'Imprimer';
                    Image = PostPrint;
                    trigger OnAction()

                    begin
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("BC6_Envoyer par E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'FRA="Envoyer par E-Mail"';
                    Image = SendMail;
                    trigger OnAction()
                    var
                        RecLPurchQuote: Record "Purchase Header";
                        RptLPurchQuote: Report "BC6_Prices Request";

                    begin
                        RecLPurchQuote := Rec;
                        RecLPurchQuote.SETRECFILTER();
                        RptLPurchQuote.SETTABLEVIEW(RecLPurchQuote);
                        RptLPurchQuote.DefineTagMail(Rec."BC6_Buy-from E-Mail Address");
                        RptLPurchQuote.RUN();
                    end;
                }
                action("BC6_Envoyer par Fax")
                {
                    ApplicationArea = All;
                    Caption = 'Envoyer par Fax';
                    Image = SendTo;
                    trigger OnAction()
                    var
                        RecLPurchQuote: Record "Purchase Header";
                        RptLPurchQuote: Report "BC6_Prices Request";
                    begin
                        RecLPurchQuote := Rec;
                        RecLPurchQuote.SETRECFILTER();
                        RptLPurchQuote.SETTABLEVIEW(RecLPurchQuote);
                        RptLPurchQuote.DefineTagFax(Rec."BC6_Buy-from Fax No.");
                        RptLPurchQuote.RUN();
                    end;
                }
            }
        }
    }
    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;

        SalesSetup: Record "Sales & Receivables Setup";
        DocPrint: Codeunit "Document-Print";
        Mail: Codeunit Mail;
        Text001: Label '';
        TextDEMANDE_PRIX001: Label 'There are no items with cross reference: %1', comment = '"FRA=Il n''existe aucun article avec la référence externe %1."';
        nameF: Text[250];

    PROCEDURE GetQuotes(VAR PurchHeader: Record "Purchase Header");
    VAR
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        NextLineNo: Integer;
    BEGIN

        //DEMANDE_PRIX SOBH NSC1.01 [004] Prix sur cde de vente
        PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::Quote);

        SalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.");
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Quote);
        IF (PAGE.RUNMODAL(PAGE::"Sales List", SalesHeader) <> ACTION::LookupOK) OR
           (SalesHeader."No." = '')
        THEN
            EXIT;
        IF PurchHeader.RECORDLEVELLOCKING THEN
            PurchHeader.LOCKTABLE();
        SalesHeader.TESTFIELD("Document Type", SalesHeader."Document Type"::Quote);

        PurchLine.LOCKTABLE();
        IF NOT PurchHeader.RECORDLEVELLOCKING THEN
            PurchHeader.LOCKTABLE(TRUE, TRUE); // Only version check
        SalesLine.LOCKTABLE();
        IF NOT PurchHeader.RECORDLEVELLOCKING THEN
            SalesHeader.LOCKTABLE(TRUE, TRUE); // Only version check

        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Quote);
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FIND('+') THEN
            NextLineNo := PurchLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Quote);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Outstanding Quantity", '<>0');
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');

        IF SalesLine.FIND('-') THEN
            REPEAT
                PurchLine.INIT();
                PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := NextLineNo;
                CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, PurchLine);
                PurchLine.INSERT();
                NextLineNo := NextLineNo + 10000;

                IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, TRUE) THEN BEGIN
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
                    IF PurchLine2.FIND('+') THEN
                        NextLineNo := PurchLine2."Line No.";
                    NextLineNo := NextLineNo + 10000;
                END;
            UNTIL SalesLine.NEXT() = 0
        ELSE
            ERROR(
              TextDEMANDE_PRIX001,
              SalesHeader."No.");

        PurchHeader.MODIFY(); // Only version check
        SalesHeader.MODIFY(); // Only version check
    END;

    PROCEDURE GetOrders(VAR PurchHeader: Record "Purchase Header");
    VAR
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        NextLineNo: Integer;
    BEGIN
        //DEMANDE_PRIX SOBH NSC1.01 [004] Prix sur cde de vente
        PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::Quote);

        SalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.");
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        IF (PAGE.RUNMODAL(PAGE::"Sales List", SalesHeader) <> ACTION::LookupOK) OR
           (SalesHeader."No." = '')
        THEN
            EXIT;
        IF PurchHeader.RECORDLEVELLOCKING THEN
            PurchHeader.LOCKTABLE();
        SalesHeader.TESTFIELD("Document Type", SalesHeader."Document Type"::Order);

        PurchLine.LOCKTABLE();
        IF NOT PurchHeader.RECORDLEVELLOCKING THEN
            PurchHeader.LOCKTABLE(TRUE, TRUE); // Only version check
        SalesLine.LOCKTABLE();
        IF NOT PurchHeader.RECORDLEVELLOCKING THEN
            SalesHeader.LOCKTABLE(TRUE, TRUE); // Only version check

        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Quote);
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FIND('+') THEN
            NextLineNo := PurchLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Outstanding Quantity", '<>0');
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');

        IF SalesLine.FIND('-') THEN
            REPEAT
                PurchLine.INIT();
                PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := NextLineNo;
                CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, PurchLine);
                PurchLine.INSERT();
                NextLineNo := NextLineNo + 10000;

                IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, TRUE) THEN BEGIN
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
                    IF PurchLine2.FIND('+') THEN
                        NextLineNo := PurchLine2."Line No.";
                    NextLineNo := NextLineNo + 10000;
                END;
            UNTIL SalesLine.NEXT() = 0
        ELSE
            ERROR(
              TextDEMANDE_PRIX001,
              SalesHeader."No.");

        PurchHeader.MODIFY(); // Only version check
        SalesHeader.MODIFY(); // Only version check
    END;

    PROCEDURE OpenFile()
    begin
    end;

    PROCEDURE EnvoiMail();
    BEGIN
        SalesSetup.GET();
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
            ERASE(nameF);
        END
        ELSE BEGIN
            ERASE(SalesSetup."BC6_Repertoire" + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + Rec."No.";
        HistMail.INSERT(TRUE);
    END;
}