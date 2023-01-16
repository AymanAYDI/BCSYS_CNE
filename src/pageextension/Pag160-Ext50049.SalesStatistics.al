pageextension 50049 "BC6_SalesStatistics" extends "Sales Statistics" //160
{
    //à refaire !!
    layout
    {
        modify(AdjProfitLCY)
        {
            Caption = 'Total DEEE', comment = 'FRA="Marge relle DS"';
            Visible = ShowRealProfit;
        }
        modify(AdjProfitPct)
        {
            Caption = 'Total DEEE', comment = 'FRA="% marge relle"';
            Visible = ShowRealProfit;
        }
        modify(TotalAdjCostLCY)
        {
            Caption = 'Adjusted Cost (LCY)', comment = 'FRA="Coût réel DS"';
            Visible = ShowRealProfit;
        }

        modify("TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        addafter("TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            field(BC6_Purchase_Cost; TotalSalesLineLCY."BC6_Purchase cost")
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost (LCY)', comment = 'FRA="Coût d''achat DS"';
            }
        }
        addafter("TotalSalesLine.""Unit Volume""")
        {
            field(BC6_Montant_DEEE; TotalSalesLineLCY."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant DEEE (DS)';
                Editable = false;
            }
        }
        addafter(TotalAmount1)
        {
            field(BC6_Total_DEEE; TotalSalesLine."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total DEEE';
            }
            field("Total_HT_DEEE"; TotalAmount1 + TotalSalesLine."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total HT DEEE comprise';
            }
        }
    }
    trigger OnOpenPage()
    begin
        ShowRealProfit := FALSE;
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."BC6_Aut. Real Sales Profit %" THEN
                ShowRealProfit := TRUE;
    end;

    var
        UserSetup: Record "User Setup";
        [INDATASET]
        ShowRealProfit: Boolean;

    //TODO UpdateHeaderInfo // Araxis ligne 467 //
    //TODO CalculateTotals // Araxis ligne  74
}
