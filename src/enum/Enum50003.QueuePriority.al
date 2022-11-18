enum 50003 "BC6_Queue Priority"
{
    Extensible = false;

    value(0; "Very Low")
    {
        Caption = 'Very Low', comment = 'FRA="Très faible,"';
    }
    value(2; Low)
    {
        Caption = 'Low', comment = 'FRA="Faible"';
    }
    value(3; Medium)
    {
        Caption = 'Medium', comment = 'FRA="Moyenne"';
    }
    value(4; High)
    {
        Caption = 'High', comment = 'FRA="Haute"';
    }
    value(7; "Very High")
    {
        Caption = 'Very High', comment = 'FRA="Très haute"';
    }
}
