page 50123 "Stockkeeping Unit List METZ"
{
    Caption = 'Stockkeeping Unit List METZ';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Table5700;
    SourceTableView = WHERE (Location Code=CONST(METZ));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                }
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the item number to which the SKU applies.';
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the description from the Item Card.';
                }
                field("Reorder Quantity"; "Reorder Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                }
                field("Safety Stock Quantity"; "Safety Stock Quantity")
                {
                }
                field("Order Multiple"; "Order Multiple")
                {
                }
                field("Reordering Policy"; "Reordering Policy")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = Table ID=CONST(27),
                                  No.=FIELD(Item No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page 346;
                                    RunPageLink = No.=FIELD(Item No.),
                                  Date Filter=FIELD(Date Filter),
                                  Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                  Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                  Location Filter=FIELD(Location Code),
                                  Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                  Variant Filter=FIELD(Variant Code);
                }
                separator()
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page 5404;
                                    RunPageLink = Item No.=FIELD(Item No.);
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page 5401;
                                    RunPageLink = Item No.=FIELD(Item No.);
                }
                separator()
                {
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page 35;
                                    RunPageLink = Item No.=FIELD(Item No.),
                                  Variant Code=FIELD(FILTER(Variant Code));
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(Item No.);
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 391;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(Item No.);
                    RunPageView = SORTING(Table Name,No.,Language Code,All Language Codes,Starting Date,Ending Date);
                }
            }
            group("&SKU")
            {
                Caption = '&SKU';
                Image = SKU;
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page 304;
                                        RunPageLink = No.=FIELD(Item No.),
                                      Date Filter=FIELD(Date Filter),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Code),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Code);
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page 158;
                                        RunPageLink = No.=FIELD(Item No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Code),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Code);
                    }
                }
                group("&Item Availability By")
                {
                    Caption = '&Item Availability By';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        var
                            Item: Record "27";
                        begin
                            Item.GET("Item No.");
                            Item.SETRANGE("Location Filter","Location Code");
                            Item.SETRANGE("Variant Filter","Variant Code");
                            COPYFILTER("Date Filter",Item."Date Filter");
                            COPYFILTER("Global Dimension 1 Filter",Item."Global Dimension 1 Filter");
                            COPYFILTER("Global Dimension 2 Filter",Item."Global Dimension 2 Filter");
                            COPYFILTER("Drop Shipment Filter",Item."Drop Shipment Filter");
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Item,ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        RunObject = Page 157;
                                        RunPageLink = No.=FIELD(Item No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Code),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Code);
                    }
                    action("Bill of Material")
                    {
                        Caption = 'Bill of Material';
                        Image = BOM;

                        trigger OnAction()
                        var
                            Item: Record "27";
                        begin
                            Item.GET("Item No.");
                            Item.SETRANGE("Location Filter","Location Code");
                            Item.SETRANGE("Variant Filter","Variant Code");
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Item,ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                    action(Timeline)
                    {
                        Caption = 'Timeline';
                        Image = Timeline;

                        trigger OnAction()
                        begin
                            ShowTimeline(Rec);
                        end;
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5704;
                                    RunPageLink = Item No.=FIELD(Item No.),
                                  Variant Code=FIELD(Variant Code),
                                  Location Code=FIELD(Location Code);
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page 7305;
                                    RunPageLink = Location Code=FIELD(Location Code),
                                  Item No.=FIELD(Item No.),
                                  Variant Code=FIELD(Variant Code);
                    RunPageView = SORTING(Location Code,Item No.,Variant Code);
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = CustomerLedger;
                        RunObject = Page 38;
                                        RunPageLink = Item No.=FIELD(Item No.),
                                      Location Code=FIELD(Location Code),
                                      Variant Code=FIELD(Variant Code);
                        RunPageView = SORTING(Item No.,Open,Variant Code);
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page 497;
                                        RunPageLink = Item No.=FIELD(Item No.),
                                      Location Code=FIELD(Location Code),
                                      Variant Code=FIELD(Variant Code),
                                      Reservation Status=CONST(Reservation);
                        RunPageView = SORTING(Item No.,Variant Code,Location Code,Reservation Status);
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page 390;
                                        RunPageLink = Item No.=FIELD(Item No.),
                                      Location Code=FIELD(Location Code),
                                      Variant Code=FIELD(Variant Code);
                        RunPageView = SORTING(Item No.,Variant Code);
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page 5802;
                                        RunPageLink = Item No.=FIELD(Item No.),
                                      Location Code=FIELD(Location Code),
                                      Variant Code=FIELD(Variant Code);
                        RunPageView = SORTING(Item No.,Valuation Date,Location Code,Variant Code);
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingDocMgt: Codeunit "6503";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(0,'',"Item No.","Variant Code",'','',"Location Code");
                        end;
                    }
                }
            }
        }
        area(creation)
        {
        }
        area(reporting)
        {
            action("Inventory - List")
            {
                Caption = 'Inventory - List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 701;
            }
            action("Inventory Availability")
            {
                Caption = 'Inventory Availability';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 705;
            }
            action("Inventory - Availability Plan")
            {
                Caption = 'Inventory - Availability Plan';
                Image = ItemAvailability;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 707;
            }
            action("Item/Vendor Catalog")
            {
                Caption = 'Item/Vendor Catalog';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 720;
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = NewItem;
                action("New Item")
                {
                    Caption = 'New Item';
                    Image = NewItem;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page 30;
                                    RunPageMode = Create;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;

                    trigger OnAction()
                    var
                        SKU: Record "5700";
                        PhysInvtCountMgt: Codeunit "7380";
                    begin
                        CurrPage.SETSELECTIONFILTER(SKU);
                        PhysInvtCountMgt.UpdateSKUPhysInvtCount(SKU);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //BC6 - MM 080119
        SETRANGE("Reordering Policy","Reordering Policy"::"Fixed Reorder Qty.");
        //BC6 - MM 080119
    end;

    var
        ItemAvailFormsMgt: Codeunit "353";
}

