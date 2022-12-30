pageextension 50015 "BC6_SalesInvoice" extends "Sales Invoice" //43
{
    layout
    {

        addafter("Sell-to Contact No.")
        {
            field(BC6_ID; Rec.ID)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact No.")
        {
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("BC6_Reason Code"; "Reason Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    FnctGOnAvterValidateReasonCode();
                end;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
        }
        addfirst(Control205)
        {
            field("BC6_Bill-to Customer No."; "Bill-to Customer No.")
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
                Caption = 'Post and New';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category5;
                ShortCutKey = 'Alt+F9';
                ToolTip = 'Post the sales document and create a new, empty one.';

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
        Excel: Boolean;
        STR3: Label 'Imprimer lme document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        Text001: Label '';
        Text004: Label '';
        nameF: Text[250];



    procedure FnctGOnAvterValidateReasonCode()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    procedure "--Functions_NSC1.01--"()
    begin
    end;

    procedure EnvoiMail()
    begin
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

    procedure OpenFile1(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260]
    begin
    end;
}

