pageextension 50019 "BC6_SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; "BC6_DEEE Category Code")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
            {
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
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("Item Reference No.")
        {
            field("BC6_Public Price"; "BC6_Public Price")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Purchase cost"; "BC6_Purchase cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Amount")
        {
            field("BC6_Profit %"; "Profit %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field("BC6_DEEE Unit Price"; "BC6_DEEE Unit Price")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }
}

