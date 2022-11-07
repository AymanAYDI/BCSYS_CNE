page 9022 "Small Business Role Center"
{
    Caption = 'Small Business Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 1310)
                {
                    AccessByPermission = TableData 17 = R;
                }
                part("Favorite Customers"; 1374)
                {
                    Caption = 'Favorite Customers';
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                part(; 1390)
                {
                    AccessByPermission = TableData 84 = R;
                }
                part(; 1393)
                {
                    AccessByPermission = TableData 17 = R;
                }
                part(; 681)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                action("Sales Quote")
                {
                    Caption = 'Sales Quote';
                    Image = Quote;
                    RunObject = Page 1324;
                    RunPageMode = Create;
                    ToolTip = 'Create a new sales quote';
                }
                action("Sales Invoice")
                {
                    Caption = 'Sales Invoice';
                    Image = NewInvoice;
                    RunObject = Page 1304;
                    RunPageMode = Create;
                    ToolTip = 'Create a new sales invoice.';
                }
                action("Purchase Invoice")
                {
                    Caption = 'Purchase Invoice';
                    Image = NewInvoice;
                    RunObject = Page 1354;
                    RunPageMode = Create;
                    ToolTip = 'Create a new purchase invoice.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                action("Payment Registration")
                {
                    Caption = 'Payment Registration';
                    Image = Payment;
                    RunObject = Page 981;
                    ToolTip = 'Process your customer''s payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post and apply the payments to your books.';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                group(Setup)
                {
                    Caption = 'Setup';
                    Image = Setup;
                    action("Company Information")
                    {
                        Caption = 'Company Information';
                        Image = CompanyInformation;
                        RunObject = Page 1352;
                        ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                    }
                    action("General Ledger Setup")
                    {
                        Caption = 'General Ledger Setup';
                        Image = JournalSetup;
                        RunObject = Page 1348;
                        ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    }
                    action("Sales & Receivables Setup")
                    {
                        Caption = 'Sales & Receivables Setup';
                        Image = ReceivablesPayablesSetup;
                        RunObject = Page 1350;
                        ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    }
                    action("Purchases & Payables Setup")
                    {
                        Caption = 'Purchases & Payables Setup';
                        Image = Purchase;
                        RunObject = Page 1349;
                        ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    }
                    action("Inventory Setup")
                    {
                        Caption = 'Inventory Setup';
                        Image = InventorySetup;
                        RunObject = Page 1351;
                        ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
                    }
                    action("Fixed Assets Setup")
                    {
                        Caption = 'Fixed Assets Setup';
                        Image = FixedAssets;
                        RunObject = Page 1353;
                        ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    }
                    action("Human Resources Setup")
                    {
                        Caption = 'Human Resources Setup';
                        Image = HRSetup;
                        RunObject = Page 5233;
                        ToolTip = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.';
                    }
                    action("Jobs Setup")
                    {
                        Caption = 'Jobs Setup';
                        Image = Job;
                        RunObject = Page 463;
                    }
                }
            }
            group("Getting Started")
            {
                Caption = 'Getting Started';
                action("Show/Hide Getting Started")
                {
                    Caption = 'Show/Hide Getting Started';
                    Image = Help;
                    RunObject = Codeunit 1321;
                }
            }
        }
        area(embedding)
        {
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = Page 1301;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                RunObject = Page 1331;
            }
            action(Items)
            {
                Caption = 'Items';
                RunObject = Page 1303;
            }
            action("Posted Sales Invoices")
            {
                Caption = 'Posted Sales Invoices';
                RunObject = Page 1309;
            }
            action(PostedPurchaseInvoices)
            {
                Caption = 'Posted Purchase Invoices';
                RunObject = Page 1359;
            }
            action("Ongoing Sales Quotes")
            {
                Caption = 'Ongoing Sales Quotes';
                RunObject = Page 1326;
            }
        }
        area(sections)
        {
            group(Bookkeeping)
            {
                Caption = 'Bookkeeping';
                Image = Journals;
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(General),Recurring=CONST(No));
                }
                action("Chart of Accounts")
                {
                    Caption = 'Chart of Accounts';
                    RunObject = Page 16;
                }
                action("G/L Budgets")
                {
                    Caption = 'G/L Budgets';
                    RunObject = Page 121;
                }
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page 5601;
                }
                action(Employees)
                {
                    Caption = 'Employees';
                    RunObject = Page 5201;
                }
                action("Cash Receipt Journals")
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(Cash Receipts),Recurring=CONST(No));
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(Payments),Recurring=CONST(No));
                }
                action("Sales Invoices")
                {
                    Caption = 'Sales Invoices';
                    RunObject = Page 1306;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page 1309;
                }
                action("Sales Credit Memos")
                {
                    Caption = 'Sales Credit Memos';
                    RunObject = Page 1317;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page 1321;
                }
                action(Reminders)
                {
                    Caption = 'Reminders';
                    Image = Reminder;
                    RunObject = Page 436;
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Finance Charge Memos")
                {
                    Caption = 'Finance Charge Memos';
                    Image = FinChargeMemo;
                    RunObject = Page 448;
                }
                action("Issued Finance Charge Memos")
                {
                    Caption = 'Issued Finance Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page 452;
                }
                action("<Page Mini Purchase Invoices>")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page 1356;
                }
                action("<Page Mini Posted Purchase Invoices>")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 1359;
                }
                action("<Page Mini Purchase Credit Memos>")
                {
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page 1367;
                }
                action("<Page Mini Posted Purchase Credit Memos>")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page 1371;
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                Image = AnalysisView;
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = Page 103;
                }
                action("Sales Analysis Reports")
                {
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page 9376;
                }
                action("Purchase Analysis Reports")
                {
                    Caption = 'Purchase Analysis Reports';
                    RunObject = Page 9375;
                }
                action("Inventory Analysis Reports")
                {
                    Caption = 'Inventory Analysis Reports';
                    RunObject = Page 9377;
                }
                action("VAT Reports")
                {
                    Caption = 'VAT Reports';
                    RunObject = Page 744;
                }
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page 849;
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page 851;
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page 857;
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page 859;
                }
            }
            group("Bank & Payments")
            {
                Caption = 'Bank & Payments';
                Image = Bank;
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page 371;
                }
                action("Bank Acc. Reconciliations")
                {
                    Caption = 'Bank Acc. Reconciliations';
                    Image = BankAccountRec;
                    RunObject = Page 388;
                }
                action("Bank Acc. Statements")
                {
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page 389;
                }
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(General),Recurring=CONST(No));
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(Payments),Recurring=CONST(No));
                }
                action("Cash Receipt Journals")
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE (Template Type=CONST(Cash Receipts),Recurring=CONST(No));
                }
                action(Currencies)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page 5;
                }
                action("Direct Debit Collections")
                {
                    Caption = 'Direct Debit Collections';
                    RunObject = Page 1207;
                }
            }
            group(Jobs)
            {
                Caption = 'Jobs';
                Image = Job;
                action(Jobs)
                {
                    Caption = 'Jobs';
                    Image = Job;
                    RunObject = Page 89;
                }
                action("On Order")
                {
                    Caption = 'On Order';
                    RunObject = Page 89;
                    RunPageView = WHERE (Status = FILTER (Order));
                }
                action("Planned and Quoted")
                {
                    Caption = 'Planned and Quoted';
                    RunObject = Page 89;
                    RunPageView = WHERE (Status = FILTER (Quote | Planning));
                }
                action(Completed)
                {
                    Caption = 'Completed';
                    RunObject = Page 89;
                    RunPageView = WHERE (Status = FILTER (Completed));
                }
                action(Unassigned)
                {
                    Caption = 'Unassigned';
                    RunObject = Page 89;
                    RunPageView = WHERE (Person Responsible=FILTER(''));
                }
                action("Job Tasks")
                {
                    Caption = 'Job Tasks';
                    RunObject = Page 1004;
                }
                action("Sales Invoices")
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Sales Invoices';
                    RunObject = Page 1306;
                }
                action("Sales Credit Memos")
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page 1317;
                }
                action(Resources)
                {
                    Caption = 'Resources';
                    RunObject = Page 77;
                }
                action("Resource Groups")
                {
                    Caption = 'Resource Groups';
                    RunObject = Page 72;
                }
                action(MiniPurchasesInvoices)
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Purchase Invoices';
                    RunObject = Page 1356;
                }
                action(MiniCreditMemos)
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page 1367;
                }
                action(Items)
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Items';
                    RunObject = Page 1303;
                }
                action(Customers)
                {
                    AccessByPermission = TableData 167=R;
                    Caption = 'Customers';
                    RunObject = Page 1301;
                }
                action("Time Sheets")
                {
                    Caption = 'Time Sheets';
                    RunObject = Page 951;
                }
            }
            group("VAT Reporting")
            {
                Caption = 'VAT Reporting';
                Image = Statistics;
                action("VAT Statements")
                {
                    Caption = 'VAT Statements';
                    RunObject = Page 320;
                }
                action("Intrastat Journals")
                {
                    Caption = 'Intrastat Journals';
                    RunObject = Page 327;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page 1309;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page 1321;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 146;
                }
            }
        }
    }
}

