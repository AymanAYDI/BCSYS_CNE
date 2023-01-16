table 99003 "BC6_Historique Mails Envoyés"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', comment = 'FRA="N°"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; Nom; Text[200])
        {
            Caption = 'Name', comment = 'FRA="Nom"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "E-Mail"; Text[250])
        {
            Caption = 'E-Mail', comment = 'FRA="E-Mail"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Date d'envoi"; Date)
        {
            Caption = 'Date d''envoi', comment = 'FRA="Date d''envoi"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Document envoyé"; Text[100])
        {
            Caption = 'Document envoyé', comment = 'FRA="Document envoyé"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; Sequence; Integer)
        {
            Caption = 'Sequence', comment = 'FRA="Sequence"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF FindFirst() THEN FINDLAST();
        Sequence := Sequence + 1;
    end;
}
