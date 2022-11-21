page 50031 "BC6_Contact Affair Subform"
{
    Caption = 'Contact Affair Subform';
    PageType = ListPart;
    SourceTable = "BC6_Contact Project Relation";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Affair No."; "Affair No.")
                {
                }
                field("Affair Responsible"; "Affair Responsible")
                {
                }
                field(Statut; Statut)
                {
                }
                field(Blocked; Blocked)
                {
                }
                field("Contact No."; "Contact No.")
                {
                }
                field("Contact Name"; "Contact Name")
                {
                    Editable = false;
                }
                field("Contact City"; "Contact City")
                {
                }
                field("Contact Post Code"; "Contact Post Code")
                {
                }
                field(Awarder; Awarder)
                {
                }
                field("Relation Type"; "Relation Type")
                {
                }
                field("Relation Description"; "Relation Description")
                {
                    Editable = false;
                    Enabled = true;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Company No."; "Company No.")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
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
        OnAfterGetCurrRecord();
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
        OnAfterGetCurrRecord();
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CALCFIELDS("Company No.", Type);
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

