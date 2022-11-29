pageextension 50034 "BC6_ApplyCustomerEntries" extends "Apply Customer Entries" //232
{
    layout
    {
        addafter("Document No.")
        {
            field("BC6_Pay-to Customer No."; "BC6_Pay-to Customer No.")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
            }
            field("BC6_Pay-to cust. Name"; getCustomerName("BC6_Pay-to Customer No."))
            {
                Caption = 'Pay-to cust. Name', comment = 'FRA="Nom tiers payeur"';
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    //TODO: Il existe des modification à continuer au sein des procédures CalcApplnAmount & Setsales..
}

