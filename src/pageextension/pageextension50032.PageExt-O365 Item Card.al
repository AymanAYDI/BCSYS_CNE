pageextension 50032 pageextension50032 extends "O365 Item Card"
{

    //Unsupported feature: Code Modification on "EnableControls(PROCEDURE 6)".

    //procedure EnableControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ProfitEditable := "Price/Profit Calculation" <> "Price/Profit Calculation"::"Profit=Price-Cost";
    PriceEditable := "Price/Profit Calculation" <> "Price/Profit Calculation"::"Price=Cost+Profit";

    EnableCostingControls;

    EnableShowStockOutWarning;

    EnableShowShowEnforcePositivInventory;

    UpdateSpecialPricesAndDiscountsTxt;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ProfitEditable := "Price/Profit Calculation" <> "Price/Profit Calculation"::"Price=Cost+Profit";
    PriceEditable := "Price/Profit Calculation" <> "Price/Profit Calculation"::"Profit=Price-Cost";
    #3..10
    */
    //end;


    //Unsupported feature: Code Modification on "EnableCostingControls(PROCEDURE 3)".

    //procedure EnableCostingControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    StandardCostEnable := "Costing Method" = "Costing Method"::Standard;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    StandardCostEnable := "Costing Method" = "Costing Method"::Average;
    */
    //end;


    //Unsupported feature: Code Modification on "InitDefaultValues(PROCEDURE 15)".

    //procedure InitDefaultValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UnitOfMeasureDefaultCode := 'PCS';
    UnitOfMeasure.SETRANGE(Code,UnitOfMeasureDefaultCode);

    IF NOT UnitOfMeasure.ISEMPTY THEN
      "Base Unit of Measure" := UnitOfMeasureDefaultCode;

    Type := Type::Service;
    "Costing Method" := "Costing Method"::FIFO;

    IF GenProductPostingGroup.FINDFIRST THEN
      "Gen. Prod. Posting Group" := GenProductPostingGroup.Code;

    IF VATProductPostingGroup.FINDFIRST THEN
      "VAT Prod. Posting Group" := VATProductPostingGroup.Code;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    "Costing Method" := "Costing Method"::Standard;
    #9..14
    */
    //end;
}

