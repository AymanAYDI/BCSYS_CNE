pageextension 50101 "BC6_BinContentsList" extends "Bin Contents List" //7305
{
    layout
    {
        addafter("Warehouse Class Code")
        {
            field("BC6_Pick Qty."; "Pick Qty.")
            {
                ApplicationArea = All;
            }
        }
    }
}

