pageextension 50074 "BC6_BlanketPurchaseOrder" extends "Blanket Purchase Order" //509
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
            }
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
            {
            }
        }
    }
}

