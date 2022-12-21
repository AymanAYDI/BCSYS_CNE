report 50016 "BC6_Maj cout standard article"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Vendor No.", Blocked;

            trigger OnAfterGetRecord()
            var
                CduPurchPricemgt: Codeunit "Purch. Price Calc. Mgt.";
                FunctionMgt: Codeunit "BC6_Functions Mgt";

            begin
                IntGCounter += 1;
                DlgGWin.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));

                //  TODO:   Item.VALIDATE("Standard Cost", CduPurchPricemgt.Findbestpurchprice(Item."No."));
                Item.MODIFY(TRUE);
            end;

            trigger OnPostDataItem()
            begin
                DlgGWin.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                IntGTotal := COUNT;
                IntGCounter := 0;
                DlgGWin.OPEN(CstG001);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        IntGCounter: Integer;
        IntGTotal: Integer;
        DlgGWin: Dialog;
        CstG001: Label 'Traitement des articles @1@@@@@@@@@';
}
