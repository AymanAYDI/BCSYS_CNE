codeunit 50095 "Invt. Pick To Reclass."
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>  CNE4.01
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    // C:FE10 01.11.2011 : Invt. Pick - Direct Sales
    // 
    // //>> CNE6.01
    // TDL:EC01 15.12.2014 : Update Field Qty. Picked

    TableNo = 7311;

    trigger OnRun()
    begin

        WhseJnlLine.COPY(Rec);
        Code;
        Rec := WhseJnlLine;
    end;

    var
        Location: Record "14";
        Bin: Record "7354";
        Item: Record "27";
        WhseJnlLine: Record "7311";
        WhseActivHeader: Record "5766";
        WhseActivLine: Record "5767";
        TmpWhseActivLine: Record "5767" temporary;
        NewWhseActivLine: Record "5767";
        SalesHeader: Record "36";
        SalesLine: Record "37";
        CurrentDate: Date;
        RemQtyToPickBase: Decimal;
        QtyBase: Decimal;
        QtyAvailToPickBase: Decimal;
        NextLineNo: Integer;
        LineCreated: Boolean;
        SourceLineNo: Integer;
        DueDate: Date;
        ShippingAdvice: Option;
        LineSpacing: Integer;
        NextSourceLineNo: Integer;
        Purchasing: Record "5721";
        WhseSalesRelease: Codeunit "5771";
        ReleaseSalesDoc: Codeunit "414";
        SalesOrderCreatedOk: Boolean;
        LineCreatedOk: Boolean;
        SalesSetup: Record "311";

    [Scope('Internal')]
    procedure "Code"()
    begin
        WITH WhseJnlLine DO BEGIN

            IF NOT ("Whse. Document Type 2" = "Whse. Document Type 2"::"Invt. Pick") THEN
                EXIT;

            IF ("Whse. Document No. 2" = '') THEN
                EXIT;

            IF ("Qty. (Absolute)" = 0) AND ("Qty. (Base)" = 0) AND (NOT "Phys. Inventory") THEN
                EXIT;

            GetLocation("Location Code");
            Location.TESTFIELD("Bin Mandatory");
            GetItem2("Item No.");
            WhseActivHeader.GET(WhseActivHeader.Type::"Invt. Pick", "Whse. Document No. 2");

            NextLineNo := 0;
            WhseActivLine.RESET;
            WhseActivLine.SETRANGE("Activity Type", WhseActivLine."Activity Type"::"Invt. Pick");
            WhseActivLine.SETRANGE("No.", "Whse. Document No. 2");
            IF WhseActivLine.FIND('+') THEN
                NextLineNo := WhseActivLine."Line No.";

            CLEAR(SourceLineNo);
            CLEAR(DueDate);
            CLEAR(ShippingAdvice);

            IF ("From Bin Code" <> '') THEN BEGIN
                TmpWhseActivLine.RESET;
                TmpWhseActivLine.DELETEALL;

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
                    UNTIL (WhseActivLine.NEXT = 0) OR (RemQtyToPickBase <= 0);

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
                        UNTIL (WhseActivLine.NEXT = 0) OR (RemQtyToPickBase <= 0);
                END;

                // Plus
                IF RemQtyToPickBase > 0 THEN BEGIN
                    IF (WhseActivLine."Line No." <> 0) THEN BEGIN
                        IF (WhseActivLine."Item No." = "Item No.") AND
                           (NOT WhseActivHeader."Sales Counter") THEN BEGIN
                            NextLineNo := WhseActivLine."Line No." + CalcLineSpacing(WhseActivLine);
                            SourceLineNo := WhseActivLine."Source Line No.";
                        END
                        ELSE BEGIN
                            SourceLineNo := 0;
                        END;
                        DueDate := WhseActivLine."Due Date";
                        ShippingAdvice := WhseActivLine."Shipping Advice";
                    END ELSE BEGIN
                        SourceLineNo := 0;
                        DueDate := WORKDATE;
                        ShippingAdvice := 0;
                    END;

                    TmpWhseActivLine.INIT;
                    TmpWhseActivLine."Activity Type" := WhseActivHeader.Type;
                    TmpWhseActivLine."No." := WhseActivHeader."No.";
                    TmpWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                    TmpWhseActivLine."Source Type" := DATABASE::"Sales Line";
                    TmpWhseActivLine."Source Subtype" := WhseActivHeader."Source Subtype";
                    TmpWhseActivLine."Source Document" := WhseActivHeader."Source Document";
                    TmpWhseActivLine."Source No." := WhseActivHeader."Source No.";
                    TmpWhseActivLine."Source Line No." := SourceLineNo;
                    TmpWhseActivLine."Location Code" := "Location Code";
                    TmpWhseActivLine."Zone Code" := "From Zone Code";
                    TmpWhseActivLine."Bin Code" := "From Bin Code";
                    TmpWhseActivLine."Item No." := "Item No.";
                    TmpWhseActivLine."Variant Code" := "Variant Code";
                    TmpWhseActivLine."Unit of Measure Code" := "Unit of Measure Code";
                    TmpWhseActivLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
                    TmpWhseActivLine.Description := Item.Description;
                    TmpWhseActivLine."Description 2" := Item."Description 2";
                    TmpWhseActivLine."Due Date" := DueDate;
                    TmpWhseActivLine."Shipping Advice" := ShippingAdvice;
                    TmpWhseActivLine."Line No." := NextLineNo;
                    TmpWhseActivLine.Quantity := TmpWhseActivLine.CalcQty(RemQtyToPickBase);
                    TmpWhseActivLine."Qty. (Base)" := RemQtyToPickBase;
                    TmpWhseActivLine."Qty. Outstanding" := TmpWhseActivLine.Quantity;
                    TmpWhseActivLine."Qty. Outstanding (Base)" := TmpWhseActivLine."Qty. (Base)";
                    TmpWhseActivLine."Qty. to Handle" := 0;
                    TmpWhseActivLine."Qty. to Handle (Base)" := 0;
                    //>> CNE6.01
                    TmpWhseActivLine."Qty. Picked" := TmpWhseActivLine.Quantity;
                    TmpWhseActivLine.INSERT;

                    // ERROR('');
                END;

            END;

            IF ("To Bin Code" <> '') THEN BEGIN
                TmpWhseActivLine.CALCSUMS("Qty. (Base)");
                IF TmpWhseActivLine."Qty. (Base)" <> "Qty. (Base)" THEN
                    ERROR('%1 %2', "Qty. (Base)", TmpWhseActivLine."Qty. (Base)");
                TmpWhseActivLine.FIND('-');
                REPEAT
                    InsertPickBinWhseActivLine(NewWhseActivLine);
                UNTIL TmpWhseActivLine.NEXT = 0;
                TmpWhseActivLine.RESET;
                TmpWhseActivLine.DELETEALL;
            END;

        END;
    end;

    local procedure ModifyPickBinWhseActivLine(WhseActivLine: Record "5767"; QtyToPickBase: Decimal; var RemQtyToPickBase: Decimal)
    var
        QtyAvailToPickBase: Decimal;
        ITQtyToPickBase: Decimal;
    begin
        IF QtyToPickBase <= 0 THEN
            EXIT;

        TmpWhseActivLine.INIT;
        TmpWhseActivLine := WhseActivLine;
        TmpWhseActivLine."Bin Code" := WhseJnlLine."From Bin Code";
        TmpWhseActivLine.Quantity := WhseActivLine.CalcQty(QtyToPickBase);
        TmpWhseActivLine."Qty. (Base)" := QtyToPickBase;
        TmpWhseActivLine."Qty. Outstanding" := WhseActivLine.Quantity;
        TmpWhseActivLine."Qty. Outstanding (Base)" := WhseActivLine."Qty. (Base)";
        TmpWhseActivLine."Qty. to Handle" := 0;
        TmpWhseActivLine."Qty. to Handle (Base)" := 0;
        //>> CNE6.01
        TmpWhseActivLine."Qty. Picked" := TmpWhseActivLine.Quantity;
        TmpWhseActivLine.INSERT;

        WhseActivLine.Quantity := WhseActivLine.Quantity - WhseActivLine.CalcQty(QtyToPickBase);
        WhseActivLine."Qty. (Base)" := WhseActivLine."Qty. (Base)" - QtyToPickBase;
        WhseActivLine."Qty. Outstanding" := WhseActivLine.Quantity;
        WhseActivLine."Qty. Outstanding (Base)" := WhseActivLine."Qty. (Base)";
        WhseActivLine."Qty. to Handle" := 0;
        WhseActivLine."Qty. to Handle (Base)" := 0;
        WhseActivLine.MODIFY;

        RemQtyToPickBase := RemQtyToPickBase - QtyToPickBase;
    end;

    local procedure InsertPickBinWhseActivLine(NewWhseActivLine: Record "5767")
    var
        QtyToPickBase: Decimal;
        QtyAvailToPickBase: Decimal;
    begin
        WITH WhseJnlLine DO BEGIN
            QtyToPickBase := "Qty. (Base)";
            IF QtyToPickBase > 0 THEN BEGIN
                SalesOrderCreatedOk := FALSE;

                IF (WhseActivHeader."Source Document" = WhseActivHeader."Source Document"::"Sales Order") AND
                   WhseActivHeader."Sales Counter" AND
                   (WhseActivHeader."Source No." = '') THEN BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("Purchasing Code Grouping Line");
                    WhseActivHeader.TESTFIELD("Destination No.");
                    WhseActivHeader.TESTFIELD("Location Code");

                    SalesOrderCreatedOk := CreateSalesOrder(WhseActivHeader, SalesHeader);

                    // Modify ActivHeader
                    WhseActivHeader."Source No." := SalesHeader."No.";
                    WhseActivHeader.MODIFY;
                END;

                IF TmpWhseActivLine."Source No." = '' THEN
                    TmpWhseActivLine."Source No." := WhseActivHeader."Source No.";

                IF TmpWhseActivLine."Source Line No." = 0 THEN BEGIN
                    SalesHeader.GET(SalesHeader."Document Type"::Order, WhseActivHeader."Source No.");

                    // Purchasing Code
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("Purchasing Code Grouping Line");
                    Purchasing.GET(SalesSetup."Purchasing Code Grouping Line");
                    // Purchasing.SETRANGE("Drop Shipment",FALSE);
                    // Purchasing.SETRANGE("Special Order",FALSE);
                    // IF Purchasing.FIND('-') THEN;

                    IF (NextSourceLineNo = 0) THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        IF SalesLine.FINDLAST THEN
                            NextSourceLineNo := SalesLine."Line No." + 10000
                        ELSE
                            NextSourceLineNo := 10000;
                    END;
                    LineCreatedOk := CreateSalesLine(TmpWhseActivLine, SalesHeader, SalesLine);
                    IF LineCreatedOk THEN BEGIN
                        NextSourceLineNo += 10000;
                        TmpWhseActivLine."Source No." := SalesLine."Document No.";
                        TmpWhseActivLine."Source Line No." := SalesLine."Line No.";
                        TmpWhseActivLine.MODIFY;

                        // Release Sales Doc
                        IF SalesOrderCreatedOk THEN BEGIN
                            // CLEAR(ReleaseSalesDoc);
                            // ReleaseSalesDoc.RUN(SalesHeader);
                        END;

                    END;
                END;

                NewWhseActivLine.INIT;
                NewWhseActivLine := TmpWhseActivLine;
                NewWhseActivLine."Line No." := TmpWhseActivLine."Line No." + CalcLineSpacing(TmpWhseActivLine);
                NewWhseActivLine."Zone Code" := WhseJnlLine."To Zone Code";
                NewWhseActivLine."Bin Code" := WhseJnlLine."To Bin Code";
                NewWhseActivLine."Qty. Outstanding" := NewWhseActivLine.Quantity;
                NewWhseActivLine."Qty. Outstanding (Base)" := NewWhseActivLine."Qty. (Base)";
                NewWhseActivLine."Qty. to Handle" := NewWhseActivLine."Qty. Outstanding";
                NewWhseActivLine."Qty. to Handle (Base)" := NewWhseActivLine."Qty. Outstanding (Base)";
                //>> CNE6.01
                NewWhseActivLine."Qty. Picked" := NewWhseActivLine.Quantity;

                NewWhseActivLine.INSERT;

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

    [Scope('Internal')]
    procedure CalcLineSpacing(FromWhseActivLine: Record "5767") LineSpacing: Integer
    var
        WhseActivLine2: Record "5767";
    begin
        WhseActivLine2 := FromWhseActivLine;
        WhseActivLine2.SETRANGE("No.", FromWhseActivLine."No.");
        IF WhseActivLine2.FIND('>') THEN
            LineSpacing := (WhseActivLine2."Line No." - FromWhseActivLine."Line No.") DIV 2
        ELSE
            LineSpacing := 10000;
    end;

    [Scope('Internal')]
    procedure CreateSalesOrder(var FromWhseActivHeader: Record "5766"; var ToSalesHeader: Record "36") SalesOrderCreatedOk: Boolean
    begin
        WITH ToSalesHeader DO BEGIN
            INIT;
            SetHideValidationDialog(TRUE);
            "Document Type" := ToSalesHeader."Document Type"::Order;
            "No." := '';
            "Sales Counter" := WhseActivHeader."Sales Counter";
            INSERT(TRUE);

            VALIDATE("Sell-to Customer No.", FromWhseActivHeader."Destination No.");
            VALIDATE("Location Code", FromWhseActivHeader."Location Code");
            "External Document No." := FromWhseActivHeader."External Document No.";
            "Your Reference" := FromWhseActivHeader."Your Reference";
            VALIDATE("Requested Delivery Date", ToSalesHeader."Posting Date");
            MODIFY(TRUE);
            SalesOrderCreatedOk := TRUE;
        END;
    end;

    [Scope('Internal')]
    procedure CreateSalesLine(var FromWhseActivLine: Record "5767"; var FromSalesHeader: Record "36"; var ToSalesLine: Record "37") LineCreatedOk: Boolean
    begin
        LineCreatedOk := FALSE;
        WITH ToSalesLine DO BEGIN

            INIT;
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

