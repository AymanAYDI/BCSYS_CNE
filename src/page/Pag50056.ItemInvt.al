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

    layout
    {
        area(content)
        {
            // usercontrol(ScanZone; "ControlAddinScanCapture") TODO: Dotnet
            // {
            //     Visible = true;
            //     ApplicationArea = All;

            //     trigger ControlAddInReady()
            //     begin
            //         CurrPage.ScanZone.AddControl(1, ItemNoCaption, '');
            //         CurrPage.ScanZone.SetFocus(1);
            //     end;

            //     trigger KeyPressed(index: Integer; data: Text)
            //     begin
            //         CASE data OF
            //             '113':
            //                 CurrPage.ScanZone.SubmitAllData(2); //F2
            //             '114':
            //                 CurrPage.ScanZone.SubmitAllData(3); //F3
            //             '121':
            //                 CurrPage.ScanZone.SubmitAllData(1); //F10
            //         END;
            //     end;

            //     trigger TextCaptured(index: Integer; data: Text)
            //     begin
            //         CASE index OF
            //             1:
            //                 BEGIN
            //                     data := ScanDeviceHelper.ConvertScanData(data);
            //                     ItemNo := COPYSTR(data, 1, MAXSTRLEN(ItemNo));
            //                     AssignItemNo(ItemNo);
            //                     CurrPage.ScanZone.reset(1);
            //                     CurrPage.ScanZone.SetText(1, ItemNo);
            //                     CurrPage.ScanZone.SetFocus(1);
            //                 END;
            //         END;
            //     end;

            //     trigger AddInDrillDown(index: Integer; data: Text)
            //     begin
            //         CASE index OF
            //             1:
            //                 BEGIN
            //                     CLEAR(ItemForm);
            //                     Item.RESET;
            //                     //>>TI318739
            //                     Item.SETRANGE(Blocked, FALSE);
            //                     //<<TI318739
            //                     ItemForm.SETTABLEVIEW(Item);
            //                     ItemForm.LOOKUPMODE(TRUE);
            //                     IF ItemNo <> '' THEN
            //                         IF Item.GET(ItemNo) THEN
            //                             ItemForm.SETRECORD(Item);
            //                     IF ItemForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //                         ItemForm.GETRECORD(Item);
            //                         ItemNo := Item."No.";
            //                         CurrPage.ScanZone.SetText(1, ItemNo);
            //                         LocationCode := '';
            //                         CurrPage.SAVERECORD;
            //                         AssignItemNo(ItemNo);
            //                     END;
            //                 END;
            //         END;
            //     end;

            //     trigger Focused(index: Integer; data: Text)
            //     begin
            //     end;

            //     trigger FocusLost(index: Integer; data: Text)
            //     begin
            //     end;

            //     trigger DataSubmited(index: Integer; data: Text)
            //     begin
            //     end;
            // }
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
                field("Location Code"; "Location Code")
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
                field("Bin Code"; "Bin Code")
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
                field(Quantity; Quantity)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MESSAGE(FIELDCAPTION(Quantity));
                        EXIT;
                    end;
                }
                field("Pick Qty."; "Pick Qty.")
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
                field(Default; Default)
                {
                    Image = "None";
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Fixed; Fixed)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT;
                    end;
                }
                field("Item No."; "Item No.")
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
        Item: Record Item;
        Location: Record Location;
        Bin: Record Bin;
        ItemNo: Code[20];
        ItemNo2: Code[20];
        ItemDescription: Text[250];
        LocationCode: Code[20];
        DistInt: Codeunit "Dist. Integration";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        BoolWait: Boolean;
        // ScanDeviceHelper: Codeunit 50090; TODO:
        [InDataSet]
        IsVisibleSearch: Boolean;
        ItemNoCaption: Label 'Item No.', Comment = 'FRA="N° Article"';
        [InDataSet]
        IsChangeBinEnabled: Boolean;


    procedure SetRecFilters()
    begin
        ItemNo := Item."No.";
        ItemDescription := Item.Description;
        RESET();
        SETRANGE("Item No.", Item."No.");
        IF LocationCode <> '' THEN
            SETRANGE("Location Code", LocationCode);
        SETFILTER(Quantity, '<>%1', 0);
        IF FIND('-') THEN BEGIN
            CurrPage.UPDATE(FALSE);
            EXIT;
        END;
        ClearFilters();
    end;


    procedure ClearFilters()
    begin
        RESET();
        SETRANGE("Min. Qty.", 111111111111111.0);
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
                // ItemNo2 := DistInt.GetItem(FromItemNo); TODO:
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
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
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

