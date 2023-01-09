page 50004 "BC6_Special Extended Text"
{
    AutoSplitKey = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "BC6_Special Extended Text Line";
    UsageCategory = None;
    Caption = 'Special Extended Text', comment = 'FRA=""';
    layout
    {
        area(content)
        {
            group(Control1100267000)
            {
                field("No."; Rec."No.")
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
                field("Code"; Rec.Code)
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
                field("Table Name"; Rec."Table Name")
                {
                    Visible = false;
                }
                field(No2; Rec."No.")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Text"; Rec.Text)
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
                Caption = 'List', Comment = 'FRA="Liste"';
                Image = List;
                RunPageOnRec = true;
                trigger OnAction()
                begin

                    SpecialExtendedTextLine2.RESET();
                    IF CurrentType = CurrentType::Customer THEN
                        SpecialExtendedTextLine2.SETRANGE("Table Name", Rec."Table Name"::Customer);
                    IF CurrentType = CurrentType::vendor THEN
                        SpecialExtendedTextLine2.SETRANGE("Table Name", Rec."Table Name"::Vendor);
                    SpecialExtendedTextLine2.SETRANGE("Table Name", Rec."Table Name");
                    SpecialExtendedTextLine2.SETRANGE("No.", Rec."No.");
                    IF PAGE.RUNMODAL(PAGE::"BC6_Special Extended Text list", SpecialExtendedTextLine2) = ACTION::LookupOK THEN BEGIN
                        CurrPage.UPDATE(FALSE);
                        Rec.Code := SpecialExtendedTextLine2.Code;
                        CurrentCode := SpecialExtendedTextLine2.Code;
                        // Lecture de la table Customer ou Vendor
                        IF Rec."Table Name" = Rec."Table Name"::Customer THEN BEGIN
                            IF TableCustomer.GET(Rec.Code) THEN
                                CustomerName := TableCustomer.Name;
                            Rec.Code := TableCustomer."No.";
                        END ELSE BEGIN
                            IF TableVendor.GET(Rec.Code) THEN
                                CustomerName := TableVendor.Name;
                            Rec.Code := TableVendor."No.";
                        END;
                        CurrentCode := Rec.Code;

                        Rec.RESET();
                        Rec.SETRANGE("Table Name", Rec."Table Name");
                        Rec.SETRANGE("No.", Rec."No.");
                        Rec.SETRANGE(Code, CurrentCode);
                        Rec.FIND();
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        CurrentCode := '';
        Rec.RESET();
        Rec.SETRANGE("Table Name", CurrentType);
        Rec.SETRANGE("No.", CurrentNo);
        Rec.SETRANGE(Code, Rec.Code);
        IF (CurrentType <> Rec."Table Name") OR (Rec.Code = '') THEN BEGIN
            CurrentCode := '';
            Rec.Code := '';
            Rec.RESET();
            SpecialExtendedTextLine.RESET();
            SpecialExtendedTextLine.SETRANGE(SpecialExtendedTextLine."Table Name", CurrentType);
            SpecialExtendedTextLine.SETRANGE(SpecialExtendedTextLine."No.", CurrentNo);
            IF SpecialExtendedTextLine.FIND('-') THEN BEGIN
                Rec.Code := SpecialExtendedTextLine.Code;
                CurrentCode := SpecialExtendedTextLine.Code;
            END;
            Rec.SETRANGE("Table Name", CurrentType);
            Rec.SETRANGE("No.", CurrentNo);
            Rec.SETRANGE(Code, Rec.Code);
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
        IF Rec."Table Name" = Rec."Table Name"::Customer THEN BEGIN
            IF TableCustomer.GET(Rec.Code) THEN
                CustomerName := TableCustomer.Name;
            Rec.Code := TableCustomer."No.";
        END ELSE BEGIN
            IF TableVendor.GET(Rec.Code) THEN
                CustomerName := TableVendor.Name;
            Rec.Code := TableVendor."No.";
        END;
        CurrentCode := Rec.Code;
        Rec.RESET();
        Rec.SETRANGE("Table Name", Rec."Table Name");
        Rec.SETRANGE("No.", Rec."No.");
        Rec.SETRANGE(Code, CurrentCode);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnActivateForm()
    begin
        TableItem.GET(CurrentNo);
        ItemName := TableItem.Description;
    end;
}
