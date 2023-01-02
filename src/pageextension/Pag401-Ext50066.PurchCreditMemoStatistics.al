pageextension 50066 "BC6_PurchCreditMemoStatistics" extends "Purch. Credit Memo Statistics" //401
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
            }
            field("VendAmount + DecGMntHTDEEE"; NewVendAmount + DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
            }
        }
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        DecGMntHTDEEE: Decimal;
        NewAmountInclVAT: Decimal;
        NewAmountLCY: Decimal;
        NewVATAmount: Decimal;
        NewVATPercentage: Decimal;
        NewVendAmount: Decimal;
        NewVATAmountText: Text[30];

    procedure Increment_MntHTDEEE(_DecGMntHTDEEE: Decimal)
    begin
        DecGMntHTDEEE += _DecGMntHTDEEE;
    end;

    procedure SetNewVendAmount(pNewVendAmount: Decimal)
    begin
        NewVendAmount := NewVendAmount;
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

