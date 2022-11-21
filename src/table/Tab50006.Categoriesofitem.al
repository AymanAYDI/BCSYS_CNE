table 50006 "BC6_Categories of item"
{
    Caption = 'Catégories d''article';
    DataClassification = CustomerContent;
    LookupPageID = 50024;

    fields
    {
        field(1; Category; Code[10])
        {
            Caption = 'Catégorie', comment = 'FRA="Catégorie"';
            DataClassification = CustomerContent;
        }
        field(2; "Eco Partner"; Code[20])
        {
            Caption = 'Eco Partner', comment = 'FRA="co Partenaire"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(10; "Weight Min"; Decimal)
        {
            Caption = 'Weight Min', comment = 'FRA="Poids Mini"';
            DataClassification = CustomerContent;
        }
        field(11; "Weight Max"; Decimal)
        {
            Caption = 'Weight Max', comment = 'FRA="Poids Maxi"';
            DataClassification = CustomerContent;
        }
        field(12; "Eco-partner"; Text[30])
        {
            Caption = 'Eco-partner', comment = 'FRA="Eco-partenaire"';
            DataClassification = CustomerContent;
        }
        field(13; Designation; Text[50])
        {
            Caption = 'Designation', comment = 'FRA="Designation"';
            DataClassification = CustomerContent;
        }
        field(14; "DEEE Product Group ID"; Code[10])
        {
            Caption = 'Groupe compta. produit DEEE', comment = 'FRA="Groupe compta. produit DEEE"';
            TableRelation = "Gen. Product Posting Group".Code;
            DataClassification = CustomerContent;
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
