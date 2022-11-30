pageextension 50026 "BC6_PurchaseQuoteSubform" extends "Purchase Quote Subform" //97
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
            field("BC6_Discount Direct Unit Cost"; "BC6_Discount Direct Unit Cost")
            {
                ApplicationArea = All;
            }
        }

        addafter(ShortcutDimCode8)
        {
            field("BC6_Sales Document Type"; "BC6_Sales Document Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales No."; "BC6_Sales No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Line No."; "BC6_Sales Line No.")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        "--FE-B--": Integer;
    // CuGItemHistoryMgt: Codeunit 50009; TODO:
}
