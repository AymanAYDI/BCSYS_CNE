pageextension 50056 "BC6_PurchaseOrderStatistics" extends "Purchase Order Statistics" //403
{
    layout
    {
        //Unsupported feature: Property Modification (SourceExpr) on "Control 41". TODO:

        //Unsupported feature: Property Modification (SourceExpr) on "Control 65". TODO:

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
