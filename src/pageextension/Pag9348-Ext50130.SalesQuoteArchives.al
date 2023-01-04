pageextension 50130 "BC6_SalesQuoteArchives" extends "Sales Quote Archives" //9348
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field(BC6_No; Rec."No.")
            {
            }
        }
    }
}

