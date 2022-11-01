page 50020 "BC6_Customer Profit"
{
    Caption = 'Marge Client';
    PageType = List;
    SourceTable = "Customer Sales Profit Group";

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

