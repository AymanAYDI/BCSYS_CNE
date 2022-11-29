pageextension 50149 "BC6_SalesStatistics" extends "Sales Statistics" //160
{
    layout
    {
        modify(AdjProfitLCY)
        {
            Visible = ShowRealProfit;
            Caption = 'Total DEEE', comment = 'FRA="Marge relle DS"';

        }
        modify(AdjProfitPct)
        {
            Visible = ShowRealProfit;
            Caption = 'Total DEEE', comment = 'FRA="% Marge relle DS"';
        }
        modify(TotalAdjCostLCY)
        {
            Visible = ShowRealProfit;
            Caption = 'Adjusted Cost (LCY)', comment = 'FRA="Coùt réel DS"';
        }

        modify("TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        addafter("TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            field(BC6_Purchase_Cost; TotalSalesLineLCY."BC6_Purchase cost")
            {
                Caption = 'Purchase Cost (LCY)', comment = 'FRA="Coùt d''achat DS"';
            }

        }
        addafter("TotalSalesLine.""Unit Volume""")
        {
            field(BC6_Montant_DEEE; TotalSalesLineLCY."BC6_DEEE HT Amount (LCY)")
            {
                Caption = 'Montant DEEE (DS)';
            }
        }
        addafter(TotalAmount1)
        {
            field(BC6_Total_DEEE; TotalSalesLine."BC6_DEEE HT Amount")
            {
                Caption = 'Total DEEE';
            }
            field("Total_HT_DEEE"; TotalAmount1 + TotalSalesLine."BC6_DEEE HT Amount")
            {
                Caption = 'Total HT DEEE comprise';

            }
        }

    }
    trigger OnOpenPage()
    begin
        ShowRealProfit := FALSE;
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."BC6_Aut. Real Sales Profit %" THEN
                ShowRealProfit := TRUE;
    end;

    var
        UserSetup: Record "User Setup";
        RecGCustomer: Record Customer;
        [INDATASET]
        ShowRealProfit: Boolean;
        DecGTTCAmount: Decimal;
        DecGVATAmount: Decimal;

    //TODO UpdateHeaderInfo // Araxis ligne 467
    //TODO CalculateTotals // Araxis ligne  74 

    LOCAL PROCEDURE UpdateHeaderInfo();
    VAR
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    BEGIN
        TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount();
        TotalAmount1 :=
          TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount();


        RecGCustomer.GET("Sell-to Customer No.");
        IF RecGCustomer."BC6_Submitted to DEEE" THEN BEGIN
            DecGVATAmount := TempVATAmountLine.GetTotalVATDEEEAmount();
            DecGTTCAmount := TempVATAmountLine.GetTotalAmountDEEEInclVAT();
            VATAmount := VATAmount + DecGVATAmount;
        END ELSE BEGIN
            TotalSalesLineLCY."BC6_DEEE HT Amount (LCY)" := 0;
            TotalSalesLine."BC6_DEEE HT Amount" := 0;
            DecGVATAmount := 0;
            DecGTTCAmount := 0;
        END;


        IF "Prices Including VAT" THEN BEGIN
            TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT();
            TotalAmount2 := TotalAmount1 - VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount2 := TotalAmount1 + VATAmount; //standard
            TotalAmount2 := TotalAmount2 + DecGTTCAmount - DecGVATAmount;
        END;
        IF "Prices Including VAT" THEN
            TotalSalesLineLCY.Amount := TotalAmount2
        ELSE
            TotalSalesLineLCY.Amount := TotalAmount1;
        IF "Currency Code" <> '' THEN BEGIN
            IF ("Document Type" IN ["Document Type"::"Blanket Order", "Document Type"::Quote]) AND
               ("Posting Date" = 0D)
            THEN
                UseDate := WORKDATE()
            ELSE
                UseDate := "Posting Date";

            TotalSalesLineLCY.Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, "Currency Code", TotalSalesLineLCY.Amount, "Currency Factor");
            TotalSalesLineLCY."BC6_DEEE HT Amount (LCY)" :=
                CurrExchRate.ExchangeAmtFCYToLCY(
                  UseDate, "Currency Code", TotalSalesLine."BC6_DEEE HT Amount", "Currency Factor");

        END;
        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."BC6_Purchase cost";

        IF TotalSalesLineLCY.Amount = 0 THEN
            ProfitPct := 0
        ELSE
            ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount, 0.01);

        AdjProfitLCY := TotalSalesLineLCY.Amount - TotalAdjCostLCY;
        IF TotalSalesLineLCY.Amount = 0 THEN
            AdjProfitPct := 0
        ELSE
            AdjProfitPct := ROUND(100 * AdjProfitLCY / TotalSalesLineLCY.Amount, 0.01);
    END;

    local procedure GetVATSpecification()
    begin
        CurrPage.SubForm.PAGE.GetTempVATAmountLine(TempVATAmountLine);
        if TempVATAmountLine.GetAnyLineModified() then
            UpdateHeaderInfo();
    end;

    protected procedure UpdateInvDiscAmount()
    var
        InvDiscBaseAmount: Decimal;
        Text003: Label '%1 must not be 0.';
        Text004: Label '%1 must not be greater than %2.';
    begin
        //TODO CheckAllowInvDisc();
        InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(false, "Currency Code");
        if InvDiscBaseAmount = 0 then
            Error(Text003, TempVATAmountLine.FieldCaption("Inv. Disc. Base Amount"));

        if TotalSalesLine."Inv. Discount Amount" / InvDiscBaseAmount > 1 then
            Error(
              Text004,
              TotalSalesLine.FieldCaption("Inv. Discount Amount"),
              TempVATAmountLine.FieldCaption("Inv. Disc. Base Amount"));

        TempVATAmountLine.SetInvoiceDiscountAmount(
          TotalSalesLine."Inv. Discount Amount", Rec."Currency Code", Rec."Prices Including VAT", Rec."VAT Base Discount %");
        CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        UpdateHeaderInfo();

        Rec."Invoice Discount Calculation" := Rec."Invoice Discount Calculation"::Amount;
        Rec."Invoice Discount Value" := TotalSalesLine."Inv. Discount Amount";
        Rec.Modify();
        UpdateVATOnSalesLines();
    end;

    local procedure CalculateTotals()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        DecGHTAmount: Decimal;
        DecGHTAmountLCY: Decimal;

    begin
        Clear(SalesLine);
        Clear(TotalSalesLine);
        Clear(TotalSalesLineLCY);
        Clear(SalesPost);
        SalesPost.GetSalesLines(Rec, TempSalesLine, 0);
        Clear(SalesPost);

        //TODO:FCT IN COD80//  SalesPost.SetIncrPurchCost(TRUE);
        //TODO:FCT IN COD378// SalesPost.SumSalesLinesTemp(
        //   Rec, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
        //   VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY,
        //   DecGHTAmount, DecGVATAmount, DecGTTCAmount, DecGHTAmountLCY);

        RecGCustomer.GET("Sell-to Customer No.");
        IF NOT RecGCustomer."BC6_Submitted to DEEE" THEN BEGIN
            DecGHTAmount := 0;
            DecGVATAmount := 0;
            DecGTTCAmount := 0;
            DecGHTAmountLCY := 0;
        END;


        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."BC6_Purchase cost";
        IF TotalSalesLineLCY.Amount = 0 THEN
            ProfitPct := 0
        ELSE
            ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount, 0.01);
        AdjProfitLCY := TotalSalesLineLCY.Amount - TotalAdjCostLCY;
        if TotalSalesLineLCY.Amount <> 0 then
            AdjProfitPct := Round(AdjProfitLCY / TotalSalesLineLCY.Amount * 100, 0.1);
        if Rec."Prices Including VAT" then begin
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        end else begin
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
            TotalAmount2 := TotalAmount2 + DecGTTCAmount;
        end;

        if Cust.Get(Rec."Bill-to Customer No.") then
            Cust.CalcFields("Balance (LCY)")
        else
            Clear(Cust);
        if Cust."Credit Limit (LCY)" = 0 then
            CreditLimitLCYExpendedPct := 0
        else
            if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 then
                CreditLimitLCYExpendedPct := 0
            else
                if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 then
                    CreditLimitLCYExpendedPct := 10000
                else
                    CreditLimitLCYExpendedPct := Round(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine);
        TempVATAmountLine.ModifyAll(Modified, false);
        SetVATSpecification();
    end;

    local procedure SetVATSpecification()
    begin
        CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        CurrPage.SubForm.PAGE.InitGlobals(
          Rec."Currency Code", AllowVATDifference, AllowVATDifference,
          Rec."Prices Including VAT", AllowInvDisc, Rec."VAT Base Discount %");
    end;



}

