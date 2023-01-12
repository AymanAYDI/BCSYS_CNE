report 50056 "BC6_Blocked Items"
{
    Caption = 'Item Blocked, Negative Inv. ?', comment = 'FRA="Articles débloquer, stock négatif ?"';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Location Filter";

            trigger OnAfterGetRecord()
            begin
                Counter += 1;

                Window.UPDATE(1, "No.");
                Window.UPDATE(2, Counter);
                Window.UPDATE(3, TotalCounter);

                CALCFIELDS(Inventory);
                QtyToEmpty := Inventory;
                IF (QtyToEmpty < 0) THEN BEGIN
                    Item."No. 2" := 'NEGATIF';
                    Item.MODIFY(FALSE);
                END;

                IF Blocked THEN BEGIN
                    Item.Blocked := FALSE;
                    Item."No. 2" := 'BLOQUE';
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
        QtyToEmpty: Decimal;
        Window: Dialog;
        Counter: Integer;
        TotalCounter: Integer;
        Text002: Label 'Extract Inventory Location %1...', comment = 'FRA="Débloquer articles, stock négatif ..."';
        Text003: Label 'Item No. #1#############', comment = 'FRA="article n° #1#############"';
        Text004: Label '           #2#####|#3#####';
}

