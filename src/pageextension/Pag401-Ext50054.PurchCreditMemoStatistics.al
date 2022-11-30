pageextension 50054 "BC6_PurchCreditMemoStatistics" extends "Purch. Credit Memo Statistics" //401
{
    layout
    {
        addafter(VATAmount)
        {
            field(BC6_DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
            }
            // field("VendAmount + DecGMntHTDEEE"; VendAmount + DecGMntHTDEEE) TODO:
            // {
            //     Caption = 'Total HT DEEE Incluse';
            // }
        }
    }

    var
        "--- TDL94.001 ---": Integer;
        DecGMntTTCDEEE: Decimal;
        DecGMntHTDEEE: Decimal;

    procedure Increment_MntHTDEEE(_DecGMntHTDEEE: Decimal)
    begin
        DecGMntHTDEEE += _DecGMntHTDEEE;
    end;

}

