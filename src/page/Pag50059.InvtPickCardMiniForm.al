page 50059 "BC6_Invt. Pick Card MiniForm"
{
    AutoSplitKey = false;
    Caption = 'Invt Pick Card', Comment = 'FRA="Prélèvement stock"';
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
                usercontrol(ScanZone; "BC6_ControlAddinScanCapture")
                {
                    Visible = true;
                    ApplicationArea = All;

                    trigger ControlAddInReady()
                    var
                        i: Integer;
                    begin
                        IsReady := TRUE;
                        CurrPage.ScanZone.AddControl(1, PickLabel, PickNo);
                        CurrPage.ScanZone.AddControl(2, BinLabel, FromBinCode);
                        CurrPage.ScanZone.AddControl(3, FIELDCAPTION("Item No."), ItemNo);
                        CurrPage.ScanZone.AddControl(4, FIELDCAPTION(Quantity), Qty);
                        UpdateCurrForm;
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
                                    PickNo := COPYSTR(data, 1, MAXSTRLEN(PickNo));
                                    PickNoOnAfterValidate;
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, PickNo);
                                END;
                            2:
                                BEGIN
                                    FromBinCode := COPYSTR(data, 1, MAXSTRLEN(FromBinCode));
                                    FromBinCodeOnAfterValidate;
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, FromBinCode);
                                END;
                            3:
                                BEGIN
                                    ItemNo := COPYSTR(data, 1, MAXSTRLEN(ItemNo));
                                    ItemNoOnAfterValidate;
                                    CurrPage.ScanZone.reset(index);
                                    CurrPage.ScanZone.SetText(index, ItemNo);
                                    CurrPage.ScanZone.SetText(index + 1, Qty);
                                END;
                            4:
                                BEGIN
                                    Qty := COPYSTR(data, 1, MAXSTRLEN(Qty));
                                    QtyOnAfterValidate;
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
                                    CLEAR(InvtPickForm);
                                    InvtPick.RESET;
                                    InvtPick.ASCENDING(FALSE);
                                    InvtPickForm.LOOKUPMODE(TRUE);
                                    IF (PickNo <> '') THEN
                                        IF InvtPick.GET(InvtPick.Type::"Invt. Pick", PickNo) THEN
                                            InvtPickForm.SETRECORD(InvtPick);
                                    InvtPickForm.SETTABLEVIEW(InvtPick);
                                    IF InvtPickForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        InvtPickForm.GETRECORD(InvtPick);
                                        PickNo := InvtPick."No.";
                                        CurrPage.ScanZone.SetText(1, PickNo);
                                        CurrPage.ScanZone.SetHide(2, FALSE);
                                        AssignPickNo(PickNo);
                                    END;
                                END;

                            2:
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
                                            CurrPage.ScanZone.SetText(2, FromBinCode);
                                            CurrPage.ScanZone.SetHide(3, FALSE);
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
                                            CurrPage.ScanZone.SetText(2, FromBinCode);
                                            CurrPage.ScanZone.SetHide(3, FALSE);
                                            AssignFromBinCode(FromBinCode);
                                        END;
                                    END;
                                END;

                            3:
                                BEGIN
                                    CLEAR(ItemForm);
                                    Item.RESET;
                                    //>>TI318739
                                    Item.SETRANGE(Blocked, FALSE);
                                    //<<TI318739
                                    ItemForm.SETTABLEVIEW(Item);
                                    ItemForm.LOOKUPMODE(TRUE);
                                    IF ItemNo <> '' THEN
                                        IF Item.GET(ItemNo) THEN
                                            ItemForm.SETRECORD(Item);
                                    IF ItemForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        ItemForm.GETRECORD(Item);
                                        ItemNo := Item."No.";
                                        CurrPage.ScanZone.SetText(3, ItemNo);
                                        CurrPage.ScanZone.SetHide(4, FALSE);
                                        AssignItemNo(ItemNo);
                                    END;
                                END;

                            4:
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
                    var
                        LastJnlLine: Record "Item Journal Line";
                    begin
                        //index values :
                        //0 = Close Page
                        //1 = Post
                        // Close and Open with same Item

                        IF NOT SkipAssignValue THEN BEGIN
                            IF ScanDeviceHelper.GetValueOfSubmition(1, data) <> "BC6_Whse. Document No." THEN BEGIN
                                PickNo := ScanDeviceHelper.GetValueOfSubmition(1, data);
                                AssignPickNo(PickNo);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(2, data) <> "Bin Code" THEN BEGIN
                                FromBinCode := ScanDeviceHelper.GetValueOfSubmition(2, data);
                                AssignFromBinCode(FromBinCode);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(3, data) <> "Item No." THEN BEGIN
                                ItemNo := ScanDeviceHelper.GetValueOfSubmition(1, data);
                                AssignItemNo(ItemNo);
                            END;
                            IF ScanDeviceHelper.GetValueOfSubmition(4, data) <> FORMAT(Quantity) THEN BEGIN
                                Qty := ScanDeviceHelper.GetValueOfSubmition(4, data);
                                AssignQty(Qty);
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
                        RefreshDataControlAddin
                    end;
                }
                field(PickNoCtrl; PickNo)
                {
                    Caption = 'Pick No.', Comment = 'FRA="N° prélèvement"';
                    Editable = true;
                    Numeric = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Location: Record Location;
                    begin

                        CLEAR(InvtPickForm);
                        InvtPick.RESET;
                        InvtPick.ASCENDING(FALSE);
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
                        RefreshDataControlAddin
                    end;

                    trigger OnValidate()
                    begin
                        PickNoOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
                field(LocationCodeCtrl; LocationCode)
                {
                    Caption = 'Location', Comment = 'FRA="Magasin"';
                    Editable = false;
                    Numeric = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    TableRelation = Location;
                    Visible = LocationCodeVisible;
                    ApplicationArea = All;

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
                        RefreshDataControlAddin
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
                        Item.RESET;
                        //>>TI318739
                        Item.SETRANGE(Blocked, FALSE);
                        //<<TI318739
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
                    // BlankZero = true; TODO:
                    Caption = 'Quantity', Comment = 'FRA="Quantité"';
                    Editable = QtyCtrlEditable;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate;
                        RefreshDataControlAddin
                    end;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ToBinCodeCtrl; ToBinCode)
                {
                    Caption = 'Bin Code', Comment = 'FRA="Vers emp."';
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    TableRelation = Bin.Code;
                    Visible = ToBinCodeCtrlVisible;
                    ApplicationArea = All;

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
                            IF ToBinCodeCtrlEditable THEN BEGIN
                                ToBinCode := Bin.Code;
                                AssignBinCode(ToBinCode);
                            END;
                        END;
                        RefreshDataControlAddin
                    end;

                    trigger OnValidate()
                    begin
                        ToBinCodeOnAfterValidate;
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
                Caption = '&Item', Comment = 'FRA="&Article"';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F2';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50063: Page "Invt. Pick Card MiniForm F2";
                begin
                    CurrPage.ScanZone.SubmitAllData(2);
                end;
            }
            action(BinButton)
            {
                Caption = '&Bin', Comment = 'FRA="&Emp."';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F3';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50064: Page "Invt. Pick Card MiniForm F3";
                begin
                    CurrPage.ScanZone.SubmitAllData(3);
                end;
            }
            action(PostButton)
            {
                Caption = '&Post', Comment = 'FRA="&Valider"';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F8';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50059: Page "BC6_Invt. Pick Card MiniForm";
                begin
                    /*IF ISCLEAR(WshShell) THEN
                      CREATE(WshShell,FALSE ,TRUE);
                    
                    BoolWait := FALSE;
                    WshShell.SendKeys('{TAB}', BoolWait);
                    */
                    //QtyOnAfterValidate;

                    IF IsReady THEN
                        CurrPage.ScanZone.SubmitAllData(1);

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
                    CurrPage.CLOSE;
                end;
            }
            action(DeleteButton)
            {
                Caption = '&Delete', Comment = 'FRA="&Supprimer"';
                Image = Delete;
                Promoted = true;
                PromotedCategory = "Report";
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
        UpdateCurrForm;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        found: Boolean;
    begin
        found := FIND(Which);
        UpdateCurrForm();
        RefreshDataControlAddin;
        EXIT(found);
    end;

    trigger OnInit()
    begin

        VisibleTestBool := TRUE;

        QtyCtrlEditable := TRUE;
        ToBinCodeCtrlEditable := TRUE;
        QtyCtrlVisible := TRUE;
        ItemNoLibCtrlVisible := TRUE;
        ItemNoCtrlVisible := TRUE;

        FromBinCodeCtrlVisible := TRUE;
        PickNoLibCtrlVisible := TRUE;
        PickNoCtrlVisible := TRUE;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        found: Integer;
    begin
        found := NEXT(Steps);
        UpdateCurrForm();
        RefreshDataControlAddin;
        EXIT(found);
    end;

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee();
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        ToBinCodeCtrlVisible := TRUE;
        IsVisibleSearch := NOT (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
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
        EXIT(TRUE);
    end;

    var
        OptionMode: Option New,Edit,KeepPick,KeepPickAndBin;
        InvSetup: Record "Inventory Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemBatchJnl: Record "Item Journal Batch";
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        WhseEmployee: Record "Warehouse Employee";
        InvtPick: Record "Warehouse Activity Header";
        InvtPickLine: Record "Warehouse Activity Line";
        ItemTrackingCode: Record "Item Tracking Code";
        Location: Record Location;
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Bin: Record Bin;
        Item: Record Item;
        BinContent: Record "Bin Content";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
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
        DistInt: Codeunit "Dist. Integration";
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        Text016: Label 'Item %1 not exit on Invt. Pick', Comment = 'FRA="Article (%1)  n''est pas sur le prélevement."';
        ErrorTxt: Text[250];
        Text013: Label 'Item No. %1 Incorrect', Comment = 'FRA="%1 n° article erroné"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="%1 article bloqué"';
        Text012: Label 'Item %1 with tracking', Comment = 'FRA="%1 article avec traçabilité"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
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
        InvtPickForm: Page "BC6_Invt Pick List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BinContentForm: Page "BC6_Bin Content List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        VisibleTestBool: Boolean;
        // WshShell: Automation; TODO:
        BoolWait: Boolean;
        [InDataSet]
        IsVisibleSearch: Boolean;
        ScanDeviceHelper: Codeunit BC6_ScanDeviceHelper;
        [InDataSet]
        IsReady: Boolean;
        PickNoCaption: Label 'Pick No.', Comment = 'FRA="N° prélèvement"';
        SkipUpdateData: Boolean;
        SkipClosePage: Boolean;
        PickLabel: Label 'Pick', Comment = 'FRA="Prélèv."';
        BinLabel: Label 'Bin', Comment = 'FRA="Empl."';
        SkipAssignValue: Boolean;


    procedure NewLine(LastJnlLine: Record "Item Journal Line")
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
            "Location Code" := DefaultLocationCode;
            "Line No." := 0;
        END;

        IF OptionMode <> OptionMode::Edit THEN
            SetUpNewLine(xRec);
        "Entry Type" := "Entry Type"::Transfer;
        "Line No." := LastJnlLine."Line No." + 10000;
        VALIDATE("Posting Date", WORKDATE);
        AssignPickNo(PickNo);

        LocationCode := DefaultLocationCode;
        AssignLocationCode(LocationCode);
        INSERT(TRUE);
        ToBinCodeCtrlVisible := FALSE;
        RefreshDataControlAddin
    end;


    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocationCode: Code[10];
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FIND('-') THEN BEGIN
                WhseEmployee.SETRANGE(Default, TRUE);
                IF WhseEmployee.FIND('-') THEN
                    DefaultLocationCode := WhseEmployee."Location Code"
                ELSE
                    DefaultLocationCode := WmsManagement.GetDefaultLocation;
                LocationCode := DefaultLocationCode;
                IF NOT Location.GET(LocationCode) THEN
                    Location.INIT;
                FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 1");
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
                IF NOT Rec.FIND('+') THEN BEGIN
                    "Journal Template Name" := ItemJnlTemplate.Name;
                    "Journal Batch Name" := ItemBatchJnl.Name;
                    NewLine(Rec);
                    CurrPage.SAVERECORD;
                END;
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


    procedure AssignPickNo(var PickNo: Code[20])
    begin
        IF InvtPick.GET(InvtPick.Type::"Invt. Pick", PickNo) THEN BEGIN
            "BC6_Whse. Document Type" := "BC6_Whse. Document Type"::"Invt. Pick";
            VALIDATE("BC6_Whse. Document No.", PickNo);
        END ELSE BEGIN
            "BC6_Whse. Document Type" := "BC6_Whse. Document Type"::" ";
            VALIDATE("BC6_Whse. Document No.", '');

        END;

        UpdateCurrForm();
    end;


    procedure AssignLocationCode(var LocationCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
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


    procedure AssignBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> "New Bin Code") THEN
                VALIDATE("New Location Code", "Location Code");
            "New Bin Code" := BinCode;
            UpdateCurrForm();
            EXIT;
        END;

        IF OptionMode <> OptionMode::KeepPickAndBin THEN
            MESSAGE(Text002, BinCode);
        BinCode := '';
        "New Bin Code" := BinCode;
    end;


    procedure AssignFromBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
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

        IF OptionMode <> OptionMode::KeepPickAndBin THEN
            MESSAGE(Text002, BinCode);
        BinCode := '';
        "Bin Code" := BinCode;
    end;

    procedure AssignItemNo(var ItemNo: Code[20])
    var
        ItemError: Boolean;
    begin
        // TESTFIELD("Whse. Document No.");
        ItemError := FALSE;
        ErrorTxt := '';

        IF (ItemNo <> '') THEN BEGIN
            TESTFIELD("BC6_Whse. Document No.");
            IF CodeEANOk(ItemNo) THEN BEGIN
                ItemNo2 := FunctionsMgt.GetItem(ItemNo);
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

            IF NOT ItemExistOnInvtPick(ItemNo, '') THEN BEGIN
                IF NOT ItemError THEN
                    ErrorTxt := STRSUBSTNO(Text016, ItemNo, "BC6_Whse. Document No.");
                ItemError := TRUE;
            END;
        END;

        IF ItemError THEN BEGIN
            MESSAGE('%1', ErrorTxt);
        END ELSE BEGIN
            VALIDATE("Item No.", ItemNo);
            VALIDATE("Bin Code", FromBinCode);
            IF ShipBinCode <> '' THEN BEGIN
                ToBinCode := ShipBinCode;
                AssignBinCode(ToBinCode);
            END;
        END;

        UpdateCurrForm();
    end;


    procedure AssignQty(var Qty: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
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


    procedure PostBatch()
    begin
        //CLEAR(JnlPostBatch);
        JnlPostBatch.RUN(Rec);
    end;


    procedure InitForm(Picking: Boolean)
    begin
    end;


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


    procedure UpdateCurrForm()
    var
        i: Integer;
    begin
        PickNo := "BC6_Whse. Document No.";
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
                        CurrPage.ScanZone.SetFocus(2);
                    END;

                OptionMode::KeepPickAndBin:
                    BEGIN
                        CurrPage.ScanZone.SetHide(3, FALSE);
                        CurrPage.ScanZone.SetHide(2, FALSE);
                        CurrPage.ScanZone.SetFocus(3);
                    END;

                ELSE BEGIN
                    IF PickNo = '' THEN
                        CurrPage.ScanZone.SetHide(2, FALSE)
                    ELSE
                        CurrPage.ScanZone.SetHide(2, FALSE);
                    IF FromBinCode = '' THEN
                        CurrPage.ScanZone.SetHide(3, FALSE)
                    ELSE
                        CurrPage.ScanZone.SetHide(3, FALSE);
                    IF ItemNo = '' THEN
                        CurrPage.ScanZone.SetHide(4, FALSE)
                    ELSE
                        CurrPage.ScanZone.SetHide(4, FALSE);
                END;
            END;

        END;
    end;


    procedure ItemExistOnInvtPick(ItemNo: Code[20]; BinCode: Code[20]): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        IF ("BC6_Whse. Document No." <> '') THEN BEGIN
            IF InvtPick.GET(InvtPick.Type::"Invt. Pick", "BC6_Whse. Document No.") AND
               InvtPick."BC6_Sales Counter" THEN BEGIN
                IF Location.GET("Location Code") THEN
                    ShipBinCode := Location."Shipment Bin Code";
                EXIT(TRUE);
            END;

            InvtPickLine.RESET;
            InvtPickLine.SETRANGE("Activity Type", InvtPickLine."Activity Type"::"Invt. Pick");
            InvtPickLine.SETRANGE("No.", "BC6_Whse. Document No.");
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
            AssignPickNo(PickNo);
            "Location Code" := LastJnlLine."Location Code";
            "Bin Code" := LastJnlLine."Bin Code";
            INSERT(TRUE);
        END;

        ;
        // CurrPage.CLOSE;
        // //MIG 2017
        // InvtPickCardMiniForm.SETTABLEVIEW(Rec);
        // InvtPickCardMiniForm.SetOptionMode(OptionMode::KeepItem);
        // InvtPickCardMiniForm.RUN();
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
            AssignPickNo(PickNo);
            "Location Code" := LastJnlLine."Location Code";
            //SOBI
            //"Item No." := LastJnlLine."Item No.";
            //Description := LastJnlLine.Description;
            //SOBI
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
        IF NOT IsReady THEN
            EXIT;
        CurrPage.ScanZone.SetText(1, PickNo);
        CurrPage.ScanZone.SetText(2, FromBinCode);
        CurrPage.ScanZone.SetText(3, ItemNo);
        CurrPage.ScanZone.SetText(4, Qty);
    end;
}

