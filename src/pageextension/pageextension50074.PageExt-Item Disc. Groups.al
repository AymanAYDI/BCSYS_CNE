pageextension 50074 pageextension50074 extends "Item Disc. Groups"
{
    var
        "-MIGNAV2013-": Integer;
        ItemDiscGroup: Record "341";

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure GetSelectionFilter2(var ToItemDiscGroup: Record "341")
    var
        ItemDiscGr: Record "341";
    begin
        //>>MIGRATION 2013
        //ToItemDiscGroup.COPY(ItemDiscGroup);
        CurrPage.SETSELECTIONFILTER(ToItemDiscGroup);
        //<<MIGRATION 2013
    end;
}

