pageextension 50002 "BC6_SalespersonsPurchasers" extends "Salespersons/Purchasers" //14
{
    layout
    {
        addafter("Phone No.")
        {
            field("BC6_Grouping Code"; Rec."BC6_Grouping Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
