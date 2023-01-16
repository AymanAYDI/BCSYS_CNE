table 50001 "BC6_Various Tables"
{
    Caption = 'Various Tables';
    DataClassification = CustomerContent;
    LookupPageID = "BC6_Tab. Diverses (Non Modif)";

    fields
    {
        field(1; Radical; Code[10])
        {
            Caption = 'Radical', comment = 'FRA="Radical"';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                "Radical Code" := Radical + Code;
            end;
        }
        field(3; Description; Text[200])
        {
            Caption = 'Description', comment = 'FRA="Libellé"';
            DataClassification = CustomerContent;
        }
        field(4; Text1; Text[30])
        {
            Caption = 'Text1', comment = 'FRA="Texte1"';
            DataClassification = CustomerContent;
        }
        field(5; Text2; Text[30])
        {
            Caption = 'Text2', comment = 'FRA="Texte2"';
            DataClassification = CustomerContent;
        }
        field(6; Text3; Text[30])
        {
            Caption = 'Text3', comment = 'FRA="Texte3"';
            DataClassification = CustomerContent;
        }
        field(7; Number1; Decimal)
        {
            Caption = 'Number1', comment = 'FRA="Nombre1"';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(8; Number2; Decimal)
        {
            Caption = 'Number2', comment = 'FRA="Nombre2"';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(9; Number3; Decimal)
        {
            Caption = 'Number3', comment = 'FRA="Nombre3"';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(10; Date1; Date)
        {
            Caption = 'Date1', comment = 'FRA="Date1"';
            DataClassification = CustomerContent;
        }
        field(11; Date2; Date)
        {
            Caption = 'Date2', comment = 'FRA="Date2"';
            DataClassification = CustomerContent;
        }
        field(12; Date3; Date)
        {
            Caption = 'Date3', comment = 'FRA="Date3"';
            DataClassification = CustomerContent;
        }
        field(13; "Top Logical1"; Boolean)
        {
            Caption = 'Top Logical1', comment = 'FRA="Top Logique1"';
            DataClassification = CustomerContent;
        }
        field(14; "Top Logical2"; Boolean)
        {
            Caption = 'Top Logical2', comment = 'FRA="Top Logique2"';
            DataClassification = CustomerContent;
        }
        field(15; "Top Logical3"; Boolean)
        {
            Caption = 'Top Logical3', comment = 'FRA="Top Logique3"';
            DataClassification = CustomerContent;
        }
        field(16; "Radical Code1"; Code[10])
        {
            Caption = 'Radical Code1', comment = 'FRA="Code Radical1"';
            DataClassification = CustomerContent;
        }
        field(17; "Radical Code2"; Code[10])
        {
            Caption = 'Radical Code2', comment = 'FRA="Code Radical2"';
            DataClassification = CustomerContent;
        }
        field(18; "Radical Code3"; Code[10])
        {
            Caption = 'Radical Code3', comment = 'FRA="Code Radical3"';
            DataClassification = CustomerContent;
        }
        field(19; Comment; Boolean)
        {
            Caption = 'Comment', comment = 'FRA="Comment"';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(20; "Radical Code"; Code[20])
        {
            Caption = 'Radical Code', comment = 'FRA="Code Radical"';
            DataClassification = CustomerContent;
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
