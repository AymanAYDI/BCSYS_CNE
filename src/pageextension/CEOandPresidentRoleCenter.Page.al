page 9019 "CEO and President Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 762)
                {
                }
                part(; 762)
                {
                    Visible = false;
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
                part(; 869)
                {
                }
                part(; 770)
                {
                }
                part(; 770)
                {
                    Visible = false;
                }
                part(; 681)
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
                part(; 9152)
                {
                    Visible = false;
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
            action("Recei&vables-Payables")
            {
                Caption = 'Recei&vables-Payables';
                Image = ReceivablesPayables;
                RunObject = Report 5;
            }
            action("&Trial Balance/Budget")
            {
                Caption = '&Trial Balance/Budget';
                Image = "Report";
                RunObject = Report 9;
            }
            action("&Closing Trial Balance")
            {
                Caption = '&Closing Trial Balance';
                Image = "Report";
                RunObject = Report 10;
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report 36;
            }
            separator()
            {
            }
            action("Customer - &Balance")
            {
                Caption = 'Customer - &Balance';
                Image = "Report";
                RunObject = Report 121;
            }
            action("Customer - T&op 10 List")
            {
                Caption = 'Customer - T&op 10 List';
                Image = "Report";
                RunObject = Report 111;
            }
            action("Customer - S&ales List")
            {
                Caption = 'Customer - S&ales List';
                Image = "Report";
                RunObject = Report 119;
            }
            action("Sales &Statistics")
            {
                Caption = 'Sales &Statistics';
                Image = "Report";
                RunObject = Report 112;
            }
            separator()
            {
            }
            action("Vendor - &Purchase List")
            {
                Caption = 'Vendor - &Purchase List';
                Image = "Report";
                RunObject = Report 309;
            }
        }
        area(embedding)
        {
            action("Account Schedules")
            {
                Caption = 'Account Schedules';
                RunObject = Page 103;
            }
            action("Analysis by Dimensions")
            {
                Caption = 'Analysis by Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page 556;
            }
            action("Sales Analysis Report")
            {
                Caption = 'Sales Analysis Report';
                RunObject = Page 9376;
                RunPageView = WHERE (Analysis Area=FILTER(Sales));
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                RunObject = Page 121;
            }
            action("Sales Budgets")
            {
                Caption = 'Sales Budgets';
                RunObject = Page 7132;
                                RunPageView = WHERE(Analysis Area=FILTER(Sales));
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
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Contacts)
            {
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page 5052;
            }
        }
        area(sections)
        {
        }
    }
}

