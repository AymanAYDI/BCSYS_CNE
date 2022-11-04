page 50073 "Order Processor Role Center CN"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1)
            {
                part("SO Processor Activities"; "SO Processor Activities")
                {
                }
                systempart("Outlook"; Outlook)
                {
                }
            }
            group(Control2)
            {
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                }
                part("My Customers"; "My Customers")
                {
                }
                part("My Items"; "My Items")
                {
                }
                systempart("MyNotes"; MyNotes)
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
                RunObject = Report "Customer - Order Summary";
            }
            action("Customer - &Top 10 List")
            {
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
            }
            action("Customer/&Item Sales")
            {
                Caption = 'Customer/&Item Sales';
                Image = "Report";
                RunObject = Report "Customer/Item Sales";
            }
            separator(Action17)
            {
            }
            action("Salesperson - Sales &Statistics")
            {
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
            }
            action("Price &List")
            {
                Caption = 'Price &List';
                Image = "Report";
                RunObject = Report 715;
            }
            separator(Action22)
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
                RunObject = Page "Sales Order List";
            }
            action("Shipped Not Invoiced")
            {
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
            }
            action("Completely Shipped Not Invoiced")
            {
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page "Blanket Sales Orders";
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
            }
            action("Sales Journals")
            {
                Caption = 'Sales Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
            }
            action("Cash Receipt Journals")
            {
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
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
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
            }
            action("Sales &Invoice")
            {
                Caption = 'Sales &Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
            }
            action("Sales &Order")
            {
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
            }
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
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
                RunObject = Page "Sales Journal";
            }
            action("Sales Price &Worksheet")
            {
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page 7023;
            }
            separator(Action42)
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
                RunObject = Page Navigate;
            }
        }
    }
}
