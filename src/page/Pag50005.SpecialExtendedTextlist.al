page 50005 "BC6_Special Extended Text list"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "BC6_Special Extended Text Line";

    layout
    {
        area(content)
        {
            group(Control1100267000)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
            }
            repeater(Control1000000000)
            {
                field("Code"; Code)
                {
                }
                field(Name; Name)
                {
                    Caption = 'Name';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        Name := '';
        IF "Table Name" = "Table Name"::Customer THEN BEGIN
            IF Customer.GET(Code) THEN
                Name := Customer.Name;
        END ELSE
            IF "Table Name" = "Table Name"::Vendor THEN BEGIN
                IF Vendor.GET(Code) THEN
                    Name := Vendor.Name;
            END;
    end;

    trigger OnInit()
    begin
        Name := '';

        IF "No." <> '' THEN
            SETRANGE("No.", "No.");
        IF FIND('-') THEN BEGIN
            REPEAT
                IF ("No." <> '') AND (Text <> '') THEN
                    IF (Code <> '') AND (Code <> SaveCode) THEN BEGIN
                        MARK(TRUE);
                        SaveCode := Code;
                    END;
            UNTIL NEXT = 0;
        END;
        MARKEDONLY(TRUE);
    end;

    var
        Name: Text[30];
        Customer: Record Customer;
        Vendor: Record Vendor;
        SaveCode: Code[20];

    local procedure OnBeforePutRecord()
    begin
        MARK(FALSE);
    end;
}
