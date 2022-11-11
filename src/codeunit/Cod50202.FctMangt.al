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
    // PROCEDURE CopyAndRenameClientFile(OldFilePath: Text; DirectoryPath: Text; NewSubDirectoryName: Text) NewFilePath: Text;
    // VAR
    //     directory: Text;
    //     NewFileName: Text;
    //     fileMgt: Codeunit "File Management";
    //     Text003: Label 'You must enter a file name.';
    //     Text1100267000: Label 'You must enter a file name.';
    //     Text1100267001: Label 'The directory %1 does not exist.';



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
                    RecLCustLedEntry.RESET;
                    RecLCustLedEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive, "Due Date");
                    RecLCustLedEntry.SETRANGE("BC6_Pay-to Customer No.", CodLNoTiers);
                    RecLCustLedEntry.SETRANGE(Open, TRUE);
                    RecLCustLedEntry.SETFILTER("Customer No.", '<>%1', CodLNoTiers);
                    RecLCustLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    IF RecLCustLedEntry.FINDFIRST THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
            OptLAccountType::Vendor:
                BEGIN
                    RecLVendLedEntry.RESET;
                    RecLVendLedEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive, "Due Date");
                    RecLVendLedEntry.SETRANGE("BC6_Pay-to Vend. No.", CodLNoTiers);
                    RecLVendLedEntry.SETRANGE(Open, TRUE);
                    RecLVendLedEntry.SETFILTER("Vendor No.", '<>%1', CodLNoTiers);
                    RecLVendLedEntry.SETFILTER("Applies-to ID", '%1*', CodLAppliesID);
                    IF RecLVendLedEntry.FINDFIRST THEN
                        EXIT(TRUE)
                    ELSE
                        EXIT(FALSE);
                END;
        END;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE CreateEntryTierPayeurCustomer(RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]);
    VAR
        RecLInvPostingBufferCopy: ARRAY[2] OF Record "Payment Post. Buffer";
        RecLCustLedEntry: Record "Cust. Ledger Entry";
        TierPayeurCree: Code[20];
        i: Integer;
    BEGIN
        //Creation des ecritures pour la partie CLIENT

        TierPayeurCree := '';
        i := 0;
        RecLCustLedEntry.RESET;
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
            UNTIL RecLCustLedEntry.NEXT = 0;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE GenereEntryTierPayeurCustomer(RecLCustLedEntry: Record "Cust. Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    VAR
        RecLCustLedEntry2: Record "Cust. Ledger Entry";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
    BEGIN
        RecLCustLedEntry2.RESET;
        RecLCustLedEntry2.SETCURRENTKEY("BC6_Pay-to Customer No.", "Applies-to ID", "Customer No.");
        RecLCustLedEntry2.SETRANGE("BC6_Pay-to Customer No.", RecLInvPostingBuffer."Account No.");
        RecLCustLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLCustLedEntry2.SETFILTER("Customer No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLCustLedEntry2.SETRANGE("Customer No.", RecLCustLedEntry."Customer No.");
        IF RecLCustLedEntry2.FINDSET(FALSE, FALSE) THEN
            REPEAT
                AmountTot += RecLCustLedEntry2."Amount to Apply";
            UNTIL RecLCustLedEntry2.NEXT = 0;

        IF RecLInvPostingBuffer."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
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

        RecLInvPostingBufferCopy.INIT;
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE("Account No.", RecLCustLedEntry."Customer No.");
        RecLInvPostingBufferCopy.VALIDATE(Amount, -AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", -AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLCustLedEntry."BC6_Pay-to Customer No.";
        RecLInvPostingBufferCopy.INSERT;

        RecLInvPostingBufferCopy.INIT;
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE(Amount, AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        Description2 :=
          STRSUBSTNO(StepLedgerDescription, RecLInvPostingBufferCopy."Due Date", RecLCustLedEntry."Customer No.", '');
        RecLInvPostingBufferCopy.Description := COPYSTR(Description2, 1, 50);
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLCustLedEntry."BC6_Pay-to Customer No.";
        RecLInvPostingBufferCopy.INSERT;
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
        RecLVendLedEntry.RESET;
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
            UNTIL RecLVendLedEntry.NEXT = 0;
    END;

    // TODO:  specific function related to codeunit 10860 "Payment Management"
    PROCEDURE GenereEntryTierPayeurVendor(RecLVendLedEntry: Record "Vendor Ledger Entry"; RecLInvPostingBuffer: Record "Payment Post. Buffer"; StepLedgerDescription: Text[50]; i: Integer);
    VAR
        RecLVendLedEntry2: Record "Vendor Ledger Entry";
        RecLInvPostingBufferCopy: Record "Payment Post. Buffer";
        AmountTot: Decimal;
        AmountTotDS: Decimal;
        Description2: Text[98];
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
    BEGIN
        RecLVendLedEntry2.RESET;
        RecLVendLedEntry2.SETCURRENTKEY("BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.");
        RecLVendLedEntry2.SETRANGE("BC6_Pay-to Vend. No.", RecLInvPostingBuffer."Account No.");
        RecLVendLedEntry2.SETRANGE("Applies-to ID", RecLInvPostingBuffer."Applies-to ID");
        RecLVendLedEntry2.SETFILTER("Vendor No.", '<>%1', RecLInvPostingBuffer."Account No.");

        RecLVendLedEntry2.SETRANGE("Vendor No.", RecLVendLedEntry."Vendor No.");
        IF RecLVendLedEntry2.FINDSET(FALSE, FALSE) THEN
            REPEAT
                AmountTot += RecLVendLedEntry2."Amount to Apply";
            UNTIL RecLVendLedEntry2.NEXT = 0;

        IF RecLInvPostingBuffer."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
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

        RecLInvPostingBufferCopy.INIT;
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE("Account No.", RecLVendLedEntry."Vendor No.");
        RecLInvPostingBufferCopy.VALIDATE(Amount, -AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", -AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLVendLedEntry."BC6_Pay-to Vend. No.";
        RecLInvPostingBufferCopy.INSERT;

        RecLInvPostingBufferCopy.INIT;
        RecLInvPostingBufferCopy.COPY(RecLInvPostingBuffer);
        RecLInvPostingBufferCopy.VALIDATE(Amount, AmountTot);
        RecLInvPostingBufferCopy.VALIDATE("Amount (LCY)", AmountTotDS);
        RecLInvPostingBufferCopy."Document Type" := RecLInvPostingBufferCopy."Document Type"::" ";
        Description2 :=
          STRSUBSTNO(StepLedgerDescription, RecLInvPostingBufferCopy."Due Date", RecLVendLedEntry."Vendor No.", '');
        RecLInvPostingBufferCopy.Description := COPYSTR(Description2, 1, 50);
        RecLInvPostingBufferCopy."Auxiliary Entry No." := i;
        RecLInvPostingBufferCopy."BC6_Pay-to No." := RecLVendLedEntry."BC6_Pay-to Vend. No.";
        RecLInvPostingBufferCopy.INSERT;
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

                    PurchaseLine.RESET;
                    PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    PurchaseLine.SETRANGE(PurchaseLine."Document Type", "Document Type");
                    PurchaseLine.SETRANGE(PurchaseLine.Type, PurchaseLine.Type::Item);
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", "No.");
                    IF PurchaseLine.FINDFIRST THEN
                        REPEAT
                            PurchaseLine.TESTFIELD("Return Reason Code");
                            PurchaseLine.TESTFIELD("BC6_Solution Code");
                            PurchaseLine.TESTFIELD("BC6_Return Comment");
                        UNTIL PurchaseLine.NEXT = 0;
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
                    L_SalesLine.RESET;
                    L_SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    L_SalesLine.SETRANGE(L_SalesLine."Document Type", "Document Type");
                    L_SalesLine.SETRANGE(L_SalesLine.Type, L_SalesLine.Type::Item);
                    L_SalesLine.SETRANGE(L_SalesLine."Document No.", "No.");
                    IF L_SalesLine.FINDFIRST THEN
                        REPEAT
                            L_SalesLine.TESTFIELD("Return Reason Code");
                            L_SalesLine.TESTFIELD("BC6_Solution Code");
                            L_SalesLine.TESTFIELD("BC6_Return Comment");
                        UNTIL L_SalesLine.NEXT = 0;
                END;
        END;
    END;

    var
        BinCode: Code[20]; // TODO: related to codeunit 7302
        PostingDate: Date; // TODO: related to codeunit 7324 "Whse.-Activity-Post"
        HideValidationDialog: Boolean;
}