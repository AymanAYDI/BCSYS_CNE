pageextension 50087 "BC6_ItemReferenceEntries" extends "Item Reference Entries" //5737
{
    layout
    {
        addfirst(Control1)
        {
            field(BC6_ItemNo; Rec."Item No.")
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
            field(BC6_Inventory; Rec."BC6_Inventory")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addlast(Control1)
        {
            field(BC6_InternalBarCode; Rec."BC6_Internal Bar Code")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
