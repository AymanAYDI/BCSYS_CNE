pageextension 50016 "BC6_SalesCreditMemo" extends "Sales Credit Memo" //44
{
    layout
    {
        addafter("No.")
        {
            field(BC6_ID; ID)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Reason Code"; "Reason Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Sell-to Customer No."; "Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        modify(TestReport)
        {
            Visible = false;
        }
        addafter(TestReport)
        {
            action(BC6_TestReport)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Report', Comment = 'FRA="Impression test"';
                Ellipsis = true;
                Enabled = "No." <> '';
                Image = TestReport;
                ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                trigger OnAction()
                var
                    ReportPrint: Codeunit "Test Report-Print";
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            ReportPrint.PrintSalesHeader(Rec);
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
        Salessetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        STR3: Label 'Imprimer lme document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        Text001: Label '';
        nameF: Text[250];



    procedure EnvoiMail()
    begin
        Salessetup.GET();
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(Salessetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
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

    procedure OpenFile1(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260]
    begin
    end;
}

