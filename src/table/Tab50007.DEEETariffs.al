table 50007 "BC6_DEEE Tariffs"
{
    Caption = 'Tarifs DEEE';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "DEEE Code"; Code[10])
        {
            Caption = 'Code DEEE', comment = 'FRA="Code DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
        }
        field(2; "Date beginning"; Date)
        {
            Caption = 'Date début', comment = 'FRA="Date début"';
            DataClassification = CustomerContent;
        }
        field(3; "Eco Partner"; Code[20])
        {
            Caption = 'Eco Partner', comment = 'FRA="Eco Partenaire"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(10; "HT Unit Tax (LCY)"; Decimal)
        {
            Caption = 'HT Unit Tax (LCY)', comment = 'FRA="Taxe Unitaire HT (DS)"';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
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


    procedure GetLine(Number: Integer)
    begin
        IF Number = 1 THEN
            FIND('-')
        ELSE
            NEXT();
    end;
}

