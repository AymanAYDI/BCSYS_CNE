pageextension 50124 "BC6_PurchaseQuotes" extends "Purchase Quotes" //9306
{
    layout
    {
        addafter(Status)
        {
            field(BC6_ID; ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Amount)
            {
                ApplicationArea = All;
            }
        }
    }
}

