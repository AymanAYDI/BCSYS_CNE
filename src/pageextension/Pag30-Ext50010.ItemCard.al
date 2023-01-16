pageextension 50010 "BC6_ItemCard" extends "Item Card" //30
{
    layout
    {
        modify("Blocked")
        {
            visible = false;
        }
        addafter(Description)
        {
            field("BC6_No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'No. 2', Comment = 'FRA="N° 2"';
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field(BC6_EAN13Code; EAN13Code)
            {
                ApplicationArea = All;
                Caption = 'EAN13 Code';
                trigger OnLookup(var Text: Text): Boolean
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";
                begin
                    FunctionMgt.LookupItemEAN13Code(Rec."No.", EAN13Code);
                end;
            }
        }
        modify(Inventory)
        {
            Visible = false;
        }
        modify(InventoryNonFoundation)
        {
            visible = false;
        }
        addafter("Search Description")
        {
            field("BC6_Search Description 2"; Rec."BC6_Search Description 2")
            {
                ApplicationArea = All;
                Caption = 'Search Description 2', Comment = 'FRA="Désignation de recherche 2"';
            }
            field(BC6_Inventory2; Rec.Inventory)
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. on Prod. Order")
        {
            field("BC6_Qty. Return Order SAV"; Rec."BC6_Qty. Return Order SAV")
            {
                ApplicationArea = All;
                Caption = ' Qty. Return Order SAV', Comment = 'FRA="Qté sur retour vente SAV"';
                DecimalPlaces = 0 : 0;
            }
        }
        addafter("Qty. on Asm. Component")
        {
            field("BC6_Pick Qty."; Rec."BC6_Pick Qty.")
            {
                ApplicationArea = All;
                Caption = 'Pick Qty.', Comment = 'FRA="Prélever qté"';
            }
        }
        addafter("Unit Price")
        {
            field("BC6_Unit Price Includes VAT"; Rec."BC6_Unit Price Includes VAT")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Includes VAT', Comment = 'FRA="Prix Public TTC"';
            }
            field("BC6_Print Unit Price Incl. VAT"; Rec."BC6_Print Unit Price Incl. VAT")
            {
                ApplicationArea = All;
                Caption = 'Print Unit Price Includes VAT On Label', Comment = 'FRA="Imprimer Prix Public TTC sur étiquette"';
            }
        }
        addafter("Item Disc. Group")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
                Caption = 'DEEE Category Code ', Comment = 'FRA="DEEE Code catégorie"';
                LookupPageID = "BC6_Item Category List";
            }
            field("BC6_Number of Units DEEE"; Rec."BC6_Number of Units DEEE")
            {
                ApplicationArea = All;
                Caption = 'Number of Units DEEE', Comment = 'FRA="Nombre d''unités DEEE"';
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
                Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
                Importance = Promoted;
            }
        }
        addafter("Last Direct Cost")
        {
            field("BC6_Cost Increase Coeff %"; Rec."BC6_Cost Increase Coeff %")
            {
                ApplicationArea = All;
                Caption = 'Cost Increase Coeff (%)', Comment = 'FRA="Coeff majoration du coût (%)"';
                Visible = ShowIncreaseCoeff;
            }
        }

        modify("Vendor No.")
        {
            ShowMandatory = true;
        }
        addafter(AssemblyBOM)
        {
            field(BC6_Blocked; Rec.Blocked)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Blocked', Comment = 'FRA="Bloqué"';
                Editable = BooGBlocked;
                ToolTip = 'Specifies that transactions with the item cannot be posted, for example, because the item is in quarantine.', Comment = 'FRA="Indique que les transactions avec l''article ne peuvent pas être validées, par exemple, parce que l''article est en quarantaine."';
            }
        }
        addafter(ItemPicture)
        {
            part("Sales/Purch. HistoryFactBox"; "BC6_Sales/Purch. Hist Fact")
            {
                ApplicationArea = All;
                Caption = 'Item Sales/Purchase History', Comment = 'FRA="Historique vente/achat article"';
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        addafter(SaveAsTemplate)
        {
            action(BC6_PrintLabel)
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
            action("Créer code-barres interne")
            {
                ApplicationArea = All;
                Caption = 'Create Internal BarCodes', Comment = 'FRA="Créer code-barres interne"';
                Image = BarCode;

                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";
                begin
                    CLEAR(DistInt);
                    FunctionMgt.CreateItemEAN13Code(Rec."No.", TRUE);
                end;
            }
        }
        addfirst(Navigation_Item)
        {
            action(BC6_BarCodes)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cross Re&ferences', Comment = 'FRA="&Références externes"';
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = Page "Item Reference Entries";
                RunPageLink = "Item No." = FIELD("No."),
                                    "Reference Type" = CONST("Bar Code");
                Scope = Repeater;
                ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', Comment = 'FRA="Configurez la manière dont un client ou un fournisseur identifie l''article sélectionné. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez."';
            }
        }
        addafter("Return Orders")
        {
            action(BC6_UpdateICPartnerItems)
            {
                ApplicationArea = All;
                Caption = 'Update IC Partner Items', Comment = 'FRA="Màj articles partenaires"';
                Enabled = UpdateICPartnerItemsEnabled;
                Image = UpdateDescription;
                RunObject = Codeunit "BC6_Update IC Partner Items";
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
    begin
        EAN13Code := FunctionMgt.GetItemEAN13Code(Rec."No.");
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(USERID) AND UserSetup."BC6_Aut. Real Sales Profit %" THEN begin
            ShowIncreaseCoeff := true;
            CurrPage.Update();
        end ELSE
            ShowIncreaseCoeff := false
    end;

    var
        DistInt: Codeunit "Dist. Integration";
        BooGBlocked: Boolean;
        ShowIncreaseCoeff: Boolean;
        UpdateICPartnerItemsEnabled: Boolean;
        EAN13Code: Code[20];
}
