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

    procedure BinLookUp2(LocationCode: Code[10]; BinCod: Code[10]): Code[20]; // TODO: related to codeunit 7302
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

    PROCEDURE InsertTempWhseJnlLine2(ItemJnlLine: Record "Item Journal Line"; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDoc: Integer; SourceType2: Integer; SourceSubType2: Integer; SourceNo2: Code[20]; SourceLineNo2: Integer; VAR TempWhseJnlLine: Record "Warehouse Journal Line" temporary; VAR NextLineNo: Integer);
    VAR
        WhseEntry: Record "Warehouse Entry";
        WhseMgt: Codeunit "Whse. Management";
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

    var
        EnableIncrPurchCost: Boolean;
        YourReference: Text; // related to SetYourReference function
}