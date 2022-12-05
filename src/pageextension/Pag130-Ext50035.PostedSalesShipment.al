pageextension 50035 "BC6_PostedSalesShipment" extends "Posted Sales Shipment" //130
{
    //DeleteAllowed = false; TODO:

    layout
    {
        addafter("Sell-to Contact")
        {
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Sell-to E-Mail Address"; "BC6_Sell-to E-Mail Address")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_User ID"; "User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group("BC6_E&nvoyer/Imprimer")
            {
                Caption = 'E&nvoyer/Imprimer';
            }
        }
        addfirst("BC6_E&nvoyer/Imprimer")
        {
            action("BC6_Envoyer par E-Mail")
            {
                Caption = 'Envoyer par E-Mail';
                ApplicationArea = All;

                trigger OnAction()
                var
                    "-MIGNAV2013-": Integer;
                    RecLPostSalesShpt: Record "Sales Shipment Header";
                begin
                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER();
                    CLEAR(cduMail);
                    recGCompanyInfo.GET();

                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER();
                    ToFile := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,') + '.pdf';
                    FileName := TEMPORARYPATH + ToFile;
                    // REPORT.SAVEASPDF(REPORT::"Sales - Shipment CNE", FileName, RecLPostSalesShpt); TODO:
                    // ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile); TODO:

                    IF RecLPostSalesShpt."Your Reference" <> '' THEN
                        Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,') + ' - ' + DELCHR((RecLPostSalesShpt."Your Reference"), '=', '/\:.,')
                    ELSE
                        Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,');

                    Body := 'Chère Cliente, Cher Client' + '<br>' + '<br>' + 'Veuillez trouver ci-joint votre bon de livraison.' + '<br>' + '<br>' + 'Sincères salutations,' +
                            '<br>' + '<br>' + recGCompanyInfo.Name + '<br>' + recGCompanyInfo.Address + ' ' + recGCompanyInfo."Post Code" + ' ' + recGCompanyInfo.City + '<br>' + 'Tél : ' + recGCompanyInfo."Phone No." +
                            ' ' + '- Fax : ' + recGCompanyInfo."Fax No.";

                    cduMail.NewMessage("BC6_Sell-to E-Mail Address", '', '', Objet, Body, ToFile, TRUE);
                    FILE.ERASE(FileName);
                end;
            }
            action("BC6_Envoyer par Fax")
            {
                Caption = 'Envoyer par Fax';
                ApplicationArea = All;

                trigger OnAction()
                var
                    "-MIGNAV2013-": Integer;
                    RecLPostSalesShpt: Record "Sales Shipment Header";
                begin
                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER();
                end;
            }
        }
    }

    var
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: Label '';
        "-MIGNAV2013-": Integer;
        DocPrint: Codeunit "Document-Print";
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        nameF: Text[250];
        Mail: Codeunit Mail;
        SalesSetup: Record "Sales & Receivables Setup";
        Excel: Boolean;
        "-CNE-": Integer;
        cduMail: Codeunit Mail;
        FileName: Text[250];
        ToFile: Text[250];
        Objet: Text[250];
        Body: Text[1024];
        recGCompanyInfo: Record "Company Information";
    // ReportHelper: Codeunit 50010; TODO:

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure EnvoiMail()
    begin
        SalesSetup.GET();
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
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