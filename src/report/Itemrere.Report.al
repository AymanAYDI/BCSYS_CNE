report 50000 "Item rere"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            DataItemTableView = WHERE (Description = CONST (COLLIER EN INOX DE LIAISON));

            trigger OnAfterGetRecord()
            begin
                IF Item."No." <> 'CEL0-031820' THEN BEGIN
                    Item.RENAME('MIGRATION 2013');
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

