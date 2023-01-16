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
                ApplicationArea = All;
                Caption = 'Total DEEE';
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
            field("CustAmount+DecGMntHTDEEE"; NewCustAmount + DecGMntHTDEEE)
            {
                ApplicationArea = All;
                Caption = 'Total HT DEEE Incluse';
                Enabled = false;
            }
        }
    }

    actions
    {
    }

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
        NewCustAmount: Decimal;
}
