pageextension 50037 "BC6_PostedSalesInvoice" extends "Posted Sales Invoice" //132
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
                Enabled = false;
                ApplicationArea = All;
            }
            field("BC6_Sell-to E-Mail Address"; "BC6_Sell-to E-Mail Address")
            {
                Caption = 'Sell-to Customer E-Mail', Comment = 'FRA="E-Mail donneur d''ordre"';
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Shipment Invoiced"; "BC6_Shipment Invoiced")
            {
                ApplicationArea = All;
            }
            field("BC6_User ID"; "User ID")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Email)
        {
            action("BC6_Envoyer par E-Mail")
            {
                Caption = 'Envoyer par E-Mail';
                Image = SendMail;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecLPostSalesInv: Record "Sales Invoice Header";
                begin
                    RecLPostSalesInv := Rec;
                    RecLPostSalesInv.SETRECFILTER();
                    CLEAR(cduMail);
                    recGCompanyInfo.GET();

                    RecLPostSalesInv := Rec;
                    RecLPostSalesInv.SETRECFILTER();
                    ToFile := 'BON DE LIVRAISON CNE N° ' + DELCHR((RecLPostSalesInv."No."), '=', '/\:.,') + '.pdf';
                    FileName := TEMPORARYPATH + ToFile;
                    REPORT.SAVEASPDF(REPORT::"BC6_Sales - Invoice CNE", FileName, RecLPostSalesInv);
                    ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);

                    IF RecLPostSalesInv."Your Reference" <> '' THEN
                        Objet := 'FACTURE CNE N° ' + DELCHR((RecLPostSalesInv."No."), '=', '/\:.,') + ' - ' + DELCHR((RecLPostSalesInv."Your Reference"), '=', '/\:.,')
                    ELSE
                        Objet := 'FACTURE CNE N° ' + DELCHR((RecLPostSalesInv."No."), '=', '/\:.,');

                    Body := 'Chère Cliente, Cher Client' + '<br>' + '<br>' + 'Veuillez trouver ci-joint votre facture.' + '<br>' + '<br>' + 'Sincères salutations,' +
                            '<br>' + '<br>' + recGCompanyInfo.Name + '<br>' + recGCompanyInfo.Address + ' ' + recGCompanyInfo."Post Code" + ' ' + recGCompanyInfo.City + '<br>' + 'Tél : ' + recGCompanyInfo."Phone No." +
                            ' ' + '- Fax : ' + recGCompanyInfo."Fax No.";

                    cduMail.NewMessage("BC6_Sell-to E-Mail Address", '', '', Objet, Body, ToFile, FALSE);
                    FILE.ERASE(FileName);
                end;
            }
            action("BC6_Envoyer par Fax")
            {
                Caption = 'Envoyer par Fax';
                Image = SendElectronicDocument;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecLPostSalesShpt: Record "Sales Invoice Header";
                    "-MIGNAV2013-": Integer;
                begin
                    RecLPostSalesShpt := Rec;
                    RecLPostSalesShpt.SETRECFILTER();
                end;
            }
        }
    }

    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        recGCompanyInfo: Record "Company Information";
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        ReportHelper: Codeunit BC6_ReportHelper;
        cduMail: Codeunit Mail;
        Mail: Codeunit Mail;
        Excel: Boolean;
        Text001: Label '';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        FileName: Text[250];
        nameF: Text[250];
        Objet: Text[250];
        ToFile: Text[250];
        Body: Text[1024];


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
