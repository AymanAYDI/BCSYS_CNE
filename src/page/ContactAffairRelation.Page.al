page 50035 "Contact Affair Relation"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : gestin des appeles d'offres clients
    //    - Form created
    // ------------------------------------------------------------------------

    Caption = 'Contact Affair Relation';
    Editable = false;
    PageType = List;
    SourceTable = Table5054;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Business Relation Code"; "Business Relation Code")
                {
                }
                field("Business Relation Description"; "Business Relation Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

