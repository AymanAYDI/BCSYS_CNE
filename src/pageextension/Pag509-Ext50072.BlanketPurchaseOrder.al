pageextension 50072 "BC6_BlanketPurchaseOrder" extends "Blanket Purchase Order" //509
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field(BC6_ID; ID)
            {
            }
            field("BC6_Buy-from Fax No."; "BC6_Buy-from Fax No.")
            {
            }
        }
    }
}

