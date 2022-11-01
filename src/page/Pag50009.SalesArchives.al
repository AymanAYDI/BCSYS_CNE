page 50009 "BC6_Sales Archives"
{
    Caption = 'Sales Orders';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field("Line Discount %"; "Line Discount %")
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
                Caption = '&Line';
                action("Show Order")
                {
                    Caption = 'Show Order';
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

