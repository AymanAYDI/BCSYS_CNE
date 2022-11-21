page 50053 "BC6_Location List MiniForm"
{
    Caption = 'Location List';
    Editable = false;
    PageType = List;
    SourceTable = Location;
    SourceTableView = SORTING(Code)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
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

