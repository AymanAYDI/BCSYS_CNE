pageextension 50059 pageextension50059 extends "Sales Invoice"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on "Control 2".

        addafter("Control 2")
        {
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
            }
        }
        addafter("Control 100")
        {
            field(ID; ID)
            {
                Editable = false;
            }
        }
        addafter("Control 8")
        {
            field("Sell-to Fax No."; "Sell-to Fax No.")
            {
            }
        }
        addafter("Control 67")
        {
            field("Reason Code"; "Reason Code")
            {

                trigger OnValidate()
                begin
                    FnctGOnAvterValidateReasonCode();
                end;
            }
            field("Affair No."; "Affair No.")
            {
            }
        }
        addfirst("Control 205")
        {
            field("Bill-to Customer No."; "Bill-to Customer No.")
            {
            }
        }
        addafter(WorkflowStatus)
        {
            part(; 50028)
            {
                Provider = "56";
                SubPageLink = Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.);
                Visible = false;
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "PostAndNew(Action 7).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"New Document");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*

            //>>MIGRATION NAV 2013
            //Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"New Document");
            //EMAIL SOBH NSC1.01 [005]
            CASE STRMENU (STR3+','+STR4+','+STR5) OF
                 1:Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"New Document");
                 2:EnvoiMail;
            END;
            //Fin EMAIL SOBH NSC1.01 [005]
            //<<MIGRATION NAV2013
            */
        //end;
    }

    var
        "--MIGNAV2013--": ;
        STR3: Label 'Imprimer lme document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        "-MIGNAV2013-": Integer;
        "--NSC1.01--": Integer;
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        "Sales & Receivables Setup": Record "311";
        Excel: Boolean;
        HistMail: Record "99003";
        SalesSetup: Record "311";
        Text001: ;
        Text004: ;

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure FnctGOnAvterValidateReasonCode()
    begin
        //<<DEEE1.00
        CurrPage.UPDATE(TRUE) ;
        //>>DEEE1.00
    end;

    procedure "--Functions_NSC1.01--"()
    begin
    end;

    procedure EnvoiMail()
    begin
        //EMAIL NSC00.01 SBH [005] Envoi document
        cust.SETRANGE(cust."No.","Sell-to Customer No.");
        IF cust.FIND('-') THEN
        cust.TESTFIELD("E-Mail");
          OpenFile;
          IF nameF<>'' THEN BEGIN
            //MIG 2017 >>
            //Mail.NewMessage(cust."E-Mail",'',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            Mail.NewMessage(cust."E-Mail",'','',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            //MIG 2017 <<
            ERASE(nameF);
          END ELSE BEGIN
            ERASE(SalesSetup.Repertoire +'Envoi'+'\'+CurrPage.CAPTION) ;
            ERROR(Text001);
          END;
        HistMail."No.":=cust."No.";
        HistMail.Nom  :=cust.Name;
        HistMail."E-Mail":=  cust."E-Mail";
        HistMail."Date d'envoi":=TODAY;
        HistMail."Document envoyé":=CurrPage.CAPTION+' '+"No.";
        HistMail.INSERT(TRUE);
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
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

    procedure OpenFile1(WindowTitle: Text[50];DefaultFileName: Text[250];DefaultFileType: Option " ",Text,Excel,Word,Custom;FilterString: Text[250];"Action": Option Open,Save): Text[260]
    begin
    end;
}

