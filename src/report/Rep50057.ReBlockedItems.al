report 50057 "BC6_Re Blocked Items"
{
    Caption = 'Item Blocked, Negative Inv. ?', comment = 'FRA="Articles débloquer, stock négatif ?"';
    ProcessingOnly = true;

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
        Text002: Label 'Extract Inventory Location %1...', comment = 'FRA="Débloquer articles, stock négatif ..."';
        Text003: Label 'Item No. #1#############', comment = 'FRA="article n° #1#############"';
        Window: Dialog;
        Text004: Label '           #2#####|#3#####';
        Counter: Integer;
        TotalCounter: Integer;
}

