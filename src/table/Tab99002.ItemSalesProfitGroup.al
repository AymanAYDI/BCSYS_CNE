table 99002 "BC6_Item Sales Profit Group"
{
    Caption = 'Groupe Marge Vente Article';
    //   TODO: Page   // LookupPageID = 50021;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Designation; Text[30])
        {
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

