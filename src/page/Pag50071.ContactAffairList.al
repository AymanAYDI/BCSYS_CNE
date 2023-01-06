page 50071 "BC6_Contact Affair List"
{
    Caption = 'Contact Affair Subform', Comment = 'FRA="Contact affaire"';
    PageType = List;
    SourceTable = "BC6_Contact Project Relation";
    ApplicationArea = All;
    UsageCategory = Lists;
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
                field("Affair Description"; Rec."Affair Description")
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
                    Editable = false;
                    ApplicationArea = All;
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
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Company No."; Rec."Company No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fiche affaire")
            {
                Promoted = true;
                RunObject = Page "Job Card";
                RunPageLink = "No." = FIELD("Affair No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ProcOnAfterGetCurrRecord();
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
        ProcOnAfterGetCurrRecord();
    end;

    local procedure ProcOnAfterGetCurrRecord()
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

