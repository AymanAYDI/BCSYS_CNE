table 99003 "BC6_Historique Mails Envoyés"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; Nom; Text[200])
        {
            Editable = false;
        }
        field(3; "E-Mail"; Text[250])
        {
            Editable = false;
        }
        field(4; "Date d'envoi"; Date)
        {
            Editable = false;
        }
        field(5; "Document envoyé"; Text[100])
        {
            Editable = false;
        }
        field(6; Sequence; Integer)
        {
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
        IF FIND('-') THEN FINDLAST();
        Sequence := Sequence + 1;
    end;
}

