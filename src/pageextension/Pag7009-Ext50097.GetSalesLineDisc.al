#pragma warning disable AL0432
pageextension 50097 "BC6_GetSalesLineDisc" extends "Get Sales Line Disc." //7009
{
    layout
    {
        addafter("Line Discount %")
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
#pragma warning restore AL0432
