table 50016 "BC6_Return Order Relation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Return Order"; Code[20])
        {
            Caption = 'Sales Return Order', comment = 'FRA="N° retour vente"';
            DataClassification = CustomerContent;
        }
        field(2; "Purchase Return Order"; Code[20])
        {
            Caption = 'Purchase Return Order', comment = 'FRA="N° retour achat lié"';
            DataClassification = CustomerContent;
        }
        field(3; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', comment = 'FRA="N° commande achat liée"';
            DataClassification = CustomerContent;
        }
        field(4; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.', comment = 'FRA="N° commande vente liée"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sales Return Order")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

