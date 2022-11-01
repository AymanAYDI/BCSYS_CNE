tableextension 50034 "BC6_ItemDiscountGroup" extends "Item Discount Group"
{
    LookupPageID = "Item Disc. Groups";
    trigger OnDelete()
    begin
        PurchaseLineDiscount.SETRANGE(BC6_Type, PurchaseLineDiscount.BC6_Type::"Item Disc. Group");
        PurchaseLineDiscount.SETRANGE("Item No.", Code);
        PurchaseLineDiscount.DELETEALL(TRUE);

    end;

    var
        PurchaseLineDiscount: Record "Purchase Line Discount";  //TODO marked for removal
        "-NSC1.01-": Integer;
}

