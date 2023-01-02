pageextension 50032 "BC6_ItemVendorCatalog" extends "Item Vendor Catalog" //114
{
    actions
    {
        modify("Purch. Line &Discounts")
        {
            Visible = false;
        }
        addafter("Purch. Line &Discounts")
        {
            action("BC6_Purch. Line &Discounts2")
            {
                ApplicationArea = Planning;
                Caption = 'Purch. Line &Discounts', Comment = 'FRA="&Remises ligne achat"';
                Image = LineDiscount;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = not ExtendedPriceEnabled2;
                RunObject = Page "Purchase Line Discounts";
                RunPageLink = "Item No." = FIELD("Item No."),
                                  "Vendor No." = FIELD("Vendor No.");
                RunPageView = SORTING("Item No.", "Vendor No.", BC6_type);
                ToolTip = 'Define purchase line discounts with vendors. For example, you may get for a line discount if you buy items from a vendor in large quantities.', Comment = 'FRA="Définissez des remises ligne achat avec des fournisseurs. Par exemple, vous pouvez obtenir une remise ligne si vous achetez des articles en grandes quantités auprès d''un fournisseur."';
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                ObsoleteTag = '18.0';
            }
        }
    }

    trigger OnOpenPage()
    var
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
    begin
        ExtendedPriceEnabled2 := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();
    end;

    var
        ExtendedPriceEnabled2: Boolean;
}

