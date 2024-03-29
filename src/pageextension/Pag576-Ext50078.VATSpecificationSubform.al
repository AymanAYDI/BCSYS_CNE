pageextension 50078 "BC6_VATSpecificationSubform" extends "VAT Specification Subform" //576
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Amount (LCY) for Stat"; Rec."BC6_DEEE Amount (LCY) for Stat")
            {
                ApplicationArea = All;
            }
        }
    }
}
