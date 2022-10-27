tableextension 50053 tableextension50053 extends "Contact Business Relation"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:IDSITE 21/11/2007 : gestion des appeles d'offres clients
    //    - Change table proprety "LookupFormID"
    // ------------------------------------------------------------------------
    DrillDownPageID = 5061;
    LookupPageID = 50035;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Link to Table=CONST(Customer)) Customer
                            ELSE IF (Link to Table=CONST(Vendor)) Vendor
                            ELSE IF (Link to Table=CONST(Bank Account)) "Bank Account";
        }
        modify("Business Relation Description")
        {
            Caption = 'Business Relation Description';
        }


        //Unsupported feature: Code Modification on ""Business Relation Code"(Field 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("No." = '') AND
           ("Contact No." <> '') AND
           ("Business Relation Code" <> '')
        THEN BEGIN
          RMSetup.GET;
          IF "Business Relation Code" = RMSetup."Bus. Rel. Code for Customers" THEN
        #7..15
              FIELDCAPTION("Business Relation Code"),"Business Relation Code",
              Cont.TABLECAPTION,BankAcc.TABLECAPTION);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ("No." = '') AND
           ("Contact No." <> '') AND
           ("Business Relation Code" <> '') AND
           (CurrFieldNo <> 0)
        #4..18
        */
        //end;
    }

    //Unsupported feature: Property Insertion (Local) on "TouchContact(PROCEDURE 1)".

}

