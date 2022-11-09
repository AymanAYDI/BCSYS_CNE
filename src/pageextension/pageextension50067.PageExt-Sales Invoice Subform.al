pageextension 50067 pageextension50067 extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Control 4")
        {
            field("DEEE Category Code"; "DEEE Category Code")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Eco partner DEEE"; "Eco partner DEEE")
            {
            }
            field("DEEE VAT Amount"; "DEEE VAT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("DEEE TTC Amount"; "DEEE TTC Amount")
            {
            }
            field("DEEE HT Amount (LCY)"; "DEEE HT Amount (LCY)")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Control 58")
        {
            field("Public Price"; "Public Price")
            {
            }
        }
        addafter("Control 10")
        {
            field("Purchase cost"; "Purchase cost")
            {
            }
        }
        addafter("Control 64")
        {
            field("Profit %"; "Profit %")
            {
            }
        }
        addafter("Control 82")
        {
            field("DEEE Unit Price"; "DEEE Unit Price")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("DEEE HT Amount"; "DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }
}

