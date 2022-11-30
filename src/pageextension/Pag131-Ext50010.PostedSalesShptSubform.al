pageextension 50010 "BC6_PostedSalesShptSubform" extends "Posted Sales Shpt. Subform" //131
{
    layout
    {
        addafter("Location Code")
        {
            field("BC6_Amount(LCY)"; "BC6_Amount(LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}

