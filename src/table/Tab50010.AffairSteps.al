table 50010 "BC6_Affair Steps"
{

    Caption = 'Affair Steps';

    fields
    {
        field(1; "Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            TableRelation = Job."No.";
        }
        field(2; "No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'No.';
        }
        field(3; "Step Date"; Date)
        {
            Caption = 'Step date';
        }
        field(4; Interlocutor; Text[50])
        {
            Caption = 'Interlocutor';
            Description = 'CNE2.05';
            TableRelation = "User Setup";
        }
        field(5; Contact; Code[20])
        {
            Caption = 'Contact';
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                RecLContact.RESET();
                RecLContact.SETFILTER(RecLContact."No.", Contact);
                IF RecLContact.FIND('-') THEN
                    "Contact Name" := RecLContact.Name;
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'CNE2.05';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER("Order" | "Quote"));
        }
        field(9; Terminated; Boolean)
        {
            Caption = 'Terminated';
        }
        field(10; Result; Text[100])
        {
            Caption = 'Result';
        }
        field(11; "Affair Description"; Text[100])
        {
            Caption = 'Affair Description';
            TableRelation = Job."No.";
        }
        field(12; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
        }
    }

    keys
    {
        key(Key1; "No.", "Affair No.")
        {
            Clustered = true;
        }
        key(Key2; Interlocutor, "Reminder Date", Terminated)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecGJob: Record Job;
    begin
        RecGJob.SETFILTER(RecGJob."No.", "Affair No.");
        IF RecGJob.FIND('-') THEN
            "Affair Description" := RecGJob.Description;
    end;


    procedure setupNewLine(recLTmpStep: Record "BC6_Affair Steps")
    begin
        "Step Date" := WORKDATE();
        Interlocutor := USERID;
        "No." := recLTmpStep."No." + 1

    end;
}

