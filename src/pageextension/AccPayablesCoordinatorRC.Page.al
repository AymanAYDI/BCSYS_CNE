page 9002 "Acc. Payables Coordinator RC"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9032)
                {
                }
                part(; 9152)
                {
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                part(; 9151)
                {
                }
                part(; 681)
                {
                }
                part(; 675)
                {
                    Visible = false;
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
            action("&Vendor - List")
            {
                Caption = '&Vendor - List';
                Image = "Report";
                RunObject = Report 301;
            }
            action("Vendor - &Balance to date")
            {
                Caption = 'Vendor - &Balance to date';
                Image = "Report";
                RunObject = Report 321;
            }
            action("Vendor Trial Balance")
            {
                Caption = 'Vendor Trial Balance';
                Image = "Report";
                RunObject = Report 10807;
            }
            action("Vendor Detail Trial Balance")
            {
                Caption = 'Vendor Detail Trial Balance';
                Image = "Report";
                RunObject = Report 10808;
            }
            action("Vendor - &Summary Aging")
            {
                Caption = 'Vendor - &Summary Aging';
                Image = "Report";
                RunObject = Report 305;
            }
            action("Aged &Accounts Payable")
            {
                Caption = 'Aged &Accounts Payable';
                Image = "Report";
                RunObject = Report 322;
            }
            action("Vendor - &Purchase List")
            {
                Caption = 'Vendor - &Purchase List';
                Image = "Report";
                RunObject = Report 309;
            }
            action("Pa&yments on Hold")
            {
                Caption = 'Pa&yments on Hold';
                Image = "Report";
                RunObject = Report 319;
            }
            action("P&urchase Statistics")
            {
                Caption = 'P&urchase Statistics';
                Image = "Report";
                RunObject = Report 312;
            }
            action("Vendor Journal")
            {
                Caption = 'Vendor Journal';
                Image = "Report";
                RunObject = Report 10814;
            }
            separator()
            {
            }
            action("Vendor &Document Nos.")
            {
                Caption = 'Vendor &Document Nos.';
                Image = "Report";
                RunObject = Report 328;
            }
            action("Purchase &Invoice Nos.")
            {
                Caption = 'Purchase &Invoice Nos.';
                Image = "Report";
                RunObject = Report 324;
            }
            action("Purchase &Credit Memo Nos.")
            {
                Caption = 'Purchase &Credit Memo Nos.';
                Image = "Report";
                RunObject = Report 325;
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
            action("GL/Vend. Ledger Reconciliation")
            {
                Caption = 'GL/Vend. Ledger Reconciliation';
                Image = "Report";
                RunObject = Report 10863;
            }
        }
        area(embedding)
        {
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
                RunPageView = WHERE (Balance (LCY)=FILTER(<>0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action("Purchase Invoices")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page 9308;
            }
            action("Purchase Return Orders")
            {
                Caption = 'Purchase Return Orders';
                RunObject = Page 9311;
            }
            action("Purchase Credit Memos")
            {
                Caption = 'Purchase Credit Memos';
                RunObject = Page 9309;
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page 371;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action("Purchase Journals")
            {
                Caption = 'Purchase Journals';
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(Purchases),Recurring=CONST(No));
            }
            action("Payment Journals")
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(Payments),Recurring=CONST(No));
            }
            action("Payment Slips")
            {
                Caption = 'Payment Slips';
                RunObject = Page 10870;
            }
            action("General Journals")
            {
                Caption = 'General Journals';
                Image = Journal;
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(General),Recurring=CONST(No));
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
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
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page 147;
                }
                action("Posted Return Shipments")
                {
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
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
        }
        area(creation)
        {
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
            action("&Purchase Order")
            {
                Caption = '&Purchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                                RunPageMode = Create;
            }
            action("Purchase &Invoice")
            {
                Caption = 'Purchase &Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 51;
                                RunPageMode = Create;
            }
            action("Purchase Credit &Memo")
            {
                Caption = 'Purchase Credit &Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 52;
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
            action("P&urchase Journal")
            {
                Caption = 'P&urchase Journal';
                Image = Journals;
                RunObject = Page 254;
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
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Purchases && Payables &Setup")
            {
                Caption = 'Purchases && Payables &Setup';
                Image = Setup;
                RunObject = Page 460;
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

