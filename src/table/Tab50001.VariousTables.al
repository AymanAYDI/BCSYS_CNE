table 50001 "BC6_Various Tables"
{
    Caption = 'Various Tables';
    //   TODO: Page  // LookupPageID = 50003;

    fields
    {
        field(1; Radical; Code[10])
        {
            Caption = 'Radical';
            NotBlank = true;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Radical Code" := Radical + Code;
            end;
        }
        field(3; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(4; Text1; Text[30])
        {
            Caption = 'Text1';
        }
        field(5; Text2; Text[30])
        {
            Caption = 'Text2';
        }
        field(6; Text3; Text[30])
        {
            Caption = 'Text3';
        }
        field(7; Number1; Decimal)
        {
            Caption = 'Number1';
            DecimalPlaces = 0 : 5;
        }
        field(8; Number2; Decimal)
        {
            Caption = 'Number2';
            DecimalPlaces = 0 : 5;
        }
        field(9; Number3; Decimal)
        {
            Caption = 'Number3';
            DecimalPlaces = 0 : 5;
        }
        field(10; Date1; Date)
        {
            Caption = 'Date1';
        }
        field(11; Date2; Date)
        {
            Caption = 'Date2';
        }
        field(12; Date3; Date)
        {
            Caption = 'Date3';
        }
        field(13; "Top Logical1"; Boolean)
        {
            Caption = 'Top Logical1';
        }
        field(14; "Top Logical2"; Boolean)
        {
            Caption = 'Top Logical2';
        }
        field(15; "Top Logical3"; Boolean)
        {
            Caption = 'Top Logical3';
        }
        field(16; "Radical Code1"; Code[10])
        {
            Caption = 'Radical Code1';
        }
        field(17; "Radical Code2"; Code[10])
        {
            Caption = 'Radical Code2';
        }
        field(18; "Radical Code3"; Code[10])
        {
            Caption = 'Radical Code3';
        }
        field(19; Comment; Boolean)
        {
            Caption = 'Comment';
            InitValue = false;
        }
        field(20; "Radical Code"; Code[20])
        {
            Caption = 'Radical Code';
        }
    }

    keys
    {
        key(Key1; Radical, "Code")
        {
            Clustered = true;
        }
        key(Key2; Radical, Number1)
        {
        }
    }

    fieldgroups
    {
    }
}

