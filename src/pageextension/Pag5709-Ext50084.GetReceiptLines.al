pageextension 50084 "BC6_GetReceiptLines" extends "Get Receipt Lines" //5709
{
    layout
    {

        //Unsupported feature: Property Deletion (HideValue) on "Control 2". 
        //la valeur par défaut de HideValue est TRUE.
        modify("Document No.")
        {
            HideValue = false;
        }
        addafter("Document No.")
        {
            field("BC6_Order No."; "Order No.")
            {
            }
            field("BC6_Order Date"; "Order Date")
            {
            }
        }
    }
}

