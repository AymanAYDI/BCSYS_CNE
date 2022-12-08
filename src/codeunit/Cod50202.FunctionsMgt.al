codeunit 50202 "BC6_Functions Mgt"
{
    procedure FindVeryBestCost(var RecLPurchaseLine: Record "Purchase Line"; RecLPurchaseHeader: Record "Purchase Header")
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
        with RecLPurchaseLine do
            if RecLPurchaseLine.Type = Type::Item then begin

                //Prix unitaire
                Item.RESET();
                Item.GET(RecLPurchaseLine."No.");
                ItemDirectUnitCost := Item."Unit Price";

                //Meilleur prix
                if PurPriCalMgt.PurchLinePriceExists(RecLPurchaseHeader, RecLPurchaseLine, false) then begin
                    PurPriCalMgt.CalcBestDirectUnitCost(PurchPrice);
                    BestCost := PurchPrice."Direct Unit Cost";
                end else
                    BestCost := 0;

                //Meilleur remise
                if PurPriCalMgt.PurchLineLineDiscExists(RecLPurchaseHeader, RecLPurchaseLine, false) then begin
                    PurPriCalMgt.CalcBestLineDisc(PurchLineDisc);
                    BestDiscount := PurchLineDisc."Line Discount %";
                end else
                    BestDiscount := 0;

                ItemDirectUnitCostBestDiscount := (ItemDirectUnitCost * (1 - BestDiscount / 100));

                if (BestCost <> 0) then begin
                    if (ItemDirectUnitCostBestDiscount < BestCost) then begin
                        RecLPurchaseLine."Direct Unit Cost" := ItemDirectUnitCost;
                        RecLPurchaseLine."Line Discount %" := BestDiscount;
                        RecLPurchaseLine."Allow Invoice Disc." := true;
                    end else begin
                        RecLPurchaseLine."Direct Unit Cost" := BestCost;
                        RecLPurchaseLine."Line Discount %" := 0;
                        RecLPurchaseLine."Allow Invoice Disc." := true;
                    end;
                end else begin
                    RecLPurchaseLine."Direct Unit Cost" := ItemDirectUnitCost;
                    RecLPurchaseLine."Line Discount %" := BestDiscount;
                    RecLPurchaseLine."Allow Invoice Disc." := true;
                end;
            end;
    end;

    //COD419

    procedure CopyAndRenameClientFile(OldFilePath: Text; DirectoryPath: Text; NewSubDirectoryName: Text) NewFilePath: Text;
    var
        fileMgt: Codeunit "File Management";
        Text003: label 'You must enter a file name.';
        Text1100267000: label 'You must enter a file name.';
        Text1100267001: label 'The directory %1 does not exist.';
        directory: Text;
        NewFileName: Text;
    begin
        if OldFilePath = '' then
            exit('');
        //TODO: dotnet
        // IF NOT ClientFileHelper.Exists(OldFilePath) THEN
        //     EXIT('');

        NewFileName := fileMgt.GetFileName(OldFilePath);
        if NewFileName = '' then
            ERROR(Text003);

        if DirectoryPath = '' then
            ERROR(Text1100267000);

        if not fileMgt.ServerDirectoryExists(DirectoryPath) then
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

        exit(NewFilePath);
    end;

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
        Text0009: label 'Conversion cannot be performed before %1 is set to true.';
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

    procedure GetTaxAmountFromSalesOrder_CNE(SalesHeader: Record "Sales Header"): Decimal;
    var
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
        exit(-1 * VATAmount);
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

    procedure ShowPostedConfirmationMessageCode(): Code[50];
    begin
        exit(UPPERCASE('ShowPostedConfirmationMessage'));
    end;

    //COD 5063////////////////////////////


    procedure ArchiveSalesDocumentWithoutMessage(var SalesHeader: Record "Sales Header");
    var
        archMgt: Codeunit ArchiveManagement;
    begin
        archMgt.StoreSalesDocument(SalesHeader, false);
    end;

    procedure PrintInvtPickHeaderCheck(WhseActivHeader: Record "Warehouse Activity Header"; HideDialog: Boolean);
    var
        //TODO:report
        // WhsePick: Report 50047;
        WhsePick2: Report "Picking List";
    begin
        WhseActivHeader.SETRANGE("No.", WhseActivHeader."No.");
        //TODO:report
        // WhsePick.SETTABLEVIEW(WhseActivHeader);
        // WhsePick.InitRequest(0, FALSE, TRUE);
        // WhsePick.USEREQUESTPAGE(NOT HideDialog);
        // WhsePick.RUNMODAL;
    end;

    procedure GetShipmentBin(LocationCode: Code[10]; var BinCod: Code[20]); // TODO: related to codeunit 7302
    var
        Bin: Record Bin;
        Location: Record Location;
        WMSMgt: codeunit "WMS Management";
    begin
        GetLocation(LocationCode);

        if not Location."Bin Mandatory" then
            exit;

        if Location."Directed Put-away and Pick" then
            exit;

        Bin.RESET();
        Bin.SETRANGE("Location Code", Location.Code);
        Bin.SETRANGE(Empty, true);
        Bin.SETRANGE("BC6_Sales Order Not Shipped", false);
        Bin.SETRANGE("BC6_To Make Available", true);
        if Bin.FINDFIRST() then
            BinCod := Bin.Code;
    end;

    procedure BinLookUp2(LocationCode: Code[10]; BinCod: Code[10]): Code[20]; // related to codeunit 7302
    var
        Bin: Record Bin;
    begin
        Bin.SETRANGE("Location Code", LocationCode);
        if BinCod <> '' then
            if Bin.GET(LocationCode, BinCod) then;

        if PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK then
            exit(Bin.Code);
    end;



    // related to codeunit 73020
    procedure InsertTempWhseJnlLine2(ItemJnlLine: Record "Item Journal Line"; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; RefDoc: Integer; SourceType2: Integer; SourceSubType2: Integer; SourceNo2: Code[20]; SourceLineNo2: Integer; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer);
    var
        WhseEntry: Record "Warehouse Entry";
        WhseMgt: Codeunit "Whse. Management";
        WMSMgmt: Codeunit "WMS Management";
    begin
        with ItemJnlLine do begin

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
            if WhseEntry.FIND('-') then
                repeat
                    TempWhseJnlLine.INIT();
                    if WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Positive Adjmt." then
                        "Entry Type" := "Entry Type"::"Negative Adjmt."
                    else
                        "Entry Type" := "Entry Type"::"Positive Adjmt.";
                    Quantity := ABS(WhseEntry.Quantity);
                    "Quantity (Base)" := ABS(WhseEntry."Qty. (Base)");
                    WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 0, TempWhseJnlLine, false);
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
                    if "Entry Type" = "Entry Type"::"Negative Adjmt." then begin
                        TempWhseJnlLine."From Zone Code" := TempWhseJnlLine."Zone Code";
                        TempWhseJnlLine."From Bin Code" := TempWhseJnlLine."Bin Code";
                    end else begin
                        TempWhseJnlLine."To Zone Code" := TempWhseJnlLine."Zone Code";
                        TempWhseJnlLine."To Bin Code" := TempWhseJnlLine."Bin Code";
                    end;
                    TempWhseJnlLine.INSERT();
                    NextLineNo := TempWhseJnlLine."Line No." + 10000;
                until WhseEntry.NEXT() = 0;
        end;
    end;

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
    procedure SetPostingDate(NewPostingDate: Date);
    begin
        PostingDate := NewPostingDate;
    end;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    procedure VerifTierPayeur(OptLAccountType: Enum "Gen. Journal Account Type"; CodLNoTiers: Code[20]; CodLAppliesID: Code[20]): Boolean;
    var
        RecLCustLedEntry: Record "Cust. Ledger Entry";
        RecLVendLedEntry: Record "Vendor Ledger Entry";
    begin
        case OptLAccountType of
            OptLAccountType::Customer:
                begin
                    RecLCustLedEntry.RESET();
                    RecLCustLedEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive, "Due Date");
                    RecLCustLedEntry.SETRANGE("BC6_Pay-to Customer No.", CodLNoTiers);
                    RecLCustLedEntry.SETRANGE(Open, true);
                    RecLCustLedEntry.SETFILTER("Customer No.", '<>%1', CodLNoTiers);
                    RecLCustLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    if RecLCustLedEntry.FINDFIRST() then
                        exit(true)
                    else
                        exit(false);
                end;
            OptLAccountType::Vendor:
                begin
                    RecLVendLedEntry.RESET();
                    RecLVendLedEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive, "Due Date");
                    RecLVendLedEntry.SETRANGE("BC6_Pay-to Vend. No.", CodLNoTiers);
                    RecLVendLedEntry.SETRANGE(Open, true);
                    RecLVendLedEntry.SETFILTER("Vendor No.", '<>%1', CodLNoTiers);
                    RecLVendLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    if RecLVendLedEntry.FINDFIRST() then
                        exit(true)
                    else
                        exit(false);
                end;
        end;
    end;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    procedure CreateEntryTierPayeurCustomer(RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]);
    var
        RecLCustLedEntry: Record "Cust. Ledger Entry";
        RecLInvPostingBufferCopy: array[2] of Record "Payment Post. Buffer";
        TierPayeurCree: Code[20];
        i: Integer;
    begin
        //Creation des ecritures pour la partie CLIENT

        TierPayeurCree := '';
        i := 0;
        RecLCustLedEntry.RESET();
        RecLCustLedEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", "Applies-to ID", "Customer No.");
        RecLCustLedEntry.SETRANGE("BC6_Pay-to Customer No.", RecLInvPostingBuffer."Account No.");
        RecLCustLedEntry.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLCustLedEntry.SETFILTER("Customer No.", '<>%1', RecLInvPostingBuffer."Account No.");
        if RecLCustLedEntry.FINDSET(false, false) then
            repeat
                if TierPayeurCree <> RecLCustLedEntry."Customer No." then
                    GenereEntryTierPayeurCustomer(RecLCustLedEntry, RecLInvPostingBuffer, StepLedgerDescription, i);
                i += 1;
                TierPayeurCree := RecLCustLedEntry."Customer No.";
            until RecLCustLedEntry.NEXT() = 0;
    end;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    procedure GenereEntryTierPayeurCustomer(RecLCustLedEntry: Record "Cust. Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        RecLCustLedEntry2: Record "Cust. Ledger Entry";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
    begin
        RecLCustLedEntry2.RESET();
        RecLCustLedEntry2.SETCURRENTKEY("BC6_Pay-to Customer No.", "Applies-to ID", "Customer No.");
        RecLCustLedEntry2.SETRANGE("BC6_Pay-to Customer No.", RecLInvPostingBuffer."Account No.");
        RecLCustLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLCustLedEntry2.SETFILTER("Customer No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLCustLedEntry2.SETRANGE("Customer No.", RecLCustLedEntry."Customer No.");
        if RecLCustLedEntry2.FINDSET(false, false) then
            repeat
                AmountTot += RecLCustLedEntry2."Amount to Apply";
            until RecLCustLedEntry2.NEXT() = 0;

        if RecLInvPostingBuffer."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.GET(RecLInvPostingBuffer."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;

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
    end;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    procedure CreateEntryTierPayeurVendor(RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]);
    var
        RecLInvPostingBufferCopy: array[2] of Record "Payment Post. Buffer";
        RecLVendLedEntry: Record "Vendor Ledger Entry";
        TierPayeurCree: Code[20];
        i: Integer;
    begin
        //Creation des ecritures pour la partie FOURNISSEUR

        TierPayeurCree := '';
        i := 0;
        RecLVendLedEntry.RESET();
        RecLVendLedEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.");
        RecLVendLedEntry.SETRANGE("BC6_Pay-to Vend. No.", RecLInvPostingBuffer."Account No.");
        RecLVendLedEntry.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLVendLedEntry.SETFILTER("Vendor No.", '<>%1', RecLInvPostingBuffer."Account No.");
        if RecLVendLedEntry.FINDSET(false, false) then
            repeat
                if TierPayeurCree <> RecLVendLedEntry."Vendor No." then
                    GenereEntryTierPayeurVendor(RecLVendLedEntry, RecLInvPostingBuffer, StepLedgerDescription, i);
                i += 1;
                TierPayeurCree := RecLVendLedEntry."Vendor No.";
            until RecLVendLedEntry.NEXT() = 0;
    end;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    procedure GenereEntryTierPayeurVendor(RecLVendLedEntry: Record "Vendor Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        RecLVendLedEntry2: Record "Vendor Ledger Entry";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
    begin
        RecLVendLedEntry2.RESET();
        RecLVendLedEntry2.SETCURRENTKEY("BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.");
        RecLVendLedEntry2.SETRANGE("BC6_Pay-to Vend. No.", RecLInvPostingBuffer."Account No.");
        RecLVendLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLVendLedEntry2.SETFILTER("Vendor No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLVendLedEntry2.SETRANGE("Vendor No.", RecLVendLedEntry."Vendor No.");
        if RecLVendLedEntry2.FINDSET(false, false) then
            repeat
                AmountTot += RecLVendLedEntry2."Amount to Apply";
            until RecLVendLedEntry2.NEXT() = 0;

        if RecLInvPostingBuffer."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.GET(RecLInvPostingBuffer."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;

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
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure GetHideValidationDialog(): Boolean;
    begin
        exit(HideValidationDialog);
    end;

    procedure CheckReturnOrderMandatoryFields(PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine: Record "Purchase Line";
    begin
        with PurchaseHeader do begin
            if ("Document Type" = "Document Type"::"Return Order") then
                if "BC6_Return Order Type" = "BC6_Return Order Type"::SAV then begin

                    PurchaseLine.RESET();
                    PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    PurchaseLine.SETRANGE(PurchaseLine."Document Type", "Document Type");
                    PurchaseLine.SETRANGE(PurchaseLine.Type, PurchaseLine.Type::Item);
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", "No.");
                    if PurchaseLine.FINDFIRST() then
                        repeat
                            PurchaseLine.TESTFIELD("Return Reason Code");
                            PurchaseLine.TESTFIELD("BC6_Solution Code");
                            PurchaseLine.TESTFIELD("BC6_Return Comment");
                        until PurchaseLine.NEXT() = 0;
                end;
        end;
    end;

    procedure CheckReturnOrderMandatoryFields(P_SalesHeader: Record "Sales Header");
    var
        L_SalesLine: Record "Sales Line";
    begin
        with P_SalesHeader do begin
            if ("Document Type" = "Document Type"::"Return Order") then
                if "BC6_Return Order Type" = "BC6_Return Order Type"::SAV then begin
                    L_SalesLine.RESET();
                    L_SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    L_SalesLine.SETRANGE(L_SalesLine."Document Type", "Document Type");
                    L_SalesLine.SETRANGE(L_SalesLine.Type, L_SalesLine.Type::Item);
                    L_SalesLine.SETRANGE(L_SalesLine."Document No.", "No.");
                    if L_SalesLine.FINDFIRST() then
                        repeat
                            L_SalesLine.TESTFIELD("Return Reason Code");
                            L_SalesLine.TESTFIELD("BC6_Solution Code");
                            L_SalesLine.TESTFIELD("BC6_Return Comment");
                        until L_SalesLine.NEXT() = 0;
                end;
        end;
    end;

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
        UseInTransitLocationErr: label 'You can use In-Transit location %1 for transfer orders only.';
    begin
        if Location.IsInTransit(LocationCode) then
            Error(ErrorInfo.Create(StrSubstNo(UseInTransitLocationErr, LocationCode), true));
    end;

    //COD80
    procedure IncrementDEEE(var Nombre: Decimal; Nombre2: Decimal);
    begin
        Nombre := Nombre + Nombre2;
    end;

    procedure xUpdateShipmentInvoiced(RecPSalesInvoiceHeader: Record "Sales Invoice Header");
    var
        RecLShipmentInvoiced: Record "Shipment Invoiced";
        TxtLShipmentInvoiced: Text[250];
    begin
        RecLShipmentInvoiced.RESET();
        RecLShipmentInvoiced.SETRANGE(RecLShipmentInvoiced."Invoice No.", RecPSalesInvoiceHeader."No.");
        if RecLShipmentInvoiced.FIND('-') then begin
            TxtLShipmentInvoiced := '';
            repeat
                if STRLEN(TxtLShipmentInvoiced) <= 229 then
                    if STRPOS(TxtLShipmentInvoiced, RecLShipmentInvoiced."Shipment No.") = 0 then
                        TxtLShipmentInvoiced := TxtLShipmentInvoiced + RecLShipmentInvoiced."Shipment No." + '-';
            until RecLShipmentInvoiced.NEXT() = 0;
            RecPSalesInvoiceHeader."BC6_Shipment Invoiced" := COPYSTR(TxtLShipmentInvoiced, 1, STRLEN(TxtLShipmentInvoiced) - 1);
            RecPSalesInvoiceHeader.MODIFY();
        end;
    end;

    procedure Increment(var Number: Decimal; Number2: Decimal) //PROC dupliquée de COD80
    begin
        Number := Number + Number2;
    end;

    procedure SetIncrPurchCost(Value: Boolean);
    begin
        EnableIncrPurchCost := Value;
    end;

    procedure "**NSC1.01**"();
    begin
    end;

    procedure CalcProfit(var SalesHeader: Record "Sales Header");
    var
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        rec_Order: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        SalesPost: Codeunit "Sales-Post";
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        SubformIsEditable: Boolean;
        SubformIsReady: Boolean;
        PrevNo: Code[20];
        CreditLimitLCYExpendedPct: Decimal;
        DecLTotalAdjCostLCY: Decimal;
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        ActiveTab: Option General,Invoicing,Shipping;
        PrevTab: Option General,Invoicing,Shipping;
        VATAmountText: array[3] of Text[30];
    begin
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

        if SalesHeader."Prices Including VAT" then begin
            TotalAmount2[3] := TotalSalesLine[3].Amount;
            TotalAmount1[3] := TotalAmount2[3] + VATAmount[3];
            TotalSalesLine[3]."Line Amount" := TotalAmount1[3] + TotalSalesLine[3]."Inv. Discount Amount";
        end else begin
            TotalAmount1[3] := TotalSalesLine[3].Amount;
            TotalAmount2[3] := TotalSalesLine[3]."Amount Including VAT";
        end;

        TempVATAmountLine3.MODIFYALL(Modified, false);
        SalesHeader."BC6_Sales LCY" := TotalSalesLineLCY[3].Amount;
        SalesHeader."BC6_Profit LCY" := ProfitLCY[3];
        SalesHeader."BC6_% Profit" := ProfitPct[3];
        SalesHeader.MODIFY()
    end;

    //COD82
    procedure CalcProfit2(var SalesHeader: Record "Sales Header");
    var
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        rec_Order: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        SalesPost: Codeunit "Sales-Post";
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        SubformIsEditable: Boolean;
        SubformIsReady: Boolean;
        PrevNo: Code[20];
        CreditLimitLCYExpendedPct: Decimal;
        DecLTotalAdjCostLCY: Decimal;
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        ActiveTab: OPTION General,Invoicing,Shipping;
        PrevTab: OPTION General,Invoicing,Shipping;
        VATAmountText: array[3] of Text[30];
    begin

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

        if SalesHeader."Prices Including VAT" then begin
            TotalAmount2[3] := TotalSalesLine[3].Amount;
            TotalAmount1[3] := TotalAmount2[3] + VATAmount[3];
            TotalSalesLine[3]."Line Amount" := TotalAmount1[3] + TotalSalesLine[3]."Inv. Discount Amount";
        end else begin
            TotalAmount1[3] := TotalSalesLine[3].Amount;
            TotalAmount2[3] := TotalSalesLine[3]."Amount Including VAT";
        end;

        TempVATAmountLine3.MODIFYALL(Modified, false);
        SalesHeader."BC6_Sales LCY" := TotalSalesLineLCY[3].Amount;
        SalesHeader."BC6_Profit LCY" := ProfitLCY[3];
        SalesHeader."BC6_% Profit" := ProfitPct[3];
        SalesHeader.MODIFY()
    end;

    //COD86
    procedure UpdatePurchasedoc(var SalesOrderLine: Record "Sales Line"; SalesQuoteLine: Record "Sales Line");
    var
        RecLPurchLine: Record "Purchase Line";
    begin
        RecLPurchLine.RESET();
        //>> MODIF HL 22/10/2012 SU-LALE cf appel TI127191
        RecLPurchLine.SETCURRENTKEY("BC6_Sales Document Type", "BC6_Sales Line No.", "BC6_Sales No.");
        //<< MODIF HL 22/10/2012 SU-LALE cf appel TI127191
        RecLPurchLine.SETFILTER("BC6_Sales Document Type", '%1', SalesQuoteLine."Document Type");
        RecLPurchLine.SETFILTER("BC6_Sales Line No.", '%1', SalesQuoteLine."Line No.");
        RecLPurchLine.SETFILTER("BC6_Sales No.", SalesQuoteLine."Document No.");
        if RecLPurchLine.FIND('-') then
            repeat
                RecLPurchLine."BC6_Sales No." := SalesOrderLine."Document No.";
                RecLPurchLine."BC6_Sales Line No." := SalesOrderLine."Line No.";
                RecLPurchLine."BC6_Sales Document Type" := SalesOrderLine."Document Type";
                RecLPurchLine.MODIFY(true);
            until RecLPurchLine.NEXT() = 0;
    end;

    //TODO : procedure CreateInvtPutAwayPick STD j'ai pas trouver des event pour inserer mon code donc j la dupliquer en+ la fct est utilisée juste dans des pages
    procedure CreateInvtPutAwayPick();
    var
        PurchHeader: Record "Purchase Header";
        WhseRequest: Record "Warehouse Request";
        RepLCreateInvtPutPickMvmt: Report "Create Invt Put-away/Pick/Mvmt";
    begin
        PurchHeader.get();
        PurchHeader.TESTFIELD(Status, "Purchase Document Status"::Released);
        WhseRequest.RESET();
        WhseRequest.SETCURRENTKEY("Source Document", "Source No.");
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order:
                WhseRequest.SETRANGE("Source Document", WhseRequest."Source Document"::"Purchase Order");
            PurchHeader."Document Type"::"Return Order":
                WhseRequest.SETRANGE("Source Document", WhseRequest."Source Document"::"Purchase Return Order");
        end;
        WhseRequest.SETRANGE("Source No.", PurchHeader."No.");
        RepLCreateInvtPutPickMvmt.SETTABLEVIEW(WhseRequest);
        RepLCreateInvtPutPickMvmt.InitializeRequest(true, false, false, true, false);
        RepLCreateInvtPutPickMvmt.RUN();
    end;

    //TODO: //fct du std , j la dupliquer et effacer le reste du code qui ne sert a rien , cette fct est utilisé juste ds les pages on peut apres passer la valeur true simplement sans avoir besoin a cette fct
    procedure ConfirmCloseUnposted(): Boolean;
    begin
        exit(true);
    end;

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

    procedure SetYourReference(_YourRef: Text);
    begin
        YourReference := _YourRef;
    end;

    procedure FindVeryBestPrice(var RecLSalesLine: Record "Sales Line"; RecLSalesHeader: Record "Sales Header");
    var
        Item: Record Item;
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        BestDiscount: Decimal;
        BestPrice: Decimal;
        ItemUnitPrice: Decimal;
        ItemUnitPriceBestDiscount: Decimal;
    begin
        with RecLSalesLine do begin
            if RecLSalesLine.Type = Type::Item then begin

                PriceCalcMgt.SetCurrency(
                  RecLSalesHeader."Currency Code", RecLSalesHeader."Currency Factor", PriceCalcMgt.SalesHeaderExchDate(RecLSalesHeader));
                PriceCalcMgt.SetVAT(RecLSalesHeader."Prices Including VAT", "VAT %", "VAT Calculation Type".AsInteger(), "VAT Bus. Posting Group");
                PriceCalcMgt.SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
                PriceCalcMgt.SetLineDisc("Line Discount %", "Allow Line Disc.", "Allow Invoice Disc.");

                //Prix unitaire
                Item.RESET();
                Item.GET(RecLSalesLine."No.");
                ItemUnitPrice := Item."Unit Price";
                if RecLSalesHeader."Prices Including VAT" then
                    ItemUnitPrice := ItemUnitPrice * (1 + RecLSalesLine."VAT %" / 100);

                //Meilleur remise
                if PriceCalcMgt.SalesLineLineDiscExists(RecLSalesHeader, RecLSalesLine, false) then begin
                    // PriceCalcMgt.CalcBestLineDisc(TempSalesLineDisc); TODO:
                    // BestDiscount := TempSalesLineDisc."Line Discount %"; TODO:
                end else begin
                    BestDiscount := 0;
                end;

                //Meilleur prix
                if PriceCalcMgt.SalesLinePriceExists(RecLSalesHeader, RecLSalesLine, false) then begin
                    // PriceCalcMgt.CalcBestUnitPrice(TempSalesPrice); TODO:
                    // BestPrice := TempSalesPrice."Unit Price" ; TODO:
                end else begin
                    BestPrice := 0;
                end;

                ItemUnitPriceBestDiscount := (ItemUnitPrice * (1 - BestDiscount / 100));

                if (BestPrice <> 0) then begin
                    if (ItemUnitPriceBestDiscount < BestPrice) then begin
                        RecLSalesLine."Unit Price" := ItemUnitPrice;
                        RecLSalesLine."Line Discount %" := BestDiscount;
                        RecLSalesLine."Allow Line Disc." := true;
                        RecLSalesLine."Allow Invoice Disc." := true;
                    end else begin
                        RecLSalesLine."Unit Price" := BestPrice;
                        RecLSalesLine."Line Discount %" := 0;
                        RecLSalesLine."Allow Line Disc." := false;
                        RecLSalesLine."Allow Invoice Disc." := true;
                    end;
                end else begin
                    RecLSalesLine."Unit Price" := ItemUnitPrice;
                    RecLSalesLine."Line Discount %" := BestDiscount;
                    RecLSalesLine."Allow Line Disc." := true;
                    RecLSalesLine."Allow Invoice Disc." := true;
                end;
                PriceCalcMgt.ConvertPriceLCYToFCY('', RecLSalesLine."Unit Price");
            end;
        end;
    end;

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
    //COD90
    procedure MntDivisionDEEE(DecPQtyPurchLine: Decimal; var PurchLine: Record "Purchase Line"); //COD90
    var
        GLSetup: Record "General Ledger Setup";
    begin
        with PurchLine do begin
            "BC6_DEEE HT Amount" := ROUND("BC6_DEEE HT Amount" * DecPQtyPurchLine / Quantity, 0.01);
            if ("VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax") and
               (Quantity <> "Qty. to Invoice") and
               GLSetup."BC6_Sales Tax Recalcul"
            then
                "BC6_DEEE TTC Amount" :=
                  "BC6_DEEE HT Amount" + 0
            else
                "BC6_DEEE TTC Amount" := ROUND("BC6_DEEE TTC Amount" * DecPQtyPurchLine / Quantity);
            "BC6_DEEE VAT Amount" := "BC6_DEEE TTC Amount" - "BC6_DEEE HT Amount";
        end;
    end;

    //COD6620
    procedure RecalculateSalesLineAmounts2(FromSalesLine: Record "Sales Line"; var ToSalesLine: Record "Sales Line"; Currency: Record Currency)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        ToSalesLine.Validate("Unit Price", FromSalesLine."Unit Price");
        ToSalesLine.Validate("Line Discount %", FromSalesLine."Line Discount %");
        ToSalesLine.Validate(
            "Line Discount Amount",
            Round(FromSalesLine."Line Discount Amount", Currency."Amount Rounding Precision"));
        ToSalesLine.Validate(
            "Inv. Discount Amount",
            Round(FromSalesLine."Inv. Discount Amount", Currency."Amount Rounding Precision"));
    end;

    procedure InitShipmentDateInLine2(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        if SalesHeader."Shipment Date" <> 0D then
            SalesLine."Shipment Date" := SalesHeader."Shipment Date"
        else
            SalesLine."Shipment Date" := WorkDate;
    end;



    procedure GetLastToSalesLineNo(ToSalesHeader: Record "Sales Header"): Decimal
    var
        ToSalesLine: Record "Sales Line";
    begin
        ToSalesLine.LockTable();
        ToSalesLine.SetRange("Document Type", ToSalesHeader."Document Type");
        ToSalesLine.SetRange("Document No.", ToSalesHeader."No.");
        if ToSalesLine.FindLast() then
            exit(ToSalesLine."Line No.");
        exit(0);
    end;

    procedure Fct_SetProperties(NewCopyLinesExactly: Boolean);
    begin
        BoolGCopyLinesExactly := NewCopyLinesExactly;
    end;

    procedure InsertOldOrders(FromSalesInvoiceLine: Record "Sales Invoice Line"; ToSalesHeader: Record "Sales Header"; var NextLineNo: Integer);
    begin
        if (ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::"Return Order") and (ToSalesHeader."BC6_Return Order Type" = ToSalesHeader."BC6_Return Order Type"::SAV) then begin
            NextLineNoNewInsert := NextLineNo;
            InsertSalesAndPurOrderShptLine(FromSalesInvoiceLine, ToSalesHeader, NextLineNoNewInsert);
            NextLineNo := NextLineNo + 10000;
        end;
    end;

    procedure InsertSalesAndPurOrderShptLine(FromSalesInvoiceLine: Record "Sales Invoice Line"; ToSalesHeader: Record "Sales Header"; var NextLineNo: Integer);
    var
        L_ShipmentInvoiced: Record "Shipment Invoiced";
        L_SalesShptHeader: Record "Sales Shipment Header";
        L_SalesHeader: Record "Sales Header";
        L_PurchaseHeader: Record "Purchase Header";
        ToSalesLine2: Record "Sales Line";
        LanguageManagement: Codeunit Language;
        Text018: label '%1 - %2:';
    begin
        L_ShipmentInvoiced.RESET;
        L_ShipmentInvoiced.SETCURRENTKEY("Invoice No.", "Invoice Line No.", "Shipment No.", "Shipment Line No.");
        L_ShipmentInvoiced.SETRANGE("Invoice No.", FromSalesInvoiceLine."Document No.");
        L_ShipmentInvoiced.SETRANGE("Invoice Line No.", FromSalesInvoiceLine."Line No.");
        if L_ShipmentInvoiced.FINDFIRST then
            if L_SalesShptHeader.GET(L_ShipmentInvoiced."Shipment No.") then
                if L_SalesHeader.GET(L_SalesHeader."Document Type"::Order, L_SalesShptHeader."Order No.") then begin
                    SalesOrderExists := true;
                    if L_PurchaseHeader.GET(L_PurchaseHeader."Document Type"::Order, L_SalesHeader."BC6_Purchase No. Order Lien") then;
                    PurchaseOrderExists := true;
                end;

        G_LinkedPurchOrderNo := L_SalesShptHeader."Order No.";

        if SalesOrderExists then begin
            NextLineNo := NextLineNo + 10000;
            ToSalesLine2.INIT;
            ToSalesLine2."Line No." := NextLineNo;
            ToSalesLine2."Document Type" := ToSalesHeader."Document Type";
            ToSalesLine2."Document No." := ToSalesHeader."No.";

            //TODO   // LanguageManagement.SetGlobalLanguageByCode(ToSalesHeader."Language Code");

            if PurchaseOrderExists then
                ToSalesLine2.Description :=
                STRSUBSTNO(
                  Text018,
                  COPYSTR(SELECTSTR(1, Text50000) + L_SalesShptHeader."Order No.", 1, 23),
                  COPYSTR(SELECTSTR(2, Text50000) + L_SalesHeader."BC6_Purchase No. Order Lien", 1, 23))
            else
                ToSalesLine2.Description :=
                STRSUBSTNO(
                  Text50001,
                  COPYSTR(SELECTSTR(1, Text50000) + L_SalesShptHeader."Order No.", 1, 23));

            //TODO     // LanguageManagement.RestoreGlobalLanguage;

            ToSalesLine2.INSERT;
        end;
    end;

    procedure SetSkipTestCreditLimit(NewSkipTestCreditLimit: Boolean);
    var
        SkipTestCreditLimit: Boolean;
    begin
        SkipTestCreditLimit := NewSkipTestCreditLimit;
    end;




    procedure MntInverseDEEE(var RecLPurchLine: Record "Purchase Line");
    begin

        with RecLPurchLine do begin
            "BC6_DEEE HT Amount" := -"BC6_DEEE HT Amount";
            "BC6_DEEE VAT Amount" := -"BC6_DEEE VAT Amount";
            "BC6_DEEE TTC Amount" := -"BC6_DEEE TTC Amount";
        end;
    end;

    PROCEDURE MntIncrDEEE(VAR RecLPurchLine: Record "Purchase Line");
    var
        GloablFunction: codeunit "BC6_GlobalFunctionMgt";
        DecMntTTCDEEE: decimal;
        GDecMntHTDEEE: Decimal;

    BEGIN
        GloablFunction.SetGDecMntTTCDEEE(DecMntTTCDEEE + RecLPurchLine."BC6_DEEE TTC Amount");
      GloablFunction.SetGDecMntHTDEEE(GDecMntHTDEEE+RecLPurchLine."BC6_DEEE HT Amount");

    END;

    procedure UpdateInvoicePostBuffer(var InvoicePostBuffer: Record "Invoice Post. Buffer"; TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary)
    var
        FALineNo: Integer;
        DeferralLineNo: Integer;
        InvDefLineNo: Integer;

    begin
        InvoicePostBuffer.get(InvoicePostBuffer.Type, InvoicePostBuffer."G/L Account", InvoicePostBuffer."Gen. Bus. Posting Group", InvoicePostBuffer."Gen. Prod. Posting Group", InvoicePostBuffer."VAT Bus. Posting Group", InvoicePostBuffer."VAT Prod. Posting Group", InvoicePostBuffer."Tax Area Code", InvoicePostBuffer."Tax Group Code", InvoicePostBuffer."Tax Liable", InvoicePostBuffer."Use Tax", InvoicePostBuffer."Dimension Set ID", InvoicePostBuffer."Job No.", InvoicePostBuffer."Fixed Asset Line No.", InvoicePostBuffer."Deferral Code");
        if InvoicePostBuffer.Type = InvoicePostBuffer.Type::"Fixed Asset" then begin
            FALineNo := FALineNo + 1;
            InvoicePostBuffer."Fixed Asset Line No." := FALineNo;
        end;
        TempInvoicePostBuffer.Update(InvoicePostBuffer, InvDefLineNo, DeferralLineNo);
    end;


    procedure OnRunTiersPayeur(var Rec: Record "Payment Line");
    var
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
        Text001: label 'The %1 in the %2 will be changed from %3 to %4.\', Comment = 'FRA="Remplacement de %1 %3 par %4 dans %2.\"';
        Text002: label 'Do you wish to continue?', Comment = 'FRA="Souhaitez-vous continuer ?"';
        Text003: label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
        Text005: label 'The %1 or %2 must be Customer or Vendor.', Comment = 'FRA="%1 ou %2 doit être un client ou un fournisseur."';
        Text006: label 'All entries in one application must be in the same currency.', Comment = 'FRA="La même devise doit être utilisée pour toutes les écritures lettrage."';
        Text007: label 'All entries in one application must be in the same currency or one or more of the EMU currencies.', Comment = 'FRA="Toutes les écritures d''une même application doivent être indiquées dans la même devise ou dans une ou plusieurs devises UME. "';
    begin
        Header.GET(Rec."No.");

        GenJnlLine."Account Type" := Rec."Account Type";
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Amount := Rec.Amount;
        GenJnlLine."Amount (LCY)" := Rec."Amount (LCY)";
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine."Posting Date" := Header."Posting Date";

        with GenJnlLine do begin
            PayApply.GetCurrency;
            AccType := "Account Type";
            AccNo := "Account No.";

            case AccType of
                AccType::Customer:
                    begin
                        CustLedgEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("BC6_Pay-to Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, true);
                        if "Applies-to ID" = '' then
                            "Applies-to ID" := Rec."No." + '/' + FORMAT(Rec."Line No.");
                        ApplyCustEntries.SetGenJnlLine(GenJnlLine, GenJnlLine.FIELDNO("Applies-to ID"));
                        ApplyCustEntries.SETRECORD(CustLedgEntry);
                        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
                        ApplyCustEntries.LOOKUPMODE(true);
                        OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyCustEntries);
                        if not OK then
                            exit;
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("BC6_Pay-to Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, true);
                        CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        if CustLedgEntry.FIND('-') then begin
                            CurrencyCode2 := CustLedgEntry."Currency Code";
                            if Amount = 0 then begin
                                repeat
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
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
                                    if (CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice) and
                                       ("Posting Date" <= CustLedgEntry."Pmt. Discount Date")
                                    then
                                        Amount := Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                    else
                                        Amount := Amount - CustLedgEntry."Amount to Apply";
                                until CustLedgEntry.NEXT = 0;
                                "Amount (LCY)" := Amount;
                                "Currency Factor" := 1;
                                if ("Bal. Account Type" = "Bal. Account Type"::Customer) or
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                then begin
                                    Amount := -Amount;
                                    "Amount (LCY)" := -"Amount (LCY)";
                                end;
                                VALIDATE(Amount);
                                VALIDATE("Amount (LCY)");
                            end else
                                repeat
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                                until CustLedgEntry.NEXT = 0;
                            if "Currency Code" <> CurrencyCode2 then
                                if Amount = 0 then begin
                                    if not
                                       CONFIRM(
                                         Text001 +
                                         Text002, true,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         CustLedgEntry."Currency Code")
                                    then
                                        ERROR(Text003);
                                    "Currency Code" := CustLedgEntry."Currency Code"
                                end else
                                    PayApply.CheckAgainstApplnCurrency("Currency Code", CustLedgEntry."Currency Code", AccType::Customer, true);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        end else
                            "Applies-to ID" := '';
                        "Due Date" := CustLedgEntry."Due Date";
                    end;
                AccType::Vendor:
                    begin
                        VendLedgEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive);
                        VendLedgEntry.SETRANGE("BC6_Pay-to Vend. No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, true);
                        "Applies-to ID" := GetAppliesToID("Applies-to ID", Rec);
                        ApplyVendEntries.SetGenJnlLine(GenJnlLine, GenJnlLine.FIELDNO("Applies-to ID"));
                        ApplyVendEntries.SETRECORD(VendLedgEntry);
                        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                        ApplyVendEntries.LOOKUPMODE(true);
                        OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyVendEntries);
                        if not OK then
                            exit;
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive);
                        VendLedgEntry.SETRANGE("BC6_Pay-to Vend. No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, true);
                        VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        if VendLedgEntry.FIND('-') then begin
                            CurrencyCode2 := VendLedgEntry."Currency Code";
                            if Amount = 0 then begin
                                repeat
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
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
                                    if (VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Invoice) and
                                       ("Posting Date" <= VendLedgEntry."Pmt. Discount Date")
                                    then
                                        Amount := Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                    else
                                        Amount := Amount - VendLedgEntry."Amount to Apply";
                                until VendLedgEntry.NEXT = 0;
                                "Amount (LCY)" := Amount;
                                "Currency Factor" := 1;
                                if ("Bal. Account Type" = "Bal. Account Type"::Customer) or
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                then begin
                                    Amount := -Amount;
                                    "Amount (LCY)" := -"Amount (LCY)";
                                end;
                                VALIDATE(Amount);
                                VALIDATE("Amount (LCY)");
                            end else
                                repeat
                                    PayApply.CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                                until VendLedgEntry.NEXT = 0;
                            if "Currency Code" <> CurrencyCode2 then
                                if Amount = 0 then begin
                                    if not
                                       CONFIRM(
                                         Text001 +
                                         Text002, true,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         VendLedgEntry."Currency Code")
                                    then
                                        ERROR(Text003);
                                    "Currency Code" := VendLedgEntry."Currency Code"
                                end else
                                    PayApply.CheckAgainstApplnCurrency("Currency Code", VendLedgEntry."Currency Code", AccType::Vendor, true);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        end else
                            "Applies-to ID" := '';
                        "Due Date" := VendLedgEntry."Due Date";
                    end;
                else
                    ERROR(
                      Text005,
                      FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));
            end;
        end;
        Rec."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
        Rec."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
        Rec."Applies-to ID" := GenJnlLine."Applies-to ID";
        Rec."Due Date" := GenJnlLine."Due Date";
        Rec.Amount := GenJnlLine.Amount;
        Rec."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        Rec.VALIDATE(Amount);
        Rec.VALIDATE("Amount (LCY)");
    end;

    procedure GetAppliesToID(AppliesToID: Code[50]; PaymentLine: Record "Payment Line"): Code[50]
    begin
        if AppliesToID = '' then
            AppliesToID := PaymentLine."No." + '/' + FORMAT(PaymentLine."Line No.");
        exit(AppliesToID);
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
            Item.SETRANGE("Drop Shipment Filter", false);
            exit(Item.CalcQtyAvailToPick(0));
        end;
    end;

    procedure CalcQtyOnPurchOrder(var SalesLine: Record "Sales Line"): Decimal;
    var
        Item: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromis: Codeunit "Available to Promise";
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
            Item.SETRANGE("Drop Shipment Filter", false);
            Item.CALCFIELDS("Qty. on Purch. Order");
            exit(Item."Qty. on Purch. Order");
        end;
    end;

    procedure LookupQtyOnPurchOrder(SalesLine: Record "Sales Line");
    var
        Item: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        PurchLine: Record "Purchase Line";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
    begin
        SalesLine.TESTFIELD(Type, SalesLine.Type::Item);
        SalesLine.TESTFIELD("No.");
        if SIPM.GetItem(SalesLine) then begin
            Item.RESET;
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Location Filter", SalesLine."Location Code");
            Item.SETRANGE("Drop Shipment Filter", false);

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
        end;
    end;

    procedure CalcCNEInventory(SalesLine: Record "Sales Line"): Decimal;
    var
        L_Item: Record Item;
    begin
        if COMPANYNAME <> 'CNE 2007' then
            L_Item.CHANGECOMPANY('CNE 2007');
        if not L_Item.READPERMISSION then
            exit(0);

        if L_Item.GET(SalesLine."No.") then
            L_Item.CALCFIELDS(Inventory);
        exit(L_Item.Inventory);
    end;

    procedure CalcCNEQtyOnPurchOrder(SalesLine: Record "Sales Line"): Decimal;
    var
        L_Item: Record Item;
    begin
        if COMPANYNAME <> 'CNE 2007' then
            L_Item.CHANGECOMPANY('CNE 2007');

        if not L_Item.READPERMISSION then
            exit(0);

        if L_Item.GET(SalesLine."No.") then
            L_Item.CALCFIELDS("Qty. on Purch. Order");
        exit(L_Item."Qty. on Purch. Order");
    end;

    procedure CalcAvailableInventoryCNE(SalesLine: Record "Sales Line"; var Item: Record Item): Decimal;
    var
        CopyOfItem: Record Item;
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
    begin
        //BCSYS 220321
        CopyOfItem.COPY(Item);
        if SalesLine.Type <> SalesLine.Type::Item then exit(0);
        if CopyOfItem.GET(CopyOfItem."No.") then begin
            //SetItemFilter(Item,SalesLine);
            Item.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Drop Shipment Filter", false);

            exit(ConvertQty(AvailableToPromise.CalcAvailableInventory(Item), SalesLine."Qty. per Unit of Measure"));
        end;
    end;

    procedure ConvertQty(Qty: Decimal; PerUoMQty: Decimal) Result: Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if PerUoMQty = 0 then
            PerUoMQty := 1;
        Result := Round(Qty / PerUoMQty, UOMMgt.QtyRndPrecision);
    end;

    procedure CalcAvailableInventoryMETZ(SalesLine: Record "Sales Line"; var Item: Record Item): Decimal;
    var
        CopyOfItem: Record Item;
        AvailableToPromise: Codeunit "Available to Promise";
        SIPM: Codeunit "Sales Info-Pane Management";
    begin
        CopyOfItem.COPY(Item);
        if SalesLine.Type <> SalesLine.Type::Item then exit(0);
        if CopyOfItem.GET(CopyOfItem."No.") then begin
            Item.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            Item.SETRANGE("Variant Filter", SalesLine."Variant Code");
            Item.SETRANGE("Drop Shipment Filter", false);

            exit(ConvertQty(AvailableToPromise.CalcAvailableInventory(Item), SalesLine."Qty. per Unit of Measure"));
        end;
    end;


    procedure CalcAvailabilityCNE(var SalesLine: Record "Sales Line"; var Item: Record Item): Decimal;
    var
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        LookaheadDateformula: DateFormula;
        CopyOfItem: Record Item;
    begin
        CopyOfItem.COPY(Item);
        if SalesLine.Type <> SalesLine.Type::Item then exit(0);
        if CopyOfItem.GET(CopyOfItem."No.") then begin
            CopyOfItem.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            CopyOfItem.SETRANGE("Variant Filter", SalesLine."Variant Code");
            CopyOfItem.SETRANGE("Drop Shipment Filter", false);

            exit(ConvertQty(AvailableToPromise.QtyAvailabletoPromise(CopyOfItem, GrossRequirement, ScheduledReceipt, SIPM.CalcAvailabilityDate(SalesLine), PeriodType, LookaheadDateformula), SalesLine."Qty. per Unit of Measure"));
        end;
    end;


    procedure CalcAvailabilityMETZ(var SalesLine: Record "Sales Line"; var Item: Record Item): Decimal;
    var
        SIPM: Codeunit "Sales Info-Pane Management";
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: enum "Analysis Period Type";
        LookaheadDateformula: DateFormula;
        CopyOfItem: Record Item;
    begin
        CopyOfItem.COPY(Item);
        if SalesLine.Type <> SalesLine.Type::Item then exit(0);
        if CopyOfItem.GET(CopyOfItem."No.") then begin
            CopyOfItem.SETRANGE("Date Filter", 0D, SIPM.CalcAvailabilityDate(SalesLine));
            CopyOfItem.SETRANGE("Variant Filter", SalesLine."Variant Code");
            CopyOfItem.SETRANGE("Drop Shipment Filter", false);

            exit(
            ConvertQty(AvailableToPromise.QtyAvailabletoPromise(CopyOfItem, GrossRequirement, ScheduledReceipt, SIPM.CalcAvailabilityDate(SalesLine), PeriodType, LookaheadDateformula), SalesLine."Qty. per Unit of Measure"));
        end;
    end;

    procedure FindPurchLineDisc(var ToPurchLineDisc: Record "Purchase Line Discount"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean; ItemDiscGrCode: Code[10])
    var
        FromPurchLineDisc: Record "Purchase Line Discount";
    begin
        with FromPurchLineDisc do begin
            SETRANGE("Item No.", ItemNo);
            SETRANGE("Vendor No.", VendorNo);
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            SETFILTER("Variant Code", '%1|%2', VariantCode, '');
            if not ShowAll then begin
                SETRANGE("Starting Date", 0D, StartingDate);
                SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
                SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            end;

            ToPurchLineDisc.RESET;
            ToPurchLineDisc.DELETEALL;
            for BC6_Type := BC6_Type::Item to BC6_Type::"All items" do begin
                if (BC6_Type = BC6_Type::"All items") or
                  ((BC6_Type = BC6_Type::Item) and (ItemNo <> '')) or
                  ((BC6_Type = BC6_Type::"Item Disc. Group") and (ItemDiscGrCode <> '')) then begin

                    SETRANGE(BC6_Type, BC6_Type);

                    case BC6_Type of
                        BC6_Type::"All items":
                            SETRANGE("Item No.");
                        BC6_Type::Item:
                            SETRANGE("Item No.", ItemNo);
                        BC6_Type::"Item Disc. Group":
                            SETRANGE("Item No.", ItemDiscGrCode);
                    end;
                    //Fin GESTION_REMISE FG 06/12/06 NSC1.01
                    //<<MIGRATION NAV 2013

                    if FIND('-') then
                        repeat
                            ToPurchLineDisc := FromPurchLineDisc;
                            ToPurchLineDisc.INSERT;
                        until NEXT = 0;
                end;
            end;
        end;
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
    procedure InsertSalesExtTextSpe(var SalesLine: Record "Sales Line");
    var
        ToSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        Item: Record Item;
        RecGTmpExtTexLineSpe: Record "BC6_Special Extended Text Line"; // TODO: check variable global utilisee dans une event codeunit 50201 BC6_EventsMgt
        BooGAutoTextSpe: Boolean; // TODO: check variable global pour test utilisee dans une event codeunit 50201 BC6_EventsMgt
        MakeUpdateRequired: Boolean; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        OKA: Boolean;
        NextLineNo: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        LineSpacing: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        Text000: label 'There is not enough space to insert extended text lines.', Comment = 'FRA="Il n''y a pas suffisamment de place pour ins‚rer des lignes texte ‚tendu."';
    begin
        OKA := false;

        if SalesLine.Type = SalesLine.Type::Item then
            OKA := true
        else
            exit;
        Item.GET(SalesLine."No.");
        OKA := Item."Automatic Ext. Texts";
        if BooGAutoTextSpe = true then begin

            SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
            RecGTmpExtTexLineSpe.RESET;

            RecGTmpExtTexLineSpe.SETRANGE("Table Name", RecGTmpExtTexLineSpe."Table Name"::Customer);
            RecGTmpExtTexLineSpe.SETRANGE(Code, SalesHeader."Bill-to Customer No.");
            RecGTmpExtTexLineSpe.SETRANGE("No.", SalesLine."No.");

            ToSalesLine.RESET;
            ToSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
            ToSalesLine.SETRANGE("Document No.", SalesLine."Document No.");

            ToSalesLine := SalesLine;

            if ToSalesLine.FIND('>') then begin
                LineSpacing :=
                   (ToSalesLine."Line No." - SalesLine."Line No.") div
                   (1 + RecGTmpExtTexLineSpe.COUNT);
                if LineSpacing = 0 then
                    ERROR(Text000);


            end else begin
                LineSpacing := 10000;
            end;


            NextLineNo := SalesLine."Line No." + LineSpacing;

            if RecGTmpExtTexLineSpe.FIND('-') then begin
                repeat
                    ToSalesLine.INIT;
                    ToSalesLine."Document Type" := SalesLine."Document Type";
                    ToSalesLine."Document No." := SalesLine."Document No.";
                    ToSalesLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToSalesLine.Description := RecGTmpExtTexLineSpe.Text;
                    ToSalesLine."Attached to Line No." := SalesLine."Line No.";
                    ToSalesLine.INSERT;
                until RecGTmpExtTexLineSpe.NEXT = 0;
                MakeUpdateRequired := true;
            end;
        end;
    end;


    // function specifique codeunit 378 "Transfer Extended Text"
    procedure InsertPurchExtTextSpe(var PurchLine: Record "Purchase Line");
    var
        ToPurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Item: Record Item;
        RecGTmpExtTexLineSpe: Record "BC6_Special Extended Text Line"; // TODO: check variable global utilisee dans une event codeunit 50201 BC6_EventsMgt
        BooGAutoTextSpe: Boolean; // TODO: check variable global pour test utilisee dans une event codeunit 50201 BC6_EventsMgt
        MakeUpdateRequired: Boolean; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        OKA: Boolean;
        NextLineNo: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
        LineSpacing: Integer; // TODO: check variable global dans la codeunit 378 "Transfer Extended Text"
    begin
        OKA := false;
        if PurchLine.Type = PurchLine.Type::Item then
            OKA := true
        else
            exit;

        Item.GET(PurchLine."No.");
        OKA := Item."Automatic Ext. Texts";


        if BooGAutoTextSpe = true then begin
            PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");

            RecGTmpExtTexLineSpe.RESET;

            RecGTmpExtTexLineSpe.SETRANGE("Table Name", RecGTmpExtTexLineSpe."Table Name"::Vendor);
            RecGTmpExtTexLineSpe.SETRANGE(Code, PurchHeader."Buy-from Vendor No.");
            RecGTmpExtTexLineSpe.SETRANGE("No.", PurchLine."No.");

            ToPurchLine.RESET;
            ToPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
            ToPurchLine.SETRANGE("Document No.", PurchLine."Document No.");

            ToPurchLine := PurchLine;
            if ToPurchLine.FIND('>') then begin
                LineSpacing :=
                   (ToPurchLine."Line No." - PurchLine."Line No.") div
                   (1 + RecGTmpExtTexLineSpe.COUNT);

            end else begin
                LineSpacing := 10000;
            end;

            NextLineNo := PurchLine."Line No." + LineSpacing;

            if RecGTmpExtTexLineSpe.FIND('-') then begin
                repeat
                    ToPurchLine.INIT;
                    ToPurchLine."Document Type" := PurchLine."Document Type";
                    ToPurchLine."Document No." := PurchLine."Document No.";
                    ToPurchLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToPurchLine.Description := RecGTmpExtTexLineSpe.Text;
                    ToPurchLine."Attached to Line No." := PurchLine."Line No.";
                    ToPurchLine.INSERT;
                until RecGTmpExtTexLineSpe.NEXT = 0;
                MakeUpdateRequired := true;
            end;
        end;
    end;
    // COD 7000
    procedure ActivatedCampaignExists(var ToCampaignTargetGr: Record "Campaign Target Group"; CustNo: Code[20]; ContNo: Code[20]; CampaignNo: Code[20]): Boolean;
    var
        FromCampaignTargetGr: Record "Campaign Target Group";
        Cont: Record Contact;
    begin
        with FromCampaignTargetGr do begin
            ToCampaignTargetGr.RESET;
            ToCampaignTargetGr.DELETEALL;

            if CampaignNo <> '' then begin
                ToCampaignTargetGr."Campaign No." := CampaignNo;
                ToCampaignTargetGr.INSERT;
            end else begin
                SETRANGE(Type, Type::Customer);
                SETRANGE("No.", CustNo);
                if FINDSET then
                    repeat
                        ToCampaignTargetGr := FromCampaignTargetGr;
                        ToCampaignTargetGr.INSERT;
                    until NEXT = 0
                else begin
                    if Cont.GET(ContNo) then begin
                        SETRANGE(Type, Type::Contact);
                        SETRANGE("No.", Cont."Company No.");
                        if FINDSET then
                            repeat
                                ToCampaignTargetGr := FromCampaignTargetGr;
                                ToCampaignTargetGr.INSERT;
                            until NEXT = 0;
                    end;
                end;
            end;
            exit(ToCampaignTargetGr.FINDFIRST);
        end;
    end;

    procedure CopySalesDiscToSalesDisc(var FromSalesLineDisc: Record "Sales Line Discount"; var ToSalesLineDisc: Record "Sales Line Discount");
    begin
        with ToSalesLineDisc do begin
            if FromSalesLineDisc.FINDSET then
                repeat
                    ToSalesLineDisc := FromSalesLineDisc;
                    INSERT;
                until FromSalesLineDisc.NEXT = 0;
        end;
    end;

    procedure FindSalesLineDisc(var ToSalesLineDisc: Record "Sales Line Discount"; CustNo: Code[20]; ContNo: Code[20]; CustDiscGrCode: Code[10]; CampaignNo: Code[20]; ItemNo: Code[20]; ItemDiscGrCode: Code[10]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean; VendorNo: Code[20]);

    var
        FromSalesLineDisc: Record "Sales Line Discount";
        SalesPriceCalMgt: codeunit "Sales Price Calc. Mgt.";
        TempCampaignTargetGr: Record "Campaign Target Group" temporary;
        InclCampaigns: Boolean;
    begin
        with FromSalesLineDisc do begin
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            SETFILTER("Variant Code", '%1|%2', VariantCode, '');
            if not ShowAll then begin
                SETRANGE("Starting Date", 0D, StartingDate);
                SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
                if UOM <> '' then
                    SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            end;

            ToSalesLineDisc.RESET;
            ToSalesLineDisc.DELETEALL;
            for "Sales Type" := "Sales Type"::Customer to "Sales Type"::Campaign do
                if ("Sales Type" = "Sales Type"::"All Customers") or
                   (("Sales Type" = "Sales Type"::Customer) and (CustNo <> '')) or
                   (("Sales Type" = "Sales Type"::"Customer Disc. Group") and (CustDiscGrCode <> '')) or
                   (("Sales Type" = "Sales Type"::Campaign) and
                    not ((CustNo = '') and (ContNo = '') and (CampaignNo = '')))
                then begin
                    InclCampaigns := false;

                    SETRANGE("Sales Type", "Sales Type");
                    case "Sales Type" of
                        "Sales Type"::"All Customers":
                            SETRANGE("Sales Code");
                        "Sales Type"::Customer:
                            SETRANGE("Sales Code", CustNo);
                        "Sales Type"::"Customer Disc. Group":
                            SETRANGE("Sales Code", CustDiscGrCode);
                        "Sales Type"::Campaign:
                            begin
                                InclCampaigns := ActivatedCampaignExists(TempCampaignTargetGr, CustNo, ContNo, CampaignNo);
                                SETRANGE("Sales Code", TempCampaignTargetGr."Campaign No.");
                            end;
                    end;

                    repeat
                        SETRANGE(Type, Type::Item);
                        SETRANGE(Code, ItemNo);
                        CopySalesDiscToSalesDisc(FromSalesLineDisc, ToSalesLineDisc);

                        if ItemDiscGrCode <> '' then begin
                            SETRANGE(Type, Type::"Item Disc. Group");
                            SETRANGE(Code, ItemDiscGrCode);
                            CopySalesDiscToSalesDisc(FromSalesLineDisc, ToSalesLineDisc);
                        end;

                        if VendorNo <> '' then begin
                            SETRANGE(Type, Type::Vendor);
                            SETRANGE(Code, VendorNo);
                            CopySalesDiscToSalesDisc(FromSalesLineDisc, ToSalesLineDisc);
                        end;

                        if InclCampaigns then begin
                            InclCampaigns := TempCampaignTargetGr.NEXT <> 0;
                            SETRANGE("Sales Code", TempCampaignTargetGr."Campaign No.");
                        end;
                    until not InclCampaigns;
                end;
        end;
    end;

    PROCEDURE GetItemEAN13Code(ItemNo: Code[20]) EAN13Code: Code[20];
    VAR
        ItemReference: Record "Item Reference";
        Item: record Item;
        CrossRefTypeNo: Code[20];
        InvSetup: Record "Inventory Setup";

    BEGIN
        EAN13Code := '';
        InvSetup.GET;
        IF InvSetup."BC6_Cross.Ref.Type No.BarCode" = '' THEN
            EXIT('');
        CrossRefTypeNo := InvSetup."BC6_Cross.Ref.Type No.BarCode";
        IF NOT Item.GET(ItemNo) THEN
            EXIT('');

        ItemReference.RESET;
        ItemReference.SETRANGE("Item No.", Item."No.");
        ItemReference.SETRANGE("Variant Code", '');
        ItemReference.SETRANGE("Unit of Measure", Item."Base Unit of Measure");
        ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
        ItemReference.SETRANGE("Reference Type No.", CrossRefTypeNo);
        ItemReference.SETRANGE("Discontinue Bar Code", FALSE);
        IF ItemReference.FINDFIRST THEN
            EAN13Code := ItemReference."Reference No.";

        EXIT(EAN13Code);
    END;

    PROCEDURE GetItem(EAN13Code: Code[20]) ItemNo: Code[20];
    var
        ItemReference: Record "Item Reference";
        Item: record Item;
        CrossRefTypeNo: Code[20];
        InvSetup: Record "Inventory Setup";

    BEGIN
        ItemNo := '';
        InvSetup.GET;
        IF InvSetup."BC6_Cross.Ref.Type No.BarCode" = '' THEN
            EXIT('');
        CrossRefTypeNo := InvSetup."BC6_Cross.Ref.Type No.BarCode";

        ItemReference.RESET;
        ItemReference.SETCURRENTKEY("Reference No.", "Reference Type", "Reference Type No.", "Discontinue Bar Code");
        ItemReference.SETRANGE("Reference No.", EAN13Code);
        ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
        ItemReference.SETRANGE("Reference Type No.", CrossRefTypeNo);
        ItemReference.SETRANGE("Variant Code", '');
        ItemReference.SETRANGE("Discontinue Bar Code", FALSE);
        IF ItemReference.FINDFIRST THEN
            REPEAT
                IF Item.GET(ItemReference."Item No.") THEN
                    IF Item.Blocked = FALSE THEN
                        ItemNo := ItemReference."Item No.";
            UNTIL ItemReference.NEXT = 0;

        Item.RESET;

        IF NOT Item.GET(ItemNo) THEN
            EXIT('');

        EXIT(ItemNo);
    END;

    PROCEDURE CreateItemEAN13Code(ItemNo: Code[20]; ShowMessage: Boolean) EAN13Code: Code[20];
    VAR
        ItemReference2: Record "Item Reference";
        SeriesNo: Code[20];
        Checksum: Integer;
        Item: record Item;
        CrossRefTypeNo: Code[20];
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CstG001: Label 'N° code-barres %1 erroné.';
        CstG002: Label 'Code-barres interne %1 ajouté comme référence externe.';

    BEGIN
        InvSetup.GET;
        InvSetup.TESTFIELD("BC6_Cross.Ref.Type No.BarCode");
        CrossRefTypeNo := InvSetup."BC6_Cross.Ref.Type No.BarCode";
        EAN13Code := '';
        IF NOT Item.GET(ItemNo) THEN
            EXIT('');

        IF GetItemEAN13Code(ItemNo) = '' THEN BEGIN

            InvSetup.TESTFIELD("BC6_Int. BarCode Nos");
            CLEAR(NoSeriesMgt);
            SeriesNo := '';
            NoSeriesMgt.InitSeries(InvSetup."BC6_Cross.Ref.Type No.BarCode", '', WORKDATE, EAN13Code, SeriesNo);
            IF STRLEN(EAN13Code) <> 12 THEN
                ERROR(CstG001, EAN13Code);
            Checksum := STRCHECKSUM(EAN13Code, '131313131313', 10);
            EAN13Code := EAN13Code + FORMAT(Checksum);

            ItemReference2.INIT;
            ItemReference2.VALIDATE("Item No.", Item."No.");
            ItemReference2.VALIDATE("Variant Code", '');
            ItemReference2.VALIDATE("Reference Type", ItemReference2."Reference Type"::"Bar Code");
            ItemReference2.VALIDATE("Reference Type No.", CrossRefTypeNo);
            ItemReference2."Reference No." := EAN13Code;
            ItemReference2.Description := Item.Description;
            ItemReference2.VALIDATE("Unit of Measure", Item."Base Unit of Measure");
            ItemReference2."BC6_Internal Bar Code" := TRUE;
            ItemReference2.INSERT;
            IF ShowMessage THEN
                MESSAGE(CstG002, EAN13Code);
        END;

        EXIT(EAN13Code);
    END;

    PROCEDURE LookupItemEAN13Code(ItemNo: Code[20]; EAN13Code: Code[20]);
    var
        ItemReference: Record "Item Reference";
        Item: record Item;
        CrossRefTypeNo: Code[20];
        InvSetup: Record "Inventory Setup";

    BEGIN

        EAN13Code := '';
        InvSetup.GET;
        IF InvSetup."BC6_Cross.Ref.Type No.BarCode" = '' THEN
            EXIT;

        CrossRefTypeNo := InvSetup."BC6_Cross.Ref.Type No.BarCode";
        IF NOT Item.GET(ItemNo) THEN
            EXIT;

        WITH ItemReference DO BEGIN
            RESET;
            SETRANGE("Item No.", Item."No.");
            SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
            SETRANGE("Reference Type No.", CrossRefTypeNo);
            IF NOT FINDFIRST THEN
                SETRANGE("Reference Type No.");
            IF PAGE.RUNMODAL(PAGE::"Item Reference List", ItemReference) = ACTION::LookupOK THEN;
        END;
    END;



    var
        EnableIncrPurchCost: Boolean;
        BoolGCopyLinesExactly: Boolean;
        NextLineNoNewInsert: Integer;
        SalesOrderExists: Boolean;
        PurchaseOrderExists: Boolean;
        Text50000: label 'Sales Oder No., Purch Order No.', comment = 'FRA="N° Cde vente.,N° Cde achat."';
        Text50001: label '%1:';
        G_LinkedPurchOrderNo: Code[20];
        IsSAVReturnOrder: Boolean;

        YourReference: Text; // related to SetYourReference function
}