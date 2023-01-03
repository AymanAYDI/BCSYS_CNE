pageextension 50032 "BC6_ItemVendorCatalog" extends "Item Vendor Catalog" //114
{
    actions
    {
#pragma warning disable AL0432
        modify("Purch. Line &Discounts")
#pragma warning restore AL0432
        {
            Visible = false;
        }
#pragma warning disable AL0432
        addafter("Purch. Line &Discounts")
#pragma warning restore AL0432
        {
            action("BC6_Purch. Line &Discounts2")
            {
                ApplicationArea = Planning;
                Caption = 'Purch. Line &Discounts';
                Image = LineDiscount;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = not ExtendedPriceEnabled2;
                RunObject = Page "Purchase Line Discounts";
                RunPageLink = "Item No." = FIELD("Item No."),
                                  "Vendor No." = FIELD("Vendor No.");
                RunPageView = SORTING("Item No.", "Vendor No.", BC6_type);
                ToolTip = 'Define purchase line discounts with vendors. For example, you may get for a line discount if you buy items from a vendor in large quantities.';
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

