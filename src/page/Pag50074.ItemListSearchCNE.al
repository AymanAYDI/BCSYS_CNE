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
                    ApplicationArea = All;
                    Visible = IsVisibleSearch;

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
                    ApplicationArea = All;
                    Caption = 'Search', Comment = 'FRA="Rechercher"';
                    Visible = NOT (IsVisibleSearch);

                    trigger OnValidate()
                    begin
                        OnAfterValidate();
                    end;
                }
                field(LastSearchField; LastSearchField)
                {
                    ApplicationArea = All;
                    Caption = 'Last Search', Comment = 'FRA="Dernière recherche"';
                    Editable = false;
                    QuickEntry = false;

                    trigger OnValidate()
                    var
                        ItemCrossReference: Record "Item Reference";
                    begin
                        Rec.RESET();
                        Rec.DELETEALL();
                        IF SearchField <> '' THEN BEGIN
                            ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Reference No.", SearchField);
                            IF ItemCrossReference.FINDSET() THEN
                                REPEAT
                                    Item.GET(ItemCrossReference."Item No.");
                                    Rec := Item;
                                    IF Rec.INSERT() THEN;
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.', Comment = 'FRA="Spécifie le numéro de l''article."';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.', Comment = 'FRA="Spécifie une description de l''élément."';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).', Comment = 'FRA="Spécifie si la fiche article représente un article physique (Stock) ou un service (Service)."';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = IsService;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.', Comment = 'FRA="Spécifie le nombre d''unités (par exemple des pièces, des boîtes ou des palettes) en stock."';
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that a substitute exists for this item.', Comment = 'FRA="Spécifie qu''un substitut existe pour cet article."';
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.', Comment = 'FRA="Spécifie l''unité dans laquelle l''article est stocké."';
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost per unit of the item.', Comment = 'FRA="Spécifie le coût par unité de l''article."';
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price for one unit of the item, in LCY.', Comment = 'FRA="Spécifie le prix unitaire, en DS, de l''article."';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the item''s tariff number.', Comment = 'FRA="Spécifie un code pour la nomenclature produit de l''article."';
                    Visible = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Product Group Code"; "Product Group Code") TODO:
                // {
                //     Visible = false;
                //     ApplicationArea = All;
                // }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
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
                ApplicationArea = All;
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
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
        CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID);

        ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");
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
        CRMIntegrationManagement.IsCRMIntegrationEnabled();
        ApplicationAreaSetup.IsFoundationEnabled();
        SetWorkflowManagementEnabledState();
        IsVisibleSearch := NOT (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        Item: Record Item;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        IsVisibleSearch: Boolean;
        LastSearchField: Code[20];
        SearchField: Code[20];
        ConfAddToItem: Label 'Add to an existing Item ?', Comment = 'FRA="Ajouter à un article existant ?"';
        ConvertFrom: Label '&é"''(-è_çà';
        ConvertTo: Label '1234567890';
        EventFilter: Text;

    procedure GetSelectionFilter(): Text
    var
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
        IsService := (Rec.Type = Rec.Type::Service);
        IsVisibleSearch := TRUE;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode() + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode();

        WorkflowManagement.EnabledWorkflowExist(DATABASE::Item, EventFilter);
    end;

    local procedure OnAfterValidate()
    var
        LItem: Record Item;
        ItemReference: Record "Item Reference";
    begin
        Rec.RESET();
        Rec.DELETEALL();
        CLEAR(Rec);
        IF SearchField <> '' THEN BEGIN
            ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
            ItemReference.SETRANGE("Reference No.", SearchField);
            IF ItemReference.FINDSET() THEN
                REPEAT
                    LItem.GET(ItemReference."Item No.");
                    Rec := LItem;
                    IF Rec.INSERT() THEN;
                UNTIL ItemReference.NEXT() = 0
            ELSE
                IF CONFIRM(ConfAddToItem, TRUE) THEN
                    IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Item List", LItem) THEN BEGIN
                        ItemReference.INIT();
                        ItemReference."Reference Type" := ItemReference."Reference Type"::"Bar Code";
                        ItemReference."Reference No." := SearchField;
                        ItemReference."Item No." := LItem."No.";
                        ItemReference.INSERT();
                        Rec := LItem;
                        IF Rec.INSERT() THEN;
                    END;
        END;
        LastSearchField := SearchField;
        SearchField := '';
        CurrPage.ScanZone.SetText(1, LastSearchField);  //TODO: Check param
        IF Rec.ISEMPTY THEN
            CurrPage.ScanZone.SetBgColor(1, 'red') //TODO: Check param
        ELSE
            CurrPage.ScanZone.SetBgColor(1, 'green'); //TODO: Check param
        CurrPage.ScanZone.focus();
        CurrPage.UPDATE(FALSE);
    end;
}
