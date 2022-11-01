page 50049 "Sales Archives - Quotes"
{
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Cde] Creation du FORM

    Caption = 'Sales Quotes';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = Table5108;
    SourceTableView = WHERE (Document Type=FILTER(Quote));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Version No.";"Version No.")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Shipment Date";"Shipment Date")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Currency Code";"Currency Code")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Outstanding Quantity";"Outstanding Quantity")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field(Amount;Amount)
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Line Discount %";"Line Discount %")
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
                    RunObject = Page 5159;
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(Document No.);
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }
}

