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
                Caption = 'Purchase (LCY)', Comment = 'FRA="Achats DS"';
                Editable = false;
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
                Caption = 'Purchase (LCY)', Comment = 'FRA="Achats DS"';
                Editable = false;
            }
        }

        addafter("Total_General")
        {
            field(DEEE_HT_Amount; TotalPurchLine[1]."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total DEEE';
            }
            field("Total_HT_DEEE_Incluse"; TotalAmount1[1] + TotalPurchLine[1]."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total HT DEEE Incluse';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("NoOfVATLines_General")
        {
            field(Montant_DEEE_DS; TotalPurchLineLCY[1]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant DEEE (DS)';
            }
        }
    }
}
