pageextension 50112 "BC6_PurchaseOrder" extends "Purchase Order"
{
    layout
    {
    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        addafter("Create &Whse. Receipt")
        {
            action("BC6_Create Inventor&y Put-away/Pick")
            {
                AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                ApplicationArea = Warehouse;
                Ellipsis = true;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stock"';
                Promoted = true;
                Image = CreateInventoryPickup;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    FunctionsMgt: codeunit "BC6_Functions Mgt";

                begin
                    FunctionsMgt.BC6_CreateInvtPutAwayPick_Purchase(rec);
                    IF NOT Rec.FIND('=><') then
                        Rec.INIT();
                END;

            }
        }
    }
}
