pageextension 50067 "BC6_SalesOrderStatistics" extends "Sales Order Statistics" //402
{
    layout
    {
        modify("AdjProfitLCY[1]")
        {
            Caption = 'Adjusted Profit (LCY)', Comment = 'FRA="Marge réelle DS"';
            Visible = ShowRealProfit;
        }
        modify("AdjProfitPct[1]")
        {
            Caption = 'Adjusted Profit %', Comment = 'FRA="% marge réelle"';
            Visible = ShowRealProfit;
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Editable = false;
            Visible = false;
        }
        modify("TotalAdjCostLCY[1]")
        {
            Caption = 'Adjusted Cost (LCY)', Comment = 'FRA="Coût réel DS"';
            Visible = ShowRealProfit;
        }
        modify("AdjProfitLCY[2]")
        {
            Caption = 'Adjusted Profit (LCY)', Comment = 'FRA="Marge réelle DS"';
            Visible = ShowRealProfit;
        }
        modify("AdjProfitPct[2]")
        {
            Caption = 'Adjusted Profit %', Comment = 'FRA="% marge réelle"';
            Visible = ShowRealProfit;
        }
        modify("TotalAdjCostLCY[2]")
        {
            Caption = 'Adjusted Cost (LCY)', Comment = 'FRA="Coût réel DS"';
            Visible = ShowRealProfit;
        }

        addafter("TotalAmount1[1]")
        {
            field("TotalSalesLine1DEEEHTAmount"; TotalSalesLine[1]."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total DEEE';
                Style = StandardAccent;
                StyleExpr = TRUE;
            }

            field("TotalAmount1TotalSalesLine1DEEEHTAmount"; TotalAmount1[1] + TotalSalesLine[1]."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'Total HT DEEE comprise';
                Editable = false;
            }
        }

        addafter("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY1Purchase cost"; TotalSalesLineLCY[1]."BC6_Purchase cost")
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Coût d''achat DS"';
                Editable = false;
            }
        }

        addafter(NoOfVATLines_General)
        {
            field("TotalSalesLineLCY1DEEE HT AmountLCY"; TotalSalesLineLCY[1]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant DEEE (DS)';
                Editable = false;
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }

        addafter("TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY2Purchase cost"; TotalSalesLineLCY[2]."BC6_Purchase cost")
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Coût d''achat DS"';
            }
        }

        addafter(NoOfVATLines_Invoicing)
        {
            field("TotalSalesLineLCY2DEEE HT AmountLCY"; TotalSalesLineLCY[2]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant DEEE (DS)';
            }
        }

        addafter("TotalSalesLineLCY[3].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY[3].""Purchase cost"""; TotalSalesLineLCY[3]."BC6_Purchase cost")
            {
                ApplicationArea = All;
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Coût d''achat DS"';
            }
        }

        addafter("TempVATAmountLine3.COUNT")
        {
            field("TotalSalesLineLCY3DEEE HT AmountLCY"; TotalSalesLineLCY[3]."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montant DEEE (DS)';
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }
    }

    var
        ShowRealProfit: Boolean;
}