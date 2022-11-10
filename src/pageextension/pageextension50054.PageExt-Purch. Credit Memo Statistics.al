pageextension 50054 pageextension50054 extends "Purch. Credit Memo Statistics"
{
    layout
    {
        addafter("Control 16")
        {
            field(DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
            }
            field(VendAmount+DecGMntHTDEEE; VendAmount+DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
            }
        }
    }

    var
        "--- TDL94.001 ---": Integer;
        DecGMntTTCDEEE: Decimal;
        DecGMntHTDEEE: Decimal;


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

        PurchCrMemoLine.SETRANGE("Document No.","No.");

        IF PurchCrMemoLine.FIND('-') THEN
          REPEAT
            VendAmount := VendAmount + PurchCrMemoLine.Amount;
            AmountInclVAT := AmountInclVAT + PurchCrMemoLine."Amount Including VAT";
            IF "Prices Including VAT" THEN
              InvDiscAmount := InvDiscAmount + PurchCrMemoLine."Inv. Discount Amount" / (1 + PurchCrMemoLine."VAT %" / 100)
            ELSE
              InvDiscAmount := InvDiscAmount + PurchCrMemoLine."Inv. Discount Amount";
            LineQty := LineQty + PurchCrMemoLine.Quantity;
            TotalNetWeight := TotalNetWeight + (PurchCrMemoLine.Quantity * PurchCrMemoLine."Net Weight");
            TotalGrossWeight := TotalGrossWeight + (PurchCrMemoLine.Quantity * PurchCrMemoLine."Gross Weight");
            TotalVolume := TotalVolume + (PurchCrMemoLine.Quantity * PurchCrMemoLine."Unit Volume");
            IF PurchCrMemoLine."Units per Parcel" > 0 THEN
              TotalParcels := TotalParcels + ROUND(PurchCrMemoLine.Quantity / PurchCrMemoLine."Units per Parcel",1,'>');
            IF PurchCrMemoLine."VAT %" <> VATPercentage THEN
              IF VATPercentage = 0 THEN
                VATPercentage := PurchCrMemoLine."VAT %"
              ELSE
                VATPercentage := -1;
          UNTIL PurchCrMemoLine.NEXT = 0;
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
        VendLedgEntry.SETRANGE("Document Type",VendLedgEntry."Document Type"::"Credit Memo");
        VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
        IF VendLedgEntry.FINDFIRST THEN
          AmountLCY := VendLedgEntry."Purchase (LCY)";

        IF NOT Vend.GET("Pay-to Vendor No.") THEN
          CLEAR(Vend);
        Vend.CALCFIELDS("Balance (LCY)");

        PurchCrMemoLine.CalcVATAmountLines(Rec,TempVATAmountLine);
        CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        CurrPage.SubForm.PAGE.InitGlobals("Currency Code",FALSE,FALSE,FALSE,FALSE,"VAT Base Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13

            //<<TDL94.001
            DecGMntHTDEEE:=DecGMntHTDEEE + PurchCrMemoLine."DEEE HT Amount";
            AmountInclVAT:=AmountInclVAT + PurchCrMemoLine."DEEE TTC Amount";
            //>>TDL94.001

        #14..30

        //<<TDL94.001
        VATAmount := AmountInclVAT - VendAmount - DecGMntHTDEEE ;
        //>>TDL94.001

        #31..37

        //>>TDL94.001
        {IF "Currency Code" = '' THEN
        #39..43
        }
        IF "Currency Code" = '' THEN
          AmountLCY := VendAmount + DecGMntHTDEEE
        ELSE
          AmountLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              WORKDATE,"Currency Code",VendAmount + DecGMntHTDEEE,"Currency Factor");

        //<<TDL94.001
        #44..58
        */
        //end;
}

