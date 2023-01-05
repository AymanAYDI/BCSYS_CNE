pageextension 50031 "BC6_PurchCrMemoSubform" extends "Purch. Cr. Memo Subform" //98
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }
}

