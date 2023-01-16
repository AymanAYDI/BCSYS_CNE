pageextension 50128 "BC6_BlanketPurchaseOrders" extends "Blanket Purchase Orders" //9310
{
    layout
    {
        addafter("Currency Code")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
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
