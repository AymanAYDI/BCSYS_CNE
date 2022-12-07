report 50001 "BC6_MAJ Order Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267001; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order),
                                      "Completely Shipped" = CONST(false));
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(<> ' '),
                                          "No." = FILTER(<> ''),
                                          Quantity = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    "Sales Line"."Completely Shipped" := TRUE;
                    "Sales Line".MODIFY();
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

