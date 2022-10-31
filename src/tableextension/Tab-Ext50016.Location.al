tableextension 50016 "BC6_Location" extends Location
{
    LookupPageID = 15;
    DrillDownPageID = 15;
    fields
    {
        field(50000; BC6_Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }
}

