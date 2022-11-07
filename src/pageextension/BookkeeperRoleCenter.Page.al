page 9004 "Bookkeeper Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9036)
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
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9151)
                {
                }
                part(; 681)
                {
                }
                part(; 9175)
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
            action("A&ccount Schedule")
            {
                Caption = 'A&ccount Schedule';
                Image = "Report";
                RunObject = Report 25;
            }
            action("FR Account Schedule")
            {
                Caption = 'FR Account Schedule';
                Image = "Report";
                RunObject = Report 10811;
            }
            action("G/L Account Statement")
            {
                Caption = 'G/L Account Statement';
                Image = "Report";
                RunObject = Report 10842;
            }
            group("&Trial Balance")
            {
                Caption = '&Trial Balance';
                Image = Balance;
                action("&G/L Trial Balance")
                {
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report 10803;
                }
                action("G/L Detail Trial Balance")
                {
                    Caption = 'G/L Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report 10804;
                }
                action("Bank Trial Balance")
                {
                    Caption = 'Bank Trial Balance';
                    Image = "Report";
                    RunObject = Report 10809;
                }
                action("Bank &Detail Trial Balance")
                {
                    Caption = 'Bank &Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report 10810;
                }
                action("T&rial Balance/Budget")
                {
                    Caption = 'T&rial Balance/Budget';
                    Image = "Report";
                    RunObject = Report 9;
                }
                action("Trial Balance by &Period")
                {
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report 38;
                }
                action("Closing Tria&l Balance")
                {
                    Caption = 'Closing Tria&l Balance';
                    Image = "Report";
                    RunObject = Report 10;
                }
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report 36;
            }
            action("Balance C&omp. . Prev. Year")
            {
                Caption = 'Balance C&omp. . Prev. Year';
                Image = "Report";
                RunObject = Report 37;
            }
            separator()
            {
            }
            action("&Aged Accounts Receivable")
            {
                Caption = '&Aged Accounts Receivable';
                Image = "Report";
                RunObject = Report 120;
            }
            action("Aged Accou&nts Payable")
            {
                Caption = 'Aged Accou&nts Payable';
                Image = "Report";
                RunObject = Report 322;
            }
            action("Reconcile Cust. and &Vend. Accs")
            {
                Caption = 'Reconcile Cust. and &Vend. Accs';
                Image = "Report";
                RunObject = Report 33;
            }
            separator()
            {
            }
            action("VAT Reg&istration No. Check")
            {
                Caption = 'VAT Reg&istration No. Check';
                Image = "Report";
                RunObject = Report 32;
            }
            action("VAT E&xceptions")
            {
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report 31;
            }
            action("VAT State&ment")
            {
                Caption = 'VAT State&ment';
                Image = "Report";
                RunObject = Report 12;
            }
            action("VAT - VI&ES Declaration Tax Auth")
            {
                Caption = 'VAT - VI&ES Declaration Tax Auth';
                Image = "Report";
                RunObject = Report 19;
            }
            action("VAT - VIES Declaration Dis&k")
            {
                Caption = 'VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report 88;
            }
            action("EC &Sales List")
            {
                Caption = 'EC &Sales List';
                Image = "Report";
                RunObject = Report 130;
            }
            separator()
            {
            }
            action(Journals)
            {
                Caption = 'Journals';
                Image = "Report";
                RunObject = Report 10801;
            }
            action("Customer Journal")
            {
                Caption = 'Customer Journal';
                Image = "Report";
                RunObject = Report 10813;
            }
            action("Vendor Journal")
            {
                Caption = 'Vendor Journal';
                Image = "Report";
                RunObject = Report 10814;
            }
            action("Bank Account Journal")
            {
                Caption = 'Bank Account Journal';
                Image = "Report";
                RunObject = Report 10815;
            }
            separator()
            {
            }
            action("Payments Lists")
            {
                Caption = 'Payments Lists';
                Image = "Report";
                RunObject = Report 10860;
            }
            action("GL/Cust. Ledger Reconciliation")
            {
                Caption = 'GL/Cust. Ledger Reconciliation';
                Image = "Report";
                RunObject = Report 10861;
            }
            action("GL/Vend. Ledger Reconciliation")
            {
                Caption = 'GL/Vend. Ledger Reconciliation';
                Image = "Report";
                RunObject = Report 10863;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page 16;
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page 371;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page 22;
                RunPageView = WHERE (Balance (LCY)=FILTER(<>0));
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page 27;
                                RunPageView = WHERE(Balance (LCY)=FILTER(<>0));
            }
            action("Payment on Hold")
            {
                Caption = 'Payment on Hold';
                RunObject = Page 27;
                                RunPageView = WHERE(Blocked=FILTER(Payment));
            }
            action("VAT Statements")
            {
                Caption = 'VAT Statements';
                RunObject = Page 320;
            }
            action("Purchase Invoices")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page 9308;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action("Cash Receipt Journals")
            {
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(Cash Receipts),Recurring=CONST(No));
            }
            action("Payment Journals")
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(Payments),Recurring=CONST(No));
            }
            action("General Journals")
            {
                Caption = 'General Journals';
                Image = Journal;
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(General),Recurring=CONST(No));
            }
            action("Recurring General Journals")
            {
                Caption = 'Recurring General Journals';
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(General),Recurring=CONST(Yes));
            }
            action("Intrastat Journals")
            {
                Caption = 'Intrastat Journals';
                RunObject = Page 327;
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
                action("Posted Return Shipments")
                {
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page 147;
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Issued Fi. Charge Memos")
                {
                    Caption = 'Issued Fi. Charge Memos';
                    RunObject = Page 452;
                }
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page 116;
                }
                action("Simulation Registers")
                {
                    Caption = 'Simulation Registers';
                    RunObject = Page 10810;
                }
                action("Payment Slip List Archives")
                {
                    Caption = 'Payment Slip List Archives';
                    RunObject = Page 10879;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                action(Currencies)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page 5;
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page 100;
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    RunObject = Page 456;
                }
            }
        }
        area(creation)
        {
            action("C&ustomer")
            {
                Caption = 'C&ustomer';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 21;
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
            action("Sales Credit &Memo")
            {
                Caption = 'Sales Credit &Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                                RunPageMode = Create;
            }
            action("Sales &Fin. Charge Memo")
            {
                Caption = 'Sales &Fin. Charge Memo';
                Image = FinChargeMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 446;
                                RunPageMode = Create;
            }
            action("Sales &Reminder")
            {
                Caption = 'Sales &Reminder';
                Image = Reminder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 434;
                                RunPageMode = Create;
            }
            separator()
            {
            }
            action("&Vendor")
            {
                Caption = '&Vendor';
                Image = Vendor;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 26;
                                RunPageMode = Create;
            }
            action("&Purchase Invoice")
            {
                Caption = '&Purchase Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 51;
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
            action("Cash Re&ceipt Journal")
            {
                Caption = 'Cash Re&ceipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page 255;
            }
            action("Payment &Journal")
            {
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page 256;
            }
            action("Payment Slip")
            {
                Caption = 'Payment Slip';
                RunObject = Page 10868;
            }
            action("Look/Edit Payment Line")
            {
                Caption = 'Look/Edit Payment Line';
                RunObject = Page 10862;
            }
            action("Payment Report")
            {
                Caption = 'Payment Report';
                RunObject = Page 10863;
            }
            action("Archive Payment Journals")
            {
                Caption = 'Archive Payment Journals';
                Image = "Report";
                RunObject = Report 10873;
            }
            action("Create Payment Slip")
            {
                Caption = 'Create Payment Slip';
                RunObject = Codeunit 10860;
            }
            action("Payment Registration")
            {
                Caption = 'Payment Registration';
                Image = Payment;
                RunObject = Page 981;
            }
            separator()
            {
            }
            action("B&ank Account Reconciliations")
            {
                Caption = 'B&ank Account Reconciliations';
                Image = BankAccountRec;
                RunObject = Page 379;
            }
            action("Adjust E&xchange Rates")
            {
                Caption = 'Adjust E&xchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report 595;
            }
            action("Post Inventor&y Cost to G/L")
            {
                Caption = 'Post Inventor&y Cost to G/L';
                Ellipsis = true;
                Image = PostInventoryToGL;
                RunObject = Report 1002;
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                Ellipsis = true;
                Image = SettleOpenTransactions;
                RunObject = Report 20;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Sa&les && Receivables Setup")
            {
                Caption = 'Sa&les && Receivables Setup';
                Image = Setup;
                RunObject = Page 459;
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

