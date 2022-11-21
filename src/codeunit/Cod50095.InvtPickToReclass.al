codeunit 50095 "BC6_Invt. Pick To Reclass."
{
    TableNo = "Warehouse Journal Line";

    trigger OnRun()
    begin
        WhseJnlLine.COPY(Rec);
        Code();
        Rec := WhseJnlLine;
    end;

    var
        Bin: Record Bin;
        Item: Record Item;
        Location: Record Location;
        Purchasing: Record Purchasing;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        WhseActivHeader: Record "Warehouse Activity Header";
        NewWhseActivLine: Record "Warehouse Activity Line";
        TempWhseActivLine: Record "Warehouse Activity Line" temporary;
        WhseActivLine: Record "Warehouse Activity Line";
        WhseJnlLine: Record "Warehouse Journal Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        WhseSalesRelease: Codeunit "Whse.-Sales Release";
        LineCreated: Boolean;
        LineCreatedOk: Boolean;
        SalesOrderCreatedOk: Boolean;
        CurrentDate: Date;
        DueDate: Date;
        QtyAvailToPickBase: Decimal;
        QtyBase: Decimal;
        RemQtyToPickBase: Decimal;
        LineSpacing: Integer;
        NextLineNo: Integer;
        NextSourceLineNo: Integer;
        SourceLineNo: Integer;
        ShippingAdvice: Option;

    procedure "Code"()
    begin
        WITH WhseJnlLine DO BEGIN

            IF NOT ("BC6_Whse. Document Type 2" = "BC6_Whse. Document Type 2"::"Invt. Pick") THEN
                EXIT;

            IF ("BC6_Whse. Document No. 2" = '') THEN
                EXIT;

            IF ("Qty. (Absolute)" = 0) AND ("Qty. (Base)" = 0) AND (NOT "Phys. Inventory") THEN
                EXIT;

            GetLocation("Location Code");
            Location.TESTFIELD("Bin Mandatory");
            GetItem2("Item No.");
            WhseActivHeader.GET(WhseActivHeader.Type::"Invt. Pick", "BC6_Whse. Document No. 2");

            NextLineNo := 0;
            WhseActivLine.RESET();
            WhseActivLine.SETRANGE("Activity Type", WhseActivLine."Activity Type"::"Invt. Pick");
            WhseActivLine.SETRANGE("No.", "BC6_Whse. Document No. 2");
            IF WhseActivLine.FIND('+') THEN
                NextLineNo := WhseActivLine."Line No.";

            CLEAR(SourceLineNo);
            CLEAR(DueDate);
            CLEAR(ShippingAdvice);

            IF ("From Bin Code" <> '') THEN BEGIN
                TempWhseActivLine.RESET();
                TempWhseActivLine.DELETEALL();

                RemQtyToPickBase := "Qty. (Base)";
                QtyBase := 0;

                // find pick qty. for same bin
                WhseActivLine.SETRANGE("Location Code", "Location Code");
                WhseActivLine.SETRANGE("Item No.", "Item No.");
                WhseActivLine.SETRANGE("Bin Code", "From Bin Code");
                IF WhseActivLine.FIND('-') THEN
                    REPEAT
                        QtyAvailToPickBase :=
                          WhseActivLine."Qty. (Base)" - WhseActivLine."Qty. to Handle (Base)" - WhseActivLine."Qty. Handled (Base)";
                        IF (RemQtyToPickBase < QtyAvailToPickBase) THEN
                            QtyBase := RemQtyToPickBase
                        ELSE
                            QtyBase := QtyAvailToPickBase;
                        ModifyPickBinWhseActivLine(WhseActivLine, QtyBase, RemQtyToPickBase);
                    UNTIL (WhseActivLine.NEXT() = 0) OR (RemQtyToPickBase <= 0);

                // find pick qty. for other bins
                IF RemQtyToPickBase > 0 THEN BEGIN
                    WhseActivLine.SETRANGE("Bin Code");
                    IF WhseActivLine.FIND('-') THEN
                        REPEAT
                            QtyAvailToPickBase :=
                              WhseActivLine."Qty. (Base)" - WhseActivLine."Qty. to Handle (Base)" - WhseActivLine."Qty. Handled (Base)";
                            IF (RemQtyToPickBase < QtyAvailToPickBase) THEN
                                QtyBase := RemQtyToPickBase
                            ELSE
                                QtyBase := QtyAvailToPickBase;
                            ModifyPickBinWhseActivLine(WhseActivLine, QtyBase, RemQtyToPickBase);
                        UNTIL (WhseActivLine.NEXT() = 0) OR (RemQtyToPickBase <= 0);
                END;

                // Plus
                IF RemQtyToPickBase > 0 THEN BEGIN
                    IF (WhseActivLine."Line No." <> 0) THEN BEGIN
                        IF (WhseActivLine."Item No." = "Item No.") AND
                           (NOT WhseActivHeader."BC6_Sales Counter") THEN BEGIN
                            NextLineNo := WhseActivLine."Line No." + CalcLineSpacing(WhseActivLine);
                            SourceLineNo := WhseActivLine."Source Line No.";
                        END
                        ELSE
                            SourceLineNo := 0;
                        DueDate := WhseActivLine."Due Date";
                        ShippingAdvice := WhseActivLine."Shipping Advice".AsInteger();
                    END ELSE BEGIN
                        SourceLineNo := 0;
                        DueDate := WORKDATE();
                        ShippingAdvice := 0;
                    END;

                    TempWhseActivLine.INIT();
                    TempWhseActivLine."Activity Type" := WhseActivHeader.Type;
                    TempWhseActivLine."No." := WhseActivHeader."No.";
                    TempWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                    TempWhseActivLine."Source Type" := DATABASE::"Sales Line";
                    TempWhseActivLine."Source Subtype" := WhseActivHeader."Source Subtype";
                    TempWhseActivLine."Source Document" := WhseActivHeader."Source Document";
                    TempWhseActivLine."Source No." := WhseActivHeader."Source No.";
                    TempWhseActivLine."Source Line No." := SourceLineNo;
                    TempWhseActivLine."Location Code" := "Location Code";
                    TempWhseActivLine."Zone Code" := "From Zone Code";
                    TempWhseActivLine."Bin Code" := "From Bin Code";
                    TempWhseActivLine."Item No." := "Item No.";
                    TempWhseActivLine."Variant Code" := "Variant Code";
                    TempWhseActivLine."Unit of Measure Code" := "Unit of Measure Code";
                    TempWhseActivLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
                    TempWhseActivLine.Description := Item.Description;
                    TempWhseActivLine."Description 2" := Item."Description 2";
                    TempWhseActivLine."Due Date" := DueDate;
                    TempWhseActivLine."Shipping Advice" := ShippingAdvice;
                    TempWhseActivLine."Line No." := NextLineNo;
                    TempWhseActivLine.Quantity := TempWhseActivLine.CalcQty(RemQtyToPickBase);
                    TempWhseActivLine."Qty. (Base)" := RemQtyToPickBase;
                    TempWhseActivLine."Qty. Outstanding" := TempWhseActivLine.Quantity;
                    TempWhseActivLine."Qty. Outstanding (Base)" := TempWhseActivLine."Qty. (Base)";
                    TempWhseActivLine."Qty. to Handle" := 0;
                    TempWhseActivLine."Qty. to Handle (Base)" := 0;
                    TempWhseActivLine."BC6_Qty. Picked" := TempWhseActivLine.Quantity;
                    TempWhseActivLine.INSERT();
                END;
            END;

            IF ("To Bin Code" <> '') THEN BEGIN
                TempWhseActivLine.CALCSUMS("Qty. (Base)");
                IF TempWhseActivLine."Qty. (Base)" <> "Qty. (Base)" THEN
                    ERROR('%1 %2', "Qty. (Base)", TempWhseActivLine."Qty. (Base)");
                TempWhseActivLine.FIND('-');
                REPEAT
                    InsertPickBinWhseActivLine(NewWhseActivLine);
                UNTIL TempWhseActivLine.NEXT() = 0;
                TempWhseActivLine.RESET();
                TempWhseActivLine.DELETEALL();
            END;
        END;
    end;

    local procedure ModifyPickBinWhseActivLine(WhseActivityLine: Record "Warehouse Activity Line"; QtyToPickBase: Decimal; var RemQuantityToPickBase: Decimal)
    var
        ITQtyToPickBase: Decimal;
        QtyAvailbToPickBase: Decimal;
    begin
        IF QtyToPickBase <= 0 THEN
            EXIT;

        TempWhseActivLine.INIT();
        TempWhseActivLine := WhseActivityLine;
        TempWhseActivLine."Bin Code" := WhseJnlLine."From Bin Code";
        TempWhseActivLine.Quantity := WhseActivityLine.CalcQty(QtyToPickBase);
        TempWhseActivLine."Qty. (Base)" := QtyToPickBase;
        TempWhseActivLine."Qty. Outstanding" := WhseActivityLine.Quantity;
        TempWhseActivLine."Qty. Outstanding (Base)" := WhseActivityLine."Qty. (Base)";
        TempWhseActivLine."Qty. to Handle" := 0;
        TempWhseActivLine."Qty. to Handle (Base)" := 0;
        //>> CNE6.01
        TempWhseActivLine."BC6_Qty. Picked" := TempWhseActivLine.Quantity;
        TempWhseActivLine.INSERT();

        WhseActivityLine.Quantity := WhseActivityLine.Quantity - WhseActivityLine.CalcQty(QtyToPickBase);
        WhseActivityLine."Qty. (Base)" := WhseActivityLine."Qty. (Base)" - QtyToPickBase;
        WhseActivityLine."Qty. Outstanding" := WhseActivityLine.Quantity;
        WhseActivityLine."Qty. Outstanding (Base)" := WhseActivityLine."Qty. (Base)";
        WhseActivityLine."Qty. to Handle" := 0;
        WhseActivityLine."Qty. to Handle (Base)" := 0;
        WhseActivityLine.MODIFY();

        RemQuantityToPickBase := RemQuantityToPickBase - QtyToPickBase;
    end;

    local procedure InsertPickBinWhseActivLine(NewWhseActivityLine: Record "Warehouse Activity Line")
    var
        QtyAvaileToPickBase: Decimal;
        QtyToPickBase: Decimal;
    begin
        WITH WhseJnlLine DO BEGIN
            QtyToPickBase := "Qty. (Base)";
            IF QtyToPickBase > 0 THEN BEGIN
                SalesOrderCreatedOk := FALSE;

                IF (WhseActivHeader."Source Document" = WhseActivHeader."Source Document"::"Sales Order") AND
                   WhseActivHeader."BC6_Sales Counter" AND
                   (WhseActivHeader."Source No." = '') THEN BEGIN
                    SalesSetup.GET();
                    SalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
                    WhseActivHeader.TESTFIELD("Destination No.");
                    WhseActivHeader.TESTFIELD("Location Code");

                    SalesOrderCreatedOk := CreateSalesOrder(WhseActivHeader, SalesHeader);

                    // Modify ActivHeader
                    WhseActivHeader."Source No." := SalesHeader."No.";
                    WhseActivHeader.MODIFY();
                END;

                IF TempWhseActivLine."Source No." = '' THEN
                    TempWhseActivLine."Source No." := WhseActivHeader."Source No.";

                IF TempWhseActivLine."Source Line No." = 0 THEN BEGIN
                    SalesHeader.GET(SalesHeader."Document Type"::Order, WhseActivHeader."Source No.");

                    // Purchasing Code
                    SalesSetup.GET();
                    SalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
                    Purchasing.GET(SalesSetup."BC6_Purcha. Code Grouping Line");
                    // Purchasing.SETRANGE("Drop Shipment",FALSE);
                    // Purchasing.SETRANGE("Special Order",FALSE);
                    // IF Purchasing.FIND('-') THEN;

                    IF (NextSourceLineNo = 0) THEN BEGIN
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        IF SalesLine.FINDLAST() THEN
                            NextSourceLineNo := SalesLine."Line No." + 10000
                        ELSE
                            NextSourceLineNo := 10000;
                    END;
                    LineCreatedOk := CreateSalesLine(TempWhseActivLine, SalesHeader, SalesLine);
                    IF LineCreatedOk THEN BEGIN
                        NextSourceLineNo += 10000;
                        TempWhseActivLine."Source No." := SalesLine."Document No.";
                        TempWhseActivLine."Source Line No." := SalesLine."Line No.";
                        TempWhseActivLine.MODIFY();

                        IF SalesOrderCreatedOk THEN BEGIN
                        END;
                    END;
                END;

                NewWhseActivityLine.INIT();
                NewWhseActivityLine := TempWhseActivLine;
                NewWhseActivityLine."Line No." := TempWhseActivLine."Line No." + CalcLineSpacing(TempWhseActivLine);
                NewWhseActivityLine."Zone Code" := WhseJnlLine."To Zone Code";
                NewWhseActivityLine."Bin Code" := WhseJnlLine."To Bin Code";
                NewWhseActivityLine."Qty. Outstanding" := NewWhseActivityLine.Quantity;
                NewWhseActivityLine."Qty. Outstanding (Base)" := NewWhseActivityLine."Qty. (Base)";
                NewWhseActivityLine."Qty. to Handle" := NewWhseActivityLine."Qty. Outstanding";
                NewWhseActivityLine."Qty. to Handle (Base)" := NewWhseActivityLine."Qty. Outstanding (Base)";
                NewWhseActivityLine."BC6_Qty. Picked" := NewWhseActivityLine.Quantity;

                NewWhseActivityLine.INSERT();

                LineCreated := TRUE;
            END;
        END;
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        IF (Bin."Location Code" <> LocationCode) OR
           (Bin.Code <> BinCode)
        THEN
            Bin.GET(LocationCode, BinCode);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF Location.Code <> LocationCode THEN
            Location.GET(LocationCode);
    end;

    local procedure GetItem2(ItemNo: Code[20])
    begin
        IF Item."No." <> ItemNo THEN
            Item.GET(ItemNo);
    end;

    procedure CalcLineSpacing(FromWhseActivLine: Record "Warehouse Activity Line") LineSpacing: Integer
    var
        WhseActivLine2: Record "Warehouse Activity Line";
    begin
        WhseActivLine2 := FromWhseActivLine;
        WhseActivLine2.SETRANGE("No.", FromWhseActivLine."No.");
        IF WhseActivLine2.FIND('>') THEN
            LineSpacing := (WhseActivLine2."Line No." - FromWhseActivLine."Line No.") DIV 2
        ELSE
            LineSpacing := 10000;
    end;

    procedure CreateSalesOrder(var FromWhseActivHeader: Record "Warehouse Activity Header"; var ToSalesHeader: Record "Sales Header") SalesOrderCreatedOk: Boolean
    begin
        WITH ToSalesHeader DO BEGIN
            INIT();
            SetHideValidationDialog(TRUE);
            "Document Type" := ToSalesHeader."Document Type"::Order;
            "No." := '';
            "BC6_Sales Counter" := WhseActivHeader."BC6_Sales Counter";
            INSERT(TRUE);

            VALIDATE("Sell-to Customer No.", FromWhseActivHeader."Destination No.");
            VALIDATE("Location Code", FromWhseActivHeader."Location Code");
            "External Document No." := FromWhseActivHeader."External Document No.";
            "Your Reference" := FromWhseActivHeader."BC6_Your Reference";
            VALIDATE("Requested Delivery Date", ToSalesHeader."Posting Date");
            MODIFY(TRUE);
            SalesOrderCreatedOk := TRUE;
        END;
    end;

    procedure CreateSalesLine(var FromWhseActivLine: Record "Warehouse Activity Line"; var FromSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line") LineCreatedOk: Boolean
    begin
        LineCreatedOk := FALSE;
        WITH ToSalesLine DO BEGIN

            INIT();
            SetHideValidationDialog(TRUE);
            SuspendStatusCheck(TRUE);
            "Document Type" := FromSalesHeader."Document Type"::Order;
            "Document No." := FromSalesHeader."No.";
            "Line No." := NextSourceLineNo;

            VALIDATE(Type, Type::Item);
            VALIDATE("No.", FromWhseActivLine."Item No.");
            VALIDATE("Variant Code", FromWhseActivLine."Variant Code");
            VALIDATE(Quantity, FromWhseActivLine.Quantity);
            VALIDATE("Unit of Measure Code", FromWhseActivLine."Unit of Measure Code");
            IF Purchasing.Code <> '' THEN
                VALIDATE("Purchasing Code", Purchasing.Code);
            IF INSERT(TRUE) THEN
                LineCreatedOk := TRUE;
        END;
    end;
}
