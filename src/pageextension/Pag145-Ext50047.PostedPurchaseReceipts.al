pageextension 50047 "BC6_PostedPurchaseReceipts" extends "Posted Purchase Receipts" //145
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("BC6_Order No."; "Order No.")
            {
            }
        }
    }
}

