pageextension 50124 "BC6_PurchaseQuotes" extends "Purchase Quotes" //9306
{
    layout
    {
        addafter(Status)
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
    }
}
