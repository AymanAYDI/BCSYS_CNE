pageextension 50029 "BC6_SalesCrMemoSubform" extends "Sales Cr. Memo Subform" //96
{
    layout
    {
        addafter("Item Reference No.")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                Visible = false;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                Visible = false;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                Visible = false;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                Visible = false;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                Visible = false;
            }
        }
        addafter(Description)
        {
            field("BC6_Purchasing Code"; Rec."Purchasing Code")
            {
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }
    }
}

