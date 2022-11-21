page 50058 "BC6_Reclass. Card MiniForm"
{
    AutoSplitKey = false;
    Caption = 'Reclass.';
    DataCaptionExpression = GetCaptionClass;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    SaveValues = false;
    SourceTable = "Item Journal Line";
    SourceTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(Control1)
            {
                usercontrol(ScanZone; "ControlAddinScanCapture")
                {
                    Visible = true;

                    trigger ControlAddInReady()
                    begin
                        IsReady := TRUE;
                        CurrPage.ScanZone.AddControl(1, FromBinCaption, FromBinCode);
                        CurrPage.ScanZone.AddControl(2, ItemNoCaption, ItemNo);
                        CurrPage.ScanZone.AddControl(3, QuantityCaption, Qty);
                        CurrPage.ScanZone.AddControl(4, ToBinCaption, ToBinCode);
                        CurrPage.ScanZone.SetFocus(1);
                        CurrPage.ScanZone.SetHide(2, FALSE);
                        CurrPage.ScanZone.SetHide(3, FALSE);
                        CurrPage.ScanZone.SetHide(4, FALSE);
                    end;

                    trigger KeyPressed(index: Integer; data: Text)
                    begin
                        CASE data OF
                            '113':
                                CurrPage.ScanZone.SubmitAllData(2); //F2
                            '114':
                                CurrPage.ScanZone.SubmitAllData(3); //F3
                            '121':
                                CurrPage.ScanZone.SubmitAllData(1); //F10
                        END;
                    end;

                    trigger TextCaptured(index: Integer; data: Text)
                    begin
                        CASE index OF
                            1:
                                BEGIN
                                    FromBinCode := COPYSTR(data, 1, MAXSTRLEN(FromBinCode));
                                    AssignFromBinCode(FromBinCode);
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, FromBinCode);
                                END;

                            2:
                                BEGIN
                                    ItemNo := COPYSTR(data, 1, MAXSTRLEN(ItemNo));
                                    AssignItemNo(ItemNo);
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, ItemNo);
                                    CurrPage.ScanZone.SetText(index + 1, Qty);
                                END;

                            3:
                                BEGIN
                                    Qty := COPYSTR(data, 1, MAXSTRLEN(Qty));
                                    AssignQty(Qty);
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, Qty);
                                END;

                            4:
                                BEGIN
                                    ToBinCode := COPYSTR(data, 1, MAXSTRLEN(ToBinCode));
                                    AssignBinCode(ToBinCode);
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, ToBinCode);
                                END;
                        END;
                        CurrPage.ScanZone.SetHide(index + 1, FALSE);
                        CurrPage.ScanZone.SetFocus(index + 1);
                    end;

                    trigger AddInDrillDown(index: Integer; data: Text)
                    begin
                        CASE index OF
                            1:
                                BEGIN
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
                                            CurrPage.ScanZone.SetText(1, FromBinCode);
                                            CurrPage.ScanZone.SetHide(2, FALSE);
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
                                            CurrPage.ScanZone.SetText(1, FromBinCode);
                                            CurrPage.ScanZone.SetHide(2, FALSE);
                                            AssignFromBinCode(FromBinCode);
                                        END;
                                    END;
                                END;

                            2:
                                BEGIN
                                    CLEAR(ItemForm);
                                    Item.RESET;
                                    //>>TI318739
                                    Item.SETRANGE(Blocked, FALSE);
                                    //<<TI318739
                                    ItemForm.SETTABLEVIEW(Item);
                                    ItemForm.LOOKUPMODE(TRUE);
                                    IF (ItemNo <> '') THEN
                                        IF Item.GET(ItemNo) THEN
                                            ItemForm.SETRECORD(Item);
                                    IF ItemForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        ItemForm.GETRECORD(Item);
                                        ItemNo := Item."No.";
                                        CurrPage.ScanZone.SetText(2, ItemNo);
                                        CurrPage.ScanZone.SetHide(3, FALSE);
                                        AssignItemNo(ItemNo);
                                    END;
                                END;

                            3:
                                BEGIN

                                END;

                            4:
                                BEGIN
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
                                        CurrPage.ScanZone.SetText(4, ToBinCode);
                                        AssignBinCode(ToBinCode);
                                    END;
                                END;
                        END;
                    end;

                    trigger Focused(index: Integer; data: Text)
                    begin
                    end;

                    trigger FocusLost(index: Integer; data: Text)
                    begin
                    end;

                    trigger DataSubmited(index: Integer; data: Text)
                    var
                        LastJnlLine: Record "Item Journal Line";
                    begin
                        //index values :
                        //0 : Close Page
                        //1 : Post

                        IF NOT SkipAssignValue THEN BEGIN
                            IF ScanDeviceHelper.GetValueOfSubmition(1, data) <> "Bin Code" THEN BEGIN
                                FromBinCode := ScanDeviceHelper.GetValueOfSubmition(1, data);
                                AssignFromBinCode(FromBinCode);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(2, data) <> "Item No." THEN BEGIN
                                ItemNo := ScanDeviceHelper.GetValueOfSubmition(2, data);
                                AssignItemNo(ItemNo);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(3, data) <> FORMAT(Quantity) THEN BEGIN
                                Qty := ScanDeviceHelper.GetValueOfSubmition(3, data);
                                AssignQty(Qty);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(4, data) <> "New Bin Code" THEN BEGIN
                                ToBinCode := ScanDeviceHelper.GetValueOfSubmition(4, data);
                                AssignBinCode(ToBinCode);
                            END;
                        END;

                        CASE index OF
                            0:
                                BEGIN
                                    SkipUpdateData := TRUE;
                                    CurrPage.CLOSE;
                                END;

                            1:
                                BEGIN
                                    IF NOT MODIFY(TRUE) THEN
                                        INSERT(TRUE);

                                    CurrPage.ScanZone.SetFocus(1);
                                    RefreshDataControlAddin;
                                    PostBatch;

                                    LastJnlLine.RESET;
                                    LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                                    LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                                    IF LastJnlLine.FIND('+') THEN BEGIN
                                        Rec := LastJnlLine
                                    END ELSE BEGIN
                                        //NewLine(Rec);
                                        Rec := xRec;
                                        CurrPage.UPDATE(FALSE);
                                    END;

                                    SkipUpdateData := FALSE;
                                    SkipClosePage := FALSE;
                                    SkipAssignValue := TRUE;
                                    CurrPage.CLOSE;
                                    EXIT;
                                END;

                            2:
                                CloseAndOpenCurrentPickAndBin;

                            3:
                                CloseAndOpenCurrentPick;

                        END;
                        RefreshDataControlAddin;
                    end;
                }
                field(FromBinCodeCtrl; FromBinCode)
                {
                    Caption = 'Bin Code';
                    Editable = true;
                    Style = Standard;
                    StyleExpr = TRUE;
                    TableRelation = Bin.Code;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Bin: Record Bin;
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
                        RefreshDataControlAddin
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
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                    begin
                        CLEAR(ItemForm);
                        Item.RESET;
                        //>>TI318739
                        Item.SETRANGE(Blocked, FALSE);
                        //<<TI318739
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
                        RefreshDataControlAddin
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
                field(QtyCtrl; Qty)
                {
                    BlankZero = true;
                    Caption = 'Quantity';
                    Editable = QtyCtrlEditable;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
                field(ToBinCodeCtrl; ToBinCode)
                {
                    Caption = 'Bin Code';
                    Editable = ToBinCodeCtrlEditable;
                    Style = Standard;
                    StyleExpr = TRUE;
                    TableRelation = Bin.Code;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Bin: Record Bin;
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
                        RefreshDataControlAddin
                    end;

                    trigger OnValidate()
                    begin
                        ToBinCodeOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
                field(Description; Description)
                {
                    Editable = false;
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
                        Location: Record Location;
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
                        RefreshDataControlAddin
                    end;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ItemButton)
            {
                Caption = '&Item';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F2';

                trigger OnAction()
                var
                    PgeLReclassItemSelection: Page "BC6_Reclass. Card MiniForm F2";
                begin
                    CurrPage.ScanZone.SubmitAllData(2);
                end;
            }
            action(BinButton)
            {
                Caption = '&Bin';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F3';

                trigger OnAction()
                var
                    PgeLReclassBinSelection: Page "BC6_Reclass. Card MiniForm F3";
                begin
                    CurrPage.ScanZone.SubmitAllData(3);
                end;
            }
            action(PostButton)
            {
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F8';

                trigger OnAction()
                begin
                    IF IsReady THEN
                        CurrPage.ScanZone.SubmitAllData(1);

                    /*
                    IF ISCLEAR(WshShell) THEN
                      CREATE(WshShell,FALSE ,TRUE);
                    
                    
                    BoolWait := FALSE;
                    WshShell.SendKeys('{F2}', BoolWait);
                    */

                end;
            }
            action(QuitButton)
            {
                Caption = '&Quit';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.ScanZone.SubmitAllData(0);
                end;
            }
            action(DeleteButton)
            {
                Caption = '&Delete';
                Image = Delete;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    LastJnlLine: Record "Item Journal Line";
                begin
                    SkipClosePage := TRUE;
                    LastJnlLine := Rec;
                    SETFILTER("Journal Template Name", "Journal Template Name");
                    SETFILTER("Journal Batch Name", "Journal Batch Name");
                    IF DELETE(TRUE) THEN
                        COMMIT;

                    IF ISEMPTY THEN BEGIN
                        SkipClosePage := FALSE;
                        SkipUpdateData := TRUE;
                        CurrPage.CLOSE;
                        EXIT;
                    END;
                    UpdateCurrForm;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        Found: Boolean;
    begin
        Found := FIND(Which);
        UpdateCurrForm();
        RefreshDataControlAddin;
        EXIT(Found);
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
        NewLine(Rec);
        OnAfterGetCurrRecord;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        Found: Integer;
    begin
        Found := NEXT(Steps);
        UpdateCurrForm();
        RefreshDataControlAddin;
        EXIT(Found);
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF SkipClosePage THEN BEGIN
            SkipClosePage := FALSE;
            EXIT(FALSE);
        END;
        IF IsReady AND NOT SkipUpdateData THEN BEGIN
            CurrPage.ScanZone.SubmitAllData(0);
            EXIT(FALSE);
        END;
    end;

    var
        OptionMode: Option New,Edit,KeepPick,KeepPickAndBin;
        InvSetup: Record "Inventory Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemBatchJnl: Record "Item Journal Batch";
        WhseEmployee: Record "Warehouse Employee";
        Location: Record Location;
        Bin: Record Bin;
        Item: Record Item;
        BinContent: Record "Bin Content";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
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
        DistInt: Codeunit "Dist. Integration";
        txt003: Label 'You cannot delete the entry';
        Text001: Label 'User %1 does not exist on warehouse salary list';
        Text002: Label 'Location %1 incorrect';
        Text006: Label 'Palette nr (%1) incorrect';
        Text013: Label 'Item No. %1 Incorrect';
        Text014: Label 'Item %1 blocked';
        Text012: Label 'Item %1 with tracking';
        ItemError: Boolean;
        ErrorTxt: Text[250];
        ItemTrackingCode: Record "Item Tracking Code";
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
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        BinContentForm: Page "BC6_Bin Content List MiniForm";
        WshShell: Automation;
        BoolWait: Boolean;
        FromBinCaption: Label 'From Bin Code';
        ItemNoCaption: Label 'Item nr';
        QuantityCaption: Label 'Quantity';
        ToBinCaption: Label 'To Bin Code';
        IsReady: Boolean;
        ScanDeviceHelper: Codeunit 50090;
        SkipUpdateData: Boolean;
        SkipClosePage: Boolean;
        SkipAssignValue: Boolean;


    procedure NewLine(LastJnlLine: Record "Item Journal Line")
    begin
        BarCode := '';
        FromBinCode := '';
        ToBinCode := '';
        ItemNo := '';
        Qty := '';
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        //CLEAR(LastJnlLine);
        LastJnlLine.RESET;
        LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF LastJnlLine.ISEMPTY THEN BEGIN
            LastJnlLine.INIT;
            LastJnlLine."Journal Template Name" := "Journal Template Name";
            LastJnlLine."Journal Batch Name" := "Journal Batch Name";
            "Line No." := 0;
        END;

        SetUpNewLine(LastJnlLine);
        "Entry Type" := "Entry Type"::Transfer;
        "Line No." := "Line No." + 10000;
        VALIDATE("Posting Date", WORKDATE);
        INSERT(TRUE);
        IF LocationCode = '' THEN
            LocationCode := Location.Code;

        AssignLocationCode(LocationCode);
        MODIFY(TRUE);
        TESTFIELD("Location Code");
        RefreshDataControlAddin
    end;


    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocationCode: Code[10];
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 2");

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
                ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 2");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
                ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                ItemBatchJnl.SETRANGE("BC6_Assigned User ID", USERID);
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
        RefreshDataControlAddin
    end;


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
        RefreshDataControlAddin
    end;


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
        RefreshDataControlAddin
    end;


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
        RefreshDataControlAddin
    end;

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
                //>>TI318739
                //IF NOT Item.GET(ItemNo) THEN
                Item.RESET;
                Item.SETRANGE("No.", ItemNo);
                Item.SETRANGE(Blocked, FALSE);
                IF NOT Item.FINDFIRST THEN
                //<<TI318739
                  BEGIN
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
            VALIDATE(Quantity, 0);
        END;

        UpdateCurrForm();
        RefreshDataControlAddin
    end;

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
        RefreshDataControlAddin
    end;


    procedure PostBatch()
    begin
        CLEAR(JnlPostBatch);
        JnlPostBatch.RUN(Rec);
    end;


    procedure InitForm(Picking: Boolean)
    begin
    end;


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


    procedure UpdateCurrForm()
    var
        i: Integer;
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
        IF IsReady THEN BEGIN

            CASE OptionMode OF
                OptionMode::Edit:
                    BEGIN
                        FOR i := 1 TO 4 DO BEGIN
                            CurrPage.ScanZone.SetHide(i, FALSE);
                        END;
                    END;

                OptionMode::KeepPick:
                    BEGIN
                        CurrPage.ScanZone.SetHide(2, FALSE);
                        CurrPage.ScanZone.SetHide(3, FALSE);
                        CurrPage.ScanZone.SetFocus(1);
                    END;

                OptionMode::KeepPickAndBin:
                    BEGIN
                        CurrPage.ScanZone.SetHide(3, FALSE);
                        CurrPage.ScanZone.SetHide(2, FALSE);
                        CurrPage.ScanZone.SetFocus(2);
                    END;

                ELSE BEGIN

                END;
            END;

        END;
    end;


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

    local procedure CloseAndOpenCurrentPickAndBin()
    var
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
        LastJnlLine: Record "Item Journal Line";
    begin
        IF MODIFY(TRUE) THEN;
        LastJnlLine := Rec;
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
        END;

        SetOptionMode(OptionMode::KeepPickAndBin);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CloseAndOpenCurrentPick()
    var
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
        LastJnlLine: Record "Item Journal Line";
    begin
        IF MODIFY(TRUE) THEN;
        LastJnlLine := Rec;
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
        END;

        // CurrPage.CLOSE;

        //MIG 2017

        //
        // InvtPickCardMiniForm.SETTABLEVIEW(Rec);
        // InvtPickCardMiniForm.SetOptionMode(OptionMode::KeepBin);
        // InvtPickCardMiniForm.RUN();
        SetOptionMode(OptionMode::KeepPick);
        CurrPage.UPDATE(FALSE);
    end;


    procedure SetOptionMode(NewOptionMode: Option New,Edit,KeepPick,KeepPickAndBin)
    begin
        OptionMode := NewOptionMode;
    end;

    local procedure GetCaptionClass(): Text
    begin
        CASE OptionMode OF
            OptionMode::KeepPick:
                EXIT(STRSUBSTNO('%1 - %2 %3', FIELDCAPTION("Whse. Document No."), "Whse. Document No.", "Line No."));
            OptionMode::KeepPickAndBin:
                EXIT(STRSUBSTNO('%1 - %2 %3', FIELDCAPTION("Bin Code"), "Bin Code", "Line No."));

            ELSE
                EXIT(STRSUBSTNO('%1 - %2 %3', TABLECAPTION, "Whse. Document No.", "Line No."));
        END;
    end;

    local procedure RefreshDataControlAddin()
    begin
        IF NOT IsReady THEN EXIT;
        CurrPage.ScanZone.SetText(1, FromBinCode);
        CurrPage.ScanZone.SetText(2, ItemNo);
        CurrPage.ScanZone.SetText(3, Qty);
        CurrPage.ScanZone.SetText(4, ToBinCode);
    end;
}

