pageextension 50129 "BC6_PurchaseReturnOrderList" extends "Purchase Return Order List" //9311
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Return Order Type"; Rec."BC6_Return Order Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales No. Order Lien"; Rec."BC6_Sales No. Order Lien")
            {
                ApplicationArea = All;
                Caption = 'Sales No. Order Link', comment = 'FRA="NO Commande Vente Lien"';
            }
            field(BC6_Amount; Rec.Amount)
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
        addfirst(Warehouse)
        {
            action("BC6_Create Inventor&y Put-away/Pick")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Ellipsis = true;
                Image = CreatePutawayPick;
                trigger OnAction()
                var
                    FunctionsMgt: codeunit "BC6_Functions Mgt";
                begin
                    FunctionsMgt.BC6_CreateInvtPutAwayPick_Purchase(rec);
                end;
            }
        }
    }
}
