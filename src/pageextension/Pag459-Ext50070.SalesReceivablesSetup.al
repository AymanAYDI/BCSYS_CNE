pageextension 50070 "BC6_SalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        addafter("Prepmt. Auto Update Frequency")
        {
            field("BC6_Promised Delivery Date"; Rec."BC6_Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Requested Delivery Date"; Rec."BC6_Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("BC6_E-Mail Administrateur"; Rec."BC6_E-Mail Administrateur")
            {
                Caption = 'Mail pour déblocage devis';
                ApplicationArea = All;
            }
            field(BC6_Nbr_Devis; Rec.BC6_Nbr_Devis)
            {
                Caption = 'Blocage devis si nb dépasse ';
                ApplicationArea = All;
            }
            field(BC6_Période; Rec."BC6_Période")
            {
                Caption = 'Blocage devis sur période';
                ApplicationArea = All;
            }
            field("BC6_PDF Mail Tag"; Rec."BC6_PDF Mail Tag")
            {
                ApplicationArea = All;
            }
            field("BC6_Update Price Allow Line disc."; Rec."BC6_Upd. Price AllowLine disc.")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Management"; Rec."BC6_DEEE Management")
            {
                ApplicationArea = All;
            }
            field("BC6_allow Profit% to"; Rec."BC6_allow Profit% to")
            {

                ApplicationArea = All;
            }
            field("Contact's Address on sales doc"; Rec."BC6_Contact's Address on sales doc")
            {
                ApplicationArea = All;
            }
            field("BC6_RTE Fax Tag"; Rec."BC6_RTE Fax Tag")
            {
                ApplicationArea = All;
            }
            field("BC6_Active Quantity Management"; Rec."BC6_Active Quantity Management")
            {
                ApplicationArea = All;
            }
            field("BC6_Active Released Printing Order"; Rec."BC6_Acti. Releas. Print. Order")
            {
                ApplicationArea = All;
            }
            field("BC6_Purchasing Code Grouping Line"; Rec."BC6_Purcha. Code Grouping Line")
            {
                ApplicationArea = All;
            }
            field("BC6_Technicals Directory Path"; Rec."BC6_Technicals Directory Path")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("BC6_SAV Return Order Nos."; Rec."BC6_SAV Return Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnClosePage()
    begin
        IF Rec.BC6_Nbr_Devis = 0 THEN BEGIN
            Rec.GET();
            Rec.BC6_Nbr_Devis := 5;
            Rec.MODIFY();
        END;
    end;
}

