page 50053 "BC6_Location List MiniForm"
{
    Caption = 'Location List', Comment = 'FRA="Liste des magasins"';
    Editable = false;
    PageType = List;
    SourceTable = Location;
    SourceTableView = SORTING(Code)
                      ORDER(Ascending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Bin Mandatory"; "Bin Mandatory")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

