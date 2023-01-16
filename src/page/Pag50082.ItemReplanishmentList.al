page 50082 "BC6_Item Replanishment List"
{
    ApplicationArea = All;
    Caption = 'Item Replanishment List', Comment = 'FRA="Liste réapprovisonnement articles"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes', Comment = 'FRA="Nouveau,Traiter,Déclarer,Historique,Prix et remises spéciaux,Demander une approbation,Traitements,Inventaire,Attributs"';
    RefreshOnActivate = true;
    SourceTable = Item;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Item)
            {
                Caption = 'Item', Comment = 'FRA="Article"';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number of the item.', Comment = 'FRA="Spécifie le numéro de l''article."';
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a description of the item.', Comment = 'FRA="Spécifie une description de l''élément."';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ApplicationArea = All;
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Search Description 2"; Rec."Bc6_Search Description 2")
                {
                    ApplicationArea = All;
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
            part(ItemAttributesFactBox; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(RecordLinks; Links)
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
        area(processing)
        {
            group(Item1)
            {
                Caption = 'Item', Comment = 'FRA="Article"';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    ApplicationArea = All;
                    Caption = '&Units of Measure', Comment = 'FRA="&Unités"';
                    Image = UnitOfMeasure;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up the different units that the selected item can be traded in, such as piece, box, or hour.', Comment = 'FRA="Configurez les différentes unités dans lesquelles l''article sélectionné peut être négocié, par exemple pièce, boîte ou heure."';
                }
                action(Attributes)
                {
                    AccessByPermission = TableData "Item Attribute" = R;
                    ApplicationArea = All;
                    Caption = 'Attributes', Comment = 'FRA="Attributs"';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Scope = Repeater;
                    ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.', Comment = 'FRA="Affichez ou modifiez les attributs de l''article, tels que la couleur, la taille ou d''autres caractéristiques permettant de le décrire."';

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(PAGE::"Item Attribute Value Editor", Rec);
                        CurrPage.SAVERECORD();
                        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");
                    end;
                }
                action(FilterByAttributes)
                {
                    AccessByPermission = TableData "Item Attribute" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Filter by Attributes', Comment = 'FRA="Filtrer par attributs"';
                    Image = EditFilter;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedOnly = true;
                    ToolTip = 'Find items that match specific attributes. To make sure you include recent changes made by other users, clear the filter and then reset it.', Comment = 'FRA="Recherchez des articles qui correspondent à des attributs spécifiques. Pour vous assurer d''inclure les modifications récentes apportées par d''autres utilisateurs, effacez le filtre, puis réinitialisez-le."';

                    trigger OnAction()
                    var
                        ItemAttributeManagement: Codeunit "Item Attribute Management";
                        TypeHelper: Codeunit "Type Helper";
                        CloseAction: Action;
                        FilterPageID: Integer;
                        ParameterCount: Integer;
                        FilterText: Text;
                    begin
                        FilterPageID := PAGE::"Filter Items by Attribute";
                        IF CURRENTCLIENTTYPE = CLIENTTYPE::Phone THEN
                            FilterPageID := PAGE::"Filter Items by Att. Phone";

                        CloseAction := PAGE.RUNMODAL(FilterPageID, TempFilterItemAttributesBuffer);
                        IF (CURRENTCLIENTTYPE <> CLIENTTYPE::Phone) AND (CloseAction <> ACTION::LookupOK) THEN
                            EXIT;

                        ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempFilteredItem);
                        FilterText := ItemAttributeManagement.GetItemNoFilterText(TempFilteredItem, ParameterCount);

                        IF ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery() - 100 THEN BEGIN
                            Rec.FILTERGROUP(0);
                            Rec.MARKEDONLY(FALSE);
                            Rec.SETFILTER("No.", FilterText);
                        END ELSE BEGIN
                            RunOnTempRec := TRUE;
                            Rec.CLEARMARKS();
                            Rec.RESET();
                        END;
                    end;
                }
                action(ClearAttributes)
                {
                    AccessByPermission = TableData "Item Attribute" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Clear Attributes Filter', Comment = 'FRA="Effacer le filtre d''attributs"';
                    Image = RemoveFilterLines;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedOnly = true;
                    ToolTip = 'Remove the filter for specific item attributes.', Comment = 'FRA="Supprimez le filtre pour les attributs article spécifiques."';

                    trigger OnAction()
                    begin
                        Rec.CLEARMARKS();
                        Rec.MARKEDONLY(FALSE);
                        TempFilterItemAttributesBuffer.RESET();
                        TempFilterItemAttributesBuffer.DELETEALL();
                        TempFilteredItem.RESET();
                        TempFilteredItem.DELETEALL();
                        RunOnTempRec := FALSE;
                        Rec.FILTERGROUP(0);
                        Rec.SETRANGE("No.");
                    end;
                }
                action("Va&riants")
                {
                    ApplicationArea = All;
                    Caption = 'Va&riants', Comment = 'FRA="&Variantes"';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Substituti&ons")
                {
                    ApplicationArea = Suite;
                    Caption = 'Substituti&ons', Comment = 'FRA="Articles de su&bstitution"';
                    Image = ItemSubstitution;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                }
                action(Identifiers)
                {
                    ApplicationArea = All;
                    Caption = 'Identifiers', Comment = 'FRA="Identifiants"';
                    Image = BarCode;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cross Re&ferences', Comment = 'FRA="&Références externes"';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    RunObject = Page "Item References";
                    RunPageLink = "Item No." = FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', Comment = 'FRA="Configurez la manière dont un client ou un fournisseur identifie l''article sélectionné. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez."';
                }
                action("E&xtended Texts")
                {
                    ApplicationArea = All;
                    Caption = 'E&xtended Texts', Comment = 'FRA="Te&xtes étendus"';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    Scope = Repeater;
                    ToolTip = 'Set up additional text for the description of the selected item. Extended text can be inserted under the Description field on document lines for the item.', Comment = 'FRA="Définissez un texte supplémentaire pour la description de l''article sélectionné. Un texte plus long peut être inséré sous le champ Description sur les lignes document de l''article."';
                }
                action(Translations)
                {
                    ApplicationArea = All;
                    Caption = 'Translations', Comment = 'FRA="Traductions"';
                    Image = Translations;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No."),
                                  "Variant Code" = CONST();
                    Scope = Repeater;
                    ToolTip = 'Set up translated item descriptions for the selected item. Translated item descriptions are automatically inserted on documents according to the language code.', Comment = 'FRA="Configurez des descriptions traduites pour l''article sélectionné. Les descriptions d''articles traduites sont automatiquement insérées dans les documents en fonction du code de langue."';
                }
                group(Action145)
                {
                    Visible = false; //it is unvisible , why ?
                    action(AdjustInventory)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Inventory', Comment = 'FRA="Ajuster stock"';
                        Enabled = InventoryItemEditable;
                        Image = InventoryCalculation;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        Scope = Repeater;
                        ToolTip = 'Increase or decrease the item''s inventory quantity manually by entering a new quantity. Adjusting the inventory quantity manually may be relevant after a physical count or if you do not record purchased quantities.', Comment = 'FRA="Vous pouvez augmenter ou diminuer manuellement la quantité en stock d''un article en entrant une nouvelle quantité. Il peut s''avérer utile d''ajuster manuellement la quantité d''inventaire après un décompte physique ou si vous n''enregistrez pas les quantités achetées."';
                        Visible = IsFoundationEnabled;

                        trigger OnAction()
                        begin
                            COMMIT();
                            PAGE.RUNMODAL(PAGE::"Adjust Inventory", Rec)
                        end;
                    }
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-Single', Comment = 'FRA="Affectations - Simples"';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27),
                                      "No." = FIELD("No.");
                        Scope = Repeater;
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action(DimensionsMultiple)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-&Multiple', Comment = 'FRA="Affectations - &Multiples"';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            Item: Record Item;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            DefaultDimMultiple.SetMultiRecord(Item, Rec.FieldNo("No."));
                            DefaultDimMultiple.RUNMODAL();
                        end;
                    }
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
                        Image = ItemLedger;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedOnly = true;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.")
                                      ORDER(Descending);
                        Scope = Repeater;
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the history of positive and negative inventory changes that reflect transactions with the selected item.', Comment = 'FRA="Affichez l''historique des modifications de stock positives et négatives qui reflètent les transactions avec l''article sélectionné."';
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Phys. Inventory Ledger Entries', Comment = 'FRA="Écritures comptables &inventaire"';
                        Image = PhysicalInventoryLedger;
                        Promoted = true;
                        //PromotedCategory = Category5;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        Scope = Repeater;
                    }
                }
            }
            group(PricesandDiscounts)
            {
                Caption = 'Prices and Discounts', Comment = 'FRA="Prix et remises"';
                action(Prices_Prices)
                {
                    ApplicationArea = All;
                    Caption = 'Special Prices', Comment = 'FRA="Prix spéciaux"';
                    Image = Price;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    Scope = Repeater;
                    ToolTip = 'Set up different prices for the selected item. An item price is automatically used on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Configurez des prix différents pour l''article sélectionné. Un prix article est automatiquement utilisé sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin."';
                }
                action(Prices_LineDiscounts)
                {
                    ApplicationArea = All;
                    Caption = 'Special Discounts', Comment = 'FRA="Remises spéciales"';
                    Image = LineDiscount;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item),
                                  Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    Scope = Repeater;
                    ToolTip = 'Set up different discounts for the selected item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Configurez des remises différentes pour l''article sélectionné. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin."';
                }
                action(PricesDiscountsOverview)
                {
                    ApplicationArea = All;
                    Caption = 'Special Prices & Discounts Overview', Comment = 'FRA="Aperçu des prix et remises spéciaux"';
                    Image = PriceWorksheet;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SalesPriceAndLineDiscounts: Page "Sales Price and Line Discounts";
                    begin
                        SalesPriceAndLineDiscounts.InitPage(TRUE);
                        SalesPriceAndLineDiscounts.LoadItem(Rec);
                        SalesPriceAndLineDiscounts.RUNMODAL();
                    end;
                }
                action("Sales Price Worksheet")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Price Worksheet', Comment = 'FRA="Feuille prix vente"';
                    Image = PriceWorksheet;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    RunObject = Page "Sales Price Worksheet";
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities', Comment = 'FRA="Traitements"';
                action("Adjust Cost - Item Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Cost - Item Entries', Comment = 'FRA="Ajuster coûts : Écr. article"';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedOnly = true;
                    RunObject = Report "Adjust Cost - Item Entries";
                    ToolTip = 'Adjust inventory values in value entries so that you use the correct adjusted cost for updating the general ledger and so that sales and profit statistics are up to date.', Comment = 'FRA="Ajustez les valeurs de stocks des écritures valeur afin que vous utilisiez le coût ajusté correct pour la mise à jour de la comptabilité et que les statistiques vente et profit soient à jour."';
                }
                action("Post Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Inventory Cost to G/L', Comment = 'FRA="Valider coûts ajustés"';
                    Image = PostInventoryToGL;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedOnly = true;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Post the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.', Comment = 'FRA="Validez les changements de quantité et de valeur en stock dans les écritures comptables article et les écritures valeur lorsque vous validez des mouvements de stocks, tels que des expéditions vente ou des réceptions achat."';
                }
                action("Physical Inventory Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Physical Inventory Journal', Comment = 'FRA="Feuille inventaire phys."';
                    Image = PhysicalInventory;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedOnly = true;
                    RunObject = Page "Phys. Inventory Journal";
                    ToolTip = 'Select how you want to maintain an up-to-date record of your inventory at different locations.', Comment = 'FRA="Sélectionnez comment vous souhaitez conserver un enregistrement mis à jour du stock dans différents magasins."';
                }
                action("Revaluation Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Revaluation Journal', Comment = 'FRA="Feuille réévaluation"';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedOnly = true;
                    RunObject = Page "Revaluation Journal";
                    ToolTip = 'View or edit the inventory value of items, which you can change, such as after doing a physical inventory.', Comment = 'FRA="Affichez ou modifiez la valeur stock des articles, que vous pouvez modifier, par exemple, après avoir effectué un inventaire."';
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval', Comment = 'FRA="Approbation demande achat"';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''a&pprobation"';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.', Comment = 'FRA="Envoyez une demande d''approbation."';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendItemForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler demande d''appro&bation"';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Cancel the approval request.', Comment = 'FRA="Annulez la demande d''approbation."';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);
                    end;
                }
            }
            group(Workflow)
            {
                Caption = 'Workflow', Comment = 'FRA="Flux de travail"';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Approval Workflow', Comment = 'FRA="Créer flux de travail approbation"';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for creating or changing items, by going through a few pages that will guide you.', Comment = 'FRA="Configurez un flux de travail approbation pour créer ou modifier des articles, en consultant quelques pages qui vous guideront."';

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(PAGE::"Item Approval WF Setup Wizard");
                    end;
                }
                action(ManageApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Manage Approval Workflow', Comment = 'FRA="Gérer le flux de travail approbation"';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for creating or changing items.', Comment = 'FRA="Affichez ou modifiez des flux de travail approbation existants pour créer ou modifier des articles."';

                    trigger OnAction()
                    var
                        WorkflowManagement: Codeunit "Workflow Management";
                    begin
                        WorkflowManagement.NavigateToWorkflows(DATABASE::Item, EventFilter);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("&Create Stockkeeping Unit")
                {
                    AccessByPermission = TableData "Stockkeeping Unit" = R;
                    ApplicationArea = All;
                    Caption = '&Create Stockkeeping Unit', Comment = 'FRA="&Créer point de stock"';
                    Image = CreateSKU;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", TRUE, FALSE, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    AccessByPermission = TableData "Phys. Invt. Item Selection" = R;
                    ApplicationArea = All;
                    Caption = 'C&alculate Counting Period', Comment = 'FRA="C&alculer période d''inventaire"';
                    Image = CalculateCalendar;

                    trigger OnAction()
                    var
                        Item: Record Item;
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        CurrPage.SETSELECTIONFILTER(Item);
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Item);
                    end;
                }
                action(UpdateCostIncreaseCoeff)
                {
                    ApplicationArea = All;
                    Caption = 'Update Cost Incr. Coeff.', Comment = 'FRA="Modifier coeff majoration du coût"';
                    Image = CalculateCost;
                    RunObject = Report "BC6_Upd Item Cost Incr. Coeff.";
                }
            }
            action("Requisition Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Requisition Worksheet', Comment = 'FRA="Demande achat"';
                Image = Worksheet;
                RunObject = Page "Req. Worksheet";
            }
            action("Item Journal")
            {
                ApplicationArea = All;
                Caption = 'Item Journal', Comment = 'FRA="Feuille article"';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Journal";
            }
            action("Item Reclassification Journal")
            {
                ApplicationArea = All;
                Caption = 'Item Reclassification Journal', Comment = 'FRA="Feuille reclassement article"';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Reclass. Journal";
            }
            action("Item Tracing")
            {
                ApplicationArea = All;
                Caption = 'Item Tracing', Comment = 'FRA="Traçabilité"';
                Image = ItemTracing;
                RunObject = Page "Item Tracing";
            }
            action("Adjust Item Cost/Price")
            {
                ApplicationArea = All;
                Caption = 'Adjust Item Cost/Price', Comment = 'FRA="Ajuster coût et prix article"';
                Image = AdjustItemCost;
                RunObject = Report "Adjust Item Costs/Prices";
            }
        }
        area(reporting)
        {
            group("Assembly/Production_reporting")
            {
                Caption = 'Assembly/Production', Comment = 'FRA="Assemblage/Production"';
                action("Assemble to Order - Sales")
                {
                    ApplicationArea = All;
                    Caption = 'Assemble to Order - Sales', Comment = 'FRA="Assembler pour commande - Ventes"';
                    Image = "Report";
                    RunObject = Report "Assemble to Order - Sales";
                }
                action("Where-Used (Top Level)")
                {
                    ApplicationArea = All;
                    Caption = 'Where-Used (Top Level)', Comment = 'FRA="Cas d''emploi (multi-niveau)"';
                    Image = "Report";
                    RunObject = Report "Where-Used (Top Level)";
                }
                action("Quantity Explosion of BOM")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Explosion of BOM', Comment = 'FRA="Nomenclature multi-niveau"';
                    Image = "Report";
                    RunObject = Report "Quantity Explosion of BOM";
                }
                group(Costing_reporting)
                {
                    Caption = 'Costing', Comment = 'FRA="Evaluation stock"';
                    Image = ItemCosts;
                    action("Inventory Valuation - WIP")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Valuation - WIP', Comment = 'FRA="Évaluation du stock d''en-cours"';
                        Image = "Report";
                        RunObject = Report "Inventory Valuation - WIP";
                    }
                    action("Cost Shares Breakdown")
                    {
                        ApplicationArea = All;
                        Caption = 'Cost Shares Breakdown', Comment = 'FRA="Analyse des coûts"';
                        Image = "Report";
                        RunObject = Report "Cost Shares Breakdown";
                    }
                    action("Detailed Calculation")
                    {
                        ApplicationArea = All;
                        Caption = 'Detailed Calculation', Comment = 'FRA="Coût détaillé"';
                        Image = "Report";
                        RunObject = Report "Detailed Calculation";
                    }
                    action("Rolled-up Cost Shares")
                    {
                        ApplicationArea = All;
                        Caption = 'Rolled-up Cost Shares', Comment = 'FRA="Coût multi-niveau détaillé"';
                        Image = "Report";
                        RunObject = Report "Rolled-up Cost Shares";
                    }
                    action("Single-Level Cost Shares")
                    {
                        ApplicationArea = All;
                        Caption = 'Single-Level Cost Shares', Comment = 'FRA="Coût mono-niveau détaillé"';
                        Image = "Report";
                        RunObject = Report "Single-level Cost Shares";
                    }
                }
            }
            group(Inventory)
            {
                Caption = 'Inventory', Comment = 'FRA="Stocks"';
                action("Inventory - List")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory - List', Comment = 'FRA="Stocks : Liste des articles"';
                    Image = "Report";
                    RunObject = Report "Inventory - List";
                }
                action("Inventory - Availability Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory - Availability Plan', Comment = 'FRA="Stocks : Échéancier des dispo."';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory - Availability Plan";
                }
                action("Item/Vendor Catalog")
                {
                    ApplicationArea = All;
                    Caption = 'Item/Vendor Catalog', Comment = 'FRA="Articles : Catalogue fourn."';
                    Image = "Report";
                    RunObject = Report "Item/Vendor Catalog";
                }
                action("Phys. Inventory List")
                {
                    ApplicationArea = All;
                    Caption = 'Phys. Inventory List', Comment = 'FRA="Liste d''inventaire"';
                    Image = "Report";
                    RunObject = Report "Phys. Inventory List";
                }
                action("Nonstock Item Sales")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstock Item Sales', Comment = 'FRA="Ventes d''articles non stockés"';
                    Image = "Report";
                    RunObject = Report "Catalog Item Sales";
                }
                action("Item Substitutions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Substitutions', Comment = 'FRA="Articles de substitution"';
                    Image = "Report";
                    RunObject = Report "Item Substitutions";
                    ToolTip = 'View or edit any substitute items that are set up to be traded instead of the item in case it is not available.', Comment = 'FRA="Affichez ou modifiez les articles de substitution qui sont configurés pour être négociés à la place de l''article, s''il n''est pas disponible."';
                }
                action("Price List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Price List', Comment = 'FRA="Liste des prix"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = Report "Price List";
                    ToolTip = 'View, print, or save a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.', Comment = 'FRA="Affichez, imprimez ou enregistrez une liste de vos articles ainsi que leur prix, par exemple, pour envoyer aux clients. Vous pouvez créer la liste pour des clients, des campagnes ou des devises spécifiques ou encore pour d''autres critères."';
                }
                action("Inventory Cost and Price List")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Cost and Price List', Comment = 'FRA="Prix et coûts article"';
                    Image = "Report";
                    RunObject = Report "Inventory Cost and Price List";
                    ToolTip = 'View, print, or save a list of your items and their price and cost information. The report specifies direct unit cost, last direct cost, unit price, profit percentage, and profit.', Comment = 'FRA="Affichez, imprimez ou enregistrez une liste de vos articles, ainsi que leur prix et des informations sur leur coût. L''état spécifie le coût unitaire direct, le dernier coût direct, le prix unitaire, le pourcentage de marge et la marge."';
                }
                action("Inventory Availability")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Availability', Comment = 'FRA="Disponibilité articles"';
                    Image = "Report";
                    RunObject = Report "Inventory Availability";
                    ToolTip = 'View, print, or save a summary of historical inventory transactions with selected items, for example, to decide when to purchase the items. The report specifies quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there are reorders.', Comment = 'FRA="Affichez, imprimez ou enregistrez un résumé des mouvements de stock historiques avec les articles sélectionnés, par exemple, pour décider quand acheter les articles. L''état spécifie la quantité sur commande vente, la quantité sur commande achat, les commandes à livrer des fournisseurs, le stock minimal et la présence éventuelle de réapprovisionnements."';
                }
                group("Item Register")
                {
                    Caption = 'Item Register', Comment = 'FRA="Historique des transactions article"';
                    Image = ItemRegisters;
                    action("Item Register - Quantity")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Register - Quantity', Comment = 'FRA="Hist trans article - Qté"';
                        Image = "Report";
                        RunObject = Report "Item Register - Quantity";
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Register - Value', Comment = 'FRA="Transactions article : Valeur"';
                        Image = "Report";
                        RunObject = Report "Item Register - Value";
                    }
                }
                group(Costing_Inventory)
                {
                    Caption = 'Costing', Comment = 'FRA="Evaluation stock"';
                    Image = ItemCosts;
                    action("Inventory - Cost Variance")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - Cost Variance', Comment = 'FRA="Stocks : Évolution des coûts"';
                        Image = ItemCosts;
                        RunObject = Report "Inventory - Cost Variance";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = All;
                        Caption = 'Invt. Valuation - Cost Spec.', Comment = 'FRA="Éval. stock : Composante coût"';
                        Image = "Report";
                        RunObject = Report "Invt. Valuation - Cost Spec.";
                    }
                    action("Compare List")
                    {
                        ApplicationArea = All;
                        Caption = 'Compare List', Comment = 'FRA="Liste de comparaison"';
                        Image = "Report";
                        RunObject = Report "Compare List";
                    }
                }
                group("Inventory Details")
                {
                    Caption = 'Inventory Details', Comment = 'FRA="Détails stock"';
                    Image = "Report";
                    action("Inventory - Transaction Detail")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - Transaction Detail', Comment = 'FRA="Stocks : Liste des mouvements"';
                        Image = "Report";
                        RunObject = Report "Inventory - Transaction Detail";
                    }
                    action("Item Charges - Specification")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Charges - Specification', Comment = 'FRA="Frais annexes : Composante"';
                        Image = "Report";
                        RunObject = Report "Item Charges - Specification";
                    }
                    action("Item Age Composition - Qty.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Qty.', Comment = 'FRA="Ancienneté stock : Qté"';
                        Image = "Report";
                        RunObject = Report "Item Age Composition - Qty.";
                        ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.', Comment = 'FRA="Affichez, imprimez ou enregistrez un aperçu de l''ancienneté des articles sélectionnés dans votre stock."';
                    }
                    action("Item Expiration - Quantity")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Expiration - Quantity', Comment = 'FRA="Péremption article - Quantité"';
                        Image = "Report";
                        RunObject = Report "Item Expiration - Quantity";
                    }
                }
                group(Reports)
                {
                    Caption = 'Inventory Statistics', Comment = 'FRA="Statistiques stock"';
                    Image = "Report";
                    action("Inventory - Sales Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory - Sales Statistics', Comment = 'FRA="Stocks : Statistiques vente"';
                        Image = "Report";
                        RunObject = Report "Inventory - Sales Statistics";
                        ToolTip = 'View, print, or save a summary of selected items'' sales per customer, for example, to analyze the profit on individual items or trends in revenues and profit. The report specifies direct unit cost, unit price, sales quantity, sales in LCY, profit percentage, and profit.', Comment = 'FRA="Affichez, imprimez ou enregistrez un résumé des ventes d''articles sélectionnés par client, par exemple, pour analyser la marge sur des articles spécifiques ou les tendances en termes de revenus et de marge. L''état spécifie le coût unitaire direct, le prix unitaire, la quantité vendue, les ventes en devise société, le pourcentage de marge et la marge."';
                    }
                    action("Inventory - Customer Sales")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory - Customer Sales', Comment = 'FRA="Stocks : Ventes par client"';
                        Image = "Report";
                        RunObject = Report "Inventory - Customer Sales";
                        ToolTip = 'View, print, or save a list of customers that have purchased selected items within a selected period, for example, to analyze customers'' purchasing patterns. The report specifies quantity, amount, discount, profit percentage, and profit.', Comment = 'FRA="Affichez, imprimez ou enregistrez une liste des clients qui ont acheté des articles sélectionnés pendant une période sélectionnée, par exemple, pour analyser les habitudes d''achat des clients. L''état spécifie la quantité, le montant, la remise, le pourcentage de marge et la marge."';
                    }
                    action("Inventory - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Top 10 List', Comment = 'FRA="Stocks : Palmarès articles"';
                        Image = "Report";
                        RunObject = Report "Inventory - Top 10 List";
                        ToolTip = 'View, print, or save a list of the top items by sales, quantity on hand, or inventory value. The report includes a bar graph to show you how the items rank.', Comment = 'FRA="Affichez, imprimez ou enregistrez une liste des principaux articles par valeur de vente, de quantité disponible ou du stock. Le rapport inclut un graphique à barres pour vous illustrer la manière dont les articles sont classés."';
                    }
                }
                group("Finance Reports")
                {
                    Caption = 'Finance Reports', Comment = 'FRA="États financiers"';
                    Image = "Report";
                    action("Inventory Valuation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Valuation', Comment = 'FRA="Évaluation du stock"';
                        Image = "Report";
                        RunObject = Report "Inventory Valuation";
                        ToolTip = 'View, print, or save a list of the values of the on-hand quantity of each inventory item.', Comment = 'FRA="Affichez, imprimez ou enregistrez une liste des valeurs de la quantité disponible de chaque article en stock."';
                    }
                    action(Status)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Status', Comment = 'FRA="Statut"';
                        Image = "Report";
                        RunObject = Report Status;
                        ToolTip = 'View, print, or save the status of partially filled or unfilled orders so you can determine what effect filling these orders may have on your inventory.', Comment = 'FRA="Affichez, imprimez ou enregistrez le statut des commandes partiellement satisfaites ou insatisfaites afin que vous puissiez déterminer quel effet la satisfaction de ces commandes peut avoir sur votre stock."';
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Age Composition - Value', Comment = 'FRA="Ancienneté stock : Valeur"';
                        Image = "Report";
                        RunObject = Report "Item Age Composition - Value";
                        ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.', Comment = 'FRA="Affichez, imprimez ou enregistrez un aperçu de l''ancienneté des articles sélectionnés dans votre stock."';
                    }
                }
            }
            group(Orders_group)
            {
                Caption = 'Orders', Comment = 'FRA="Commandes"';
                action("Inventory Order Details")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Order Details', Comment = 'FRA="Commandes vente en cours"';
                    Image = "Report";
                    RunObject = Report "Inventory Order Details";
                }
                action("Inventory Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Purchase Orders', Comment = 'FRA="Commandes achat en cours"';
                    Image = "Report";
                    RunObject = Report "Inventory Purchase Orders";
                }
                action("Inventory - Vendor Purchases")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory - Vendor Purchases', Comment = 'FRA="Stocks : Achats par fourn."';
                    Image = "Report";
                    RunObject = Report "Inventory - Vendor Purchases";
                }
                action("Inventory - Reorders")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory - Reorders', Comment = 'FRA="Stocks : Réappro. à effectuer"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Inventory - Reorders";
                }
                action("Inventory - Sales Back Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory - Sales Back Orders', Comment = 'FRA="Stocks : Commandes à livrer"';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Inventory - Sales Back Orders";
                }
            }
        }
        area(navigation)
        {
            group(ItemGroup)
            {
                Caption = 'Item', Comment = 'FRA="Article"';
                action(ApprovalEntries)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals', Comment = 'FRA="Approbations"';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', Comment = 'FRA="Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due."';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID);
                    end;
                }
            }
            group(Availability)
            {
                Caption = 'Availability', Comment = 'FRA="Disponibilité"';
                Image = Item;
                action("Items b&y Location")
                {
                    AccessByPermission = TableData Location = R;
                    ApplicationArea = All;
                    Caption = 'Items b&y Location', Comment = 'FRA="Articles &par magasin"';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.', Comment = 'FRA="Affichez la liste des articles regroupés par emplacement."';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Items by Location", Rec);
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by', Comment = 'FRA="Disponibi&lité article par"';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        ApplicationArea = All;
                        Caption = 'Event', Comment = 'FRA="Événement"';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent());
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period', Comment = 'FRA="Période"';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("Variant")
                    {
                        ApplicationArea = All;
                        Caption = 'Variant', Comment = 'FRA="Variante"';
                        Image = ItemVariant;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location', Comment = 'FRA="Magasin"';
                        Image = Warehouse;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level', Comment = 'FRA="Niveau nomenclature"';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByBOM());
                        end;
                    }
                    action(Timeline)
                    {
                        ApplicationArea = All;
                        Caption = 'Timeline', Comment = 'FRA="Chronologie"';
                        Image = Timeline;

                        trigger OnAction()
                        begin
                            Rec.ShowTimelineFromItem(Rec);
                        end;
                    }
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM', Comment = 'FRA="Dynamics CRM"';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToProduct)
                {
                    ApplicationArea = All;
                    Caption = 'Product', Comment = 'FRA="Produit"';
                    Image = CoupledItem;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM product.', Comment = 'FRA="Ouvrez le produit Microsoft Dynamics CRM couplé."';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    ApplicationArea = All;
                    Caption = 'Synchronize Now', Comment = 'FRA="Synchroniser maintenant"';
                    Image = Refresh;
                    ToolTip = 'Send updated data to Microsoft Dynamics CRM.', Comment = 'FRA="Envoyez des données mises à jour à Microsoft Dynamics CRM."';

                    trigger OnAction()
                    var
                        Item: Record Item;
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        ItemRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Item);
                        Item.NEXT();

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
                    Caption = 'Coupling', Comment = 'FRA="Couplage"';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', Comment = 'FRA="Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM."';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = All;
                        Caption = 'Set Up Coupling', Comment = 'FRA="Configurer le couplage"';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM product.', Comment = 'FRA="Créez ou modifiez le couplage avec un produit Microsoft Dynamics CRM."';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RECORDID);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = All;
                        Caption = 'Delete Coupling', Comment = 'FRA="Supprimer le couplage"';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM product.', Comment = 'FRA="Supprimez le couplage avec un produit Microsoft Dynamics CRM."';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RECORDID);
                        end;
                    }
                }
            }
            group("Assembly/Production_navigation")
            {
                Caption = 'Assembly/Production', Comment = 'FRA="Assemblage/Production"';
                Image = Production;
                action(Structure)
                {
                    ApplicationArea = All;
                    Caption = 'Structure', Comment = 'FRA="Structure"';
                    Image = Hierarchy;

                    trigger OnAction()
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN();
                    end;
                }
                action("Cost Shares")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Shares', Comment = 'FRA="Coûts totaux"';
                    Image = CostBudget;

                    trigger OnAction()
                    var
                        BOMCostShares: Page "BOM Cost Shares";
                    begin
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.RUN();
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Assemb&ly', Comment = 'FRA="Assemb&lage"';
                    Image = AssemblyBOM;
                    action("<Action32>")
                    {
                        ApplicationArea = All;
                        Caption = 'Assembly BOM', Comment = 'FRA="Nomenclature d''élément d''assemblage"';
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                    }
                    action("Where-Used1")
                    {
                        ApplicationArea = All;
                        Caption = 'Where-Used', Comment = 'FRA="Cas d''emploi"';
                        Image = Track;
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                    }
                    action("Calc. Stan&dard Cost1")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = All;
                        Caption = 'Calc. Stan&dard Cost', Comment = 'FRA="Calculer coût stan&dard"';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(Rec."No.", TRUE);
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = All;
                        Caption = 'Calc. Unit Price', Comment = 'FRA="Calculer prix unitaire"';
                        Image = SuggestItemPrice;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcAssemblyItemPrice(Rec."No.");
                        end;
                    }
                }
                group(Production)
                {
                    Caption = 'Production', Comment = 'FRA="Fabrication"';
                    Image = Production;
                    action("Production BOM")
                    {
                        ApplicationArea = All;
                        Caption = 'Production BOM', Comment = 'FRA="Nomenclature de production"';
                        Image = BOM;
                        RunObject = Page "Production BOM";
                        RunPageLink = "No." = FIELD("Production BOM No.");
                    }
                    action("Where-Used2")
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = All;
                        Caption = 'Where-Used', Comment = 'FRA="Cas d''emploi"';
                        Image = "Where-Used";

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE());
                            ProdBOMWhereUsed.RUNMODAL();
                        end;
                    }
                    action("Calc. Stan&dard Cost2")
                    {
                        AccessByPermission = TableData "Production BOM Header" = R;
                        ApplicationArea = All;
                        Caption = 'Calc. Stan&dard Cost', Comment = 'FRA="Calculer coût stan&dard"';
                        Image = CalculateCost;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(Rec."No.", FALSE);
                        end;
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Reservation Entries', Comment = 'FRA="Écritures &réservation"';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation),
                                      "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Value Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Value Entries', Comment = 'FRA="Écritures &valeur"';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("Item &Tracking Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Item &Tracking Entries', Comment = 'FRA="&Ecritures traçabilité"';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForEntity(3, '', Rec."No.", '', '');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Warehouse Entries', Comment = 'FRA="É&critures entrepôt"';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                    }
                }
                group(Statistics_group)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    action(Statistics_action)
                    {
                        ApplicationArea = All;
                        Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                        Image = Statistics;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL();
                        end;
                    }
                    action("Entry Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Entry Statistics', Comment = 'FRA="Statistiques écritures"';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("T&urnover")
                    {
                        ApplicationArea = All;
                        Caption = 'T&urnover', Comment = 'FRA="&Rotation"';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales', Comment = 'FRA="&Ventes"';
                Image = Sales;
                action(Sales_Prices)
                {
                    ApplicationArea = All;
                    Caption = 'Prices', Comment = 'FRA="Prix"';
                    Image = Price;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Sales_LineDiscounts)
                {
                    ApplicationArea = All;
                    Caption = 'Line Discounts', Comment = 'FRA="Remises ligne"';
                    Image = LineDiscount;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item),
                                  Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                }
                action("Marge Vente")
                {
                    ApplicationArea = All;
                    Caption = 'Marge Vente', Comment = 'FRA="Marge Vente"';
                    Image = Sales;
                    RunObject = Page "BC6_Item Sales Profit Group";
                    RunPageLink = Code = FIELD("BC6_Item Sales Profit Group");
                    RunPageView = SORTING(Code);
                }
                action("Prepa&yment Percentages1")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Percentages', Comment = 'FRA="Pourcentages acom&pte"';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action(Orders1)
                {
                    ApplicationArea = All;
                    Caption = 'Orders', Comment = 'FRA="Commandes"';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Returns Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Returns Orders', Comment = 'FRA="Retours"';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases', Comment = 'FRA="Ac&hats"';
                Image = Purchasing;
                action("Ven&dors")
                {
                    ApplicationArea = All;
                    Caption = 'Ven&dors', Comment = 'FRA="&Fournisseurs"';
                    Image = Vendor;
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Prices)
                {
                    ApplicationArea = All;
                    Caption = 'Prices', Comment = 'FRA="Prix"';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Line Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Line Discounts', Comment = 'FRA="Remises ligne"';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = BC6_Type = CONST(Item),
                                  "Item No." = FIELD("No.");
                    RunPageView = SORTING(BC6_Type, "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
                }
                action("Prepa&yment Percentages2")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Percentages', Comment = 'FRA="Pourcentages acom&pte"';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action(Orders2)
                {
                    ApplicationArea = Suite;
                    Caption = 'Orders', Comment = 'FRA="Commandes"';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Return Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Return Orders', Comment = 'FRA="Retours"';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nonstoc&k Items', Comment = 'FRA="Articles &non stockés"';
                    Image = NonStockItem;
                    RunObject = Page "Catalog Item List";
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("&Bin Contents1")
                {
                    ApplicationArea = All;
                    Caption = '&Bin Contents', Comment = 'FRA="C&ontenu emplacement"';
                    Image = BinContent;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Stockkeepin&g Units")
                {
                    ApplicationArea = All;
                    Caption = 'Stockkeepin&g Units', Comment = 'FRA="Point de stoc&k"';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
            }
            group(Service)
            {
                Caption = 'Service', Comment = 'FRA="Service"';
                Image = ServiceItem;
                action("Ser&vice Items")
                {
                    ApplicationArea = All;
                    Caption = 'Ser&vice Items', Comment = 'FRA="&Articles de service"';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Troubleshooting)
                {
                    AccessByPermission = TableData "Service Header" = R;
                    ApplicationArea = All;
                    Caption = 'Troubleshooting', Comment = 'FRA="Incident"';
                    Image = Troubleshoot;

                    trigger OnAction()
                    var
                        TroubleshootingHeader: Record "Troubleshooting Header";
                    begin
                        TroubleshootingHeader.ShowForItem(Rec);
                    end;
                }
                action("Troubleshooting Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Troubleshooting Setup', Comment = 'FRA="Paramètres incidents"';
                    Image = Troubleshoot;
                    RunObject = Page "Troubleshooting Setup";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                }
            }
            group(Resources)
            {
                Caption = 'Resources', Comment = 'FRA="Ressources"';
                Image = Resource;
                group("R&esource")
                {
                    Caption = 'R&esource', Comment = 'FRA="Re&ssource"';
                    Image = Resource;
                    action("Resource &Skills")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Resource &Skills', Comment = 'FRA="&Compétences ressources"';
                        Image = ResourceSkills;
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        ToolTip = 'View the assignment of skills to resources, items, service item groups, and service items. You can use skill codes to allocate skilled resources to service items or items that need special skills for servicing.', Comment = 'FRA="Affichez l''affectation des compétences aux ressources, aux articles, aux groupes articles de service et aux articles de service. Vous pouvez utiliser les codes compétence pour affecter des ressources compétentes aux articles de service ou aux articles nécessitant des compétences spéciales pour la maintenance."';
                    }
                    action("Skilled R&esources")
                    {
                        AccessByPermission = TableData "Service Header" = R;
                        ApplicationArea = Jobs;
                        Caption = 'Skilled R&esources', Comment = 'FRA="&Ressources compétentes"';
                        Image = ResourceSkills;
                        ToolTip = 'View a list of all registered resources with information about whether they have the skills required to service the particular service item group, item, or service item.', Comment = 'FRA="Affichez la liste de toutes les ressources enregistrées. Cette fenêtre indique si ces dernières possèdent les compétences nécessaires pour effectuer des opérations de service sur le groupe articles de service, l''article ou l''article de service particulier."';

                        trigger OnAction()
                        var
                            ResourceSkill: Record "Resource Skill";
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item, Rec."No.", Rec.Description);
                            SkilledResourceList.RUNMODAL();
                        end;
                    }
                }
                action(UpdateICPartnerItems)
                {
                    ApplicationArea = All;
                    Caption = 'Update IC Partner Items', Comment = 'FRA="Màj articles partenaires"';
                    Enabled = UpdateICPartnerItemsEnabled;
                    Image = UpdateDescription;
                    RunObject = Codeunit "BC6_Update IC Partner Items";
                }
            }
            action("Créer code-barres interne")
            {
                ApplicationArea = All;
                Caption = 'Create Internal BarCodes', Comment = 'FRA="Créer code-barres interne"';
                Image = BarCode;

                trigger OnAction()
                begin
                    CLEAR(DistInt);
                    FunctionMgt.CreateItemEAN13Code(Rec."No.", TRUE);
                end;
            }
            action(PrintLabel)
            {
                ApplicationArea = All;
                Caption = 'Print Label', Comment = 'FRA="Imprimer étiquette"';
                Ellipsis = true;
                Image = BarCode;

                trigger OnAction()
                var
                    FromItem: Record Item;
                    PrintLabel: Report "BC6_Item Label v2";
                begin
                    CLEAR(PrintLabel);
                    CLEAR(FromItem);
                    CurrPage.SETSELECTIONFILTER(FromItem);
                    PrintLabel.SETTABLEVIEW(FromItem);
                    PrintLabel.RUN();
                end;
            }
            action(UpdateUnitPriceIncVAT)
            {
                ApplicationArea = All;
                Caption = 'Update Item Prices Inc VAT', Comment = 'FRA="Mise à jour prix public TTC"';
                Ellipsis = true;
                Image = Price;

                trigger OnAction()
                var
                    ItemToUpdate: Record Item;
                    UpdateUnitPriceIncVAT: Report "BC6_Update Items Prices";
                begin
                    CLEAR(ItemToUpdate);
                    CLEAR(UpdateUnitPriceIncVAT);
                    CurrPage.SETSELECTIONFILTER(ItemToUpdate);
                    UpdateUnitPriceIncVAT.SETTABLEVIEW(ItemToUpdate);
                    UpdateUnitPriceIncVAT.RUN();
                end;
            }
            group("&Bin Contents_group")
            {
                Caption = '&Bin Contents', Comment = 'FRA="C&ontenu emplacement"';
                action("&Bin Contents2")
                {
                    ApplicationArea = All;
                    Caption = '&Bin Contents', Comment = 'FRA="C&ontenu emplacement"';
                    Image = BinContent;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin

        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID) AND CRMIntegrationEnabled;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");

        SetWorkflowManagementEnabledState();
    end;

    trigger OnAfterGetRecord()
    var
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
    begin
        EnableControls();
        EAN13Code := FunctionsMgt.GetItemEAN13Code(Rec."No.");
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
        EXIT(Rec.FIND(Which));
    end;

    trigger OnInit()
    begin
        IF STRPOS(COMPANYNAME, 'CNE') = 0 THEN
            UpdateICPartnerItemsEnabled := FALSE
        ELSE
            UpdateICPartnerItemsEnabled := TRUE;
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
        EXIT(Rec.NEXT(Steps));
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled();
        SetWorkflowManagementEnabledState();
        Rec.SETRANGE("Reordering Policy", Rec."Reordering Policy"::"Fixed Reorder Qty.");
    end;

    var
        MemberOf: Record "Access Control";
        RecGAccessControl: Record "Access Control";
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        TempFilteredItem: Record Item temporary;
        ItemCrossRef: Record "Item Reference";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        DistInt: Codeunit "Dist. Integration";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        FormItemCrossRef: Page "Item References";
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
        OpenApprovalEntriesExist: Boolean;
        RunOnTempRec: Boolean;
        [InDataSet]

        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        UpdateICPartnerItemsEnabled: Boolean;
        EAN13Code: Code[20];
        "-CNEIC-": Integer;
        "-MIGNAV2013-": Integer;
        "--NSC1.01--": Integer;
        EventFilter: Text;

    procedure GetSelectionFilter(): Text
    var
        ItemVar: Record Item;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(ItemVar);
        EXIT(SelectionFilterManagement.GetSelectionFilterForItem(ItemVar));
    end;

    procedure SetSelection(var ItemP: Record Item)
    begin
        CurrPage.SETSELECTIONFILTER(ItemP);
    end;

    local procedure EnableControls()
    begin
        IsService := (Rec.Type = Rec.Type::Service);
        InventoryItemEditable := Rec.Type = Rec.Type::Inventory;
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
}
