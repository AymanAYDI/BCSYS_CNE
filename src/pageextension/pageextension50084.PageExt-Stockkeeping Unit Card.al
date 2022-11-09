pageextension 50084 pageextension50084 extends "Stockkeeping Unit Card"
{

    //Unsupported feature: Code Modification on "EnableCostingControls(PROCEDURE 3)".

    //procedure EnableCostingControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    StandardCostEnable := Item."Costing Method" = Item."Costing Method"::Standard;
    UnitCostEnable := Item."Costing Method" <> Item."Costing Method"::Standard;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    StandardCostEnable := Item."Costing Method" = Item."Costing Method"::Average;
    UnitCostEnable := Item."Costing Method" <> Item."Costing Method"::Average;
    */
    //end;
}

