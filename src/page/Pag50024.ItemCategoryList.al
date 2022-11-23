page 50024 "BC6_Item Category List"
{
    Caption = 'Item Category List', Comment = 'FRA="Liste des catégories d''articles"';
    PageType = List;
    SourceTable = "BC6_Categories of item";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Category; Category)
                {
                    ApplicationArea = All;
                }
                field("Eco Partner"; "Eco Partner")
                {
                    ApplicationArea = All;
                }
                field("Weight Min"; "Weight Min")
                {
                    ApplicationArea = All;
                }
                field("Weight Max"; "Weight Max")
                {
                    ApplicationArea = All;
                }
                field("Eco-partner"; "Eco-partner")
                {
                    ApplicationArea = All;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = All;
                }
                field("DEEE Product Group ID"; "DEEE Product Group ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Tariffs")
            {
                Caption = '&Tariffs', Comment = 'FRA="&Tarifs"';
                Promoted = true;
                PromotedCategory = Process;

                RunPageLink = "DEEE Code" = FIELD(Category),
                              "Eco Partner" = FIELD("Eco Partner");
                RunObject = Page "BC6_DEEE Tariffs List";
                ApplicationArea = All;
            }
        }
    }
}

