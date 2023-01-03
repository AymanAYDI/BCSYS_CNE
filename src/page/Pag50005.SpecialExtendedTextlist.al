page 50005 "BC6_Special Extended Text list"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "BC6_Special Extended Text Line";
    UsageCategory = None;
    Caption = 'Special Extended Text list';
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
                    Caption = 'Name', comment = 'FRA="Nom"';
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
            IF "Table Name" = "Table Name"::Vendor THEN
                IF Vendor.GET(Code) THEN
                    Name := Vendor.Name;
    end;

    trigger OnInit()
    begin
        Name := '';

        IF "No." <> '' THEN
            SETRANGE("No.", "No.");
        IF FIND('-') THEN
            REPEAT
                IF ("No." <> '') AND (Text <> '') THEN
                    IF (Code <> '') AND (Code <> SaveCode) THEN BEGIN
                        MARK(TRUE);
                        SaveCode := Code;
                    END;
            UNTIL NEXT() = 0;

        MARKEDONLY(TRUE);
    end;

    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        SaveCode: Code[20];
        Name: Text[100];

}

