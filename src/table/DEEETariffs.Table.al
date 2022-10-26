table 50007 "DEEE Tariffs"
{
    // //>>DEEE1.00 : MICO 19.12.2006
    //   Table des tarifs pour chaque catégories d'articles et des eco-partenaires

    Caption = 'Tarifs DEEE';

    fields
    {
        field(1; "DEEE Code"; Code[10])
        {
            Caption = 'Code DEEE';
            TableRelation = "Categories of item".Category;
        }
        field(2; "Date beginning"; Date)
        {
            Caption = 'Date début';
        }
        field(3; "Eco Partner"; Code[20])
        {
            Caption = 'Eco Partner';
            TableRelation = Vendor;
        }
        field(10; "HT Unit Tax (LCY)"; Decimal)
        {
            Caption = 'HT Unit Tax (LCY)';
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(Key1; "Eco Partner", "DEEE Code", "Date beginning")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('Internal')]
    procedure GetLine(Number: Integer)
    begin
        IF Number = 1 THEN
            FIND('-')
        ELSE
            NEXT;
    end;
}

