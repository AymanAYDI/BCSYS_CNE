page 50074 "BC6_Item List Search CNE"
{
    Caption = 'Item List', Comment = 'FRA="Liste des articles"';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes', Comment = 'FRA="Nouveau,Traiter,Déclarer,Historique,Prix et remises spéciaux,Demander une approbation,Traitements,Inventaire,Attributs"';
    RefreshOnActivate = true;
    SourceTable = Item;
    SourceTableTemporary = true;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(GroupSearch)
            {
                Caption = 'Search', Comment = 'FRA="Chercher"';
                usercontrol(ScanZone; "BC6_ControlAddinScanCapture")
                {
                    Visible = IsVisibleSearch;
                    ApplicationArea = All;

                    trigger ControlAddInReady()
                    begin
                        CurrPage.ScanZone.focus();
                    end;

                    trigger KeyPressed(index: Integer; data: Text)
                    begin
                    end;

                    trigger TextCaptured(index: Integer; data: Text)
                    begin
                        data := CONVERTSTR(data, ConvertFrom, ConvertTo);
                        SearchField := COPYSTR(data, 1, MAXSTRLEN(SearchField));
                        CurrPage.ScanZone.SetText(index, SearchField); //TODO: Check param
                        CurrPage.ScanZone.reset(index); //TODO: Check param
                        OnAfterValidate();
                        CurrPage.ScanZone.focus();
                    end;
                }
                field(SearchField; SearchField)
                {
                    Caption = 'Search', Comment = 'FRA="Rechercher"';
                    Visible = NOT (IsVisibleSearch);
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        OnAfterValidate();
                    end;
                }
                field(LastSearchField; LastSearchField)
                {
                    Caption = 'Last Search', Comment = 'FRA="Dernière recherche"';
                    Editable = false;
                    QuickEntry = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemCrossReference: Record "Item Reference";
                    begin
                        RESET();
                        DELETEALL();
                        IF SearchField <> '' THEN BEGIN
                            ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Reference No.", SearchField);
                            IF ItemCrossReference.FINDSET() THEN
                                REPEAT
                                    Item.GET(ItemCrossReference."Item No.");
                                    Rec := Item;
                                    IF INSERT() THEN;
                                UNTIL ItemCrossReference.NEXT() = 0;
                        END;
                        LastSearchField := SearchField;
                        SearchField := '';
                        CurrPage.ScanZone.SetBgColor(1, 'red'); //TODO: Check param
                    end;
                }
            }
            repeater(Item)
            {
                Caption = 'Item', Comment = 'FRA="Article"';
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.', Comment = 'FRA="Spécifie le numéro de l''article."';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.', Comment = 'FRA="Spécifie une description de l''élément."';
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).', Comment = 'FRA="Spécifie si la fiche article représente un article physique (Stock) ou un service (Service)."';
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    // HideValue = IsService;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.', Comment = 'FRA="Spécifie le nombre d''unités (par exemple des pièces, des boîtes ou des palettes) en stock."';
                }
                field("Created From Nonstock Item"; "Created From Nonstock Item")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Substitutes Exist"; "Substitutes Exist")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that a substitute exists for this item.', Comment = 'FRA="Spécifie qu''un substitut existe pour cet article."';
                }
                field("Stockkeeping Unit Exists"; "Stockkeeping Unit Exists")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly BOM"; "Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Production BOM No."; "Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; "Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.', Comment = 'FRA="Spécifie l''unité dans laquelle l''article est stocké."';
                }
                field("Shelf No."; "Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Costing Method"; "Costing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost is Adjusted"; "Cost is Adjusted")
                {
                    ApplicationArea = All;
                }
                field("Standard Cost"; "Standard Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost per unit of the item.', Comment = 'FRA="Spécifie le coût par unité de l''article."';
                }
                field("Last Direct Cost"; "Last Direct Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; "Price/Profit Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price for one unit of the item, in LCY.', Comment = 'FRA="Spécifie le prix unitaire, en DS, de l''article."';
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tariff No."; "Tariff No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the item''s tariff number.', Comment = 'FRA="Spécifie un code pour la nomenclature produit de l''article."';
                    Visible = false;
                }
                field("Search Description"; "Search Description")
                {
                    ApplicationArea = All;
                }
                field("Overhead Rate"; "Overhead Rate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Product Group Code"; "Product Group Code") TODO:
                // {
                //     Visible = false;
                //     ApplicationArea = All;
                // }
                field(Blocked; Blocked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; "Sales Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Replenishment System"; "Replenishment System")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; "Purch. Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Manufacturing Policy"; "Manufacturing Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Flushing Method"; "Flushing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly Policy"; "Assembly Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Tracking Code"; "Item Tracking Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Default Deferral Template Code"; "Default Deferral Template Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Default Deferral Template', Comment = 'FRA="Modèle échelonnement par défaut"';
                    Importance = Additional;
                    ToolTip = 'Specifies the default template that governs how to defer revenues and expenses to the periods when they occurred.', Comment = 'FRA="Spécifie le modèle par défaut qui régit la manière de reporter les revenus et les dépenses aux périodes auxquelles ils se sont produits."';
                }
            }
        }
        area(factboxes)
        {
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                ApplicationArea = All;
            }
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            part("Item Planning FactBox"; "Item Planning FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
            }
            part("Item Warehouse FactBox"; "Item Warehouse FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            part(ItemAttributesFactbox; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin

        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID) AND CRMIntegrationEnabled;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData("No.");
        IsVisibleSearch := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableControls();
        CurrPage.ScanZone.focus();
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
#pragma warning disable AL0432
        IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled();
