report 50057 "Re Blocked Items"
{
    Caption = 'Item Blocked, Negative Inv. ?';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem8129; Table27)
        {
            RequestFilterFields = "No.", "Location Filter";

            trigger OnAfterGetRecord()
            begin
                Counter += 1;

                Window.UPDATE(1, "No.");
                Window.UPDATE(2, Counter);
                Window.UPDATE(3, TotalCounter);

                /*CALCFIELDS(Inventory);
                QtyToEmpty := Inventory;
                IF (QtyToEmpty < 0) THEN
                  BEGIN
                    Item."No. 2" := 'NEGATIF';
                    Item.MODIFY(FALSE);
                END; */

                IF Item."No. 2" = 'BLOQUE' THEN BEGIN
                    Item.Blocked := TRUE;
                    Item.MODIFY(FALSE);
                END;

            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(STRSUBSTNO(Text002) + '\' +
                            Text003 + '\' +
                            Text004);

                TotalCounter := COUNT;
                Counter := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text001: Label 'Report must be initialized';
        Text002: Label 'Extract Inventory Location %1...';
        Text003: Label 'Item No. #1#############';
        Window: Dialog;
        QtyToEmpty: Decimal;
        Text004: Label '           #2#####|#3#####';
        Counter: Integer;
        TotalCounter: Integer;
        TotalCounterTxt: Text[30];
}

