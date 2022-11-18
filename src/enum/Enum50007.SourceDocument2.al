enum 50007 "BC6_Source Document 2"
{
    Extensible = true;

    value(1; "Sales Order")
    {
        Caption = 'Sales Order', comment = 'FRA="Commande vente"';
    }
    value(2; "Sales Return Order")
    {
        Caption = 'Sales Return Order', comment = 'FRA="Retour vente"';
    }
    value(3; "Purchase Order")
    {
        Caption = 'Purchase Order', comment = 'FRA="Commande achat"';
    }
    value(4; "Purchase Return Order")
    {
        Caption = 'Purchase Return Order', comment = 'FRA="Retour achat"';
    }
    value(5; "Inbound Transfer")
    {
        Caption = 'Inbound Transfer', comment = 'FRA="Enlogement transfert"';
    }
    value(6; "Outbound Transfer")
    {
        Caption = 'Outbound Transfer', comment = 'FRA="Désenlogement transfert"';
    }
    value(7; "Prod. Consumption")
    {
        Caption = 'Prod. Consumption', comment = 'FRA="Consommation O.F."';
    }
    value(8; "Prod. Output")
    {
        Caption = 'Prod. Output', comment = 'FRA="Production O.F."';
    }
}
