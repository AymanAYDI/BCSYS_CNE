table 50011 "BC6_SMTP Mail Setup1"
{
    Caption = 'SMTP Mail Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', comment = 'FRA="Clé primaire"';
            DataClassification = CustomerContent;
        }
        field(2; "SMTP Server"; Text[250])
        {
            Caption = 'SMTP Server', comment = 'FRA="Serveur SMTP"';
            DataClassification = CustomerContent;
        }
        field(3; Authentication; Enum BC6_AuthentificationMail)
        {
            Caption = 'Authentication', comment = 'FRA="Authentication"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Authentication <> Authentication::Basic THEN BEGIN
                    "User ID" := '';
                    Password := '';
                END;
            end;
        }
        field(4; "User ID"; Text[30])
        {
            Caption = 'User ID', comment = 'FRA="Code utilisateur"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD(Authentication, Authentication::Basic);
            end;
        }
        field(5; Password; Text[30])
        {
            Caption = 'Password', comment = 'FRA="Mot de passe"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD(Authentication, Authentication::Basic);
            end;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

