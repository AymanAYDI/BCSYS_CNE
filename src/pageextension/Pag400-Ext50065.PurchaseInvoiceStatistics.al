pageextension 50065 "BC6_PurchaseInvoiceStatistics" extends "Purchase Invoice Statistics" //400
{
    layout
    {
        modify(VATAmount)
        {
            Visible = false;
        }
        addafter(VATAmount)
        {
            field(BC6_VATAmount2; NewVATAmount)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
                CaptionClass = '3,' + Format(NewVATAmountText);
                Caption = 'VAT Amount';
                ToolTip = 'Specifies the total VAT amount that has been calculated for all the lines in the purchase document.';
            }
        }

        modify(AmountLCY)
        {
            Visible = false;
        }
        addafter(AmountLCY)
        {
            field(BC6_AmountLCY2; NewAmountLCY)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Purchase (LCY)';
                ToolTip = 'Specifies your total purchases.';
            }
        }
        addafter(VATAmount)
        {
            field(BC6_DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("VendAmount+DecGMntHTDEEE"; NewVendAmount + DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        DecGMntHTDEEE: Decimal;
        DecGMntTTCDEEE: Decimal;
        NewAmountInclVAT: Decimal;
        NewAmountLCY: Decimal;
        NewVATAmount: Decimal;
        NewVATPercentage: Decimal;
        NewVendAmount: Decimal;
        NewVATAmountText: Text[30];

    procedure IncrementDecGMntHTDEEE(pDecGMntHTDEEE: Decimal)
    begin
        DecGMntHTDEEE += pDecGMntHTDEEE;
    end;

    procedure IncrementDecGMntTTCDEEE(pDecGMntTTCDEEE: Decimal)
    begin
#pragma warning disable AA0206
        DecGMntTTCDEEE += pDecGMntTTCDEEE;
    end;

    procedure SetNewVendAmount(pNewVendAmount: Decimal)
    begin
        NewVendAmount := pNewVendAmount;
    end;

    procedure SetNewAmountInclVAT(pNewAmountInclVAT: Decimal)
    begin
        NewAmountInclVAT := pNewAmountInclVAT;
    end;

    procedure SetNewVATPercentage(pNewVATPercentage: Decimal)
    begin
        NewVATPercentage := pNewVATPercentage;
    end;

    trigger OnAfterGetRecord()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        Text000: Label 'VAT Amount';
        Text001: Label '%1% VAT';
    begin
        NewVATAmount := NewAmountInclVAT - NewVendAmount - DecGMntHTDEEE;

        if NewVATPercentage <= 0 then
            NewVATAmountText := Text000
        else
            NewVATAmountText := StrSubstNo(Text001, NewVATPercentage);

        IF Rec."Currency Code" = '' THEN
            NewAmountLCY := NewVendAmount + DecGMntHTDEEE
        ELSE
            NewAmountLCY :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                WORKDATE(), Rec."Currency Code", NewVendAmount + DecGMntHTDEEE, "Currency Factor");

        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.", "No.");
        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::"Credit Memo");
        VendLedgEntry.SETRANGE("Vendor No.", "Pay-to Vendor No.");
        IF VendLedgEntry.FINDFIRST() THEN
            NewAmountLCY := VendLedgEntry."Purchase (LCY)";

    end;
}

