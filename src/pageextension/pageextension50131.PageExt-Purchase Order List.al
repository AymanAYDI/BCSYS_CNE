pageextension 50131 pageextension50131 extends "Purchase Order List"
{
    layout
    {
        modify("Control 20")
        {
            Visible = false;
        }
        addafter("Control 5")
        {
            field(ID; ID)
            {
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
            field(Amount; Amount)
            {
            }
            field("Sales No. Order Lien"; "Sales No. Order Lien")
            {
                Caption = 'Sales No. Order Lien';
            }
        }
        addafter("Control 22")
        {
            field("Last Related Info Date"; "Last Related Info Date")
            {
                DrillDownPageID = "Log Purch. Comment Lines";
                LookupPageID = "Log Purch. Comment Lines";
            }
            field("Related Sales Return Order"; "Related Sales Return Order")
            {
            }
        }
    }
    actions
    {
        addafter("Action 1102601030")
        {
            action(LogCommentsList)
            {
                Caption = 'Receipt related information';
                Image = ReceiptReminder;
                RunObject = Page 50105;
                RunPageLink = Document Type=FIELD(Document Type),
                              No.=FIELD(No.),
                              Document Line No.=CONST(0),
                              Is Log=CONST(Yes);
            }
            action(AddLogComment)
            {
                Caption = 'Add receipt related information';
                Image = NewWarehouseReceipt;

                trigger OnAction()
                var
                    AddLogPurchCommentPage: Page "50106";
                begin
                    AddLogPurchCommentPage.SETTABLEVIEW(Rec);
                    AddLogPurchCommentPage.SETRECORD(Rec);
                    AddLogPurchCommentPage.LOOKUPMODE(TRUE);
                    AddLogPurchCommentPage.RUNMODAL;
                end;
            }
        }
    }
}

