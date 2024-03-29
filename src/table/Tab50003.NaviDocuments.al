table 50003 "BC6_Navi+ Documents"
{
    Caption = 'Document';
    DataCaptionFields = Description;
    DataClassification = CustomerContent;
    DrillDownPageID = "BC6_Invt. Pick Card MiniF2";
    LookupPageID = "BC6_Invt. Pick Card MiniF2";

    fields
    {
        field(1; "Table No."; Integer)
        {
            BlankZero = true;
            Caption = 'Table No.', comment = 'FRA="Table N°"';
            DataClassification = CustomerContent;
            TableRelation = "Table Information"."Table No.";
        }
        field(2; "Reference No. 1"; Code[20])
        {
            Caption = 'Reference No. 1', comment = 'FRA="Référence N° 1"';
            DataClassification = CustomerContent;
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
            Caption = 'Reference No.2', comment = 'FRA="Référence N° 2"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Reference No. 3"; Code[20])
        {
            Caption = 'Reference No.3', comment = 'FRA="Référence N° 3"';
            DataClassification = CustomerContent;
        }
        field(5; "No."; Integer)
        {
            Caption = 'No.', comment = 'FRA="N°"';
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'FRA="N° Document"';
            DataClassification = CustomerContent;
        }
        field(10; "Table Name"; Text[30])
        {
            CalcFormula = Lookup("Table Information"."Table Name" WHERE("Table No." = FIELD("Table No.")));
            Caption = 'Table Name', comment = 'FRA="Nom Table"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Description; Text[80])
        {
            Caption = 'Description', comment = 'FRA="Description"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Description := CONVERTSTR(Description, '!"#£@¤$%&/(){[]}=?+`´|^~¨*:.;,\<>', '_________________________________');
            end;
        }
        field(13; "Path and file"; Text[250])
        {
            Caption = 'Path and file', comment = 'FRA="Chemin et fichier"';
            DataClassification = CustomerContent;
        }
        field(14; "Description 2"; Text[80])
        {
            Caption = 'Description 2', comment = 'FRA="Description2"';
            DataClassification = CustomerContent;
        }
        field(15; "In Use By"; Code[20])
        {
            Caption = 'In Use By', comment = 'FRA="Utilisé par"';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = User."User Security ID";
            ValidateTableRelation = false;
        }
        field(16; Special; Boolean)
        {
            Caption = 'Special', comment = 'FRA="Spécial"';
            DataClassification = CustomerContent;
        }
        field(17; "Created Date"; Date)
        {
            Caption = 'Created Date', comment = 'FRA="Date de Création"';
            DataClassification = CustomerContent;
        }
        field(18; "Modified Date"; Date)
        {
            Caption = 'Modified Date', comment = 'FRA="Date de Modification"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Modified By"; Code[50])
        {
            Caption = 'Modified By', comment = 'FRA="Modifié par"';
            DataClassification = CustomerContent;
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
        CodGFiltreRef1 := CopyStr(GETFILTER("Reference No. 1"), 1, MaxStrLen(CodGFiltreRef1));
        CodGFiltreRef2 := CopyStr(GETFILTER("Reference No. 2"), 1, MaxStrLen(CodGFiltreRef2));
        TxtGFiltreRef3 := CopyStr(GETFILTER("Reference No. 3"), 1, MaxStrLen(TxtGFiltreRef3));
        IF ("Reference No. 1" = '') AND (CodGFiltreRef1 <> '') THEN
            "Reference No. 1" := CodGFiltreRef1;
        IF ("Reference No. 2" = '') AND (CodGFiltreRef2 <> '') THEN
            "Reference No. 2" := CodGFiltreRef2;
        IF ("Reference No. 3" = '') AND (TxtGFiltreRef3 <> '') THEN
            "Reference No. 3" := TxtGFiltreRef3;
    end;

    trigger OnModify()
    begin
        "Modified Date" := TODAY;
        "Modified By" := CopyStr(USERID, 1, MaxStrLen("Modified By"));
    end;

    var
        RecGDoc: Record "BC6_Navi+ Documents";
        CodGFiltreRef2: Code[20];
        TxtGFiltreRef3: Code[20];
        CodGFiltreTable: Text;
        CodGFiltreRef1: Text[20];
}
