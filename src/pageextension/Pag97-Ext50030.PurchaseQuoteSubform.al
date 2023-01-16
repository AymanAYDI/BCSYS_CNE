pageextension 50030 "BC6_PurchaseQuoteSubform" extends "Purchase Quote Subform" //97
{
    layout
    {
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount Direct Unit Cost"; Rec."BC6_Discount Direct Unit Cost")
            {
                ApplicationArea = All;
            }
        }

        addafter(ShortcutDimCode8)
        {
            field("BC6_Sales Document Type"; Rec."BC6_Sales Document Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales No."; Rec."BC6_Sales No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Line No."; Rec."BC6_Sales Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
