pageextension 50125 "BC6_PurchaseOrderList" extends "Purchase Order List" //9307
{
    layout
    {
        addafter("Job Queue Status")
        {
            field(BC6_ID; Rec.ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Amount)
            {
                ApplicationArea = All;
            }
            field("BC6_Sales No. Order Lien"; "BC6_Sales No. Order Lien")
            {
                Caption = 'Sales No. Order Lien', Comment = 'FRA="n° Commande Vente Lien"';
                ApplicationArea = All;
            }
        }
        addafter("Amount Including VAT")
        {
            field("BC6_Last Related Info Date"; "BC6_Last Related Info Date")
            {
                DrillDownPageID = "BC6_Log Purch. Comment Lines";
                LookupPageID = "BC6_Log Purch. Comment Lines";
                ApplicationArea = All;
            }
            field("BC6_Related Sales Return Order"; "BC6_Related Sales Return Order")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        addafter("Co&mments")
        {
            action(BC6_LogCommentsList)
            {
                Caption = 'Receipt related information', Comment = 'FRA="Informations connexes de réception"';
                Image = ReceiptReminder;
                RunObject = Page "BC6_Log Purch. Comment Lines";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No."),
                              "Document Line No." = CONST(0),
                              "BC6_Is Log" = CONST(true);
                ApplicationArea = All;
            }
            action(BC6_AddLogComment)
            {
                Caption = 'Add receipt related information', Comment = 'FRA="Ajouter information connexe de réception"';
                Image = NewWarehouseReceipt;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AddLogPurchCommentPage: Page "BC6_Add Log Purch. Comment";
                begin
                    AddLogPurchCommentPage.SETTABLEVIEW(Rec);
                    AddLogPurchCommentPage.SETRECORD(Rec);
                    AddLogPurchCommentPage.LOOKUPMODE(TRUE);
                    AddLogPurchCommentPage.RUNMODAL();
                end;
            }
        }
        addafter("Create &Whse. Receipt")
        {
            action("BC6_Create Inventor&y Put-away/Pick")
            {
                AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick';
                Ellipsis = true;
                Image = CreatePutawayPick;
                trigger OnAction()
                var
                    FunctionsMgt: codeunit "BC6_Functions Mgt";

                begin
                    FunctionsMgt.BC6_CreateInvtPutAwayPick_Purchase(rec);

                    if not Rec.find('=><') then
                        Rec.init();
                end;
            }
        }
    }
}

