pageextension 50012 pageextension50012 extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Control 4")
        {
            field("DEEE Category Code"; "DEEE Category Code")
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
            }
            field("Eco partner DEEE"; "Eco partner DEEE")
            {
            }
            field("DEEE TTC Amount"; "DEEE TTC Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
            }
            field("DEEE HT Amount (LCY)"; "DEEE HT Amount (LCY)")
            {
            }
        }
        addafter("Control 10")
        {
            field("Purchase Cost"; "Purchase Cost")
            {
            }
        }
        addafter("Control 44")
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

