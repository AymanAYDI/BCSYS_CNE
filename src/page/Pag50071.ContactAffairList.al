page 50071 "BC6_Contact Affair List"
{
    Caption = 'Contact Affair Subform', Comment = 'FRA="Contact affaire"';
    PageType = List;
    SourceTable = "BC6_Contact Project Relation";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Affair No."; "Affair No.")
                {
                    ApplicationArea = All;
                }
                field("Affair Description"; "Affair Description")
                {
                    ApplicationArea = All;
                }
                field("Affair Responsible"; "Affair Responsible")
                {
                    ApplicationArea = All;
                }
                field(Statut; Statut)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; "Contact Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Contact City"; "Contact City")
                {
                    ApplicationArea = All;
                }
                field("Contact Post Code"; "Contact Post Code")
                {
                    ApplicationArea = All;
                }
                field(Awarder; Awarder)
                {
                    ApplicationArea = All;
                }
                field("Relation Type"; "Relation Type")
                {
                    ApplicationArea = All;
                }
                field("Relation Description"; "Relation Description")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Company No."; "Company No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Type)
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
        OnAfterGetCurrRecord;
        AffairNoOnFormat;
        ContactNoOnFormat;
        ContactNameOnFormat;
        RelationTypeOnFormat;
        RelationDescriptionOnFormat;
        PhoneNoOnFormat;
        NoOnFormat;
        CompanyNoOnFormat;
        TypeOnFormat;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        //>>CNE2.05
        CALCFIELDS("Company No.", Type);
        //<<CNE2.05
    end;

    local procedure AffairNoOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure ContactNoOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure ContactNameOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure RelationTypeOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure RelationDescriptionOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure PhoneNoOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure NoOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure CompanyNoOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;

    local procedure TypeOnFormat()
    begin
        IF Awarder = TRUE THEN;
    end;
}

