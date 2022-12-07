report 50002 "BC6_TI213763"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("VAT Prod. Posting Group" = CONST('TVA19,6'),
                                      "No." = FILTER('P*'));

            trigger OnAfterGetRecord()
            begin
                IF Item."VAT Prod. Posting Group" = 'TVA19,6' THEN BEGIN
                    i := i + 1;
                    Item."VAT Prod. Posting Group" := 'TVA20';
                    Item.MODIFY;
                END
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('%1 enregistrements modifiés', i);
            end;

            trigger OnPreDataItem()
            begin
                i := 0
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
        i: Integer;
}

