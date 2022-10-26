table 50018 "Return Solution"
{
    DrillDownPageID = 50113;
    LookupPageID = 50113;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(50000; Type; Option)
        {
            Caption = 'Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;
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

