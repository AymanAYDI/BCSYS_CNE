page 50082 "Item Replanishment List"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // 
    // //BLOQUER SOBH NSC1.01 [007] Article Bloqué
    // //FILTRE_ARTICLE_NONBLOQUE FG 05/12/2006 NSC1.01
    // 
    // //GESTION_REMISE FG 06/12/06 NSC1.01
    //                     Modification bouton Achats, Remises ligne, RunFormView
    //                         SORTING(Code)
    //                     --> SORTING(Type,Code,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
    //                         RunFormLink Type=CONST(Item),Code=FIELD(No.)
    // 
    // //>> CNE4.03 Calc. Price Include VAT
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 01/07/2015: Add Function "Update IC Partner Items"
    //                                         Add C/AL in Trigger OnInit

    Caption = 'Item Replanishment List';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    RefreshOnActivate = true;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            repeater(Item)
            {
                Caption = 'Item';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number of the item.';
                }
                field("No. 2"; "No. 2")
                {
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Reorder Quantity"; "Reorder Quantity")
                {
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
                field(Blocked; Blocked)
                {
                    Editable = false;
                }
                field("Search Description 2"; "Search Description 2")
                {
                }
            }
        }
        area(factboxes)
        {
            part(; 875)
            {
                ApplicationArea = All;
                SubPageLink = Source Type=CONST(Item),
                              Source No.=FIELD(No.);
                                             Visible = SocialListeningVisible;
            }
            part(; 876)
            {
                ApplicationArea = All;
                SubPageLink = Source Type=CONST(Item),
                              Source No.=FIELD(No.);
                                             UpdatePropagation = Both;
                                             Visible = SocialListeningSetupVisible;
            }
            part(; 9089)
            {
                SubPageLink = No.=FIELD(No.),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                              Location Filter=FIELD(Location Filter),
                              Drop Shipment Filter=FIELD(Drop Shipment Filter),
                              Bin Filter=FIELD(Bin Filter),
                              Variant Filter=FIELD(Variant Filter),
                              Lot No. Filter=FIELD(Lot No. Filter),
                              Serial No. Filter=FIELD(Serial No. Filter);
            }
            part(;9090)
            {
                SubPageLink = No.=FIELD(No.),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                              Location Filter=FIELD(Location Filter),
                              Drop Shipment Filter=FIELD(Drop Shipment Filter),
                              Bin Filter=FIELD(Bin Filter),
                              Variant Filter=FIELD(Variant Filter),
                              Lot No. Filter=FIELD(Lot No. Filter),
                              Serial No. Filter=FIELD(Serial No. Filter);
                Visible = false;
            }
            part(;9091)
            {
                SubPageLink = No.=FIELD(No.),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                              Location Filter=FIELD(Location Filter),
                              Drop Shipment Filter=FIELD(Drop Shipment Filter),
                              Bin Filter=FIELD(Bin Filter),
                              Variant Filter=FIELD(Variant Filter),
                              Lot No. Filter=FIELD(Lot No. Filter),
                              Serial No. Filter=FIELD(Serial No. Filter);
            }
            part(;9109)
            {
                SubPageLink = No.=FIELD(No.),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                              Location Filter=FIELD(Location Filter),
                              Drop Shipment Filter=FIELD(Drop Shipment Filter),
                              Bin Filter=FIELD(Bin Filter),
                              Variant Filter=FIELD(Variant Filter),
                              Lot No. Filter=FIELD(Lot No. Filter),
                              Serial No. Filter=FIELD(Serial No. Filter);
                Visible = false;
            }
            part(ItemAttributesFactBox;9110)
            {
                ApplicationArea = Basic,Suite;
            }
            systempart(;Links)
            {
            }
            systempart(;Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Item)
            {
                Caption = 'Item';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page 5404;
                                    RunPageLink = Item No.=FIELD(No.);
                    Scope = Repeater;
                    ToolTip = 'Set up the different units that the selected item can be traded in, such as piece, box, or hour.';
                }
                action(Attributes)
                {
                    AccessByPermission = TableData 7500=R;
                    Caption = 'Attributes';
                    Image = Category;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Scope = Repeater;
                    ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(PAGE::"Item Attribute Value Editor",Rec);
                        CurrPage.SAVERECORD;
                        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData("No.");
                    end;
                }
                action(FilterByAttributes)
                {
                    AccessByPermission = TableData 7500=R;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Filter by Attributes';
                    Image = EditFilter;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedOnly = true;
                    ToolTip = 'Find items that match specific attributes. To make sure you include recent changes made by other users, clear the filter and then reset it.';

                    trigger OnAction()
                    var
                        ItemAttributeManagement: Codeunit "7500";
                        TypeHelper: Codeunit "10";
                        CloseAction: Action;
                        FilterText: Text;
                        FilterPageID: Integer;
                        ParameterCount: Integer;
                    begin
                        FilterPageID := PAGE::"Filter Items by Attribute";
                        IF CURRENTCLIENTTYPE = CLIENTTYPE::Phone THEN
                          FilterPageID := PAGE::"Filter Items by Att. Phone";

                        CloseAction := PAGE.RUNMODAL(FilterPageID,TempFilterItemAttributesBuffer);
                        IF (CURRENTCLIENTTYPE <> CLIENTTYPE::Phone) AND (CloseAction <> ACTION::LookupOK) THEN
                          EXIT;

                        ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer,TempFilteredItem);
                        FilterText := ItemAttributeManagement.GetItemNoFilterText(TempFilteredItem,ParameterCount);

                        IF ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery - 100 THEN BEGIN
                          FILTERGROUP(0);
                          MARKEDONLY(FALSE);
                          SETFILTER("No.",FilterText);
                        END ELSE BEGIN
                          RunOnTempRec := TRUE;
                          CLEARMARKS;
                          RESET;
                        END;
                    end;
                }
                action(ClearAttributes)
                {
                    AccessByPermission = TableData 7500=R;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Clear Attributes Filter';
                    Image = RemoveFilterLines;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedOnly = true;
                    ToolTip = 'Remove the filter for specific item attributes.';

                    trigger OnAction()
                    begin
                        CLEARMARKS;
                        MARKEDONLY(FALSE);
                        TempFilterItemAttributesBuffer.RESET;
                        TempFilterItemAttributesBuffer.DELETEALL;
                        TempFilteredItem.RESET;
                        TempFilteredItem.DELETEALL;
                        RunOnTempRec := FALSE;
                        FILTERGROUP(0);
                        SETRANGE("No.");
                    end;
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page 5401;
                                    RunPageLink = Item No.=FIELD(No.);
                }
                action("Substituti&ons")
                {
                    ApplicationArea = Suite;
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page 5716;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = BarCode;
                    RunObject = Page 7706;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.,Variant Code,Unit of Measure Code);
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    RunObject = Page 5721;
                                    RunPageLink = Item No.=FIELD(No.);
                    Scope = Repeater;
                    ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 391;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Language Code,All Language Codes,Starting Date,Ending Date);
                    Scope = Repeater;
                    ToolTip = 'Set up additional text for the description of the selected item. Extended text can be inserted under the Description field on document lines for the item.';
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page 35;
                                    RunPageLink = Item No.=FIELD(No.),
                                  Variant Code=CONST();
                    Scope = Repeater;
                    ToolTip = 'Set up translated item descriptions for the selected item. Translated item descriptions are automatically inserted on documents according to the language code.';
                }
                group()
                {
                    Visible = false;
                    action(AdjustInventory)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Adjust Inventory';
                        Enabled = InventoryItemEditable;
                        Image = InventoryCalculation;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        Scope = Repeater;
                        ToolTip = 'Increase or decrease the item''s inventory quantity manually by entering a new quantity. Adjusting the inventory quantity manually may be relevant after a physical count or if you do not record purchased quantities.';
                        Visible = IsFoundationEnabled;

                        trigger OnAction()
                        begin
                            COMMIT;
                            PAGE.RUNMODAL(PAGE::"Adjust Inventory",Rec)
                        end;
                    }
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page 540;
                                        RunPageLink = Table ID=CONST(27),
                                      No.=FIELD(No.);
                        Scope = Repeater;
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action(DimensionsMultiple)
                    {
                        AccessByPermission = TableData 348=R;
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            Item: Record "27";
                            DefaultDimMultiple: Page "542";
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            DefaultDimMultiple.SetMultiItem(Item);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
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
                        Image = ItemLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page 38;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.)
                                      ORDER(Descending);
                        Scope = Repeater;
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the history of positive and negative inventory changes that reflect transactions with the selected item.';
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page 390;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.);
                        Scope = Repeater;
                    }
                }
            }
            group(PricesandDiscounts)
            {
                Caption = 'Prices and Discounts';
                action(Prices_Prices)
                {
                    Caption = 'Special Prices';
                    Image = Price;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page 7002;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                    Scope = Repeater;
                    ToolTip = 'Set up different prices for the selected item. An item price is automatically used on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                action(Prices_LineDiscounts)
                {
                    Caption = 'Special Discounts';
                    Image = LineDiscount;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page 7004;
                                    RunPageLink = Type=CONST(Item),
                                  Code=FIELD(No.);
                    RunPageView = SORTING(Type,Code);
                    Scope = Repeater;
                    ToolTip = 'Set up different discounts for the selected item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                action(PricesDiscountsOverview)
                {
                    Caption = 'Special Prices & Discounts Overview';
                    Image = PriceWorksheet;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        SalesPriceAndLineDiscounts: Page "1345";
                    begin
                        SalesPriceAndLineDiscounts.InitPage(TRUE);
                        SalesPriceAndLineDiscounts.LoadItem(Rec);
                        SalesPriceAndLineDiscounts.RUNMODAL;
                    end;
                }
                action("Sales Price Worksheet")
                {
                    Caption = 'Sales Price Worksheet';
                    Image = PriceWorksheet;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page 7023;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Adjust Cost - Item Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Adjust Cost - Item Entries';
                    Image = AdjustEntries;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Report 795;
                                    ToolTip = 'Adjust inventory values in value entries so that you use the correct adjusted cost for updating the general ledger and so that sales and profit statistics are up to date.';
                }
                action("Post Inventory Cost to G/L")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Post Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Report 1002;
                                    ToolTip = 'Post the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }
                action("Physical Inventory Journal")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Physical Inventory Journal';
                    Image = PhysicalInventory;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Page 392;
                                    ToolTip = 'Select how you want to maintain an up-to-date record of your inventory at different locations.';
                }
                action("Revaluation Journal")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Revaluation Journal';
                    Image = Journal;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Page 5803;
                                    ToolTip = 'View or edit the inventory value of items, which you can change, such as after doing a physical inventory.';
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        IF ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendItemForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);
                    end;
                }
            }
            group(Workflow)
            {
                Caption = 'Workflow';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Approval Workflow';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for creating or changing items, by going through a few pages that will guide you.';

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(PAGE::"Item Approval WF Setup Wizard");
                    end;
                }
                action(ManageApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Manage Approval Workflow';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for creating or changing items.';

                    trigger OnAction()
                    var
                        WorkflowManagement: Codeunit "1501";
                    begin
                        WorkflowManagement.NavigateToWorkflows(DATABASE::Item,EventFilter);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Create Stockkeeping Unit")
                {
                    AccessByPermission = TableData 5700=R;
                    Caption = '&Create Stockkeeping Unit';
                    Image = CreateSKU;

                    trigger OnAction()
                    var
                        Item: Record "27";
                    begin
                        Item.SETRANGE("No.","No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit",TRUE,FALSE,Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    AccessByPermission = TableData 7380=R;
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;

                    trigger OnAction()
                    var
                        Item: Record "27";
                        PhysInvtCountMgt: Codeunit "7380";
                    begin
                        CurrPage.SETSELECTIONFILTER(Item);
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Item);
                    end;
                }
                action(UpdateCostIncreaseCoeff)
                {
                    Caption = 'Update Cost Incr. Coeff.';
                    Image = CalculateCost;
                    RunObject = Report 50099;
                }
            }
            action("Requisition Worksheet")
            {
                Caption = 'Requisition Worksheet';
                Image = Worksheet;
                RunObject = Page 291;
            }
            action("Item Journal")
            {
                Caption = 'Item Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 40;
            }
            action("Item Reclassification Journal")
            {
                Caption = 'Item Reclassification Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 393;
            }
            action("Item Tracing")
            {
                Caption = 'Item Tracing';
                Image = ItemTracing;
                RunObject = Page 6520;
            }
            action("Adjust Item Cost/Price")
            {
                Caption = 'Adjust Item Cost/Price';
                Image = AdjustItemCost;
                RunObject = Report 794;
            }
        }
        area(reporting)
        {
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                action("Assemble to Order - Sales")
                {
                    Caption = 'Assemble to Order - Sales';
                    Image = "Report";
                    RunObject = Report 915;
                }
                action("Where-Used (Top Level)")
                {
                    Caption = 'Where-Used (Top Level)';
                    Image = "Report";
                    RunObject = Report 99000757;
                }
                action("Quantity Explosion of BOM")
                {
                    Caption = 'Quantity Explosion of BOM';
                    Image = "Report";
                    RunObject = Report 99000753;
                }
                group(Costing)
                {
                    Caption = 'Costing';
                    Image = ItemCosts;
                    action("Inventory Valuation - WIP")
                    {
                        Caption = 'Inventory Valuation - WIP';
                        Image = "Report";
                        RunObject = Report 5802;
                    }
                    action("Cost Shares Breakdown")
                    {
                        Caption = 'Cost Shares Breakdown';
                        Image = "Report";
                        RunObject = Report 5848;
                    }
                    action("Detailed Calculation")
                    {
                        Caption = 'Detailed Calculation';
                        Image = "Report";
                        RunObject = Report 99000756;
                    }
                    action("Rolled-up Cost Shares")
                    {
                        Caption = 'Rolled-up Cost Shares';
                        Image = "Report";
                        RunObject = Report 99000754;
                    }
                    action("Single-Level Cost Shares")
                    {
                        Caption = 'Single-Level Cost Shares';
                        Image = "Report";
                        RunObject = Report 99000755;
                    }
                }
            }
            group(Inventory)
            {
                Caption = 'Inventory';
                action("Inventory - List")
                {
                    Caption = 'Inventory - List';
                    Image = "Report";
                    RunObject = Report 701;
                }
                action("Inventory - Availability Plan")
                {
                    Caption = 'Inventory - Availability Plan';
                    Image = ItemAvailability;
                    RunObject = Report 707;
                }
                action("Item/Vendor Catalog")
                {
                    Caption = 'Item/Vendor Catalog';
                    Image = "Report";
                    RunObject = Report 720;
                }
                action("Phys. Inventory List")
                {
                    Caption = 'Phys. Inventory List';
                    Image = "Report";
                    RunObject = Report 722;
                }
                action("Nonstock Item Sales")
                {
                    Caption = 'Nonstock Item Sales';
                    Image = "Report";
                    RunObject = Report 5700;
                }
                action("Item Substitutions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Substitutions';
                    Image = "Report";
                    RunObject = Report 5701;
                                    ToolTip = 'View or edit any substitute items that are set up to be traded instead of the item in case it is not available.';
                }
                action("Price List")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Price List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = Report 715;
                                    ToolTip = 'View, print, or save a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                }
                action("Inventory Cost and Price List")
                {
                    Caption = 'Inventory Cost and Price List';
                    Image = "Report";
                    RunObject = Report 716;
                                    ToolTip = 'View, print, or save a list of your items and their price and cost information. The report specifies direct unit cost, last direct cost, unit price, profit percentage, and profit.';
                }
                action("Inventory Availability")
                {
                    Caption = 'Inventory Availability';
                    Image = "Report";
                    RunObject = Report 705;
                                    ToolTip = 'View, print, or save a summary of historical inventory transactions with selected items, for example, to decide when to purchase the items. The report specifies quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there are reorders.';
                }
                group("Item Register")
                {
                    Caption = 'Item Register';
                    Image = ItemRegisters;
                    action("Item Register - Quantity")
                    {
                        Caption = 'Item Register - Quantity';
                        Image = "Report";
                        RunObject = Report 703;
                    }
                    action("Item Register - Value")
                    {
                        Caption = 'Item Register - Value';
                        Image = "Report";
                        RunObject = Report 5805;
                    }
                }
                group(Costing)
                {
                    Caption = 'Costing';
                    Image = ItemCosts;
                    action("Inventory - Cost Variance")
                    {
                        Caption = 'Inventory - Cost Variance';
                        Image = ItemCosts;
                        RunObject = Report 721;
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        Caption = 'Invt. Valuation - Cost Spec.';
                        Image = "Report";
                        RunObject = Report 5801;
                    }
                    action("Compare List")
                    {
                        Caption = 'Compare List';
                        Image = "Report";
                        RunObject = Report 99000758;
                    }
                }
                group("Inventory Details")
                {
                    Caption = 'Inventory Details';
                    Image = "Report";
                    action("Inventory - Transaction Detail")
                    {
                        Caption = 'Inventory - Transaction Detail';
                        Image = "Report";
                        RunObject = Report 704;
                    }
                    action("Item Charges - Specification")
                    {
                        Caption = 'Item Charges - Specification';
                        Image = "Report";
                        RunObject = Report 5806;
                    }
                    action("Item Age Composition - Qty.")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Item Age Composition - Qty.';
                        Image = "Report";
                        RunObject = Report 5807;
                                        ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.';
                    }
                    action("Item Expiration - Quantity")
                    {
                        Caption = 'Item Expiration - Quantity';
                        Image = "Report";
                        RunObject = Report 5809;
                    }
                }
                group(Reports)
                {
                    Caption = 'Inventory Statistics';
                    Image = "Report";
                    action("Inventory - Sales Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory - Sales Statistics';
                        Image = "Report";
                        RunObject = Report 712;
                                        ToolTip = 'View, print, or save a summary of selected items'' sales per customer, for example, to analyze the profit on individual items or trends in revenues and profit. The report specifies direct unit cost, unit price, sales quantity, sales in LCY, profit percentage, and profit.';
                    }
                    action("Inventory - Customer Sales")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory - Customer Sales';
                        Image = "Report";
                        RunObject = Report 713;
                                        ToolTip = 'View, print, or save a list of customers that have purchased selected items within a selected period, for example, to analyze customers'' purchasing patterns. The report specifies quantity, amount, discount, profit percentage, and profit.';
                    }
                    action("Inventory - Top 10 List")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Inventory - Top 10 List';
                        Image = "Report";
                        RunObject = Report 711;
                                        ToolTip = 'View, print, or save a list of the top items by sales, quantity on hand, or inventory value. The report includes a bar graph to show you how the items rank.';
                    }
                }
                group("Finance Reports")
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action("Inventory Valuation")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Inventory Valuation';
                        Image = "Report";
                        RunObject = Report 1001;
                                        ToolTip = 'View, print, or save a list of the values of the on-hand quantity of each inventory item.';
                    }
                    action(Status)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Status';
                        Image = "Report";
                        RunObject = Report 706;
                                        ToolTip = 'View, print, or save the status of partially filled or unfilled orders so you can determine what effect filling these orders may have on your inventory.';
                    }
                    action("Item Age Composition - Value")
                    {
                        Caption = 'Item Age Composition - Value';
                        Image = "Report";
                        RunObject = Report 5808;
                                        ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.';
                    }
                }
            }
            group(Orders)
            {
                Caption = 'Orders';
                action("Inventory Order Details")
                {
                    Caption = 'Inventory Order Details';
                    Image = "Report";
                    RunObject = Report 708;
                }
                action("Inventory Purchase Orders")
                {
                    Caption = 'Inventory Purchase Orders';
                    Image = "Report";
                    RunObject = Report 709;
                }
                action("Inventory - Vendor Purchases")
                {
                    Caption = 'Inventory - Vendor Purchases';
                    Image = "Report";
                    RunObject = Report 714;
                }
                action("Inventory - Reorders")
                {
                    Caption = 'Inventory - Reorders';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 717;
                }
                action("Inventory - Sales Back Orders")
                {
                    Caption = 'Inventory - Sales Back Orders';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 718;
                }
            }
        }
        area(navigation)
        {
            group(Item)
            {
                Caption = 'Item';
                action(ApprovalEntries)
                {
                    AccessByPermission = TableData 454=R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
                    end;
                }
            }
            group(Availability)
            {
                Caption = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    AccessByPermission = TableData 14=R;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Items by Location",Rec);
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec,ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        RunObject = Page 157;
                                        RunPageLink = No.=FIELD(No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page 5414;
                                        RunPageLink = No.=FIELD(No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        RunObject = Page 492;
                                        RunPageLink = No.=FIELD(No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec,ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                    action(Timeline)
                    {
                        Caption = 'Timeline';
                        Image = Timeline;

                        trigger OnAction()
                        begin
                            ShowTimelineFromItem(Rec);
                        end;
                    }
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToProduct)
                {
                    ApplicationArea = All;
                    Caption = 'Product';
                    Image = CoupledItem;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM product.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "5330";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData 5331=IM;
                    ApplicationArea = All;
                    Caption = 'Synchronize Now';
                    Image = Refresh;
                    ToolTip = 'Send updated data to Microsoft Dynamics CRM.';

                    trigger OnAction()
                    var
                        Item: Record "27";
                        CRMIntegrationManagement: Codeunit "5330";
                        ItemRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Item);
                        Item.NEXT;

                        IF Item.COUNT = 1 THEN
                          CRMIntegrationManagement.UpdateOneNow(Item.RECORDID)
                        ELSE BEGIN
                          ItemRecordRef.GETTABLE(Item);
                          CRMIntegrationManagement.UpdateMultipleNow(ItemRecordRef);
                        END
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment='Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData 5331=IM;
                        ApplicationArea = All;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM product.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "5330";
                        begin
                            CRMIntegrationManagement.DefineCoupling(RECORDID);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData 5331=IM;
                        ApplicationArea = All;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM product.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "5331";
                        begin
                            CRMCouplingManagement.RemoveCoupling(RECORDID);
                        end;
                    }
                }
            }
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                Image = Production;
                action(Structure)
                {
                    Caption = 'Structure';
                    Image = Hierarchy;

                    trigger OnAction()
                    var
                        BOMStructure: Page "5870";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN;
                    end;
                }
                action("Cost Shares")
                {
                    Caption = 'Cost Shares';
                    Image = CostBudget;

                    trigger OnAction()
                    var
                        BOMCostShares: Page "5872";
                    begin
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.RUN;
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Assemb&ly';
                    Image = AssemblyBOM;
                    action("<Action32>")
                    {
                        Caption = 'Assembly BOM';
                        Image = BOM;
                        RunObject = Page 36;
                                        RunPageLink = Parent Item No.=FIELD(No.);
                    }
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        Image = Track;
                        RunObject = Page 37;
                                        RunPageLink = Type=CONST(Item),
                                      No.=FIELD(No.);
                        RunPageView = SORTING(Type,No.);
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem("No.",TRUE);
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Calc. Unit Price';
                        Image = SuggestItemPrice;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcAssemblyItemPrice("No.");
                        end;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                    Image = Production;
                    action("Production BOM")
                    {
                        Caption = 'Production BOM';
                        Image = BOM;
                        RunObject = Page 99000786;
                                        RunPageLink = No.=FIELD(Production BOM No.);
                    }
                    action("Where-Used")
                    {
                        AccessByPermission = TableData 90=R;
                        Caption = 'Where-Used';
                        Image = "Where-Used";

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "99000811";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec,WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        AccessByPermission = TableData 99000771=R;
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem("No.",FALSE);
                        end;
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page 497;
                                        RunPageLink = Reservation Status=CONST(Reservation),
                                      Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.,Variant Code,Location Code,Reservation Status);
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page 5802;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.);
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingDocMgt: Codeunit "6503";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(3,'',"No.",'','','','');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page 7318;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.,Bin Code,Location Code,Variant Code,Unit of Measure Code,Lot No.,Serial No.,Entry Type,Dedicated);
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "5827";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page 304;
                                        RunPageLink = No.=FIELD(No.),
                                      Date Filter=FIELD(Date Filter),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page 158;
                                        RunPageLink = No.=FIELD(No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(No.);
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action(Sales_Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7002;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
                action(Sales_LineDiscounts)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7004;
                                    RunPageLink = Type=CONST(Item),
                                  Code=FIELD(No.);
                    RunPageView = SORTING(Type,Code);
                }
                action("Marge Vente")
                {
                    Caption = 'Marge Vente';
                    RunObject = Page 50021;
                                    RunPageLink = Code=FIELD(Item Sales Profit Group);
                    RunPageView = SORTING(Code);
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page 664;
                                    RunPageLink = Item No.=FIELD(No.);
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page 48;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Type,No.);
                }
                action("Returns Orders")
                {
                    Caption = 'Returns Orders';
                    Image = ReturnOrder;
                    RunObject = Page 6633;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Type,No.);
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page 114;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7012;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7014;
                                    RunPageLink = Type=CONST(Item),
                                  Item No.=FIELD(No.);
                    RunPageView = SORTING(Type,Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity);
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page 665;
                                    RunPageLink = Item No.=FIELD(No.);
                }
                action(Orders)
                {
                    ApplicationArea = Suite;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page 56;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Type,No.);
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page 6643;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Type,No.);
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    RunObject = Page 5726;
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
                    RunObject = Page 7379;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page 5701;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;
                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    Image = ServiceItem;
                    RunObject = Page 5988;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
                action(Troubleshooting)
                {
                    AccessByPermission = TableData 5900=R;
                    Caption = 'Troubleshooting';
                    Image = Troubleshoot;

                    trigger OnAction()
                    var
                        TroubleshootingHeader: Record "5943";
                    begin
                        TroubleshootingHeader.ShowForItem(Rec);
                    end;
                }
                action("Troubleshooting Setup")
                {
                    Caption = 'Troubleshooting Setup';
                    Image = Troubleshoot;
                    RunObject = Page 5993;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                }
            }
            group(Resources)
            {
                Caption = 'Resources';
                Image = Resource;
                group("R&esource")
                {
                    Caption = 'R&esource';
                    Image = Resource;
                    action("Resource &Skills")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Resource &Skills';
                        Image = ResourceSkills;
                        RunObject = Page 6019;
                                        RunPageLink = Type=CONST(Item),
                                      No.=FIELD(No.);
                        ToolTip = 'View the assignment of skills to resources, items, service item groups, and service items. You can use skill codes to allocate skilled resources to service items or items that need special skills for servicing.';
                    }
                    action("Skilled R&esources")
                    {
                        AccessByPermission = TableData 5900=R;
                        ApplicationArea = Jobs;
                        Caption = 'Skilled R&esources';
                        Image = ResourceSkills;
                        ToolTip = 'View a list of all registered resources with information about whether they have the skills required to service the particular service item group, item, or service item.';

                        trigger OnAction()
                        var
                            ResourceSkill: Record "5956";
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item,"No.",Description);
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }
                action(UpdateICPartnerItems)
                {
                    Caption = 'Update IC Partner Items';
                    Enabled = UpdateICPartnerItemsEnabled;
                    Image = UpdateDescription;
                    RunObject = Codeunit 50021;
                }
            }
            action("Créer code-barres interne")
            {
                Caption = 'Create Internal BarCodes';
                Description = 'MIGNAV2013';
                Image = BarCode;

                trigger OnAction()
                begin
                    CLEAR(DistInt);
                    DistInt.CreateItemEAN13Code("No.",TRUE);
                end;
            }
            action(PrintLabel)
            {
                Caption = 'Print Label';
                Description = 'MIGNAV2013';
                Ellipsis = true;
                Image = BarCode;

                trigger OnAction()
                var
                    FromItem: Record "27";
                    PrintLabel: Report "50049";
                begin
                    //>>MIGRATION NAV 2013

                    CLEAR(PrintLabel);
                    CLEAR(FromItem);
                    CurrPage.SETSELECTIONFILTER(FromItem);
                    PrintLabel.SETTABLEVIEW(FromItem);
                    PrintLabel.RUN;
                    //<<MIGRATION NAV 2013
                end;
            }
            action(UpdateUnitPriceIncVAT)
            {
                Caption = 'Update Item Prices Inc VAT';
                Description = 'MIGNAV2013';
                Ellipsis = true;
                Image = Price;

                trigger OnAction()
                var
                    ItemToUpdate: Record "27";
                    UpdateUnitPriceIncVAT: Report "50053";
                begin
                    //>> CNE4.03
                    CLEAR(ItemToUpdate);
                    CLEAR(UpdateUnitPriceIncVAT);
                    CurrPage.SETSELECTIONFILTER(ItemToUpdate);
                    UpdateUnitPriceIncVAT.SETTABLEVIEW(ItemToUpdate);
                    UpdateUnitPriceIncVAT.RUN;
                end;
            }
            group("&Bin Contents")
            {
                Caption = '&Bin Contents';
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page 7379;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "5331";
    begin
        SetSocialListeningFactboxVisibility;

        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID) AND CRMIntegrationEnabled;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData("No.");

        SetWorkflowManagementEnabledState;
    end;

    trigger OnAfterGetRecord()
    var
        "-MIGNAV2013-": Integer;
        DistInt: Codeunit "5702";
    begin
        SetSocialListeningFactboxVisibility;
        EnableControls;
        //>MIGRATION NAV 2013
        EAN13Code := DistInt.GetItemEAN13Code("No.");
        //<<MIGRATION NAV 2013
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        Found: Boolean;
    begin
        IF RunOnTempRec THEN BEGIN
          TempFilteredItem := Rec;
          Found := TempFilteredItem.FIND(Which);
          IF Found THEN
            Rec := TempFilteredItem;
          EXIT(Found);
        END;
        EXIT(FIND(Which));
    end;

    trigger OnInit()
    begin
        //>>CR_NouvSte_CNE_20150605: TO 01/07/2015:
        IF STRPOS(COMPANYNAME,'CNE') = 0 THEN
          UpdateICPartnerItemsEnabled := FALSE
        ELSE
          UpdateICPartnerItemsEnabled := TRUE;
        //<<CR_NouvSte_CNE_20150605: TO 01/07/2015:
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        ResultSteps: Integer;
    begin
        IF RunOnTempRec THEN BEGIN
          TempFilteredItem := Rec;
          ResultSteps := TempFilteredItem.NEXT(Steps);
          IF ResultSteps <> 0 THEN
            Rec := TempFilteredItem;
          EXIT(ResultSteps);
        END;
        EXIT(NEXT(Steps));
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "5330";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
        SetWorkflowManagementEnabledState;
        /*
        //>MIGRATION NAV 2013
        //OLD
        {
        //FILTRE_ARTICLE_NONBLOQUE FG 05/12/2006 NSC1.01
        MemberOf.RESET;
        MemberOf.SETRANGE("User ID",USERID);
        MemberOf.SETRANGE("Role ID",'SUPER');
        IF MemberOf.FIND('-') THEN BEGIN
          SETRANGE(Blocked,FALSE);
        END ELSE BEGIN
          FILTERGROUP(2);
          SETRANGE(Blocked,FALSE);
          FILTERGROUP(0);
        END ;
        //FILTRE_ARTICLE_NONBLOQUE FG 05/12/2006 NSC1.01
        }
        //OLD
        //NEW
        RecGAccessControl.RESET ;
        RecGAccessControl.SETRANGE("User Security ID",USERSECURITYID) ;
        //RecGAccessControl.SETRANGE("Role ID",'SUPER') ;
        RecGAccessControl.SETRANGE("Role ID",'MODIFART') ;
        IF RecGAccessControl.FINDFIRST THEN BEGIN
          SETRANGE(Blocked,FALSE);
        END ELSE BEGIN
          FILTERGROUP(2);
          SETRANGE(Blocked,FALSE);
          FILTERGROUP(0);
        END
        //NEW
        //<<MIGRATION NAV 2013
         */
        
        //BC6 - MM 080119
        SETRANGE("Reordering Policy","Reordering Policy"::"Fixed Reorder Qty.");
        //BC6 - MM 080119

    end;

    var
        TempFilterItemAttributesBuffer: Record "7506" temporary;
        TempFilteredItem: Record "27" temporary;
        ApplicationAreaSetup: Record "9178";
        CalculateStdCost: Codeunit "5812";
        ItemAvailFormsMgt: Codeunit "353";
        ApprovalsMgmt: Codeunit "1535";
        SkilledResourceList: Page "6023";
                                 IsFoundationEnabled: Boolean;
    [InDataSet]

    SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RunOnTempRec: Boolean;
        EventFilter: Text;
        "-MIGNAV2013-": Integer;
        "--NSC1.01--": Integer;
        MemberOf: Record "2000000053";
        EAN13Code: Code[20];
        DistInt: Codeunit "5702";
        FormItemCrossRef: Page "5721";
                              ItemCrossRef: Record "5717";
                              RecGAccessControl: Record "2000000053";
                              "-CNEIC-": Integer;
                              UpdateICPartnerItemsEnabled: Boolean;

    [Scope('Internal')]
    procedure GetSelectionFilter(): Text
    var
        Item: Record "27";
        SelectionFilterManagement: Codeunit "46";
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;

    [Scope('Internal')]
    procedure SetSelection(var Item: Record "27")
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
        SocialListeningMgt: Codeunit "871";
    begin
        SocialListeningMgt.GetItemFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    end;

    local procedure EnableControls()
    begin
        IsService := (Type = Type::Service);
        InventoryItemEditable := Type = Type::Inventory;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "1501";
        WorkflowEventHandling: Codeunit "1520";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode;

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item, EventFilter);
    end;
}

