pageextension 50090 "BC6_VATSpecificationSubform" extends "VAT Specification Subform" //576
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; "BC6_DEEE VAT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Amount (LCY) for Stat"; "BC6_DEEE Amount (LCY) for Stat")
            {
                ApplicationArea = All;
            }
        }
    }
}

