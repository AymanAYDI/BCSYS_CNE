pageextension 50012 "BC6_PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform" //133
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
            }
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
            {
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Purchase Cost"; "BC6_Purchase Cost")
            {
            }
        }
        addafter("Appl.-to Item Entry")
        {
            field("BC6_DEEE Unit Price"; "BC6_DEEE Unit Price")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }
}

