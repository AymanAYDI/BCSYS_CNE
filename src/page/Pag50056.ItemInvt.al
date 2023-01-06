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
                Visible = true;
                ApplicationArea = All;

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
                                //>>TI318739
                                Item.SETRANGE(Blocked, FALSE);
                                //<<TI318739
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

                trigger Focused(index: Integer; data: Text)
                begin
                end;

                trigger FocusLost(index: Integer; data: Text)
                begin
                end;

                trigger DataSubmited(index: Integer; data: Text)
                begin
                end;
            }
            field(ItemNo; ItemNo)
            {
                Caption = 'Item Filter', Comment = 'FRA="N° article"';
                Importance = Promoted;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = false;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CLEAR(ItemForm);
                    Item.RESET();
                    //>>TI318739
                    Item.SETRANGE(Blocked, FALSE);
                    //<<TI318739
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
                Caption = 'Item Filter', Comment = 'FRA="Filtre article"';
                Editable = false;
                ApplicationArea = All;

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
                    Visible = false;
                    ApplicationArea = All;

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
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = All;

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
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MESSAGE(Rec.FIELDCAPTION(Quantity));
                        EXIT;
                    end;
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Available Qty. to Take"; CalcAvailQty())
                {
                    Caption = 'Available Qty. to Take', Comment = 'FRA="Qté disponible pour prélèv."';
                    DecimalPlaces = 0 : 0;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    Image = "None";
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Fixed; Rec.Fixed)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(ItemDetailsFB; "BC6_Item ScanDevice Factbox")
            {
                Caption = 'Item Details', Comment = 'FRA="Détails Article"';
                SubPageLink = "No." = FIELD("Item No.");
                ApplicationArea = All;
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
                    Caption = 'Change Def. Bin content', Comment = 'FRA="Modifier emp. par déf."';
                    Enabled = IsChangeBinEnabled;
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
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
    var
        BinContent: Record "Bin Content";
    begin
        ClearFilters();
        IsVisibleSearch := NOT (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
        //Not Compatible with Phone device
        // IF ISCLEAR(WshShell) THEN
        //  CREATE(WshShell,FALSE ,TRUE);
        //
        //
        // BoolWait := FALSE;
        // WshShell.SendKeys('{TAB}', BoolWait);
        // WshShell.SendKeys('{TAB}', BoolWait);
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
        BoolWait: Boolean;
        [InDataSet]
        IsChangeBinEnabled: Boolean;
        [InDataSet]
        IsVisibleSearch: Boolean;
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
        IF (FromItemNo <> '') THEN BEGIN
            IF (STRLEN(FromItemNo) = 13) OR
               (STRLEN(FromItemNo) = 14) THEN BEGIN
                ItemNo2 := FunctionsMgt.GetItem(FromItemNo);
                IF Item.GET(ItemNo2) THEN;
            END ELSE BEGIN
                //>>TI318739
                //IF Item.GET(FromItemNo) THEN;
                Item.RESET();
                Item.SETRANGE("No.", FromItemNo);
                Item.SETRANGE(Blocked, FALSE);
                IF Item.FINDFIRST() THEN;
                //<<TI318739
            END;
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

