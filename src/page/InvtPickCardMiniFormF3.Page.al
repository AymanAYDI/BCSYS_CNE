page 50064 "Invt. Pick Card MiniForm F3"
{
    AutoSplitKey = false;
    Caption = 'Invt Pick Card';
    DataCaptionFields = "Whse. Document No.", "Line No.";
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
            field(LocationCodeCtrl; LocationCode)
            {
                Caption = 'Location';
                Editable = false;
                Numeric = false;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Location;
                Visible = LocationCodeVisible;

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
                    IF ItemNo <> '' THEN
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
                        IF ToBinCodeCtrlEditable THEN BEGIN
                            ToBinCode := Bin.Code;
                            AssignBinCode(ToBinCode);
                        END;
                    END;
                end;

                trigger OnValidate()
                begin
                    ToBinCodeOnAfterValidate;
                end;
            }
            field(PickNoCtrl; PickNo)
            {
                Caption = 'Pick No.';
                Editable = false;
                Numeric = false;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = PickNoCtrlVisible;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record "14";
                begin

                    CLEAR(InvtPickForm);
                    InvtPick.RESET;
                    InvtPickForm.LOOKUPMODE(TRUE);
                    IF (PickNo <> '') THEN
                        IF InvtPick.GET(InvtPick.Type::"Invt. Pick", PickNo) THEN
                            InvtPickForm.SETRECORD(InvtPick);
                    InvtPickForm.SETTABLEVIEW(InvtPick);
                    IF InvtPickForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        InvtPickForm.GETRECORD(InvtPick);
                        PickNo := InvtPick."No.";
                        AssignPickNo(PickNo);
                    END;
                end;

                trigger OnValidate()
                begin
                    PickNoOnAfterValidate;
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
                Image = item;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F2';

                trigger OnAction()
                var
                    page50063: Page "50063";
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
                        AssignPickNo(PickNo);
                        "Location Code" := LastJnlLine."Location Code";
                        "Bin Code" := LastJnlLine."Bin Code";
                        INSERT(TRUE);
                    END;

                    VisibleTestBool := FALSE;
                    ToBinCodeCtrlVisible := FALSE;

                    CurrPage.CLOSE;
                    page50063.SETTABLEVIEW(Rec);
                    page50063.RUN;
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
                    page50064: Page "50064";
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
                        AssignPickNo(PickNo);
                        "Location Code" := LastJnlLine."Location Code";
                        //SOBI
                        //"Item No." := LastJnlLine."Item No.";
                        //Description := LastJnlLine.Description;
                        //AssignItemNo(LastJnlLine."Item No.");
                        //SOBI

                        INSERT(TRUE);
                    END;

                    CurrPage.CLOSE;
                    page50064.SETTABLEVIEW(Rec);
                    page50064.RUN;
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
                    page50059: Page "50059";
                begin
                    /*
                    IF ISCLEAR(WshShell) THEN
                      CREATE(WshShell,FALSE ,TRUE);
                    
                    BoolWait := FALSE;
                    WshShell.SendKeys('{TAB}', BoolWait);
                             */
                    PostBatch();

                    CurrPage.CLOSE;

                end;
            }
            action("&Quit")
            {
                Caption = '&Quit';
                Image = cancel;
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
                    page50064: Page "50064";
                begin
                    DELETE(TRUE);

                    page50064.SETTABLEVIEW(Rec);
                    page50064.RUN;
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

        //VisibleTestBool := TRUE;

        QtyCtrlEditable := TRUE;
        ToBinCodeCtrlEditable := TRUE;
        QtyCtrlVisible := TRUE;
        ItemNoLibCtrlVisible := TRUE;
        ItemNoCtrlVisible := TRUE;

        FromBinCodeCtrlVisible := TRUE;
        PickNoLibCtrlVisible := TRUE;
        PickNoCtrlVisible := TRUE;
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

        ToBinCodeCtrlVisible := TRUE;
    end;

    var
        InvSetup: Record "313";
        ItemJnlTemplate: Record "82";
        ItemBatchJnl: Record "233";
        txt003: Label 'You cannot delete the entry';
        WhseEmployee: Record "7301";
        LastJnlLine: Record "83";
        InvtPick: Record "5766";
        InvtPickLine: Record "5767";
        ItemTrackingCode: Record "6502";
        Location: Record "14";
        Text001: Label 'User %1 does not exist on warehouse salary list';
        Text002: Label 'Location %1 incorrect';
        Text006: Label 'Palette nr (%1) incorrect';
        Bin: Record "7354";
        Item: Record "27";
        BinContent: Record "7302";
        JnlPostBatch: Codeunit "23";
        BatchName: Code[20];
        CurrentLocationCode: Code[20];
        DefaultLocationCode: Code[20];
        "---": Integer;
        PickNo: Code[20];
        LocationCode: Code[20];
        FromBinCode: Code[20];
        ToBinCode: Code[20];
        ShipBinCode: Code[20];
        ItemNo: Code[20];
        Qty: Code[10];
        PostingDate: Date;
        DocNo: Code[20];
        ShowCtrl: Boolean;
        EditableCtrl: Boolean;
        EditableFromBinCtrl: Boolean;
        ItemNo2: Code[20];
        DistInt: Codeunit "5702";
        Text016: Label 'Item %1 not exit on Invt. Pick';
        ErrorTxt: Text[250];
        Text013: Label 'Item No. %1 Incorrect';
        Text014: Label 'Item %1 blocked';
        Text012: Label 'Item %1 with tracking';
        Text015: Label 'User %1 model sheet does not exist';
        [InDataSet]
        ToBinCodeCtrlEditable: Boolean;
        [InDataSet]
        PickNoCtrlVisible: Boolean;
        [InDataSet]
        PickNoLibCtrlVisible: Boolean;
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
        QtyCtrlEditable: Boolean;
        LocationCodeVisible: Boolean;
        InvtPickForm: Page "50055";
        LocationForm: Page "50053";
        BinContentForm: Page "50054";
        BinForm: Page "50052";
        ItemForm: Page "50051";
        VisibleTestBool: Boolean;
        WshShell: Automation;
        BoolWait: Boolean;

    [Scope('Internal')]
    procedure NewLine()
    begin
        FromBinCode := '';
        ToBinCode := '';
        ItemNo := '';
        Qty := '';
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;
        VisibleTestBool := FALSE;
        CLEAR(InvtPick);
        CLEAR(InvtPickLine);

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
        AssignPickNo(PickNo);

        LocationCode := DefaultLocationCode;
        AssignLocationCode(LocationCode);

        ToBinCodeCtrlVisible := FALSE;
    end;

    [Scope('Internal')]
    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "7301";
        WmsManagement: Codeunit "7302";
        CurrentLocationCode: Code[10];
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FIND('-') THEN BEGIN
                WhseEmployee.SETRANGE(Default, TRUE);
                IF WhseEmployee.FIND('-') THEN
                    DefaultLocationCode := WhseEmployee."Location Code"
                ELSE
                    DefaultLocationCode := WmsManagement.GetDefaultLocation;
                IF NOT Location.GET(LocationCode) THEN
                    Location.INIT;
                FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."Item Jnl Template Name 1");
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
    procedure AssignPickNo(var PickNo: Code[20])
    begin
        IF InvtPick.GET(InvtPick.Type::"Invt. Pick", PickNo) THEN BEGIN
            "Whse. Document Type" := "Whse. Document Type"::"Invt. Pick";
            VALIDATE("Whse. Document No.", PickNo);
        END ELSE BEGIN
            "Whse. Document Type" := "Whse. Document Type"::" ";
            VALIDATE("Whse. Document No.", '');

        END;

        UpdateCurrForm();
    end;

    [Scope('Internal')]
    procedure AssignLocationCode(var LocationCode: Code[20])
    var
        Text004: Label 'Bar code incorrect';
    begin
        CLEAR(Location);
        IF (LocationCode <> '') AND
           (STRLEN(LocationCode) < 20) THEN BEGIN
            IF Location.GET(LocationCode) THEN BEGIN
                "Location Code" := LocationCode;
                ShipBinCode := Location."Shipment Bin Code";
            END;
        END ELSE BEGIN
            ShipBinCode := '';
            LocationCode := '';
            "Location Code" := LocationCode;
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
            "New Bin Code" := BinCode;
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
        // TESTFIELD("Whse. Document No.");
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
        ItemError: Boolean;
    begin
        // TESTFIELD("Whse. Document No.");
        ItemError := FALSE;
        ErrorTxt := '';

        IF (ItemNo <> '') THEN BEGIN
            TESTFIELD("Whse. Document No.");
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

            IF NOT ItemExistOnInvtPick(ItemNo, '') THEN BEGIN
                IF NOT ItemError THEN
                    ErrorTxt := STRSUBSTNO(Text016, ItemNo, "Whse. Document No.");
                ItemError := TRUE;
            END;
        END;

        IF ItemError THEN BEGIN
            MESSAGE('%1', ErrorTxt);
        END ELSE BEGIN
            VALIDATE("Item No.", ItemNo);
            VALIDATE("Bin Code", FromBinCode);
            VALIDATE(Quantity, 1);
            IF ShipBinCode <> '' THEN BEGIN
                ToBinCode := ShipBinCode;
                AssignBinCode(ToBinCode);
            END;
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
            AssignBinCode(ToBinCode);
            UpdateCurrForm();
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
        //CLEAR(JnlPostBatch);
        JnlPostBatch.RUN(Rec);
    end;

    [Scope('Internal')]
    procedure InitForm(Picking: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure CtrlEnabled()
    begin
        PickNoCtrlVisible := ShowCtrl;
        PickNoLibCtrlVisible := ShowCtrl;
        // CurrForm.FromBinCodeCtrl.EDITABLE(EditableCtrl);
        FromBinCodeCtrlVisible := ShowCtrl;
        //CurrForm.ToBinCodeCtrl.EDITABLE(EditableCtrl);
        ToBinCodeCtrlEditable := FALSE;
        ToBinCodeCtrlVisible := ShowCtrl;
        ToBinCodeCtrlVisible := VisibleTestBool;
        ItemNoCtrlVisible := ShowCtrl;
        ItemNoLibCtrlVisible := ShowCtrl;
        QtyCtrlVisible := ShowCtrl;
        QtyCtrlEditable := EditableCtrl;
    end;

    [Scope('Internal')]
    procedure UpdateCurrForm()
    begin

        PickNo := "Whse. Document No.";
        LocationCode := "Location Code";
        IF NOT Location.GET("Location Code") THEN BEGIN
            Location.INIT;
            ShipBinCode := '';
        END;
        FromBinCode := "Bin Code";
        ToBinCode := "New Bin Code";
        ItemNo := "Item No.";
        Qty := FORMAT(Quantity);
        EditableCtrl := ("Item No." <> '');
        CtrlEnabled;
    end;

    [Scope('Internal')]
    procedure ItemExistOnInvtPick(ItemNo: Code[20]; BinCode: Code[20]): Boolean
    var
        SalesLine: Record "37";
    begin
        IF ("Whse. Document No." <> '') THEN BEGIN
            IF InvtPick.GET(InvtPick.Type::"Invt. Pick", "Whse. Document No.") AND
               InvtPick."Sales Counter" THEN BEGIN
                IF Location.GET("Location Code") THEN
                    ShipBinCode := Location."Shipment Bin Code";
                EXIT(TRUE);
            END;

            InvtPickLine.RESET;
            InvtPickLine.SETRANGE("Activity Type", InvtPickLine."Activity Type"::"Invt. Pick");
            InvtPickLine.SETRANGE("No.", "Whse. Document No.");
            InvtPickLine.SETRANGE("Item No.", ItemNo);
            IF BinCode <> '' THEN
                InvtPickLine.SETRANGE("Bin Code", BinCode);
            InvtPickLine.SETFILTER(Quantity, '<>%1', 0);
            IF InvtPickLine.FIND('-') THEN BEGIN
                CASE InvtPickLine."Source Type" OF
                    37:
                        IF SalesLine.GET(SalesLine."Document Type"::Order, InvtPickLine."Source No.", InvtPickLine."Source Line No.") AND
                          (SalesLine."Location Code" = InvtPickLine."Location Code") THEN
                            ShipBinCode := SalesLine."Bin Code";
                END;
                EXIT(TRUE);
            END;
        END;
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

    local procedure PickNoOnAfterValidate()
    begin
        AssignPickNo(PickNo);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
        ToBinCodeCtrlVisible := FALSE;
    end;
}

