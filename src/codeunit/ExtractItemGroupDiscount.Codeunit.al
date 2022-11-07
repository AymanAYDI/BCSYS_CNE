codeunit 50092 "Extract Item Group Discount"
{
    TableNo = 7004;

    trigger OnRun()
    var
        FromSalesLineDiscount: Record "7004";
        SalesLineDiscount: Record "7004";
        ToSalesLineDiscount: Record "7004";
        ItemDiscGroup: Record "341";
        ItemDiscGroupForm: Page "513";
    begin

        TESTFIELD("Sales Type", "Sales Type"::Customer);
        TESTFIELD("Sales Code");
        TESTFIELD(Type, Type::"Item Disc. Group");
        // TESTFIELD(Code);

        FromSalesLineDiscount := Rec;

        ItemDiscGroup.RESET;
        CLEAR(ItemDiscGroupForm);
        ItemDiscGroupForm.SETRECORD(ItemDiscGroup);
        ItemDiscGroupForm.SETTABLEVIEW(ItemDiscGroup);
        ItemDiscGroupForm.EDITABLE(FALSE);
        ItemDiscGroupForm.LOOKUPMODE := TRUE;
        IF ItemDiscGroupForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CLEAR(ItemDiscGroup);
            ItemDiscGroupForm.GetSelectionFilter2(ItemDiscGroup);
            // MESSAGE('%1',ItemDiscGroup.COUNT);
        END ELSE
            EXIT;

        SalesLineDiscount.RESET;
        SalesLineDiscount.SETRANGE("Sales Type", FromSalesLineDiscount."Sales Type");
        SalesLineDiscount.SETRANGE("Sales Code", FromSalesLineDiscount."Sales Code");
        SalesLineDiscount.SETRANGE(Type, FromSalesLineDiscount.Type::"Item Disc. Group");
        IF ItemDiscGroup.FIND('-') THEN
            REPEAT

                SalesLineDiscount.SETRANGE(Code, ItemDiscGroup.Code);
                IF NOT SalesLineDiscount.ISEMPTY THEN
                    SalesLineDiscount.DELETEALL(TRUE);

                ToSalesLineDiscount.INIT;
                ToSalesLineDiscount.Type := FromSalesLineDiscount.Type::"Item Disc. Group";
                ToSalesLineDiscount.Code := ItemDiscGroup.Code;
                ToSalesLineDiscount."Sales Type" := FromSalesLineDiscount."Sales Type";
                ToSalesLineDiscount."Sales Code" := FromSalesLineDiscount."Sales Code";
                ToSalesLineDiscount."Starting Date" := FromSalesLineDiscount."Starting Date";
                ToSalesLineDiscount."Currency Code" := FromSalesLineDiscount."Currency Code";
                ToSalesLineDiscount."Variant Code" := FromSalesLineDiscount."Variant Code";
                ToSalesLineDiscount."Unit of Measure Code" := FromSalesLineDiscount."Unit of Measure Code";
                ToSalesLineDiscount."Minimum Quantity" := FromSalesLineDiscount."Minimum Quantity";
                ToSalesLineDiscount."Profit %" := FromSalesLineDiscount."Profit %";
                ToSalesLineDiscount."Line Discount %" := FromSalesLineDiscount."Line Discount %";
                ToSalesLineDiscount."Ending Date" := FromSalesLineDiscount."Ending Date";
                ToSalesLineDiscount."Dispensation No." := FromSalesLineDiscount."Dispensation No.";
                ToSalesLineDiscount."Added Discount %" := FromSalesLineDiscount."Added Discount %";
                ToSalesLineDiscount.INSERT;

            UNTIL ItemDiscGroup.NEXT = 0;
    end;

    var
        Text001: Label 'Souhaitez-vous supprimer les %1 remises existantes ?';
}

