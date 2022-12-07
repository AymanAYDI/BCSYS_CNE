report 50089 "MAJ ITEM"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            DataItemTableView = WHERE(No.=FILTER(CLI*));

            trigger OnAfterGetRecord()
            begin
                Item.Blocked:=FALSE;
                MODIFY;
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

