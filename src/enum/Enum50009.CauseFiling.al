enum 50009 "BC6_Cause Filing"
{
    Extensible = false;

    value(0; "No proceeded")
    {
        Caption = 'No proceeded', comment = 'FRA="Non traitée"';
    }
    value(1; Deleted)
    {
        Caption = 'Deleted', comment = 'FRA="Supprimé"';
    }
    value(2; "Change in Order")
    {
        Caption = 'Change in Order', comment = 'FRA="Transformé en Cde"';
    }
}
