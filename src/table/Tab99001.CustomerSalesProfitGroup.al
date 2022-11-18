table 99001 "Customer Sales Profit Group"
{
    Caption = 'Groupe Marge Vente Client';
    //TODO LookupPageID = 50020;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
        }
        field(2; Designation; Text[50])
        {
            Caption = 'Designation', comment = 'FRA="Designation"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

