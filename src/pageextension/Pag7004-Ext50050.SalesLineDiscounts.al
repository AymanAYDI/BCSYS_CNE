pageextension 50050 "BC6_SalesLineDiscounts" extends "Sales Line Discounts" //7004
{

    layout
    {
        addafter("Minimum Quantity")
        {
            field("BC6_Dispensation No."; "BC6_Dispensation No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Added Discount %"; "BC6_Added Discount %")
            {
                ApplicationArea = All;
            }
        }
    }
}

