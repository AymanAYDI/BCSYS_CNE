pageextension 50036 "BC6_PostedSalesShptSubform" extends "Posted Sales Shpt. Subform" //131
{
    layout
    {
        addafter("Location Code")
        {
            field("BC6_Amount(LCY)"; Rec."BC6_Amount(LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
