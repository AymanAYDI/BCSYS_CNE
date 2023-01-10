page 50021 "BC6_Item Sales Profit Group"
{

    Caption = 'Item Sales Profit Group', Comment = 'FRA="Groupe Marge Vente Article"';

    PageType = List;
    SourceTable = "BC6_Item Sales Profit Group";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

