pageextension 50038 "BC6_PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform" //133
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; "BC6_DEEE Category Code")
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Purchase Cost"; "BC6_Purchase Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
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

