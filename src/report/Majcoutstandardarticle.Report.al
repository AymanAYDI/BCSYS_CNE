report 50016 "Maj cout standard article"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add Dialog Window
    // 
    // ------------------------------------------------------------------------

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            RequestFilterFields = "No.", "Vendor No.", Blocked;

            trigger OnAfterGetRecord()
            var
                CduPurchPricemgt: Codeunit "7010";
            begin
                //>>TDL.76
                IntGCounter += 1;
                DlgGWin.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));
                //<<TDL.76

                Item.VALIDATE("Standard Cost", CduPurchPricemgt.Findbestpurchprice(Item."No."));
                Item.MODIFY(TRUE);
            end;

            trigger OnPostDataItem()
            begin
                //>>TDL.76
                DlgGWin.CLOSE;
                //<<TDL.76
            end;

            trigger OnPreDataItem()
            begin
                //>>TDL.76
                IntGTotal := COUNT;
                IntGCounter := 0;
                DlgGWin.OPEN(CstG001);
                //<<TDL.76
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
        "- TDL.76 -": Integer;
        IntGCounter: Integer;
        IntGTotal: Integer;
        DlgGWin: Dialog;
        "-- TDL.76 --": ;
        CstG001: Label 'Traitement des articles @1@@@@@@@@@';
}

