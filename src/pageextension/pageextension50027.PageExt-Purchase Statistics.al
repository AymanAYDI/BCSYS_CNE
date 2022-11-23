pageextension 50027 pageextension50027 extends "Purchase Statistics"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 3".

        addafter("Control 3")
        {
            field(TotalPurchLineLCY."DEEE HT Amount (LCY)";
                TotalPurchLineLCY."DEEE HT Amount (LCY)")
            {
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                Visible = false;
            }
            field(TotalPurchLine."DEEE HT Amount";
                TotalPurchLine."DEEE HT Amount")
            {
                Caption = 'Total DEEE';
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field(TotalAmount1+TotalPurchLine."DEEE HT Amount"; TotalAmount1+TotalPurchLine."DEEE HT Amount")
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
            }
        }
    }

    var
        "-DEEE1.00-": Integer;
        DecGHTAmount: Decimal;
        DecGVATAmount: Decimal;
        DecGTTCAmount: Decimal;
        DecGHTAmountLCY: Decimal;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));
        IF PrevNo = "No." THEN BEGIN
          GetVATSpecification;
          EXIT;
        END;
        PrevNo := "No.";
        FILTERGROUP(2);
        SETRANGE("No.",PrevNo);
        FILTERGROUP(0);
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);
        CLEAR(PurchPost);

        PurchPost.GetPurchLines(Rec,TempPurchLine,0);
        CLEAR(PurchPost);
        PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText);

        IF "Prices Including VAT" THEN BEGIN
          TotalAmount2 := TotalPurchLine.Amount;
          TotalAmount1 := TotalAmount2 + VATAmount;
          TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
          TotalAmount1 := TotalPurchLine.Amount;
          TotalAmount2 := TotalPurchLine."Amount Including VAT";
        END;

        IF Vend.GET("Pay-to Vendor No.") THEN
          Vend.CALCFIELDS("Balance (LCY)")
        ELSE
          CLEAR(Vend);

        PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified,FALSE);
        SetVATSpecification;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
        //>>MIGRATION NAV 2013
        //OLD
        {
        #15..18
        }
        //NEW
        //<<DEEE1.00
        {PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText);}

        PurchPost.GetPurchLines(Rec,TempPurchLine,0);
        CLEAR(PurchPost);
        PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText,
          DecGHTAmount,DecGVATAmount,DecGTTCAmount,DecGHTAmountLCY) ;

        //>>DEEE1.00
        //<<MIGRATION NAV2013

        #19..26

        //>>MIGRATION NAV2013
          //<<DEEE1.00
          TotalAmount2 :=TotalAmount2+DecGTTCAmount ;
          //>>DEEE1.00
        //<<MIGRATION NAV2013

        #27..36
        */
        //end;


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

