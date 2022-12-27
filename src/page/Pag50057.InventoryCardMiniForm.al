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
                                /*IF ItemNo <> '' THEN
                                  BEGIN
                                    CLEAR(BinContentForm);
                                    BinContent.RESET;
                                    IF LocationCode <> '' THEN
                                      BinContent.SETRANGE("Location Code",LocationCode);
                                    IF ItemNo <> '' THEN
                                      BinContent.SETRANGE("Item No.",ItemNo);
                                    BinContent.SETFILTER(Quantity,'>%1',0);
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
                                END ELSE BEGIN*/
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
                                //END;
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

                        3:
                            BEGIN

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
                begin
                    //index values :
                    //0 = Close Page

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
                    /*IF ItemNo <> '' THEN
                      BEGIN
                        CLEAR(BinContentForm);
                        BinContent.RESET;
                        IF LocationCode <> '' THEN
                          BinContent.SETRANGE("Location Code",LocationCode);
                        IF ItemNo <> '' THEN
                          BinContent.SETRANGE("Item No.",ItemNo);
                        BinContent.SETFILTER(Quantity,'>%1',0);
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
                    END ELSE BEGIN*/
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
                    //END;

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
            field(Description; Description)
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
                    SETFILTER("Journal Template Name", "Journal Template Name");
                    SETFILTER("Journal Batch Name", "Journal Batch Name");
                    IF DELETE(TRUE) THEN
                        COMMIT();

                    IF ISEMPTY THEN BEGIN
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
        OnAfterGetCurrRecord();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        found: Boolean;
    begin
        found := FIND(Which);
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
        OnAfterGetCurrRecord();
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        found: Integer;
    begin
        found := NEXT(Steps);
        UpdateCurrForm();
        RefreshDataControlAddin();
        EXIT(found);
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
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        InvSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemBatchJnl: Record "Item Journal Batch";
        LastJnlLine: Record "Item Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        Location: Record Location;
        WhseEmployee: Record "Warehouse Employee";
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        ScanDeviceHelper: Codeunit BC6_ScanDeviceHelper;
        DistInt: Codeunit "Dist. Integration";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BoolWait: Boolean;
        EditableCtrl: Boolean;
        EditableFromBinCtrl: Boolean;
        EditableLotCtrl: Boolean;
        FirstLine: Boolean;
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
        IsReady: Boolean;
        [InDataSet]
        ItemNoCtrlVisible: Boolean;
        [InDataSet]
        ItemNoLibCtrlVisible: Boolean;
        PalletBarCode: Boolean;
        [InDataSet]
        QtyCtrlEditable: Boolean;
        [InDataSet]
        QtyCtrlVisible: Boolean;
        ShowCtrl: Boolean;
        SkipClosePage: Boolean;
        SkipUpdateData: Boolean;
        Qty: Code[10];
        BatchName: Code[20];
        CurrentLocationCode: Code[20];
        DocNo: Code[20];
        FromBinCode: Code[20];
        ItemNo: Code[20];
        ItemNo2: Code[20];
        LocationCode: Code[20];
        ToBinCode: Code[20];
        PostingDate: Date;
        "---": Integer;
        EntryNo: Integer;
        FromBinCaption: Label 'Bin Code', Comment = 'FRA="De empl."';
        ItemNoCaption: Label 'Item nr', Comment = 'FRA="N° article"';
        QuantityCaption: Label 'Quantity', Comment = 'FRA="Quantité"';
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Text011: Label 'Inventory Item', Comment = 'FRA="Inventaire article"';
        Text013: Label 'Bar code incorrect \ %1', Comment = 'FRA="Code barres erroné \ %1"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="Article %1 bloqué"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        OptionMode: Option New,Edit,KeepPick,KeepPickAndBin;
        _BinCode: Text;
        BarTxt: Text[30];


    procedure NewLine(LastJnlLine: Record "Item Journal Line")
    begin
        FromBinCode := '';
        ToBinCode := '';
        ItemNo := '';
        Qty := '';
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        CLEAR(LastJnlLine);
        LastJnlLine.RESET();
        LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF NOT LastJnlLine.FIND('+') THEN BEGIN
            LastJnlLine.INIT();
            LastJnlLine."Journal Template Name" := "Journal Template Name";
            LastJnlLine."Journal Batch Name" := "Journal Batch Name";
            "Line No." := 0;
        END;

        SetUpNewLine(xRec);
        "Entry Type" := "Entry Type"::"Positive Adjmt.";
        "Line No." := LastJnlLine."Line No." + 10000;
        VALIDATE("Posting Date", WORKDATE());

        IF LocationCode = '' THEN
            LocationCode := Location.Code;

        AssignLocationCode(LocationCode);
        INSERT(TRUE);
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
                FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 3");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
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


    procedure AssignLocationCode(var LocationCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
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


    procedure AssignBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> "Bin Code") THEN
                VALIDATE("New Location Code", "Location Code");
            VALIDATE("New Bin Code", BinCode);
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        "New Bin Code" := BinCode;
    end;


    procedure AssignFromBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
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

    procedure AssignItemNo(var ItemNo: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (ItemNo <> '') THEN BEGIN
            IF CodeEANOk(ItemNo) THEN BEGIN
                ItemNo2 := FunctionsMgt.GetItem(ItemNo);
                IF Item.GET(ItemNo2) THEN
                    ItemNo := Item."No.";
            END ELSE BEGIN
                IF Item.GET(ItemNo) THEN;
            END;
            "Phys. Inventory" := FALSE;
            VALIDATE("Item No.", ItemNo);
            VALIDATE("Bin Code", FromBinCode);
            "Phys. Inventory" := TRUE;
            UpdateCurrForm();
            EXIT;
        END;

        IF ItemNo <> '' THEN
            MESSAGE(Text004, ItemNo);
        ItemNo := '';
        Description := '';
        VALIDATE("Item No.", ItemNo);
        ItemNo := "Item No.";
        UpdateCurrForm();
    end;


    procedure AssignQty(var Qty: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (Qty <> '') THEN BEGIN
            "Phys. Inventory" := TRUE;
            EVALUATE("Qty. (Phys. Inventory)", Qty);
            VALIDATE("Qty. (Phys. Inventory)");
            Qty := FORMAT("Qty. (Phys. Inventory)");
            EXIT;
        END;

        IF Qty <> '' THEN
            MESSAGE(Text006, Qty);
        Qty := '';
        VALIDATE(Quantity, 0);
        Qty := FORMAT(Quantity);
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
        LocationCode := "Location Code";
        IF NOT Location.GET("Location Code") THEN
            Location.INIT();
        FromBinCode := "Bin Code";
        ToBinCode := "New Bin Code";
        ItemNo := "Item No.";
        Qty := FORMAT("Qty. (Phys. Inventory)");
        EditableCtrl := ("Item No." <> '');
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

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
    end;

    local procedure SaveValues()
    begin
        IF IsReady THEN BEGIN
            CurrPage.ScanZone.GetText(1);
            IF _BinCode <> Rec."Bin Code" THEN BEGIN
                FromBinCode := _BinCode;
                AssignFromBinCode(FromBinCode);
            END;
            CurrPage.ScanZone.GetText(2);
            IF _BinCode <> Rec."Item No." THEN BEGIN
                ItemNo := _BinCode;
                AssignItemNo(ItemNo);
            END;
            CurrPage.ScanZone.GetText(3);
            IF _BinCode <> FORMAT(Rec.Quantity) THEN BEGIN
                Qty := _BinCode;
                AssignQty(Qty);
            END;
        END;
    end;

    local procedure CloseAndOpenCurrentPickAndBin()
    var
        LastJnlLine: Record "Item Journal Line";
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
    begin
        IF MODIFY(TRUE) THEN;
        LastJnlLine := Rec;
        LastJnlLine.RESET();
        LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF LastJnlLine.FIND('+') THEN BEGIN
            INIT();
            "Journal Template Name" := LastJnlLine."Journal Template Name";
            "Journal Batch Name" := LastJnlLine."Journal Batch Name";
            "Line No." := LastJnlLine."Line No." + 10000;
            VALIDATE("Entry Type", "Entry Type"::"Positive Adjmt.");
            VALIDATE("Posting Date", WORKDATE());
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
        LastJnlLine: Record "Item Journal Line";
        InvtPickCardMiniForm: Page "BC6_Invt. Pick Card MiniForm";
    begin
        IF MODIFY(TRUE) THEN;
        LastJnlLine := Rec;
        LastJnlLine.RESET();
        LastJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF LastJnlLine.FIND('+') THEN BEGIN
            INIT();
            "Journal Template Name" := LastJnlLine."Journal Template Name";
            "Journal Batch Name" := LastJnlLine."Journal Batch Name";
            "Line No." := LastJnlLine."Line No." + 10000;
            VALIDATE("Entry Type", "Entry Type"::"Positive Adjmt.");
            VALIDATE("Posting Date", WORKDATE());
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
                EXIT(STRSUBSTNO('%1 - %2 %3', FIELDCAPTION("BC6_Whse. Document No."), "BC6_Whse. Document No.", "Line No."));
            OptionMode::KeepPickAndBin:
                EXIT(STRSUBSTNO('%1 - %2 %3', FIELDCAPTION("Bin Code"), "Bin Code", "Line No."));

            ELSE
                EXIT(STRSUBSTNO('%1 - %2 %3', TABLECAPTION, "BC6_Whse. Document No.", "Line No."));
        END;
    end;

    local procedure RefreshDataControlAddin()
    begin
        IF NOT IsReady THEN EXIT;
        CurrPage.ScanZone.SetText(1, FromBinCode);
        CurrPage.ScanZone.SetText(2, ItemNo);
        CurrPage.ScanZone.SetText(3, Qty);
    end;
}

