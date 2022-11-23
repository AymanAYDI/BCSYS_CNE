page 50064 "Invt. Pick Card MiniForm F3"
{
    AutoSplitKey = false;
    Caption = 'Invt Pick Card', Comment = 'FRA="Prélèvement stock"';
    DataCaptionFields = "BC6_Whse. Document No.", "Line No.";
    DelayedInsert = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = false;
    SourceTable = "Item Journal Line";
    SourceTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                      ORDER(Ascending);
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
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
                end;

                trigger OnValidate()
                begin
                    LocationCodeOnAfterValidate;
                end;
            }
            field(FromBinCodeCtrl; FromBinCode)
            {
                Caption = 'Bin Code', Comment = 'FRA="De empl."';
                Editable = true;
                Style = Standard;
                StyleExpr = TRUE;
                TableRelation = Bin.Code;
                Visible = FromBinCodeCtrlVisible;
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
                end;

                trigger OnValidate()
                begin
                    FromBinCodeOnAfterValidate;
                end;
            }
            field(ItemNoCtrl; ItemNo)
            {
                Caption = 'Item nr', Comment = 'FRA="N° article"';
                NotBlank = false;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = ItemNoCtrlVisible;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record Item;
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
                ApplicationArea = All;
            }
            field(QtyCtrl; Qty)
            {
                // BlankZero = true; TODO:
                Caption = 'Quantity', Comment = 'FRA="Quantité"';
                Editable = QtyCtrlEditable;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = QtyCtrlVisible;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    QtyOnAfterValidate;
                end;
            }
            field(ToBinCodeCtrl; ToBinCode)
            {
                Caption = 'Bin Code', Comment = 'FRA="Vers emp."';
                Editable = ToBinCodeCtrlEditable;
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
                end;

                trigger OnValidate()
                begin
                    ToBinCodeOnAfterValidate;
                end;
            }
            field(PickNoCtrl; PickNo)
            {
                Caption = 'Pick No.', Comment = 'FRA="N° prélèvement"';
                Editable = false;
                Numeric = false;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = PickNoCtrlVisible;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Location: Record Location;
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
                Caption = '&Item', Comment = 'FRA="&Art."';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F2';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50063: Page "Invt. Pick Card MiniForm F2";
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
                Caption = '&Bin', Comment = 'FRA="&Emp."';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F3';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50064: Page "Invt. Pick Card MiniForm F3";
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
                Caption = '&Quit', Comment = 'FRA="&Quitter"';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
            action("&Delete")
            {
                Caption = '&Delete', Comment = 'FRA="&Delete"';
                ShortCutKey = 'F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50064: Page "Invt. Pick Card MiniForm F3";
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
        AfterGetCurrRecord;
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
        AfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee();
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;

        ToBinCodeCtrlVisible := TRUE;
    end;

    var
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        InvSetup: Record "Inventory Setup";
        Item: Record Item;
        ItemBatchJnl: Record "Item Journal Batch";
        LastJnlLine: Record "Item Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemTrackingCode: Record "Item Tracking Code";
        Location: Record Location;
        InvtPick: Record "Warehouse Activity Header";
        InvtPickLine: Record "Warehouse Activity Line";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        BinContentForm: Page "BC6_Bin Content List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        InvtPickForm: Page "Invt Pick List MiniForm";
        // WshShell: Automation; TODO:
        EditableCtrl: Boolean;
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
        [InDataSet]
        ItemNoCtrlVisible: Boolean;
        [InDataSet]
        ItemNoLibCtrlVisible: Boolean;
        LocationCodeVisible: Boolean;
        [InDataSet]
        PickNoCtrlVisible: Boolean;
        [InDataSet]
        PickNoLibCtrlVisible: Boolean;
        [InDataSet]
        QtyCtrlEditable: Boolean;
        [InDataSet]
        QtyCtrlVisible: Boolean;
        ShowCtrl: Boolean;
        [InDataSet]
        ToBinCodeCtrlEditable: Boolean;
        [InDataSet]
        ToBinCodeCtrlVisible: Boolean;
        VisibleTestBool: Boolean;
        Qty: Code[10];
        BatchName: Code[20];
        CurrentLocationCode: Code[20];
        DefaultLocationCode: Code[20];
        FromBinCode: Code[20];
        ItemNo: Code[20];
        ItemNo2: Code[20];
        LocationCode: Code[20];
        PickNo: Code[20];
        ShipBinCode: Code[20];
        ToBinCode: Code[20];
        PostingDate: Date;
        "---": Integer;
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Text012: Label 'Item %1 with tracking', Comment = 'FRA="%1 article avec traçabilité"';
        Text013: Label 'Item No. %1 Incorrect', Comment = 'FRA="%1 n° article erroné"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="%1 article bloqué"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA=""';
        Text016: Label 'Item %1 not exit on Invt. Pick', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        ErrorTxt: Text[250];

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

    procedure OpenWithWhseEmployee(): Boolean
    var
        WhsEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocatCode: Code[10];
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            WhsEmployee.SETRANGE("User ID", USERID);
            IF WhsEmployee.FIND('-') THEN BEGIN
                WhsEmployee.SETRANGE(Default, TRUE);
                IF WhsEmployee.FIND('-') THEN
                    DefaultLocationCode := WhsEmployee."Location Code"
                ELSE
                    DefaultLocationCode := WmsManagement.GetDefaultLocation;
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

    procedure AssignPickNo(var PickN: Code[20])
    begin
        IF InvtPick.GET(InvtPick.Type::"Invt. Pick", PickN) THEN BEGIN
            "BC6_Whse. Document Type" := "BC6_Whse. Document Type"::"Invt. Pick";
            VALIDATE("BC6_Whse. Document No.", PickN);
        END ELSE BEGIN
            "BC6_Whse. Document Type" := "BC6_Whse. Document Type"::" ";
            VALIDATE("BC6_Whse. Document No.", '');

        END;

        UpdateCurrForm();
    end;

    procedure AssignLocationCode(var LocatCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        CLEAR(Location);
        IF (LocatCode <> '') AND
           (STRLEN(LocatCode) < 20) THEN BEGIN
            IF Location.GET(LocatCode) THEN BEGIN
                "Location Code" := LocatCode;
                ShipBinCode := Location."Shipment Bin Code";
            END;
        END ELSE BEGIN
            ShipBinCode := '';
            LocatCode := '';
            "Location Code" := LocatCode;
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

        MESSAGE(Text002, BinCode);
        BinCode := '';
        "Bin Code" := BinCode;
    end;


    procedure AssignItemNo(var ItemNum: Code[20])
    var
        ItemError: Boolean;
    begin
        // TESTFIELD("Whse. Document No.");
        ItemError := FALSE;
        ErrorTxt := '';

        IF (ItemNum <> '') THEN BEGIN
            TESTFIELD("BC6_Whse. Document No.");
            IF CodeEANOk(ItemNum) THEN BEGIN
                // ItemNo2 := DistInt.GetItem(ItemNo); TODO:
                IF Item.GET(ItemNo2) THEN
                    ItemNum := Item."No."
                ELSE BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemNum);
                END;
            END ELSE BEGIN
                IF NOT Item.GET(ItemNum) THEN BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemNum);
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

            IF NOT ItemExistOnInvtPick(ItemNum, '') THEN BEGIN
                IF NOT ItemError THEN
                    ErrorTxt := STRSUBSTNO(Text016, ItemNum, "BC6_Whse. Document No.");
                ItemError := TRUE;
            END;
        END;

        IF ItemError THEN BEGIN
            MESSAGE('%1', ErrorTxt);
        END ELSE BEGIN
            VALIDATE("Item No.", ItemNum);
            VALIDATE("Bin Code", FromBinCode);
            VALIDATE(Quantity, 1);
            IF ShipBinCode <> '' THEN BEGIN
                ToBinCode := ShipBinCode;
                AssignBinCode(ToBinCode);
            END;
        END;

        UpdateCurrForm();
    end;

    procedure AssignQty(var Quantity: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (Quantity <> '') THEN BEGIN
            EVALUATE(Quantity, Quantity);
            VALIDATE(Quantity);
            AssignBinCode(ToBinCode);
            UpdateCurrForm();
            EXIT;
        END;

        IF Quantity <> '' THEN
            MESSAGE(Text006, Quantity);
        Quantity := '';
        VALIDATE(Quantity, 0);
        Quantity := FORMAT(Quantity);
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
    end;


    procedure ItemExistOnInvtPick(ItemNo: Code[20]; BinCode: Code[20]): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        IF ("BC6_Whse. Document No." <> '') THEN BEGIN
            IF InvtPick.GET(InvtPick.Type::"Invt. Pick", "BC6_Whse. Document No.") AND InvtPick."BC6_Sales Counter" THEN
                IF Location.GET("Location Code") THEN
                    ShipBinCode := Location."Shipment Bin Code";
            EXIT(TR UE);
           

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

    local procedure AfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
        ToBinCodeCtrlVisible := FALSE;
    end;
}

