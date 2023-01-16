pageextension 50011 "BC6_ItemList" extends "Item List" //31
{
    layout
    {
        addafter("No.")
        {
            field(BC6_CodeEAN13Ctrl; EAN13Code)
            {
                ApplicationArea = All;
                Caption = 'EAN13 Code', comment = 'FRA="EAN13 Code"';
                trigger OnLookup(var Text: Text): Boolean
                var
                    functionMgt: Codeunit "BC6_Functions Mgt";
                begin
                    functionMgt.LookupItemEAN13Code(Rec."No.", EAN13Code);
                end;
            }
            field(BC6_Blocked2; Rec.Blocked)
            {
                ApplicationArea = All;
            }
            field("BC6_No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Search Description 2"; Rec."BC6_Search Description 2")
            {
                ApplicationArea = All;
                Caption = 'Search Description 2', Comment = 'FRA="Désignation de recherche 2"';
                Editable = false;
            }
        }
        addafter(Description)
        {
            field(BC6_Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field("BC6_Unit Price Includes VAT"; Rec."BC6_Unit Price Includes VAT")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Includes VAT', Comment = 'FRA="Prix Public TTC"';
            }
        }
        modify("Vendor No.")
        {
            Visible = False;
        }
        addafter("Vendor Item No.")
        {
            field("BC6_Reorder Quantity"; Rec."Reorder Quantity")
            {
                ApplicationArea = All;
            }
            field("BC6_Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;
            }
            field("BC6_Order Multiple"; Rec."Order Multiple")
            {
                ApplicationArea = All;
            }
        }
        modify("Search Description")
        {
            Visible = False;
        }
    }

    actions
    {
        addafter("C&alculate Counting Period")
        {
            action(BC6_UpdateCostIncreaseCoeff)
            {
                ApplicationArea = All;
                Caption = 'Update Cost Incr. Coeff.', Comment = 'FRA="Modifier coeff majoration du coût"';
                Image = CalculateCost;
                RunObject = Report "BC6_Upd Item Cost Incr. Coeff.";
            }
        }
        addbefore("Prepa&yment Percentages")
        {
            action("BC6_Marge Vente")
            {
                ApplicationArea = All;
                Caption = 'Marge Vente';
                Image = GainLossEntries;
                RunObject = page "BC6_Item Sales Profit Group";
                RunPageLink = Code = field("BC6_Item Sales Profit Group");
                RunPageView = sorting(Code);
            }
        }
        modify("Line Discounts")
        { Visible = false; }
        addbefore(Action125)
        {
            action("BC6_Line Discounts")
            {
                ApplicationArea = All;
                Caption = 'Line Discounts', Comment = 'FRA="Remises ligne"';
                Image = LineDiscount;
                RunObject = page "Purchase Line Discounts";
                RunPageLink = BC6_Type = const(Item),
                                  "Item No." = field("No.");
                RunPageView = sorting(BC6_Type, "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
            }
        }
        addafter("Skilled R&esources")
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
        addlast(navigation)
        {
            action("Créer code-barres interne")
            {
                ApplicationArea = All;
                Caption = 'Create Internal BarCodes', Comment = 'FRA="Créer code-barres interne"';
                Image = BarCode;

                trigger OnAction()
                var
                    functionMgt: Codeunit "BC6_Functions Mgt";
                begin
                    CLEAR(DistInt);
                    functionMgt.CreateItemEAN13Code(Rec."No.", TRUE);
                end;
            }
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
                    PrintLabel2: Report "BC6_Item Label v3";
                begin
                    CLEAR(PrintLabel);
                    CLEAR(FromItem);
                    CurrPage.SETSELECTIONFILTER(FromItem);
                    PrintLabel2.SETTABLEVIEW(FromItem);
                    PrintLabel2.RUN();
                end;
            }
            action(BC6_UpdateUnitPriceIncVAT)
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
            group("BC6_&Bin Contents")
            {
                Caption = '&Bin Contents', Comment = 'FRA="C&ontenu emplacement"';
                action("BC6_&Bin Content")
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

    trigger OnOpenPage()

    begin
        if STRPOS(COMPANYNAME, 'CNE') = 0 then
            UpdateICPartnerItemsEnabled := false
        else
            UpdateICPartnerItemsEnabled := true;
    end;

    trigger OnAfterGetRecord()
    var
        functionMgt: Codeunit "BC6_Functions Mgt";
    begin
        EAN13Code := functionMgt.GetItemEAN13Code(Rec."No.");
    end;

    var
        DistInt: Codeunit "Dist. Integration";
        UpdateICPartnerItemsEnabled: Boolean;
        EAN13Code: Code[20];
}
