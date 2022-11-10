pageextension 50142 pageextension50142 extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Control 34")
        {
            field("DEEE Category Code"; "DEEE Category Code")
            {
                Visible = false;
            }
            field("Eco partner DEEE"; "Eco partner DEEE")
            {
                Visible = false;
            }
            field("DEEE VAT Amount"; "DEEE VAT Amount")
            {
                Visible = false;
            }
            field("DEEE TTC Amount"; "DEEE TTC Amount")
            {
                Visible = false;
            }
            field("DEEE HT Amount (LCY)"; "DEEE HT Amount (LCY)")
            {
                Visible = false;
            }
        }
        addafter("Control 6")
        {
            field("Purchasing Code"; "Purchasing Code")
            {
            }
        }
        addafter("Control 10")
        {
            field("Purchase cost"; "Purchase cost")
            {
            }
        }
        addafter("Control 74")
        {
            field("DEEE Unit Price"; "DEEE Unit Price")
            {
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
            field("DEEE HT Amount"; "DEEE HT Amount")
            {
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }
    }
}

