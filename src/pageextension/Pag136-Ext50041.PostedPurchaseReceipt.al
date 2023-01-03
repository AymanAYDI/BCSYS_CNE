pageextension 50041 "BC6_PostedPurchaseReceipt" extends "Posted Purchase Receipt" //136
{
    layout
    {
        addafter("Vendor Order No.")
        {
            field("BC6_User ID"; "User ID")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action("BC6_Sent/Print")
            {
                Caption = '&Print', Comment = 'FRA="&Imprimer"';
                Image = SendMail;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            BEGIN
                                CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                                PurchRcptHeader.PrintRecords(TRUE);
                            END;
                        2:
                            EnvoiMail();
                    END;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('');
    end;

    var

        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text001: Label '';
        nameF: Text[250];

    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            ERASE(nameF);
        END
        ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail.Init();
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + "No.";
        HistMail.INSERT(TRUE);
    end;

    procedure OpenFile()
    begin
    end;
}

