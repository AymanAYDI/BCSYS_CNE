pageextension 50086 pageextension50086 extends "Get Receipt Lines"
{
    layout
    {

        //Unsupported feature: Property Deletion (HideValue) on "Control 2".

        addafter("Control 2")
        {
            field("Order No."; "Order No.")
            {
            }
            field("Order Date"; "Order Date")
            {
            }
        }
    }
}

