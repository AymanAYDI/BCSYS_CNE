page 50068 "Reclass. Card MiniForm F3"
{
    AutoSplitKey = false;
    Caption = 'Reclass.';
    DelayedInsert = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = false;
    SourceTable = Table83;
    SourceTableView = SORTING (Journal Template Name, Journal Batch Name, Line No.)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            field(FromBinCodeCtrl; FromBinCode)
            {
                Caption = 'Bin Code';
                Editable = true;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Bin.Code;
                Visible = FromBinCodeCtrlVisible;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record "7354";
                begin
                    IF ItemNo <> '' THEN BEGIN
                        CLEAR(BinContentForm);
                        BinContent.RESET;
                        IF LocationCode <> '' THEN
                            BinContent.SETRANGE("Location Code", LocationCode);
                        IF ItemNo <> '' THEN
                            BinContent.SETRANGE("Item No.", ItemNo);
                        BinContent.SETFILTER(Quantity, '>%1', 0);
                        IF BinContent.FIND('-') THEN
                            BinContentForm.SETRECORD(BinContent);
                        BinContentForm.SETTABLEVIEW(BinContent);
                        BinContentForm.LOOKUPMODE(TRUE);
                        IF BinContent.FIND('-') THEN
                            BinContentForm.SETRECORD(BinContent);
                        IF BinContentForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            BinContentForm.GETRECORD(BinContent);
                            FromBinCode := BinContent."Bin Code";
                            AssignFromBinCode(FromBinCode);
                        END;
                    END ELSE BEGIN
                        CLEAR(BinForm);
                        Bin.RESET;
                        IF LocationCode <> '' THEN
                            Bin.SETRANGE("Location Code", LocationCode);
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            BinForm.GETRECORD(Bin);
                            FromBinCode := Bin.Code;
                            AssignFromBinCode(FromBinCode);
                        END;
                    END;
                end;

                trigger OnValidate()
                begin
                    FromBinCodeOnAfterValidate;
                end;
            }
            field(ItemNoCtrl; ItemNo)
            {
                Caption = 'Item nr';
                NotBlank = false;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = ItemNoCtrlVisible;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record "27";
                begin
                    CLEAR(ItemForm);
                    Item.RESET;
                    ItemForm.SETTABLEVIEW(Item);
                    ItemForm.LOOKUPMODE(TRUE);
                    IF (ItemNo <> '') THEN
                        IF Item.GET(ItemNo) THEN
                            ItemForm.SETRECORD(Item);
                    IF ItemForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        ItemForm.GETRECORD(Item);
                        ItemNo := Item."No.";
                        AssignItemNo(ItemNo);
                    END;
                end;

                trigger OnValidate()
                begin
                    ItemNoOnAfterValidate;
                end;
            }
            field(Description; Description)
            {
                Editable = false;
            }
            field(QtyCtrl; Qty)
            {
                BlankZero = true;
                Caption = 'Quantity';
                Editable = QtyCtrlEditable;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = QtyCtrlVisible;

                trigger OnValidate()
                begin
                    QtyOnAfterValidate;
                end;
            }
            field(ToBinCodeCtrl; ToBinCode)
            {
                Caption = 'Bin Code';
                Editable = ToBinCodeCtrlEditable;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Bin.Code;
                Visible = ToBinCodeCtrlVisible;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record "7354";
                begin
                    CLEAR(BinForm);
                    Bin.RESET;
                    IF LocationCode <> '' THEN
                        Bin.SETRANGE("Location Code", LocationCode);

                    BinForm.SETTABLEVIEW(Bin);
                    BinForm.LOOKUPMODE(TRUE);
                    IF Bin.FIND('-') THEN
                        BinForm.SETRECORD(Bin);
                    IF BinForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        BinForm.GETRECORD(Bin);
                        ToBinCode := Bin.Code;
                        AssignBinCode(ToBinCode);
                    END;
                end;

                trigger OnValidate()
                begin
                    ToBinCodeOnAfterValidate;
                end;
            }
            field(LocationCodeCtrl; LocationCode)
            {
                Caption = 'Location';
                Editable = false;
                Numeric = false;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Location;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record "14";
                begin

                    CLEAR(LocationForm);
                    Location.RESET;
                    Location.SETRANGE("Bin Mandatory", TRUE);
                    LocationForm.SETTABLEVIEW(Location);
                    LocationForm.LOOKUPMODE(TRUE);
                    IF Location.FIND('-') THEN
                        LocationForm.SETRECORD(Location);
                    IF LocationForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        LocationForm.GETRECORD(Location);
                        LocationCode := Location.Code;
                        AssignLocationCode(LocationCode);
                    END;
                end;

                trigger OnValidate()
                begin
                    LocationCodeOnAfterValidate;
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Item")
            {
                Caption = '&Item';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F2';

                trigger OnAction()
                var
                    PgeLReclassItemSelection: Page "50067";
                begin
                    CLEAR(LastJnlLine);
                    LastJnlLine.RESET;
                    LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    IF LastJnlLine.FIND('+') THEN BEGIN
                        INIT;
                        "Journal Template Name" := LastJnlLine."Journal Template Name";
                        "Journal Batch Name" := LastJnlLine."Journal Batch Name";
                        "Line No." := LastJnlLine."Line No." + 10000;
                        VALIDATE("Entry Type", "Entry Type"::Transfer);
                        VALIDATE("Posting Date", WORKDATE);
                        "Document No." := LastJnlLine."Document No.";
                        "Location Code" := LastJnlLine."Location Code";
                        "Bin Code" := LastJnlLine."Bin Code";
                        INSERT(TRUE);

                        CurrPage.CLOSE;
                        PgeLReclassItemSelection.SETTABLEVIEW(Rec);
                        PgeLReclassItemSelection.RUN;

                    END;
                end;
            }
            action("&Bin")
            {
                Caption = '&Bin';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F3';

                trigger OnAction()
                var
                    PgeLReclassBinSelection: Page "50068";
                begin
                    CLEAR(LastJnlLine);
                    LastJnlLine.RESET;
                    LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    IF LastJnlLine.FIND('+') THEN BEGIN
                        INIT;
                        "Journal Template Name" := LastJnlLine."Journal Template Name";
                        "Journal Batch Name" := LastJnlLine."Journal Batch Name";
                        "Line No." := LastJnlLine."Line No." + 10000;
                        VALIDATE("Entry Type", "Entry Type"::Transfer);
                        VALIDATE("Posting Date", WORKDATE);
                        "Document No." := LastJnlLine."Document No.";
                        "Location Code" := LastJnlLine."Location Code";
                        INSERT(TRUE);

                        CurrPage.CLOSE;
                        PgeLReclassBinSelection.SETTABLEVIEW(Rec);
                        PgeLReclassBinSelection.RUN;

                    END;
                end;
            }
            action("&Post")
            {
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F8';

                trigger OnAction()
                var
                    PgeLReclass: Page "50058";
                begin
                    PostBatch();

                    CurrPage.CLOSE;
                    /*
                    IF ISCLEAR(WshShell) THEN
                      CREATE(WshShell,FALSE ,TRUE);
                    
                    
                    BoolWait := FALSE;
                    WshShell.SendKeys('{F2}', BoolWait);
                    */

                end;
            }
            action("&Quit")
            {
                Caption = '&Quit';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
            action("&Delete")
            {
                Caption = '&Delete';
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    page50068: Page "50068";
                begin
                    DELETE(TRUE);

                    page50068.SETTABLEVIEW(Rec);
                    page50068.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        QtyCtrlEditable := TRUE;
        ToBinCodeCtrlEditable := TRUE;
        QtyCtrlVisible := TRUE;
        ItemNoLibCtrlVisible := TRUE;
        ItemNoCtrlVisible := TRUE;
        ToBinCodeCtrlVisible := TRUE;
        FromBinCodeCtrlVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //NewLine();
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee();
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        //>>MIGRATION 2013
        //NewLine();
        //OnAfterGetCurrRecord;
        //<<MIGRATION 2013
    end;

    var
        InvSetup: Record "313";
        ItemJnlTemplate: Record "82";
        ItemBatchJnl: Record "233";
        WhseEmployee: Record "7301";
        LastJnlLine: Record "83";
        Location: Record "14";
        Bin: Record "7354";
        Item: Record "27";
        BinContent: Record "7302";
        JnlPostBatch: Codeunit "23";
        BatchName: Code[20];
        CurrentLocationCode: Code[20];
        "---": Integer;
        LocationCode: Code[20];
        FromBinCode: Code[20];
        ToBinCode: Code[20];
        ItemNo: Code[20];
        Qty: Code[10];
        PostingDate: Date;
        DocNo: Code[20];
        EntryNo: Integer;
        ShowCtrl: Boolean;
        BarCode: Code[20];
        BarTxt: Text[30];
        PalletBarCode: Boolean;
        EditableCtrl: Boolean;
        EditableLotCtrl: Boolean;
        EditableFromBinCtrl: Boolean;
        ItemNo2: Code[20];
        DistInt: Codeunit "5702";
        txt003: Label 'You cannot delete the entry';
        Text001: Label 'User %1 does not exist on warehouse salary list';
        Text002: Label 'Location %1 incorrect';
        Text006: Label 'Palette nr (%1) incorrect';
        Text013: Label 'Item No. %1 Incorrect';
        Text014: Label 'Item %1 blocked';
        Text012: Label 'Item %1 with tracking';
        ItemError: Boolean;
        ErrorTxt: Text[250];
        ItemTrackingCode: Record "6502";
        Text015: Label 'User %1 model sheet does not exist';
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
        [InDataSet]
        ToBinCodeCtrlVisible: Boolean;
        [InDataSet]
        ItemNoCtrlVisible: Boolean;
        [InDataSet]
        ItemNoLibCtrlVisible: Boolean;
        [InDataSet]
        QtyCtrlVisible: Boolean;
        [InDataSet]
        ToBinCodeCtrlEditable: Boolean;
        [InDataSet]
        QtyCtrlEditable: Boolean;
        ItemForm: Page "50051";
        LocationForm: Page "50053";
        BinForm: Page "50052";
        BinContentForm: Page "50054";
        WshShell: Automation;
        BoolWait: Boolean;

    [Scope('Internal')]
    procedure NewLine()
    begin
        BarCode := '';
        FromBinCode := '';
        ToBinCode := '';
        ItemNo := '';
        Qty := '';
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        CLEAR(LastJnlLine);
        LastJnlLine.RESET;
        LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF NOT LastJnlLine.FIND('+') THEN BEGIN
            LastJnlLine.INIT;
            LastJnlLine."Journal Template Name" := "Journal Template Name";
            LastJnlLine."Journal Batch Name" := "Journal Batch Name";
            LastJnlLine."Line No." := 0;
        END;

        SetUpNewLine(xRec);
        "Entry Type" := "Entry Type"::Transfer;
        "Line No." := LastJnlLine."Line No." + 10000;
        VALIDATE("Posting Date", WORKDATE);

        IF LocationCode = '' THEN
            LocationCode := Location.Code;

        AssignLocationCode(LocationCode);
    end;

    [Scope('Internal')]
    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "7301";
        WmsManagement: Codeunit "7302";
        CurrentLocationCode: Code[10];
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("Item Jnl Template Name 2");

        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FIND('-') THEN BEGIN
                WhseEmployee.SETRANGE(Default, TRUE);
                IF WhseEmployee.FIND('-') THEN
                    LocationCode := WhseEmployee."Location Code"
                ELSE
                    LocationCode := WmsManagement.GetDefaultLocation;
                IF NOT Location.GET(LocationCode) THEN
                    Location.INIT;
                FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."Item Jnl Template Name 2");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
                ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                ItemBatchJnl.SETRANGE("Assigned User ID", USERID);
                IF ItemBatchJnl.FIND('-') THEN BEGIN
                    ItemBatchJnl.TESTFIELD("No. Series");
                    BatchName := ItemBatchJnl.Name;
                    SETFILTER("Journal Template Name", ItemBatchJnl."Journal Template Name");
                    SETFILTER("Journal Batch Name", BatchName);
                END ELSE BEGIN
                    ERROR(Text015, USERID);
                    EXIT(FALSE);
                END;
                FILTERGROUP := 0;
                PostingDate := WORKDATE;
                IF Rec.FIND('+') THEN;
                EXIT(TRUE);
            END ELSE BEGIN
                ERROR(Text001, USERID);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            ERROR('');
            EXIT(FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure AssignLocationCode(var LocationCode: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        CLEAR(Location);
        IF (LocationCode <> '') AND
           (STRLEN(LocationCode) < 20) THEN BEGIN
            IF Location.GET(LocationCode) THEN
                "Location Code" := LocationCode;
        END ELSE BEGIN
            LocationCode := '';
            "Location Code" := LocationCode;
            MESSAGE(Text004);
        END;
    end;

    [Scope('Internal')]
    procedure AssignBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> "New Bin Code") THEN
                VALIDATE("New Location Code", "Location Code");
            VALIDATE("New Bin Code", BinCode);
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        "New Bin Code" := BinCode;
    end;

    [Scope('Internal')]
    procedure AssignFromBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> "Bin Code") THEN
                // VALIDATE("Bin Code",BinCode);
                "Bin Code" := BinCode;
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        "Bin Code" := BinCode;
    end;

    [Scope('Internal')]
    procedure AssignItemNo(var ItemNo: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        ItemError := FALSE;
        ErrorTxt := '';

        IF (ItemNo <> '') THEN BEGIN
            IF CodeEANOk(ItemNo) THEN BEGIN
                ItemNo2 := DistInt.GetItem(ItemNo);
                IF Item.GET(ItemNo2) THEN
                    ItemNo := Item."No."
                ELSE BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemNo);
                END;
            END ELSE BEGIN
                IF NOT Item.GET(ItemNo) THEN BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemNo);
                END;
            END;

            IF Item.Blocked THEN BEGIN
                IF NOT ItemError THEN
                    ErrorTxt := STRSUBSTNO(Text014, Item."No.");
                ItemError := TRUE;
            END;

            CLEAR(ItemTrackingCode);
            IF ItemTrackingCode.GET(Item."Item Tracking Code") AND
               (ItemTrackingCode."Lot Transfer Tracking" OR
               ItemTrackingCode."SN Warehouse Tracking")
               THEN BEGIN
                IF NOT ItemError THEN
                    ErrorTxt := STRSUBSTNO(Text012, Item."No.");
                ItemError := TRUE;
            END;

        END;

        IF ItemError THEN BEGIN
            MESSAGE('%1', ErrorTxt);
        END ELSE BEGIN
            VALIDATE("Item No.", ItemNo);
            VALIDATE("Bin Code", FromBinCode);
            VALIDATE(Quantity, 1);
        END;

        UpdateCurrForm();
    end;

    [Scope('Internal')]
    procedure AssignQty(var Qty: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        IF (Qty <> '') THEN BEGIN
            EVALUATE(Quantity, Qty);
            VALIDATE(Quantity);
            Qty := FORMAT(Quantity);
            EXIT;
        END;

        IF Qty <> '' THEN
            MESSAGE(Text006, Qty);
        Qty := '';
        VALIDATE(Quantity, 0);
        Qty := FORMAT(Quantity);
    end;

    [Scope('Internal')]
    procedure PostBatch()
    begin
        CLEAR(JnlPostBatch);
        JnlPostBatch.RUN(Rec);
    end;

    [Scope('Internal')]
    procedure InitForm(Picking: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure CtrlEnabled()
    begin
        // CurrForm.FromBinCodeCtrl.EDITABLE(EditableCtrl);
        FromBinCodeCtrlVisible := ShowCtrl;
        ToBinCodeCtrlEditable := EditableCtrl;
        ToBinCodeCtrlVisible := ShowCtrl;
        ItemNoCtrlVisible := ShowCtrl;
        ItemNoLibCtrlVisible := ShowCtrl;
        QtyCtrlVisible := ShowCtrl;
        QtyCtrlEditable := EditableCtrl;
    end;

    [Scope('Internal')]
    procedure UpdateCurrForm()
    begin
        BarCode := '';
        LocationCode := "Location Code";
        IF NOT Location.GET("Location Code") THEN
            Location.INIT;
        FromBinCode := "Bin Code";
        ToBinCode := "New Bin Code";
        ItemNo := "Item No.";
        Qty := FORMAT(Quantity);
        EditableCtrl := ("Item No." <> '');
        CtrlEnabled;
    end;

    [Scope('Internal')]
    procedure CodeEANOk("Code": Code[20]) CodeOk: Boolean
    var
        i: Integer;
    begin
        IF (STRLEN(Code) = 13) THEN BEGIN
            CodeOk := TRUE;
            FOR i := 1 TO STRLEN(Code) DO BEGIN
                IF NOT (Code[i] IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) THEN BEGIN
                    CodeOk := FALSE;
                    EXIT(CodeOk);
                END;
            END;
        END ELSE
            CodeOk := FALSE;
    end;

    local procedure FromBinCodeOnAfterValidate()
    begin
        AssignFromBinCode(FromBinCode);
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        AssignLocationCode(LocationCode);
    end;

    local procedure ToBinCodeOnAfterValidate()
    begin
        AssignBinCode(ToBinCode);
    end;

    local procedure ItemNoOnAfterValidate()
    begin
        AssignItemNo(ItemNo);
    end;

    local procedure QtyOnAfterValidate()
    begin
        AssignQty(Qty);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
    end;
}

