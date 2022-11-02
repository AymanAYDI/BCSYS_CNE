page 50024 "BC6_Item Category List"
{
    Caption = 'Liste des catégories d''articles';
    PageType = List;
    SourceTable = "BC6_Categories of item";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Category; Category)
                {
                }
                field("Eco Partner"; "Eco Partner")
                {
                }
                field("Weight Min"; "Weight Min")
                {
                }
                field("Weight Max"; "Weight Max")
                {
                }
                field("Eco-partner"; "Eco-partner")
                {
                }
                field(Designation; Designation)
                {
                }
                field("DEEE Product Group ID"; "DEEE Product Group ID")
                {
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
                Caption = '&Tariffs';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_DEEE Tariffs List";
                RunPageLink = "DEEE Code" = FIELD(Category),
                              "Eco Partner" = FIELD("Eco Partner");
            }
        }
    }
}

