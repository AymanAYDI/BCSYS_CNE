pageextension 50039 "BC6_PostedSalesCreditMemo" extends "Posted Sales Credit Memo" //134
{

    layout
    {
        addafter("Sell-to Contact No.")
        {
            field("BC6_Sell-to E-Mail Address"; Rec."BC6_Sell-to E-Mail Address")
            {
                Caption = 'Sell-to Customer E-Mail', Comment = 'FRA="E-Mail donneur d''ordre"';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            group("BC6_E&nvoyer/Imprimer")
            {
                Caption = 'E&nvoyer/Imprimer';
                action("BC6_&Print")
                {
                    Caption = '&Print', Comment = 'FRA="&Imprimer"';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        SalesShptHeader.PrintRecords(TRUE);
                    end;
                }
                action("BC6_Envoyer par E-Mail")
                {
                    Caption = 'Envoyer par E-Mail';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        RecLSalesCrMemoHeader := Rec;
                        RecLSalesCrMemoHeader.SETRECFILTER();
                    end;
                }
                action("BC6_Envoyer par Fax")
                {
                    Caption = 'Envoyer par Fax';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        RecLSalesCrMemoHeader := Rec;
                        RecLSalesCrMemoHeader.SETRECFILTER();
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
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShptHeader: Record "Sales Shipment Header";
        Mail: Codeunit Mail;
        Text001: Label '';
        nameF: Text[250];



    procedure EnvoiMail()
    begin
        SalesSetup.GET();
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FindSet() THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail.Init();
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
