page 9007 "Purchasing Agent Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9063)
                {
                }
                part(; 9151)
                {
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                part(; 771)
                {
                }
                part(; 771)
                {
                    Visible = false;
                }
                part(; 772)
                {
                }
                part(; 772)
                {
                    Visible = false;
                }
                part(; 681)
                {
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9152)
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
            action("Vendor - T&op 10 List")
            {
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                RunObject = Report 311;
            }
            action("Vendor/&Item Purchases")
            {
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                RunObject = Report 313;
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
            action("Inventory &Purchase Orders")
            {
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report 709;
            }
            action("Inventory - &Vendor Purchases")
            {
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report 714;
            }
            action("Inventory &Cost and Price List")
            {
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = Report 716;
            }
        }
        area(embedding)
        {
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action("Pending Confirmation")
            {
                Caption = 'Pending Confirmation';
                RunObject = Page 9307;
                RunPageView = WHERE (Status = FILTER (Open));
            }
            action("Partially Delivered")
            {
                Caption = 'Partially Delivered';
                RunObject = Page 9307;
                RunPageView = WHERE (Status = FILTER (Released), Receive = FILTER (Yes), Completely Received=FILTER(No));
            }
            action("Purchase Quotes")
            {
                Caption = 'Purchase Quotes';
                RunObject = Page 9306;
            }
            action("Blanket Purchase Orders")
            {
                Caption = 'Blanket Purchase Orders';
                RunObject = Page 9310;
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
            action("Assembly Orders")
            {
                Caption = 'Assembly Orders';
                RunObject = Page 902;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
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
            action("Nonstock Items")
            {
                Caption = 'Nonstock Items';
                Image = NonStockItem;
                RunObject = Page 5726;
            }
            action("Stockkeeping Units")
            {
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page 5701;
            }
            action("Purchase Analysis Reports")
            {
                Caption = 'Purchase Analysis Reports';
                RunObject = Page 9375;
                                RunPageView = WHERE(Analysis Area=FILTER(Purchase));
            }
            action("Inventory Analysis Reports")
            {
                Caption = 'Inventory Analysis Reports';
                RunObject = Page 9377;
                                RunPageView = WHERE(Analysis Area=FILTER(Inventory));
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                RunObject = Page 262;
                                RunPageView = WHERE(Template Type=CONST(Item),Recurring=CONST(No));
            }
            action("Purchase Journals")
            {
                Caption = 'Purchase Journals';
                RunObject = Page 251;
                                RunPageView = WHERE(Template Type=CONST(Purchases),Recurring=CONST(No));
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
            action("Standard Cost Worksheets")
            {
                Caption = 'Standard Cost Worksheets';
                RunObject = Page 5840;
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
                action("Posted Assembly Orders")
                {
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page 922;
                }
            }
        }
        area(creation)
        {
            action("Purchase &Quote")
            {
                Caption = 'Purchase &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 49;
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
            action("Purchase &Order")
            {
                Caption = 'Purchase &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                                RunPageMode = Create;
            }
            action("Purchase &Return Order")
            {
                Caption = 'Purchase &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 6640;
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
            action("&Purchase Journal")
            {
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = Page 254;
            }
            action("Item &Journal")
            {
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page 40;
            }
            action("Order Plan&ning")
            {
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page 5522;
            }
            separator()
            {
            }
            action("Requisition &Worksheet")
            {
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page 295;
                                RunPageView = WHERE(Template Type=CONST(Req.),Recurring=CONST(No));
            }
            action("Pur&chase Prices")
            {
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page 7012;
            }
            action("Purchase &Line Discounts")
            {
                Caption = 'Purchase &Line Discounts';
                Image = LineDiscount;
                RunObject = Page 7014;
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

