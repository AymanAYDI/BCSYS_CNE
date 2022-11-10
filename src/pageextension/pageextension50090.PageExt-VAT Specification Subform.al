pageextension 50090 pageextension50090 extends "VAT Specification Subform"
{
    layout
    {
        addafter("Control 22")
        {
            field("DEEE HT Amount"; "DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("DEEE VAT Amount"; "DEEE VAT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("DEEE TTC Amount"; "DEEE TTC Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("DEEE HT Amount (LCY)"; "DEEE HT Amount (LCY)")
            {
            }
            field("DEEE Amount (LCY) for Stat"; "DEEE Amount (LCY) for Stat")
            {
            }
        }
    }
}

