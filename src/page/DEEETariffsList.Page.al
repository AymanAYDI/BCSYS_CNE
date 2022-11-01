page 50025 "DEEE Tariffs List"
{
    // //DEEE1.00 MICO
    //   Création du formulaire liste attaché à la table DEEE Tariffs

    Caption = 'DEEE Tariffs List';
    PageType = List;
    SourceTable = Table50007;

    layout
    {
        area(content)
        {
            repeater()
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

