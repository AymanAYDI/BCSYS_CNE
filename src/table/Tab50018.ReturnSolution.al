table 50018 "BC6_Return Solution"
{
    //   TODO: Page 
    // DrillDownPageID = 50113;
    // LookupPageID = 50113;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(50000; Type; Enum "BC6_Type Location")
        {
            Caption = 'Type';
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

