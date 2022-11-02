page 50056 "Item Invt."
{
    // --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // www.prodware.fr
    // --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // 
    // //>>MODIF HL
    // TI318739 DO.GEPO 15/03/2016 : return item not blocked
    // 
    // --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    Caption = 'Item Invt.';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Document;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = Table7302;

    layout
    {
        area(content)
        {
            usercontrol(ScanZone; "ControlAddinScanCapture")
            {
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
                                    CurrPage.ScanZone.SetText(1, ItemNo);
                                    LocationCode := '';
                                    CurrPage.SAVERECORD;
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
                Caption = 'Item Filter';
                Importance = Promoted;
                Style = Standard;
                StyleExpr = TRUE;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
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
                        LocationCode := '';
                        CurrPage.SAVERECORD;
                        AssignItemNo(ItemNo);
                    END;
                    IsChangeBinEnabled := Item."No." <> '';
                end;

                trigger OnValidate()
                begin
                    ItemNoOnAfterValidate;
                    IsChangeBinEnabled := Item."No." <> '';
                end;
            }
            field(ItemDescription; ItemDescription)
            {
                Caption = 'Item Filter';
                Editable = false;

                trigger OnValidate()
                begin
                    ItemDescriptionOnAfterValidate;
                end;
            }
            repeater(BinContents)
            {
                Caption = 'Bin Contents';
                Editable = false;
                field("Location Code"; "Location Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(LocationForm);
                        Location.RESET;
                        LocationForm.SETTABLEVIEW(Location);
                        LocationForm.LOOKUPMODE(TRUE);
                        IF Location.FIND('-') THEN
                            LocationForm.SETRECORD(Location);
                        IF LocationForm.RUNMODAL = ACTION::LookupOK THEN;
                    end;
                }
                field("Bin Code"; "Bin Code")
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(BinForm);
                        Bin.RESET;
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL = ACTION::LookupOK THEN;
                    end;
                }
                field(Quantity; Quantity)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        MESSAGE(FIELDCAPTION(Quantity));
                        EXIT;
                    end;
                }
                field("Pick Qty."; "Pick Qty.")
                {
                    Visible = false;
                }
                field(CalcAvailQty; CalcAvailQty)
                {
                    Caption = 'Available Qty. to Take';
                    DecimalPlaces = 0 : 0;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
                field(Default; Default)
                {
                    Image = "None";
                    Importance = Additional;
                    Visible = false;
                }
                field(Fixed;Fixed)
                {
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT;
                    end;
                }
                field("Item No."; "Item No.")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(ItemDetailsFB; 50075)
            {
                Caption = 'Item Details';
                SubPageLink = No.=FIELD(Item No.);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action(ChangeDefBin)
                {
                    Caption = 'Change Def. Bin content';
                    Enabled = IsChangeBinEnabled;
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.ItemDetailsFB.PAGE.ChangeDefaultBinContent;
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
        BinContent: Record "7302";
    begin
        ClearFilters;
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
        Item: Record "27";
        Location: Record "14";
        Bin: Record "7354";
        ItemNo: Code[20];
        ItemNo2: Code[20];
        ItemDescription: Text[250];
        LocationCode: Code[20];
        DistInt: Codeunit "5702";
        ItemForm: Page "50051";
        LocationForm: Page "50053";
        BinForm: Page "50052";
        BoolWait: Boolean;
        ScanDeviceHelper: Codeunit "50090";
        [InDataSet]
        IsVisibleSearch: Boolean;
        ItemNoCaption: Label 'Item No.';
        [InDataSet]
        IsChangeBinEnabled: Boolean;

    [Scope('Internal')]
    procedure SetRecFilters()
    begin
        ItemNo := Item."No.";
        ItemDescription := Item.Description;
        RESET;
        SETRANGE("Item No.", Item."No.");
        IF LocationCode <> '' THEN
            SETRANGE("Location Code", LocationCode);
        SETFILTER(Quantity, '<>%1', 0);
        IF FIND('-') THEN BEGIN
            CurrPage.UPDATE(FALSE);
            EXIT;
        END;
        ClearFilters;
    end;

    [Scope('Internal')]
    procedure ClearFilters()
    begin
        RESET;
        SETRANGE("Min. Qty.", 111111111111111.0);
        CurrPage.UPDATE(FALSE);
    end;

    [Scope('Internal')]
    procedure AssignItemNo(FromItemNo: Code[20])
    begin
        CLEAR(DistInt);
        CLEAR(Item);
        CLEAR(ItemNo2);
        IF (FromItemNo <> '') THEN BEGIN
            IF (STRLEN(FromItemNo) = 13) OR
               (STRLEN(FromItemNo) = 14) THEN BEGIN
                ItemNo2 := DistInt.GetItem(FromItemNo);
                IF Item.GET(ItemNo2) THEN;
            END ELSE BEGIN
                //>>TI318739
                //IF Item.GET(FromItemNo) THEN;
                Item.RESET;
                Item.SETRANGE("No.", FromItemNo);
                Item.SETRANGE(Blocked, FALSE);
                IF Item.FINDFIRST THEN;
                //<<TI318739
            END;
        END;
        SetRecFilters;
    end;

    [Scope('Internal')]
    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;

    local procedure ItemNoOnAfterValidate()
    begin
        LocationCode := '';
        CurrPage.SAVERECORD;
        AssignItemNo(ItemNo);
    end;

    local procedure ItemDescriptionOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;
}
