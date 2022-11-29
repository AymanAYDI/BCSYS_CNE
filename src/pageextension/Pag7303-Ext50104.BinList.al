pageextension 50104 "BC6_BinList" extends "Bin List"  //7303
{
    layout
    {
        addafter(Empty)
        {
            field("BC6_To Make Available"; "BC6_To Make Available")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Order Not Shipped"; "BC6_Sales Order Not Shipped")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bin Type Code")
        {
            field("BC6_Exclude Inventory Pick"; "BC6_Exclude Inventory Pick")
            {
                ApplicationArea = All;
            }
        }
    }
}