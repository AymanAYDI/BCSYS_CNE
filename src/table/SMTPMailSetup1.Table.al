table 50011 "SMTP Mail Setup1"
{
    // -----------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------
    // //>>CNE3.01
    //   FE-Emailsuiviaffaires-20090818:SOBI 12/11/09 : - creation

    Caption = 'SMTP Mail Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "SMTP Server"; Text[250])
        {
            Caption = 'SMTP Server';
        }
        field(3; Authentication; Option)
        {
            Caption = 'Authentication';
            OptionCaption = 'Anonymous,NTLM,Basic';
            OptionMembers = Anonymous,NTLM,Basic;

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
            Caption = 'User ID';

            trigger OnValidate()
            begin
                TESTFIELD(Authentication, Authentication::Basic);
            end;
        }
        field(5; Password; Text[30])
        {
            Caption = 'Password';

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

