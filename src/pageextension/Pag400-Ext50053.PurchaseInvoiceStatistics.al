pageextension 50053 "BC6_PurchaseInvoiceStatistics" extends "Purchase Invoice Statistics" //400
{
    layout
    {
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
            // field("VendAmount+DecGMntHTDEEE"; VendAmount + DecGMntHTDEEE) TODO:  global variable
            // {
            //     Caption = 'Total HT DEEE Incluse';
            //     Editable = false;
            //     ApplicationArea = All;
            // }
        }
    }

    var
        "--- TDL94.001 ---": Integer;
        DecGMntHTDEEE: Decimal;
        DecGMntTTCDEEE: Decimal;

    procedure IncrementDecGMntHTDEEE(v: Decimal)
    begin
        DecGMntHTDEEE += v;
    end;

    procedure IncrementDecGMntTTCDEEE(v: Decimal)
    begin
        DecGMntTTCDEEE += v;
    end;
}

