pageextension 50074 "BC6_ItemDiscGroups" extends "Item Disc. Groups" //513
{

    procedure GetSelectionFilter2(var ToItemDiscGroup: Record "Item Discount Group")
    var
        ItemDiscGr: Record "Item Discount Group";
    begin
        //>>MIGRATION 2013
        //ToItemDiscGroup.COPY(ItemDiscGroup);
        CurrPage.SETSELECTIONFILTER(ToItemDiscGroup);
        //<<MIGRATION 2013
    end;
}

