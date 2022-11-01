page 50062 "Order Processor RC Admin"
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
                    AccessByPermission = TableData 110 = R;
                    ApplicationArea = Basic, Suite;
                }
                part(; 50112)
                {
                    Description = 'BCSYS';
                }
                part(; 9042)
                {
                    ApplicationArea = Suite;
                }
                part(; 9150)
                {
                    ApplicationArea = Basic, Suite;
                }
                part(; 6303)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group()
            {
                part(; 760)
                {
                    AccessByPermission = TableData 110 = R;
                    ApplicationArea = Basic, Suite;
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9152)
                {
                    AccessByPermission = TableData 9152 = R;
                    ApplicationArea = Basic, Suite;
                }
                part(; 681)
                {
                    AccessByPermission = TableData 477 = R;
                    ApplicationArea = Suite;
                }
                systempart(; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.';
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
                ToolTip = 'Open the list of sales orders where you can sell items and services.';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipped Not Invoiced';
                RunObject = Page 9305;
                RunPageView = WHERE (Shipped Not Invoiced=CONST(Yes));
                ToolTip = 'View sales that are shipped but not yet invoiced.';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page 9305;
                RunPageView = WHERE (Completely Shipped=CONST(Yes),
                                    Invoice=CONST(No));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.';
            }
            action("Dynamics CRM Sales Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Dynamics CRM Sales Orders';
                RunObject = Page 5353;
                RunPageView = WHERE (StateCode = FILTER (Submitted),
                                    LastBackofficeSubmit = FILTER (''));
                ToolTip = 'View sales orders in Dynamics CRM that are coupled with sales orders in Dynamics NAV.';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page 9300;
                ToolTip = 'Open the list of sales quotes where you offer items or services to customers.';
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page 9303;
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
                ToolTip = 'Open the list of sales invoices where you can invoice items or services.';
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page 9304;
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos';
                RunObject = Page 9302;
                ToolTip = 'Open the list of sales credit memos where you can revert posted sales invoices.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
                ToolTip = 'Open the list of items that you trade in.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
                ToolTip = 'Open the list of customers.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page 262;
                RunPageView = WHERE (Template Type=CONST(Item),
                                    Recurring=CONST(No));
                ToolTip = 'Open a list of journals where you can adjust the physical quantity of items on inventory.';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journals';
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Sales),
                                    Recurring=CONST(No));
                ToolTip = 'Open the list of sales journals where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page 251;
                RunPageView = WHERE (Template Type=CONST(Cash Receipts),
                                    Recurring=CONST(No));
                ToolTip = 'Register received payments by applying them to the related customer, vendor, or bank ledger entries.';
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page 142;
                    ToolTip = 'View the posted sales shipments.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                    ToolTip = 'View the posted sales invoices.';
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page 144;
                    ToolTip = 'View the posted sales credit memos.';
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page 145;
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 146;
                    ToolTip = 'View the posted purchase invoices.';
                }
            }
            group("Self-Service")
            {
                Caption = 'Self-Service';
                Image = HumanResources;
                ToolTip = 'Manage your time sheets and assignments.';
                action("Time Sheets")
                {
                    ApplicationArea = Suite;
                    Caption = 'Time Sheets';
                    Gesture = None;
                    RunObject = Page 951;
                    ToolTip = 'View all time sheets.';
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Quote';
                Image = NewSalesQuote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 41;
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
            action("Sales &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Invoice';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 43;
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for items or services. Invoice quantities cannot be posted partially.';
            }
            action("Sales &Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services that require partial posting.';
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
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
        }
        area(processing)
        {
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                action(IntItem)
                {
                    Caption = 'Item intégration';
                    Image = ImportCodes;
                    RunObject = Page 50023;
                }
                action(UpdatePartner)
                {
                    Caption = 'Update IC Partner Purch. Price';
                    Image = UpdateUnitCost;
                    RunObject = Report 50023;
                }
                action(ExportTarif)
                {
                    Caption = 'Export Purchase Price';
                    Image = Export;
                    RunObject = XMLport 50000;
                }
                action(BlockItem)
                {
                    Caption = 'Batch Traitement Article';
                    Image = Reject;
                    RunObject = Report 50020;
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Sales &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales &Journal';
                    Image = Journals;
                    RunObject = Page 253;
                    ToolTip = 'Open a sales journal where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.';
                }
                action("Sales Price &Worksheet")
                {
                    Caption = 'Sales Price &Worksheet';
                    Image = PriceWorksheet;
                    RunObject = Page 7023;
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                action("&Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Prices';
                    Image = SalesPrices;
                    RunObject = Page 7002;
                    ToolTip = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                action("&Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Line Discounts';
                    Image = SalesLineDisc;
                    RunObject = Page 7004;
                    ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group(Customer)
                {
                    Caption = 'Customer';
                    Image = Customer;
                    action("Customer - &Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Order Summary';
                        Image = "Report";
                        RunObject = Report 107;
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List';
                        Image = "Report";
                        RunObject = Report 111;
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer/&Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/&Item Sales';
                        Image = "Report";
                        RunObject = Report 113;
                        ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                    }
                }
                group(Sales)
                {
                    Caption = 'Sales';
                    Image = Sales;
                    action("Salesperson - Sales &Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson - Sales &Statistics';
                        Image = "Report";
                        RunObject = Report 114;
                        ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
                    }
                    action("Price &List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Price &List';
                        Image = "Report";
                        RunObject = Report 715;
                        ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                    }
                    action("Inventory - Sales &Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales &Back Orders';
                        Image = "Report";
                        RunObject = Report 718;
                        ToolTip = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.';
                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page 344;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
    }
}

