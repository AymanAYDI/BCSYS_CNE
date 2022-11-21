page 50074 "BC6_Item List Search CNE"
{
    Caption = 'Item List';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    RefreshOnActivate = true;
    SourceTable = Item;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(GroupSearch)
            {
                Caption = 'Search';
                usercontrol(ScanZone; "ControlAddinScanCapture")
                {
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
                        CurrPage.ScanZone.SetText('');
                        CurrPage.ScanZone.reset();
                        OnAfterValidate;
                        CurrPage.ScanZone.focus();
                    end;
                }
                field(SearchField; SearchField)
                {
                    Caption = 'Search';
                    Visible = NOT (IsVisibleSearch);

                    trigger OnValidate()
                    begin
                        OnAfterValidate;
                    end;
                }
                field(LastSearchField; LastSearchField)
                {
                    Caption = 'Last Search';
                    Editable = false;
                    QuickEntry = false;

                    trigger OnValidate()
                    var
                        ItemCrossReference: Record "5717";
                    begin
                        RESET;
                        DELETEALL;
                        IF SearchField <> '' THEN BEGIN
                            ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Cross-Reference No.", SearchField);
                            IF ItemCrossReference.FINDSET THEN
                                REPEAT
                                    Item.GET(ItemCrossReference."Item No.");
                                    Rec := Item;
                                    IF INSERT THEN;
                                UNTIL ItemCrossReference.NEXT = 0;
                        END;
                        LastSearchField := SearchField;
                        SearchField := '';
                        CurrPage.ScanZone.SetBgColor('red');
                    end;
                }
            }
            repeater(Item)
            {
                Caption = 'Item';
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.';
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).';
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = IsService;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                }
                field("Created From Nonstock Item"; "Created From Nonstock Item")
                {
                    Visible = false;
                }
                field("Substitutes Exist"; "Substitutes Exist")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that a substitute exists for this item.';
                }
                field("Stockkeeping Unit Exists"; "Stockkeeping Unit Exists")
                {
                    Visible = false;
                }
                field("Assembly BOM"; "Assembly BOM")
                {
                }
                field("Production BOM No."; "Production BOM No.")
                {
                }
                field("Routing No."; "Routing No.")
                {
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.';
                }
                field("Shelf No."; "Shelf No.")
                {
                    Visible = false;
                }
                field("Costing Method"; "Costing Method")
                {
                    Visible = false;
                }
                field("Cost is Adjusted"; "Cost is Adjusted")
                {
                }
                field("Standard Cost"; "Standard Cost")
                {
                    Visible = false;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost per unit of the item.';
                }
                field("Last Direct Cost"; "Last Direct Cost")
                {
                    Visible = false;
                }
                field("Price/Profit Calculation"; "Price/Profit Calculation")
                {
                    Visible = false;
                }
                field("Profit %"; "Profit %")
                {
                    Visible = false;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price for one unit of the item, in LCY.';
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    Visible = false;
                }
                field("Tariff No."; "Tariff No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the item''s tariff number.';
                    Visible = false;
                }
                field("Search Description"; "Search Description")
                {
                }
                field("Overhead Rate"; "Overhead Rate")
                {
                    Visible = false;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    Visible = false;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Visible = false;
                }
                field(Blocked; Blocked)
                {
                    Visible = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Visible = false;
                }
                field("Sales Unit of Measure"; "Sales Unit of Measure")
                {
                    Visible = false;
                }
                field("Replenishment System"; "Replenishment System")
                {
                    Visible = false;
                }
                field("Purch. Unit of Measure"; "Purch. Unit of Measure")
                {
                    Visible = false;
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    Visible = false;
                }
                field("Manufacturing Policy"; "Manufacturing Policy")
                {
                    Visible = false;
                }
                field("Flushing Method"; "Flushing Method")
                {
                    Visible = false;
                }
                field("Assembly Policy"; "Assembly Policy")
                {
                    Visible = false;
                }
                field("Item Tracking Code"; "Item Tracking Code")
                {
                    Visible = false;
                }
                field("Default Deferral Template Code"; "Default Deferral Template Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Default Deferral Template';
                    Importance = Additional;
                    ToolTip = 'Specifies the default template that governs how to defer revenues and expenses to the periods when they occurred.';
                }
            }
        }
        area(factboxes)
        {
            part(; 875)
            {
                ApplicationArea = All;
                SubPageLink = "Source Type" = CONST(Item),
                              "Source No." = FIELD("No.");
                Visible = SocialListeningVisible;
            }
            part(; 876)
            {
                ApplicationArea = All;
                SubPageLink = "Source Type"=CONST(Item),
                              "Source No."=FIELD("No.");
                                             UpdatePropagation = Both;
                                             Visible = SocialListeningSetupVisible;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                SubPageLink = "No."=FIELD("No."),
                              "Date Filter"=FIELD("Date Filter"),
                              "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                              "Location Filter"=FIELD("Location Filter"),
                              "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                              "Bin Filter"=FIELD("Bin Filter"),
                              "Variant Filter"=FIELD("Variant Filter"),
                              "Lot No. Filter"=FIELD("Lot No. Filter"),
                              "Serial No. Filter"=FIELD("Serial No. Filter");
            }
            part("Item Replenishment FactBox";"Item Replenishment FactBox")
            {
                SubPageLink = "No."=FIELD(No.""),
                              "Date Filter"=FIELD("Date Filter"),
                              "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                              "Location Filter"=FIELD("Location Filter"),
                              "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                              "Bin Filter"=FIELD("Bin Filter"),
                              "Variant Filter"=FIELD("Variant Filter"),
                              "Lot No. Filter"=FIELD(" "),
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
        IsVisibleSearch := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        SetSocialListeningFactboxVisibility;
        EnableControls;
        CurrPage.ScanZone.focus();
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "5330";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
        SetWorkflowManagementEnabledState;
        IsVisibleSearch := NOT (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
    end;

    var
        TempFilterItemAttributesBuffer: Record "7506" temporary;
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
        EventFilter: Text;
        SearchField: Code[20];
        Item: Record "27";
        LastSearchField: Code[20];
        [InDataSet]
        IsVisibleSearch: Boolean;
        ConfAddToItem: Label 'Add to an existing Item ?';
        ConvertFrom: Label '&é"''(-è_çà';
        ConvertTo: Label '1234567890';

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
        SocialListeningMgt.GetItemFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;

    local procedure EnableControls()
    begin
        IsService := (Type = Type::Service);
        InventoryItemEditable := Type = Type::Inventory;
        IsVisibleSearch := TRUE;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "1501";
        WorkflowEventHandling: Codeunit "1520";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode;

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item,EventFilter);
    end;

    local procedure OnAfterValidate()
    var
        ItemCrossReference: Record "5717";
        Item: Record "27";
    begin
        RESET;
        DELETEALL;
        CLEAR(Rec);
        IF SearchField <> '' THEN BEGIN
          ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
          ItemCrossReference.SETRANGE("Cross-Reference No.", SearchField);
          IF ItemCrossReference.FINDSET THEN BEGIN
            REPEAT
              Item.GET(ItemCrossReference."Item No.");
              Rec := Item;
              IF INSERT THEN;
            UNTIL ItemCrossReference.NEXT = 0;
          END ELSE BEGIN
            IF CONFIRM(ConfAddToItem,TRUE) THEN
              IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Item List",Item) THEN BEGIN
                ItemCrossReference.INIT;
                ItemCrossReference."Cross-Reference Type" := ItemCrossReference."Cross-Reference Type"::"Bar Code";
                ItemCrossReference."Cross-Reference No." :=  SearchField;
                ItemCrossReference."Item No." := Item."No.";
                ItemCrossReference.INSERT;
                Rec := Item;
                IF INSERT THEN;
              END;
          END;
        END;
        LastSearchField := SearchField;
        SearchField := '';
        CurrPage.ScanZone.SetText(LastSearchField);
        IF ISEMPTY THEN
          CurrPage.ScanZone.SetBgColor('red')
        ELSE
          CurrPage.ScanZone.SetBgColor('green');
        CurrPage.ScanZone.focus();
        CurrPage.UPDATE(FALSE);
    end;
}

