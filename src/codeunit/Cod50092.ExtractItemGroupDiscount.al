codeunit 50092 "Extract Item Group Discount"
{
#pragma warning disable AL0432
    TableNo = "Sales Line Discount";
#pragma warning restore AL0432

    trigger OnRun()
    var
        ItemDiscGroup: Record "Item Discount Group";
#pragma warning disable AL0432
        FromSalesLineDiscount: Record "Sales Line Discount";
        SalesLineDiscount: Record "Sales Line Discount";
        ToSalesLineDiscount: Record "Sales Line Discount";
#pragma warning restore AL0432
        ItemDiscGroupForm: Page "Item Disc. Groups";
    begin

        TESTFIELD("Sales Type", "Sales Type"::Customer);
        TESTFIELD("Sales Code");
        TESTFIELD(Type, Type::"Item Disc. Group");


        FromSalesLineDiscount := Rec;

        ItemDiscGroup.RESET();
        CLEAR(ItemDiscGroupForm);
        ItemDiscGroupForm.SETRECORD(ItemDiscGroup);
        ItemDiscGroupForm.SETTABLEVIEW(ItemDiscGroup);
        ItemDiscGroupForm.EDITABLE(false);
        ItemDiscGroupForm.LOOKUPMODE := true;
        if ItemDiscGroupForm.RUNMODAL() = ACTION::LookupOK then begin
            CLEAR(ItemDiscGroup);
            ItemDiscGroupForm.GetSelectionFilter2(ItemDiscGroup);
        end else
            exit;

        SalesLineDiscount.RESET();
        SalesLineDiscount.SETRANGE("Sales Type", FromSalesLineDiscount."Sales Type");
        SalesLineDiscount.SETRANGE("Sales Code", FromSalesLineDiscount."Sales Code");
        SalesLineDiscount.SETRANGE(Type, FromSalesLineDiscount.Type::"Item Disc. Group");
        if ItemDiscGroup.FIND('-') then
            repeat

                SalesLineDiscount.SETRANGE(Code, ItemDiscGroup.Code);
                if not SalesLineDiscount.ISEMPTY then
                    SalesLineDiscount.DELETEALL(true);

                ToSalesLineDiscount.INIT();
                ToSalesLineDiscount.Type := FromSalesLineDiscount.Type::"Item Disc. Group";
                ToSalesLineDiscount.Code := ItemDiscGroup.Code;
                ToSalesLineDiscount."Sales Type" := FromSalesLineDiscount."Sales Type";
                ToSalesLineDiscount."Sales Code" := FromSalesLineDiscount."Sales Code";
                ToSalesLineDiscount."Starting Date" := FromSalesLineDiscount."Starting Date";
                ToSalesLineDiscount."Currency Code" := FromSalesLineDiscount."Currency Code";
                ToSalesLineDiscount."Variant Code" := FromSalesLineDiscount."Variant Code";
                ToSalesLineDiscount."Unit of Measure Code" := FromSalesLineDiscount."Unit of Measure Code";
                ToSalesLineDiscount."Minimum Quantity" := FromSalesLineDiscount."Minimum Quantity";
#pragma warning disable AL0432
                ToSalesLineDiscount."BC6_Profit %" := FromSalesLineDiscount."BC6_Profit %";
                ToSalesLineDiscount."Line Discount %" := FromSalesLineDiscount."Line Discount %";
                ToSalesLineDiscount."Ending Date" := FromSalesLineDiscount."Ending Date";
                ToSalesLineDiscount."BC6_Dispensation No." := FromSalesLineDiscount."BC6_Dispensation No.";
                ToSalesLineDiscount."BC6_Added Discount %" := FromSalesLineDiscount."BC6_Added Discount %";
#pragma warning restore AL0432
                ToSalesLineDiscount.INSERT();

            until ItemDiscGroup.NEXT() = 0;
    end;


}

