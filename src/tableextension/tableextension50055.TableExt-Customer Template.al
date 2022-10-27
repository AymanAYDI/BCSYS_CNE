tableextension 50055 tableextension50055 extends "Customer Template"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>>DEEE1.01:FLGR 19/02/2007 correct bug in quotes with customer template
    //    - add field 80800 "Submitted to DEEE"
    // ------------------------------------------------------------------------
    LookupPageID = 5156;
    DrillDownPageID = 5156;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        field(80800; "Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE';
            Description = 'DEEE1.01';
        }
    }

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 1)".

}

