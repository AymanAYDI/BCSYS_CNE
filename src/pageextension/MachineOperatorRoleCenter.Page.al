page 9013 "Machine Operator Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9047)
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
                part(; 9152)
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
            action("&Capacity Task List")
            {
                Caption = '&Capacity Task List';
                Image = "Report";
                RunObject = Report 99000780;
            }
            action("Prod. Order - &Job Card")
            {
                Caption = 'Prod. Order - &Job Card';
                Image = "Report";
                RunObject = Report 99000762;
            }
        }
        area(embedding)
        {
            action("Released Production Orders")
            {
                Caption = 'Released Production Orders';
                RunObject = Page 9326;
            }
            action("Finished Production Orders")
            {
                Caption = 'Finished Production Orders';
                RunObject = Page 9327;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action(Produced)
            {
                Caption = 'Produced';
                RunObject = Page 31;
                RunPageView = WHERE (Replenishment System=CONST(Prod. Order));
            }
            action("Raw Materials")
            {
                Caption = 'Raw Materials';
                RunObject = Page 31;
                RunPageView = WHERE (Low-Level Code=FILTER(>0),Replenishment System=CONST(Purchase),Production BOM No.=FILTER(=''));
            }
            action("Stockkeeping Units")
            {
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page 5701;
            }
            action("Capacity Ledger Entries")
            {
                Caption = 'Capacity Ledger Entries';
                Image = CapacityLedger;
                RunObject = Page 5832;
            }
            action("Inventory Put-aways")
            {
                Caption = 'Inventory Put-aways';
                RunObject = Page 9315;
            }
            action("Inventory Picks")
            {
                Caption = 'Inventory Picks';
                RunObject = Page 9316;
            }
            action("Consumption Journals")
            {
                Caption = 'Consumption Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Consumption),Recurring=CONST(No));
            }
            action("Output Journals")
            {
                Caption = 'Output Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Output),Recurring=CONST(No));
            }
            action("Capacity Journals")
            {
                Caption = 'Capacity Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Capacity),Recurring=CONST(No));
            }
            action("Recurring Capacity Journals")
            {
                Caption = 'Recurring Capacity Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Capacity),Recurring=CONST(Yes));
            }
        }
        area(sections)
        {
        }
        area(creation)
        {
            action("Inventory P&ick")
            {
                Caption = 'Inventory P&ick';
                Image = CreateInventoryPickup;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7377;
                                RunPageMode = Create;
            }
            action("Inventory Put-&away")
            {
                Caption = 'Inventory Put-&away';
                Image = CreatePutAway;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7375;
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
            action("Consumptio&n Journal")
            {
                Caption = 'Consumptio&n Journal';
                Image = ConsumptionJournal;
                RunObject = Page 99000846;
            }
            action("Output &Journal")
            {
                Caption = 'Output &Journal';
                Image = OutputJournal;
                RunObject = Page 99000823;
            }
            action("&Capacity Journal")
            {
                Caption = '&Capacity Journal';
                Image = CapacityJournal;
                RunObject = Page 99000773;
            }
            separator()
            {
            }
            action("Register Absence - &Machine Center")
            {
                Caption = 'Register Absence - &Machine Center';
                Image = CalendarMachine;
                RunObject = Report 99003800;
            }
            action("Register Absence - &Work Center")
            {
                Caption = 'Register Absence - &Work Center';
                Image = CalendarWorkcenter;
                RunObject = Report 99003805;
            }
        }
    }
}

