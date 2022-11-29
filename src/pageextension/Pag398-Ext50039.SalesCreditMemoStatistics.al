pageextension 50039 "BC6_SalesCreditMemoStatistics" extends "Sales Credit Memo Statistics" //398
{

    layout
    {

        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify(CostLCY)
        {
            Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Co–t d''achat DS"';
        }

        addafter(CustAmount)
        {
            field(BC6_DecGMntHTDEEE; DecGMntHTDEEE)
            {
                Caption = 'Total DEEE';
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("CustAmount+DecGMntHTDEEE"; NewCustAmount + DecGMntHTDEEE)
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
            }
        }

    }

    actions
    {
    }



    var
        "-MIGNAV2013-": Integer;
        "-DEEE1.00-": Integer;
        DecGMntTTCDEEE: Decimal;
        DecGMntHTDEEE: Decimal;
        NewCustAmount: Decimal;


    procedure IncremntDecGMntHTDEEE(_DecGMntHTDEEE: Decimal)
    begin
        DecGMntHTDEEE += _DecGMntHTDEEE;
    end;

    procedure SetNewCustAmount(_NewCustAmount: Decimal)
    begin
        NewCustAmount := _NewCustAmount;
    end;
}

