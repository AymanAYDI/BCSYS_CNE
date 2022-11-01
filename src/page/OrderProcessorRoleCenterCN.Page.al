page 50073 "Order Processor Role Center CN"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9060)
                {
                }
                systempart(; Outlook)
                {
                }
            }
            group()
            {
                part(; 760)
                {
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9150)
                {
                }
                part(; 9152)
                {
                }
                systempart(; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report 107;
            }
            action("Customer - &Top 10 List")
            {
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report 111;
            }
            action("Customer/&Item Sales")
            {
                Caption = 'Customer/&Item Sales';
                Image = "Report";
                RunObject = Report 113;
            }
            separator()
            {
            }
            action("Salesperson - Sales &Statistics")
            {
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report 114;
            }
            action("Price &List")
            {
                Caption = 'Price &List';
                Image = "Report";
                RunObject = Report 715;
            }
            separator()
            {
            }
            action("Inventory - Sales &Back Orders")
            {
                Caption = 'Inventory - Sales &Back Orders';
                Image = "Report";
                RunObject = Report 718;
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action("Shipped Not Invoiced")
            {
                Caption = 'Shipped Not Invoiced';
                RunObject = Page 9305;
                RunPageView = WHERE (Shipped Not Invoiced=CONST(Yes));
            }
            action("Completely Shipped Not Invoiced")
            {
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page 9305;
                RunPageView = WHERE (Completely Shipped=CONST(Yes),
                                    Invoice=CONST(No));
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page 9300;
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page 9303;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page 9304;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page 9302;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                RunObject = Page 262;
                RunPageView = WHERE (Template Type=CONST(Item),
                                    Recurring=CONST(No));
            }
            action("Sales Journals")
            {
                Caption = 'Sales Journals';
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Sales),
                                    Recurring=CONST(No));
            }
            action("Cash Receipt Journals")
            {
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Cash Receipts),
                                    Recurring=CONST(No));
            }
            action("Liste des sessions")
            {
                RunObject = Page 9506;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page 142;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page 144;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page 145;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 146;
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                Caption = 'Sales &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 41;
                RunPageMode = Create;
            }
            action("Sales &Invoice")
            {
                Caption = 'Sales &Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 43;
                RunPageMode = Create;
            }
            action("Sales &Order")
            {
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                RunPageMode = Create;
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 6630;
                RunPageMode = Create;
            }
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Sales &Journal")
            {
                Caption = 'Sales &Journal';
                Image = Journals;
                RunObject = Page 253;
            }
            action("Sales Price &Worksheet")
            {
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page 7023;
            }
            separator()
            {
            }
            action("Sales &Prices")
            {
                Caption = 'Sales &Prices';
                Image = SalesPrices;
                RunObject = Page 7002;
            }
            action("Sales &Line Discounts")
            {
                Caption = 'Sales &Line Discounts';
                Image = SalesLineDisc;
                RunObject = Page 7004;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page 344;
            }
        }
    }
}

