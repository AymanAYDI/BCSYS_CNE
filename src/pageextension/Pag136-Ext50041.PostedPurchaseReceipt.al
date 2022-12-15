pageextension 50041 "BC6_PostedPurchaseReceipt" extends "Posted Purchase Receipt" //136
{
    layout
    {
        addafter("Vendor Order No.")
        {
            field("BC6_User ID"; "User ID")
            {
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action("BC6_Sent/Print")
            {
                Caption = '&Print';
                Image = SendMail;

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

        PurchRcptHeader: Record "Purch. Rcpt. Header";
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        "-MIGNAV2013-": Integer;
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        Mail: Codeunit Mail;
        nameF: Text[250];
        Excel: Boolean;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: Label '';

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

