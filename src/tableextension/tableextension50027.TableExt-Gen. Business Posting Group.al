tableextension 50027 tableextension50027 extends "Gen. Business Posting Group"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    // ------------------------------------------------------------------------
    LookupPageID = 312;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        field(80800; "Subject to DEEE"; Boolean)
        {
            Caption = 'Subject to DEEE';
            Description = 'DEEE1.00';
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".

}

