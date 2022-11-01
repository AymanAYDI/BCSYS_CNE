page 50052 "Bin List MiniForm"
{
    Caption = 'Bin List';
    Editable = false;
    PageType = List;
    SourceTable = Table7354;
    SourceTableView = SORTING (Location Code, Code)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field(Code; Code)
                {
                }
                field(Empty; Empty)
                {
                }
            }
        }
    }

    actions
    {
    }
}

