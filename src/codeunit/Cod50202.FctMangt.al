codeunit 50202 "BC6_FctMangt"
{
    trigger OnRun()
    begin

    end;

    procedure FindVeryBestCost(VAR RecLPurchaseLine: Record "Purchase Line"; RecLPurchaseHeader: Record "Purchase Header")
    var
        Item: Record Item;
        TempPurchPrice: Record "Purchase Price";
        TempPurchLineDisc: Record "Purchase Line Discount";
        PurPriCalMgt: Codeunit "Purch. Price Calc. Mgt.";
        ItemDirectUnitCost: Decimal;
        BestCost: Decimal;
        BestDiscount: Decimal;
        ItemDirectUnitCostBestDiscount: Decimal;
    begin
        WITH RecLPurchaseLine DO
            IF RecLPurchaseLine.Type = Type::Item THEN BEGIN

                //Prix unitaire
                Item.RESET();
                Item.GET(RecLPurchaseLine."No.");
                ItemDirectUnitCost := Item."Unit Price";

                //Meilleur prix
                IF PurPriCalMgt.PurchLinePriceExists(RecLPurchaseHeader, RecLPurchaseLine, FALSE) THEN BEGIN
                    PurPriCalMgt.CalcBestDirectUnitCost(TempPurchPrice);
                    BestCost := TempPurchPrice."Direct Unit Cost";
                END ELSE
                    BestCost := 0;

                //Meilleur remise
                IF PurPriCalMgt.PurchLineLineDiscExists(RecLPurchaseHeader, RecLPurchaseLine, FALSE) THEN BEGIN
                    PurPriCalMgt.CalcBestLineDisc(TempPurchLineDisc);
                    BestDiscount := TempPurchLineDisc."Line Discount %";
                END ELSE
                    BestDiscount := 0;

                ItemDirectUnitCostBestDiscount := (ItemDirectUnitCost * (1 - BestDiscount / 100));

                IF (BestCost <> 0) THEN BEGIN
                    IF (ItemDirectUnitCostBestDiscount < BestCost) THEN BEGIN
                        RecLPurchaseLine."Direct Unit Cost" := ItemDirectUnitCost;
                        RecLPurchaseLine."Line Discount %" := BestDiscount;
                        RecLPurchaseLine."Allow Invoice Disc." := TRUE;
                    END ELSE BEGIN
                        RecLPurchaseLine."Direct Unit Cost" := BestCost;
                        RecLPurchaseLine."Line Discount %" := 0;
                        RecLPurchaseLine."Allow Invoice Disc." := TRUE;
                    END;
                END ELSE BEGIN
                    RecLPurchaseLine."Direct Unit Cost" := ItemDirectUnitCost;
                    RecLPurchaseLine."Line Discount %" := BestDiscount;
                    RecLPurchaseLine."Allow Invoice Disc." := TRUE;
                END;
            END;
    end;
    //COD419
    PROCEDURE CopyAndRenameClientFile(OldFilePath: Text; DirectoryPath: Text; NewSubDirectoryName: Text) NewFilePath: Text;
    VAR
        directory: Text;
        NewFileName: Text;
        fileMgt: Codeunit "File Management";
        Text003: Label 'You must enter a file name.';
        Text1100267000: Label 'You must enter a file name.';
        Text1100267001: Label 'The directory %1 does not exist.';


    BEGIN
        IF OldFilePath = '' THEN
            EXIT('');
        //TODO: dotnet
        // IF NOT ClientFileHelper.Exists(OldFilePath) THEN
        //     EXIT('');

        NewFileName := fileMgt.GetFileName(OldFilePath);
        IF NewFileName = '' THEN
            ERROR(Text003);

        IF DirectoryPath = '' THEN
            ERROR(Text1100267000);

        IF NOT fileMgt.ServerDirectoryExists(DirectoryPath) THEN
            ERROR(Text1100267001, DirectoryPath);

        directory := DirectoryPath;

        //TODO: dotnet
        // IF NewSubDirectoryName <> '' THEN BEGIN
        //     directory := PathHelper.Combine(directory, NewSubDirectoryName);
        //     DirectoryHelper.CreateDirectory(directory);
        // END;

        //TODO: dotnet
        // NewFilePath := PathHelper.Combine(directory, NewFileName);
        // IF ClientFileHelper.Exists(NewFilePath) THEN BEGIN
        //     NewFilePath := '';
        //     EXIT('');
        // END;

        fileMgt.DeleteServerFile(NewFilePath);
        //TODO: dotnet
        // ClientFileHelper.Copy(OldFilePath, NewFilePath);

        EXIT(NewFilePath);
    END;

    procedure UpdateRec(var RecRef: RecordRef; ConvertVATProdPostingGroup: Boolean; ConvertGenProdPostingGroup: Boolean)
    var
        "Field": Record "Field";
        VATRateChangeLogEntry: Record "VAT Rate Change Log Entry";
        FieldRef: FieldRef;
        GenProdPostingGroupConverted: Boolean;
        VATProdPostingGroupConverted: Boolean;
        IsHandled: Boolean;
        VATRateChangeConversion: Record "VAT Rate Change Conversion";
        VATRateChangeSetup: record "VAT Rate Change Setup";

    begin
        VATRateChangeLogEntry.Init();
        VATRateChangeLogEntry."Record ID" := RecRef.RecordId;
        VATRateChangeLogEntry."Table ID" := RecRef.Number;
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
        Field.SetRange(RelationTableNo, DATABASE::"Gen. Product Posting Group");
        Field.SetRange(Type, Field.Type::Code);
        if Field.Find('+') then
            repeat
                FieldRef := RecRef.Field(Field."No.");
                GenProdPostingGroupConverted := false;
                if ConvertGenProdPostingGroup then
                    if VATRateChangeConversion.Get(VATRateChangeConversion.Type::"Gen. Prod. Posting Group", FieldRef.Value) then begin
                        VATRateChangeLogEntry."Old Gen. Prod. Posting Group" := FieldRef.Value;
                        FieldRef.Validate(VATRateChangeConversion."To Code");
                        VATRateChangeLogEntry."New Gen. Prod. Posting Group" := FieldRef.Value;
                        GenProdPostingGroupConverted := true;
                    end;
                if not GenProdPostingGroupConverted then begin
                    VATRateChangeLogEntry."Old Gen. Prod. Posting Group" := FieldRef.Value;
                    VATRateChangeLogEntry."New Gen. Prod. Posting Group" := FieldRef.Value;
                end;
            until Field.Next(-1) = 0;

        Field.SetRange(RelationTableNo, DATABASE::"VAT Product Posting Group");
        if Field.Find('+') then
            repeat
                FieldRef := RecRef.Field(Field."No.");
                VATProdPostingGroupConverted := false;
                if ConvertVATProdPostingGroup then
                    if VATRateChangeConversion.Get(VATRateChangeConversion.Type::"VAT Prod. Posting Group", FieldRef.Value) then begin
                        VATRateChangeLogEntry."Old VAT Prod. Posting Group" := FieldRef.Value;
                        FieldRef.Validate(VATRateChangeConversion."To Code");
                        VATRateChangeLogEntry."New VAT Prod. Posting Group" := FieldRef.Value;
                        VATProdPostingGroupConverted := true;
                    end;
                if not VATProdPostingGroupConverted then begin
                    VATRateChangeLogEntry."Old VAT Prod. Posting Group" := FieldRef.Value;
                    VATRateChangeLogEntry."New VAT Prod. Posting Group" := FieldRef.Value;
                end;
            until Field.Next(-1) = 0;
        VATRateChangeSetup.get();
        if VATRateChangeSetup."Perform Conversion" then begin
            RecRef.Modify();
            VATRateChangeLogEntry.Converted := true;
        end;
        if (VATRateChangeLogEntry."New Gen. Prod. Posting Group" <> VATRateChangeLogEntry."Old Gen. Prod. Posting Group") or
           (VATRateChangeLogEntry."New VAT Prod. Posting Group" <> VATRateChangeLogEntry."Old VAT Prod. Posting Group")
        then
            WriteLogEntry(VATRateChangeLogEntry);
    end;

    procedure WriteLogEntry(VATRateChangeLogEntry: Record "VAT Rate Change Log Entry")
    var
        VATRateChangeSetup: Record "VAT Rate Change Setup";
        Text0009: Label 'Conversion cannot be performed before %1 is set to true.';
    begin
        with VATRateChangeLogEntry do begin
            if Converted then
                "Converted Date" := WorkDate()
            else
                if Description = '' then
                    Description := StrSubstNo(Text0009, VATRateChangeSetup.FieldCaption("Perform Conversion"));
            Insert();
        end;
    end;
    //TODO: Tocheck 
    procedure SumSalesLinesTemp(var SalesHeader: Record "Sales Header"; var OldSalesLine: Record "Sales Line"; QtyType: enum BC6_QtyType; var NewTotalSalesLine: Record "Sales Line"; var NewTotalSalesLineLCY: Record "Sales Line"; var VATAmount: Decimal; var VATAmountText: Text[30]; var ProfitLCY: Decimal; var ProfitPct: Decimal; var TotalAdjCostLCY: Decimal; var DEEEHTAmount: Decimal; var DEEEVATAmount: Decimal; var DEEETTCAmount: Decimal; var DEEEHTAmountLCY: Decimal)
    begin
        //    TODO // SumSalesLinesTemp(SalesHeader, OldSalesLine, QtyType, NewTotalSalesLine, NewTotalSalesLineLCY, VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY, true);
    end;

    procedure SumSalesLines(var NewSalesHeader: Record "Sales Header"; QtyType: enum BC6_QtyType; var NewTotalSalesLine: Record "Sales Line"; var NewTotalSalesLineLCY: Record "Sales Line"; var VATAmount: Decimal; var VATAmountText: Text[30]; var ProfitLCY: Decimal; var ProfitPct: Decimal; var TotalAdjCostLCY: Decimal; var DEEEHTAmount: Decimal; var DEEEVATAmount: Decimal; var DEEETTCAmount: Decimal; var DEEEHTAmountLCY: Decimal)
    var
        OldSalesLine: Record "Sales Line";
    begin
        SumSalesLinesTemp(
          NewSalesHeader, OldSalesLine, QtyType, NewTotalSalesLine, NewTotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY, DEEEHTAmount, DEEEVATAmount, DEEETTCAmount, DEEEHTAmountLCY);
    end;

    PROCEDURE GetTaxAmountFromSalesOrder_CNE(SalesHeader: Record "Sales Header"): Decimal;
    VAR
        NewSalesLine: Record "Sales Line";
        NewSalesLineLCY: Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
        QtyType: enum BC6_QtyType;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TotalAdjCostLCY: Decimal;
    begin
        SumSalesLines(SalesHeader, QtyType::Invoicing, NewSalesLine, NewSalesLineLCY, VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY, NewSalesLine."BC6_DEEE HT Amount", NewSalesLine."BC6_DEEE VAT Amount", NewSalesLine."BC6_DEEE TTC Amount", NewSalesLine."BC6_DEEE HT Amount (LCY)");
        EXIT(-1 * VATAmount);
    end;

    //event OnBeforeGetTaxAmountFromPurchaseOrder
    //  procedure SumPurchLines(var NewPurchHeader: Record "Purchase Header"; QtyType: enum BC6_QtyType; var NewTotalPurchLine: Record "Purchase Line"; var NewTotalPurchLineLCY: Record "Purchase Line"; var VATAmount: Decimal; var VATAmountText: Text[30])
    //     var
    //         OldPurchLine: Record "Purchase Line";
    //     begin
    //         SumPurchLinesTemp(
    //           NewPurchHeader, OldPurchLine, QtyType, NewTotalPurchLine, NewTotalPurchLineLCY,
    //           VATAmount, VATAmountText);
    //     end;

    //     procedure SumPurchLinesTemp(var PurchHeader: Record "Purchase Header"; var OldPurchLine: Record "Purchase Line"; QtyType: enum BC6_QtyType; var NewTotalPurchLine: Record "Purchase Line"; var NewTotalPurchLineLCY: Record "Purchase Line"; var VATAmount: Decimal; var VATAmountText: Text[30])
    //     var
    //         PurchLine: Record "Purchase Line";
    //            TotalPurchLine: Record "Purchase Line";
    //     begin
    //         TotalPurchLine.get;
    //         with PurchHeader do begin
    //             SumPurchLines2(PurchHeader, PurchLine, OldPurchLine, QtyType, false);
    //             VATAmount := TotalPurchLine."Amount Including VAT" - TotalPurchLine.Amount;
    //             if TotalPurchLine."VAT %" = 0 then
    //                 VATAmountText := VATAmountTxt
    //             else
    //                 VATAmountText := StrSubstNo(VATRateTxt, TotalPurchLine."VAT %");
    //             NewTotalPurchLine := TotalPurchLine;
    //             NewTotalPurchLineLCY := TotalPurchLineLCY;
    //         end;
    //     end;

    //     PROCEDURE GetTaxAmountFromPurchaseOrder(PurchaseHeader: Record 38): Decimal;
    //     VAR
    //         NewPurchLine: Record 39;
    //         NewPurchLineLCY: Record 39;
    //         PurchPost: Codeunit 90;
    //         QtyType: Enum BC6_QtyType;
    //         VATAmount: Decimal;
    //         VATAmountText: Text[30];
    //     BEGIN
    //         PurchPost.SumPurchLines(PurchaseHeader, QtyType::Invoicing, NewPurchLine, NewPurchLineLCY,
    //           VATAmount, VATAmountText,
    //           NewPurchLine."BC6_DEEE HT Amount", NewPurchLine."BC6_DEEE VAT Amount",
    //           NewPurchLine."BC6_DEEE TTC Amount", NewPurchLine."BC6_DEEE HT Amount (LCY)");
    //         EXIT(VATAmount);
    //     END;


    PROCEDURE ShowPostedConfirmationMessageCode(): Code[50];
    BEGIN
        EXIT(UPPERCASE('ShowPostedConfirmationMessage'));
    END;

    //COD 5063////////////////////////////

    PROCEDURE "***CNE-ARCHIVAGE"();
    BEGIN
    END;

    PROCEDURE ArchiveSalesDocumentWithoutMessage(VAR SalesHeader: Record 36);
    var
        archMgt: Codeunit ArchiveManagement;
    BEGIN
        archMgt.StoreSalesDocument(SalesHeader, FALSE);
    END;

    PROCEDURE PrintInvtPickHeaderCheck(WhseActivHeader: Record 5766; HideDialog: Boolean);
    VAR
        //TODO:report
        // WhsePick: Report 50047;
        WhsePick2: Report 5752;
    BEGIN
        WhseActivHeader.SETRANGE("No.", WhseActivHeader."No.");
        //TODO:report
        // WhsePick.SETTABLEVIEW(WhseActivHeader);
        // WhsePick.InitRequest(0, FALSE, TRUE);
        // WhsePick.USEREQUESTPAGE(NOT HideDialog);
        // WhsePick.RUNMODAL;
    END;



    procedure "--"(); // TODO: related to codeunit 7302
    begin

    end;

    procedure GetShipmentBin(LocationCode: Code[10]; VAR BinCode: Code[20]); // TODO: related to codeunit 7302
    var
        Bin: Record Bin;
        Location: Record Location;
        WMSMgt: codeunit "WMS Management";
    begin
        GetLocation(LocationCode);

        IF NOT Location."Bin Mandatory" THEN
            EXIT;

        IF Location."Directed Put-away and Pick" THEN
            EXIT;

        Bin.RESET();
        Bin.SETRANGE("Location Code", Location.Code);
        Bin.SETRANGE(Empty, TRUE);
        Bin.SETRANGE("BC6_Sales Order Not Shipped", FALSE);
        Bin.SETRANGE("BC6_To Make Available", TRUE);
        IF Bin.FINDFIRST() THEN
            BinCode := Bin.Code;
    end;

    procedure BinLookUp2(LocationCode: Code[10]; BinCode: Code[10]): Code[20]; // TODO: related to codeunit 7302
    var
        Bin: Record Bin;
    begin
        Bin.SETRANGE("Location Code", LocationCode);
        IF BinCode <> '' THEN
            IF Bin.GET(LocationCode, BinCode) THEN;

        IF PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK THEN
            EXIT(Bin.Code);
    end;

    PROCEDURE "--- MIGNAV2013 ---"();
    BEGIN
    END;

    PROCEDURE InsertTempWhseJnlLine2(ItemJnlLine: Record "Item Journal Line"; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDoc: Integer; SourceType2: Integer; SourceSubType2: Integer; SourceNo2: Code[20]; SourceLineNo2: Integer; VAR TempWhseJnlLine: Record "Warehouse Journal Line" temporary; VAR NextLineNo: Integer);
    VAR
        WhseEntry: Record "Warehouse Entry";
        WhseMgt: Codeunit "Whse. Management";
    BEGIN
        WITH ItemJnlLine DO BEGIN
            WhseEntry.RESET;
            WhseEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
            WhseEntry.SETRANGE("BC6_Source Type 2", SourceType);
            WhseEntry.SETRANGE("Source Subtype", SourceSubType);
            WhseEntry.SETRANGE("Source No.", SourceNo);
            WhseEntry.SETRANGE("Source Line No.", SourceLineNo);
            WhseEntry.SETRANGE("Reference No.", "Document No.");
            WhseEntry.SETRANGE("Item No.", "Item No.");
            WhseEntry.SETRANGE("BC6_Source Type 2", SourceType2);
            WhseEntry.SETRANGE("BC6_Source Subtype 2", SourceSubType2);
            WhseEntry.SETRANGE("BC6_Source No. 2", SourceNo2);
            WhseEntry.SETRANGE("BC6_Source Line No. 2", SourceLineNo2);
            IF WhseEntry.FIND('-') THEN
                REPEAT
                    TempWhseJnlLine.INIT;
                    IF WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Positive Adjmt." THEN
                        "Entry Type" := "Entry Type"::"Negative Adjmt."
                    ELSE
                        "Entry Type" := "Entry Type"::"Positive Adjmt.";
                    Quantity := ABS(WhseEntry.Quantity);
                    "Quantity (Base)" := ABS(WhseEntry."Qty. (Base)");
                    // WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 0, TempWhseJnlLine, FALSE); //TODO: mising function in Codeunit "Whse. Management";
                    TempWhseJnlLine."Source Type" := SourceType;
                    TempWhseJnlLine."Source Subtype" := SourceSubType;
                    TempWhseJnlLine."Source No." := SourceNo;
                    TempWhseJnlLine."Source Line No." := SourceLineNo;
                    TempWhseJnlLine."BC6_Source Type 2" := SourceType2;
                    TempWhseJnlLine."BC6_Source Subtype 2" := SourceSubType2;
                    TempWhseJnlLine."BC6_Source No. 2" := SourceNo2;
                    TempWhseJnlLine."BC6_Source Line No. 2" := SourceLineNo2;
                    TempWhseJnlLine."Reference Document" := RefDoc;
                    TempWhseJnlLine."Reference No." := "Document No.";
                    TempWhseJnlLine."Location Code" := "Location Code";
                    TempWhseJnlLine."Zone Code" := WhseEntry."Zone Code";
                    TempWhseJnlLine."Bin Code" := WhseEntry."Bin Code";
                    TempWhseJnlLine."Whse. Document Type" := WhseEntry."Whse. Document Type";
                    TempWhseJnlLine."Whse. Document No." := WhseEntry."Whse. Document No.";
                    TempWhseJnlLine."Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                    TempWhseJnlLine."Line No." := NextLineNo;
                    TempWhseJnlLine."Serial No." := WhseEntry."Serial No.";
                    TempWhseJnlLine."Lot No." := WhseEntry."Lot No.";
                    IF "Entry Type" = "Entry Type"::"Negative Adjmt." THEN BEGIN
                        TempWhseJnlLine."From Zone Code" := TempWhseJnlLine."Zone Code";
                        TempWhseJnlLine."From Bin Code" := TempWhseJnlLine."Bin Code";
                    END ELSE BEGIN
                        TempWhseJnlLine."To Zone Code" := TempWhseJnlLine."Zone Code";
                        TempWhseJnlLine."To Bin Code" := TempWhseJnlLine."Bin Code";
                    END;
                    TempWhseJnlLine.INSERT;
                    NextLineNo := TempWhseJnlLine."Line No." + 10000;
                UNTIL WhseEntry.NEXT = 0;
        END;
    END;





    procedure GetLocation(LocationCode: Code[10])// TODO: fonction dupliquée
    var
        Location: Record Location;
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;



    procedure SetBinCode(_BinCode: Code[20]) // TODO: setter for variable BinCode in function CreatePutAwayLinesFromPurchase
    begin
        BinCode := _BinCode;
    end;

    var
        BinCode: Code[20];
}