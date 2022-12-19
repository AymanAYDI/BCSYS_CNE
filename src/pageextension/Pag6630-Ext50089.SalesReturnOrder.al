pageextension 50089 "BC6_SalesReturnOrder" extends "Sales Return Order" //6630
{

    //TODO Unsupported feature: Property Insertion (InsertAllowed) on ""Sales Return Order"(Page 6630)".
    layout
    {
        addafter("Sell-to")
        {
            field(BC6_ID; ID)
            {
            }
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("BC6_Return Order Type"; "BC6_Return Order Type")
            {
            }
        }
    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;

        }
        addafter("Create &Whse. Receipt")
        {
            action("BC6_Create Inventor&y Put-away/Pick2")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';
                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";

                begin
                    FunctionMgt.BC6_CreateInvtPutAwayPick();
                end;
            }
        }
        modify("Release")
        {
            Visible = false;
        }
        addafter(Action7)
        {
            action("BC6_Rel&ease")
            {
                ApplicationArea = SalesReturnOrder;
                Caption = 'Re&lease', Comment = 'FRA="&Lancer"';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';
                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    FctSendNotification();
                    CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                end;
            }
        }
        addafter("Action135")
        {
            action(BC6_DisplayRelatedDocuments)
            {
                Caption = 'Affichage documents associés';
                Image = CopyDocument;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    L_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
                begin
                    L_ReturnOrderMgt.DisableRelatedDocuments("No.");
                    CurrPage.UPDATE();
                end;
            }
        }
    }


    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        Text001: Label '';
        nameF: Text[250];



    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FindFirst() THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup."BC6_Repertoire" + 'Envoi' + '\' + CurrPage.CAPTION);
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


    local procedure FctSendNotification()
    var
        NotificationEntry: Record "Notification Entry";
        L_UserSetup: Record "User Setup";
        notification: Notification;
    begin
        L_UserSetup.RESET();
        L_UserSetup.SETRANGE("BC6_SAV Admin", TRUE);
        //TODO: 0 Régler les param:// IF L_UserSetup.FINDFIRST THEN
        //     REPEAT
        //         NotificationEntry.CreateNew(
        //           NotificationEntry.Type::"New Record", L_UserSetup."User ID",
        //           Rec, 6630, '');
        //     UNTIL L_UserSetup.NEXT = 0;
    end;
}

