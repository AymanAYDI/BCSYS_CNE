page 9012 "Shop Supervisor Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9041)
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
                part(; 675)
                {
                    Visible = false;
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
            action("Routing &Sheet")
            {
                Caption = 'Routing &Sheet';
                Image = "Report";
                RunObject = Report 99000787;
            }
            separator()
            {
            }
            action("Inventory - &Availability Plan")
            {
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = Report 707;
            }
            separator()
            {
            }
            action("Capacity Tas&k List")
            {
                Caption = 'Capacity Tas&k List';
                Image = "Report";
                RunObject = Report 99000780;
            }
            action("Subcontractor - Dis&patch List")
            {
                Caption = 'Subcontractor - Dis&patch List';
                Image = "Report";
                RunObject = Report 99000789;
            }
            separator()
            {
            }
            action("Production Order Ca&lculation")
            {
                Caption = 'Production Order Ca&lculation';
                Image = "Report";
                RunObject = Report 99000767;
            }
            action("S&tatus")
            {
                Caption = 'S&tatus';
                Image = "Report";
                RunObject = Report 706;
            }
        }
        area(embedding)
        {
            action("Simulated Production Orders")
            {
                Caption = 'Simulated Production Orders';
                RunObject = Page 9323;
            }
            action("Planned Production Orders")
            {
                Caption = 'Planned Production Orders';
                RunObject = Page 9324;
            }
            action("Firm Planned Production Orders")
            {
                Caption = 'Firm Planned Production Orders';
                RunObject = Page 9325;
            }
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
            action(Routings)
            {
                Caption = 'Routings';
                RunObject = Page 99000764;
            }
            action("Registered Absence")
            {
                Caption = 'Registered Absence';
                RunObject = Page 99000920;
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
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page 5742;
            }
            action("Work Centers")
            {
                Caption = 'Work Centers';
                RunObject = Page 99000755;
            }
            action("Machine Centers")
            {
                Caption = 'Machine Centers';
                RunObject = Page 99000761;
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
            action("Requisition Worksheets")
            {
                Caption = 'Requisition Worksheets';
                RunObject = Page 295;
                                RunPageView = WHERE(Template Type=CONST(Req.),Recurring=CONST(No));
            }
            action("Subcontracting Worksheets")
            {
                Caption = 'Subcontracting Worksheets';
                RunObject = Page 295;
                                RunPageView = WHERE(Template Type=CONST(For. Labor),Recurring=CONST(No));
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
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
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                action("Work Shifts")
                {
                    Caption = 'Work Shifts';
                    RunObject = Page 99000750;
                }
                action("Shop Calendars")
                {
                    Caption = 'Shop Calendars';
                    RunObject = Page 99000751;
                }
                action("Capacity Constrained Resources")
                {
                    Caption = 'Capacity Constrained Resources';
                    RunObject = Page 99000866;
                }
                action("Work Center Groups")
                {
                    Caption = 'Work Center Groups';
                    RunObject = Page 99000758;
                }
                action("Stop Codes")
                {
                    Caption = 'Stop Codes';
                    RunObject = Page 99000779;
                }
                action("Scrap Codes")
                {
                    Caption = 'Scrap Codes';
                    RunObject = Page 99000780;
                }
                action("Standard Tasks")
                {
                    Caption = 'Standard Tasks';
                    RunObject = Page 99000799;
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
            action("Change &Production Order Status")
            {
                Caption = 'Change &Production Order Status';
                Image = ChangeStatus;
                RunObject = Page 99000914;
            }
            separator()
            {
            }
            action("Update &Unit Cost")
            {
                Caption = 'Update &Unit Cost';
                Image = UpdateUnitCost;
                RunObject = Report 99001014;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("&Manufacturing Setup")
            {
                Caption = '&Manufacturing Setup';
                Image = ProductionSetup;
                RunObject = Page 99000768;
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

