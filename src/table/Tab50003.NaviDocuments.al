table 50003 "BC6_Navi+ Documents"
{
    Caption = 'Document';
    //   TODO: Page 
    // DataCaptionFields = Description;
    // DrillDownPageID = 50063;
    // LookupPageID = 50063;

    fields
    {
        field(1; "Table No."; Integer)
        {
            BlankZero = true;
            Caption = 'Table No.';
            TableRelation = "Table Information"."Table No.";

        }
        field(2; "Reference No. 1"; Code[20])
        {
            Caption = 'Reference No. 1';
            TableRelation = IF ("Table No." = CONST(18)) Customer."No."
            ELSE
            IF ("Table No." = CONST(23)) Vendor."No."
            ELSE
            IF ("Table No." = CONST(27)) Item."No."
            ELSE
            IF ("Table No." = CONST(99000771)) "Production BOM Header"."No."
            ELSE
            IF ("Table No." = CONST(99000763)) "Routing Header"."No.";
        }
        field(3; "Reference No. 2"; Code[20])
        {
            Caption = 'Reference No.2';
            Editable = false;
        }
        field(4; "Reference No. 3"; Code[20])
        {
            Caption = 'Reference No.3';
        }
        field(5; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(10; "Table Name"; Text[30])
        {
            CalcFormula = Lookup("Table Information"."Table Name" WHERE("Table No." = FIELD("Table No.")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Description; Text[80])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                Description := CONVERTSTR(Description, '!"#£@¤$%&/(){[]}=?+`´|^~¨*:.;,\<>', '_________________________________');
            end;
        }
        field(13; "Path and file"; Text[250])
        {
            Caption = 'Path and file';
        }
        field(14; "Description 2"; Text[80])
        {
            Caption = 'Description 2';
        }
        field(15; "In Use By"; Code[20])
        {
            Caption = 'In Use By';
            Editable = true;
            TableRelation = User."User Security ID";
            ValidateTableRelation = false;
        }
        field(16; Special; Boolean)
        {
            Caption = 'Special';
        }
        field(17; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(18; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(19; "Modified By"; Code[20])
        {
            Caption = 'Modified By';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table No.", "Reference No. 1", "Reference No. 2", "Reference No. 3", "Document No.", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
        key(Key3; "Document No.", "Created Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //IF ("Document No." <> '') OR ("Table No."<>0) OR ("Reference No. 1"<>'') OR (Description<>'')
        //   OR ("Path and file"<>'') OR ("Description 2"<>'') THEN BEGIN
        RecGDoc.SETCURRENTKEY("No.");
        IF RecGDoc.FIND('+') THEN
            "No." := RecGDoc."No." + 1
        ELSE
            "No." := 1;
        "Created Date" := TODAY;
        CodGFiltreTable := GETFILTER("Table No.");
        IF ("Table No." = 0) AND (CodGFiltreTable <> '0000000000') THEN
            IF NOT EVALUATE("Table No.", CodGFiltreTable) THEN;

        // On recupère les filtres zones pour écrire...
        CodGFiltreRef1 := GETFILTER("Reference No. 1");
        CodGFiltreRef2 := GETFILTER("Reference No. 2");
        TxtGFiltreRef3 := GETFILTER("Reference No. 3");
        IF ("Reference No. 1" = '') AND (CodGFiltreRef1 <> '') THEN
            "Reference No. 1" := CodGFiltreRef1;
        IF ("Reference No. 2" = '') AND (CodGFiltreRef2 <> '') THEN
            "Reference No. 2" := CodGFiltreRef2;
        IF ("Reference No. 3" = '') AND (TxtGFiltreRef3 <> '') THEN
            "Reference No. 3" := TxtGFiltreRef3;
        //END;
    end;

    trigger OnModify()
    begin
        "Modified Date" := TODAY;
        "Modified By" := USERID;
    end;

    var
        RecGDoc: Record "BC6_Navi+ Documents";
        CodGFiltreRef1: Code[20];
        CodGFiltreRef2: Code[20];
        TxtGFiltreRef3: Code[20];
        CodGFiltreTable: Text[10];
    // TODO
    // procedure View(): Boolean
    // var
    //     OK: Boolean;
    // begin
    // end;

    // procedure Import(FileName: Text[260]; ShowDialog: Boolean): Boolean
    // var
    //     ImportName: Text[260];
    // begin
    // end;
}

