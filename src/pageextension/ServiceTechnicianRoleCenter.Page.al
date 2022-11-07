page 9017 "Service Technician Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9066)
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
                part(; 681)
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
            action("Service &Order")
            {
                Caption = 'Service &Order';
                Image = Document;
                RunObject = Report 5900;
            }
            action("Service Items Out of &Warranty")
            {
                Caption = 'Service Items Out of &Warranty';
                Image = "Report";
                RunObject = Report 5937;
            }
            action("Service Item &Line Labels")
            {
                Caption = 'Service Item &Line Labels';
                Image = "Report";
                RunObject = Report 5901;
            }
            action("Service &Item Worksheet")
            {
                Caption = 'Service &Item Worksheet';
                Image = ServiceItemWorksheet;
                RunObject = Report 5936;
            }
        }
        area(embedding)
        {
            action("Service Orders")
            {
                Caption = 'Service Orders';
                Image = Document;
                RunObject = Page 9318;
            }
            action("In Process")
            {
                Caption = 'In Process';
                RunObject = Page 9318;
                RunPageView = WHERE (Status = FILTER (In Process));
            }
            action("Service Item Lines")
            {
                Caption = 'Service Item Lines';
                RunObject = Page 5903;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Loaners)
            {
                Caption = 'Loaners';
                Image = Loaners;
                RunObject = Page 5923;
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
        }
        area(sections)
        {
        }
        area(creation)
        {
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
            action("&Loaner")
            {
                Caption = '&Loaner';
                Image = Loaner;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5922;
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
            action("Service Item &Worksheet")
            {
                Caption = 'Service Item &Worksheet';
                Image = ServiceItemWorksheet;
                RunObject = Page 5906;
            }
        }
    }
}

