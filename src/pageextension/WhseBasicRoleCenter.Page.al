page 9008 "Whse. Basic Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9050)
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
                part(; 760)
                {
                    Visible = false;
                }
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
            action("Warehouse &Bin List")
            {
                Caption = 'Warehouse &Bin List';
                Image = "Report";
                RunObject = Report 7319;
            }
            separator()
            {
            }
            action("Physical &Inventory List")
            {
                Caption = 'Physical &Inventory List';
                Image = "Report";
                RunObject = Report 722;
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
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action(Released)
            {
                Caption = 'Released';
                RunObject = Page 9305;
                RunPageView = WHERE (Status = FILTER (Released));
            }
            action("Partially Shipped")
            {
                Caption = 'Partially Shipped';
                RunObject = Page 9305;
                RunPageView = WHERE (Status = FILTER (Released), Completely Shipped=FILTER(No));
            }
            action("Purchase Return Orders")
            {
                Caption = 'Purchase Return Orders';
                RunObject = Page 9311;
                                RunPageView = WHERE(Document Type=FILTER(Return Order));
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page 5742;
            }
            action("Released Production Orders")
            {
                Caption = 'Released Production Orders';
                RunObject = Page 9326;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action(Released)
            {
                Caption = 'Released';
                RunObject = Page 9307;
                                RunPageView = WHERE(Status=FILTER(Released));
            }
            action("Partially Received")
            {
                Caption = 'Partially Received';
                RunObject = Page 9307;
                                RunPageView = WHERE(Status=FILTER(Released),Completely Received=FILTER(No));
            }
            action("Assembly Orders")
            {
                Caption = 'Assembly Orders';
                RunObject = Page 902;
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page 9304;
            }
            action("Inventory Picks")
            {
                Caption = 'Inventory Picks';
                RunObject = Page 9316;
            }
            action("Inventory Put-aways")
            {
                Caption = 'Inventory Put-aways';
                RunObject = Page 9315;
            }
            action("Inventory Movements")
            {
                Caption = 'Inventory Movements';
                RunObject = Page 9330;
            }
            action("Internal Movements")
            {
                Caption = 'Internal Movements';
                RunObject = Page 7400;
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
            action("Item Reclassification Journals")
            {
                Caption = 'Item Reclassification Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Transfer),Recurring=CONST(No));
            }
            action("Phys. Inventory Journals")
            {
                Caption = 'Phys. Inventory Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Phys. Inventory),Recurring=CONST(No));
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Invt. Picks")
                {
                    Caption = 'Posted Invt. Picks';
                    RunObject = Page 7395;
                }
                action("Posted Sales Shipment")
                {
                    Caption = 'Posted Sales Shipment';
                    RunObject = Page 142;
                }
                action("Posted Transfer Shipments")
                {
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page 5752;
                }
                action("Posted Return Shipments")
                {
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
                }
                action("Posted Invt. Put-aways")
                {
                    Caption = 'Posted Invt. Put-aways';
                    RunObject = Page 7394;
                }
                action("Registered Invt. Movements")
                {
                    Caption = 'Registered Invt. Movements';
                    RunObject = Page 7386;
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page 5753;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page 145;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                }
                action("Posted Assembly Orders")
                {
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page 922;
                }
            }
        }
        area(creation)
        {
            action("T&ransfer Order")
            {
                Caption = 'T&ransfer Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5740;
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
            separator()
            {
            }
            action("Inventory Pi&ck")
            {
                Caption = 'Inventory Pi&ck';
                Image = CreateInventoryPickup;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7377;
                                RunPageMode = Create;
            }
            action("Inventory P&ut-away")
            {
                Caption = 'Inventory P&ut-away';
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
            action("Edit Item Reclassification &Journal")
            {
                Caption = 'Edit Item Reclassification &Journal';
                Image = OpenWorksheet;
                RunObject = Page 393;
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
        }
    }
}

