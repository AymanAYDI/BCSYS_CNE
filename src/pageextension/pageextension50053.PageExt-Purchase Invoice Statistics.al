pageextension 50053 pageextension50053 extends "Purchase Invoice Statistics"
{
    layout
    {
        addafter("Control 16")
        {
            field(DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field(VendAmount+DecGMntHTDEEE; VendAmount+DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
            }
        }
    }

    var
        "--- TDL94.001 ---": Integer;
        DecGMntHTDEEE: Decimal;
        DecGMntTTCDEEE: Decimal;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEARALL;

        IF "Currency Code" = '' THEN
          Currency.InitRoundingPrecision
        ELSE
          Currency.GET("Currency Code");

        PurchInvLine.SETRANGE("Document No.","No.");

        IF PurchInvLine.FIND('-') THEN
          REPEAT
            VendAmount := VendAmount + PurchInvLine.Amount;
            AmountInclVAT := AmountInclVAT + PurchInvLine."Amount Including VAT";
            IF "Prices Including VAT" THEN
              InvDiscAmount := InvDiscAmount + PurchInvLine."Inv. Discount Amount" / (1 + PurchInvLine."VAT %" / 100)
            ELSE
              InvDiscAmount := InvDiscAmount + PurchInvLine."Inv. Discount Amount";
            LineQty := LineQty + PurchInvLine.Quantity;
            TotalNetWeight := TotalNetWeight + (PurchInvLine.Quantity * PurchInvLine."Net Weight");
            TotalGrossWeight := TotalGrossWeight + (PurchInvLine.Quantity * PurchInvLine."Gross Weight");
            TotalVolume := TotalVolume + (PurchInvLine.Quantity * PurchInvLine."Unit Volume");
            IF PurchInvLine."Units per Parcel" > 0 THEN
              TotalParcels := TotalParcels + ROUND(PurchInvLine.Quantity / PurchInvLine."Units per Parcel",1,'>');
            IF PurchInvLine."VAT %" <> VATPercentage THEN
              IF VATPercentage = 0 THEN
                VATPercentage := PurchInvLine."VAT %"
              ELSE
                VATPercentage := -1;
          UNTIL PurchInvLine.NEXT = 0;
        VATAmount := AmountInclVAT - VendAmount;
        InvDiscAmount := ROUND(InvDiscAmount,Currency."Amount Rounding Precision");

        IF VATPercentage <= 0 THEN
          VATAmountText := Text000
        ELSE
          VATAmountText := STRSUBSTNO(Text001,VATPercentage);

        IF "Currency Code" = '' THEN
          AmountLCY := VendAmount
        ELSE
          AmountLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              WORKDATE,"Currency Code",VendAmount,"Currency Factor");

        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.","No.");
        VendLedgEntry.SETRANGE("Document Type",VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
        IF VendLedgEntry.FINDFIRST THEN
          AmountLCY := VendLedgEntry."Purchase (LCY)";

        IF NOT Vend.GET("Pay-to Vendor No.") THEN
          CLEAR(Vend);
        Vend.CALCFIELDS("Balance (LCY)");

        PurchInvLine.CalcVATAmountLines(Rec,TempVATAmountLine);
        CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        CurrPage.SubForm.PAGE.InitGlobals("Currency Code",FALSE,FALSE,FALSE,FALSE,"VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13

            //>>MIGRATION NAV 2013

            //<<TDL94.001
            DecGMntTTCDEEE:=DecGMntTTCDEEE + PurchInvLine."DEEE TTC Amount";
            DecGMntHTDEEE:=DecGMntHTDEEE + PurchInvLine."DEEE HT Amount";
            AmountInclVAT:=AmountInclVAT + PurchInvLine."DEEE TTC Amount"  ;
            //>>TDL94.001

            //<<MIGRATION NAV 2013
        #14..30

        //>>MIGRATION NAV 2013

        //<<TDL94.001
        VATAmount := AmountInclVAT - VendAmount - DecGMntHTDEEE ;
        //>>TDL94.001

        //<<MIGRATION NAV 2013

        #31..37
        //>>MIGRATION NAV 2013

        //>>TDL94.001
        //>>STD
        {IF "Currency Code" = '' THEN
        #39..43
        }
        //<<STD
        IF "Currency Code" = '' THEN
          AmountLCY := VendAmount + DecGMntHTDEEE
        ELSE
          AmountLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              WORKDATE,"Currency Code",VendAmount+ DecGMntHTDEEE,"Currency Factor");
        //<<TDL94.001

        //<<MIGRATION NAV 2013

        #44..58
        */
        //end;
}

