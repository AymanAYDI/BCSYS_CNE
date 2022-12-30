report 50101 "BC6_Calculate Inventory"
{
    Caption = 'Calculate Inventory', Comment = 'FRA="Calculer Inventaire"';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE(Type = CONST(Inventory), Blocked = CONST(false));
            RequestFilterFields = "No.", "Location Filter", "Bin Filter";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");

                trigger OnAfterGetRecord()
                var
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempSKU: Boolean;
                    IsHandled: Boolean;
                begin
                    if not GetLocation("Location Code") then
                        CurrReport.Skip();

                    if ("Location Code" <> '') and Location."Use As In-Transit" then
                        CurrReport.Skip();

                    if ColumnDim <> '' then
                        TransferDim("Dimension Set ID");

                    if not "Drop Shipment" then
                        ByBin := Location."Bin Mandatory" and not Location."Directed Put-away and Pick";

                    IsHandled := false;

                    if not SkipCycleSKU("Location Code", "Item No.", "Variant Code") then
                        if ByBin then begin
                            if not TempSKU.Get("Location Code", "Item No.", "Variant Code") then begin
                                InsertTempSKU := false;
                                if "Variant Code" = '' then
                                    InsertTempSKU := true
                                else
                                    if ItemVariant.Get("Item No.", "Variant Code") then
                                        InsertTempSKU := true;
                                if InsertTempSKU then begin
                                    TempSKU."Item No." := "Item No.";
                                    TempSKU."Variant Code" := "Variant Code";
                                    TempSKU."Location Code" := "Location Code";
                                    TempSKU.Insert();
                                    ExecuteLoop := true;
                                end;
                            end;
                            if ExecuteLoop then begin
                                WhseEntry.SetRange("Item No.", "Item No.");
                                WhseEntry.SetRange("Location Code", "Location Code");
                                WhseEntry.SetRange("Variant Code", "Variant Code");
                                if WhseEntry.Find('-') then
                                    if WhseEntry."Entry No." <> OldWhseEntry."Entry No." then begin
                                        OldWhseEntry := WhseEntry;
                                        repeat
                                            WhseEntry.SetRange("Bin Code", WhseEntry."Bin Code");
                                            if not ItemBinLocationIsCalculated(WhseEntry."Bin Code") then begin
                                                WhseEntry.CalcSums("Qty. (Base)");
                                                UpdateBuffer(WhseEntry."Bin Code", WhseEntry."Qty. (Base)", false);
                                            end;
                                            WhseEntry.Find('+');
                                            Item.CopyFilter("Bin Filter", WhseEntry."Bin Code");
                                        until WhseEntry.Next() = 0;
                                    end;
                            end;
                        end else
                            UpdateBuffer('', Quantity, true);
                end;

                trigger OnPreDataItem()
                begin
                    WhseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code");
                    Item.CopyFilter("Bin Filter", WhseEntry."Bin Code");

                    if ColumnDim = '' then
                        TempDimBufIn.SetRange("Table ID", DATABASE::Item)
                    else
                        TempDimBufIn.SetRange("Table ID", DATABASE::"Item Ledger Entry");
                    TempDimBufIn.SetRange("Entry No.");
                    TempDimBufIn.DeleteAll();

                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter");

                trigger OnAfterGetRecord()
                begin
                    if not "Item Ledger Entry".IsEmpty() then
                        CurrReport.Skip();   // Skip if item has any record in Item Ledger Entry.

                    Clear(TempQuantityOnHandBuffer);
                    TempQuantityOnHandBuffer."Item No." := "Item No.";
                    TempQuantityOnHandBuffer."Location Code" := "Location Code";
                    TempQuantityOnHandBuffer."Variant Code" := "Variant Code";

                    GetLocation("Location Code");
                    if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                        TempQuantityOnHandBuffer."Bin Code" := "Bin Code";

                    if not TempQuantityOnHandBuffer.Find() then
                        TempQuantityOnHandBuffer.Insert();   // Insert a zero quantity line.
                end;
            }
            dataitem(ItemWithNoTransaction; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                begin
                    if IncludeItemWithNoTransaction then
                        UpdateQuantityOnHandBuffer(Item."No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if not HideValidationDialog then
                    Window.Update();
                TempSKU.DeleteAll();
            end;

            trigger OnPostDataItem()
            begin
                CalcPhysInvQtyAndInsertItemJnlLine();
            end;

            trigger OnPreDataItem()
            var
                ItemJnlBatch: Record "Item Journal Batch";
                ItemJnlTemplate: Record "Item Journal Template";
            begin
                if PostingDate = 0D then
                    Error(Text000);

                ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");


                if NextDocNo = '' then begin
                    if ItemJnlBatch."No. Series" <> '' then begin
                        ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
                        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                        if not ItemJnlLine.FindFirst() then
                            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, false);
                        ItemJnlLine.Init();
                    end;
                    if NextDocNo = '' then
                        Error(Text001);
                end;

                NextLineNo := 0;

                if not HideValidationDialog then
                    Window.Open(Text002, "No.");

                if not SkipDim then
                    SelectedDim.GetSelectedDim(UserId, 3, REPORT::"Calculate Inventory", '', TempSelectedDim);

                TempQuantityOnHandBuffer.Reset();
                TempQuantityOnHandBuffer.DeleteAll();

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Date', comment = 'FRA="Date comptabilisation"';
                        ToolTip = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.', Comment = 'FRA="Spécifie la date comptabilisation de ce traitement par lots. Par défaut, la date de travail est saisie, mais vous pouvez la modifier."';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate();
                        end;
                    }
                    field(DocumentNo; NextDocNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document No.', comment = 'FRA="N° document"';
                        ToolTip = 'Specifies the number of the document that is processed by the report or batch job.', Comment = 'FRA="Spécifie le nombre de documents traités par l''état ou le traitement par lots."';
                    }
                    field(ItemsNotOnInventory; ZeroQty)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items Not on Inventory.', Comment = 'FRA="Avec qté calculée = 0."';
                        ToolTip = 'Specifies if journal lines should be created for items that are not on inventory, that is, items where the value in the Qty. (Calculated) field is 0.', Comment = 'FRA="Indique si les lignes feuille doivent être créées pour les articles qui ne figurent pas en stock, à savoir les articles dont la valeur du champ Quantité (calculée) est égale à 0."';

                        trigger OnValidate()
                        begin
                            if not ZeroQty then
                                IncludeItemWithNoTransaction := false;
                        end;
                    }
                    field(IncludeItemWithNoTransaction; IncludeItemWithNoTransaction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Item without Transactions', Comment = 'FRA="Inclure l''article sans transactions"';
                        ToolTip = 'Specifies if journal lines should be created for items that are not on inventory and are not used in any transactions.', Comment = 'FRA="Indique si les lignes feuille doivent être créées pour les articles qui ne figurent pas en stock et qui ne sont pas utilisés dans les transactions."';

                        trigger OnValidate()
                        begin
                            if not IncludeItemWithNoTransaction then
                                exit;
                            if not ZeroQty then
                                Error(ItemNotOnInventoryErr);
                        end;
                    }
                    field(ByDimensions; ColumnDim)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'By Dimensions', Comment = 'FRA="Par axe"';
                        Editable = false;
                        ToolTip = 'Specifies the dimensions that you want the batch job to consider.', Comment = 'FRA="Spécifie les axes analytiques dont vous souhaitez que le traitement par lots tienne compte."';

                        trigger OnAssistEdit()
                        begin
                            DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Calculate Inventory", ColumnDim);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if PostingDate = 0D then
                PostingDate := WorkDate();
            ValidatePostingDate();
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
            Item.SETRANGE(Blocked, FALSE);
            Item.SETFILTER("Location Filter", 'ACTI');
            Item.SETFILTER(Inventory, '<>0');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        if SkipDim then
            ColumnDim := ''
        else
            DimSelectionBuf.CompareDimText(3, REPORT::"Calculate Inventory", '', ColumnDim, Text003);
        ZeroQtySave := ZeroQty;
    end;

    var
        TempDimBufIn: Record "Dimension Buffer" temporary;
        TempDimBufOut: Record "Dimension Buffer" temporary;
        DimSelectionBuf: Record "Dimension Selection Buffer";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        Location: Record Location;
        SelectedDim: Record "Selected Dimension";
        TempSelectedDim: Record "Selected Dimension" temporary;
        SourceCodeSetup: Record "Source Code Setup";
        OldWhseEntry: Record "Warehouse Entry";
        WhseEntry: Record "Warehouse Entry";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AdjustPosQty: Boolean;
        ItemTrackingSplit: Boolean;
        SkipDim: Boolean;
        ZeroQtySave: Boolean;
        PhysInvtCountCode: Code[10];
        NegQty: Decimal;
        PosQty: Decimal;
        Window: Dialog;
        NextLineNo: Integer;
        ItemNotOnInventoryErr: Label 'Items Not on Inventory.', Comment = 'FRA="Avec qté calculée = 0."';
        Text000: Label 'Enter the posting date.', Comment = 'FRA="Entrez une date comptabilisation."';
        Text001: Label 'Enter the document no.', Comment = 'FRA="Entrez un numéro de document."';
        Text002: Label 'Processing items    #1##########', Comment = 'FRA="Traitement des articles #1##########"';
        Text003: Label 'Retain Dimensions', Comment = 'FRA="Conserver axes"';
        CycleSourceType: Option " ",Item,SKU;

    protected var
        TempQuantityOnHandBuffer: Record "Inventory Buffer" temporary;
        TempSKU: Record "Stockkeeping Unit" temporary;
        HideValidationDialog: Boolean;
        IncludeItemWithNoTransaction: Boolean;
        ZeroQty: Boolean;
        NextDocNo: Code[20];
        PostingDate: Date;
        ColumnDim: Text[250];

    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        if not ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name") then
            exit;

        if ItemJnlBatch."No. Series" = '' then
            NextDocNo := ''
        else begin
            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, false);
            Clear(NoSeriesMgt);
        end;
    end;

    procedure InsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal)
    var
        Bin: Record Bin;
        DimValue: Record "Dimension Value";
        ItemLedgEntry: Record "Item Ledger Entry";
        DimMgt: Codeunit DimensionManagement;
        IsHandled: Boolean;
        NoBinExist: Boolean;
        ShouldInsertItemJnlLine: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            with ItemJnlLine do begin
                if NextLineNo = 0 then begin
                    LockTable();
                    SetRange("Journal Template Name", "Journal Template Name");
                    SetRange("Journal Batch Name", "Journal Batch Name");
                    if FindLast() then
                        NextLineNo := "Line No.";

                    SourceCodeSetup.Get();
                end;
                NextLineNo := NextLineNo + 10000;
                ShouldInsertItemJnlLine := (Quantity2 <> 0) or ZeroQty;
                if ShouldInsertItemJnlLine then begin
                    if (Quantity2 = 0) and Location."Bin Mandatory" and not Location."Directed Put-away and Pick"
                    then
                        if not Bin.Get(Location.Code, BinCode2) then
                            NoBinExist := true;


                    Init();
                    "Line No." := NextLineNo;
                    Validate("Posting Date", PostingDate);
                    if PhysInvQuantity >= Quantity2 then
                        Validate("Entry Type", "Entry Type"::"Positive Adjmt.")
                    else
                        Validate("Entry Type", "Entry Type"::"Negative Adjmt.");
                    Validate("Document No.", NextDocNo);
                    Validate("Item No.", ItemNo);
                    Validate("Variant Code", VariantCode2);
                    Validate("Location Code", Location.Code);
                    if not NoBinExist then
                        Validate("Bin Code", BinCode2)
                    else
                        Validate("Bin Code", '');
                    Validate("Source Code", SourceCodeSetup."Phys. Inventory Journal");
                    "Qty. (Phys. Inventory)" := PhysInvQuantity;
                    "Phys. Inventory" := true;
                    Validate("Qty. (Calculated)", Quantity2);
                    "Posting No. Series" := ItemJnlBatch."Posting No. Series";
                    "Reason Code" := ItemJnlBatch."Reason Code";

                    "Phys Invt Counting Period Code" := PhysInvtCountCode;
                    "Phys Invt Counting Period Type" := CycleSourceType;

                    if Location."Bin Mandatory" then
                        "Dimension Set ID" := 0;
                    "Shortcut Dimension 1 Code" := '';
                    "Shortcut Dimension 2 Code" := '';

                    ItemLedgEntry.Reset();
                    ItemLedgEntry.SetCurrentKey("Item No.");
                    ItemLedgEntry.SetRange("Item No.", ItemNo);
                    if ItemLedgEntry.FindLast() then
                        "Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
                    else
                        "Last Item Ledger Entry No." := 0;

                    Insert(true);

                    if Location.Code <> '' then
                        if Location."Directed Put-away and Pick" then
                            ReserveWarehouse(ItemJnlLine);

                    if ColumnDim = '' then
                        DimEntryNo2 := CreateDimFromItemDefault();

                    if DimBufMgt.GetDimensions(DimEntryNo2, TempDimBufOut) then begin
                        TempDimSetEntry.Reset();
                        TempDimSetEntry.DeleteAll();
                        if TempDimBufOut.Find('-') then begin
                            repeat
                                DimValue.Get(TempDimBufOut."Dimension Code", TempDimBufOut."Dimension Value Code");
                                TempDimSetEntry."Dimension Code" := TempDimBufOut."Dimension Code";
                                TempDimSetEntry."Dimension Value Code" := TempDimBufOut."Dimension Value Code";
                                TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                                if TempDimSetEntry.Insert() then;
                                "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID",
                                  "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                                Modify();
                            until TempDimBufOut.Next() = 0;
                            TempDimBufOut.DeleteAll();
                        end;
                    end;
                end;
            end;

    end;

    local procedure InsertQuantityOnHandBuffer(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10])
    begin
        with TempQuantityOnHandBuffer do begin
            Reset();
            SetRange("Item No.", ItemNo);
            SetRange("Location Code", LocationCode);
            SetRange("Variant Code", VariantCode);
            if not FindFirst() then begin
                Reset();
                Init();
                "Item No." := ItemNo;
                "Location Code" := LocationCode;
                "Variant Code" := VariantCode;
                "Bin Code" := '';
                "Dimension Entry No." := 0;
                Insert(true);
            end;
        end;
    end;

    local procedure ReserveWarehouse(ItemJournlLine: Record "Item Journal Line")
    var
        ReservEntry: Record "Reservation Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        OrderLineNo: Integer;
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
    begin
        with ItemJournlLine do begin
            WhseEntry.SetCurrentKey(
                "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                "Lot No.", "Serial No.", "Entry Type");
            WhseEntry.SetRange("Item No.", "Item No.");
            WhseEntry.SetRange("Bin Code", Location."Adjustment Bin Code");
            WhseEntry.SetRange("Location Code", "Location Code");
            WhseEntry.SetRange("Variant Code", "Variant Code");
            if "Entry Type" = "Entry Type"::"Positive Adjmt." then
                EntryType := EntryType::"Negative Adjmt.";
            if "Entry Type" = "Entry Type"::"Negative Adjmt." then
                EntryType := EntryType::"Positive Adjmt.";
            WhseEntry.SetRange("Entry Type", EntryType);
            if WhseEntry.Find('-') then
                repeat
                    WhseEntry.SetTrackingFilterFromWhseEntry(WhseEntry);
                    WhseEntry.CalcSums("Qty. (Base)");

                    WhseEntry2.SetCurrentKey(
                        "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                        "Lot No.", "Serial No.", "Entry Type");
                    WhseEntry2.CopyFilters(WhseEntry);
                    case EntryType of
                        EntryType::"Positive Adjmt.":
                            WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                        EntryType::"Negative Adjmt.":
                            WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Positive Adjmt.");
                    end;
                    WhseEntry2.CalcSums("Qty. (Base)");
                    if Abs(WhseEntry2."Qty. (Base)") > Abs(WhseEntry."Qty. (Base)") then
                        WhseEntry."Qty. (Base)" := 0
                    else
                        WhseEntry."Qty. (Base)" := WhseEntry."Qty. (Base)" + WhseEntry2."Qty. (Base)";

                    if WhseEntry."Qty. (Base)" <> 0 then begin
                        if "Order Type" = "Order Type"::Production then
                            OrderLineNo := "Order Line No.";
                        ReservEntry.CopyTrackingFromWhseEntry(WhseEntry);
                        CreateReservEntry.CreateReservEntryFor(
                            DATABASE::"Item Journal Line", "Entry Type".AsInteger(), "Journal Template Name", "Journal Batch Name", OrderLineNo,
                            "Line No.", "Qty. per Unit of Measure",
                            Abs(WhseEntry.Quantity), Abs(WhseEntry."Qty. (Base)"), ReservEntry);
                        if WhseEntry."Qty. (Base)" < 0 then             // only Date on positive adjustments
                            CreateReservEntry.SetDates(WhseEntry."Warranty Date", WhseEntry."Expiration Date");
                        CreateReservEntry.CreateEntry(
                            "Item No.", "Variant Code", "Location Code", Description, 0D, 0D, 0, "Reservation Status"::Prospect);
                    end;
                    WhseEntry.Find('+');
                    WhseEntry.ClearTrackingFilter();
                until WhseEntry.Next() = 0;
        end;
    end;

    procedure InitializeRequest(NewPostingDate: Date; DocNo: Code[20]; ItemsNotOnInvt: Boolean; InclItemWithNoTrans: Boolean)
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
        ZeroQty := ItemsNotOnInvt;
        IncludeItemWithNoTransaction := InclItemWithNoTrans and ZeroQty;
        if not SkipDim then
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
    end;

    local procedure TransferDim(DimSetID: Integer)
    begin
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        if DimSetEntry.Find('-') then
            repeat
                if TempSelectedDim.Get(
                     UserId, 3, REPORT::"Calculate Inventory", '', DimSetEntry."Dimension Code")
                then
                    InsertDim(DATABASE::"Item Ledger Entry", DimSetID, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            until DimSetEntry.Next() = 0;
    end;


    local procedure CalcWhseQty(AdjmtBin: Code[20]; var PosQuantity: Decimal; var NegQuantity: Decimal)
    var
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NoWhseEntry: Boolean;
        NoWhseEntry2: Boolean;
        WhseQuantity: Decimal;
    begin
        AdjustPosQty := false;
        with TempQuantityOnHandBuffer do begin
            ItemTrackingMgt.GetWhseItemTrkgSetup("Item No.", WhseItemTrackingSetup);
            ItemTrackingSplit := WhseItemTrackingSetup.TrackingRequired();
            WhseEntry.SetCurrentKey(
              "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
              "Lot No.", "Serial No.", "Entry Type");

            WhseEntry.SetRange("Item No.", "Item No.");
            WhseEntry.SetRange("Location Code", "Location Code");
            WhseEntry.SetRange("Variant Code", "Variant Code");
            WhseEntry.CalcSums("Qty. (Base)");
            WhseQuantity := WhseEntry."Qty. (Base)";
            WhseEntry.SetRange("Bin Code", AdjmtBin);

            if WhseItemTrackingSetup."Serial No. Required" then begin
                WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
                WhseEntry.CalcSums("Qty. (Base)");
                PosQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
                WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Negative Adjmt.");
                WhseEntry.CalcSums("Qty. (Base)");
                NegQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
                WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::Movement);
                WhseEntry.CalcSums("Qty. (Base)");
                if WhseEntry."Qty. (Base)" <> 0 then
                    if WhseEntry."Qty. (Base)" > 0 then
                        PosQuantity := PosQuantity + WhseQuantity - WhseEntry."Qty. (Base)"
                    else
                        NegQuantity := NegQuantity - WhseQuantity - WhseEntry."Qty. (Base)";


                WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
                if WhseEntry.Find('-') then
                    repeat
                        WhseEntry.SetRange("Serial No.", WhseEntry."Serial No.");

                        WhseEntry2.Reset();
                        WhseEntry2.SetCurrentKey(
                          "Item No.", "Bin Code", "Location Code", "Variant Code",
                          "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");

                        WhseEntry2.CopyFilters(WhseEntry);
                        WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                        WhseEntry2.SetRange("Serial No.", WhseEntry."Serial No.");
                        if WhseEntry2.Find('-') then
                            repeat
                                PosQuantity := PosQuantity + 1;
                                NegQuantity := NegQuantity - 1;
                                NoWhseEntry := WhseEntry.Next() = 0;
                                NoWhseEntry2 := WhseEntry2.Next() = 0;
                            until NoWhseEntry2 or NoWhseEntry
                        else
                            AdjustPosQty := true;

                        if not NoWhseEntry and NoWhseEntry2 then
                            AdjustPosQty := true;

                        WhseEntry.Find('+');
                        WhseEntry.SetRange("Serial No.");
                    until WhseEntry.Next() = 0;

            end else begin
                if WhseEntry.Find('-') then
                    repeat
                        WhseEntry.SetRange("Lot No.", WhseEntry."Lot No.");
                        WhseEntry.CalcSums("Qty. (Base)");
                        if WhseEntry."Qty. (Base)" <> 0 then
                            if WhseEntry."Qty. (Base)" > 0 then
                                NegQuantity := NegQuantity - WhseEntry."Qty. (Base)"
                            else
                                PosQuantity := PosQuantity + WhseEntry."Qty. (Base)";

                        WhseEntry.Find('+');
                        WhseEntry.SetRange("Lot No.");
                    until WhseEntry.Next() = 0;
                if PosQuantity <> WhseQuantity then
                    PosQuantity := WhseQuantity - PosQuantity;
                if NegQuantity <> -WhseQuantity then
                    NegQuantity := WhseQuantity + NegQuantity;
            end;
        end;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure InitializePhysInvtCount(PhysInvtCountCode2: Code[10]; CountSourceType2: Option " ",Item,SKU)
    begin
        PhysInvtCountCode := PhysInvtCountCode2;
        CycleSourceType := CountSourceType2;
    end;

    local procedure SkipCycleSKU(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]): Boolean
    var
        SKU: Record "Stockkeeping Unit";
    begin
        if CycleSourceType = CycleSourceType::Item then
            if SKU.ReadPermission then
                if SKU.Get(LocationCode, ItemNo, VariantCode) then
                    exit(true);
        exit(false);
    end;

    procedure GetLocation(LocationCode: Code[10]): Boolean
    begin
        if LocationCode = '' then begin
            Clear(Location);
            exit(true);
        end;

        if Location.Code <> LocationCode then
            if not Location.Get(LocationCode) then
                exit(false);

        exit(true);
    end;

    local procedure UpdateBuffer(BinCode: Code[20]; NewQuantity: Decimal; CalledFromItemLedgerEntry: Boolean)
    var
        DimEntryNo: Integer;
    begin
        with TempQuantityOnHandBuffer do begin
            if not HasNewQuantity(NewQuantity) then
                exit;
            if BinCode = '' then begin
                if ColumnDim <> '' then
                    TempDimBufIn.SetRange("Entry No.", "Item Ledger Entry"."Dimension Set ID");
                DimEntryNo := DimBufMgt.FindDimensions(TempDimBufIn);
                if DimEntryNo = 0 then
                    DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
            end;
            if RetrieveBuffer(BinCode, DimEntryNo) then begin
                Quantity := Quantity + NewQuantity;
                Modify();
            end else begin
                Quantity := NewQuantity;
                Insert();
            end;
        end;
    end;

    local procedure RetrieveBuffer(BinCode: Code[20]; DimEntryNo: Integer): Boolean
    begin
        with TempQuantityOnHandBuffer do begin
            Reset();
            "Item No." := "Item Ledger Entry"."Item No.";
            "Variant Code" := "Item Ledger Entry"."Variant Code";
            "Location Code" := "Item Ledger Entry"."Location Code";
            "Dimension Entry No." := DimEntryNo;
            "Bin Code" := BinCode;
            exit(Find());
        end;
    end;

    local procedure HasNewQuantity(NewQuantity: Decimal): Boolean
    begin
        exit((NewQuantity <> 0) or ZeroQty);
    end;

    local procedure ItemBinLocationIsCalculated(BinCode: Code[20]): Boolean
    begin
        with TempQuantityOnHandBuffer do begin
            Reset();
            SetRange("Item No.", "Item Ledger Entry"."Item No.");
            SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
            SetRange("Location Code", "Item Ledger Entry"."Location Code");
            SetRange("Bin Code", BinCode);
            exit(Find('-'));
        end;
    end;

    procedure SetSkipDim(NewSkipDim: Boolean)
    begin
        SkipDim := NewSkipDim;
    end;

    local procedure UpdateQuantityOnHandBuffer(ItemNo: Code[20])
    var
        ItemVariant: Record "Item Variant";
        Location: Record Location;
    begin
        ItemVariant.SetRange("Item No.", Item."No.");
        Item.CopyFilter("Variant Filter", ItemVariant.Code);
        Item.CopyFilter("Location Filter", Location.Code);
        Location.SetRange("Use As In-Transit", false);
        if (Item.GetFilter("Location Filter") <> '') and Location.FindSet() then
            repeat
                if (Item.GetFilter("Variant Filter") <> '') and ItemVariant.FindSet() then
                    repeat
                        InsertQuantityOnHandBuffer(ItemNo, Location.Code, ItemVariant.Code);
                    until ItemVariant.Next() = 0
                else
                    InsertQuantityOnHandBuffer(ItemNo, Location.Code, '');
            until Location.Next() = 0
        else
            if (Item.GetFilter("Variant Filter") <> '') and ItemVariant.FindSet() then
                repeat
                    InsertQuantityOnHandBuffer(ItemNo, '', ItemVariant.Code);
                until ItemVariant.Next() = 0
            else
                InsertQuantityOnHandBuffer(ItemNo, '', '');
    end;

    local procedure CalcPhysInvQtyAndInsertItemJnlLine()
    begin
        with TempQuantityOnHandBuffer do begin
            Reset();
            if FindSet() then begin
                repeat
                    PosQty := 0;
                    NegQty := 0;

                    GetLocation("Location Code");
                    if Location."Directed Put-away and Pick" then
                        CalcWhseQty(Location."Adjustment Bin Code", PosQty, NegQty);

                    if (NegQty - Quantity <> Quantity - PosQty) or ItemTrackingSplit then begin
                        if PosQty = Quantity then
                            PosQty := 0;
                        if (PosQty <> 0) or AdjustPosQty then
                            InsertItemJnlLine(
                              "Item No.", "Variant Code", "Dimension Entry No.",
                              "Bin Code", Quantity, PosQty);

                        if NegQty = Quantity then
                            NegQty := 0;
                        if NegQty <> 0 then begin
                            if ((PosQty <> 0) or AdjustPosQty) and not ItemTrackingSplit then begin
                                NegQty := NegQty - Quantity;
                                Quantity := 0;
                                ZeroQty := true;
                            end;
                            if NegQty = -Quantity then begin
                                NegQty := 0;
                                AdjustPosQty := true;
                            end;
                            InsertItemJnlLine(
                              "Item No.", "Variant Code", "Dimension Entry No.",
                              "Bin Code", Quantity, NegQty);

                            ZeroQty := ZeroQtySave;
                        end;
                    end else begin
                        PosQty := 0;
                        NegQty := 0;
                    end;

                    if (PosQty = 0) and (NegQty = 0) and not AdjustPosQty then
                        InsertItemJnlLine(
                          "Item No.", "Variant Code", "Dimension Entry No.",
                          "Bin Code", Quantity, Quantity);
                until Next() = 0;
                DeleteAll();
            end;
        end;
    end;

    local procedure CreateDimFromItemDefault() DimEntryNo: Integer
    var
        DefaultDimension: Record "Default Dimension";
    begin
        with DefaultDimension do begin
            SetRange("No.", TempQuantityOnHandBuffer."Item No.");
            SetRange("Table ID", DATABASE::Item);
            SetFilter("Dimension Value Code", '<>%1', '');
            if FindSet() then
                repeat
                    InsertDim(DATABASE::Item, 0, "Dimension Code", "Dimension Value Code");
                until Next() = 0;
        end;

        DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
        TempDimBufIn.SetRange("Table ID", DATABASE::Item);
        TempDimBufIn.DeleteAll();
    end;

    local procedure InsertDim(TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValueCode: Code[20])
    begin
        with TempDimBufIn do begin
            Init();
            "Table ID" := TableID;
            "Entry No." := EntryNo;
            "Dimension Code" := DimCode;
            "Dimension Value Code" := DimValueCode;
            if Insert() then;
        end;
    end;


}
