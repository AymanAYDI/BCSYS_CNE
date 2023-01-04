pageextension 50019 "BC6_SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
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
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }
}

