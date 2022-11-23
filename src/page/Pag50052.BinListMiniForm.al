page 50052 "BC6_Bin List MiniForm"
{
    Caption = 'Bin List', Comment = 'FRA="Liste emplacements"';
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
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Empty; Empty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

