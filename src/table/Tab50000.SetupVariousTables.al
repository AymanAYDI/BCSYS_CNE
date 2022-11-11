table 50000 "BC6_Setup Various Tables"
{
    Caption = 'Setup Various Tables';
    //   TODO: Page
    // DrillDownPageID = 50002;
    // LookupPageID = 50002;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Text1 Use"; Boolean)
        {
            Caption = 'Text1 Use';
        }
        field(4; "Text1 Description"; Text[30])
        {
            Caption = 'Text1 Description';
        }
        field(5; "Text2 Use"; Boolean)
        {
            Caption = 'Text2 Use';
        }
        field(6; "Text2 Description"; Text[30])
        {
            Caption = 'Text2 Description';
        }
        field(7; "Text3 Use"; Boolean)
        {
            Caption = 'Text3 Use';
        }
        field(8; "Text3 Description"; Text[30])
        {
            Caption = 'Text3 Description';
        }
        field(9; "Number1 Use"; Boolean)
        {
            Caption = 'Number1 Use';
        }
        field(10; "Number1 Description"; Text[30])
        {
            Caption = 'Number1 Description';
        }
        field(11; "Number2 Use"; Boolean)
        {
            Caption = 'Number2 Use';
        }
        field(12; "Number2 Description"; Text[30])
        {
            Caption = 'Number2 Description';
        }
        field(13; "Number3 Use"; Boolean)
        {
            Caption = 'Number3 Use';
        }
        field(14; "Number3 Description"; Text[30])
        {
            Caption = 'Number3 Description';
        }
        field(15; "Date1 Use"; Boolean)
        {
            Caption = 'Date1 Use';
        }
        field(16; "Date1 Description"; Text[30])
        {
            Caption = 'Date1 Description';
        }
        field(17; "Date2 Use"; Boolean)
        {
            Caption = 'Date2 Use';
        }
        field(18; "Date2 Description"; Text[30])
        {
            Caption = 'Date2 Description';
        }
        field(19; "Date3 Use"; Boolean)
        {
            Caption = 'Date3 Use';
        }
        field(20; "Date3 Description"; Text[30])
        {
            Caption = 'Date3 Description';
        }
        field(21; "Top Logical1 Use"; Boolean)
        {
            Caption = 'Top Logical1 Use';
        }
        field(22; "Top Logical1 Description"; Text[30])
        {
            Caption = 'Top Logical1 Description';
        }
        field(23; "Top Logical2 Use"; Boolean)
        {
            Caption = 'Top Logical2 Use';
        }
        field(24; "Top Logical2 Description"; Text[30])
        {
            Caption = 'Top Logical2 Description';
        }
        field(25; "Top Logical3 Use"; Boolean)
        {
            Caption = 'Top Logical3 Use';
        }
        field(26; "Top Logical3 Description"; Text[30])
        {
            Caption = 'Top Logical3 Description';
        }
        field(27; "Radical Code1 Use"; Boolean)
        {
            Caption = 'Radical Code1 Use';
        }
        field(28; "Radical Code1 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code1")));
            Caption = 'Radical Code1 Description';
            FieldClass = FlowField;
        }
        field(29; "Radical Code1"; Code[10])
        {
            Caption = 'Radical Code1';
            TableRelation = "BC6_Setup Various Tables".Code;
        }
        field(31; "Radical Code2 Use"; Boolean)
        {
            Caption = 'Radical Code2 Use';
        }
        field(32; "Radical Code2 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code2")));
            Caption = 'Radical Code2 Description';
            FieldClass = FlowField;
        }
        field(33; "Radical Code2"; Code[20])
        {
            Caption = 'Radical Code2';
            TableRelation = "BC6_Setup Various Tables".Code;
        }
        field(35; "Radical Code3 Use"; Boolean)
        {
            Caption = 'Radical Code3 Use';
        }
        field(36; "Radical Code3 Description"; Text[30])
        {
            CalcFormula = Lookup("BC6_Setup Various Tables".Description WHERE(Code = FIELD("Radical Code3")));
            Caption = 'Radical Code3 Description';
            FieldClass = FlowField;
        }
        field(37; "Radical Code3"; Code[20])
        {
            Caption = 'Radical Code3';
            TableRelation = "BC6_Setup Various Tables".Code;
        }
        field(39; "Comment Use"; Boolean)
        {
            Caption = 'Comment Use';
        }
        field(40; "Obligatory Text1"; Boolean)
        {
            Caption = 'Obligatory Text1';
        }
        field(41; "Obligatory Text2"; Boolean)
        {
            Caption = 'Obligatory Text2';
        }
        field(42; "Obligatory Text3"; Boolean)
        {
            Caption = 'Obligatory Text3';
        }
        field(43; "Obligatory Number1"; Boolean)
        {
            Caption = 'Obligatory Number1';
        }
        field(44; "Obligatory Number2"; Boolean)
        {
            Caption = 'Obligatory Number2';
        }
        field(45; "Obligatory Number3"; Boolean)
        {
            Caption = 'Obligatory Number3';
        }
        field(46; "Obligatory Date1"; Boolean)
        {
            Caption = 'Obligatory Date1';
        }
        field(47; "Obligatory Date2"; Boolean)
        {
            Caption = 'Obligatory Date2';
        }
        field(48; "Obligatory Date3"; Boolean)
        {
            Caption = 'Obligatory Date3';
        }
        field(49; "Obligatory Radical Code1"; Boolean)
        {
            Caption = 'Obligatory Radical Code1';
        }
        field(50; "Obligatory Radical Code2"; Boolean)
        {
            Caption = 'Obligatory Radical Code2';
        }
        field(51; "Obligatory Radical Code3"; Boolean)
        {
            Caption = 'Obligatory Radical Code3';
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
