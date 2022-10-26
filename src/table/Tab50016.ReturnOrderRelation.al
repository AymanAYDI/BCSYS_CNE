table 50016 "BC6_Return Order Relation"
{

    fields
    {
        field(1; "Sales Return Order"; Code[20])
        {
            Caption = 'N° retour vente';
        }
        field(2; "Purchase Return Order"; Code[20])
        {
            Caption = 'N° retour achat lié';
        }
        field(3; "Purchase Order No."; Code[20])
        {
            Caption = 'N° commande achat liée';
        }
        field(4; "Sales Order No."; Code[20])
        {
            Caption = 'N° commande vente liée';
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

