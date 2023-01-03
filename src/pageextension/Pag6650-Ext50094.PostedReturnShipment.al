pageextension 50094 "BC6_PostedReturnShipment" extends "Posted Return Shipment" //6650
{
    layout
    {
        addafter("No. Printed")
        {
            field("BC6_User ID"; "User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Update Document")
        {
            separator(sep1)
            {
            }
            action("BC6_&Print")
            {
                Caption = '&Print', Comment = 'FRA="&Envoyer/Imprimer"';
                Ellipsis = true;
                Image = SendEmailPDF;

                trigger OnAction()
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            BEGIN
                                ReturnShptHeader := Rec;
                                CurrPage.SETSELECTIONFILTER(ReturnShptHeader);
                                ReturnShptHeader.PrintRecords(TRUE);
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
        ReturnShptHeader: Record "Return Shipment Header";
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        Excel: Boolean;
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text001: Label '';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
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

