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
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
            }
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
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
        IF Rec."Table Name" = Rec."Table Name"::Customer THEN BEGIN
            IF Customer.GET(Rec.Code) THEN
                Name := Customer.Name;
        END ELSE
            IF Rec."Table Name" = Rec."Table Name"::Vendor THEN
                IF Vendor.GET(Rec.Code) THEN
                    Name := Vendor.Name;
    end;

    trigger OnInit()
    begin
        Name := '';

        IF Rec."No." <> '' THEN
            Rec.SETRANGE("No.", Rec."No.");
        IF Rec.FIND('-') THEN
            REPEAT
                IF (Rec."No." <> '') AND (Rec.Text <> '') THEN
                    IF (Rec.Code <> '') AND (Rec.Code <> SaveCode) THEN BEGIN
                        Rec.MARK(TRUE);
                        SaveCode := Rec.Code;
                    END;
            UNTIL Rec.NEXT() = 0;

        Rec.MARKEDONLY(TRUE);
    end;

    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        SaveCode: Code[20];
        Name: Text[100];

}

