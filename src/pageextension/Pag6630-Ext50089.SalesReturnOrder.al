pageextension 50089 "BC6_SalesReturnOrder" extends "Sales Return Order" //6630
{


    layout
    {
        addafter("Sell-to")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
            }
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
            }
        }
        addafter("Job Queue Status")
        {
            field("BC6_Return Order Type"; Rec."BC6_Return Order Type")
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
                    FunctionMgt.BC6_CreateInvtPutAwayPick_Sales(rec);
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
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    L_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
                begin
                    L_ReturnOrderMgt.DisableRelatedDocuments(Rec."No.");
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

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    //     Error: Label 'you don''t have permission to add records', Comment = 'FRA="vous n''êtes pas autorisé à ajouter des enregistrements"';
    // begin
    //     Error(Error); //TODO: Check Modify property InsertAllowed by Error
    // end;

    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FindFirst() THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup."BC6_Repertoire" + 'Envoi' + '\' + CurrPage.CAPTION);
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


    local procedure FctSendNotification()
    var
        NotificationEntry: Record "Notification Entry";
        L_UserSetup: Record "User Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        L_UserSetup.RESET();
        L_UserSetup.SETRANGE("BC6_SAV Admin", TRUE);
        IF L_UserSetup.FindSet() THEN begin
            WorkflowStepInstance.Get();
            if WorkflowStepArgument.Get(WorkflowStepInstance.Argument) then
                REPEAT
                    NotificationEntry.CreateNotificationEntry(NotificationEntry.Type::"New Record", L_UserSetup."User ID", Rec, WorkflowStepArgument."Link Target Page",
                                        WorkflowStepArgument."Custom Link", CopyStr(UserId(), 1, 50));
                UNTIL L_UserSetup.NEXT() = 0;
        end;
    end;
}

