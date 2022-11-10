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