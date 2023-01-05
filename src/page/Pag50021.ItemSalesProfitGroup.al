page 50021 "BC6_Item Sales Profit Group"
{
    Caption = 'Item Sales Profit Group', Comment = 'FRA="Groupe Marge Vente Article"';
    PageType = List;
    SourceTable = "BC6_Item Sales Profit Group";
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

