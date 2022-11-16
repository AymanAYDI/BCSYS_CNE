table 50000 "BC6_Setup Various Tables"
{
    Caption = 'Setup Various Tables';
    DataClassification = CustomerContent;
    //   TODO: Page
    // DrillDownPageID = 50002;
    // LookupPageID = 50002;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Radical"';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description', comment = 'FRA="Libellé"';
            DataClassification = CustomerContent;
        }
        field(3; "Text1 Use"; Boolean)
        {
            Caption = 'Text1 Use', comment = 'FRA="Utilisation Texte1"';
            DataClassification = CustomerContent;
        }
        field(4; "Text1 Description"; Text[30])
        {
            Caption = 'Text1 Description', comment = 'FRA="Libellé Texte1"';
            DataClassification = CustomerContent;
        }
        field(5; "Text2 Use"; Boolean)
        {
            Caption = 'Text2 Use', comment = 'FRA="Utilisation Texte2"';
            DataClassification = CustomerContent;
        }
        field(6; "Text2 Description"; Text[30])
        {
            Caption = 'Text2 Description', comment = 'FRA="Libellé Texte2"';
            DataClassification = CustomerContent;
        }
        field(7; "Text3 Use"; Boolean)
        {
            Caption = 'Text3 Use', comment = 'FRA="Utilisation Texte3"';
            DataClassification = CustomerContent;
        }
        field(8; "Text3 Description"; Text[30])
        {
            Caption = 'Text3 Description', comment = 'FRA="Libellé Texte3"';
            DataClassification = CustomerContent;
        }
        field(9; "Number1 Use"; Boolean)
        {
            Caption = 'Number1 Use', comment = 'FRA="Utilisation Nombre1"';
            DataClassification = CustomerContent;
        }
        field(10; "Number1 Description"; Text[30])
        {
            Caption = 'Number1 Description', comment = 'FRA="Libellé Nombre1"';
            DataClassification = CustomerContent;
        }
        field(11; "Number2 Use"; Boolean)
        {
            Caption = 'Number2 Use', comment = 'FRA="Utilisation Nombre2"';
            DataClassification = CustomerContent;
        }
        field(12; "Number2 Description"; Text[30])
        {
            Caption = 'Number2 Description', comment = 'FRA="Libellé Nombre2"';
            DataClassification = CustomerContent;
        }
        field(13; "Number3 Use"; Boolean)
        {
            Caption = 'Number3 Use', comment = 'FRA="Utilisation Nombre3"';
            DataClassification = CustomerContent;
        }
        field(14; "Number3 Description"; Text[30])
        {
            Caption = 'Number3 Description', comment = 'FRA="Libellé Nombre3"';
            DataClassification = CustomerContent;
        }
        field(15; "Date1 Use"; Boolean)
        {
            Caption = 'Date1 Use', comment = 'FRA="Utilisation Date1"';
            DataClassification = CustomerContent;
        }
        field(16; "Date1 Description"; Text[30])
        {
            Caption = 'Date1 Description', comment = 'FRA="Libellé Date1"';
            DataClassification = CustomerContent;
        }
        field(17; "Date2 Use"; Boolean)
        {
            Caption = 'Date2 Use', comment = 'FRA="Utilisation Date2"';
            DataClassification = CustomerContent;
        }
        field(18; "Date2 Description"; Text[30])
        {
            Caption = 'Date2 Description', comment = 'FRA="Libellé Date2"';
            DataClassification = CustomerContent;
        }
        field(19; "Date3 Use"; Boolean)
        {
            Caption = 'Date3 Use', comment = 'FRA="Utilisation Date3"';
            DataClassification = CustomerContent;
        }
        field(20; "Date3 Description"; Text[30])
        {
            Caption = 'Date3 Description', comment = 'FRA="Libellé Date3"';
            DataClassification = CustomerContent;
        }
        field(21; "Top Logical1 Use"; Boolean)
        {
            Caption = 'Top Logical1 Use', comment = 'FRA="Utilisation Top Logique1"';
            DataClassification = CustomerContent;
        }
        field(22; "Top Logical1 Description"; Text[30])
        {
            Caption = 'Top Logical1 Description', comment = 'FRA="Libellé Top Logique1"';
            DataClassification = CustomerContent;
        }
        field(23; "Top Logical2 Use"; Boolean)
        {
            Caption = 'Top Logical2 Use', comment = 'FRA="Utilisation Top Logique2"';
            DataClassification = CustomerContent;
        }
        field(24; "Top Logical2 Description"; Text[30])
        {
            Caption = 'Top Logical2 Description', comment = 'FRA="Libellé Top Logique2"';
            DataClassification = CustomerContent;
        }
        field(25; "Top Logical3 Use"; Boolean)
        {
            Caption = 'Top Logical3 Use', comment = 'FRA="Utilisation Top Logique3"';
            DataClassification = CustomerContent;
        }
        field(26; "Top Logical3 Description"; Text[30])
        {
            Caption = 'Top Logical3 Description', comment = 'FRA="Libellé Top Logique3"';
            DataClassification = CustomerContent;
        }
        field(27; "Radical Code1 Use"; Boolean)
        {
            Caption = 'Radical Code1 Use', comment = 'FRA="Utilisation Code Radical1"';
            DataClassification = CustomerContent;
        }
        field(28; "Radical Code1 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code1")));
            Caption = 'Radical Code1 Description', comment = 'FRA="Libellé Code Radical1"';
            FieldClass = FlowField;
        }
        field(29; "Radical Code1"; Code[10])
        {
            Caption = 'Radical Code1', comment = 'FRA="Code Radical1"';
            TableRelation = "BC6_Setup Various Tables".Code;
            DataClassification = CustomerContent;
        }
        field(31; "Radical Code2 Use"; Boolean)
        {
            Caption = 'Radical Code2 Use', comment = 'FRA="Utilisation Code Radical2"';
            DataClassification = CustomerContent;
        }
        field(32; "Radical Code2 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code2")));
            Caption = 'Radical Code2 Description', comment = 'FRA="Libellé Code Radical2"';
            FieldClass = FlowField;
        }
        field(33; "Radical Code2"; Code[20])
        {
            Caption = 'Radical Code2', comment = 'FRA="Code Radical2"';
            TableRelation = "BC6_Setup Various Tables".Code;
            DataClassification = CustomerContent;
        }
        field(35; "Radical Code3 Use"; Boolean)
        {
            Caption = 'Radical Code3 Use', comment = 'FRA="Utilisation Code Radical3"';
            DataClassification = CustomerContent;
        }
        field(36; "Radical Code3 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code3")));
            Caption = 'Radical Code3 Description', comment = 'FRA="Libellé Code Radical3"';
            FieldClass = FlowField;
        }
        field(37; "Radical Code3"; Code[20])
        {
            Caption = 'Radical Code3', comment = 'FRA="Code Radical3"';
            TableRelation = "BC6_Setup Various Tables".Code;
            DataClassification = CustomerContent;
        }
        field(39; "Comment Use"; Boolean)
        {
            Caption = 'Comment Use', comment = 'FRA="Utilisation Commentaire"';
            DataClassification = CustomerContent;
        }
        field(40; "Obligatory Text1"; Boolean)
        {
            Caption = 'Obligatory Text1', comment = 'FRA="Texte1 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(41; "Obligatory Text2"; Boolean)
        {
            Caption = 'Obligatory Text2', comment = 'FRA="Texte2 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(42; "Obligatory Text3"; Boolean)
        {
            Caption = 'Obligatory Text3', comment = 'FRA="Texte3 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(43; "Obligatory Number1"; Boolean)
        {
            Caption = 'Obligatory Number1', comment = 'FRA="Nombre1 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(44; "Obligatory Number2"; Boolean)
        {
            Caption = 'Obligatory Number2', comment = 'FRA="Nombre2 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(45; "Obligatory Number3"; Boolean)
        {
            Caption = 'Obligatory Number3', comment = 'FRA="Nombre3 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(46; "Obligatory Date1"; Boolean)
        {
            Caption = 'Obligatory Date1', comment = 'FRA="Date1 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(47; "Obligatory Date2"; Boolean)
        {
            Caption = 'Obligatory Date2', comment = 'FRA="Date2 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(48; "Obligatory Date3"; Boolean)
        {
            Caption = 'Obligatory Date3', comment = 'FRA="Date3 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(49; "Obligatory Radical Code1"; Boolean)
        {
            Caption = 'Obligatory Radical Code1', comment = 'FRA="Code Radical1 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(50; "Obligatory Radical Code2"; Boolean)
        {
            Caption = 'Obligatory Radical Code2', comment = 'FRA="Code Radical2 Obligatoire"';
            DataClassification = CustomerContent;
        }
        field(51; "Obligatory Radical Code3"; Boolean)
        {
            Caption = 'Obligatory Radical Code3', comment = 'FRA="Code Radical3 Obligatoire"';
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

    trigger OnDelete()
    begin
        // Lors de la suppression du parametrage d'une table diverse
        RecGDiv.SETRANGE(Code, Code);
        IF RecGDiv.FIND('-') THEN
            REPEAT
                RecGDiv.DELETE();
            UNTIL RecGDiv.NEXT() = 0
    end;

    var
        RecGDiv: Record "BC6_Various Tables";
}
