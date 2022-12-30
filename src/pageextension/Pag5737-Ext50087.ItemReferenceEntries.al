pageextension 50087 "BC6_ItemReferenceEntries" extends "Item Reference Entries" //5737
{
    layout
    {
        addfirst(Control1)
        {
            field(BC6_ItemNo; "Item No.")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        modify("Variant Code")
        {
            Visible = FALSE;
        }
        addafter(Description)
        {
            field(BC6_Inventory; "BC6_Inventory")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addlast(Control1)
        {
            field(BC6_InternalBarCode; "BC6_Internal Bar Code")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }
}
