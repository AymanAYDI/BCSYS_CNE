pageextension 50035 "BC6_PostedSalesShipment" extends "Posted Sales Shipment" //130
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Sell-to E-Mail Address"; Rec."BC6_Sell-to E-Mail Address")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Editable = false;
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
        addafter("F&unctions")
        {
            group("BC6_E&nvoyer/Imprimer")
            {
                Caption = 'Envoyer/Imprimer';
                action("BC6_Envoyer par E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Envoyer par E-Mail';
                    Image = SendEmailPDF;

                    trigger OnAction()
                    var
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
                        REPORT.SAVEASPDF(REPORT::"BC6_Sales - Shipment CNE", FileName, RecLPostSalesShpt);
                        ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);

                        IF RecLPostSalesShpt."Your Reference" <> '' THEN
                            Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,') + ' - ' + DELCHR((RecLPostSalesShpt."Your Reference"), '=', '/\:.,')
                        ELSE
                            Objet := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesShpt."No."), '=', '/\:.,');

                        Body := 'Chère Cliente, Cher Client' + '<br>' + '<br>' + 'Veuillez trouver ci-joint votre bon de livraison.' + '<br>' + '<br>' + 'Sincères salutations,' +
                                '<br>' + '<br>' + recGCompanyInfo.Name + '<br>' + recGCompanyInfo.Address + ' ' + recGCompanyInfo."Post Code" + ' ' + recGCompanyInfo.City + '<br>' + 'Tél : ' + recGCompanyInfo."Phone No." +
                                ' ' + '- Fax : ' + recGCompanyInfo."Fax No.";

                        cduMail.NewMessage(Rec."BC6_Sell-to E-Mail Address", '', '', Objet, Body, ToFile, TRUE);
                        FILE.ERASE(FileName);
                    end;
                }
                action("BC6_Envoyer par Fax")
                {
                    ApplicationArea = All;
                    Caption = 'Envoyer par Fax';
                    Image = SendTo;

                    trigger OnAction()
                    var
                        RecLPostSalesShpt: Record "Sales Shipment Header";
                    begin
                        RecLPostSalesShpt := Rec;
                        RecLPostSalesShpt.SETRECFILTER();
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
        recGCompanyInfo: Record "Company Information";
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        ReportHelper: Codeunit BC6_ReportHelper;
        cduMail: Codeunit Mail;
        Mail: Codeunit Mail;
        Text001: Label '';
        FileName: Text[250];
        nameF: Text[250];
        Objet: Text[250];
        ToFile: Text[250];
        Body: Text[1024];

    procedure EnvoiMail()
    begin
        SalesSetup.GET();
        HistMail.Init();
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
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
