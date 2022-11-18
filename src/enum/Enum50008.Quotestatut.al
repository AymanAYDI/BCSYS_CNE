enum 50008 "BC6_Quote statut"
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; approved)
    {
        Caption = 'Approved', comment = 'FRA="Approuvé"';
    }
    value(2; locked)
    {
        Caption = 'Locked', comment = 'FRA="Verrouillé"';
    }
}
