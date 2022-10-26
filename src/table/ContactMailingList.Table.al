table 50015 "Contact Mailing List"
{
    Caption = 'Contact Mailing Group';
    DrillDownPageID = 5064;

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
            TableRelation = Contact;
        }
        field(2; "Mailing List Code"; Code[10])
        {
            Caption = 'Mailing Group Code';
            NotBlank = true;
            TableRelation = "Mailing Group";
        }
        field(3; "Contact Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE (No.=FIELD(Contact No.)));
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4;"Contact Company Name";Text[50])
        {
            CalcFormula = Lookup(Contact."Company Name" WHERE (No.=FIELD(Contact No.)));
            Caption = 'Contact Company Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;"Mailing Group Description";Text[50])
        {
            Caption = 'Mailing Group Description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Contact No.","Mailing List Code")
        {
            Clustered = true;
        }
        key(Key2;"Mailing List Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TouchContact("Contact No.");
    end;

    trigger OnInsert()
    begin
        TouchContact("Contact No.");
    end;

    trigger OnModify()
    begin
        TouchContact("Contact No.");
    end;

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
        Cont: Record "5050";

    local procedure TouchContact(ContactNo: Code[20])
    begin
        Cont.LOCKTABLE;
        Cont.GET(ContactNo);
        Cont."Last Date Modified" := TODAY;
        Cont.MODIFY;
    end;
}

