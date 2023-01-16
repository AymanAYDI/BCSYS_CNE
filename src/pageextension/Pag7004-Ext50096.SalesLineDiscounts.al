pageextension 50096 "BC6_SalesLineDiscounts" extends "Sales Line Discounts" //7004
{
    layout
    {
        addafter("Minimum Quantity")
        {
            field("BC6_Dispensation No."; Rec."BC6_Dispensation No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Added Discount %"; Rec."BC6_Added Discount %")
            {
                ApplicationArea = All;
            }
        }
    }
}
