pageextension 50052 "BC6_Std Vendor Pur. Codes" extends "Standard Vendor Purchase Codes" //178
{
    layout
    {
        addafter(Description)
        {
            field(BC6_TextautoReport; Rec."BC6_TextautoReport")
            {
                ApplicationArea = All;
            }
        }
    }
}
