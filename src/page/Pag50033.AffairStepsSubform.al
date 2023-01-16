page 50033 "BC6_Affair Steps Sub-form"
{
    Caption = 'Affair Steps Sub-form', Comment = 'FRA="Sous-formulaire des étapes de l''affaire"';
    PageType = ListPart;
    SourceTable = "BC6_Affair Steps";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Step Date"; Rec."Step Date")
                {
                    ApplicationArea = All;
                }
                field(Interlocutor; Rec.Interlocutor)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Reminder Date"; Rec."Reminder Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Terminated; Rec.Terminated)
                {
                    ApplicationArea = All;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
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
        Rec.setupNewLine(xRec);
    end;

    var
        RecGContactProjectRelation: Record "BC6_Contact Project Relation";

    local procedure NoOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure StepDateOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure InterlocutorOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ContactOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ContactNameOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure DescriptionOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ReminderDateOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;

    local procedure ResultOnFormat()
    begin
        IF RecGContactProjectRelation.GET(Rec.Contact, Rec."Affair No.") THEN
            IF RecGContactProjectRelation.Awarder = TRUE THEN;
    end;
}
