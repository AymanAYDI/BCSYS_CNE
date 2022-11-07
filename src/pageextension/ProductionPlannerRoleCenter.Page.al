page 9010 "Production Planner Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9038)
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
                }
                part(; 9175)
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
            action("Ro&uting Sheet")
            {
                Caption = 'Ro&uting Sheet';
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
            action("&Planning Availability")
            {
                Caption = '&Planning Availability';
                Image = "Report";
                RunObject = Report 99001048;
            }
            action("&Capacity Task List")
            {
                Caption = '&Capacity Task List';
                Image = "Report";
                RunObject = Report 99000780;
            }
            action("Subcontractor - &Dispatch List")
            {
                Caption = 'Subcontractor - &Dispatch List';
                Image = "Report";
                RunObject = Report 99000789;
            }
            separator()
            {
            }
            action("Production Order - &Shortage List")
            {
                Caption = 'Production Order - &Shortage List';
                Image = "Report";
                RunObject = Report 99000788;
            }
            action("D&etailed Calculation")
            {
                Caption = 'D&etailed Calculation';
                Image = "Report";
                RunObject = Report 99000756;
            }
            separator()
            {
            }
            action("P&roduction Order - Calculation")
            {
                Caption = 'P&roduction Order - Calculation';
                Image = "Report";
                RunObject = Report 99000767;
            }
            action("Sta&tus")
            {
                Caption = 'Sta&tus';
                Image = "Report";
                RunObject = Report 706;
            }
            action("Inventory &Valuation WIP")
            {
                Caption = 'Inventory &Valuation WIP';
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
            action("Production Forecast")
            {
                Caption = 'Production Forecast';
                RunObject = Page 99000921;
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page 9303;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action("Blanket Purchase Orders")
            {
                Caption = 'Blanket Purchase Orders';
                RunObject = Page 9310;
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
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
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
            action("Production BOMs")
            {
                Caption = 'Production BOMs';
                RunObject = Page 99000787;
            }
            action(Certified)
            {
                Caption = 'Certified';
                RunObject = Page 99000787;
                                RunPageView = WHERE(Status=CONST(Certified));
            }
            action(Routings)
            {
                Caption = 'Routings';
                RunObject = Page 99000764;
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action("Item Journals")
                {
                    Caption = 'Item Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Item),Recurring=CONST(No));
                }
                action("Item Reclassification Journals")
                {
                    Caption = 'Item Reclassification Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Transfer),Recurring=CONST(No));
                }
                action("Revaluation Journals")
                {
                    Caption = 'Revaluation Journals';
                    RunObject = Page 262;
                                    RunPageView = WHERE(Template Type=CONST(Revaluation),Recurring=CONST(No));
                }
            }
            group(Worksheets)
            {
                Caption = 'Worksheets';
                Image = Worksheets;
                action("Planning Worksheets")
                {
                    Caption = 'Planning Worksheets';
                    RunObject = Page 295;
                                    RunPageView = WHERE(Template Type=CONST(Planning),Recurring=CONST(No));
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
                action("Standard Cost Worksheet")
                {
                    Caption = 'Standard Cost Worksheet';
                    RunObject = Page 5840;
                }
            }
            group("Product Design")
            {
                Caption = 'Product Design';
                Image = ProductDesign;
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    Image = BOM;
                    RunObject = Page 99000787;
                }
                action(Certified)
                {
                    Caption = 'Certified';
                    RunObject = Page 99000787;
                                    RunPageView = WHERE(Status=CONST(Certified));
                }
                action(Routings)
                {
                    Caption = 'Routings';
                    RunObject = Page 99000764;
                }
                action("Routing Links")
                {
                    Caption = 'Routing Links';
                    RunObject = Page 99000798;
                }
                action("Standard Tasks")
                {
                    Caption = 'Standard Tasks';
                    RunObject = Page 99000799;
                }
                action(Families)
                {
                    Caption = 'Families';
                    RunObject = Page 99000791;
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
                                    RunPageView = WHERE(Replenishment System=CONST(Prod. Order));
                }
                action("Raw Materials")
                {
                    Caption = 'Raw Materials';
                    RunObject = Page 31;
                                    RunPageView = WHERE(Low-Level Code=FILTER(>0),Replenishment System=CONST(Purchase));
                }
                action("Stockkeeping Units")
                {
                    Caption = 'Stockkeeping Units';
                    Image = SKU;
                    RunObject = Page 5701;
                }
            }
            group(Capacities)
            {
                Caption = 'Capacities';
                Image = Capacities;
                action("Work Centers")
                {
                    Caption = 'Work Centers';
                    RunObject = Page 99000755;
                }
                action(Internal)
                {
                    Caption = 'Internal';
                    Image = Comment;
                    RunObject = Page 99000755;
                                    RunPageView = WHERE(Subcontractor No.=FILTER(=''));
                }
                action(Subcontracted)
                {
                    Caption = 'Subcontracted';
                    RunObject = Page 99000755;
                                    RunPageView = WHERE(Subcontractor No.=FILTER(<>''));
                }
                action("Machine Centers")
                {
                    Caption = 'Machine Centers';
                    RunObject = Page 99000761;
                }
                action("Registered Absence")
                {
                    Caption = 'Registered Absence';
                    RunObject = Page 99000920;
                }
                action(Vendors)
                {
                    Caption = 'Vendors';
                    Image = Vendor;
                    RunObject = Page 27;
                }
            }
        }
        area(creation)
        {
            action("&Item")
            {
                Caption = '&Item';
                Image = Item;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 30;
                                RunPageMode = Create;
            }
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
            action("Production &BOM")
            {
                Caption = 'Production &BOM';
                Image = BOM;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 99000786;
                                RunPageMode = Create;
            }
            action("&Routing")
            {
                Caption = '&Routing';
                Image = Route;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 99000766;
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
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Item &Journal")
            {
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page 40;
            }
            action("Re&quisition Worksheet")
            {
                Caption = 'Re&quisition Worksheet';
                Image = Worksheet;
                RunObject = Page 291;
            }
            action("Planning Works&heet")
            {
                Caption = 'Planning Works&heet';
                Image = PlanningWorksheet;
                RunObject = Page 99000852;
            }
            action("Item Availability by Timeline")
            {
                Caption = 'Item Availability by Timeline';
                Image = Timeline;
                RunObject = Page 5540;
            }
            action("Subcontracting &Worksheet")
            {
                Caption = 'Subcontracting &Worksheet';
                Image = SubcontractingWorksheet;
                RunObject = Page 99000886;
            }
            separator()
            {
            }
            action("Change Pro&duction Order Status")
            {
                Caption = 'Change Pro&duction Order Status';
                Image = ChangeStatus;
                RunObject = Page 99000914;
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
            action("Order Promising S&etup")
            {
                Caption = 'Order Promising S&etup';
                Image = OrderPromisingSetup;
                RunObject = Page 99000958;
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

