tableextension 50075 "BC6_BinContent" extends "Bin Content"
{

    //Unsupported feature: Code Modification on "CalcQtyAvailToTake(PROCEDURE 15)". //TODO: Check codeunit EventMGT procedure T7302_OnBeforeCalcQtyAvailToTake_BinContent

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
}

