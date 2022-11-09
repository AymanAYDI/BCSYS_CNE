pageextension 50056 pageextension50056 extends "Purchase Order Statistics"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 41".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 65".

        addafter("Total_General")
        {
            field(TotalPurchLine[1]."DEEE HT Amount";TotalPurchLine[1]."DEEE HT Amount")
            {
                Caption = 'Total DEEE';
            }
            field(TotalAmount1[1]+TotalPurchLine[1]."DEEE HT Amount";TotalAmount1[1]+TotalPurchLine[1]."DEEE HT Amount")
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("NoOfVATLines_General")
        {
            field(TotalPurchLineLCY[1]."DEEE HT Amount (LCY)";TotalPurchLineLCY[1]."DEEE HT Amount (LCY)")
            {
                Caption = 'Montant DEEE (DS)';
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        "-DEEE1.00-": Integer;
        DecGHTAmount: array [3] of Decimal;
        DecGVATAmount: array [3] of Decimal;
        DecGTTCAmount: array [3] of Decimal;
        DecGHTAmountLCY: array [3] of Decimal;

    //Unsupported feature: Variable Insertion (Variable: -MIGNAV2013-) (VariableCollection) on "RefreshOnAfterGetRecord(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: RecLVendor) (VariableCollection) on "RefreshOnAfterGetRecord(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "RefreshOnAfterGetRecord(PROCEDURE 11)".

    //procedure RefreshOnAfterGetRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));

        IF PrevNo = "No." THEN
          EXIT;
        PrevNo := "No.";
        FILTERGROUP(2);
        SETRANGE("No.",PrevNo);
        FILTERGROUP(0);

        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);

        FOR i := 1 TO 3 DO BEGIN
          TempPurchLine.DELETEALL;
          CLEAR(TempPurchLine);
          CLEAR(PurchPost);
          PurchPost.GetPurchLines(Rec,TempPurchLine,i - 1);
          CLEAR(PurchPost);
          CASE i OF
            1:
              PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine1);
            2:
              PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine2);
            3:
              PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine3);
          END;

          PurchPost.SumPurchLinesTemp(
            Rec,TempPurchLine,i - 1,TotalPurchLine[i],TotalPurchLineLCY[i],
            VATAmount[i],VATAmountText[i]);
          IF "Prices Including VAT" THEN BEGIN
            TotalAmount2[i] := TotalPurchLine[i].Amount;
            TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
            TotalPurchLine[i]."Line Amount" := TotalAmount1[i] + TotalPurchLine[i]."Inv. Discount Amount";
          END ELSE BEGIN
            TotalAmount1[i] := TotalPurchLine[i].Amount;
            TotalAmount2[i] := TotalPurchLine[i]."Amount Including VAT";
          END;
        END;
        TempPurchLine.DELETEALL;
        CLEAR(TempPurchLine);
        PurchPostPrepayments.GetPurchLines(Rec,0,TempPurchLine);
        PurchPostPrepayments.SumPrepmt(
          Rec,TempPurchLine,TempVATAmountLine4,PrepmtTotalAmount,PrepmtVATAmount,PrepmtVATAmountText);
        PrepmtInvPct :=
          Pct(TotalPurchLine[1]."Prepmt. Amt. Inv.",PrepmtTotalAmount);
        PrepmtDeductedPct :=
          Pct(TotalPurchLine[1]."Prepmt Amt Deducted",TotalPurchLine[1]."Prepmt. Amt. Inv.");
        IF "Prices Including VAT" THEN BEGIN
          PrepmtTotalAmount2 := PrepmtTotalAmount;
          PrepmtTotalAmount := PrepmtTotalAmount + PrepmtVATAmount;
        END ELSE
          PrepmtTotalAmount2 := PrepmtTotalAmount + PrepmtVATAmount;

        IF Vend.GET("Pay-to Vendor No.") THEN
          Vend.CALCFIELDS("Balance (LCY)")
        ELSE
          CLEAR(Vend);

        TempVATAmountLine1.MODIFYALL(Modified,FALSE);
        TempVATAmountLine2.MODIFYALL(Modified,FALSE);
        TempVATAmountLine3.MODIFYALL(Modified,FALSE);
        TempVATAmountLine4.MODIFYALL(Modified,FALSE);

        PrevTab := -1;
        UpdateHeaderInfo(2,TempVATAmountLine2);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..27
          //>>DEEE1.00
          //<<MIGRATION NAV 2013 - 2017
          {PurchPost.SumPurchLinesTemp(
            Rec,TempPurchLine,i - 1,TotalPurchLine[i],TotalPurchLineLCY[i],
            VATAmount[i],VATAmountText[i]);}
          PurchPost.SumPurchLinesTemp(
            Rec,TempPurchLine,i - 1,TotalPurchLine[i],TotalPurchLineLCY[i],
            VATAmount[i],VATAmountText[i],
            DecGHTAmount[i],DecGVATAmount[i],DecGTTCAmount[i],DecGHTAmountLCY[i]) ;
          //>>DEEE1.00
          //<<MIGRATION NAV 2013 - 2017

        #32..38
            //>>MIGRATION NAV 2013
            //<<DEEE1.00
            TotalAmount2[i] :=TotalAmount2[i]+DecGTTCAmount[i] ;
            //>>DEEE1.00
            //<<MIGRATION NAV 2013
        #39..67
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: -MIGNAV2013-) (VariableCollection) on "UpdateHeaderInfo(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: --- TDL94 ---) (VariableCollection) on "UpdateHeaderInfo(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: RecLVendor) (VariableCollection) on "UpdateHeaderInfo(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "UpdateHeaderInfo(PROCEDURE 5)".

    //procedure UpdateHeaderInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TotalPurchLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1[IndexNo] :=
          TotalPurchLine[IndexNo]."Line Amount" - TotalPurchLine[IndexNo]."Inv. Discount Amount";
        VATAmount[IndexNo] := VATAmountLine.GetTotalVATAmount;
        IF "Prices Including VAT" THEN BEGIN
          TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
          TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
          TotalPurchLine[IndexNo]."Line Amount" :=
            TotalAmount1[IndexNo] + TotalPurchLine[IndexNo]."Inv. Discount Amount";
        END ELSE
          TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];

        IF "Prices Including VAT" THEN
          TotalPurchLineLCY[IndexNo].Amount := TotalAmount2[IndexNo]
        ELSE
          TotalPurchLineLCY[IndexNo].Amount := TotalAmount1[IndexNo];
        IF "Currency Code" <> '' THEN BEGIN
          IF "Posting Date" = 0D THEN
            UseDate := WORKDATE
          ELSE
            UseDate := "Posting Date";

          TotalPurchLineLCY[IndexNo].Amount :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              UseDate,"Currency Code",TotalPurchLineLCY[IndexNo].Amount,"Currency Factor");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4

        //>>MIGRATION NAV 2013
        //<<DEEE1.00 : update header value (F9 with clic)
        CLEAR(DecGHTAmount) ;
        CLEAR(DecGVATAmount) ;
        CLEAR(DecGTTCAmount) ;
        CLEAR(DecGHTAmountLCY) ;

        //IF VATAmountLine."Is Line Submitted"=2 THEN BEGIN
          //DecGHTAmount[IndexNo]:=VATAmountLine.GetTotalHTDEEEAmount
          DecGVATAmount[IndexNo]:=VATAmountLine.GetTotalVATDEEEAmount ;
          DecGTTCAmount[IndexNo]:=VATAmountLine.GetTotalAmountDEEEInclVAT ;
          VATAmount[IndexNo]:=VATAmount[IndexNo]+DecGVATAmount[IndexNo] ;
        //END ;
        //>>DEEE1.00 : update header value (F9 with clic)
        //<<MIGRATION NAV 2013

        #5..10

          //>>MIGRATION NAV 2013
          // TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo]; //STD CODE
          //<<DEEE1.00 : update header value (F9 with clic)
          BEGIN
          TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo]; //standard
          //IF VATAmountLine."Is Line Submitted"=2 THEN
            TotalAmount2[IndexNo] := TotalAmount2[IndexNo] +DecGTTCAmount[IndexNo]-DecGVATAmount[IndexNo] ;
          //>>DEEE1.00 : update header value (F9 with clic)
          END ;
          //<<MIRATION NAV 213
        #12..25

        //>>MIGRATION NAV 2013
        //<<DEEE1.00 : update DEEE amount (LCY)
        TotalPurchLineLCY[IndexNo]."DEEE HT Amount (LCY)":=
            CurrExchRate.ExchangeAmtFCYToLCY(
              UseDate,"Currency Code",TotalPurchLineLCY[IndexNo]."DEEE HT Amount","Currency Factor");
        //>>DEEE1.00 : update DEEE amount (LCY)
        //<<MIGRATION NAV 2013
        END;
        */
    //end;
}

