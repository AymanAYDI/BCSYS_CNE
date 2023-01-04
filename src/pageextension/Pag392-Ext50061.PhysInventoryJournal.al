pageextension 50061 "BC6_PhysInventoryJournal" extends "Phys. Inventory Journal" //392
{

    layout
    {
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        addafter("Qty. (Phys. Inventory)")
        {
            field("BC6_Qty. Refreshed (Phys. Inv.)"; Rec."BC6_Qty.(Phys. Inv.)")
            {
                ShowCaption = false;
            }
        }

    }

    actions
    {
        addafter(CalculateInventory)
        {
            action("BC6_Refresh Phys. Qty")
            {
                Caption = 'Refresh Phys. Qty', Comment = 'FRA="Actualiser quantité &constatée"';

                trigger OnAction()
                begin
                    RefreshPhysQty.SetItemJnlLine(Rec);
                    RefreshPhysQty.RUNMODAL();
                    CLEAR(RefreshPhysQty);
                end;
            }
        }
    }



    var
        RefreshPhysQty: Report "BC6_Refresh Phys. Qty";

}

