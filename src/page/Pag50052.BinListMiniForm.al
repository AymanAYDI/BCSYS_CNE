page 50052 "BC6_Bin List MiniForm"
{
    Caption = 'Bin List';
    Editable = false;
    PageType = List;
    SourceTable = Bin;
    SourceTableView = SORTING("Location Code", Code)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field("Code"; Code)
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

