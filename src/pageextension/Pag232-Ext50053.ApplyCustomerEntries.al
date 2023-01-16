pageextension 50053 "BC6_ApplyCustomerEntries" extends "Apply Customer Entries" //232
{
    layout
    {
        addafter("Document No.")
        {
            field("BC6_Pay-to Customer No."; Rec."BC6_Pay-to Customer No.")
            {
                ApplicationArea = Basic, Suite;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("BC6_Pay-to cust. Name"; Rec.getCustomerName(Rec."BC6_Pay-to Customer No."))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pay-to cust. Name', comment = 'FRA="Nom tiers payeur"';
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }

    //TODO: Il existe des modification à continuer au sein des procédures CalcApplnAmount & Setsales..
}
