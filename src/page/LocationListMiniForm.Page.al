page 50053 "Location List MiniForm"
{
    Caption = 'Location List';
    Editable = false;
    PageType = List;
    SourceTable = Table14;
    SourceTableView = SORTING (Code)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code; Code)
                {
                }
                field("Bin Mandatory"; "Bin Mandatory")
                {
                }
                field(Name; Name)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

