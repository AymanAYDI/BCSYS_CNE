table 50007 "BC6_DEEE Tariffs"
{
    Caption = 'Tarifs DEEE';

    fields
    {
        field(1; "DEEE Code"; Code[10])
        {
            Caption = 'Code DEEE';
            TableRelation = "BC6_Categories of item".Category;
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


    procedure GetLine(Number: Integer)
    begin
        IF Number = 1 THEN
            FIND('-')
        ELSE
            NEXT();
    end;
}

