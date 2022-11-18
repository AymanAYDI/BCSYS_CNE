tableextension 50002 "BC6_Location" extends Location //14
{
    fields
    {
        field(50000; BC6_Blocked; Boolean)
        {
            Caption = 'Blocked', comment = 'FRA="Bloqué"';
            DataClassification = CustomerContent;
        }
    }
}

