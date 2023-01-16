table 50002 "BC6_Special Extended Text Line"
{
    Caption = 'Special Extended Text Line';
    DataClassification = CustomerContent;
    LookupPageID = "BC6_Special Extended Text list";

    fields
    {
        field(1; "Table Name"; Enum "Credit Transfer Account Type")
        {
            Caption = 'Table Name', comment = 'FRA="Nom de la table"';
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
            TableRelation = IF ("Table Name" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Table Name" = CONST(Vendor)) Vendor."No.";
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.', comment = 'FRA="N°"';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'FRA="N° Ligne"';
            DataClassification = CustomerContent;
        }
        field(6; "Text"; Text[50])
        {
            Caption = 'Text', comment = 'FRA="Texte"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table Name", "Code", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
