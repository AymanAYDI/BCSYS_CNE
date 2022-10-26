table 99002 "Item Sales Profit Group"
{
    // //GRPMARGEARTICLE SM 15/10/06 NCS1.01 [FE024V1] CREATION

    Caption = 'Groupe Marge Vente Article';
    LookupPageID = 50021;

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

