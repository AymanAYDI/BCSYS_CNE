pageextension 50128 "BC6_BlanketPurchaseOrders" extends "Blanket Purchase Orders" //9310
{
    layout
    {
        addafter("Currency Code")
        {
            field(BC6_ID; BC6_ID)
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
            field(BC6_Amount; Amount)
            {
            }
        }
    }
}

