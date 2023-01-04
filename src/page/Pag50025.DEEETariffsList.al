page 50025 "BC6_DEEE Tariffs List"
{
    Caption = 'DEEE Tariffs List', Comment = 'FRA="Liste des catégories d''articles"';
    PageType = List;
    SourceTable = "BC6_DEEE Tariffs";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("DEEE Code"; Rec."DEEE Code")
                {
                    ApplicationArea = All;
                }
                field("Eco Partner"; Rec."Eco Partner")
                {
                    ApplicationArea = All;
                }
                field("Date beginning"; Rec."Date beginning")
                {
                    ApplicationArea = All;
                }
                field("HT Unit Tax (LCY)"; Rec."HT Unit Tax (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

