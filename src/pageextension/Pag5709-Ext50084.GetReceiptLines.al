pageextension 50084 "BC6_GetReceiptLines" extends "Get Receipt Lines" //5709
{
    layout
    {
        modify("Document No.")
        {
            HideValue = false;
        }
        addafter("Document No.")
        {
            field("BC6_Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
