table 50009 "BC6_Contact Project Relation"
{
    Caption = 'Contact Project Relation';
    PasteIsValid = true;

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            Description = 'CNE2.05';
            NotBlank = false;
            TableRelation = Contact."No.";

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
            Caption = 'Contact Name';
            Description = 'CNE1.00';
        }
        field(3; "Relation Type"; Code[10])
        {
            Caption = 'Relation Type';
            Description = 'CNE1.00';
            TableRelation = "Contact Business Relation"."Business Relation Code" WHERE("Contact No." = FIELD("Company No."));
        }
        field(4; "Relation Description"; Text[100])
        {
            CalcFormula = Lookup("Business Relation".Description WHERE(Code = FIELD("Relation Type")));
            Caption = 'Relation Description';
            Description = 'CNE1.00';
            Editable = false;
            FieldClass = FlowField;


        }
        field(5; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Description = 'CNE1.00';
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'CNE1.00';
            TableRelation = IF ("Link to table" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Link to table" = CONST(Vendor)) Vendor."No.";
        }
        field(7; "Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job."No.";
        }
        field(8; "Link to table"; Enum "Gen. Journal Source Type")
        {
            Caption = 'Link to Table';
        }
        field(10; "Company No."; Code[20])
        {
            CalcFormula = Lookup(Contact."Company No." WHERE("No." = FIELD("Contact No.")));
            Caption = 'Company No.';
            Description = 'CNE2.05';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact WHERE(Type = CONST(Company));


        }
        field(11; Type; enum "Partner Type")
        {
            CalcFormula = Lookup(Contact.Type WHERE("No." = FIELD("Contact No.")));
            Caption = 'Type';
            Description = 'CNE2.05';
            Editable = false;
            FieldClass = FlowField;

        }
        field(12; Awarder; Boolean)
        {
            Caption = 'Awarder';
            Description = 'CNE3.01';
        }
        field(50000; "Affair Responsible"; Code[20])
        {
            //TODO: tableExt //CalcFormula = Lookup(Job."Affair Responsible" WHERE("No."=FIELD("Affair No.")));
            Caption = 'Affair Responsible';
            Description = 'CNE1.00';
            FieldClass = FlowField;
            TableRelation = "User Setup";
        }
        field(50001; Statut; Enum BC6_Statut)
        {
            FieldClass = FlowField;
            //TODO: tableExt //CalcFormula = Lookup(Job.Statut WHERE ("No."=FIELD("Affair No.")));
            Description = 'CNE1.00';

        }
        field(50003; Blocked; Enum "Job Blocked")
        {
            CalcFormula = Lookup(Job.Blocked WHERE("No." = FIELD("Affair No.")));
            Caption = 'Blocked';
            Description = 'CNE1.00';
            FieldClass = FlowField;
        }
        field(50004; "Contact City"; Text[30])
        {
            CalcFormula = Lookup(Contact.City WHERE("No." = FIELD("Contact No.")));
            Caption = 'Ville';
            FieldClass = FlowField;
        }
        field(50005; "Contact Post Code"; Code[20])
        {
            CalcFormula = Lookup(Contact."Post Code" WHERE("No." = FIELD("Contact No.")));
            Caption = 'Code postal';
            FieldClass = FlowField;
        }
        field(50006; "Affair Description"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD("Affair No.")));
            Caption = 'Désignation';
            Description = 'SU';
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

        //>>CNE2.05
        RecGCntBusinessRelation.RESET();
        RecGCntBusinessRelation.SETFILTER("Contact No.", "Contact No.");
        IF RecGCntBusinessRelation.FIND('-') THEN;

        /*RecGCntBusinessRelation.RESET;
        RecGCntBusinessRelation.SETFILTER("Contact No.","Company No.");
        RecGCntBusinessRelation.SETRANGE("Link to Table",RecGCntBusinessRelation."Link to Table"::Vendor);
        IF RecGCntBusinessRelation.FIND('-') THEN;
        BEGIN
          RecGCntBusinessRelation.RESET;
          RecGCntBusinessRelation.SETFILTER("Contact No.","Company No.");
          RecGCntBusinessRelation.SETRANGE("Link to Table",RecGCntBusinessRelation."Link to Table"::Customer);
        END;*/
        //<<CNE2.05

    end;
}

