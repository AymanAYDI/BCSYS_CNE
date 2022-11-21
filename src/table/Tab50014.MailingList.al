table 50014 "BC6_Mailing List"
{
    Caption = 'Mailing Group', comment = 'FRA="Groupe de distribution"';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Mailing Groups";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description', comment = 'FRA="Description"';
            DataClassification = CustomerContent;
        }
        field(3; "No. of Contacts"; Integer)
        {
            CalcFormula = Count("Contact Mailing Group" WHERE("Mailing Group Code" = FIELD(Code)));
            Caption = 'No. of Contacts', comment = 'FRA="Nbre contacts"';
            Editable = false;
            FieldClass = FlowField;
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

    trigger OnDelete()
    begin
        CALCFIELDS("No. of Contacts");
        TESTFIELD("No. of Contacts", 0);
    end;
}
