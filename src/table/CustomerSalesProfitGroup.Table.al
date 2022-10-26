table 99001 "Customer Sales Profit Group"
{
    // //GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] CREATION

    Caption = 'Groupe Marge Vente Client';
    LookupPageID = 50020;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Designation; Text[50])
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

    var
        SalesLineDiscount: Record "7004";
}

