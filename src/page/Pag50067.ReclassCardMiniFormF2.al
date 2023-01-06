page 50067 "BC6_Reclass. Card MiniForm F2"
{
    AutoSplitKey = false;
    Caption = 'Reclass.', Comment = 'FRA="Reclassement article"';
    DelayedInsert = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = false;
    SourceTable = "Item Journal Line";
    SourceTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                      ORDER(Ascending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
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
                    IF (ItemNo <> '') THEN
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
            field(Description; Rec.Description)
            {
                Editable = false;
                Caption = 'Description';
                ApplicationArea = All;
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
                    QtyOnAfterValidate();
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
                    Bin.RESET();
                    IF LocationCode <> '' THEN
                        Bin.SETRANGE("Location Code", LocationCode);

                    BinForm.SETTABLEVIEW(Bin);
                    BinForm.LOOKUPMODE(TRUE);
                    IF Bin.FIND('-') THEN
                        BinForm.SETRECORD(Bin);
                    IF BinForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        BinForm.GETRECORD(Bin);
                        ToBinCode := Bin.Code;
                        AssignBinCode(ToBinCode);
                    END;
                end;

                trigger OnValidate()
                begin
                    ToBinCodeOnAfterValidate();
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
                        BinContent.RESET();
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
                        IF BinContentForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            BinContentForm.GETRECORD(BinContent);
                            FromBinCode := BinContent."Bin Code";
                            AssignFromBinCode(FromBinCode);
                        END;
                    END ELSE BEGIN
                        CLEAR(BinForm);
                        Bin.RESET();
                        IF LocationCode <> '' THEN
                            Bin.SETRANGE("Location Code", LocationCode);
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            BinForm.GETRECORD(Bin);
                            FromBinCode := Bin.Code;
                            AssignFromBinCode(FromBinCode);
                        END;
                    END;
                end;

                trigger OnValidate()
                begin
                    FromBinCodeOnAfterValidate();
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
            action("&Item")
            {
                Caption = '&Item', Comment = 'FRA="Magasin"';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F2';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PgeLReclassItemSelection: Page "BC6_Reclass. Card MiniForm F2";
                begin
                    CLEAR(LastJnlLine);
                    LastJnlLine.RESET();
                    LastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    LastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF LastJnlLine.FIND('+') THEN BEGIN
                        Rec.INIT();
                        Rec."Journal Template Name" := LastJnlLine."Journal Template Name";
                        Rec."Journal Batch Name" := LastJnlLine."Journal Batch Name";
                        Rec."Line No." := LastJnlLine."Line No." + 10000;
                        Rec.VALIDATE("Entry Type", Rec."Entry Type"::Transfer);
                        Rec.VALIDATE("Posting Date", WORKDATE());
                        Rec."Document No." := LastJnlLine."Document No.";
                        Rec."Location Code" := LastJnlLine."Location Code";
                        Rec."Bin Code" := LastJnlLine."Bin Code";
                        Rec.INSERT(TRUE);

                        CurrPage.CLOSE();
                        PgeLReclassItemSelection.SETTABLEVIEW(Rec);
                        PgeLReclassItemSelection.RUN();

                    END;
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
                    PgeLReclassBinSelection: Page "BC6_Reclass. Card MiniForm F3";
                begin
                    CLEAR(LastJnlLine);
                    LastJnlLine.RESET();
                    LastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    LastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF LastJnlLine.FIND('+') THEN BEGIN
                        Rec.INIT();
                        Rec."Journal Template Name" := LastJnlLine."Journal Template Name";
                        Rec."Journal Batch Name" := LastJnlLine."Journal Batch Name";
                        Rec."Line No." := LastJnlLine."Line No." + 10000;
                        Rec.VALIDATE("Entry Type", Rec."Entry Type"::Transfer);
                        Rec.VALIDATE("Posting Date", WORKDATE());
                        Rec."Document No." := LastJnlLine."Document No.";
                        Rec."Location Code" := LastJnlLine."Location Code";
                        Rec.INSERT(TRUE);

                        CurrPage.CLOSE();
                        PgeLReclassBinSelection.SETTABLEVIEW(Rec);
                        PgeLReclassBinSelection.RUN();

                    END;
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
                    PgeLReclass: Page "BC6_Reclass. Card MiniForm";
                begin
                    PostBatch();

                    CurrPage.CLOSE();
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
                Caption = '&Quit', Comment = 'FRA="&Quitter"';
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
                Image = Delete;

                trigger OnAction()
                var
                    page50067: Page "BC6_Reclass. Card MiniForm F2";
                begin
                    Rec.DELETE(TRUE);

                    page50067.SETTABLEVIEW(Rec);
                    page50067.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
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
        OnAfterGetCurrRecord();
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
        ItemTrackingCode: Record "Item Tracking Code";
        Location: Record Location;
        WhseEmployee: Record "Warehouse Employee";
        DistInt: Codeunit "Dist. Integration";
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        BinContentForm: Page "BC6_Bin Content List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BoolWait: Boolean;
        EditableCtrl: Boolean;
        EditableFromBinCtrl: Boolean;
        EditableLotCtrl: Boolean;
        [InDataSet]
        FromBinCodeCtrlVisible: Boolean;
        ItemError: Boolean;
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
        [InDataSet]
        ToBinCodeCtrlEditable: Boolean;
        [InDataSet]
        ToBinCodeCtrlVisible: Boolean;
        Qty: Code[10];
        BarCode: Code[20];
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
        Text012: Label 'Item %1 with tracking', Comment = 'FRA="%1 article avec traçabilité"';
        Text013: Label 'Item No. %1 Incorrect', Comment = 'FRA="%1 n° article erroné"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="%1 article bloqué"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        BarTxt: Text[30];
        ErrorTxt: Text[250];

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
        LastJnlLine.RESET();
        LastJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        LastJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IF NOT LastJnlLine.FIND('+') THEN BEGIN
            LastJnlLine.INIT();
            LastJnlLine."Journal Template Name" := Rec."Journal Template Name";
            LastJnlLine."Journal Batch Name" := Rec."Journal Batch Name";
            LastJnlLine."Line No." := 0;
        END;

        Rec.SetUpNewLine(xRec);
        Rec."Entry Type" := Rec."Entry Type"::Transfer;
        Rec."Line No." := LastJnlLine."Line No." + 10000;
        Rec.VALIDATE("Posting Date", WORKDATE());

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

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 2");

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
                Rec.FILTERGROUP := 2;
                ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 2");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
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


    procedure AssignLocationCode(var LocationsCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        CLEAR(Location);
        IF (LocationsCode <> '') AND
           (STRLEN(LocationsCode) < 20) THEN BEGIN
            IF Location.GET(LocationsCode) THEN
                Rec."Location Code" := LocationsCode;
        END ELSE BEGIN
            LocationsCode := '';
            Rec."Location Code" := LocationsCode;
            MESSAGE(Text004);
        END;
    end;

    procedure AssignBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> Rec."New Bin Code") THEN
                Rec.VALIDATE("New Location Code", Rec."Location Code");
            Rec.VALIDATE("New Bin Code", BinCode);
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        Rec."New Bin Code" := BinCode;
    end;

    procedure AssignFromBinCode(var BinCode: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (BinCode <> '') AND
           (STRLEN(BinCode) < 20) THEN BEGIN
            IF (BinCode <> Rec."Bin Code") THEN
                // VALIDATE("Bin Code",BinCode);
                Rec."Bin Code" := BinCode;
            UpdateCurrForm();
            EXIT;
        END;

        MESSAGE(Text002, BinCode);
        BinCode := '';
        Rec."Bin Code" := BinCode;
    end;

    procedure AssignItemNo(var ItemN: Code[20])
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        ItemError := FALSE;
        ErrorTxt := '';

        IF (ItemN <> '') THEN BEGIN
            IF CodeEANOk(ItemN) THEN BEGIN
                ItemNo2 := FunctionMgt.GetItem(ItemNo);
                IF Item.GET(ItemNo2) THEN
                    ItemN := Item."No."
                ELSE BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemN);
                END;
            END ELSE BEGIN
                IF NOT Item.GET(ItemN) THEN BEGIN
                    ItemError := TRUE;
                    ErrorTxt := STRSUBSTNO(Text013, ItemN);
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
            Rec.VALIDATE("Item No.", ItemN);
            Rec.VALIDATE("Bin Code", FromBinCode);
            Rec.VALIDATE(Quantity, 1);
        END;

        UpdateCurrForm();
    end;

    procedure AssignQty(var Quantity: Code[20])
    var
        Text004: Label 'Bar code incorrect', Comment = 'FRA="Code barres eronné."';
    begin
        IF (Quantity <> '') THEN BEGIN
            EVALUATE(Quantity, Quantity);
            Rec.VALIDATE(Quantity);
            Quantity := FORMAT(Quantity);
            EXIT;
        END;

        IF Quantity <> '' THEN
            MESSAGE(Text006, Quantity);
        Quantity := '';
        Rec.VALIDATE(Quantity, 0);
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
    begin
        BarCode := '';
        LocationCode := Rec."Location Code";
        IF NOT Location.GET(Rec."Location Code") THEN
            Location.INIT();
        FromBinCode := Rec."Bin Code";
        ToBinCode := Rec."New Bin Code";
        ItemNo := Rec."Item No.";
        Qty := FORMAT(Rec.Quantity);
        EditableCtrl := (Rec."Item No." <> '');
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

