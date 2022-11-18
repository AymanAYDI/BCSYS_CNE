enum 50000 "BC6_Statut"
{
    Extensible = false;

    value(0; Outstanding)
    {
        Caption = 'Outstanding', comment = 'FRA="Outstanding"';
    }
    value(1; Lost)
    {
        Caption = 'Lost', comment = 'FRA="Lost"';
    }
    value(2; Won)
    {
        Caption = 'Won', comment = 'FRA="Won"';
    }
}
