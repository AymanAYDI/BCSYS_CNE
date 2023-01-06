page 50057 "BC6_Inventory Card MiniForm"
{
    AutoSplitKey = false;
    Caption = 'Inventory', Comment = 'FRA="Inventaire article"';
    DelayedInsert = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    SaveValues = false;
    SourceTable = "Item Journal Line";
    SourceTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                      ORDER(Ascending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            usercontrol(ScanZone; "BC6_ControlAddinScanCapture")
            {
                Visible = true;
                ApplicationArea = All;

                trigger ControlAddInReady()
                begin
                    IsReady := TRUE;
                    CurrPage.ScanZone.AddControl(1, FromBinCaption, FromBinCode);
                    CurrPage.ScanZone.AddControl(2, ItemNoCaption, ItemNo);
                    CurrPage.ScanZone.AddControl(3, QuantityCaption, Qty);
                    CurrPage.ScanZone.SetFocus(1);
                    CurrPage.ScanZone.SetHide(2, FALSE);
                    CurrPage.ScanZone.SetHide(3, FALSE);
                end;

                trigger KeyPressed(index: Integer; data: Text)
                begin
                    CASE data OF
                        '113':
                            CurrPage.ScanZone.SubmitAllData(2); //F2
                        '114':
                            CurrPage.ScanZone.SubmitAllData(3); //F3
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
                            END;

                        3:
                            BEGIN
                                Qty := COPYSTR(data, 1, MAXSTRLEN(Qty));
                                AssignQty(Qty);
                                CurrPage.ScanZone.reset(index);
                                CurrPage.ScanZone.SetText(index, Qty);
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
                                CLEAR(BinForm);
                                Bin.RESET();
                                IF LocationCode <> '' THEN
                                    Bin.SETRANGE("Location Code", LocationCode);
                                BinForm.SETTABLEVIEW(Bin);
                                BinForm.LOOKUPMODE(TRUE);
                                IF FromBinCode <> '' THEN
                                    IF Bin.GET(LocationCode, FromBinCode) THEN
                                        BinForm.SETRECORD(Bin);
                                IF BinForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                    BinForm.GETRECORD(Bin);
                                    FromBinCode := Bin.Code;
                                    CurrPage.ScanZone.SetText(1, FromBinCode);
                                    CurrPage.ScanZone.SetHide(2, FALSE);
                                    AssignFromBinCode(FromBinCode);
                                END;
                            END;

                        2:
                            BEGIN
                                CLEAR(ItemForm);
                                Item.RESET();
                                ItemForm.SETTABLEVIEW(Item);
                                ItemForm.LOOKUPMODE(TRUE);
                                IF ItemNo <> '' THEN
                                    IF Item.GET(ItemNo) THEN
                                        ItemForm.SETRECORD(Item);
                                IF ItemForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                    ItemForm.GETRECORD(Item);
                                    ItemNo := Item."No.";
                                    CurrPage.ScanZone.SetText(2, ItemNo);
                                    CurrPage.ScanZone.SetHide(3, FALSE);
                                    AssignItemNo(ItemNo);
                                END;
                            END;



                    END;

                end;


                trigger DataSubmited(index: Integer; data: Text)
                begin
                    //index values :
                    //0 = Close Page

                    IF ScanDeviceHelper.GetValueOfSubmition(1, data) <> Rec."Bin Code" THEN BEGIN
                        FromBinCode := ScanDeviceHelper.GetValueOfSubmition(1, data);
                        AssignFromBinCode(FromBinCode);
                    END;
                    IF ScanDeviceHelper.GetValueOfSubmition(2, data) <> Rec."Item No." THEN BEGIN
                        ItemNo := ScanDeviceHelper.GetValueOfSubmition(2, data);
                        AssignItemNo(ItemNo);
                    END;
                    IF ScanDeviceHelper.GetValueOfSubmition(3, data) <> FORMAT(Rec.Quantity) THEN BEGIN
                        Qty := ScanDeviceHelper.GetValueOfSubmition(3, data);
                        AssignQty(Qty);
                    END;

                    CASE index OF
                        0:
                            BEGIN
                                SkipUpdateData := TRUE;
                                CurrPage.CLOSE();
                            END;

                        2:
                            CloseAndOpenCurrentPickAndBin();

                        3:
                            CloseAndOpenCurrentPick();

                    END;
                    RefreshDataControlAddin();
                end;

                trigger EventGetText(Id: Text)
                begin
                    _BinCode := Id;
                end;
            }
            field(FromBinCodeCtrl; FromBinCode)
            {
                Caption = 'Bin Code', Comment = 'FRA="De empl."';
                Editable = true;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Bin.Code;
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Bin: Record Bin;
                begin
                    CLEAR(BinForm);
                    Bin.RESET();
                    IF LocationCode <> '' THEN
                        Bin.SETRANGE("Location Code", LocationCode);
                    BinForm.SETTABLEVIEW(Bin);
                    BinForm.LOOKUPMODE(TRUE);
                    IF FromBinCode <> '' THEN
                        IF Bin.GET(LocationCode, FromBinCode) THEN
                            BinForm.SETRECORD(Bin);
                    IF BinForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        BinForm.GETRECORD(Bin);
                        FromBinCode := Bin.Code;
                        AssignFromBinCode(FromBinCode);
                    END;

                end;

                trigger OnValidate()
                begin
                    FromBinCodeOnAfterValidate();
                end;
            }
            field(ItemNoCtrl; ItemNo)
            {
                Caption = 'Item nr', Comment = 'FRA="N° article"';
                NotBlank = false;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record Item;
                begin
                    CLEAR(ItemForm);
                    Item.RESET();
                    ItemForm.SETTABLEVIEW(Item);
                    ItemForm.LOOKUPMODE(TRUE);
                    IF ItemNo <> '' THEN
                        IF Item.GET(ItemNo) THEN
                            ItemForm.SETRECORD(Item);
                    IF ItemForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        ItemForm.GETRECORD(Item);
                        ItemNo := Item."No.";
                        AssignItemNo(ItemNo);
                    END;
                end;

                trigger OnValidate()
                begin
                    ItemNoOnAfterValidate();
                end;
            }
            field(QtyCtrl; Qty)
            {
                Caption = 'Quantity', Comment = 'FRA="Quantité"';
                Editable = QtyCtrlEditable;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF FromBinCode = '' THEN
                        ERROR('Veuillez spécifier l''emplacement.');

                    QtyOnAfterValidate();
                end;
            }
            field(Description; Rec.Description)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(LocationCodeCtrl; LocationCode)
            {
                Caption = 'Location', Comment = 'FRA="Magasin"';
                Editable = false;
                Numeric = false;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Location;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record Location;
                begin

                    CLEAR(LocationForm);
                    Location.RESET();
                    Location.SETRANGE("Bin Mandatory", TRUE);
                    LocationForm.SETTABLEVIEW(Location);
                    LocationForm.LOOKUPMODE(TRUE);
                    IF Location.FIND('-') THEN
                        LocationForm.SETRECORD(Location);
                    IF LocationForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        LocationForm.GETRECORD(Location);
                        LocationCode := Location.Code;
                        AssignLocationCode(LocationCode);
                    END;
                end;

                trigger OnValidate()
                begin
                    LocationCodeOnAfterValidate();
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ItemButton)
            {
                Caption = 'Item', Comment = 'FRA="N°&art."';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F2';
                ApplicationArea = All;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PgeLInventoryItemSelection: Page "BC6_Inventory Card MiniForm F2";
                begin
                    CurrPage.ScanZone.SubmitAllData(2);
                end;
            }
            action(BinButton)
            {
                Caption = '&Bin.', Comment = 'FRA="&Emp."';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F3';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PgeLInventoryBinSelection: Page "BC6_Inventory Card MiniForm F3";
                begin
                    CurrPage.ScanZone.SubmitAllData(3);
                end;
            }
            action(DeleteButton)
            {
                Caption = '&Delete', Comment = 'FRA="&Supprimer"';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    LastJnlLine: Record "Item Journal Line";
                begin
                    SkipClosePage := TRUE;
                    LastJnlLine := Rec;
                    Rec.SETFILTER("Journal Template Name", Rec."Journal Template Name");
                    Rec.SETFILTER("Journal Batch Name", Rec."Journal Batch Name");
                    IF Rec.DELETE(TRUE) THEN
                        COMMIT();

                    IF Rec.ISEMPTY THEN BEGIN
                        SkipClosePage := FALSE;
                        SkipUpdateData := TRUE;
                        CurrPage.CLOSE();
                        EXIT;
                    END;
                    UpdateCurrForm();
                end;
            }
            action(QuitButton)
            {
                Caption = '&Quit', Comment = 'FRA="&Quitter"';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.ScanZone.SubmitAllData(0);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ProcOnAfterGetCurrRecord();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        found: Boolean;
    begin
        found := Rec.FIND(Which);
        UpdateCurrForm();
        RefreshDataControlAddin();
        EXIT(found);
    end;

    trigger OnInit()
    begin
        QtyCtrlEditable := TRUE;
        QtyCtrlVisible := TRUE;
        ItemNoLibCtrlVisible := TRUE;
        ItemNoCtrlVisible := TRUE;
        FromBinCodeCtrlVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NewLine(Rec);
        ProcOnAfterGetCurrRecord();
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        found: Integer;
    begin
        found := Rec.NEXT(Steps);
        UpdateCurrForm();
        RefreshDataControlAddin();
        EXIT(found);
    end;

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee();
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

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
        Bin: Record Bin;
        InvSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemBatchJnl: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        Location: Record Location;
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        ScanDeviceHelper: Codeunit BC6_ScanDeviceHelper;
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        EditableCtrl: Boolean;
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
        IsReady: Boolean;
        [InDataSet]
        ItemNoCtrlVisible: Boolean;
        [InDataSet]
        ItemNoLibCtrlVisible: Boolean;
        [InDataSet]
        QtyCtrlEditable: Boolean;
        [InDataSet]
        QtyCtrlVisible: Boolean;
        ShowCtrl: Boolean;
        SkipClosePage: Boolean;
        SkipUpdateData: Boolean;
        Qty: Code[10];
        BatchName: Code[20];
        DocNo: Code[20];
        FromBinCode: Code[20];
        ItemNo: Code[20];
        ItemNo2: Code[20];
        LocationCode: Code[20];
        ToBinCode: Code[20];
        PostingDate: Date;
        FromBinCaption: Label 'Bin Code', Comment = 'FRA="De empl."';
        ItemNoCaption: Label 'Item nr', Comment = 'FRA="N° article"';
        QuantityCaption: Label 'Quantity', Comment = 'FRA="Quantité"';
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Text011: Label 'Inventory Item', Comment = 'FRA="Inventaire article"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        OptionMode: Option New,Edit,KeepPick,KeepPickAndBin;
        _BinCode: Text;


    procedure NewLine(pLastJnlLine: Record "Item Journal Line")
    begin
        FromBinCode := '';
        ToBinCode := '';
        ItemNo := '';
        Qty := '';
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        CLEAR(pLastJnlLine);
        pLastJnlLine.RESET();
        pLastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        pLastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IF NOT pLastJnlLine.FIND('+') THEN BEGIN
            pLastJnlLine.INIT();
            pLastJnlLine."Journal Template Name" := Rec."Journal Template Name";
            pLastJnlLine."Journal Batch Name" := Rec."Journal Batch Name";
            Rec."Line No." := 0;
        END;

        Rec.SetUpNewLine(xRec);
        Rec."Entry Type" := Rec."Entry Type"::"Positive Adjmt.";
        Rec."Line No." := pLastJnlLine."Line No." + 10000;
        Rec.VALIDATE("Posting Date", WORKDATE());

        IF LocationCode = '' THEN
            LocationCode := Location.Code;

        AssignLocationCode(LocationCode);
        Rec.INSERT(TRUE);
    end;


    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocationCode: Code[10];
    begin
        CurrPage.CAPTION := Text011;

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 3");
        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FIND('-') THEN BEGIN
                WhseEmployee.SETRANGE(Default, TRUE);
                IF WhseEmployee.FIND('-') THEN
                    LocationCode := WhseEmployee."Location Code"
                ELSE
                    LocationCode := WmsManagement.GetDefaultLocation();
                IF NOT Location.GET(LocationCode) THEN
                    Location.INIT();
                Rec.FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 3");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                ItemBatchJnl.SETRANGE("BC6_Assigned User ID", USERID);
                IF ItemBatchJnl.FIND('-') THEN BEGIN
                    ItemBatchJnl.TESTFIELD("No. Series");
                    BatchName := ItemBatchJnl.Name;
                    Rec.SETFILTER("Journal Template Name", ItemBatchJnl."Journal Template Name");
                    Rec.SETFILTER("Journal Batch Name", BatchName);
                END ELSE BEGIN
                    ERROR(Text015, USERID);
                    EXIT(FALSE);
                END;
                Rec.FILTERGROUP := 0;
                PostingDate := WORKDATE();
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


    procedure AssignLocationCode(var pLocationCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        CLEAR(Location);
        IF (pLocationCode <> '') AND
           (STRLEN(pLocationCode) < 20) THEN BEGIN
            IF Location.GET(pLocationCode) THEN
                Rec."Location Code" := pLocationCode;
        END ELSE BEGIN
            pLocationCode := '';
            Rec."Location Code" := pLocationCode;
            MESSAGE(Text004);
        END;
    end;


    procedure AssignFromBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> Rec."Bin Code") THEN
                Rec."Bin Code" := BinCode;
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        Rec."Bin Code" := BinCode;
    end;

    procedure AssignItemNo(var pItemNo: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (pItemNo <> '') THEN BEGIN
            IF CodeEANOk(pItemNo) THEN BEGIN
                ItemNo2 := FunctionsMgt.GetItem(pItemNo);
                IF Item.GET(ItemNo2) THEN
                    pItemNo := Item."No.";
            END ELSE BEGIN
                IF Item.GET(pItemNo) THEN;
            END;
            Rec."Phys. Inventory" := FALSE;
            Rec.VALIDATE("Item No.", pItemNo);
            Rec.VALIDATE("Bin Code", FromBinCode);
            Rec."Phys. Inventory" := TRUE;
            UpdateCurrForm();
            EXIT;
        END;

        IF pItemNo <> '' THEN
            MESSAGE(Text004, pItemNo);
        pItemNo := '';
        Rec.Description := '';
        Rec.VALIDATE("Item No.", pItemNo);
        pItemNo := Rec."Item No.";
        UpdateCurrForm();
    end;


    procedure AssignQty(var pQty: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (pQty <> '') THEN BEGIN
            Rec."Phys. Inventory" := TRUE;
            EVALUATE(Rec."Qty. (Phys. Inventory)", pQty);
            Rec.VALIDATE("Qty. (Phys. Inventory)");
            pQty := FORMAT(Rec."Qty. (Phys. Inventory)");
            EXIT;
        END;

        IF pQty <> '' THEN
            MESSAGE(Text006, pQty);
        pQty := '';
        Rec.VALIDATE(Quantity, 0);
        pQty := FORMAT(Rec.Quantity);
    end;


    procedure CtrlEnabled()
    begin
        FromBinCodeCtrlVisible := ShowCtrl;
        ItemNoCtrlVisible := ShowCtrl;
        ItemNoLibCtrlVisible := ShowCtrl;
        QtyCtrlVisible := ShowCtrl;
        QtyCtrlEditable := EditableCtrl;
    end;


    procedure UpdateCurrForm()
    var
        i: Integer;
    begin
        LocationCode := Rec."Location Code";
        IF NOT Location.GET(Rec."Location Code") THEN
            Location.INIT();
        FromBinCode := Rec."Bin Code";
        ToBinCode := Rec."New Bin Code";
        ItemNo := Rec."Item No.";
        Qty := FORMAT(Rec."Qty. (Phys. Inventory)");
        EditableCtrl := (Rec."Item No." <> '');
        CtrlEnabled();
        IF IsReady THEN BEGIN

            CASE OptionMode OF
                OptionMode::Edit:
                    BEGIN
                        FOR i := 1 TO 3 DO BEGIN
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

    local procedure ItemNoOnAfterValidate()
    begin
        AssignItemNo(ItemNo);
    end;

    local procedure QtyOnAfterValidate()
    begin
        AssignQty(Qty);
    end;

    local procedure ProcOnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
    end;

    local procedure CloseAndOpenCurrentPickAndBin()
    var
        _LastJnlLine: Record "Item Journal Line";
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
    begin
        IF Rec.MODIFY(TRUE) THEN;
        _LastJnlLine := Rec;
        _LastJnlLine.RESET();
        _LastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        _LastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IF _LastJnlLine.FIND('+') THEN BEGIN
            Rec.INIT();
            Rec."Journal Template Name" := _LastJnlLine."Journal Template Name";
            Rec."Journal Batch Name" := _LastJnlLine."Journal Batch Name";
            Rec."Line No." := _LastJnlLine."Line No." + 10000;
            Rec.VALIDATE("Entry Type", Rec."Entry Type"::"Positive Adjmt.");
            Rec.VALIDATE("Posting Date", WORKDATE());
            Rec."Document No." := _LastJnlLine."Document No.";
            Rec."Location Code" := _LastJnlLine."Location Code";
            Rec."Bin Code" := _LastJnlLine."Bin Code";
            Rec.INSERT(TRUE);
        END;

        SetOptionMode(OptionMode::KeepPickAndBin);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CloseAndOpenCurrentPick()
    var
        _LastJnlLine: Record "Item Journal Line";
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
    begin
        IF Rec.MODIFY(TRUE) THEN;
        _LastJnlLine := Rec;
        _LastJnlLine.RESET();
        _LastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        _LastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IF _LastJnlLine.FIND('+') THEN BEGIN
            Rec.INIT();
            Rec."Journal Template Name" := _LastJnlLine."Journal Template Name";
            Rec."Journal Batch Name" := _LastJnlLine."Journal Batch Name";
            Rec."Line No." := _LastJnlLine."Line No." + 10000;
            Rec.VALIDATE("Entry Type", Rec."Entry Type"::"Positive Adjmt.");
            Rec.VALIDATE("Posting Date", WORKDATE());
            Rec."Document No." := _LastJnlLine."Document No.";
            Rec."Location Code" := _LastJnlLine."Location Code";
            Rec.INSERT(TRUE);
        END;

        SetOptionMode(OptionMode::KeepPick);
        CurrPage.UPDATE(FALSE);
    end;


    procedure SetOptionMode(NewOptionMode: Option New,Edit,KeepPick,KeepPickAndBin)
    begin
        OptionMode := NewOptionMode;
    end;

    local procedure RefreshDataControlAddin()
    begin
        IF NOT IsReady THEN EXIT;
        CurrPage.ScanZone.SetText(1, FromBinCode);
        CurrPage.ScanZone.SetText(2, ItemNo);
        CurrPage.ScanZone.SetText(3, Qty);
    end;
}

