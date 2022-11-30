pageextension 50013 "BC6_PostedSalesCreditMemo" extends "Posted Sales Credit Memo" //134
{
    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Sales Credit Memo"(Page 134)". TODO:

    layout
    {
        addafter("Sell-to Contact No.")
        {
            field("BC6_Sell-to E-Mail Address"; "BC6_Sell-to E-Mail Address")
            {
                Caption = 'Sell-to Customer E-Mail';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field("BC6_User ID"; "User ID")
            {
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
        addafter("&Navigate")
        {
            group("BC6_E&nvoyer/Imprimer")
            {
                Caption = 'E&nvoyer/Imprimer';
                action("BC6_&Print")
                {
                    Caption = '&Print';
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
                        "-MIGNAV2013-": Integer;
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
                        "-MIGNAV2013-": Integer;
                        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        RecLSalesCrMemoHeader := Rec;
                        RecLSalesCrMemoHeader.SETRECFILTER();
                    end;
                }
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        DocPrint: Codeunit "Document-Print";
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        nameF: Text[250];
        Mail: Codeunit Mail;
        SalesSetup: Record "Sales & Receivables Setup";
        Excel: Boolean;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: Label '';
        SalesShptHeader: Record "Sales Shipment Header";

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
