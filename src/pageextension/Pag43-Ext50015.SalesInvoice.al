pageextension 50015 "BC6_SalesInvoice" extends "Sales Invoice" //43
{
    layout
    {

        addafter("Sell-to Contact No.")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact No.")
        {
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("BC6_Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    FnctGOnAvterValidateReasonCode();
                end;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
        }
        addfirst(Control205)
        {
            field("BC6_Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(WorkflowStatus)
        {
            part("BC6_Sales Hist. Sellto FactBox"; "BC6_Sales Hist. Sellto FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(PostAndNew)
        {
            Visible = false;
        }

        addafter(PostAndNew)
        {
            action(BC6_PostAndNew2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post and New', Comment = 'FRA="Valider et Créer"';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category5;
                ShortCutKey = 'Alt+F9';

                trigger OnAction()
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            CallPostDocument(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"New Document");
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
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        STR3: Label 'Imprimer lme document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        Text001: Label '';
        nameF: Text[250];



    procedure FnctGOnAvterValidateReasonCode()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    procedure EnvoiMail()
    begin
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

    procedure OpenFile1(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260]
    begin
    end;
}

