tableextension 50054 "BC6_OpportunityEntry" extends "Opportunity Entry"
{


    //Unsupported feature: Code Modification on "GetSalesDocValue(PROCEDURE 4)". TODO: 

    //procedure GetSalesDocValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesPost.SumSalesLines(
      SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
      VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY);
    EXIT(TotalSalesLineLCY.Amount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesPost.SumSalesLines(
      SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
      VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY,
      //>>MIGRATION NAV 2013
      //DEEE
      TotalSalesLine."DEEE HT Amount",TotalSalesLine."DEEE VAT Amount",
      TotalSalesLine."DEEE TTC Amount",TotalSalesLine."DEEE HT Amount (LCY)");
      //FIN DEEE
      //<<MIGRATION NAV 2013
    EXIT(TotalSalesLineLCY.Amount);
    */
    //end;

}

