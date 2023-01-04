page 50002 "BC6_Various Tables List"
{
    Caption = 'Various Tables List', comment = 'FRA="Liste Tables Diverses"';
    PageType = List;
    SourceTable = "BC6_Setup Various Tables";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

