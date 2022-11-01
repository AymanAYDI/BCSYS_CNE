page 50021 "Item Sales Profit Group"
{
    // //MARGEVENTEARTICLE SM 15/10/06 NCS1.01 [FE024V1] CREATION

    Caption = 'Groupe Marge Vente Article';
    PageType = List;
    SourceTable = Table99002;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code; Code)
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

