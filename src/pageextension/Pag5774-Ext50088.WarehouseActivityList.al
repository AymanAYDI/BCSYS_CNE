pageextension 50088 "BC6_WarehouseActivityList" extends "Warehouse Activity List"//5774
{
    layout
    {
        addafter("Source Document")
        {
            field(BC6_Comments; Rec."BC6_Comments")
            {
                ApplicationArea = All;
            }
        }
        addafter("Source No.")
        {
            field(BC6_YourReference; Rec."BC6_Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Destination No.")
        {
            field(BC6_DestinationName; Rec."BC6_Destination Name")
            {
                ApplicationArea = All;
            }
            field(BC6_BinCode; Rec."BC6_Bin Code")
            {
                ApplicationArea = All;
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
