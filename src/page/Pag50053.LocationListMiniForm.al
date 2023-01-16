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
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Bin Mandatory"; Rec."Bin Mandatory")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}
