table 50006 "BC6_Categories of item"
{
    Caption = 'Catégories d''article';
    LookupPageID = 50024;

    fields
    {
        field(1; Category; Code[10])
        {
            Caption = 'Catégorie';
        }
        field(2; "Eco Partner"; Code[20])
        {
            Caption = 'Eco Partner';
            TableRelation = Vendor;
        }
        field(10; "Weight Min"; Decimal)
        {
            Caption = 'Weight Min';
        }
        field(11; "Weight Max"; Decimal)
        {
            Caption = 'Weight Max';
        }
        field(12; "Eco-partner"; Text[30])
        {
        }
        field(13; Designation; Text[50])
        {
        }
        field(14; "DEEE Product Group ID"; Code[10])
        {
            Caption = 'Groupe compta. produit DEEE';
            TableRelation = "Gen. Product Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; Category, "Eco Partner")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

