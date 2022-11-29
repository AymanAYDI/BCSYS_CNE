pageextension 50019 "BC6_SalespersonsPurchasers" extends "Salespersons/Purchasers" //14
{
    layout
    {
        addafter("Phone No.")
        {
            field("BC6_Grouping Code"; "BC6_Grouping Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

