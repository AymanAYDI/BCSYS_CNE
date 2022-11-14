table 50009 "BC6_Contact Project Relation"
{
    Caption = 'Contact Project Relation', comment = 'FRA="Relation projet contact"';
    PasteIsValid = true;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.', comment = 'FRA="N° contact"';
            NotBlank = false;
            TableRelation = Contact."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetContact();
                "Contact Name" := RecGcontact.Name;
                "Phone No." := RecGcontact."Phone No.";
                CALCFIELDS("Company No.", Type);
                IF GetContactRelation() THEN BEGIN
                    "Relation Type" := RecGCntBusinessRelation."Business Relation Code";
                    "Relation Description" := RecGContactRelation.Description;
                END;
                GetContactRelationType();
                "No." := RecGCntBusinessRelation."No.";
                "Link to table" := RecGCntBusinessRelation."Link to Table";
            end;
        }
        field(2; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name', comment = 'FRA="Nom contact"';
            DataClassification = CustomerContent;
        }
        field(3; "Relation Type"; Code[10])
        {
            Caption = 'Relation Type', comment = 'FRA="Type relation"';
            TableRelation = "Contact Business Relation"."Business Relation Code" WHERE("Contact No." = FIELD("Company No."));
            DataClassification = CustomerContent;
        }
        field(4; "Relation Description"; Text[100])
        {
            CalcFormula = Lookup("Business Relation".Description WHERE(Code = FIELD("Relation Type")));
            Caption = 'Relation Description', comment = 'FRA="Libellé relation"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', comment = 'FRA="N° téléphone"';
            DataClassification = CustomerContent;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.', comment = 'FRA="N°"';
            TableRelation = IF ("Link to table" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Link to table" = CONST(Vendor)) Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(7; "Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° affaire"';
            TableRelation = Job."No.";
            DataClassification = CustomerContent;
        }
        field(8; "Link to table"; Enum "Gen. Journal Source Type")
        {
            Caption = 'Link to Table', comment = 'FRA="Lié à la table"';
            DataClassification = CustomerContent;
        }
        field(10; "Company No."; Code[20])
        {
            CalcFormula = Lookup(Contact."Company No." WHERE("No." = FIELD("Contact No.")));
            Caption = 'Company No.', comment = 'FRA="N° de la société"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(11; Type; enum "Partner Type")
        {
            CalcFormula = Lookup(Contact.Type WHERE("No." = FIELD("Contact No.")));
            Caption = 'Type', comment = 'FRA="Type"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Awarder; Boolean)
        {
            Caption = 'Awarder', comment = 'FRA="Adjudicataire"';
            DataClassification = CustomerContent;
        }
        field(50000; "Affair Responsible"; Code[20])
        {
            CalcFormula = Lookup(Job."BC6_Affair Responsible" WHERE("No." = FIELD("Affair No.")));
            Caption = 'Affair Responsible', comment = 'FRA="Chargé d''affaire"';
            FieldClass = FlowField;
            TableRelation = "User Setup";
        }
        field(50001; Statut; Enum BC6_Statut)
        {
            FieldClass = FlowField;
            Caption = 'Statut', comment = 'FRA="Statut"';
            CalcFormula = Lookup(Job."BC6_Statut" WHERE("No." = FIELD("Affair No.")));
        }
        field(50003; Blocked; Enum "Job Blocked")
        {
            CalcFormula = Lookup(Job.Blocked WHERE("No." = FIELD("Affair No.")));
            Caption = 'Blocked', comment = 'FRA="Bloqué"';
            FieldClass = FlowField;
        }
        field(50004; "Contact City"; Text[30])
        {
            CalcFormula = Lookup(Contact.City WHERE("No." = FIELD("Contact No.")));
            Caption = 'Contact City', comment = 'FRA="Ville"';
            FieldClass = FlowField;
        }
        field(50005; "Contact Post Code"; Code[20])
        {
            CalcFormula = Lookup(Contact."Post Code" WHERE("No." = FIELD("Contact No.")));
            Caption = 'Code postal', comment = 'FRA="Code postal"';
            FieldClass = FlowField;
        }
        field(50006; "Affair Description"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD("Affair No.")));
            Caption = 'Désignation', comment = 'FRA="Désignation"';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Contact No.", "Affair No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecGcontact: Record Contact;
        RecGCntBusinessRelation: Record "Contact Business Relation";
        RecGContactRelation: Record "Business Relation";

    procedure GetContact()
    begin
        TESTFIELD("Contact No.");
        IF "Contact No." <> RecGcontact."No." THEN
            RecGcontact.GET("Contact No.");
    end;

    procedure GetContactRelation() BooFindRelation: Boolean
    begin
        BooFindRelation := FALSE;

        TESTFIELD("Contact No.");
        RecGCntBusinessRelation.RESET();
        IF "Company No." <> '' THEN BEGIN
            RecGCntBusinessRelation.SETFILTER("Contact No.", "Company No.");
            IF RecGCntBusinessRelation.FIND('-') THEN BEGIN
                RecGContactRelation.RESET();
                RecGContactRelation.SETFILTER(Code, RecGCntBusinessRelation."Business Relation Code");
                BooFindRelation := RecGContactRelation.FIND('-');
            END;
        END;
    end;

    procedure GetContactRelationType()
    begin
        TESTFIELD("Contact No.");

        RecGCntBusinessRelation.RESET();
        RecGCntBusinessRelation.SETFILTER("Contact No.", "Contact No.");
        IF RecGCntBusinessRelation.FIND('-') THEN;
    end;
}
