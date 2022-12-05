report 50024 "MAJ article"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {
            DataItemTableView = SORTING (No.)
                                WHERE (No.=CONST(AWG114110090122));

            trigger OnAfterGetRecord()
            begin
                IF Item."Vendor No." = 'CNE' THEN BEGIN
                    Item."Vendor No." := 'AWG';
                    Item.MODIFY;
                END;
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
}

