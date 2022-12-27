pageextension 50042 "BC6_PostedPurchaseInvoice" extends "Posted Purchase Invoice" //138
{

    layout
    {
        addafter(Corrective)
        {
            field("BC6_User ID"; "User ID")
            {
                ApplicationArea = All;
            }
            field("BC6_Affaire No."; "BC6_Affaire No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            group("BC6_&Print_group")
            {
                action("BC6_&Print")
                {
                    Caption = '&Print';
                    Image = print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                            1:
                                BEGIN
                                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                                    PurchInvHeader.PrintRecords(TRUE);
                                END;
                            2:
                                EnvoiMail();
                        END;
                    end;
                }
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
        PurchInvHeader: Record "Purch. Inv. Header";
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
        /*//EMAIL NSC00.01 SBH [005] Envoi document
        FileDialog.DialogTitle('Envoi'+' '+CurrForm.CAPTION);
        FileDialog.Filter := Text004;
        SalesSetup.GET;
        FileDialog.FileName := '';
        FileDialog.InitDir(SalesSetup.Repertoire);
        FileDialog.Flags := 4096 + 2048; // vérification de l'existence du fichier, code qui suit inutile.
        FileDialog.ShowOpen;
        nameF:=FileDialog.FileName;
        IF nameF='' THEN
          BEGIN
            Excel := FALSE;
            EXIT;
          END;
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
        */

    end;
}

