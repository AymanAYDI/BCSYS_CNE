table 50018 "BC6_Return Solution"
{
    DataClassification = CustomerContent;
    DrillDownPageID = "BC6_Return Solutions";
    LookupPageID = "BC6_Return Solutions";

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
            DataClassification = CustomerContent;
            Description = 'BCSYS';
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
