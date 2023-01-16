pageextension 50019 "BC6_SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
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
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Item Reference No.")
        {
            field("BC6_Public Price"; Rec."BC6_Public Price")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Amount")
        {
            field("BC6_Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }
}
