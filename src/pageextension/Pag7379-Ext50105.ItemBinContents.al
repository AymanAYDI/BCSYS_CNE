pageextension 50105 "BC6_ItemBinContents" extends "Item Bin Contents" //7379
{
    layout
    {
        addafter("Quantity (Base)")
        {
            field("BC6_Pick Qty."; Rec."Pick Qty.")
            {
                ApplicationArea = All;
            }
        }
    }
}
