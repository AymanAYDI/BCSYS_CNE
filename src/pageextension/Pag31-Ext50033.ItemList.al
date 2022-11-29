pageextension 50033 "BC6_ItemList" extends "Item List" //31
{
    layout
    {

        addafter("No.")
        {
            field(BC6_CodeEAN13Ctrl; EAN13Code)
            {
                Caption = 'EAN13 Code';
                //TODO
                // trigger OnLookup(var Text: Text): Boolean
                // begin
                //     DistInt.LookupItemEAN13Code("No.", EAN13Code);
                // end;
            }
            field(BC6_Blocked2; Blocked)
            {
                Caption = 'Blocked';
            }
            field("BC6_No. 2"; "No. 2")
            {
                Caption = 'No. 2';
            }
            field("BC6_Search Description 2"; "BC6_Search Description 2")
            {
                Editable = false;
                Caption = 'Search Description 2', Comment = 'FRA="Désignation de recherche 2"';
            }
        }
        addafter(Description)
        {
            field(BC6_Inventory; Inventory)
            {
                Caption = 'Inventory';
            }
        }
        addafter("Unit Price")
        {
            field("BC6_Unit Price Includes VAT"; "BC6_Unit Price Includes VAT")
            {
                Caption = 'Unit Price Includes VAT', Comment = 'FRA="Prix Public TTC"';
            }
        }
        modify("Vendor No.")
        {
            Visible = False;
        }
        addafter("Vendor Item No.")
        {
            field("BC6_Reorder Quantity"; "Reorder Quantity")
            {
                Caption = 'Reorder Quantity';
            }
            field("BC6_Safety Stock Quantity"; "Safety Stock Quantity")
            {
                Caption = 'Safety Stock Quantity';
            }
            field("BC6_Order Multiple"; "Order Multiple")
            {
                Caption = 'Order Multiple';
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
                Caption = 'Update Cost Incr. Coeff.';
                Image = CalculateCost;
                //TODO:Report // RunObject = Report 50099;
            }
        }
        addbefore("Prepa&yment Percentages")
        {
            action("BC6_Marge Vente")
            {
                Caption = 'Marge Vente';
                Image = GainLossEntries;
                RunObject = page 50021;
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
                Caption = 'Line Discounts';
                Image = LineDiscount;
                RunObject = page 7014;
                RunPageLink = BC6_Type = const(Item),
                                  "Item No." = field("No.");
                RunPageView = sorting(BC6_Type, "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
            }
        }
        addlast(Resources)
        {
            action(BC6_UpdateICPartnerItems)
            {
                Caption = 'Update IC Partner Items';
                Enabled = UpdateICPartnerItemsEnabled;
                Image = UpdateDescription;
                // TODO: //RunObject = Codeunit 50021;
            }
        }
        addlast(navigation)
        {
            action("Créer code-barres interne")
            {
                Caption = 'Create Internal BarCodes';
                Description = 'MIGNAV2013';
                Image = BarCode;

                trigger OnAction()
                begin
                    CLEAR(DistInt);
                    //TODO // DistInt.CreateItemEAN13Code("No.", TRUE);
                end;
            }
            action(BC6_PrintLabel)
            {
                Caption = 'Print Label';
                Description = 'MIGNAV2013';
                Ellipsis = true;
                Image = BarCode;

                trigger OnAction()
                var
                    FromItem: Record 27;
                // PrintLabel: Report 50049;
                // PrintLabel2: Report 50059;
                begin
                    //TODO : les 3 lignes 
                    // CLEAR(PrintLabel);
                    CLEAR(FromItem);
                    CurrPage.SETSELECTIONFILTER(FromItem);
                    // PrintLabel2.SETTABLEVIEW(FromItem);
                    // PrintLabel2.RUN;
                end;
            }
            action(BC6_UpdateUnitPriceIncVAT)
            {
                Caption = 'Update Item Prices Inc VAT';
                Description = 'MIGNAV2013';
                Ellipsis = true;
                Image = Price;

                trigger OnAction()
                var
                    ItemToUpdate: Record 27;
                //TODO   // UpdateUnitPriceIncVAT: Report 50053;
                begin
                    CLEAR(ItemToUpdate);
                    // CLEAR(UpdateUnitPriceIncVAT);
                    // CurrPage.SETSELECTIONFILTER(ItemToUpdate);
                    // UpdateUnitPriceIncVAT.SETTABLEVIEW(ItemToUpdate);
                    // UpdateUnitPriceIncVAT.RUN;
                end;
            }
            group("BC6_&Bin Contents")
            {
                Caption = '&Bin Contents';
                action("BC6_&Bin Content")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page 7379;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
            }
        }

    }



    trigger OnOpenPage() //TODO : AU LIEU DE OnInit ( à vérifier)

    begin
        if STRPOS(COMPANYNAME, 'CNE') = 0 then
            UpdateICPartnerItemsEnabled := false
        else
            UpdateICPartnerItemsEnabled := true;
    end;

    trigger OnAfterGetRecord()
    var
        DistInt: Codeunit 5702;
        "-MIGNAV2013-": Integer;
    begin
        //TODO // EAN13Code := DistInt.GetItemEAN13Code("No.");
    end;

    var
        UpdateICPartnerItemsEnabled: Boolean;
        EAN13Code: Code[20];
        DistInt: Codeunit 5702;
        MemberOf: Record 2000000053;
        ItemCrossRef: Record 5717;
        RecGAccessControl: Record 2000000053;



}
