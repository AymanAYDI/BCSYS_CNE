pageextension 50068 "BC6_PurchaseOrderStatistics" extends "Purchase Order Statistics" //403
{
    layout
    {
        modify("TotalPurchLineLCY[2].Amount")
        {
            Visible = false;
        }
        addafter("TotalPurchLineLCY[2].Amount")
        {
            field("TotalPurchLineLCY[2].Amount2"; TotalPurchLineLCY[2].Amount + TotalPurchLineLCY[2]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Purchase (LCY)';
                Editable = false;
                ToolTip = 'Specifies the amount in the Total field, converted to LCY.';
            }
        }

        modify("TotalPurchLineLCY[3].Amount")
        {
            Visible = false;
        }
        addafter("TotalPurchLineLCY[3].Amount")
        {
            field("TotalPurchLineLCY[3].Amount2"; TotalPurchLineLCY[3].Amount + TotalPurchLineLCY[2]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Purchase (LCY)';
                Editable = false;
                ToolTip = 'Specifies the amount in the Total field, converted to LCY.';
            }
        }

        addafter("Total_General")
        {
            field(DEEE_HT_Amount; TotalPurchLine[1]."BC6_DEEE HT Amount")
            {
                Caption = 'Total DEEE';
                ApplicationArea = All;
            }
            field("Total_HT_DEEE_Incluse"; TotalAmount1[1] + TotalPurchLine[1]."BC6_DEEE HT Amount")
            {
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("NoOfVATLines_General")
        {
            field(Montant_DEEE_DS; TotalPurchLineLCY[1]."BC6_DEEE HT Amount (LCY)")
            {
                Caption = 'Montant DEEE (DS)';
                ApplicationArea = All;
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        "-DEEE1.00-": Integer;
        DecGHTAmount: array[3] of Decimal;
        DecGVATAmount: array[3] of Decimal;
        DecGTTCAmount: array[3] of Decimal;
        DecGHTAmountLCY: array[3] of Decimal;
}
