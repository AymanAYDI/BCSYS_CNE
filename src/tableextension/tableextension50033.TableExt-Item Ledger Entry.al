tableextension 50033 tableextension50033 extends "Item Ledger Entry"
{
    LookupPageID = 38;
    DrillDownPageID = 38;
    fields
    {
        modify("Source No.")
        {
            TableRelation = IF (Source Type=CONST(Customer)) Customer
                            ELSE IF (Source Type=CONST(Vendor)) Vendor
                            ELSE IF (Source Type=CONST(Item)) Item;
        }
        modify(Description)
        {
            Caption = 'Description';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 47)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 70)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Quantity"(Field 70)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Assemble to Order"(Field 904)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered No."(Field 5701)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered Var. Code"(Field 5702)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5704)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5707)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipped Qty. Not Returned"(Field 5818)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Prod. Order Comp. Line No."(Field 5833)".

    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Item No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Item No.,Open,Variant Code,Positive,Location Code,Posting Date,Expiration Date,Lot No.,Serial No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Item No.,Open,Variant Code,Location Code,Item Tracking,Lot No.,Serial No."(Key)".


        //Unsupported feature: Property Deletion (SIFTLevelsToMaintain) on ""Item No.,Open,Variant Code,Positive,Location Code,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Item No.,Open,Variant Code,Positive,Location Code,Posting Date,Expiration Date,Lot No.,Serial No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Country/Region Code,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Item No.,Entry Type,Variant Code,Drop Shipment,Global Dimension 1 Code,Global Dimension 2 Code,Location Code,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Order Type,Order No.,Order Line No.,Entry Type,Prod. Order Comp. Line No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Item No.,Applied Entry to Adjust"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Item No.,Location Code,Open,Variant Code,Unit of Measure Code,Lot No.,Serial No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Open,Variant Code,Positive,Expiration Date,Lot No.,Serial No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Item No.,Open,Variant Code,Location Code,Item Tracking,Lot No.,Serial No."(Key)".

        key(Key1; "Item No.", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
        {
        }
    }

    //Unsupported feature: Property Insertion (Local) on "GetCurrencyCode(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "VerifyOnInventory(PROCEDURE 9)".

    //procedure VerifyOnInventory();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT Open THEN
      EXIT;
    IF Quantity >= 0 THEN
      EXIT;
    CASE "Entry Type" OF
      "Entry Type"::"Negative Adjmt.","Entry Type"::Consumption,"Entry Type"::"Assembly Consumption":
        IF "Source Type" = "Source Type"::Item THEN
          ERROR(IsNotOnInventoryErr,"Item No.");
      "Entry Type"::Transfer:
        ERROR(IsNotOnInventoryErr,"Item No.");
      ELSE BEGIN
        Item.GET("Item No.");
        IF Item.PreventNegativeInventory THEN
          ERROR(IsNotOnInventoryErr,"Item No.");
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      "Entry Type"::Consumption,"Entry Type"::"Assembly Consumption","Entry Type"::Transfer:
    #10..16
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateRemInventoryValue(PROCEDURE 12)".

    //procedure CalculateRemInventoryValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
    ValueEntry.SETRANGE("Item Ledger Entry No.",ItemLedgEntryNo);
    ValueEntry.SETFILTER("Posting Date",'<=%1',PostingDate);
    IF NOT IncludeExpectedCost THEN
      ValueEntry.SETRANGE("Expected Cost",FALSE);
    IF ValueEntry.FINDSET THEN
    #7..15
            AdjustedCost += RemQty / TotalQty * ValueEntry."Cost Amount (Actual)";
      UNTIL ValueEntry.NEXT = 0;
    EXIT(AdjustedCost);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
    ValueEntry.SETRANGE("Item Ledger Entry No.",ItemLedgEntryNo);
    ValueEntry.SETFILTER("Valuation Date",'<=%1',PostingDate);
    #4..18
    */
    //end;

    procedure TrackingExists(): Boolean
    begin
        EXIT(("Serial No." <> '') OR ("Lot No." <> ''));
    end;
}

