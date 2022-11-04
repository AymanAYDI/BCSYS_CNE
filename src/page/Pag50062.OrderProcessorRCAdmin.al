page 50062 "BC6_Order Processor RC Admin"
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
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("Purchase Return Order Cue"; "Purchase Return Order Cue")
                {
                    Description = 'BCSYS';
                }
                part("Team Member Activities"; "Team Member Activities")
                {
                    ApplicationArea = Suite;
                }
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = Basic, Suite;
                }
                part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control2)
            {
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                }
                part("My Items"; "My Items")
                {
                    AccessByPermission = TableData "My Item" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("Report Inbox Part"; "Report Inbox Part")
                {
                    AccessByPermission = TableData "Report Inbox" = R;
                    ApplicationArea = Suite;
                }
                systempart("MyNotes"; MyNotes)
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
                RunObject = Page "Sales Order List";
                ToolTip = 'Open the list of sales orders where you can sell items and services.';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales that are shipped but not yet invoiced.';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.';
            }
            action("Dynamics CRM Sales Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Dynamics CRM Sales Orders';
                RunObject = Page "CRM Sales Order List";
                RunPageView = WHERE(StateCode = FILTER(Submitted),
                                    LastBackofficeSubmit = FILTER(''));
                ToolTip = 'View sales orders in Dynamics CRM that are coupled with sales orders in Dynamics NAV.';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Open the list of sales quotes where you offer items or services to customers.';
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page "Blanket Sales Orders";
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Open the list of sales invoices where you can invoice items or services.';
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ToolTip = 'Open the list of sales credit memos where you can revert posted sales invoices.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Open the list of items that you trade in.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'Open the list of customers.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Open a list of journals where you can adjust the physical quantity of items on inventory.';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ToolTip = 'Open the list of sales journals where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
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
                    RunObject = Page "Time Sheet List";
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
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true' TODO:
                //PromotedCategory = Process;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
            action("Sales &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Invoice';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true' TODO:
                //PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for items or services. Invoice quantities cannot be posted partially.';
            }
            action("Sales &Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true' TODO:
                //PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services that require partial posting.';
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true' TODO:
                //PromotedCategory = Process;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
            }
            action("Sales &Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true' TODO:
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
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
                    RunObject = Page "BC6_Intégration article";
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
                    RunObject = Page "Sales Journal";
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
                        RunObject = Report "Customer - Order Summary";
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer/&Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/&Item Sales';
                        Image = "Report";
                        RunObject = Report "Customer/Item Sales";
                        ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                    }
                }
                group(Sales2)
                {
                    Caption = 'Sales';
                    Image = Sales;
                    action("Salesperson - Sales &Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson - Sales &Statistics';
                        Image = "Report";
                        RunObject = Report "Salesperson - Sales Statistics";
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
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
    }
}

