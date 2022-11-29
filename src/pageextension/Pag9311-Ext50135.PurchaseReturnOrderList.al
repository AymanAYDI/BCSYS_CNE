pageextension 50135 "BC6_PurchaseReturnOrderList" extends "Purchase Return Order List" //9311
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
            field("BC6_Return Order Type"; "BC6_Return Order Type")
            {
            }
            field("BC6_Sales No. Order Lien"; "BC6_Sales No. Order Lien")
            {
                Caption = 'Sales No. Order Link', comment = 'FRA="NO Commande Vente Lien"';
            }
            field(BC6_Amount; Amount)
            {
            }
        }
    }
}

