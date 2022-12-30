pageextension 50073 "BC6_BlanketSalesOrder" extends "Blanket Sales Order" //507
{
    layout
    {
        addafter("Sell-to Contact No.")
        {
            field(BC6_ID; Rec.ID)
            {
            }
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
            }
        }
    }
}

