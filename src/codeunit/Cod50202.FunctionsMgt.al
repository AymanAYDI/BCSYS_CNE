codeunit 50202 "BC6_Functions Mgt"
{
    trigger OnRun()
    begin
    end;

    procedure FindVeryBestCost(VAR RecLPurchaseLine: Record "Purchase Line"; RecLPurchaseHeader: Record "Purchase Header")
    var
        Item: Record Item;
        PurchLineDisc: Record "Purchase Line Discount";
        PurchPrice: Record "Purchase Price";
        PurPriCalMgt: Codeunit "Purch. Price Calc. Mgt.";
        BestCost: Decimal;
        BestDiscount: Decimal;
        ItemDirectUnitCost: Decimal;
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
                    PurPriCalMgt.CalcBestDirectUnitCost(PurchPrice);
                    BestCost := PurchPrice."Direct Unit Cost";
                END ELSE
                    BestCost := 0;

                //Meilleur remise
                IF PurPriCalMgt.PurchLineLineDiscExists(RecLPurchaseHeader, RecLPurchaseLine, FALSE) THEN BEGIN
                    PurPriCalMgt.CalcBestLineDisc(PurchLineDisc);
                    BestDiscount := PurchLineDisc."Line Discount %";
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
    // PROCEDURE CopyAndRenameClientFile(OldFilePath: Text; DirectoryPath: Text; NewSubDirectoryName: Text) NewFilePath: Text;
    // VAR
    //     directory: Text;
    //     NewFileName: Text;
    //     fileMgt: Codeunit "File Management";
    //     Text003: Label 'You must enter a file name.';
    //     Text1100267000: Label 'You must enter a file name.';
    //     Text1100267001: Label 'The directory %1 does not exist.';
    PROCEDURE CopyAndRenameClientFile(OldFilePath: Text; DirectoryPath: Text; NewSubDirectoryName: Text) NewFilePath: Text;
    VAR
        fileMgt: Codeunit "File Management";
        Text003: Label 'You must enter a file name.';
        Text1100267000: Label 'You must enter a file name.';
        Text1100267001: Label 'The directory %1 does not exist.';
        directory: Text;
        NewFileName: Text;
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
        VATRateChangeConversion: Record "VAT Rate Change Conversion";
        VATRateChangeLogEntry: Record "VAT Rate Change Log Entry";
        VATRateChangeSetup: record "VAT Rate Change Setup";
        FieldRef: FieldRef;
        GenProdPostingGroupConverted: Boolean;
        IsHandled: Boolean;
        VATProdPostingGroupConverted: Boolean;

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
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TotalAdjCostLCY: Decimal;
        VATAmount: Decimal;
        QtyType: enum BC6_QtyType;
        VATAmountText: Text[30];
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

    PROCEDURE ArchiveSalesDocumentWithoutMessage(VAR SalesHeader: Record "Sales Header");
    var
        archMgt: Codeunit ArchiveManagement;
    BEGIN
        archMgt.StoreSalesDocument(SalesHeader, FALSE);
    END;

    PROCEDURE PrintInvtPickHeaderCheck(WhseActivHeader: Record "Warehouse Activity Header"; HideDialog: Boolean);
    VAR
        //TODO:report
        // WhsePick: Report 50047;
        WhsePick2: Report "Picking List";
    BEGIN
        WhseActivHeader.SETRANGE("No.", WhseActivHeader."No.");
        //TODO:report
        // WhsePick.SETTABLEVIEW(WhseActivHeader);
        // WhsePick.InitRequest(0, FALSE, TRUE);
        // WhsePick.USEREQUESTPAGE(NOT HideDialog);
        // WhsePick.RUNMODAL;
    END;

    procedure GetShipmentBin(LocationCode: Code[10]; VAR BinCod: Code[20]); // TODO: related to codeunit 7302
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
            BinCod := Bin.Code;
    end;

    procedure BinLookUp2(LocationCode: Code[10]; BinCod: Code[10]): Code[20]; // related to codeunit 7302
    var
        Bin: Record Bin;
    begin
        Bin.SETRANGE("Location Code", LocationCode);
        IF BinCod <> '' THEN
            IF Bin.GET(LocationCode, BinCod) THEN;

        IF PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK THEN
            EXIT(Bin.Code);
    end;

    PROCEDURE "--- MIGNAV2013 ---"();
    BEGIN
    END;

    // related to codeunit 73020
    PROCEDURE InsertTempWhseJnlLine2(ItemJnlLine: Record "Item Journal Line"; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDoc: Integer; SourceType2: Integer; SourceSubType2: Integer; SourceNo2: Code[20]; SourceLineNo2: Integer; VAR TempWhseJnlLine: Record "Warehouse Journal Line" temporary; VAR NextLineNo: Integer);
    VAR
        WhseEntry: Record "Warehouse Entry";
        WhseMgt: Codeunit "Whse. Management";
        WMSMgmt: Codeunit "WMS Management";
    BEGIN
        WITH ItemJnlLine DO BEGIN
            WhseEntry.RESET();
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
                    TempWhseJnlLine.INIT();
                    IF WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Positive Adjmt." THEN
                        "Entry Type" := "Entry Type"::"Negative Adjmt."
                    ELSE
                        "Entry Type" := "Entry Type"::"Positive Adjmt.";
                    Quantity := ABS(WhseEntry.Quantity);
                    "Quantity (Base)" := ABS(WhseEntry."Qty. (Base)");
                    WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 0, TempWhseJnlLine, FALSE);
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
                    TempWhseJnlLine.INSERT();
                    NextLineNo := TempWhseJnlLine."Line No." + 10000;
                UNTIL WhseEntry.NEXT() = 0;
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

    // TODO: function specific related to codeunit 7324 "Whse.-Activity-Post"
    PROCEDURE SetPostingDate(NewPostingDate: Date);
    BEGIN
        PostingDate := NewPostingDate;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE VerifTierPayeur(OptLAccountType: Enum "Gen. Journal Account Type"; CodLNoTiers: Code[20]; CodLAppliesID: Code[20]): Boolean;
    VAR
        RecLCustLedEntry: Record "Cust. Ledger Entry";
        RecLVendLedEntry: Record "Vendor Ledger Entry";
    BEGIN
        CASE OptLAccountType OF
            OptLAccountType::Customer:
                BEGIN
                    RecLCustLedEntry.RESET();
                    RecLCustLedEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive, "Due Date");
                    RecLCustLedEntry.SETRANGE("BC6_Pay-to Customer No.", CodLNoTiers);
                    RecLCustLedEntry.SETRANGE(Open, TRUE);
                    RecLCustLedEntry.SETFILTER("Customer No.", '<>%1', CodLNoTiers);
                    RecLCustLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    IF RecLCustLedEntry.FINDFIRST() THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
            OptLAccountType::Vendor:
                BEGIN
                    RecLVendLedEntry.RESET();
                    RecLVendLedEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive, "Due Date");
                    RecLVendLedEntry.SETRANGE("BC6_Pay-to Vend. No.", CodLNoTiers);
                    RecLVendLedEntry.SETRANGE(Open, TRUE);
                    RecLVendLedEntry.SETFILTER("Vendor No.", '<>%1', CodLNoTiers);
                    RecLVendLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    IF RecLVendLedEntry.FINDFIRST() THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
        END;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE CreateEntryTierPayeurCustomer(RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]);
    VAR
        RecLCustLedEntry: Record "Cust. Ledger Entry";
        RecLInvPostingBufferCopy: ARRAY[2] OF Record "Payment Post. Buffer";
        TierPayeurCree: Code[20];
        i: Integer;
    BEGIN
        //Creation des ecritures pour la partie CLIENT

        TierPayeurCree := '';
        i := 0;
        RecLCustLedEntry.RESET();
        RecLCustLedEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", "Applies-to ID", "Customer No.");
        RecLCustLedEntry.SETRANGE("BC6_Pay-to Customer No.", RecLInvPostingBuffer."Account No.");
        RecLCustLedEntry.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLCustLedEntry.SETFILTER("Customer No.", '<>%1', RecLInvPostingBuffer."Account No.");
        IF RecLCustLedEntry.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF TierPayeurCree <> RecLCustLedEntry."Customer No." THEN
                    GenereEntryTierPayeurCustomer(RecLCustLedEntry, RecLInvPostingBuffer, StepLedgerDescription, i);
                i += 1;
                TierPayeurCree := RecLCustLedEntry."Customer No.";
            UNTIL RecLCustLedEntry.NEXT() = 0;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE GenereEntryTierPayeurCustomer(RecLCustLedEntry: Record "Cust. Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    VAR
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        RecLCustLedEntry2: Record "Cust. Ledger Entry";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
    BEGIN
        RecLCustLedEntry2.RESET();
        RecLCustLedEntry2.SETCURRENTKEY("BC6_Pay-to Customer No.", "Applies-to ID", "Customer No.");
        RecLCustLedEntry2.SETRANGE("BC6_Pay-to Customer No.", RecLInvPostingBuffer."Account No.");
        RecLCustLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLCustLedEntry2.SETFILTER("Customer No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLCustLedEntry2.SETRANGE("Customer No.", RecLCustLedEntry."Customer No.");
        IF RecLCustLedEntry2.FINDSET(FALSE, FALSE) THEN
            REPEAT
                AmountTot += RecLCustLedEntry2."Amount to Apply";
            UNTIL RecLCustLedEntry2.NEXT() = 0;

        IF RecLInvPostingBuffer."Currency Code" = '' THEN
            Currency.InitRoundingPrecision()
        ELSE BEGIN
            Currency.GET(RecLInvPostingBuffer."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;

        AmountTotDS :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                RecLInvPostingBuffer."Due Date", RecLInvPostingBuffer."Currency Code",
                AmountTot, CurrExchRate.ExchangeRate(RecLInvPostingBuffer."Due Date", RecLInvPostingBuffer."Currency Code")),
                Currency."Amount Rounding Precision");

        RecLInvPostingBufferCopy.INIT();
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE("Account No.", RecLCustLedEntry."Customer No.");
        RecLInvPostingBufferCopy.VALIDATE(Amount, -AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", -AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLCustLedEntry."BC6_Pay-to Customer No.";
        RecLInvPostingBufferCopy.INSERT();

        RecLInvPostingBufferCopy.INIT();
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE(Amount, AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        Description2 :=
          STRSUBSTNO(StepLedgerDescription, RecLInvPostingBufferCopy."Due Date", RecLCustLedEntry."Customer No.", '');
        RecLInvPostingBufferCopy.Description := COPYSTR(Description2, 1, 50);
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLCustLedEntry."BC6_Pay-to Customer No.";
        RecLInvPostingBufferCopy.INSERT();
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE CreateEntryTierPayeurVendor(RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]);
    VAR
        RecLInvPostingBufferCopy: ARRAY[2] OF Record "Payment Post. Buffer";
        RecLVendLedEntry: Record "Vendor Ledger Entry";
        TierPayeurCree: Code[20];
        i: Integer;
    BEGIN
        //Creation des ecritures pour la partie FOURNISSEUR

        TierPayeurCree := '';
        i := 0;
        RecLVendLedEntry.RESET();
        RecLVendLedEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.");
        RecLVendLedEntry.SETRANGE("BC6_Pay-to Vend. No.", RecLInvPostingBuffer."Account No.");
        RecLVendLedEntry.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLVendLedEntry.SETFILTER("Vendor No.", '<>%1', RecLInvPostingBuffer."Account No.");
        IF RecLVendLedEntry.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF TierPayeurCree <> RecLVendLedEntry."Vendor No." THEN
                    GenereEntryTierPayeurVendor(RecLVendLedEntry, RecLInvPostingBuffer, StepLedgerDescription, i);
                i += 1;
                TierPayeurCree := RecLVendLedEntry."Vendor No.";
            UNTIL RecLVendLedEntry.NEXT() = 0;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE GenereEntryTierPayeurVendor(RecLVendLedEntry: Record "Vendor Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    VAR
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        RecLVendLedEntry2: Record "Vendor Ledger Entry";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
    BEGIN
        RecLVendLedEntry2.RESET();
        RecLVendLedEntry2.SETCURRENTKEY("BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.");
        RecLVendLedEntry2.SETRANGE("BC6_Pay-to Vend. No.", RecLInvPostingBuffer."Account No.");
        RecLVendLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLVendLedEntry2.SETFILTER("Vendor No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLVendLedEntry2.SETRANGE("Vendor No.", RecLVendLedEntry."Vendor No.");
        IF RecLVendLedEntry2.FINDSET(FALSE, FALSE) THEN
            REPEAT
                AmountTot += RecLVendLedEntry2."Amount to Apply";
            UNTIL RecLVendLedEntry2.NEXT() = 0;

        IF RecLInvPostingBuffer."Currency Code" = '' THEN
            Currency.InitRoundingPrecision()
        ELSE BEGIN
            Currency.GET(RecLInvPostingBuffer."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;

        AmountTotDS :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                RecLInvPostingBuffer."Due Date", RecLInvPostingBuffer."Currency Code",
                AmountTot, CurrExchRate.ExchangeRate(RecLInvPostingBuffer."Due Date", RecLInvPostingBuffer."Currency Code")),
                Currency."Amount Rounding Precision");

        RecLInvPostingBufferCopy.INIT();
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE("Account No.", RecLVendLedEntry."Vendor No.");
        RecLInvPostingBufferCopy.VALIDATE(Amount, -AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", -AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLVendLedEntry."BC6_Pay-to Vend. No.";
        RecLInvPostingBufferCopy.INSERT();

        RecLInvPostingBufferCopy.INIT();
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE(Amount, AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        Description2 :=
          STRSUBSTNO(StepLedgerDescription, RecLInvPostingBufferCopy."Due Date", RecLVendLedEntry."Vendor No.", '');
        RecLInvPostingBufferCopy.Description := COPYSTR(Description2, 1, 50);
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLVendLedEntry."BC6_Pay-to Vend. No.";
        RecLInvPostingBufferCopy.INSERT();
    END;

    PROCEDURE SetHideValidationDialog(NewHideValidationDialog: Boolean);
    BEGIN
        HideValidationDialog := NewHideValidationDialog;
    END;

    PROCEDURE GetHideValidationDialog(): Boolean;
    BEGIN
        exit(HideValidationDialog);
    END;

    PROCEDURE CheckReturnOrderMandatoryFields(PurchaseHeader: Record "Purchase Header");
    VAR
        PurchaseLine: Record "Purchase Line";
    BEGIN
        WITH PurchaseHeader DO BEGIN
            IF ("Document Type" = "Document Type"::"Return Order") THEN
                IF "BC6_Return Order Type" = "BC6_Return Order Type"::SAV THEN BEGIN

                    PurchaseLine.RESET();
                    PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    PurchaseLine.SETRANGE(PurchaseLine."Document Type", "Document Type");
                    PurchaseLine.SETRANGE(PurchaseLine.Type, PurchaseLine.Type::Item);
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", "No.");
                    IF PurchaseLine.FINDFIRST() THEN
                        REPEAT
                            PurchaseLine.TESTFIELD("Return Reason Code");
                            PurchaseLine.TESTFIELD("BC6_Solution Code");
                            PurchaseLine.TESTFIELD("BC6_Return Comment");
                        UNTIL PurchaseLine.NEXT() = 0;
                END;
        END;
    END;

    PROCEDURE CheckReturnOrderMandatoryFields(P_SalesHeader: Record "Sales Header");
    VAR
        L_SalesLine: Record "Sales Line";
    BEGIN
        WITH P_SalesHeader DO BEGIN
            IF ("Document Type" = "Document Type"::"Return Order") THEN
                IF "BC6_Return Order Type" = "BC6_Return Order Type"::SAV THEN BEGIN
                    L_SalesLine.RESET();
                    L_SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    L_SalesLine.SETRANGE(L_SalesLine."Document Type", "Document Type");
                    L_SalesLine.SETRANGE(L_SalesLine.Type, L_SalesLine.Type::Item);
                    L_SalesLine.SETRANGE(L_SalesLine."Document No.", "No.");
                    IF L_SalesLine.FINDFIRST() THEN
                        REPEAT
                            L_SalesLine.TESTFIELD("Return Reason Code");
                            L_SalesLine.TESTFIELD("BC6_Solution Code");
                            L_SalesLine.TESTFIELD("BC6_Return Comment");
                        UNTIL L_SalesLine.NEXT() = 0;
                END;
        END;
    END;

    var
        HideValidationDialog: Boolean;
        BinCode: Code[20]; // TODO: related to codeunit 7302
        PostingDate: Date; // TODO: related to codeunit 7324 "Whse.-Activity-Post"
        myInt: Integer;
    //COD12
    procedure TotalVATAmountOnJnlLines(GenJnlLine: Record "Gen. Journal Line") TotalVATAmount: Decimal
    var
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        with GenJnlLine2 do begin
            SetRange("Source Code", GenJnlLine."Source Code");
            SetRange("Document No.", GenJnlLine."Document No.");
            SetRange("Posting Date", GenJnlLine."Posting Date");
            CalcSums("VAT Amount (LCY)", "Bal. VAT Amount (LCY)");
            TotalVATAmount := "VAT Amount (LCY)" - "Bal. VAT Amount (LCY)";
        end;
        exit(TotalVATAmount);
    end;
    //COD21
    procedure CheckInTransitLocation(LocationCode: Code[10])
    var
        Location: Record Location;
        UseInTransitLocationErr: Label 'You can use In-Transit location %1 for transfer orders only.';
    begin
        if Location.IsInTransit(LocationCode) then
            Error(ErrorInfo.Create(StrSubstNo(UseInTransitLocationErr, LocationCode), true));
    end;

    //COD80
    PROCEDURE IncrementDEEE(VAR Nombre: Decimal; Nombre2: Decimal);
    BEGIN
        Nombre := Nombre + Nombre2;
    END;

    PROCEDURE xUpdateShipmentInvoiced(RecPSalesInvoiceHeader: Record "Sales Invoice Header");
    VAR
        RecLShipmentInvoiced: Record "Shipment Invoiced";
        TxtLShipmentInvoiced: Text[250];
    BEGIN
        RecLShipmentInvoiced.RESET();
        RecLShipmentInvoiced.SETRANGE(RecLShipmentInvoiced."Invoice No.", RecPSalesInvoiceHeader."No.");
        IF RecLShipmentInvoiced.FIND('-') THEN BEGIN
            TxtLShipmentInvoiced := '';
            REPEAT
                IF STRLEN(TxtLShipmentInvoiced) <= 229 THEN
                    IF STRPOS(TxtLShipmentInvoiced, RecLShipmentInvoiced."Shipment No.") = 0 THEN
                        TxtLShipmentInvoiced := TxtLShipmentInvoiced + RecLShipmentInvoiced."Shipment No." + '-';
            UNTIL RecLShipmentInvoiced.NEXT() = 0;
            RecPSalesInvoiceHeader."BC6_Shipment Invoiced" := COPYSTR(TxtLShipmentInvoiced, 1, STRLEN(TxtLShipmentInvoiced) - 1);
            RecPSalesInvoiceHeader.MODIFY();
        END;
    END;

    procedure Increment(var Number: Decimal; Number2: Decimal) //PROC dupliquée de COD80
    begin
        Number := Number + Number2;
    end;

    PROCEDURE SetIncrPurchCost(Value: Boolean);
    BEGIN
        EnableIncrPurchCost := Value;
    END;

    PROCEDURE "**NSC1.01**"();
    BEGIN
    END;

    PROCEDURE CalcProfit(VAR SalesHeader: Record "Sales Header");
    VAR
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        rec_Order: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        TotalSalesLine: ARRAY[3] OF Record "Sales Line";
        TotalSalesLineLCY: ARRAY[3] OF Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine2: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine3: Record "VAT Amount Line" TEMPORARY;
        SalesPost: Codeunit "Sales-Post";
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        SubformIsEditable: Boolean;
        SubformIsReady: Boolean;
        PrevNo: Code[20];
        CreditLimitLCYExpendedPct: Decimal;
        DecLTotalAdjCostLCY: Decimal;
        ProfitLCY: ARRAY[3] OF Decimal;
        ProfitPct: ARRAY[3] OF Decimal;
        TotalAmount1: ARRAY[3] OF Decimal;
        TotalAmount2: ARRAY[3] OF Decimal;
        VATAmount: ARRAY[3] OF Decimal;
        ActiveTab: Option General,Invoicing,Shipping;
        PrevTab: Option General,Invoicing,Shipping;
        VATAmountText: ARRAY[3] OF Text[30];
    BEGIN
        //MODIF pour utilis‚ le calcul specifique
        PrevNo := SalesHeader."No.";
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        TempSalesLine.DELETEALL();
        CLEAR(TempSalesLine);
        CLEAR(SalesPost);
        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 2);
        CLEAR(SalesPost);
        SalesLine.CalcVATAmountLines(0, SalesHeader, TempSalesLine, TempVATAmountLine3);

        //TODO SalesPost.SumSalesLinesTemp(
        //   SalesHeader, TempSalesLine, 2, TotalSalesLine[3], TotalSalesLineLCY[3],
        //   VATAmount[3], VATAmountText[3], ProfitLCY[3], ProfitPct[3],
        //   DecLTotalAdjCostLCY,
        //   TotalSalesLine[3]."BC6_DEEE HT Amount", TotalSalesLine[3]."BC6_DEEE VAT Amount",
        //   TotalSalesLine[3]."BC6_DEEE TTC Amount", TotalSalesLine[3]."BC6_DEEE HT Amount (LCY)");

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2[3] := TotalSalesLine[3].Amount;
            TotalAmount1[3] := TotalAmount2[3] + VATAmount[3];
            TotalSalesLine[3]."Line Amount" := TotalAmount1[3] + TotalSalesLine[3]."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1[3] := TotalSalesLine[3].Amount;
            TotalAmount2[3] := TotalSalesLine[3]."Amount Including VAT";
        END;

        TempVATAmountLine3.MODIFYALL(Modified, FALSE);
        SalesHeader."BC6_Sales LCY" := TotalSalesLineLCY[3].Amount;
        SalesHeader."BC6_Profit LCY" := ProfitLCY[3];
        SalesHeader."BC6_% Profit" := ProfitPct[3];
        SalesHeader.MODIFY()
    END;

    //COD82
    PROCEDURE CalcProfit2(var SalesHeader: Record "Sales Header");
    VAR
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        rec_Order: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        TotalSalesLine: ARRAY[3] OF Record "Sales Line";
        TotalSalesLineLCY: ARRAY[3] OF Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine2: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine3: Record "VAT Amount Line" TEMPORARY;
        SalesPost: Codeunit "Sales-Post";
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        SubformIsEditable: Boolean;
        SubformIsReady: Boolean;
        PrevNo: Code[20];
        CreditLimitLCYExpendedPct: Decimal;
        DecLTotalAdjCostLCY: Decimal;
        ProfitLCY: ARRAY[3] OF Decimal;
        ProfitPct: ARRAY[3] OF Decimal;
        TotalAmount1: ARRAY[3] OF Decimal;
        TotalAmount2: ARRAY[3] OF Decimal;
        VATAmount: ARRAY[3] OF Decimal;
        ActiveTab: OPTION General,Invoicing,Shipping;
        PrevTab: OPTION General,Invoicing,Shipping;
        VATAmountText: ARRAY[3] OF Text[30];
    BEGIN

        PrevNo := SalesHeader."No.";
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        TempSalesLine.DELETEALL();
        CLEAR(TempSalesLine);
        CLEAR(SalesPost);
        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 2);
        CLEAR(SalesPost);

        SalesLine.CalcVATAmountLines(0, SalesHeader, TempSalesLine, TempVATAmountLine3);
        //TODO SalesPost.SumSalesLinesTemp(
        //   SalesHeader, TempSalesLine, 2, TotalSalesLine[3], TotalSalesLineLCY[3],
        //   VATAmount[3], VATAmountText[3], ProfitLCY[3], ProfitPct[3],
        //   DecLTotalAdjCostLCY,
        //   TotalSalesLine[3]."BC6_DEEE HT Amount", TotalSalesLine[3]."BC6_DEEE VAT Amount",
        //   TotalSalesLine[3]."BC6_DEEE TTC Amount", TotalSalesLine[3]."BC6_DEEE HT Amount (LCY)");

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2[3] := TotalSalesLine[3].Amount;
            TotalAmount1[3] := TotalAmount2[3] + VATAmount[3];
            TotalSalesLine[3]."Line Amount" := TotalAmount1[3] + TotalSalesLine[3]."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1[3] := TotalSalesLine[3].Amount;
            TotalAmount2[3] := TotalSalesLine[3]."Amount Including VAT";
        END;

        TempVATAmountLine3.MODIFYALL(Modified, FALSE);
        SalesHeader."BC6_Sales LCY" := TotalSalesLineLCY[3].Amount;
        SalesHeader."BC6_Profit LCY" := ProfitLCY[3];
        SalesHeader."BC6_% Profit" := ProfitPct[3];
        SalesHeader.MODIFY()
    END;

    //COD86
    PROCEDURE UpdatePurchasedoc(var SalesOrderLine: Record "Sales Line"; SalesQuoteLine: Record "Sales Line");
    VAR
        RecLPurchLine: Record "Purchase Line";
    BEGIN
        RecLPurchLine.RESET();
        //>> MODIF HL 22/10/2012 SU-LALE cf appel TI127191
        RecLPurchLine.SETCURRENTKEY("BC6_Sales Document Type", "BC6_Sales Line No.", "BC6_Sales No.");
        //<< MODIF HL 22/10/2012 SU-LALE cf appel TI127191
        RecLPurchLine.SETFILTER("BC6_Sales Document Type", '%1', SalesQuoteLine."Document Type");
        RecLPurchLine.SETFILTER("BC6_Sales Line No.", '%1', SalesQuoteLine."Line No.");
        RecLPurchLine.SETFILTER("BC6_Sales No.", SalesQuoteLine."Document No.");
        IF RecLPurchLine.FIND('-') THEN
            REPEAT
                RecLPurchLine."BC6_Sales No." := SalesOrderLine."Document No.";
                RecLPurchLine."BC6_Sales Line No." := SalesOrderLine."Line No.";
                RecLPurchLine."BC6_Sales Document Type" := SalesOrderLine."Document Type";
                RecLPurchLine.MODIFY(TRUE);
            UNTIL RecLPurchLine.NEXT() = 0;
    END;

    //TODO : procedure CreateInvtPutAwayPick STD j'ai pas trouver des event pour inserer mon code donc j la dupliquer en+ la fct est utilisée juste dans des pages
    PROCEDURE CreateInvtPutAwayPick();
    VAR
        PurchHeader: Record "Purchase Header";
        WhseRequest: Record "Warehouse Request";
        RepLCreateInvtPutPickMvmt: Report "Create Invt Put-away/Pick/Mvmt";
    BEGIN
        PurchHeader.get();
        PurchHeader.TESTFIELD(Status, "Purchase Document Status"::Released);
        WhseRequest.RESET();
        WhseRequest.SETCURRENTKEY("Source Document", "Source No.");
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:
                WhseRequest.SETRANGE("Source Document", WhseRequest."Source Document"::"Purchase Order");
            PurchHeader."Document Type"::"Return Order":
                WhseRequest.SETRANGE("Source Document", WhseRequest."Source Document"::"Purchase Return Order");
        END;
        WhseRequest.SETRANGE("Source No.", PurchHeader."No.");
        RepLCreateInvtPutPickMvmt.SETTABLEVIEW(WhseRequest);
        RepLCreateInvtPutPickMvmt.InitializeRequest(TRUE, FALSE, FALSE, TRUE, FALSE);
        RepLCreateInvtPutPickMvmt.RUN();
    END;

    //TODO: //fct du std , j la dupliquer et effacer le reste du code qui ne sert a rien , cette fct est utilisé juste ds les pages on peut apres passer la valeur true simplement sans avoir besoin a cette fct
    PROCEDURE ConfirmCloseUnposted(): Boolean;
    BEGIN
        EXIT(TRUE);
    END;

    procedure GetContactAsCompany2(Contact: Record Contact; var SearchContact: Record Contact): Boolean;
    var
        IsHandled: Boolean;
    begin
        if not IsHandled then
            if Contact."Company No." <> '' then
                exit(SearchContact.Get(Contact."Company No."));
    end;

    procedure GetBin(_LocationCode: Code[10]; _BinCode: Code[20]; var _Bin: Record Bin) // Fonction dupliquer
    begin
        if (_LocationCode = '') or (BinCode = '') then
            _Bin.Init()
        else
            if (_Bin."Location Code" <> _LocationCode) or
               (_Bin.Code <> BinCode)
            then
                _Bin.Get(_LocationCode, BinCode);
    end;

    PROCEDURE SetYourReference(_YourRef: Text);
    BEGIN
        YourReference := _YourRef;
    END;

    PROCEDURE FindVeryBestPrice(VAR RecLSalesLine: Record "Sales Line"; RecLSalesHeader: Record "Sales Header");
    VAR
        Item: Record Item;
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        BestDiscount: Decimal;
        BestPrice: Decimal;
        ItemUnitPrice: Decimal;
        ItemUnitPriceBestDiscount: Decimal;
    BEGIN
        WITH RecLSalesLine DO BEGIN
            IF RecLSalesLine.Type = Type::Item THEN BEGIN

                PriceCalcMgt.SetCurrency(
                  RecLSalesHeader."Currency Code", RecLSalesHeader."Currency Factor", PriceCalcMgt.SalesHeaderExchDate(RecLSalesHeader));
                PriceCalcMgt.SetVAT(RecLSalesHeader."Prices Including VAT", "VAT %", "VAT Calculation Type".AsInteger(), "VAT Bus. Posting Group");
                PriceCalcMgt.SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
                PriceCalcMgt.SetLineDisc("Line Discount %", "Allow Line Disc.", "Allow Invoice Disc.");

                //Prix unitaire
                Item.RESET();
                Item.GET(RecLSalesLine."No.");
                ItemUnitPrice := Item."Unit Price";
                IF RecLSalesHeader."Prices Including VAT" THEN
                    ItemUnitPrice := ItemUnitPrice * (1 + RecLSalesLine."VAT %" / 100);

                //Meilleur remise
                IF PriceCalcMgt.SalesLineLineDiscExists(RecLSalesHeader, RecLSalesLine, FALSE) THEN BEGIN
                    // PriceCalcMgt.CalcBestLineDisc(TempSalesLineDisc); TODO:
                    // BestDiscount := TempSalesLineDisc."Line Discount %"; TODO:
                END ELSE BEGIN
                    BestDiscount := 0;
                END;

                //Meilleur prix
                IF PriceCalcMgt.SalesLinePriceExists(RecLSalesHeader, RecLSalesLine, FALSE) THEN BEGIN
                    // PriceCalcMgt.CalcBestUnitPrice(TempSalesPrice); TODO:
                    // BestPrice := TempSalesPrice."Unit Price" ; TODO:
                END ELSE BEGIN
                    BestPrice := 0;
                END;

                ItemUnitPriceBestDiscount := (ItemUnitPrice * (1 - BestDiscount / 100));

                IF (BestPrice <> 0) THEN BEGIN
                    IF (ItemUnitPriceBestDiscount < BestPrice) THEN BEGIN
                        RecLSalesLine."Unit Price" := ItemUnitPrice;
                        RecLSalesLine."Line Discount %" := BestDiscount;
                        RecLSalesLine."Allow Line Disc." := TRUE;
                        RecLSalesLine."Allow Invoice Disc." := TRUE;
                    END ELSE BEGIN
                        RecLSalesLine."Unit Price" := BestPrice;
                        RecLSalesLine."Line Discount %" := 0;
                        RecLSalesLine."Allow Line Disc." := FALSE;
                        RecLSalesLine."Allow Invoice Disc." := TRUE;
                    END;
                END ELSE BEGIN
                    RecLSalesLine."Unit Price" := ItemUnitPrice;
                    RecLSalesLine."Line Discount %" := BestDiscount;
                    RecLSalesLine."Allow Line Disc." := TRUE;
                    RecLSalesLine."Allow Invoice Disc." := TRUE;
                END;
                PriceCalcMgt.ConvertPriceLCYToFCY('', RecLSalesLine."Unit Price");
            END;
        END;
    END;

    // Deplicated function from table "Warehouse Activity Line" Id 5767
    procedure UpdateReservation(TempWhseActivLine2: Record "Warehouse Activity Line" temporary; Deletion: Boolean)
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        with TempWhseActivLine2 do begin
            if ("Action Type" <> "Action Type"::Take) and ("Breakbulk No." = 0) and
               ("Whse. Document Type" = "Whse. Document Type"::Shipment)
            then begin
                InitTrackingSpecFromWhseActivLine(TempTrackingSpecification, TempWhseActivLine2);
                TempTrackingSpecification."Qty. to Handle (Base)" := 0;
                TempTrackingSpecification."Entry No." := TempTrackingSpecification."Entry No." + 1;
                TempTrackingSpecification."Creation Date" := Today;
                TempTrackingSpecification."Warranty Date" := "Warranty Date";
                TempTrackingSpecification."Expiration Date" := "Expiration Date";
                TempTrackingSpecification.Correction := true;
                TempTrackingSpecification.Insert();
            end;
            ItemTrackingMgt.SetPick("Activity Type" = "Activity Type"::Pick);
            ItemTrackingMgt.SynchronizeWhseItemTracking(TempTrackingSpecification, '', Deletion);
        end;
    end;

    // Deplicated function from table "Warehouse Activity Line" Id 5767
    procedure InitTrackingSpecFromWhseActivLine(var TrackingSpecification: Record "Tracking Specification"; WhseActivityLine: Record "Warehouse Activity Line")
    begin
        with WhseActivityLine do begin
            TrackingSpecification.Init();
            if "Source Type" = DATABASE::"Prod. Order Component" then
                TrackingSpecification.SetSource(
                  "Source Type", "Source Subtype", "Source No.", "Source Subline No.", '', "Source Line No.")
            else
                TrackingSpecification.SetSource(
                  "Source Type", "Source Subtype", "Source No.", "Source Line No.", '', 0);

            TrackingSpecification."Item No." := "Item No.";
            TrackingSpecification."Location Code" := "Location Code";
            TrackingSpecification.Description := Description;
            TrackingSpecification."Variant Code" := "Variant Code";
            TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            TrackingSpecification.CopyTrackingFromWhseActivityLine(WhseActivityLine);
            TrackingSpecification."Expiration Date" := "Expiration Date";
            TrackingSpecification."Bin Code" := "Bin Code";
            TrackingSpecification."Qty. to Handle (Base)" := "Qty. to Handle (Base)";
        end;
    end;

    procedure InsertRec(NewType: Enum "Notification Entry Type"; NewUserID: Code[50]; NewRecordID: RecordID; NewLinkTargetPage: Integer; NewCustomLink: Text[250]; NewSenderUserID: Code[50]): Boolean;
    var
        NotificationEntry: record "Notification Entry";
    begin
        if not DoesTableMatchType(NewType, NewRecordID.TableNo) then
            exit(false);

        Clear(NotificationEntry);
        NotificationEntry.Type := NewType;
        NotificationEntry."Recipient User ID" := NewUserID;
        NotificationEntry."Triggered By Record" := NewRecordID;
        NotificationEntry."Link Target Page" := NewLinkTargetPage;
        NotificationEntry."Custom Link" := NewCustomLink;
        NotificationEntry."Sender User ID" := NewSenderUserID;
        exit(NotificationEntry.Insert(true));
    end;

    procedure DoesTableMatchType(NewType: Enum "Notification Entry Type"; TableNo: Integer): Boolean;
    begin
        case NewType of
            "Notification Entry Type"::Approval:
                exit(TableNo = Database::"Approval Entry");
            "Notification Entry Type"::Overdue:
                exit(TableNo = Database::"Overdue Approval Entry");
        end;
        exit(true);
    end;
    //PAGE232
    procedure FindApplyingEntry()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CalcType: Enum "Customer Apply Calculation Type";
        CustEntryApplID: Code[50];
        AppliesToID: Code[50];
        TempApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        ApplyingAmount: Decimal; //TODO: need a check
        ApplnDate: Date;
        ApplnCurrencyCode: Code[10];
        ApplyCust: page "Apply Customer Entries";
    begin
        if CalcType = CalcType::Direct then begin
            CustEntryApplID := UserId;
            if CustEntryApplID = '' then
                CustEntryApplID := '***';
            CustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open);
            CustLedgEntry.SetRange("Customer No.", CustLedgEntry."Customer No.");
            if AppliesToID = '' then
                CustLedgEntry.SetRange("Applies-to ID", CustEntryApplID)
            else
                CustLedgEntry.SetRange("Applies-to ID", AppliesToID);
            CustLedgEntry.SetRange(Open, true);
            CustLedgEntry.SetRange("Applying Entry", true);
            if CustLedgEntry.FindFirst() then begin
                CustLedgEntry.CalcFields(Amount, "Remaining Amount");
                TempApplyingCustLedgEntry := CustLedgEntry;
                CustLedgEntry.SetFilter("Entry No.", '<>%1', CustLedgEntry."Entry No.");
                ApplyingAmount := CustLedgEntry."Remaining Amount";
                ApplnDate := CustLedgEntry."Posting Date";
                ApplnCurrencyCode := CustLedgEntry."Currency Code";
            end;
            ApplyCust.CalcApplnAmount();
        end;
    end;

    procedure BC6_FindApplyingEntry()
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        TempApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        AppVendEnt: page "Apply Vendor Entries";
        CalcType: Enum "Vendor Apply Calculation Type";
        VendEntryApplID: Code[50];
        AppliesToID: Code[50];
        ApplyingAmount: Decimal; //VAR glob 
        ApplnDate: Date;
        ApplnCurrencyCode: Code[10];

    begin
        VendLedgEntry.get(VendLedgEntry."Entry No.");
        if CalcType = CalcType::Direct then begin
            VendEntryApplID := UserId;
            if VendEntryApplID = '' then
                VendEntryApplID := '***';

            VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
            VendLedgEntry.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
            if AppliesToID = '' then
                VendLedgEntry.SetRange("Applies-to ID", VendEntryApplID)
            else
                VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetRange("Applying Entry", true);
            if VendLedgEntry.FindFirst() then begin
                VendLedgEntry.CalcFields(Amount, "Remaining Amount");
                TempApplyingVendLedgEntry := VendLedgEntry;
                VendLedgEntry.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                ApplyingAmount := VendLedgEntry."Remaining Amount";
                ApplnDate := VendLedgEntry."Posting Date";
                ApplnCurrencyCode := VendLedgEntry."Currency Code";
            end;
            AppVendEnt.CalcApplnAmount();
        end;
    end;


    PROCEDURE OnRunTiersPayeur(VAR Rec: Record "Payment Line");
    VAR
        Header: Record "Payment Header";
        GenJnlLine: Record "Gen. Journal Line";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Currency: Record Currency;
        ApplyCustEntries: Page "Apply Customer Entries";
        ApplyVendEntries: Page "Apply Vendor Entries";
        PayApply: Codeunit "Payment-Apply";
        GenJnlPostLine: Integer;
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        CurrencyCode2: Code[10];
        OK: Boolean;
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\', Comment = 'FRA="Remplacement de %1 %3 par %4 dans %2.\"';
        Text002: Label 'Do you wish to continue?', Comment = 'FRA="Souhaitez-vous continuer ?"';
        Text003: Label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
        Text005: Label 'The %1 or %2 must be Customer or Vendor.', Comment = 'FRA="%1 ou %2 doit être un client ou un fournisseur."';
        Text006: Label 'All entries in one application must be in the same currency.', Comment = 'FRA="La même devise doit être utilisée pour toutes les écritures lettrage."';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies.', Comment = 'FRA="Toutes les écritures d''une même application doivent être indiquées dans la même devise ou dans une ou plusieurs devises UME. "';
    BEGIN
        Header.GET(Rec."No.");

        GenJnlLine."Account Type" := Rec."Account Type";
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Amount := Rec.Amount;
        GenJnlLine."Amount (LCY)" := Rec."Amount (LCY)";
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine."Posting Date" := Header."Posting Date";

        WITH GenJnlLine DO BEGIN
            PayApply.GetCurrency;
            AccType := "Account Type";
            AccNo := "Account No.";

            CASE AccType OF
                AccType::Customer:
                    BEGIN
                        CustLedgEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("BC6_Pay-to Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, TRUE);
                        IF "Applies-to ID" = '' THEN
                            "Applies-to ID" := Rec."No." + '/' + FORMAT(Rec."Line No.");
                        ApplyCustEntries.SetGenJnlLine(GenJnlLine, GenJnlLine.FIELDNO("Applies-to ID"));
                        ApplyCustEntries.SETRECORD(CustLedgEntry);
                        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
                        ApplyCustEntries.LOOKUPMODE(TRUE);
                        OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyCustEntries);
                        IF NOT OK THEN
                            EXIT;
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("BC6_Pay-to Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, TRUE);
                        CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF CustLedgEntry.FIND('-') THEN BEGIN
                            CurrencyCode2 := CustLedgEntry."Currency Code";
                            IF Amount = 0 THEN BEGIN
                                REPEAT
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                    CustLedgEntry.CALCFIELDS("Remaining Amount");
                                    CustLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmount(
                                        CustLedgEntry."Remaining Amount",
                                        CustLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    CustLedgEntry."Remaining Amount" :=
                                      ROUND(CustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmount(
                                        CustLedgEntry."Remaining Pmt. Disc. Possible",
                                        CustLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                    IF (CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice) AND
                                       ("Posting Date" <= CustLedgEntry."Pmt. Discount Date")
                                    THEN
                                        Amount := Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                    ELSE
                                        Amount := Amount - CustLedgEntry."Amount to Apply";
                                UNTIL CustLedgEntry.NEXT = 0;
                                "Amount (LCY)" := Amount;
                                "Currency Factor" := 1;
                                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) OR
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                THEN BEGIN
                                    Amount := -Amount;
                                    "Amount (LCY)" := -"Amount (LCY)";
                                END;
                                VALIDATE(Amount);
                                VALIDATE("Amount (LCY)");
                            END ELSE
                                REPEAT
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                UNTIL CustLedgEntry.NEXT = 0;
                            IF "Currency Code" <> CurrencyCode2 THEN
                                IF Amount = 0 THEN BEGIN
                                    IF NOT
                                       CONFIRM(
                                         Text001 +
                                         Text002, TRUE,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         CustLedgEntry."Currency Code")
                                    THEN
                                        ERROR(Text003);
                                    "Currency Code" := CustLedgEntry."Currency Code"
                                END ELSE
                                    PayApply.CheckAgainstApplnCurrency("Currency Code", CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        END ELSE
                            "Applies-to ID" := '';
                        "Due Date" := CustLedgEntry."Due Date";
                    END;
                AccType::Vendor:
                    BEGIN
                        VendLedgEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive);
                        VendLedgEntry.SETRANGE("BC6_Pay-to Vend. No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, TRUE);
                        "Applies-to ID" := GetAppliesToID("Applies-to ID", Rec);
                        ApplyVendEntries.SetGenJnlLine(GenJnlLine, GenJnlLine.FIELDNO("Applies-to ID"));
                        ApplyVendEntries.SETRECORD(VendLedgEntry);
                        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                        ApplyVendEntries.LOOKUPMODE(TRUE);
                        OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyVendEntries);
                        IF NOT OK THEN
                            EXIT;
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive);
                        VendLedgEntry.SETRANGE("BC6_Pay-to Vend. No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, TRUE);
                        VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF VendLedgEntry.FIND('-') THEN BEGIN
                            CurrencyCode2 := VendLedgEntry."Currency Code";
                            IF Amount = 0 THEN BEGIN
                                REPEAT
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, TRUE);
                                    VendLedgEntry.CALCFIELDS("Remaining Amount");
                                    VendLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmount(
                                        VendLedgEntry."Remaining Amount",
                                        VendLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    VendLedgEntry."Remaining Amount" :=
                                      ROUND(VendLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmount(
                                        VendLedgEntry."Remaining Pmt. Disc. Possible",
                                        VendLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      ROUND(VendLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                    IF (VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Invoice) AND
                                       ("Posting Date" <= VendLedgEntry."Pmt. Discount Date")
                                    THEN
                                        Amount := Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                    ELSE
                                        Amount := Amount - VendLedgEntry."Amount to Apply";
                                UNTIL VendLedgEntry.NEXT = 0;
                                "Amount (LCY)" := Amount;
                                "Currency Factor" := 1;
                                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) OR
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                THEN BEGIN
                                    Amount := -Amount;
                                    "Amount (LCY)" := -"Amount (LCY)";
                                END;
                                VALIDATE(Amount);
                                VALIDATE("Amount (LCY)");
                            END ELSE
                                REPEAT
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, TRUE);
                                UNTIL VendLedgEntry.NEXT = 0;
                            IF "Currency Code" <> CurrencyCode2 THEN
                                IF Amount = 0 THEN BEGIN
                                    IF NOT
                                       CONFIRM(
                                         Text001 +
                                         Text002, TRUE,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         VendLedgEntry."Currency Code")
                                    THEN
                                        ERROR(Text003);
                                    "Currency Code" := VendLedgEntry."Currency Code"
                                END ELSE
                                    PayApply.CheckAgainstApplnCurrency("Currency Code", VendLedgEntry."Currency Code", AccType::Vendor, TRUE);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        END ELSE
                            "Applies-to ID" := '';
                        "Due Date" := VendLedgEntry."Due Date";
                    END;
                ELSE
                    ERROR(
                      Text005,
                      FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));
            END;
        END;
        Rec."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
        Rec."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
        Rec."Applies-to ID" := GenJnlLine."Applies-to ID";
        Rec."Due Date" := GenJnlLine."Due Date";
        Rec.Amount := GenJnlLine.Amount;
        Rec."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        Rec.VALIDATE(Amount);
        Rec.VALIDATE("Amount (LCY)");
    END;

    procedure GetAppliesToID(AppliesToID: Code[50]; PaymentLine: Record "Payment Line"): Code[50]
    begin
        IF AppliesToID = '' THEN
            AppliesToID := PaymentLine."No." + '/' + FORMAT(PaymentLine."Line No.");
        EXIT(AppliesToID);
    end;

    procedure CalcQtyAvailToPick(var SalesLine: Record "Sales Line"): Decimal;
    var
        Item: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        AvailabilityDate: Date;
        LookaheadDateformula: DateFormula;
    begin
        if SIPM.GetItem(SalesLine) then begin
            Item.RESET;
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Location Filter", SalesLine."Location Code");
            Item.SETRANGE("Drop Shipment Filter", FALSE);
            exit(Item.CalcQtyAvailToPick(0));
        end;
    end;

    PROCEDURE CalcQtyOnPurchOrder(VAR SalesLine: Record "Sales Line"): Decimal;
    VAR
        Item: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromis: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        AvailabilityDate: Date;
        LookaheadDateformula: DateFormula;
    BEGIN
        IF SIPM.GetItem(SalesLine) THEN BEGIN
            Item.RESET;
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Location Filter", SalesLine."Location Code");
            Item.SETRANGE("Drop Shipment Filter", FALSE);
            Item.CALCFIELDS("Qty. on Purch. Order");
            EXIT(Item."Qty. on Purch. Order");
        END;
    END;

    PROCEDURE LookupQtyOnPurchOrder(SalesLine: Record "Sales Line");
    VAR
        Item: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        PurchLine: Record "Purchase Line";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
    BEGIN
        SalesLine.TESTFIELD(Type, SalesLine.Type::Item);
        SalesLine.TESTFIELD("No.");
        IF SIPM.GetItem(SalesLine) THEN BEGIN
            Item.RESET;
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Location Filter", SalesLine."Location Code");
            Item.SETRANGE("Drop Shipment Filter", FALSE);

            PurchLine.RESET;
            PurchLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Expected Receipt Date");
            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SETRANGE(Type, PurchLine.Type::Item);
            PurchLine.SETRANGE("No.", Item."No.");
            PurchLine.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
            PurchLine.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
            PurchLine.SETFILTER("Drop Shipment", Item.GETFILTER("Drop Shipment Filter"));
            PurchLine.SETFILTER("Expected Receipt Date", Item.GETFILTER("Date Filter"));
            PurchLine.SETFILTER("Shortcut Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
            PurchLine.SETFILTER("Shortcut Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
            PAGE.RUN(0, PurchLine);
        END;
    END;

    PROCEDURE CalcCNEInventory(SalesLine: Record "Sales Line"): Decimal;
    VAR
        L_Item: Record Item;
    BEGIN
        IF COMPANYNAME <> 'CNE 2007' THEN
            L_Item.CHANGECOMPANY('CNE 2007');
        IF NOT L_Item.READPERMISSION THEN
            EXIT(0);

        IF L_Item.GET(SalesLine."No.") THEN
            L_Item.CALCFIELDS(Inventory);
        EXIT(L_Item.Inventory);
    END;

    PROCEDURE CalcCNEQtyOnPurchOrder(SalesLine: Record "Sales Line"): Decimal;
    VAR
        L_Item: Record Item;
    BEGIN
        IF COMPANYNAME <> 'CNE 2007' THEN
            L_Item.CHANGECOMPANY('CNE 2007');

        IF NOT L_Item.READPERMISSION THEN
            EXIT(0);

        IF L_Item.GET(SalesLine."No.") THEN
            L_Item.CALCFIELDS("Qty. on Purch. Order");
        EXIT(L_Item."Qty. on Purch. Order");
    END;

    PROCEDURE CalcAvailableInventoryCNE(SalesLine: Record "Sales Line"; VAR Item: Record Item): Decimal;
    VAR
        CopyOfItem: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
    BEGIN
        //BCSYS 220321
        CopyOfItem.COPY(Item);
        IF SalesLine.Type <> SalesLine.Type::Item THEN EXIT(0);
        IF CopyOfItem.GET(CopyOfItem."No.") THEN BEGIN
            //SetItemFilter(Item,SalesLine);
            Item.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Drop Shipment Filter", FALSE);

            EXIT(ConvertQty(AvailableToPromise.CalcAvailableInventory(Item), SalesLine."Qty. per Unit of Measure"));
        END;
    END;

    procedure ConvertQty(Qty: Decimal; PerUoMQty: Decimal) Result: Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if PerUoMQty = 0 then
            PerUoMQty := 1;
        Result := Round(Qty / PerUoMQty, UOMMgt.QtyRndPrecision);
    end;

    PROCEDURE CalcAvailableInventoryMETZ(SalesLine: Record "Sales Line"; VAR Item: Record Item): Decimal;
    VAR
        CopyOfItem: Record Item;
        AvailableToPromise: Codeunit "Available to Promise";
        SIPM: Codeunit "Sales Info-Pane Management";
    BEGIN
        CopyOfItem.COPY(Item);
        IF SalesLine.Type <> SalesLine.Type::Item THEN EXIT(0);
        IF CopyOfItem.GET(CopyOfItem."No.") THEN BEGIN
            Item.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Drop Shipment Filter", false);

            EXIT(ConvertQty(AvailableToPromise.CalcAvailableInventory(Item), SalesLine."Qty. per Unit of Measure"));
        END;
    END;


    PROCEDURE CalcAvailabilityCNE(VAR SalesLine: Record "Sales Line"; VAR Item: Record Item): Decimal;
    VAR
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        LookaheadDateformula: DateFormula;
        CopyOfItem: Record Item;
    BEGIN
        CopyOfItem.COPY(Item);
        IF SalesLine.Type <> SalesLine.Type::Item THEN EXIT(0);
        IF CopyOfItem.GET(CopyOfItem."No.") THEN BEGIN
            CopyOfItem.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            CopyOfItem.SETRANGE("Variant Filter", SalesLine."Variant Code");
            CopyOfItem.SETRANGE("Drop Shipment Filter", FALSE);

            EXIT(ConvertQty(AvailableToPromise.QtyAvailabletoPromise(CopyOfItem, GrossRequirement, ScheduledReceipt, SIPM.CalcAvailabilityDate(SalesLine), PeriodType, LookaheadDateformula), SalesLine."Qty. per Unit of Measure"));
        END;
    END;


    PROCEDURE CalcAvailabilityMETZ(VAR SalesLine: Record "Sales Line"; VAR Item: Record Item): Decimal;
    VAR
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        LookaheadDateformula: DateFormula;
        CopyOfItem: Record 27;
    BEGIN
        CopyOfItem.COPY(Item);
        IF SalesLine.Type <> SalesLine.Type::Item THEN EXIT(0);
        IF CopyOfItem.GET(CopyOfItem."No.") THEN BEGIN
            CopyOfItem.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            CopyOfItem.SETRANGE("Variant Filter", SalesLine."Variant Code");
            CopyOfItem.SETRANGE("Drop Shipment Filter", FALSE);

            EXIT(
            ConvertQty(AvailableToPromise.QtyAvailabletoPromise(CopyOfItem, GrossRequirement, ScheduledReceipt, SIPM.CalcAvailabilityDate(SalesLine), PeriodType, LookaheadDateformula), SalesLine."Qty. per Unit of Measure"));
        END;
    END;

    procedure FindPurchLineDisc(VAR ToPurchLineDisc: Record "Purchase Line Discount"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean; ItemDiscGrCode: Code[10])
    var
        FromPurchLineDisc: Record "Purchase Line Discount";
    begin
        WITH FromPurchLineDisc DO BEGIN
            SETRANGE("Item No.", ItemNo);
            SETRANGE("Vendor No.", VendorNo);
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            SETFILTER("Variant Code", '%1|%2', VariantCode, '');
            IF NOT ShowAll THEN BEGIN
                SETRANGE("Starting Date", 0D, StartingDate);
                SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
                SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            END;

            ToPurchLineDisc.RESET;
            ToPurchLineDisc.DELETEALL;
            FOR BC6_Type := BC6_Type::Item TO BC6_Type::"All items" DO BEGIN
                IF (BC6_Type = BC6_Type::"All items") OR
                  ((BC6_Type = BC6_Type::Item) AND (ItemNo <> '')) OR
                  ((BC6_Type = BC6_Type::"Item Disc. Group") AND (ItemDiscGrCode <> '')) THEN BEGIN

                    SETRANGE(BC6_Type, BC6_Type);

                    CASE BC6_Type OF
                        BC6_Type::"All items":
                            SETRANGE("Item No.");
                        BC6_Type::Item:
                            SETRANGE("Item No.", ItemNo);
                        BC6_Type::"Item Disc. Group":
                            SETRANGE("Item No.", ItemDiscGrCode);
                    END;
                    //Fin GESTION_REMISE FG 06/12/06 NSC1.01
                    //<<MIGRATION NAV 2013

                    IF FIND('-') THEN
                        REPEAT
                            ToPurchLineDisc := FromPurchLineDisc;
                            ToPurchLineDisc.INSERT;
                        UNTIL NEXT = 0;
                END;
            END;
        END;
    end;

    procedure PurchHeaderStartDate(var PurchHeader: Record "Purchase Header"; var DateCaption: Text[30]) StartDate: Date
    begin
        with PurchHeader do
            if "Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"] then begin
                DateCaption := FieldCaption("Posting Date");
                exit("Posting Date")
            end else begin
                DateCaption := FieldCaption("Order Date");
                exit("Order Date");
            end;
    end;

    // function specifique codeunit 378 "Transfer Extended Text"
    PROCEDURE InsertSalesExtTextSpe(VAR SalesLine: Record "Sales Line");
    VAR
        ToSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        Item: Record Item;
        RecGTmpExtTexLineSpe: Record "BC6_Special Extended Text Line"; // TODO: check variable global utilisee dans une event codeunit 50201 BC6_EventsMgt
        BooGAutoTextSpe: Boolean; // TODO: check variable global pour test utilisee dans une event codeunit 50201 BC6_EventsMgt
        MakeUpdateRequired: Boolean; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        OKA: Boolean;
        NextLineNo: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        LineSpacing: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        Text000: Label 'There is not enough space to insert extended text lines.', Comment = 'FRA="Il n''y a pas suffisamment de place pour ins‚rer des lignes texte ‚tendu."';
    BEGIN
        OKA := FALSE;

        IF SalesLine.Type = SalesLine.Type::Item THEN
            OKA := TRUE
        ELSE
            EXIT;
        Item.GET(SalesLine."No.");
        OKA := Item."Automatic Ext. Texts";
        IF BooGAutoTextSpe = TRUE THEN BEGIN

            SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
            RecGTmpExtTexLineSpe.RESET;

            RecGTmpExtTexLineSpe.SETRANGE("Table Name", RecGTmpExtTexLineSpe."Table Name"::Customer);
            RecGTmpExtTexLineSpe.SETRANGE(Code, SalesHeader."Bill-to Customer No.");
            RecGTmpExtTexLineSpe.SETRANGE("No.", SalesLine."No.");

            ToSalesLine.RESET;
            ToSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
            ToSalesLine.SETRANGE("Document No.", SalesLine."Document No.");

            ToSalesLine := SalesLine;

            IF ToSalesLine.FIND('>') THEN BEGIN
                LineSpacing :=
                   (ToSalesLine."Line No." - SalesLine."Line No.") DIV
                   (1 + RecGTmpExtTexLineSpe.COUNT);
                IF LineSpacing = 0 THEN
                    ERROR(Text000);


            END ELSE BEGIN
                LineSpacing := 10000;
            END;


            NextLineNo := SalesLine."Line No." + LineSpacing;

            IF RecGTmpExtTexLineSpe.FIND('-') THEN BEGIN
                REPEAT
                    ToSalesLine.INIT;
                    ToSalesLine."Document Type" := SalesLine."Document Type";
                    ToSalesLine."Document No." := SalesLine."Document No.";
                    ToSalesLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToSalesLine.Description := RecGTmpExtTexLineSpe.Text;
                    ToSalesLine."Attached to Line No." := SalesLine."Line No.";
                    ToSalesLine.INSERT;
                UNTIL RecGTmpExtTexLineSpe.NEXT = 0;
                MakeUpdateRequired := TRUE;
            END;
        END;
    END;


    // function specifique codeunit 378 "Transfer Extended Text"
    PROCEDURE InsertPurchExtTextSpe(VAR PurchLine: Record "Purchase Line");
    VAR
        ToPurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Item: Record Item;
        RecGTmpExtTexLineSpe: Record "BC6_Special Extended Text Line"; // TODO: check variable global utilisee dans une event codeunit 50201 BC6_EventsMgt
        BooGAutoTextSpe: Boolean; // TODO: check variable global pour test utilisee dans une event codeunit 50201 BC6_EventsMgt
        MakeUpdateRequired: Boolean; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        OKA: Boolean;
        NextLineNo: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        LineSpacing: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
    BEGIN
        OKA := FALSE;
        IF PurchLine.Type = PurchLine.Type::Item THEN
            OKA := TRUE
        ELSE
            EXIT;

        Item.GET(PurchLine."No.");
        OKA := Item."Automatic Ext. Texts";


        IF BooGAutoTextSpe = TRUE THEN BEGIN
            PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");

            RecGTmpExtTexLineSpe.RESET;

            RecGTmpExtTexLineSpe.SETRANGE("Table Name", RecGTmpExtTexLineSpe."Table Name"::Vendor);
            RecGTmpExtTexLineSpe.SETRANGE(Code, PurchHeader."Buy-from Vendor No.");
            RecGTmpExtTexLineSpe.SETRANGE("No.", PurchLine."No.");

            ToPurchLine.RESET;
            ToPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
            ToPurchLine.SETRANGE("Document No.", PurchLine."Document No.");

            ToPurchLine := PurchLine;
            IF ToPurchLine.FIND('>') THEN BEGIN
                LineSpacing :=
                   (ToPurchLine."Line No." - PurchLine."Line No.") DIV
                   (1 + RecGTmpExtTexLineSpe.COUNT);

            END ELSE BEGIN
                LineSpacing := 10000;
            END;

            NextLineNo := PurchLine."Line No." + LineSpacing;

            IF RecGTmpExtTexLineSpe.FIND('-') THEN BEGIN
                REPEAT
                    ToPurchLine.INIT;
                    ToPurchLine."Document Type" := PurchLine."Document Type";
                    ToPurchLine."Document No." := PurchLine."Document No.";
                    ToPurchLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToPurchLine.Description := RecGTmpExtTexLineSpe.Text;
                    ToPurchLine."Attached to Line No." := PurchLine."Line No.";
                    ToPurchLine.INSERT;
                UNTIL RecGTmpExtTexLineSpe.NEXT = 0;
                MakeUpdateRequired := TRUE;
            END;
        END;
    END;

    var
        EnableIncrPurchCost: Boolean;
        YourReference: Text; // related to SetYourReference function
}