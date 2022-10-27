tableextension 50091 "BC6_PlanningAssignment" extends "Planning Assignment"
{

    //Unsupported feature: Code Modification on "ItemChange(PROCEDURE 3)".

    //procedure ItemChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NewItem."Reordering Policy" = NewItem."Reordering Policy"::" " THEN
      IF OldItem."Reordering Policy" <> OldItem."Reordering Policy"::" " THEN
        AnnulAllAssignment(NewItem."No.")
      ELSE
        EXIT
    #6..18
        THEN
          AssignOne(NewItem."No.",'',ManufacturingSetup."Components at Location",WORKDATE);
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NewItem."Reordering Policy" = NewItem."Reordering Policy"::"Maximum Qty." THEN
      IF OldItem."Reordering Policy" <> OldItem."Reordering Policy"::"Maximum Qty." THEN
    #3..21
    */
    //end;


    //Unsupported feature: Code Modification on "RoutingReplace(PROCEDURE 11)".

    //procedure RoutingReplace();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OldRoutingNo <> Item."Routing No." THEN
      IF Item."Reordering Policy" <> Item."Reordering Policy"::" " THEN
        AssignPlannedOrders(Item."No.",FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF OldRoutingNo <> Item."Routing No." THEN
      IF Item."Reordering Policy" <> Item."Reordering Policy"::"Maximum Qty." THEN
        AssignPlannedOrders(Item."No.",FALSE);
    */
    //end;


    //Unsupported feature: Code Modification on "BomReplace(PROCEDURE 8)".

    //procedure BomReplace();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OldProductionBOMNo <> Item."Production BOM No." THEN BEGIN
      IF Item."Reordering Policy" <> Item."Reordering Policy"::" " THEN
        AssignPlannedOrders(Item."No.",FALSE);
      IF OldProductionBOMNo <> '' THEN
        OldBom(OldProductionBOMNo);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF OldProductionBOMNo <> Item."Production BOM No." THEN BEGIN
      IF Item."Reordering Policy" <> Item."Reordering Policy"::"Maximum Qty." THEN
    #3..6
    */
    //end;


    //Unsupported feature: Code Modification on "OldBom(PROCEDURE 2)".

    //procedure OldBom();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ProductionBOMVersion.SETRANGE("Production BOM No.",ProductionBOMNo);
    ProductionBOMVersion.SETRANGE(Status,ProductionBOMVersion.Status::Certified);
    UseVersions := ProductionBOMVersion.FINDSET;
    #4..17
        REPEAT
          IF ProductionBOMLine.Type = ProductionBOMLine.Type::Item THEN BEGIN
            IF Item.GET(ProductionBOMLine."No.") THEN
              IF Item."Reordering Policy" <> Item."Reordering Policy"::" " THEN
                AssignPlannedOrders(ProductionBOMLine."No.",FALSE);
          END ELSE
            IF ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" THEN
    #25..28
      ELSE
        EndLoop := TRUE;
    UNTIL EndLoop;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
              IF Item."Reordering Policy" <> Item."Reordering Policy"::"Maximum Qty." THEN
    #22..31
    */
    //end;


    //Unsupported feature: Code Modification on "NewBOM(PROCEDURE 7)".

    //procedure NewBOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.SETCURRENTKEY("Production BOM No.");
    Item.SETRANGE("Production BOM No.",ProductionBOMNo);
    IF Item.FINDSET THEN
      REPEAT
        IF Item."Reordering Policy" <> Item."Reordering Policy"::" " THEN
          AssignPlannedOrders(Item."No.",FALSE);
      UNTIL Item.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
        IF Item."Reordering Policy" <> Item."Reordering Policy"::"Maximum Qty." THEN
          AssignPlannedOrders(Item."No.",FALSE);
      UNTIL Item.NEXT = 0;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SKU) (VariableCollection) on "ChkAssignOne(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: ReorderingPolicy) (VariableCollection) on "ChkAssignOne(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "ChkAssignOne(PROCEDURE 1)".

    //procedure ChkAssignOne();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Item.GET(ItemNo) THEN
      IF Item."Reordering Policy" <> Item."Reordering Policy"::" " THEN
        AssignOne(ItemNo,VariantCode,LocationCode,UpdateDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ReorderingPolicy := Item."Reordering Policy"::" ";

    IF SKU.GET(LocationCode,ItemNo,VariantCode) THEN
      ReorderingPolicy := SKU."Reordering Policy"
    ELSE
      IF Item.GET(ItemNo) THEN
        ReorderingPolicy := Item."Reordering Policy";

    IF ReorderingPolicy <> Item."Reordering Policy"::"Maximum Qty." THEN
      AssignOne(ItemNo,VariantCode,LocationCode,UpdateDate);
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "SKUexists(PROCEDURE 10)".

}

