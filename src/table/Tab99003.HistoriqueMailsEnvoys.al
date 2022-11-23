table 99003 "BC6_Historique Mails Envoyés"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            Caption = 'No.', comment = 'FRA="N°"';
            DataClassification = CustomerContent;
        }
        field(2; Nom; Text[200])
        {
            Editable = false;
            Caption = 'Name', comment = 'FRA="Nom"';
            DataClassification = CustomerContent;
        }
        field(3; "E-Mail"; Text[250])
        {
            Editable = false;
            Caption = 'E-Mail', comment = 'FRA="E-Mail"';
            DataClassification = CustomerContent;
        }
        field(4; "Date d'envoi"; Date)
        {
            Editable = false;
            Caption = 'Date d''envoi', comment = 'FRA="Date d''envoi"';
            DataClassification = CustomerContent;
        }
        field(5; "Document envoyé"; Text[100])
        {
            Editable = false;
            Caption = 'Document envoyé', comment = 'FRA="Document envoyé"';
            DataClassification = CustomerContent;
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

