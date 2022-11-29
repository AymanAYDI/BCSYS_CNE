pageextension 50130 "BC6_PurchaseQuotes" extends "Purchase Quotes" //9306
{
    layout
    {
        addafter("Status")
        {
            field(BC6_ID; ID)
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
            }
            field(BC6_Amount; Amount)
            {
            }
        }
    }
}

