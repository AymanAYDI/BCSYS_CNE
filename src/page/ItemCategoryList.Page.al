page 50024 "Item Category List"
{
    // //DEEE1.00 MICO
    //   Création du formulaire liste attaché à la table catégories d'articles

    Caption = 'Liste des catégories d''articles';
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater()
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
                RunObject = Page 50025;
                RunPageLink = DEEE Code=FIELD(Category),
                              Eco Partner=FIELD(Eco Partner);
            }
        }
    }
}