#pragma warning restore AL0432
        SetWorkflowManagementEnabledState();
        IsVisibleSearch := NOT (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        Item: Record Item;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SkilledResourceList: Page "Skilled Resource List";
        CanCancelApprovalForRecord: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        IsFoundationEnabled: Boolean;
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        IsVisibleSearch: Boolean;
        OpenApprovalEntriesExist: Boolean;
        [InDataSet]


        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        LastSearchField: Code[20];
        SearchField: Code[20];
        ConfAddToItem: Label 'Add to an existing Item ?', Comment = 'FRA="Ajouter à un article existant ?"';
        ConvertFrom: Label '&é"''(-è_çà';
        ConvertTo: Label '1234567890';
        EventFilter: Text;


    procedure GetSelectionFilter(): Text
    var
        Item: Record Item;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;


    procedure SetSelection(var Items: Record Item)
    begin
        CurrPage.SETSELECTIONFILTER(Items);
    end;



    local procedure EnableControls()
    begin
        IsService := (Type = Type::Service);
        InventoryItemEditable := Type = Type::Inventory;
        IsVisibleSearch := TRUE;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode() + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode();

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item, EventFilter);
    end;

    local procedure OnAfterValidate()
    var
        Item: Record Item;
        ItemReference: Record "Item Reference";
    begin
        RESET();
        DELETEALL();
        CLEAR(Rec);
        IF SearchField <> '' THEN BEGIN
            ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
            ItemReference.SETRANGE("Reference No.", SearchField);
            IF ItemReference.FINDSET() THEN BEGIN
                REPEAT
                    Item.GET(ItemReference."Item No.");
                    Rec := Item;
                    IF INSERT() THEN;
                UNTIL ItemReference.NEXT() = 0;
            END ELSE BEGIN
                IF CONFIRM(ConfAddToItem, TRUE) THEN
                    IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Item List", Item) THEN BEGIN
                        ItemReference.INIT();
                        ItemReference."Reference Type" := ItemReference."Reference Type"::"Bar Code";
                        ItemReference."Reference No." := SearchField;
                        ItemReference."Item No." := Item."No.";
                        ItemReference.INSERT();
                        Rec := Item;
                        IF INSERT() THEN;
                    END;
            END;
        END;
        LastSearchField := SearchField;
        SearchField := '';
        CurrPage.ScanZone.SetText(1, LastSearchField);  //TODO: Check param
        IF ISEMPTY THEN
            CurrPage.ScanZone.SetBgColor(1, 'red') //TODO: Check param
        ELSE
            CurrPage.ScanZone.SetBgColor(1, 'green'); //TODO: Check param
        CurrPage.ScanZone.focus();
        CurrPage.UPDATE(FALSE);
    end;
}

