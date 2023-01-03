pageextension 50063 "BC6_SalesInvoiceStatistics" extends "Sales Invoice Statistics" //397
{
    layout
    {
        modify(AdjProfitPct)
        {
            Visible = false;
        }

        addafter(AmountInclVAT)
        {
            field(BC6_DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
                Style = StandardAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("CustAmount+DecGMntHTDEEE"; NewCustAmount + DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    procedure IncrementDecGMntTTCDEEE(_DecGMntTTCDEEE: Decimal)
    begin
#pragma warning disable AA0206
        DecGMntTTCDEEE += _DecGMntTTCDEEE;
    end;

    procedure IncrementDecGMntHTDEEE(_DecGMntHTDEEE: Decimal)
    begin
        DecGMntHTDEEE += _DecGMntHTDEEE;
    end;

    procedure SetNewCustAmount(_NewCustAmount: Decimal)
    begin
        NewCustAmount := _NewCustAmount;
    end;

    var
        DecGMntHTDEEE: Decimal;
        DecGMntTTCDEEE: Decimal;
        NewCustAmount: Decimal;
}
