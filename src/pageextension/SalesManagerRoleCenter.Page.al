page 9005 "Sales Manager Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9175)
                {
                }
                part(; 9150)
                {
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                part(; 770)
                {
                }
                part(; 760)
                {
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9151)
                {
                    Visible = false;
                }
                part(; 681)
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
            separator()
            {
            }
            action("S&ales Statistics")
            {
                Caption = 'S&ales Statistics';
                Image = "Report";
                RunObject = Report 112;
            }
            action("Salesperson - Sales &Statistics")
            {
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report 114;
            }
            action("Salesperson - &Commission")
            {
                Caption = 'Salesperson - &Commission';
                Image = "Report";
                RunObject = Report 115;
            }
            separator()
            {
            }
            action("Campaign - &Details")
            {
                Caption = 'Campaign - &Details';
                Image = "Report";
                RunObject = Report 5060;
            }
        }
        area(embedding)
        {
            action("Sales Analysis Reports")
            {
                Caption = 'Sales Analysis Reports';
                RunObject = Page 9376;
            }
            action("Sales Analysis by Dimensions")
            {
                Caption = 'Sales Analysis by Dimensions';
                RunObject = Page 9371;
            }
            action("Sales Budgets")
            {
                Caption = 'Sales Budgets';
                RunObject = Page 9374;
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page 9300;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action(Open)
            {
                Caption = 'Open';
                Image = Edit;
                RunObject = Page 9305;
                RunPageView = WHERE (Status = FILTER (Open));
                ShortCutKey = 'Return';
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action(Open)
            {
                Caption = 'Open';
                Image = Edit;
                RunObject = Page 9301;
                RunPageView = WHERE (Status = FILTER (Open));
                ShortCutKey = 'Return';
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action(Contacts)
            {
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page 5052;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Campaigns)
            {
                Caption = 'Campaigns';
                Image = Campaign;
                RunObject = Page 5087;
            }
            action(Segments)
            {
                Caption = 'Segments';
                Image = Segment;
                RunObject = Page 5093;
            }
            action("To-dos")
            {
                Caption = 'To-dos';
                Image = TaskList;
                RunObject = Page 5096;
            }
            action(Teams)
            {
                Caption = 'Teams';
                Image = TeamSales;
                RunObject = Page 5105;
            }
        }
        area(sections)
        {
            group("Administration Sales/Purchase")
            {
                Caption = 'Administration Sales/Purchase';
                Image = AdministrationSalesPurchases;
                action("Salespeople/Purchasers")
                {
                    Caption = 'Salespeople/Purchasers';
                    RunObject = Page 14;
                }
                action("Cust. Invoice Discounts")
                {
                    Caption = 'Cust. Invoice Discounts';
                    RunObject = Page 23;
                }
                action("Vend. Invoice Discounts")
                {
                    Caption = 'Vend. Invoice Discounts';
                    RunObject = Page 28;
                }
                action("Item Disc. Groups")
                {
                    Caption = 'Item Disc. Groups';
                    RunObject = Page 513;
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
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
            action("Sales Line &Discounts")
            {
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
                RunObject = Page 7004;
            }
        }
    }
}

