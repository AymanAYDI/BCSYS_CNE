pageextension 50121 "BC6_BlanketSalesOrders" extends "Blanket Sales Orders" //9303
{
    layout
    {
        addafter("Currency Code")
        {
            field(BC6_ID; BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
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

