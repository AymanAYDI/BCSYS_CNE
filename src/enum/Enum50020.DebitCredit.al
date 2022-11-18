enum 50020 "BC6_DebitCredit"
{
    Extensible = false;

    value(0; Both)
    {
        Caption = 'Both', comment = 'FRA="Les deux"';
    }
    value(1; Debit)
    {
        Caption = 'Debit', comment = 'FRA="Débit"';
    }
    value(2; Credit)
    {
        Caption = 'Credit', comment = 'FRA="Crédit"';
    }
}
