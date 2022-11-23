pageextension 50098 pageextension50098 extends "Posted Return Shipment"
{
    layout
    {
        addafter("Control 20")
        {
            field("User ID"; "User ID")
            {
            }
        }
    }
    actions
    {
        addafter("Action 49")
        {
            separator()
            {
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = SendEmailPDF;

                trigger OnAction()
                begin

                    //EMAIL NSC00.01  SBH [005] Envoi document Par Email
                    //DocPrint.PrintSalesHeader(Rec);
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        //1:DocPrint.PrintSalesHeader(Rec);
                        1:
                            BEGIN
                                CurrPage.SETSELECTIONFILTER(ReturnShptHeader);
                                ReturnShptHeader.PrintRecords(TRUE);
                            END;
                        2:
                            EnvoiMail;
                    END;
                    //Fin EMAIL NSC00.01 SBH [005] Envoi document Par Email
                end;
            }
        }
    }

    var
        "- MIGNAV2013 -": Integer;
        ReportPrint: Codeunit "228";
        UserMgt: Codeunit "5700";
        DocPrint: Codeunit "229";
        ArchiveManagement: Codeunit "5063";
        HistMail: Record "99003";
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        SalesSetup: Record "311";
        Excel: Boolean;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: ;

    procedure EnvoiMail()
    begin
        //EMAIL NSC00.01 SBH [005] Envoi document
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile;
        IF nameF <> '' THEN BEGIN
            //MIG 2017
            //Mail.NewMessage(cust."E-Mail",'',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            //MIG 2017
            ERASE(nameF);
        END
        ELSE BEGIN
            ERASE(SalesSetup.Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + "No.";
        HistMail.INSERT(TRUE);
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
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

