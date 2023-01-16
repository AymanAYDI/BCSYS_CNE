page 50056 "BC6_Item Invt."
{
    Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Document;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Bin Content";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            usercontrol(ScanZone; "BC6_ControlAddinScanCapture")
            {
                ApplicationArea = All;
                Visible = true;

                trigger ControlAddInReady()
                begin
                    CurrPage.ScanZone.AddControl(1, ItemNoCaption, '');
                    CurrPage.ScanZone.SetFocus(1);
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
                                data := ScanDeviceHelper.ConvertScanData(data);
                                ItemNo := COPYSTR(data, 1, MAXSTRLEN(ItemNo));
                                AssignItemNo(ItemNo);
                                CurrPage.ScanZone.reset(1);
                                CurrPage.ScanZone.SetText(1, ItemNo);
                                CurrPage.ScanZone.SetFocus(1);
                            END;
                    END;
                end;

                trigger AddInDrillDown(index: Integer; data: Text)
                begin
                    CASE index OF
                        1:
                            BEGIN
                                CLEAR(ItemForm);
                                Item.RESET();
                                Item.SETRANGE(Blocked, FALSE);
                                ItemForm.SETTABLEVIEW(Item);
                                ItemForm.LOOKUPMODE(TRUE);
                                IF ItemNo <> '' THEN
                                    IF Item.GET(ItemNo) THEN
                                        ItemForm.SETRECORD(Item);
                                IF ItemForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                    ItemForm.GETRECORD(Item);
                                    ItemNo := Item."No.";
                                    CurrPage.ScanZone.SetText(1, ItemNo);
                                    LocationCode := '';
                                    CurrPage.SAVERECORD();
                                    AssignItemNo(ItemNo);
                                END;
                            END;
                    END;
                end;
            }
            field(ItemNo; ItemNo)
            {
                ApplicationArea = All;
                Caption = 'Item Filter', Comment = 'FRA="N° article"';
                Importance = Promoted;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CLEAR(ItemForm);
                    Item.RESET();
                    Item.SETRANGE(Blocked, FALSE);
                    ItemForm.SETTABLEVIEW(Item);
                    ItemForm.LOOKUPMODE(TRUE);
                    IF ItemNo <> '' THEN
                        IF Item.GET(ItemNo) THEN
                            ItemForm.SETRECORD(Item);
                    IF ItemForm.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        ItemForm.GETRECORD(Item);
                        ItemNo := Item."No.";
                        LocationCode := '';
                        CurrPage.SAVERECORD();
                        AssignItemNo(ItemNo);
                    END;
                    IsChangeBinEnabled := Item."No." <> '';
                end;

                trigger OnValidate()
                begin
                    ItemNoOnAfterValidate();
                    IsChangeBinEnabled := Item."No." <> '';
                end;
            }
            field(ItemDescription; ItemDescription)
            {
                ApplicationArea = All;
                Caption = 'Item Filter', Comment = 'FRA="Filtre article"';
                Editable = false;

                trigger OnValidate()
                begin
                    ItemDescriptionOnAfterValidate();
                end;
            }
            repeater(BinContents)
            {
                Caption = 'Bin Contents', Comment = 'FRA="Contenus emplacements"';
                Editable = false;
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(LocationForm);
                        Location.RESET();
                        LocationForm.SETTABLEVIEW(Location);
                        LocationForm.LOOKUPMODE(TRUE);
                        IF Location.FIND('-') THEN
                            LocationForm.SETRECORD(Location);
                        IF LocationForm.RUNMODAL() = ACTION::LookupOK THEN;
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(BinForm);
                        Bin.RESET();
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL() = ACTION::LookupOK THEN;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        MESSAGE(Rec.FIELDCAPTION(Quantity));
                        EXIT;
                    end;
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Available Qty. to Take"; CalcAvailQty())
                {
                    ApplicationArea = All;
                    Caption = 'Available Qty. to Take', Comment = 'FRA="Qté disponible pour prélèv."';
                    DecimalPlaces = 0 : 0;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field(Fixed; Rec.Fixed)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(ItemDetailsFB; "BC6_Item ScanDevice Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Details', Comment = 'FRA="Détails Article"';
                SubPageLink = "No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1)
            {
                action(ChangeDefBin)
                {
                    ApplicationArea = All;
                    Caption = 'Change Def. Bin content', Comment = 'FRA="Modifier emp. par déf."';
                    Enabled = IsChangeBinEnabled;
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        CurrPage.ItemDetailsFB.PAGE.ChangeDefaultBinContent();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IsChangeBinEnabled := Item."No." <> '';
    end;

    trigger OnOpenPage()
    begin
        ClearFilters();
    end;

    var
        Bin: Record Bin;
        Item: Record Item;
        Location: Record Location;
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        ScanDeviceHelper: Codeunit BC6_ScanDeviceHelper;
        DistInt: Codeunit "Dist. Integration";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        [InDataSet]
        IsChangeBinEnabled: Boolean;
        [InDataSet]
        ItemNo: Code[20];
        ItemNo2: Code[20];
        LocationCode: Code[20];
        ItemNoCaption: Label 'Item No.', Comment = 'FRA="N° Article"';
        ItemDescription: Text[250];

    procedure SetRecFilters()
    begin
        ItemNo := Item."No.";
        ItemDescription := Item.Description;
        Rec.RESET();
        Rec.SETRANGE("Item No.", Item."No.");
        IF LocationCode <> '' THEN
            Rec.SETRANGE("Location Code", LocationCode);
        Rec.SETFILTER(Quantity, '<>%1', 0);
        IF Rec.FIND('-') THEN BEGIN
            CurrPage.UPDATE(FALSE);
            EXIT;
        END;
        ClearFilters();
    end;

    procedure ClearFilters()
    begin
        Rec.RESET();
        Rec.SETRANGE("Min. Qty.", 111111111111111.0);
        CurrPage.UPDATE(FALSE);
    end;

    procedure AssignItemNo(FromItemNo: Code[20])
    begin
        CLEAR(DistInt);
        CLEAR(Item);
        CLEAR(ItemNo2);
        IF (FromItemNo <> '') THEN
            IF (STRLEN(FromItemNo) = 13) OR
               (STRLEN(FromItemNo) = 14) THEN BEGIN
                ItemNo2 := FunctionsMgt.GetItem(FromItemNo);
                IF Item.GET(ItemNo2) THEN;
            END ELSE BEGIN
                Item.RESET();
                Item.SETRANGE("No.", FromItemNo);
                Item.SETRANGE(Blocked, FALSE);
                IF Item.FINDFIRST() THEN;
            END;
        SetRecFilters();
    end;

    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Rec.Quantity - Rec."Pick Qty." - Rec."Neg. Adjmt. Qty.");
    end;

    local procedure ItemNoOnAfterValidate()
    begin
        LocationCode := '';
        CurrPage.SAVERECORD();
        AssignItemNo(ItemNo);
    end;

    local procedure ItemDescriptionOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;
}
