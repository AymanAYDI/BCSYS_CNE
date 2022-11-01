page 60080 "Sales Hist. Sell-to FactBo STD"
{
    Caption = 'Sell-to Customer Sales History';
    PageType = CardPart;
    SourceTable = Table18;

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                Caption = 'Customer No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field("No. of Quotes"; "No. of Quotes")
            {
                Caption = 'Quotes';
                DrillDownPageID = "Sales Quotes";
            }
            field("No. of Orders"; "No. of Orders")
            {
                Caption = 'Orders';
                DrillDownPageID = "Sales Order List";
            }
            field("No. of Blanket Orders"; "No. of Blanket Orders")
            {
                Caption = 'Blanket Orders';
                DrillDownPageID = "Blanket Sales Orders";
            }
            field("No. of Invoices"; "No. of Invoices")
            {
                Caption = 'Invoices';
                DrillDownPageID = "Sales Invoice List";
            }
            field("No. of Return Orders"; "No. of Return Orders")
            {
                Caption = 'Return Orders';
                DrillDownPageID = "Sales Return Order List";
            }
            field("No. of Credit Memos"; "No. of Credit Memos")
            {
                Caption = 'Credit Memos';
                DrillDownPageID = "Sales Credit Memos";
            }
            field("No. of Pstd. Shipments"; "No. of Pstd. Shipments")
            {
                Caption = 'Pstd. Shipments';
                DrillDownPageID = "Posted Sales Shipments";
            }
            field("No. of Pstd. Invoices"; "No. of Pstd. Invoices")
            {
                Caption = 'Pstd. Invoices';
                DrillDownPageID = "Posted Sales Invoices";
            }
            field("No. of Pstd. Return Receipts"; "No. of Pstd. Return Receipts")
            {
                Caption = 'Pstd. Return Receipts';
                DrillDownPageID = "Posted Return Receipts";
            }
            field("No. of Pstd. Credit Memos"; "No. of Pstd. Credit Memos")
            {
                Caption = 'Pstd. Credit Memos';
                DrillDownPageID = "Posted Sales Credit Memos";
            }
        }
    }

    actions
    {
    }

    [Scope('Internal')]
    procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Customer Card", Rec);
    end;
}

