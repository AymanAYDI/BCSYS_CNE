page 50002 "BC6_Various Tables List"
{
    Caption = 'Various Tables List', comment = 'FRA="Liste Tables Diverses"';
    PageType = List;
    SourceTable = "BC6_Setup Various Tables";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

