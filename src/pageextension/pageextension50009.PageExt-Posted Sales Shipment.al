pageextension 50009 pageextension50009 extends "Posted Sales Shipment"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Sales Shipment"(Page 130)".

    layout
    {
        addafter("Control 60")
        {
            field("Sell-to Fax No."; "Sell-to Fax No.")
            {
                Editable = false;
            }
            field("Sell-to E-Mail Address"; "Sell-to E-Mail Address")
            {
                Editable = false;
            }
        }
        addafter("Control 89")
        {
            field("User ID"; "User ID")
            {
                Editable = false;
            }
            field("Affair No."; "Affair No.")
            {
                Editable = false;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (Level) on "Action 49".

        addafter("Action 74")
        {
            group("E&nvoyer/Imprimer")
            {
                Caption = 'E&nvoyer/Imprimer';
            }
        }
        addfirst("Action 49")
        {
            action("Envoyer par E-Mail")
            {
                Caption = 'Envoyer par E-Mail';

                trigger OnAction()
                var
                    "-MIGNAV2013-": Integer;
                    RecLPostSalesShpt: Record "110";
                begin
                    //>>MIGRATION NAV 2013
                    //>>FE005 MICO
                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER;
                    /*
                    RptLSalesShpt.SETTABLEVIEW(RecLPostSalesShpt);
                    RptLSalesShpt.DefineTagMail("Sell-to E-Mail Address");
                    RptLSalesShpt.RUN;
                    */
                    //<<MIGRATION NAV 2013

                    //MIGRATION 2013
                    CLEAR(cduMail);
                    recGCompanyInfo.GET();

                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER;
                    ToFile := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,') + '.pdf';
                    FileName := TEMPORARYPATH + ToFile;
                    REPORT.SAVEASPDF(REPORT::"Sales - Shipment CNE", FileName, RecLPostSalesShpt);
                    ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);

                    IF RecLPostSalesShpt."Your Reference" <> '' THEN
                        Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,') + ' - ' + DELCHR((RecLPostSalesShpt."Your Reference"), '=', '/\:.,')
                    ELSE
                        Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,');

                    Body := 'Chère Cliente, Cher Client' + '<br>' + '<br>' + 'Veuillez trouver ci-joint votre bon de livraison.' + '<br>' + '<br>' + 'Sincères salutations,' +
                            '<br>' + '<br>' + recGCompanyInfo.Name + '<br>' + recGCompanyInfo.Address + ' ' + recGCompanyInfo."Post Code" + ' ' + recGCompanyInfo.City + '<br>' + 'Tél : ' + recGCompanyInfo."Phone No." +
                            ' ' + '- Fax : ' + recGCompanyInfo."Fax No.";

                    //MIG 2017 >>
                    //cduMail.NewMessage("Sell-to E-Mail Address",'',Objet,Body,ToFile,TRUE);
                    cduMail.NewMessage("Sell-to E-Mail Address", '', '', Objet, Body, ToFile, TRUE);
                    //MIG 2017 <<
                    FILE.ERASE(FileName);

                    //MIGRATION 2013

                end;
            }
            action("Envoyer par Fax")
            {
                Caption = 'Envoyer par Fax';

                trigger OnAction()
                var
                    "-MIGNAV2013-": Integer;
                    RecLPostSalesShpt: Record "110";
                begin

                    //>>MIGRATION NAV 2013

                    //>>FE005 MICO
                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER;
                    /*
                    RptLSalesShpt.SETTABLEVIEW(RecLPostSalesShpt);
                    RptLSalesShpt.DefineTagFax("Sell-to Fax No.");
                    RptLSalesShpt.RUN;
                    */
                    //<<MIGRATION NAV 2013

                end;
            }
        }
    }

    var
        "--MIGNAV2013--": ;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: ;
        "-MIGNAV2013-": Integer;
        DocPrint: Codeunit "229";
        HistMail: Record "99003";
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        SalesSetup: Record "311";
        Excel: Boolean;
        "-CNE-": Integer;
        cduMail: Codeunit "397";
        FileName: Text[250];
        ToFile: Text[250];
        Objet: Text[250];
        Body: Text[1024];
        recGCompanyInfo: Record "79";
        ReportHelper: Codeunit "50010";

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

