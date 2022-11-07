page 9009 "Whse. Worker WMS Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9056)
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
            action("Warehouse &Bin List")
            {
                Caption = 'Warehouse &Bin List';
                Image = "Report";
                RunObject = Report 7319;
            }
            action("Warehouse A&djustment Bin")
            {
                Caption = 'Warehouse A&djustment Bin';
                Image = "Report";
                RunObject = Report 7320;
            }
            separator()
            {
            }
            action("Whse. P&hys. Inventory List")
            {
                Caption = 'Whse. P&hys. Inventory List';
                Image = "Report";
                RunObject = Report 7307;
            }
            separator()
            {
            }
            action("Prod. &Order Picking List")
            {
                Caption = 'Prod. &Order Picking List';
                Image = "Report";
                RunObject = Report 99000766;
            }
            separator()
            {
            }
            action("Customer &Labels")
            {
                Caption = 'Customer &Labels';
                Image = "Report";
                RunObject = Report 110;
            }
        }
        area(embedding)
        {
            action(Picks)
            {
                Caption = 'Picks';
                RunObject = Page 9313;
            }
            action("Put-aways")
            {
                Caption = 'Put-aways';
                RunObject = Page 9312;
            }
            action(Movements)
            {
                Caption = 'Movements';
                RunObject = Page 9314;
            }
            action("Warehouse Shipments")
            {
                Caption = 'Warehouse Shipments';
                RunObject = Page 7339;
            }
            action(Released)
            {
                Caption = 'Released';
                RunObject = Page 7339;
                RunPageView = SORTING (No.) WHERE (Status = FILTER (Released));
            }
            action("Partially Picked")
            {
                Caption = 'Partially Picked';
                RunObject = Page 7339;
                RunPageView = WHERE (Document Status=FILTER(Partially Picked));
            }
            action("Completely Picked")
            {
                Caption = 'Completely Picked';
                RunObject = Page 7339;
                                RunPageView = WHERE(Document Status=FILTER(Completely Picked));
            }
            action("Partially Shipped")
            {
                Caption = 'Partially Shipped';
                RunObject = Page 7339;
                                RunPageView = WHERE(Document Status=FILTER(Partially Shipped));
            }
            action("Warehouse Receipts")
            {
                Caption = 'Warehouse Receipts';
                RunObject = Page 7332;
            }
            action("Partially Received")
            {
                Caption = 'Partially Received';
                RunObject = Page 7332;
                                RunPageView = WHERE(Document Status=FILTER(Partially Received));
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page 5742;
            }
            action("Assembly Orders")
            {
                Caption = 'Assembly Orders';
                RunObject = Page 902;
            }
            action("Bin Contents")
            {
                Caption = 'Bin Contents';
                Image = BinContent;
                RunObject = Page 7305;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
            }
            action("Shipping Agents")
            {
                Caption = 'Shipping Agents';
                RunObject = Page 428;
            }
            action("Warehouse Employees")
            {
                Caption = 'Warehouse Employees';
                RunObject = Page 7348;
            }
            action("Whse. Phys. Invt. Journals")
            {
                Caption = 'Whse. Phys. Invt. Journals';
                RunObject = Page 7329;
                                RunPageView = WHERE(Template Type=CONST(Physical Inventory));
            }
            action("Whse. Item Journals")
            {
                Caption = 'Whse. Item Journals';
                RunObject = Page 7329;
                                RunPageView = WHERE(Template Type=CONST(Item));
            }
            action("Pick Worksheets")
            {
                Caption = 'Pick Worksheets';
                RunObject = Page 7346;
                                RunPageView = WHERE(Template Type=CONST(Pick));
            }
            action("Put-away Worksheets")
            {
                Caption = 'Put-away Worksheets';
                RunObject = Page 7346;
                                RunPageView = WHERE(Template Type=CONST(Put-away));
            }
            action("Movement Worksheets")
            {
                Caption = 'Movement Worksheets';
                RunObject = Page 7346;
                                RunPageView = WHERE(Template Type=CONST(Movement));
            }
        }
        area(sections)
        {
            group("Registered Documents")
            {
                Caption = 'Registered Documents';
                Image = RegisteredDocs;
                action("Registered Picks")
                {
                    Caption = 'Registered Picks';
                    Image = RegisteredDocs;
                    RunObject = Page 9344;
                }
                action("Registered Put-aways")
                {
                    Caption = 'Registered Put-aways';
                    Image = RegisteredDocs;
                    RunObject = Page 9343;
                }
                action("Registered Movements")
                {
                    Caption = 'Registered Movements';
                    Image = RegisteredDocs;
                    RunObject = Page 9345;
                }
                action("Posted Whse. Receipts")
                {
                    Caption = 'Posted Whse. Receipts';
                    Image = PostedReceipts;
                    RunObject = Page 7333;
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
            action("Whse. P&hysical Invt. Journal")
            {
                Caption = 'Whse. P&hysical Invt. Journal';
                Image = InventoryJournal;
                RunObject = Page 7326;
            }
            action("Whse. Item &Journal")
            {
                Caption = 'Whse. Item &Journal';
                Image = BinJournal;
                RunObject = Page 7324;
            }
            separator()
            {
            }
            action("Pick &Worksheet")
            {
                Caption = 'Pick &Worksheet';
                Image = PickWorksheet;
                RunObject = Page 7345;
            }
            action("Put-&away Worksheet")
            {
                Caption = 'Put-&away Worksheet';
                Image = PutAwayWorksheet;
                RunObject = Page 7352;
            }
            action("M&ovement Worksheet")
            {
                Caption = 'M&ovement Worksheet';
                Image = MovementWorksheet;
                RunObject = Page 7351;
            }
        }
    }
}

