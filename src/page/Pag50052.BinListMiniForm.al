page 50052 "BC6_Bin List MiniForm"
{
    Caption = 'Bin List', Comment = 'FRA="Liste emplacements"';
    Editable = false;
    PageType = List;
    SourceTable = Bin;
    SourceTableView = SORTING("Location Code", Code)
                      ORDER(Ascending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Empty; Rec.Empty)
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

