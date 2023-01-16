page 50031 "BC6_Contact Affair Subform"
{
    Caption = 'Contact Affair Subform', Comment = 'FRA="Contact affaire"';
    PageType = ListPart;
    SourceTable = "BC6_Contact Project Relation";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Affair No."; Rec."Affair No.")
                {
                    ApplicationArea = All;
                }
                field("Affair Responsible"; Rec."Affair Responsible")
                {
                    ApplicationArea = All;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contact City"; Rec."Contact City")
                {
                    ApplicationArea = All;
                }
                field("Contact Post Code"; Rec."Contact Post Code")
                {
                    ApplicationArea = All;
                }
                field(Awarder; Rec.Awarder)
                {
                    ApplicationArea = All;
                }
                field("Relation Type"; Rec."Relation Type")
                {
                    ApplicationArea = All;
                }
                field("Relation Description"; Rec."Relation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Company No."; Rec."Company No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrRecord();
        AffairNoOnFormat();
        ContactNoOnFormat();
        ContactNameOnFormat();
        RelationTypeOnFormat();
        RelationDescriptionOnFormat();
        PhoneNoOnFormat();
        NoOnFormat();
        CompanyNoOnFormat();
        TypeOnFormat();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrRecord();
    end;

    local procedure AfterGetCurrRecord()
    begin
        xRec := Rec;
        Rec.CALCFIELDS("Company No.", Type);
    end;

    local procedure AffairNoOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure ContactNoOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure ContactNameOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure RelationTypeOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure RelationDescriptionOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure PhoneNoOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure NoOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure CompanyNoOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;

    local procedure TypeOnFormat()
    begin
        IF Rec.Awarder = TRUE THEN;
    end;
}
