page 50021 "BC6_Item Sales Profit Group"
{
    Caption = 'Groupe Marge Vente Article';
    PageType = List;
    SourceTable = "BC6_Item Sales Profit Group";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                }
                field(Designation; Designation)
                {
                }
            }
        }
    }

    actions
    {
    }
}

