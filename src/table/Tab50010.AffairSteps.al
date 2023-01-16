table 50010 "BC6_Affair Steps"
{
    Caption = 'Affair Steps', comment = 'FRA="Etapes projets"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° Affaire"';
            DataClassification = CustomerContent;
            TableRelation = Job."No.";
        }
        field(2; "No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'No.', comment = 'FRA="N°"';
            DataClassification = CustomerContent;
        }
        field(3; "Step Date"; Date)
        {
            Caption = 'Step date', comment = 'FRA="Date étape"';
            DataClassification = CustomerContent;
        }
        field(4; Interlocutor; Text[50])
        {
            Caption = 'Interlocutor', comment = 'FRA="Interlocuteur"';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(5; Contact; Code[20])
        {
            Caption = 'Contact', comment = 'FRA="Contact"';
            DataClassification = CustomerContent;
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                RecLContact: Record Contact;
            begin
                RecLContact.RESET();
                RecLContact.SETFILTER(RecLContact."No.", Contact);
                if RecLContact.FindFirst() then
                    "Contact Name" := RecLContact.Name;
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description', comment = 'FRA="Description"';
            DataClassification = CustomerContent;
        }
        field(7; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date', comment = 'FRA="Date Relance"';
            DataClassification = CustomerContent;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'FRA="N° document"';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." where("Document Type" = filter("Order" | "Quote"));
        }
        field(9; Terminated; Boolean)
        {
            Caption = 'Terminated', comment = 'FRA="Terminer"';
            DataClassification = CustomerContent;
        }
        field(10; Result; Text[100])
        {
            Caption = 'Result', comment = 'FRA="Resultat"';
            DataClassification = CustomerContent;
        }
        field(11; "Affair Description"; Text[100])
        {
            Caption = 'Affair Description', comment = 'FRA="Nom Affaire"';
            DataClassification = CustomerContent;
            TableRelation = Job."No.";
        }
        field(12; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name', comment = 'FRA="=Nom contact"';
            DataClassification = CustomerContent;
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
        if RecGJob.FindFirst() then
            "Affair Description" := RecGJob.Description;
    end;

    procedure setupNewLine(recLTmpStep: Record "BC6_Affair Steps")
    begin
        "Step Date" := WORKDATE();
        Interlocutor := CopyStr(USERID, 1, MaxStrLen(Interlocutor));
        "No." := recLTmpStep."No." + 1
    end;
}
