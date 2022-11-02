page 50033 "BC6_Affair Steps Sub-form"
{
    Caption = 'Affair Steps Sub-form';
    PageType = ListPart;
    SourceTable = "BC6_Affair Steps";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                }
                field("Step Date"; "Step Date")
                {
                }
                field(Interlocutor; Interlocutor)
                {
                }
                field(Contact; Contact)
                {
                }
                field("Contact Name"; "Contact Name")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                }
                field("Reminder Date"; "Reminder Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(Terminated; Terminated)
                {
                }
                field(Result; Result)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        NoOnFormat();
        StepDateOnFormat();
        InterlocutorOnFormat();
        ContactOnFormat();
        ContactNameOnFormat();
        DescriptionOnFormat();
        ReminderDateOnFormat();
        DocumentNoOnFormat();
        ResultOnFormat();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //setupNewLine;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        setupNewLine(xRec);
    end;

    var
        RecGContactProjectRelation: Record "BC6_Contact Project Relation";

    local procedure NoOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure StepDateOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure InterlocutorOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ContactOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ContactNameOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure DescriptionOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ReminderDateOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ResultOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Contact, "Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;
}

