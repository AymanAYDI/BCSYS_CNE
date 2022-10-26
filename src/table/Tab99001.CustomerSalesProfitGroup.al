table 99001 "Customer Sales Profit Group"
{
    Caption = 'Groupe Marge Vente Client';
    //   TODO: Page 
    // LookupPageID = 50020;

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
        SalesLineDiscount: Record "Sales Line Discount";
}

