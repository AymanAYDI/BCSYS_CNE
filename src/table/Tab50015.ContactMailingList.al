table 50015 "BC6_Contact Mailing List"
{
    Caption = 'Contact Mailing Group';
    DataClassification = CustomerContent;
    DrillDownPageID = "Contact Mailing Groups";
    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.', comment = 'FRA="N° contact"';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Contact;
        }
        field(2; "Mailing List Code"; Code[10])
        {
            Caption = 'Mailing Group Code', comment = 'FRA="Code groupe de distribution"';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Mailing Group";
        }
        field(3; "Contact Name"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Contact No.")));
            Caption = 'Contact Name', comment = 'FRA="Nom contact"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Contact Company Name"; Text[100])
        {
            CalcFormula = Lookup(Contact."Company Name" WHERE("No." = FIELD("Contact No.")));
            Caption = 'Contact Company Name', comment = 'FRA="Nom société contact"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Mailing Group Description"; Text[50])
        {
            Caption = 'Mailing Group Description', comment = 'FRA="Description gpe de distrib."';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Contact No.", "Mailing List Code")
        {
            Clustered = true;
        }
        key(Key2; "Mailing List Code")
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnRename()
    begin
        IF xRec."Contact No." = "Contact No." THEN
            TouchContact("Contact No.")
        ELSE BEGIN
            TouchContact("Contact No.");
            TouchContact(xRec."Contact No.");
        END;
    end;

    var
        Cont: Record Contact;

    local procedure TouchContact(ContactNo: Code[20])
    begin
        Cont.LOCKTABLE();
        Cont.GET(ContactNo);
        Cont."Last Date Modified" := TODAY;
        Cont.MODIFY();
    end;
}
