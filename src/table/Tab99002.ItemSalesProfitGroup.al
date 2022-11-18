table 99002 "BC6_Item Sales Profit Group"
{
    Caption = 'Item Sales Profit Group', comment = 'FRA="Groupe Marge Vente Article"';
    //    TODO // LookupPageID = "BC6_Item Sales Profit Group";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
        }
        field(2; Designation; Text[30])
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

