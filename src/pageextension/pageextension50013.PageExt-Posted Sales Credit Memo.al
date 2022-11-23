pageextension 50013 pageextension50013 extends "Posted Sales Credit Memo"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Sales Credit Memo"(Page 134)".

    layout
    {
        addafter("Control 95")
        {
            field("Sell-to E-Mail Address"; "Sell-to E-Mail Address")
            {
                Caption = 'Sell-to Customer E-Mail';
                Editable = false;
            }
        }
        addafter("Control 84")
        {
            field("User ID"; "User ID")
            {
            }
            field("Affair No."; "Affair No.")
            {
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Action 51")
        {
            group("E&nvoyer/Imprimer")
            {
                Caption = 'E&nvoyer/Imprimer';
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        SalesShptHeader.PrintRecords(TRUE);
                    end;
                }
                action("Envoyer par E-Mail")
                {
                    Caption = 'Envoyer par E-Mail';

                    trigger OnAction()
                    var
                        "-MIGNAV2013-": Integer;
                        RecLSalesCrMemoHeader: Record "114";
                    begin
                        //>>MIGRATION NAV 2013

                        RecLSalesCrMemoHeader := Rec;
                        RecLSalesCrMemoHeader.SETRECFILTER;
                        /*
                        RptLPrintCrMemo.SETTABLEVIEW(RecLSalesCrMemoHeader);
                        RptLPrintCrMemo.DefineTagMail("Sell-to E-Mail Address");
                        RptLPrintCrMemo.RUN;
                        */
                        //<<MIGRATION NAV 2013

                    end;
                }
                action("Envoyer par Fax")
                {
                    Caption = 'Envoyer par Fax';

                    trigger OnAction()
                    var
                        "-MIGNAV2013-": Integer;
                        RecLSalesCrMemoHeader: Record "114";
                    begin
                        //>>MIGRATION NAV 2013

                        RecLSalesCrMemoHeader := Rec;
                        RecLSalesCrMemoHeader.SETRECFILTER;
                        /*
                        RptLPrintCrMemo.SETTABLEVIEW(RecLSalesCrMemoHeader);
                        RptLPrintCrMemo.DefineTagFax("Sell-to Fax No.");
                        RptLPrintCrMemo.RUN;
                        */
                        //<<MIGRATION NAV 2013

                    end;
                }
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        DocPrint: Codeunit "229";
        HistMail: Record "99003";
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        SalesSetup: Record "311";
        Excel: Boolean;
        "--MIGNAV2013--": ;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: ;
        SalesShptHeader: Record "110";

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure EnvoiMail()
    begin
        //>>MIGRATION NAV 2013

        //EMAIL NSC00.01 SBH [005] Envoi document
        SalesSetup.GET;
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile;
        IF nameF <> '' THEN BEGIN
            //MIG 2017 >>
            //Mail.NewMessage(cust."E-Mail",'',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            //MIG 2017 <<
            ERASE(nameF);
        END ELSE BEGIN
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

        //<<MIGRATION NAv 2013
    end;

    procedure OpenFile()
    begin
        //>>MIGRATION NAV 2013

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
        //<<MIGRATION NAv 2013

    end;
}

