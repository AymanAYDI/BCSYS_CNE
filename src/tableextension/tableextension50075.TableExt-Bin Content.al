tableextension 50075 tableextension50075 extends "Bin Content"
{
    // //>> MIGRATION 2013
    LookupPageID = 7305;
    DrillDownPageID = 7305;
    fields
    {
        modify("Bin Code")
        {
            TableRelation = IF (Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                            ELSE IF (Zone Code=FILTER(<>'')) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                             Zone Code=FIELD(Zone Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Quantity(Field 26)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pick Qty."(Field 29)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Neg. Adjmt. Qty."(Field 30)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Put-away Qty."(Field 31)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pos. Adjmt. Qty."(Field 32)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Quantity (Base)"(Field 50)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pick Quantity (Base)"(Field 51)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Negative Adjmt. Qty. (Base)"(Field 52)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Put-away Quantity (Base)"(Field 53)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Positive Adjmt. Qty. (Base)"(Field 54)".

        field(55;"ATO Components Pick Qty.";Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE (Location Code=FIELD(Location Code),
                                                                                  Bin Code=FIELD(Bin Code),
                                                                                  Item No.=FIELD(Item No.),
                                                                                  Variant Code=FIELD(Variant Code),
                                                                                  Unit of Measure Code=FIELD(Unit of Measure Code),
                                                                                  Action Type=CONST(Take),
                                                                                  Lot No.=FIELD(Lot No. Filter),
                                                                                  Serial No.=FIELD(Serial No. Filter),
                                                                                  Assemble to Order=CONST(Yes),
                                                                                  ATO Component=CONST(Yes)));
            Caption = 'ATO Components Pick Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(56;"ATO Components Pick Qty (Base)";Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE (Location Code=FIELD(Location Code),
                                                                                         Bin Code=FIELD(Bin Code),
                                                                                         Item No.=FIELD(Item No.),
                                                                                         Variant Code=FIELD(Variant Code),
                                                                                         Unit of Measure Code=FIELD(Unit of Measure Code),
                                                                                         Action Type=CONST(Take),
                                                                                         Lot No.=FIELD(Lot No. Filter),
                                                                                         Serial No.=FIELD(Serial No. Filter),
                                                                                         Assemble to Order=CONST(Yes),
                                                                                         ATO Component=CONST(Yes)));
            Caption = 'ATO Components Pick Qty (Base)';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(6503;"Unit of Measure Filter";Code[10])
        {
            Caption = 'Unit of Measure Filter';
            FieldClass = FlowFilter;
            TableRelation = "Item Unit of Measure".Code WHERE (Item No.=FIELD(Item No.));
        }
    }

    //Unsupported feature: Property Insertion (Local) on "CheckManualChange(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "CalcQtyAvailToTake(PROCEDURE 15)".

    //procedure CalcQtyAvailToTake();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Quantity (Base)","Negative Adjmt. Qty. (Base)","Pick Quantity (Base)");
        EXIT("Quantity (Base)" - ("Pick Quantity (Base)" - ExcludeQtyBase + "Negative Adjmt. Qty. (Base)"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        //>>MIGRATION 2013
        //>> 29.03.2012 Begin
        GetBin("Location Code","Bin Code");
        IF Bin."Exclude Inventory Pick" THEN
          EXIT(0);
        //<< End
        //<<MIGRATION 2013
        SetFilterOnUnitOfMeasure;
        CALCFIELDS("Quantity (Base)","Negative Adjmt. Qty. (Base)","Pick Quantity (Base)","ATO Components Pick Qty (Base)");
        EXIT(
          "Quantity (Base)" -
          (("Pick Quantity (Base)" + "ATO Components Pick Qty (Base)") - ExcludeQtyBase + "Negative Adjmt. Qty. (Base)"));
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CalcQtyAvailToPutAway(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "CheckBinMaxCubageAndWeight(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CheckDecreaseBinContent(PROCEDURE 21)".

    //procedure CheckDecreaseBinContent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Block Movement" IN ["Block Movement"::Outbound,"Block Movement"::All] THEN
          FIELDERROR("Block Movement");

        #4..22
          DecreaseQtyBase := DecreaseQtyBase + WhseActivLine."Qty. (Base)";
        END;

        QtyAvailToPickBase := CalcQtyAvailToTake(DecreaseQtyBase);
        IF QtyAvailToPickBase < QtyBase THEN BEGIN
          GetItem("Item No.");
          QtyAvailToPick := ROUND(QtyAvailToPickBase / UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code"),0.00001);
          IF QtyAvailToPick = Qty THEN
            QtyBase := QtyAvailToPickBase // rounding issue- qty is same, but not qty (base)
          ELSE
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text006,ABS(QtyBase)));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..25
        QtyAvailToPickBase := CalcTotalQtyAvailToTake(DecreaseQtyBase);
        #27..34
        */
    //end;


    //Unsupported feature: Code Modification on "CheckWhseClass(PROCEDURE 5)".

    //procedure CheckWhseClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetItem("Item No.");
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
        GetItem("Item No.");
        IF IgnoreError THEN
          EXIT("Warehouse Class Code" = Item."Warehouse Class Code");
        TESTFIELD("Warehouse Class Code",Item."Warehouse Class Code");
        EXIT(TRUE);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetBin(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "GetWhseLocation(PROCEDURE 9)".

    //procedure GetWhseLocation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF USERID <> '' THEN BEGIN
          WhseEmployee.SETRANGE("User ID",USERID);
          IF NOT WhseEmployee.FINDFIRST THEN
            ERROR(Text009,USERID);
          IF CurrentLocationCode <> '' THEN BEGIN
            IF NOT Location.GET(CurrentLocationCode) THEN BEGIN
        #7..11
                CurrentZoneCode := '';
              END ELSE BEGIN
                WhseEmployee.SETRANGE("Location Code",CurrentLocationCode);
                IF NOT WhseEmployee.FINDFIRST THEN BEGIN
                  CurrentLocationCode := '';
                  CurrentZoneCode := '';
                END;
        #19..37
        ELSE
          SETRANGE("Zone Code");
        FILTERGROUP := 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF USERID <> '' THEN BEGIN
          WhseEmployee.SETRANGE("User ID",USERID);
          IF WhseEmployee.ISEMPTY THEN
        #4..14
                IF WhseEmployee.ISEMPTY THEN BEGIN
        #16..40
        */
    //end;

    local procedure CalcTotalQtyAvailToTake(ExcludeQtyBase: Decimal): Decimal
    var
        TotalQtyBase: Decimal;
        TotalNegativeAdjmtQtyBase: Decimal;
        TotalATOComponentsPickQtyBase: Decimal;
    begin
        TotalQtyBase := CalcTotalQtyBase;
        TotalNegativeAdjmtQtyBase := CalcTotalNegativeAdjmtQtyBase;
        TotalATOComponentsPickQtyBase := CalcTotalATOComponentsPickQtyBase;
        SetFilterOnUnitOfMeasure;
        CALCFIELDS("Pick Quantity (Base)");
        EXIT(
          TotalQtyBase -
          ("Pick Quantity (Base)" + TotalATOComponentsPickQtyBase - ExcludeQtyBase + TotalNegativeAdjmtQtyBase));
    end;

    procedure SetFilterOnUnitOfMeasure()
    begin
        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
          SETRANGE("Unit of Measure Filter","Unit of Measure Code")
        ELSE
          SETRANGE("Unit of Measure Filter");
    end;

    local procedure CalcTotalQtyBase(): Decimal
    var
        WarehouseEntry: Record "7312";
    begin
        WarehouseEntry.SETRANGE("Location Code","Location Code");
        WarehouseEntry.SETRANGE("Bin Code","Bin Code");
        WarehouseEntry.SETRANGE("Item No.","Item No.");
        WarehouseEntry.SETRANGE("Variant Code","Variant Code");
        WarehouseEntry.SETFILTER("Lot No.",GETFILTER("Lot No. Filter"));
        WarehouseEntry.SETFILTER("Serial No.",GETFILTER("Serial No. Filter"));
        WarehouseEntry.CALCSUMS("Qty. (Base)");
        EXIT(WarehouseEntry."Qty. (Base)");
    end;

    local procedure CalcTotalNegativeAdjmtQtyBase(): Decimal
    var
        WarehouseJournalLine: Record "7311";
    begin
        WarehouseJournalLine.SETRANGE("Location Code","Location Code");
        WarehouseJournalLine.SETRANGE("From Bin Code","Bin Code");
        WarehouseJournalLine.SETRANGE("Item No.","Item No.");
        WarehouseJournalLine.SETRANGE("Variant Code","Variant Code");
        WarehouseJournalLine.SETFILTER("Lot No.",GETFILTER("Lot No. Filter"));
        WarehouseJournalLine.SETFILTER("Serial No.",GETFILTER("Serial No. Filter"));
        WarehouseJournalLine.CALCSUMS("Qty. (Absolute, Base)");
        EXIT(WarehouseJournalLine."Qty. (Absolute, Base)");
    end;

    local procedure CalcTotalATOComponentsPickQtyBase(): Decimal
    var
        WarehouseActivityLine: Record "5767";
    begin
        GetLocation("Location Code");
        WarehouseActivityLine.SETRANGE("Location Code","Location Code");
        WarehouseActivityLine.SETRANGE("Bin Code","Bin Code");
        WarehouseActivityLine.SETRANGE("Item No.","Item No.");
        WarehouseActivityLine.SETRANGE("Variant Code","Variant Code");
        IF Location."Allow Breakbulk" THEN
          WarehouseActivityLine.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        WarehouseActivityLine.SETRANGE("Activity Type",WarehouseActivityLine."Activity Type"::Pick);
        WarehouseActivityLine.SETRANGE("Action Type",WarehouseActivityLine."Action Type"::Take);
        WarehouseActivityLine.SETRANGE("Assemble to Order",TRUE);
        WarehouseActivityLine.SETRANGE("ATO Component",TRUE);
        WarehouseActivityLine.SETFILTER("Lot No.",GETFILTER("Lot No. Filter"));
        WarehouseActivityLine.SETFILTER("Serial No.",GETFILTER("Serial No. Filter"));
        WarehouseActivityLine.CALCSUMS("Qty. (Base)");
        EXIT(WarehouseActivityLine."Qty. (Base)");
    end;

    //Unsupported feature: Deletion (VariableCollection) on "CheckWhseClass(PROCEDURE 5).ProductGroup(Variable 1002)".

}

