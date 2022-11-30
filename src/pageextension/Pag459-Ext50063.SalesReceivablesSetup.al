pageextension 50063 "BC6_SalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        addafter("Prepmt. Auto Update Frequency")
        {
            field("BC6_Promised Delivery Date"; "BC6_Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Requested Delivery Date"; "BC6_Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BC6_E-Mail Administrateur"; "BC6_E-Mail Administrateur")
            {
                Caption = 'Mail pour déblocage devis';
                ApplicationArea = All;
            }
            field(BC6_Nbr_Devis; BC6_Nbr_Devis)
            {
                Caption = 'Blocage devis si nb dépasse ';
                ApplicationArea = All;
            }
            field(Période; Période)
            {
                Caption = 'Blocage devis sur période';
                ApplicationArea = All;
            }
            field("BC6_PDF Mail Tag"; "BC6_PDF Mail Tag")
            {
                ApplicationArea = All;
            }
            field("BC6_Update Price Allow Line disc."; "BC6_Upd. Price AllowLine disc.")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Management"; "BC6_DEEE Management")
            {
                ApplicationArea = All;
            }
            field("BC6_allow Profit% to"; "BC6_allow Profit% to")
            {
                ApplicationArea = All;
            }
            field("Contact's Address on sales doc"; "Contact's Address on sales doc")
            {
                ApplicationArea = All;
            }
            field("BC6_RTE Fax Tag"; "BC6_RTE Fax Tag")
            {
                ApplicationArea = All;
            }
            field("BC6_Active Quantity Management"; "BC6_Active Quantity Management")
            {
                ApplicationArea = All;
            }
            field("BC6_Active Released Printing Order"; "BC6_Acti. Releas. Print. Order")
            {
                ApplicationArea = All;
            }
            field("BC6_Purchasing Code Grouping Line"; "BC6_Purcha. Code Grouping Line")
            {
                ApplicationArea = All;
            }
            field("BC6_Technicals Directory Path"; "BC6_Technicals Directory Path")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("BC6_SAV Return Order Nos."; "BC6_SAV Return Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnClosePage()
    begin
        IF BC6_Nbr_Devis = 0 THEN BEGIN
            Rec.GET();
            BC6_Nbr_Devis := 5;
            Rec.MODIFY();
        END;
    end;
}

