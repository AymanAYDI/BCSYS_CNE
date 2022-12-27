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
        RecGCustomer: Record Customer;
        DecGMntHTDEEE: Decimal;
        DecGMntTTCDEEE: Decimal;
        NewCustAmount: Decimal;
        "--- TDL94.001 ---": Integer;
        "-DEEE1.00-": Integer;
        "-MIGNAV2013-": Integer;
}
