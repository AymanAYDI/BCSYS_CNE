page 9011 "Shop Supervisor Mfg Foundation"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9044)
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
            action("Production Order - &Shortage List")
            {
                Caption = 'Production Order - &Shortage List';
                Image = "Report";
                RunObject = Report 99000788;
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
            action("Production &Order Calculation")
            {
                Caption = 'Production &Order Calculation';
                Image = "Report";
                RunObject = Report 99000767;
            }
            action("S&tatus")
            {
                Caption = 'S&tatus';
                Image = "Report";
                RunObject = Report 706;
            }
            action("&Item Registers - Quantity")
            {
                Caption = '&Item Registers - Quantity';
                Image = "Report";
                RunObject = Report 703;
            }
            action("Inventory Valuation &WIP")
            {
                Caption = 'Inventory Valuation &WIP';
                Image = "Report";
                RunObject = Report 5802;
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
            action("Production BOM")
            {
                Caption = 'Production BOM';
                Image = BOM;
                RunObject = Page 99000787;
            }
            action("Under Development")
            {
                Caption = 'Under Development';
                RunObject = Page 99000787;
                                RunPageView = WHERE(Status=CONST(Under Development));
            }
            action(Certified)
            {
                Caption = 'Certified';
                RunObject = Page 99000787;
                                RunPageView = WHERE(Status=CONST(Certified));
            }
            action("Work Centers")
            {
                Caption = 'Work Centers';
                RunObject = Page 99000755;
            }
            action(Routings)
            {
                Caption = 'Routings';
                RunObject = Page 99000764;
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
            action("Standard Cost Worksheets")
            {
                Caption = 'Standard Cost Worksheets';
                RunObject = Page 5840;
            }
            action("Subcontracting Worksheets")
            {
                Caption = 'Subcontracting Worksheets';
                RunObject = Page 295;
                                RunPageView = WHERE(Template Type=CONST(For. Labor),Recurring=CONST(No));
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
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action("Revaluation Journals")
                {
                    Caption = 'Revaluation Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Revaluation),Recurring=CONST(No));
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
                action("Recurring Consumption Journals")
                {
                    Caption = 'Recurring Consumption Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Consumption),Recurring=CONST(Yes));
                }
                action("Recurring Output Journals")
                {
                    Caption = 'Recurring Output Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Output),Recurring=CONST(Yes));
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
        area(creation)
        {
            action("Production &Order")
            {
                Caption = 'Production &Order';
                Image = "Order";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 99000813;
                                RunPageMode = Create;
            }
            action("P&urchase Order")
            {
                Caption = 'P&urchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
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
            action("Co&nsumption Journal")
            {
                Caption = 'Co&nsumption Journal';
                Image = ConsumptionJournal;
                RunObject = Page 99000846;
            }
            action("Output &Journal")
            {
                Caption = 'Output &Journal';
                Image = OutputJournal;
                RunObject = Page 99000823;
            }
            separator()
            {
            }
            action("Requisition &Worksheet")
            {
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page 291;
            }
            action("Order &Planning")
            {
                Caption = 'Order &Planning';
                Image = Planning;
                RunObject = Page 5522;
            }
            separator()
            {
            }
            action("&Change Production Order Status")
            {
                Caption = '&Change Production Order Status';
                Image = ChangeStatus;
                RunObject = Page 99000914;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Manu&facturing Setup")
            {
                Caption = 'Manu&facturing Setup';
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

