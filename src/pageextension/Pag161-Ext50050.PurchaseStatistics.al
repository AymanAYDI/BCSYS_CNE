pageextension 50050 "BC6_PurchaseStatistics" extends "Purchase Statistics" //161
{
    layout
    {
        //TODO: check ligne 5 // Unsupported feature: Property Modification (SourceExpr) on "Control 3".
        modify("TotalPurchLineLCY.Amount")
        {
            Visible = false;
        }
        addafter(TotalAmount2)
        {
            field("Purchase (LCY)"; TotalPurchLineLCY.Amount + TotalPurchLine."BC6_DEEE HT Amount")
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Purchase (LCY)';
                Editable = false;
                ToolTip = 'Specifies your total purchases. It is calculated from amounts excluding VAT on all completed and open purchase invoices and credit memos.';
            }
        }
        addafter("TotalPurchLineLCY.Amount")
        {
            field("BC6_DEEE HT Amount (LCY)"; TotalPurchLineLCY."BC6_DEEE HT Amount (LCY)")
            {
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = Basic, Suite;

            }
            field("BC6_DEEE HT Amount"; TotalPurchLine."BC6_DEEE HT Amount")
            {
                Caption = 'Total DEEE';
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;

            }
            field("DEEE.HT.Amount"; TotalAmount1 + TotalPurchLine."BC6_DEEE HT Amount")
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
                ApplicationArea = Basic, Suite;

            }
        }
    }

    var
        DecGHTAmount: Decimal;
        DecGVATAmount: Decimal;
        DecGTTCAmount: Decimal;
        DecGHTAmountLCY: Decimal;




    //Unsupported feature: Code Modification on "UpdateHeaderInfo(PROCEDURE 5)".

    //procedure UpdateHeaderInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalPurchLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount;
    TotalAmount1 :=
      TotalPurchLine."Line Amount" - TotalPurchLine."Inv. Discount Amount";
    VATAmount := TempVATAmountLine.GetTotalVATAmount;
    IF "Prices Including VAT" THEN BEGIN
      TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT;
      TotalAmount2 := TotalAmount1 - VATAmount;
      TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
    END ELSE
      TotalAmount2 := TotalAmount1 + VATAmount;

    IF "Prices Including VAT" THEN
      TotalPurchLineLCY.Amount := TotalAmount2
    ELSE
      TotalPurchLineLCY.Amount := TotalAmount1;
    IF "Currency Code" <> '' THEN BEGIN
      IF ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
         ("Posting Date" = 0D)
      THEN
        UseDate := WORKDATE
      ELSE
        UseDate := "Posting Date";

      TotalPurchLineLCY.Amount :=
        CurrExchRate.ExchangeAmtFCYToLCY(
          UseDate,"Currency Code",TotalPurchLineLCY.Amount,"Currency Factor");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    //>>MIGRATION NAV 2013

    //<<DEEE1.00
    //DecgHTAmount[IndexNo]:=tempVATAmountLine.GetTotalHTDEEEAmount
    DecGVATAmount:=TempVATAmountLine.GetTotalVATDEEEAmount ;
    DecGTTCAmount:=TempVATAmountLine.GetTotalAmountDEEEInclVAT ;
    VATAmount:=VATAmount+DecGVATAmount ;
    //>>DEEE1.00
    //<<MIGRATION NAV 2013

    #5..9
      //>>MIGRATION NAV 2013

      //STD TotalAmount2 := TotalAmount1 + VATAmount;
      //<<DEEE1.00
      BEGIN
      TotalAmount2 := TotalAmount1 + VATAmount; //standard
      TotalAmount2 := TotalAmount2 + DecGTTCAmount-DecGVATAmount ;
      END ;
      //>>DEEE1.00

      //<<MIGRATION NAV 2013


    #11..26

    //>>MIGRATION NAV 2013

    //<<DEEE1.00
    TotalPurchLineLCY."DEEE HT Amount (LCY)":=
        CurrExchRate.ExchangeAmtFCYToLCY(
          UseDate,"Currency Code",TotalPurchLine."DEEE HT Amount","Currency Factor");
    //>>DEEE1.00

    //<<MIGRATION NAV 2013
    END;
    */
    //end;
}

