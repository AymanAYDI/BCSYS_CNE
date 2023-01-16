page 50122 "BC6_Stock Unit List ACTI"
{
    ApplicationArea = All;
    Caption = 'Stockkeeping Unit List ACTI', Comment = 'FRA="Liste des points de stock ACTI"';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Stockkeeping Unit";
    SourceTableView = WHERE("Location Code" = CONST('ACTI'));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Action1)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the item number to which the SKU applies.', Comment = 'FRA="Spécifie le numéro de l''article auquel s''applique le point de stock."';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description from the Item Card.', Comment = 'FRA="Spécifie la description de la fiche article."';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.', Comment = 'FRA="Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article."';
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ApplicationArea = All;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                Caption = '&Item', Comment = 'FRA="Arti&cle"';
                Image = Item;
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27),
                                  "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', Comment = 'FRA="Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions."';
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture', Comment = 'FRA="&Image"';
                    Image = Picture;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("Item No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Location Code"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Code");
                }
                separator("Action1102601007")
                {
                }
                action("&Units of Measure")
                {
                    ApplicationArea = All;
                    Caption = '&Units of Measure', Comment = 'FRA="&Unités"';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("Item No.");
                }
                action("Va&riants")
                {
                    ApplicationArea = All;
                    Caption = 'Va&riants', Comment = 'FRA="&Variantes"';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("Item No.");
                }
                separator("Action1102601010")
                {
                }
                action(Translations)
                {
                    ApplicationArea = All;
                    Caption = 'Translations', Comment = 'FRA="Traductions"';
                    Image = Translations;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD(FILTER("Variant Code"));
                }
                action("Co&mments1")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("Item No.");
                }
                action("E&xtended Texts")
                {
                    ApplicationArea = All;
                    Caption = 'E&xtended Texts', Comment = 'FRA="&Textes étendus"';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("Item No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }
            }
            group("&SKU")
            {
                Caption = '&SKU', Comment = 'FRA="&Pt de stock"';
                Image = SKU;
                group(Statistics)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    action("Entry Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Entry Statistics', Comment = 'FRA="Statistiques écritures"';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("Item No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Location Code"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Code");
                    }
                    action("T&urnover")
                    {
                        ApplicationArea = All;
                        Caption = 'T&urnover', Comment = 'FRA="&Rotation"';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("Item No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Location Code"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Code");
                    }
                }
                group("&Item Availability By")
                {
                    Caption = '&Item Availability By', Comment = 'FRA="&Disponibilité article par"';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        ApplicationArea = All;
                        Caption = 'Event', Comment = 'FRA="Événement"';
                        Image = "Event";

                        trigger OnAction()
                        var
                            Item: Record Item;
                        begin
                            Item.GET(Rec."Item No.");
                            Item.SETRANGE("Global Dimension 2 Filter", Rec."Location Code");
                            Item.SETRANGE("Variant Filter", Rec."Variant Code");
                            Rec.COPYFILTER("Date Filter", Item."Date Filter");
                            Rec.COPYFILTER("Global Dimension 1 Filter", Item."Global Dimension 1 Filter");
                            Rec.COPYFILTER("Global Dimension 2 Filter", Item."Global Dimension 2 Filter");
                            Rec.COPYFILTER("Drop Shipment Filter", Item."Drop Shipment Filter");
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Item, ItemAvailFormsMgt.ByEvent());
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period', Comment = 'FRA="Période"';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("Item No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Location Code"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Code");
                    }
                    action("Bill of Material")
                    {
                        ApplicationArea = All;
                        Caption = 'Bill of Material', Comment = 'FRA="Nomenclature"';
                        Image = BOM;

                        trigger OnAction()
                        var
                            Item: Record Item;
                        begin
                            Item.GET(Rec."Item No.");
                            Item.SETRANGE("Global Dimension 2 Filter", Rec."Location Code");
                            Item.SETRANGE("Variant Filter", Rec."Variant Code");
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Item, ItemAvailFormsMgt.ByBOM());
                        end;
                    }
                    action(Timeline)
                    {
                        ApplicationArea = All;
                        Caption = 'Timeline', Comment = 'FRA="Chronologie"';
                        Image = Timeline;

                        trigger OnAction()
                        begin
                            Rec.ShowTimeline(Rec);
                        end;
                    }
                }
                action("Co&mments2")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Stock. Unit Comment Sheet";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code"),
                                  "Location Code" = FIELD("Location Code");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("&Bin Contents")
                {
                    ApplicationArea = All;
                    Caption = '&Bin Contents', Comment = 'FRA="C&ontenu emplacement"';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                }
            }
            group(History)
            {
                Caption = 'History', Comment = 'FRA="Historique"';
                Image = History;
                group("E&ntries")
                {
                    Caption = 'E&ntries', Comment = 'FRA="É&critures"';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        ApplicationArea = All;
                        Caption = 'Ledger E&ntries', Comment = 'FRA="É&critures comptables"';
                        Image = CustomerLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("Item No."),
                                      "Location Code" = FIELD("Location Code"),
                                      "Variant Code" = FIELD("Variant Code");
                        RunPageView = SORTING("Item No.", Open, "Variant Code");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Reservation Entries', Comment = 'FRA="Écritures &réservation"';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Item No." = FIELD("Item No."),
                                      "Location Code" = FIELD("Location Code"),
                                      "Variant Code" = FIELD("Variant Code"),
                                      "Reservation Status" = CONST(Reservation);
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Phys. Inventory Ledger Entries', Comment = 'FRA="Écritures comptables &inventaire"';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("Item No."),
                                      "Location Code" = FIELD("Location Code"),
                                      "Variant Code" = FIELD("Variant Code");
                        RunPageView = SORTING("Item No.", "Variant Code");
                    }
                    action("&Value Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Value Entries', Comment = 'FRA="Écritures &valeur"';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("Item No."),
                                      "Location Code" = FIELD("Location Code"),
                                      "Variant Code" = FIELD("Variant Code");
                        RunPageView = SORTING("Item No.", "Valuation Date", "Location Code", "Variant Code");
                    }
                    action("Item &Tracking Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Item &Tracking Entries', Comment = 'FRA="Écritures &traçabilité"';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForEntity(0, '', Rec."Item No.", Rec."Variant Code", Rec."Location Code");
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
                ApplicationArea = All;
                Caption = 'Inventory - List', Comment = 'FRA="Stocks : Liste des articles"';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Inventory - List";
            }
            action("Inventory Availability")
            {
                ApplicationArea = All;
                Caption = 'Inventory Availability', Comment = 'FRA="Disponibilité articles"';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory Availability";
            }
            action("Inventory - Availability Plan")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Availability Plan', Comment = 'FRA="Stocks : Échéancier des dispo."';
                Image = ItemAvailability;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Availability Plan";
            }
            action("Item/Vendor Catalog")
            {
                ApplicationArea = All;
                Caption = 'Item/Vendor Catalog', Comment = 'FRA="Articles : Catalogue fourn."';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Item/Vendor Catalog";
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New', Comment = 'FRA="Nouveau"';
                Image = NewItem;
                action("New Item")
                {
                    ApplicationArea = All;
                    Caption = 'New Item', Comment = 'FRA="Nouvel article"';
                    Image = NewItem;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedOnly = true;
                    RunObject = Page "Item Card";
                    RunPageMode = Create;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("C&alculate Counting Period")
                {
                    ApplicationArea = All;
                    Caption = 'C&alculate Counting Period', Comment = 'FRA="C&alculer période d''inventaire"';
                    Image = CalculateCalendar;

                    trigger OnAction()
                    var
                        SKU: Record "Stockkeeping Unit";
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
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
        Rec.SETRANGE("Reordering Policy", Rec."Reordering Policy"::"Fixed Reorder Qty.");
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
}
