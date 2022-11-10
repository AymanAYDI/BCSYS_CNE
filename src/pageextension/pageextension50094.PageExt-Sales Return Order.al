pageextension 50094 pageextension50094 extends "Sales Return Order"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Sales Return Order"(Page 6630)".

    layout
    {
        addafter("Control 35")
        {
            field(ID; ID)
            {
            }
            field("Sell-to Fax No."; "Sell-to Fax No.")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
        }
        addafter("Control 5")
        {
            field("Return Order Type"; "Return Order Type")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on "Action 119.OnAction".

        //trigger (Variable: L_SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Action 119.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocPrint.PrintSalesHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>MIGRATION NAV 2013

        //EMAIL SOBH NSC1.01 [005] Envoi document
        //STD DocPrint.PrintSalesHeader(Rec);
        //>>BCSYS 05072020
        IF "Return Order Type" = "Return Order Type"::Location THEN BEGIN
        //>>BCSYS 05072020
          CASE STRMENU (STR3+','+STR4+','+STR5) OF
               1:DocPrint.PrintSalesHeader(Rec);
               2:EnvoiMail;
          END;
        //Fin EMAIL SOBH NSC1.01 [005] Envoi document
        //<<MIGRATION NAV 2013
        END ELSE
          CASE STRMENU (STR3+','+STR4) OF
               1:
                 BEGIN
                   TESTFIELD(Status,Status::Released);
                   L_SalesHeader.RESET;
                   L_SalesHeader.SETRANGE("Document Type","Document Type");
                   L_SalesHeader.SETRANGE("No.","No.");
                   REPORT.RUNMODAL(50060,TRUE,FALSE,L_SalesHeader);
                 END;
               2:
                 BEGIN
                   TESTFIELD(Status,Status::Released);
                   EnvoiMail;
                 END;

          END;
        */
        //end;


        //Unsupported feature: Code Modification on "Release(Action 112).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualRelease(Rec);

        //>>BCSYS
        FctSendNotification
        //<<BCSYS
        */
        //end;
        addafter("Action 135")
        {
            action(DisplayRelatedDocuments)
            {
                Caption = 'Affichage documents associés';
                Image = CopyDocument;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    L_ReturnOrderMgt: Codeunit "50052";
                begin
                    L_ReturnOrderMgt.DisableRelatedDocuments("No.");
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        L_SalesHeader: Record "36";

    var
        "--NSC1.01--": Integer;
        cust: Record "18";
        nameF: Text[250];
        Mail: Codeunit "397";
        "Sales & Receivables Setup": Record "311";
        Excel: Boolean;
        HistMail: Record "99003";
        "--MIGNAV2013--": ;
        Text001: ;
        Text004: ;
        STR3: Label 'Print Document';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        SalesSetup: Record "311";

    var
        "--BCSYS--": ;
        CstNewReturnOrder: Label 'Nouveau retour SAV';

    procedure "--Functions_NSC1.01--"()
    begin
    end;

    procedure EnvoiMail()
    begin
        //>>MIGRATION NAV 2013
        //EMAIL NSC00.01 SBH [005] Envoi document
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
        //<<MIGRATION NAV 2013
    end;

    procedure OpenFile()
    begin
        //>>MIGRATION NAV 2013
        /*//EMAIL NSC00.01 SBH [005] Envoi document
        FileDialog.DialogTitle('Envoi'+' 'CurrPage.CAPTION);
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
        //<<MIGRATION NAV 2013

    end;

    procedure OpenFile1(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260]
    begin
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure FctSendNotification()
    var
        L_UserSetup: Record "91";
        NotificationEntry: Record "1511";
        notification: Notification;
    begin
        L_UserSetup.RESET;
        L_UserSetup.SETRANGE("SAV Admin", TRUE);
        IF L_UserSetup.FINDFIRST THEN
            REPEAT
                NotificationEntry.CreateNew(
                  NotificationEntry.Type::"New Record", L_UserSetup."User ID",
                  Rec, 6630, '');
            UNTIL L_UserSetup.NEXT = 0;
    end;
}

