page 50066 "BC6_Inventory Card MiniForm F3"
{
    AutoSplitKey = false;
    Caption = 'Inventory', Comment = 'FRA="Inventaire article"';
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
                Visible = ItemNoCtrlVisible;
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
            field(Description; Description)
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'Description';
            }
            field(QtyCtrl; Qty)
            {
                Caption = 'Quantity', Comment = 'FRA="Quantité"';
                Editable = QtyCtrlEditable;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = QtyCtrlVisible;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    IF FromBinCode = '' THEN
                        ERROR('Veuillez spécifier l''emplacement.');

                    QtyOnAfterValidate();
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
            action(Item)
            {
                Caption = 'Item', Comment = 'FRA="N°&art."';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F2';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PgeLInventoryItemSelection: Page "BC6_Inventory Card MiniForm F2";
                begin
                    CLEAR(LastJnlLine);
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

                        CurrPage.CLOSE();
                        CLEAR(PgeLInventoryItemSelection);
                        PgeLInventoryItemSelection.SETTABLEVIEW(Rec);
                        PgeLInventoryItemSelection.RUN();

                    END;
                end;
            }
            action("&Bin.")
            {
                Caption = '&Bin.', Comment = 'FRA="&Emp."';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F3';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PgeLInventoryBinSelection: Page "BC6_Inventory Card MiniForm F3";
                begin
                    CLEAR(LastJnlLine);
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

                        CurrPage.CLOSE();
                        CLEAR(PgeLInventoryBinSelection);
                        PgeLInventoryBinSelection.SETTABLEVIEW(Rec);
                        PgeLInventoryBinSelection.RUN();

                    END;
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
                    CurrPage.CLOSE();
                end;
            }
            action("&Delete")
            {
                Caption = '&Delete', Comment = 'FRA="&Delete"';
                ShortCutKey = 'F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    page50066: Page "BC6_Inventory Card MiniForm F3";
                begin
                    DELETE(TRUE);

                    page50066.SETTABLEVIEW(Rec);
                    page50066.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrRecord();
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
        AfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee();
        ShowCtrl := TRUE;
        EditableCtrl := TRUE;
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
        DistInt: Codeunit "Dist. Integration";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BoolWait: Boolean;
        EditableCtrl: Boolean;
        EditableFromBinCtrl: Boolean;
        EditableLotCtrl: Boolean;
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
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
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Text011: Label 'Inventory Item', Comment = 'FRA="Inventaire article"';
        Text013: Label 'Bar code incorrect \ %1', Comment = 'FRA="Code barres erroné \ %1"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="%1 article bloqué"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        BarTxt: Text[30];

    procedure NewLine()
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
            LastJnlLine."Line No." := 0;
        END;

        SetUpNewLine(xRec);
        "Entry Type" := "Entry Type"::"Positive Adjmt.";
        "Line No." := LastJnlLine."Line No." + 10000;
        VALIDATE("Posting Date", WORKDATE());

        IF LocationCode = '' THEN
            LocationCode := Location.Code;

        AssignLocationCode(LocationCode);
    end;


    procedure OpenWithWhseEmployee(): Boolean
    var
        WhsEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocatCode: Code[10];
    begin
        CurrPage.CAPTION := Text011;

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 3");
        IF USERID <> '' THEN BEGIN
            WhsEmployee.SETRANGE("User ID", USERID);
            IF WhsEmployee.FIND('-') THEN BEGIN
                WhsEmployee.SETRANGE(Default, TRUE);
                IF WhsEmployee.FIND('-') THEN
                    LocationCode := WhsEmployee."Location Code"
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

    procedure AssignLocationCode(var LocationsCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        CLEAR(Location);
        IF (LocationsCode <> '') AND
           (STRLEN(LocationsCode) < 20) THEN BEGIN
            IF Location.GET(LocationsCode) THEN
                "Location Code" := LocationsCode;
        END ELSE BEGIN
            LocationsCode := '';
            "Location Code" := LocationsCode;
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
                "Bin Code" := BinCode;
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        "Bin Code" := BinCode;
    end;

    procedure AssignItemNo(var "ItemNo.": Code[20])
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF ("ItemNo." <> '') THEN BEGIN
            IF CodeEANOk("ItemNo.") THEN BEGIN
                ItemNo2 := FunctionMgt.GetItem("ItemNo.");
                IF Item.GET(ItemNo2) THEN
                    "ItemNo." := Item."No.";
            END ELSE BEGIN
                IF Item.GET("ItemNo.") THEN;
            END;
            "Phys. Inventory" := FALSE;
            VALIDATE("Item No.", "ItemNo.");
            VALIDATE("Bin Code", FromBinCode);
            "Phys. Inventory" := TRUE;
            UpdateCurrForm();
            EXIT;
        END;

        IF "ItemNo." <> '' THEN
            MESSAGE(Text004, "ItemNo.");
        "ItemNo." := '';
        Description := '';
        VALIDATE("Item No.", "ItemNo.");
        "ItemNo." := "Item No.";
        UpdateCurrForm();
    end;

    procedure AssignQty(var Quantity: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (Quantity <> '') THEN BEGIN
            "Phys. Inventory" := TRUE;
            EVALUATE("Qty. (Phys. Inventory)", Quantity);
            VALIDATE("Qty. (Phys. Inventory)");
            Quantity := FORMAT("Qty. (Phys. Inventory)");
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

    local procedure AfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateCurrForm();
    end;
}

