page 60080 "BC6_Sales Hist Sellto Fact STD"
{
    Caption = 'Sell-to Customer Sales History', Comment = 'FRA="Historique des ventes - donneur d''ordre"';
    PageType = CardPart;
    SourceTable = Customer;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = 'Customer No.', Comment = 'FRA="N° client"';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("No. of Quotes"; Rec."No. of Quotes")
            {
                ApplicationArea = All;
                Caption = 'Quotes', Comment = 'FRA="Devis"';
                DrillDownPageID = "Sales Quotes";
            }
            field("No. of Orders"; Rec."No. of Orders")
            {
                ApplicationArea = All;
                Caption = 'Orders', Comment = 'FRA="Commandes"';
                DrillDownPageID = "Sales Order List";
            }
            field("No. of Blanket Orders"; Rec."No. of Blanket Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Orders', Comment = 'FRA="Commandes ouvertes"';
                DrillDownPageID = "Blanket Sales Orders";
            }
            field("No. of Invoices"; Rec."No. of Invoices")
            {
                ApplicationArea = All;
                Caption = 'Invoices', Comment = 'FRA="Factures"';
                DrillDownPageID = "Sales Invoice List";
            }
            field("No. of Return Orders"; Rec."No. of Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Return Orders', Comment = 'FRA="Retours"';
                DrillDownPageID = "Sales Return Order List";
            }
            field("No. of Credit Memos"; Rec."No. of Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Credit Memos', Comment = 'FRA="Avoirs"';
                DrillDownPageID = "Sales Credit Memos";
            }
            field("No. of Pstd. Shipments"; Rec."No. of Pstd. Shipments")
            {
                ApplicationArea = All;
                Caption = 'Pstd. Shipments', Comment = 'FRA="Expéditions enreg."';
                DrillDownPageID = "Posted Sales Shipments";
            }
            field("No. of Pstd. Invoices"; Rec."No. of Pstd. Invoices")
            {
                ApplicationArea = All;
                Caption = 'Pstd. Invoices', Comment = 'FRA="Factures enreg."';
                DrillDownPageID = "Posted Sales Invoices";
            }
            field("No. of Pstd. Return Receipts"; Rec."No. of Pstd. Return Receipts")
            {
                ApplicationArea = All;
                Caption = 'Pstd. Return Receipts', Comment = 'FRA="Réceptions retour enreg."';
                DrillDownPageID = "Posted Return Receipts";
            }
            field("No. of Pstd. Credit Memos"; Rec."No. of Pstd. Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Pstd. Credit Memos', Comment = 'FRA="Réceptions retour enreg."';
                DrillDownPageID = "Posted Sales Credit Memos";
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
