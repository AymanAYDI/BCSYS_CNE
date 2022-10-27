tableextension 50023 tableextension50023 extends "Reason Code"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    // ------------------------------------------------------------------------
    LookupPageID = 259;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Contract Gain/Loss Amount"(Field 5901)".

        field(80800; "Disable DEEE"; Boolean)
        {
            Caption = 'Désactiver DEEE';
            Description = 'DEEE1.00';
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".

}

