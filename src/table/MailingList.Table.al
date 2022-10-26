table 50014 "Mailing List"
{
    Caption = 'Mailing Group';
    DataCaptionFields = "Code", Description;
    LookupPageID = 5063;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "No. of Contacts"; Integer)
        {
            CalcFormula = Count ("Contact Mailing Group" WHERE (Mailing Group Code=FIELD(Code)));
            Caption = 'No. of Contacts';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CALCFIELDS("No. of Contacts");
        TESTFIELD("No. of Contacts",0);
    end;
}

