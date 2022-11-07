page 9016 "Service Dispatcher Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9057)
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
                part(; 9150)
                {
                }
                part(; 9152)
                {
                }
                part(; 681)
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
            action("Service Ta&sks")
            {
                Caption = 'Service Ta&sks';
                Image = ServiceTasks;
                RunObject = Report 5904;
            }
            action("Service &Load Level")
            {
                Caption = 'Service &Load Level';
                Image = "Report";
                RunObject = Report 5956;
            }
            action("Resource &Usage")
            {
                Caption = 'Resource &Usage';
                Image = "Report";
                RunObject = Report 5939;
            }
            separator()
            {
            }
            action("Service I&tems Out of Warranty")
            {
                Caption = 'Service I&tems Out of Warranty';
                Image = "Report";
                RunObject = Report 5937;
            }
            separator()
            {
            }
            action("Profit Service &Contracts")
            {
                Caption = 'Profit Service &Contracts';
                Image = "Report";
                RunObject = Report 5976;
            }
            action("Profit Service &Orders")
            {
                Caption = 'Profit Service &Orders';
                Image = "Report";
                RunObject = Report 5910;
            }
            action("Profit Service &Items")
            {
                Caption = 'Profit Service &Items';
                Image = "Report";
                RunObject = Report 5938;
            }
        }
        area(embedding)
        {
            action("Service Contract Quotes")
            {
                Caption = 'Service Contract Quotes';
                RunObject = Page 9322;
            }
            action("Service Contracts")
            {
                Caption = 'Service Contracts';
                Image = ServiceAgreement;
                RunObject = Page 9321;
            }
            action(Open)
            {
                Caption = 'Open';
                Image = Edit;
                RunObject = Page 9321;
                RunPageView = WHERE (Change Status=FILTER(Open));
                ShortCutKey = 'Return';
            }
            action("Service Quotes")
            {
                Caption = 'Service Quotes';
                Image = Quote;
                RunObject = Page 9317;
            }
            action("Service Orders")
            {
                Caption = 'Service Orders';
                Image = Document;
                RunObject = Page 9318;
            }
            action("Standard Service Codes")
            {
                Caption = 'Standard Service Codes';
                Image = ServiceCode;
                RunObject = Page 5958;
            }
            action(Loaners)
            {
                Caption = 'Loaners';
                Image = Loaners;
                RunObject = Page 5923;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action("Service Items")
            {
                Caption = 'Service Items';
                Image = ServiceItem;
                RunObject = Page 5981;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Item),Recurring=CONST(No));
            }
            action("Requisition Worksheets")
            {
                Caption = 'Requisition Worksheets';
                RunObject = Page 295;
                                RunPageView = WHERE(Template Type=CONST(Req.),Recurring=CONST(No));
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Service Shipments")
                {
                    Caption = 'Posted Service Shipments';
                    Image = PostedShipment;
                    RunObject = Page 5974;
                }
                action("Posted Service Invoices")
                {
                    Caption = 'Posted Service Invoices';
                    Image = PostedServiceOrder;
                    RunObject = Page 5977;
                }
                action("Posted Service Credit Memos")
                {
                    Caption = 'Posted Service Credit Memos';
                    RunObject = Page 5971;
                }
            }
        }
        area(creation)
        {
            group("&Service")
            {
                Caption = '&Service';
                Image = Tools;
                action("Service Contract &Quote")
                {
                    Caption = 'Service Contract &Quote';
                    Image = AgreementQuote;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 6053;
                                    RunPageMode = Create;
                }
                action("Service &Contract")
                {
                    Caption = 'Service &Contract';
                    Image = Agreement;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 6050;
                                    RunPageMode = Create;
                }
                action("Service Q&uote")
                {
                    Caption = 'Service Q&uote';
                    Image = Quote;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 5964;
                                    RunPageMode = Create;
                }
                action("Service &Order")
                {
                    Caption = 'Service &Order';
                    Image = Document;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 5900;
                                    RunPageMode = Create;
                }
            }
            action("Sales Or&der")
            {
                Caption = 'Sales Or&der';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                                RunPageMode = Create;
            }
            action("Transfer &Order")
            {
                Caption = 'Transfer &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5740;
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
            action("Service Tas&ks")
            {
                Caption = 'Service Tas&ks';
                Image = ServiceTasks;
                RunObject = Page 5915;
            }
            action("C&reate Contract Service Orders")
            {
                Caption = 'C&reate Contract Service Orders';
                Image = "Report";
                RunObject = Report 6036;
            }
            action("Create Contract In&voices")
            {
                Caption = 'Create Contract In&voices';
                Image = "Report";
                RunObject = Report 6030;
            }
            action("Post &Prepaid Contract Entries")
            {
                Caption = 'Post &Prepaid Contract Entries';
                Image = "Report";
                RunObject = Report 6032;
            }
            separator()
            {
            }
            action("Order Pla&nning")
            {
                Caption = 'Order Pla&nning';
                Image = Planning;
                RunObject = Page 5522;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("St&andard Service Codes")
            {
                Caption = 'St&andard Service Codes';
                Image = ServiceCode;
                RunObject = Page 5958;
            }
            action("Dispatch Board")
            {
                Caption = 'Dispatch Board';
                Image = ListPage;
                RunObject = Page 6000;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Item &Tracing")
            {
                Caption = 'Item &Tracing';
                Image = ItemTracing;
                RunObject = Page 6520;
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

