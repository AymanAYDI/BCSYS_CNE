pageextension 50067 "BC6_SalesOrderStatistics" extends "Sales Order Statistics" //402
{
    layout
    {
        modify("AdjProfitLCY[1]")
        {
            Caption = 'Adjusted Profit (LCY)', Comment = 'FRA="Marge r‚elle DS"';
            //TODO Visible = ShowRealProfit;
        }
        modify("AdjProfitPct[1]")
        {
            Caption = 'Adjusted Profit %', Comment = 'FRA="% marge r‚elle"';
            // Visible = ShowRealProfit;
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Visible = false;
            Editable = false;
        }
        modify("TotalAdjCostLCY[1]")
        {
            Caption = 'Adjusted Cost (LCY)', Comment = 'FRA="Co–t r‚el DS"';
            // Visible = ShowRealProfit;
        }
        modify("AdjProfitLCY[2]")
        {
            Caption = 'Adjusted Profit (LCY)', Comment = 'FRA="Marge r‚elle DS"';
            // Visible = ShowRealProfit;
        }
        modify("AdjProfitPct[2]")
        {
            Caption = 'Adjusted Profit %', Comment = 'FRA="% marge r‚elle"';
            // Visible = ShowRealProfit;
        }
        modify("TotalAdjCostLCY[2]")
        {
            Caption = 'Adjusted Cost (LCY)', Comment = 'FRA="Co–t r‚el DS"';
            // Visible = ShowRealProfit;
        }


        addafter("TotalAmount1[1]")
        {
            field("TotalSalesLine[1].DEEE HT Amount"; TotalSalesLine[1]."BC6_DEEE HT Amount")
            {
                Caption = 'Total DEEE';
                Style = StandardAccent;
                StyleExpr = TRUE;
            }

            field("TotalAmount1[1]+TotalSalesLine[1].DEEE HT Amount"; TotalAmount1[1] + TotalSalesLine[1]."BC6_DEEE HT Amount")
            {
                Caption = 'Total HT DEEE comprise';
                Editable = false;
            }
        }




        addafter("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY[1].""Purchase cost"""; TotalSalesLineLCY[1]."BC6_Purchase cost")
            {
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Co–t d''achat DS"';
                Editable = false;
            }
        }


        addafter(NoOfVATLines_General)
        {
            field("TotalSalesLineLCY[1].""DEEE HT Amount (LCY)"""; TotalSalesLineLCY[1]."BC6_DEEE HT Amount (LCY)")
            {
                Caption = 'Montant DEEE (DS)';
                Editable = false;
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }




        addafter("TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY[2].""Purchase cost"""; TotalSalesLineLCY[2]."BC6_Purchase cost")
            {
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="Co–t d''achat DS"';
            }
        }


        addafter(NoOfVATLines_Invoicing)
        {
            field("TotalSalesLineLCY[2].""DEEE HT Amount (LCY)"""; TotalSalesLineLCY[2]."BC6_DEEE HT Amount (LCY)")
            {
                Caption = 'Montant DEEE (DS)';
            }
        }



        addafter("TotalSalesLineLCY[3].""Unit Cost (LCY)""")
        {
            field("TotalSalesLineLCY[3].""Purchase cost"""; TotalSalesLineLCY[3]."BC6_Purchase cost")
            {
                Caption = 'Purchase Cost (LCY)', Comment = 'FRA="CoÍt d''achat DS"';
            }
        }


        addafter("TempVATAmountLine3.COUNT")
        {
            field(TotalSalesLineLCY[3]."DEEE HT Amount (LCY)";TotalSalesLineLCY[3]."DEEE HT Amount (LCY)")
                {
                    Caption = 'Montant DEEE (DS)';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
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
        "--- TDL94.001 ---": Integer;
        RecGCustomer: Record Customer;
        "---BCSYS---": Integer;
        ShowRealProfit: Boolean;
        UserSetup: Record "User Setup";
}
