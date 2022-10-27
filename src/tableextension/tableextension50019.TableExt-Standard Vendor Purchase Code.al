tableextension 50019 tableextension50019 extends "Standard Vendor Purchase Code"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Text_Automatiques] Ajout du champ 50000
    // 
    // ------------------------------------------------------------------------
    Caption = 'Standard Vendor Purchase Code';
    fields
    {
        modify("Vendor No.")
        {
            Caption = 'Vendor No.';
        }
        modify("Code")
        {
            Caption = 'Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; TextautoReport; Boolean)
        {
            Caption = 'Text Auto Report';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Text_Automatiques] Ajout du champ';
        }
    }

    //Unsupported feature: Variable Insertion (Variable: StdVendPurchCodes) (VariableCollection) on "InsertPurchLines(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "InsertPurchLines(PROCEDURE 1)".

    //procedure InsertPurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchHeader.TESTFIELD("No.");
    PurchHeader.TESTFIELD("Buy-from Vendor No.");

    StdVendPurchCode.FILTERGROUP := 2;
    StdVendPurchCode.SETRANGE("Vendor No.",PurchHeader."Buy-from Vendor No.");
    StdVendPurchCode.FILTERGROUP := 0;

    IF PAGE.RUNMODAL(PAGE::"Standard Vendor Purchase Codes",StdVendPurchCode) = ACTION::LookupOK THEN
      ApplyStdCodesToPurchaseLines(PurchHeader,StdVendPurchCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    StdVendPurchCodes.SETTABLEVIEW(StdVendPurchCode);
    StdVendPurchCodes.LOOKUPMODE(TRUE);
    IF StdVendPurchCodes.RUNMODAL = ACTION::LookupOK THEN BEGIN
      StdVendPurchCodes.GetSelected(StdVendPurchCode);
      IF StdVendPurchCode.FINDSET THEN
        REPEAT
          ApplyStdCodesToPurchaseLines(PurchHeader,StdVendPurchCode);
        UNTIL StdVendPurchCode.NEXT = 0;
    END;
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "GetNextLineNo(PROCEDURE 4)".

}

