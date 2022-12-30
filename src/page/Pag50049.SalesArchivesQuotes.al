page 50049 "BC6_Sales Archives - Quotes"
{
    Caption = 'Sales Quotes', Comment = 'FRA="Liste devis historiques"';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Document Type" = FILTER(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                action("Show Order")
                {
                    Caption = 'Show Order', Comment = 'FRA="Afficher commande"';
                    Image = "Order";
                    RunObject = Page "Sales Order Archive";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("Document No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
            }
        }
    }
}

