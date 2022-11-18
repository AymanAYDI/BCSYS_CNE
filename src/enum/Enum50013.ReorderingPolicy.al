enum 50013 "BC6_Reordering Policy"
{
    Extensible = false;

    value(0; "Maximum Qty.")
    {
        Caption = 'Maximum Qty.', comment = 'FRA="Qté maximum"';
    }
    //=Qté maximum,Qté fixe de commande,Commande,Lot pour lot
    value(1; "Fixed Reorder Qty.")
    {
        Caption = 'Fixed Reorder Qty.', comment = 'FRA="Qté fixe de commande"';
    }
    value(2; "Order")
    {
        Caption = 'Order', comment = 'FRA="Commande"';
    }
    value(3; "Lot-for-Lot")
    {
        Caption = 'Lot-for-Lot', comment = 'FRA="Lot pour lot"';
    }
}
