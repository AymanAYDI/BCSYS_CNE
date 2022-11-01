page 50020 "Customer Profit"
{
    // //MARGEVENTECLT SM 15/10/06 NCS1.01 [FE024V1] CREATION

    Caption = 'Marge Client';
    PageType = List;
    SourceTable = Table99001;

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

