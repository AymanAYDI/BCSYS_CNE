page 50004 "BC6_Special Extended Text"
{
    AutoSplitKey = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "BC6_Special Extended Text Line";

    layout
    {
        area(content)
        {
            group(Control1100267000)
            {
                field("No."; "No.")
                {
                    Caption = 'Item Code', comment = 'FRA="Code Article"';
                    Editable = false;
                }
                field(ItemName; ItemName)
                {
                    Caption = 'Item Name', comment = 'FRA="Nom de l''article "';
                    Editable = false;
                    Enabled = true;
                }
            }
            group(Control1100267001)
            {
                Visible = true;
                field("Code"; Code)
                {
                    Caption = 'Code';
                    Lookup = true;

                    trigger OnValidate()
                    begin
                        CodeOnAfterValidate();
                    end;
                }
                field(CustomerName; CustomerName)
                {
                    Caption = 'Customer Name', comment = 'FRA="Nom de client"';
                    Editable = false;
                    Enabled = true;
                }
            }
            repeater(Control1000000000)
            {
                field("Table Name"; "Table Name")
                {
                    Visible = false;
                }
                field(No2; "No.")
                {
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Text"; Text)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(List)
            {
                Caption = 'List';
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;

                trigger OnAction()
                begin

                    SpecialExtendedTextLine2.RESET();
                    IF CurrentType = CurrentType::Customer THEN
                        SpecialExtendedTextLine2.SETRANGE("Table Name", "Table Name"::Customer);
                    IF CurrentType = CurrentType::vendor THEN
                        SpecialExtendedTextLine2.SETRANGE("Table Name", "Table Name"::Vendor);
                    SpecialExtendedTextLine2.SETRANGE("Table Name", "Table Name");
                    SpecialExtendedTextLine2.SETRANGE("No.", "No.");
                    IF PAGE.RUNMODAL(PAGE::"BC6_Special Extended Text list", SpecialExtendedTextLine2) = ACTION::LookupOK THEN BEGIN
                        CurrPage.UPDATE(FALSE);
                        Code := SpecialExtendedTextLine2.Code;
                        CurrentCode := SpecialExtendedTextLine2.Code;
                        // Lecture de la table Customer ou Vendor
                        IF "Table Name" = "Table Name"::Customer THEN BEGIN
                            IF TableCustomer.GET(Code) THEN
                                CustomerName := TableCustomer.Name;
                            Code := TableCustomer."No.";
                        END ELSE BEGIN
                            IF TableVendor.GET(Code) THEN
                                CustomerName := TableVendor.Name;
                            Code := TableVendor."No.";
                        END;
                        CurrentCode := Code;

                        RESET();
                        SETRANGE("Table Name", "Table Name");
                        SETRANGE("No.", "No.");
                        SETRANGE(Code, CurrentCode);
                        FIND();
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        CurrentCode := '';
        RESET();
        SETRANGE("Table Name", CurrentType);
        SETRANGE("No.", CurrentNo);
        SETRANGE(Code, Code);
        IF (CurrentType <> "Table Name") OR (Code = '') THEN BEGIN
            CurrentCode := '';
            Code := '';
            RESET();
            SpecialExtendedTextLine.RESET();
            SpecialExtendedTextLine.SETRANGE(SpecialExtendedTextLine."Table Name", CurrentType);
            SpecialExtendedTextLine.SETRANGE(SpecialExtendedTextLine."No.", CurrentNo);
            IF SpecialExtendedTextLine.FIND('-') THEN BEGIN
                Code := SpecialExtendedTextLine.Code;
                CurrentCode := SpecialExtendedTextLine.Code;
            END;
            SETRANGE("Table Name", CurrentType);
            SETRANGE("No.", CurrentNo);
            SETRANGE(Code, Code);
        END;
        OnActivateForm();
    end;

    var
        SpecialExtendedTextLine: Record "BC6_Special Extended Text Line";
        SpecialExtendedTextLine2: Record "BC6_Special Extended Text Line";
        TableCustomer: Record Customer;
        TableItem: Record Item;
        TableVendor: Record Vendor;
        CurrentCode: Code[20];
        CurrentNo: Code[20];
        CurrentType: Enum "Credit Transfer Account Type";
        CustomerName: Text[100];
        ItemName: Text[100];

    local procedure CodeOnAfterValidate()
    begin
        IF "Table Name" = "Table Name"::Customer THEN BEGIN
            IF TableCustomer.GET(Code) THEN
                CustomerName := TableCustomer.Name;
            Code := TableCustomer."No.";
        END ELSE BEGIN
            IF TableVendor.GET(Code) THEN
                CustomerName := TableVendor.Name;
            Code := TableVendor."No.";
        END;
        CurrentCode := Code;
        RESET();
        SETRANGE("Table Name", "Table Name");
        SETRANGE("No.", "No.");
        SETRANGE(Code, CurrentCode);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnActivateForm()
    begin
        TableItem.GET(CurrentNo);
        ItemName := TableItem.Description;
    end;
}
