tableextension 50080 tableextension50080 extends Bin
{
    // 
    // ----------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ----------------------------------------------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // //>> CNE4.02
    // C:FE08 05.11.2011 : Availability Customer Area - Post Invt Pick To Customer Area
    //        - Add Field    : 50000 To Make Available
    // 
    // ----------------------------------------------------------------------------------
    LookupPageID = 7303;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Adjustment Bin"(Field 5)".

        modify("Variant Filter")
        {
            TableRelation = "Stockkeeping Unit"."Variant Code" WHERE (Location Code=FIELD(Location Code),
                                                                      Item No.=FIELD(Item Filter));
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Default(Field 34)".

        field(50000;"To Make Available";Boolean)
        {
            Caption = 'To Make Available';
            Description = 'CNE4.02';
        }
        field(50001;"Sales Order Not Shipped";Boolean)
        {
            CalcFormula = Exist("Sales Header" WHERE (Document Type=CONST(Order),
                                                      Completely Shipped=CONST(No),
                                                      Location Code=FIELD(Location Code),
                                                      Bin Code=FIELD(Code)));
            Caption = 'Sales Order To Ship';
            Description = 'CNE4.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002;"Exclude Inventory Pick";Boolean)
        {
            Caption = 'Exclude Inventory Pick';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on "Code(Key)".

    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN BEGIN
          TESTFIELD("Zone Code");
          TESTFIELD("Bin Type Code");
        END ELSE BEGIN
          TESTFIELD("Zone Code",'');
          TESTFIELD("Bin Type Code",'');
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Location Code");
        #1..8
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetZone(PROCEDURE 1)".


    //Unsupported feature: Property Insertion (Local) on "GetItem(PROCEDURE 2)".


    //Unsupported feature: Property Insertion (Local) on "CheckMaxQtyBinContent(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CheckWhseClass(PROCEDURE 6)".

    //procedure CheckWhseClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetItem(ItemNo);
        IF ProductGroup.GET(Item."Item Category Code",Item."Product Group Code") THEN;
        IF IgnoreError THEN
          EXIT("Warehouse Class Code" = ProductGroup."Warehouse Class Code");
        TESTFIELD("Warehouse Class Code",ProductGroup."Warehouse Class Code");
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetItem(ItemNo);
        IF IgnoreError THEN
          EXIT("Warehouse Class Code" = Item."Warehouse Class Code");
        TESTFIELD("Warehouse Class Code",Item."Warehouse Class Code");
        EXIT(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "CheckEmptyBin(PROCEDURE 9)".

    //procedure CheckEmptyBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WarehouseEntry.SETCURRENTKEY("Bin Code","Location Code");
        WarehouseEntry.SETRANGE("Bin Code",Code);
        WarehouseEntry.SETRANGE("Location Code","Location Code");
        #4..7
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),
            "Location Code",FIELDCAPTION(Code),Code);

        WhseActivLine.SETCURRENTKEY("Bin Code","Location Code");
        WhseActivLine.SETRANGE("Bin Code",Code);
        WhseActivLine.SETRANGE("Location Code","Location Code");
        WhseActivLine.SETRANGE("Activity Type",WhseActivLine."Activity Type"::Movement);
        IF WhseActivLine.FINDFIRST THEN
          ERROR(
            Text001,
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),"Location Code",
            FIELDCAPTION(Code),Code,WhseActivLine.TABLECAPTION);

        WarehouseJnl.SETRANGE("Location Code","Location Code");
        WarehouseJnl.SETRANGE("From Bin Code",Code);
        IF WarehouseJnl.FINDFIRST THEN
          ERROR(
            Text001,
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),"Location Code",
            FIELDCAPTION(Code),Code,WarehouseJnl.TABLECAPTION);

        WarehouseJnl.RESET;
        WarehouseJnl.SETCURRENTKEY("To Bin Code","Location Code");
        WarehouseJnl.SETRANGE("To Bin Code",Code);
        WarehouseJnl.SETRANGE("Location Code","Location Code");
        IF WarehouseJnl.FINDFIRST THEN
          ERROR(
            Text001,
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),"Location Code",
            FIELDCAPTION(Code),Code,WarehouseJnl.TABLECAPTION);

        WhseRcptLine.SETCURRENTKEY("Bin Code","Location Code");
        WhseRcptLine.SETRANGE("Bin Code",Code);
        WhseRcptLine.SETRANGE("Location Code","Location Code");
        IF WhseRcptLine.FINDFIRST THEN
          ERROR(
            Text001,
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),"Location Code",
            FIELDCAPTION(Code),Code,WhseRcptLine.TABLECAPTION);

        WhseShptLine.SETCURRENTKEY("Bin Code","Location Code");
        WhseShptLine.SETRANGE("Bin Code",Code);
        WhseShptLine.SETRANGE("Location Code","Location Code");
        IF WhseShptLine.FINDFIRST THEN
          ERROR(
            Text001,
            ErrorText,TABLECAPTION,FIELDCAPTION("Location Code"),"Location Code",
            FIELDCAPTION(Code),Code,WhseShptLine.TABLECAPTION);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        #12..14
        IF NOT WhseActivLine.ISEMPTY THEN
        #16..22
        IF NOT WarehouseJnl.ISEMPTY THEN
        #24..29
        WarehouseJnl.SETRANGE("To Bin Code",Code);
        WarehouseJnl.SETRANGE("Location Code","Location Code");
        IF NOT WarehouseJnl.ISEMPTY THEN
        #34..38
        WhseRcptLine.SETRANGE("Bin Code",Code);
        WhseRcptLine.SETRANGE("Location Code","Location Code");
        IF NOT WhseRcptLine.ISEMPTY THEN
        #43..47
        WhseShptLine.SETRANGE("Bin Code",Code);
        WhseShptLine.SETRANGE("Location Code","Location Code");
        IF NOT WhseShptLine.ISEMPTY THEN
        #52..55
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CheckWhseClass(PROCEDURE 6).ProductGroup(Variable 1002)".

}

