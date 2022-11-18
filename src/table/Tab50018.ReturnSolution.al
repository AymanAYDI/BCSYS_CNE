table 50018 "BC6_Return Solution"
{
    // TODO
    // DrillDownPageID = "BC6_Return Solutions";
    // LookupPageID = "BC6_Return Solutions";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description', comment = 'FRA="Description"';
            DataClassification = CustomerContent;
        }
        field(50000; Type; Enum "BC6_Type Location")
        {
            Caption = 'Type', comment = 'FRA="Type"';
            Description = 'BCSYS';
            DataClassification = CustomerContent;
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

