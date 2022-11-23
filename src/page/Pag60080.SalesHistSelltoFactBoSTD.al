page 60080 "Sales Hist. Sell-to FactBo STD"
{
    Caption = 'Sell-to Customer Sales History', Comment = 'FRA="Historique des ventes - donneur d''ordre"';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                Caption = 'Customer No.', Comment = 'FRA="N° client"';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field("No. of Quotes"; "No. of Quotes")
            {
                Caption = 'Quotes', Comment = 'FRA="Devis"';
                DrillDownPageID = "Sales Quotes";
                ApplicationArea = All;
            }
            field("No. of Orders"; "No. of Orders")
            {
                Caption = 'Orders', Comment = 'FRA="Commandes"';
                DrillDownPageID = "Sales Order List";
                ApplicationArea = All;
            }
            field("No. of Blanket Orders"; "No. of Blanket Orders")
            {
                Caption = 'Blanket Orders', Comment = 'FRA="Commandes ouvertes"';
                DrillDownPageID = "Blanket Sales Orders";
                ApplicationArea = All;
            }
            field("No. of Invoices"; "No. of Invoices")
            {
                Caption = 'Invoices', Comment = 'FRA="Factures"';
                DrillDownPageID = "Sales Invoice List";
                ApplicationArea = All;
            }
            field("No. of Return Orders"; "No. of Return Orders")
            {
                Caption = 'Return Orders', Comment = 'FRA="Retours"';
                DrillDownPageID = "Sales Return Order List";
                ApplicationArea = All;
            }
            field("No. of Credit Memos"; "No. of Credit Memos")
            {
                Caption = 'Credit Memos', Comment = 'FRA="Avoirs"';
                DrillDownPageID = "Sales Credit Memos";
                ApplicationArea = All;
            }
            field("No. of Pstd. Shipments"; "No. of Pstd. Shipments")
            {
                Caption = 'Pstd. Shipments', Comment = 'FRA="Expéditions enreg."';
                DrillDownPageID = "Posted Sales Shipments";
                ApplicationArea = All;
            }
            field("No. of Pstd. Invoices"; "No. of Pstd. Invoices")
            {
                Caption = 'Pstd. Invoices', Comment = 'FRA="Factures enreg."';
                DrillDownPageID = "Posted Sales Invoices";
                ApplicationArea = All;
            }
            field("No. of Pstd. Return Receipts"; "No. of Pstd. Return Receipts")
            {
                Caption = 'Pstd. Return Receipts', Comment = 'FRA="Réceptions retour enreg."';
                DrillDownPageID = "Posted Return Receipts";
                ApplicationArea = All;
            }
            field("No. of Pstd. Credit Memos"; "No. of Pstd. Credit Memos")
            {
                Caption = 'Pstd. Credit Memos', Comment = 'FRA="Réceptions retour enreg."';
                DrillDownPageID = "Posted Sales Credit Memos";
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Customer Card", Rec);
    end;
}

