pageextension 50034 pageextension50034 extends "Apply Customer Entries"
{
    layout
    {
        addafter("Control 6")
        {
            field("Pay-to Customer No."; "Pay-to Customer No.")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(getCustomerName("Pay-to Customer No."); getCustomerName("Pay-to Customer No."))
            {
                Caption = 'Pay-to cust. Name';
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }

    var
        "--MIGNAV2013--": ;
        "--NSC1.00--": ;
        TextGestTierPayeur001: Label 'There is no ledger entries.';


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CalcType = CalcType::Direct THEN BEGIN
          Cust.GET("Customer No.");
          ApplnCurrencyCode := Cust."Currency Code";
          FindApplyingEntry;
        END;

        AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";

        GLSetup.GET;

        IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
          CalcApplnAmount;
        PostingDone := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CalcType = CalcType::Direct THEN BEGIN

          //>>MIGRATION NAV 2013
          //Cust.GET("Customer No.");

          //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pour aller chercher le Tiers payeur
          //std Cust.GET("Customer No.");
          IF NOT Cust.GET("Customer No.") AND NOT Cust.GET("Pay-to Customer No.") THEN ERROR(TextGestTierPayeur001);
          //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pour aller chercher le Tiers payeur

          //<<MIGRATION NAV 2013

        #3..13
        */
        //end;


        //Unsupported feature: Code Modification on "SetSales(PROCEDURE 2)".

        //procedure SetSales();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesHeader := NewSalesHeader;
        COPYFILTERS(NewCustLedgEntry);

        SalesPost.SumSalesLines(
          SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY);

        CASE SalesHeader."Document Type" OF
          SalesHeader."Document Type"::"Return Order",
          SalesHeader."Document Type"::"Credit Memo":
            ApplyingAmount := -TotalSalesLine."Amount Including VAT"
          ELSE
            ApplyingAmount := TotalSalesLine."Amount Including VAT";
        END;

        ApplnDate := SalesHeader."Posting Date";
        ApplnCurrencyCode := SalesHeader."Currency Code";
        CalcType := CalcType::SalesHeader;

        CASE ApplnTypeSelect OF
          SalesHeader.FIELDNO("Applies-to Doc. No."):
            ApplnType := ApplnType::"Applies-to Doc. No.";
          SalesHeader.FIELDNO("Applies-to ID"):
            ApplnType := ApplnType::"Applies-to ID";
        END;

        SetApplyingCustLedgEntry;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesHeader := NewSalesHeader;
        COPYFILTERS(NewCustLedgEntry);
        //>>MIGRATION NAV 2013
        //STD
        {
        #4..6
        }
        //NEW
        SalesPost.SumSalesLines(
          SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY,
          //DEEE
          TotalSalesLine."DEEE HT Amount",TotalSalesLine."DEEE VAT Amount",
          TotalSalesLine."DEEE TTC Amount",TotalSalesLine."DEEE HT Amount (LCY)");
          //FIN DEEE
        //<<MIGRATION NAV 2013
        #8..27
        */
        //end;


        //Unsupported feature: Code Modification on "CalcApplnAmount(PROCEDURE 4)".

        //procedure CalcApplnAmount();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := FALSE;

        CASE CalcType OF
          CalcType::Direct:
            BEGIN
              FindAmountRounding;
              CustEntryApplID := USERID;
              IF CustEntryApplID = '' THEN
                CustEntryApplID := '***';

              CustLedgEntry := ApplyingCustLedgEntry;

              AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
              AppliedCustLedgEntry.SETRANGE("Customer No.","Customer No.");
              AppliedCustLedgEntry.SETRANGE(Open,TRUE);
              AppliedCustLedgEntry.SETRANGE("Applies-to ID",CustEntryApplID);

              IF ApplyingCustLedgEntry."Entry No." <> 0 THEN BEGIN
                CustLedgEntry.CALCFIELDS("Remaining Amount");
                AppliedCustLedgEntry.SETFILTER("Entry No.",'<>%1',ApplyingCustLedgEntry."Entry No.");
              END;

              HandlChosenEntries(0,
                CustLedgEntry."Remaining Amount",
                CustLedgEntry."Currency Code",
                CustLedgEntry."Posting Date");
            END;
          CalcType::GenJnlLine:
            BEGIN
              FindAmountRounding;
              IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN
                CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",GenJnlLine);

              CASE ApplnType OF
                ApplnType::"Applies-to Doc. No.":
                  BEGIN
                    AppliedCustLedgEntry := Rec;
                    WITH AppliedCustLedgEntry DO BEGIN
                      CALCFIELDS("Remaining Amount");
                      IF "Currency Code" <> ApplnCurrencyCode THEN BEGIN
                        "Remaining Amount" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");
                        "Remaining Pmt. Disc. Possible" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Pmt. Disc. Possible");
                        "Amount to Apply" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Amount to Apply");
                      END;

                      IF "Amount to Apply" <> 0 THEN
                        AppliedAmount := ROUND("Amount to Apply",AmountRoundingPrecision)
                      ELSE
                        AppliedAmount := ROUND("Remaining Amount",AmountRoundingPrecision);

                      IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(
                           GenJnlLine,AppliedCustLedgEntry,0,FALSE) AND
                         ((ABS(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                           ABS(AppliedAmount - "Remaining Pmt. Disc. Possible")) OR
                          (GenJnlLine.Amount = 0))
                      THEN
                        PmtDiscAmount := "Remaining Pmt. Disc. Possible";

                      IF NOT DifferentCurrenciesInAppln THEN
                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";
                    END;
                    CheckRounding;
                  END;
                ApplnType::"Applies-to ID":
                  BEGIN
                    GenJnlLine2 := GenJnlLine;
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                    AppliedCustLedgEntry.SETRANGE("Customer No.",GenJnlLine."Account No.");
                    AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                    AppliedCustLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");

                    HandlChosenEntries(1,
                      GenJnlLine2.Amount,
                      GenJnlLine2."Currency Code",
                      GenJnlLine2."Posting Date");
                  END;
              END;
            END;
          CalcType::SalesHeader,CalcType::ServHeader:
            BEGIN
              FindAmountRounding;

              CASE ApplnType OF
                ApplnType::"Applies-to Doc. No.":
                  BEGIN
                    AppliedCustLedgEntry := Rec;
                    WITH AppliedCustLedgEntry DO BEGIN
                      CALCFIELDS("Remaining Amount");

                      IF "Currency Code" <> ApplnCurrencyCode THEN
                        "Remaining Amount" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");

                      AppliedAmount := ROUND("Remaining Amount",AmountRoundingPrecision);

                      IF NOT DifferentCurrenciesInAppln THEN
                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";
                    END;
                    CheckRounding;
                  END;
                ApplnType::"Applies-to ID":
                  BEGIN
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                    IF CalcType = CalcType::SalesHeader THEN
                      AppliedCustLedgEntry.SETRANGE("Customer No.",SalesHeader."Bill-to Customer No.")
                    ELSE
                      AppliedCustLedgEntry.SETRANGE("Customer No.",ServHeader."Bill-to Customer No.");
                    AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                    AppliedCustLedgEntry.SETRANGE("Applies-to ID",GetAppliesToID);

                    HandlChosenEntries(2,
                      ApplyingAmount,
                      ApplnCurrencyCode,
                      ApplnDate);
                  END;
              END;
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..74

                    //>>MIGRATION NAV 2013
                    //STD
                    {
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                    AppliedCustLedgEntry.SETRANGE("Customer No.",GenJnlLine."Account No.");
                    }
                    //STD
                    //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Remplacement du "Customer No." par "Pay-to Customer No."
                                //std AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                                //std AppliedCustLedgEntry.SETRANGE("Customer No.",GenJnlLine."Account No.");
                                AppliedCustLedgEntry.SETCURRENTKEY("Pay-to Customer No.",Open,Positive);
                                AppliedCustLedgEntry.SETRANGE("Pay-to Customer No.",GenJnlLine."Account No.");
                    //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Remplacement du "Customer No." par "Pay-to Customer No."
                    //<<MIGRATION NAV 2013

        #77..127
        */
        //end;
}

