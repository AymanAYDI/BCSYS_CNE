report 50001 "MAJ Order Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267001; Table36)
        {
            DataItemTableView = WHERE (Document Type=CONST(Order),
                                      Completely Shipped=CONST(No));
            dataitem(DataItem1100267000; Table37)
            {
                DataItemLink = Document Type=FIELD(Document Type),
                               Document No.=FIELD(No.);
                DataItemTableView = WHERE(Type=FILTER(<>' '),
                                          No.=FILTER(<>''),
                                          Quantity=CONST(0));

                trigger OnAfterGetRecord()
                begin
                    "Sales Line"."Completely Shipped" := TRUE;
                    "Sales Line".MODIFY;
                end;
            }
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

