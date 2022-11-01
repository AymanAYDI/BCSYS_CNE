page 50033 "Affair Steps Sub-form"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : Gestion des appeles d'offres clients
    //  - Form created
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_A.002:LY 25/01/2008 : - Add Delay On Insert-> Yes
    // 
    // //>>CNE3.01
    // FE-ADV_20080418_CNE_adjudic.001:NIRO 03/11/09 : - add code in onformat on all fields
    // 
    // ------------------------------------------------------------------------

    Caption = 'Affair Steps Sub-form';
    PageType = ListPart;
    SourceTable = Table50010;

    layout
    {
        area(content)
        {
            repeater()
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
        NoOnFormat;
        StepDateOnFormat;
        InterlocutorOnFormat;
        ContactOnFormat;
        ContactNameOnFormat;
        DescriptionOnFormat;
        ReminderDateOnFormat;
        DocumentNoOnFormat;
        ResultOnFormat;
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
        RecGContactProjectRelation: Record "50009";

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

