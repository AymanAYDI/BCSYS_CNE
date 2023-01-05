page 50009 "BC6_Sales Archives"
{
    Caption = 'Sales Orders', comment = 'FRA="Liste commande historiques"';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
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
                Caption = '&Line', comment = 'FRA="&Ligne"';
                action("Show Order")
                {
                    Caption = 'Show Order', comment = 'FRA="Afficher commande"';
                    Image = "Order";
                    RunObject = Page "Sales Order Archive";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("Document No.");
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }
}

