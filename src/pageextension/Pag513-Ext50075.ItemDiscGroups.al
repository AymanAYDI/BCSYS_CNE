pageextension 50075 "BC6_ItemDiscGroups" extends "Item Disc. Groups" //513
{
    procedure GetSelectionFilter2(var ToItemDiscGroup: Record "Item Discount Group")
    begin
        CurrPage.SETSELECTIONFILTER(ToItemDiscGroup);
    end;
}
