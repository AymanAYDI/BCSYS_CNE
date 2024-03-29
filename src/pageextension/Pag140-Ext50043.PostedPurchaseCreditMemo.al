pageextension 50043 "BC6_PostedPurchaseCreditMemo" extends "Posted Purchase Credit Memo" //140
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("BC6_User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action("BC6_Envoyer/Imprimer")
            {
                ApplicationArea = All;
                Caption = 'Envoyer/Imprimer', comment = 'FRA="Envoyer/Imprimer"';
                image = SendToMultiple;
                trigger OnAction()
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            BEGIN
                                CurrPage.SETSELECTIONFILTER(PurchCrMemoHeader);
                                PurchCrMemoHeader.PrintRecords(TRUE);
                            END;
                        2:
                            EnvoiMail();
                    END;
                end;
            }
        }
    }

    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text001: label '';
        nameF: Text[250];

    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FindFirst() THEN
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
        HistMail.Init();
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + Rec."No.";
        HistMail.INSERT(TRUE);
    end;

    procedure OpenFile()
    begin
    end;
}
