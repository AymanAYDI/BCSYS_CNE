pageextension 50060 pageextension50060 extends "Sales Credit Memo"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on "Control 2".

        addafter("Control 2")
        {
            field(ID; ID)
            {
                Editable = false;
            }
            field("Sell-to Fax No."; "Sell-to Fax No.")
            {
            }
            field("Reason Code"; "Reason Code")
            {

                trigger OnValidate()
                begin
                    //>>MIGRATION NAV 2013

                    //<<DEEE1.00
                    CurrPage.UPDATE(TRUE);
                    //>>DEEE1.00
                    //<<MIGRATION NAV 2013
                end;
            }
            field("Affair No."; "Affair No.")
            {
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "TestReport(Action 71).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReportPrint.PrintSalesHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //EMAIL SOBH NSC1.01 [005] Envoi document
        //ReportPrint.PrintSalesHeader(Rec);
        CASE STRMENU (STR3+','+STR4+','+STR5) OF
             1:ReportPrint.PrintSalesHeader(Rec);
             2:EnvoiMail;
        END;
        //Fin EMAIL SOBH NSC1.01 [005] Envoi document
        */
        //end;
    }

    var
        "--NSC1.01--": Integer;
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        "Sales & Receivables Setup": Record "311";
        Excel: Boolean;
        HistMail: Record "99003";
        STR3: Label 'Imprimer lme document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        Text001: ;
        Text004: ;
        Salessetup: Record "311";

    procedure "--Functions_NSC1.01--"()
    begin
    end;

    procedure EnvoiMail()
    begin
        //EMAIL NSC00.01 SBH [005] Envoi document
        Salessetup.GET;
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
            ERASE(Salessetup.Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
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
        Salessetup.GET;
        FileDialog.FileName := '';
        FileDialog.InitDir(Salessetup.Repertoire);
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

