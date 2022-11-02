page 50025 "BC6_DEEE Tariffs List"
{
    Caption = 'DEEE Tariffs List';
    PageType = List;
    SourceTable = "BC6_DEEE Tariffs";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("DEEE Code"; "DEEE Code")
                {
                }
                field("Eco Partner"; "Eco Partner")
                {
                }
                field("Date beginning"; "Date beginning")
                {
                }
                field("HT Unit Tax (LCY)"; "HT Unit Tax (LCY)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

