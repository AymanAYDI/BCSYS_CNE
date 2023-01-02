page 50020 "BC6_Customer Profit"
{
    Caption = 'Marge Client', Comment = 'FRA="Marge Client"';
    PageType = List;
    SourceTable = "Customer Sales Profit Group";
    UsageCategory = Lists;
    ApplicationArea = All;

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
                field(Designation; Designation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

