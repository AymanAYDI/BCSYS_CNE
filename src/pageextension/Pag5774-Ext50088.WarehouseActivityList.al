pageextension 50088 "BC6_WarehouseActivityList" extends "Warehouse Activity List"//5774
{
    layout
    {
        addafter("Source Document")
        {
            field(BC6_Comments; Rec."BC6_Comments")
            {
            }
        }
        addafter("Source No.")
        {
            field(BC6_YourReference; Rec."BC6_Your Reference")
            {
            }
        }
        addafter("Destination No.")
        {
            field(BC6_DestinationName; Rec."BC6_Destination Name")
            {
            }
            field(BC6_BinCode; Rec."BC6_Bin Code")
            {
            }
        }
    }
    actions
    {
        modify(Card)
        {
            Promoted = true;
        }
    }
}
