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
        LineCreated: Boolean;
        LineCreatedOk: Boolean;
        SalesOrderCreatedOk: Boolean;
        DueDate: Date;
        QtyAvailToPickBase: Decimal;
        QtyBase: Decimal;
        RemQtyToPickBase: Decimal;
        NextLineNo: Integer;
        NextSourceLineNo: Integer;
        SourceLineNo: Integer;
        ShippingAdvice: Option;

    procedure "Code"()
    begin
        with WhseJnlLine do begin

            if not ("BC6_Whse. Document Type 2" = "BC6_Whse. Document Type 2"::"Invt. Pick") then
                exit;

            if ("BC6_Whse. Document No. 2" = '') then
                exit;

            if ("Qty. (Absolute)" = 0) and ("Qty. (Base)" = 0) and (not "Phys. Inventory") then
                exit;

            GetLocation("Location Code");
            Location.TESTFIELD("Bin Mandatory");
            GetItem2("Item No.");
            WhseActivHeader.GET(WhseActivHeader.Type::"Invt. Pick", "BC6_Whse. Document No. 2");

            NextLineNo := 0;
            WhseActivLine.RESET();
            WhseActivLine.SETRANGE("Activity Type", WhseActivLine."Activity Type"::"Invt. Pick");
            WhseActivLine.SETRANGE("No.", "BC6_Whse. Document No. 2");
            if WhseActivLine.FIND('+') then
                NextLineNo := WhseActivLine."Line No.";

            CLEAR(SourceLineNo);
            CLEAR(DueDate);
            CLEAR(ShippingAdvice);

            if ("From Bin Code" <> '') then begin
                TempWhseActivLine.RESET();
                TempWhseActivLine.DELETEALL();

                RemQtyToPickBase := "Qty. (Base)";
                QtyBase := 0;

                WhseActivLine.SETRANGE("Location Code", "Location Code");
                WhseActivLine.SETRANGE("Item No.", "Item No.");
                WhseActivLine.SETRANGE("Bin Code", "From Bin Code");
                if WhseActivLine.FIND('-') then
                    repeat
                        QtyAvailToPickBase :=
                          WhseActivLine."Qty. (Base)" - WhseActivLine."Qty. to Handle (Base)" - WhseActivLine."Qty. Handled (Base)";
                        if (RemQtyToPickBase < QtyAvailToPickBase) then
                            QtyBase := RemQtyToPickBase
                        else
                            QtyBase := QtyAvailToPickBase;
                        ModifyPickBinWhseActivLine(WhseActivLine, QtyBase, RemQtyToPickBase);
                    until (WhseActivLine.NEXT() = 0) or (RemQtyToPickBase <= 0);

                if RemQtyToPickBase > 0 then begin
                    WhseActivLine.SETRANGE("Bin Code");
                    if WhseActivLine.FIND('-') then
                        repeat
                            QtyAvailToPickBase :=
                              WhseActivLine."Qty. (Base)" - WhseActivLine."Qty. to Handle (Base)" - WhseActivLine."Qty. Handled (Base)";
                            if (RemQtyToPickBase < QtyAvailToPickBase) then
                                QtyBase := RemQtyToPickBase
                            else
                                QtyBase := QtyAvailToPickBase;
                            ModifyPickBinWhseActivLine(WhseActivLine, QtyBase, RemQtyToPickBase);
                        until (WhseActivLine.NEXT() = 0) or (RemQtyToPickBase <= 0);
                end;

                if RemQtyToPickBase > 0 then begin
                    if (WhseActivLine."Line No." <> 0) then begin
                        if (WhseActivLine."Item No." = "Item No.") and
                           (not WhseActivHeader."BC6_Sales Counter") then begin
                            NextLineNo := WhseActivLine."Line No." + CalcLineSpacing(WhseActivLine);
                            SourceLineNo := WhseActivLine."Source Line No.";
                        end
                        else
                            SourceLineNo := 0;
                        DueDate := WhseActivLine."Due Date";
                        ShippingAdvice := WhseActivLine."Shipping Advice".AsInteger();
                    end else begin
                        SourceLineNo := 0;
                        DueDate := WORKDATE();
                        ShippingAdvice := 0;
                    end;

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
                end;
            end;

            if ("To Bin Code" <> '') then begin
                TempWhseActivLine.CALCSUMS("Qty. (Base)");
                if TempWhseActivLine."Qty. (Base)" <> "Qty. (Base)" then
                    ERROR('%1 %2', "Qty. (Base)", TempWhseActivLine."Qty. (Base)");
                TempWhseActivLine.FIND('-');
                repeat
                    InsertPickBinWhseActivLine(NewWhseActivLine);
                until TempWhseActivLine.NEXT() = 0;
                TempWhseActivLine.RESET();
                TempWhseActivLine.DELETEALL();
            end;
        end;
    end;

    local procedure ModifyPickBinWhseActivLine(WhseActivityLine: Record "Warehouse Activity Line"; QtyToPickBase: Decimal; var RemQuantityToPickBase: Decimal)
    begin
        if QtyToPickBase <= 0 then
            exit;

        TempWhseActivLine.INIT();
        TempWhseActivLine := WhseActivityLine;
        TempWhseActivLine."Bin Code" := WhseJnlLine."From Bin Code";
        TempWhseActivLine.Quantity := WhseActivityLine.CalcQty(QtyToPickBase);
        TempWhseActivLine."Qty. (Base)" := QtyToPickBase;
        TempWhseActivLine."Qty. Outstanding" := WhseActivityLine.Quantity;
        TempWhseActivLine."Qty. Outstanding (Base)" := WhseActivityLine."Qty. (Base)";
        TempWhseActivLine."Qty. to Handle" := 0;
        TempWhseActivLine."Qty. to Handle (Base)" := 0;
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
        QtyToPickBase: Decimal;
    begin
        with WhseJnlLine do begin
            QtyToPickBase := "Qty. (Base)";
            if QtyToPickBase > 0 then begin
                SalesOrderCreatedOk := false;

                if (WhseActivHeader."Source Document" = WhseActivHeader."Source Document"::"Sales Order") and
                   WhseActivHeader."BC6_Sales Counter" and
                   (WhseActivHeader."Source No." = '') then begin
                    SalesSetup.GET();
                    SalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
                    WhseActivHeader.TESTFIELD("Destination No.");
                    WhseActivHeader.TESTFIELD("Location Code");

                    SalesOrderCreatedOk := CreateSalesOrder(WhseActivHeader, SalesHeader);

                    WhseActivHeader."Source No." := SalesHeader."No.";
                    WhseActivHeader.MODIFY();
                end;

                if TempWhseActivLine."Source No." = '' then
                    TempWhseActivLine."Source No." := WhseActivHeader."Source No.";

                if TempWhseActivLine."Source Line No." = 0 then begin
                    SalesHeader.GET(SalesHeader."Document Type"::Order, WhseActivHeader."Source No.");

                    SalesSetup.GET();
                    SalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
                    Purchasing.GET(SalesSetup."BC6_Purcha. Code Grouping Line");

                    if (NextSourceLineNo = 0) then begin
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        if SalesLine.FINDLAST() then
                            NextSourceLineNo := SalesLine."Line No." + 10000
                        else
                            NextSourceLineNo := 10000;
                    end;
                    LineCreatedOk := CreateSalesLine(TempWhseActivLine, SalesHeader, SalesLine);
                    if LineCreatedOk then begin
                        NextSourceLineNo += 10000;
                        TempWhseActivLine."Source No." := SalesLine."Document No.";
                        TempWhseActivLine."Source Line No." := SalesLine."Line No.";
                        TempWhseActivLine.MODIFY();

                        if SalesOrderCreatedOk then;
                    end;
                end;

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

                LineCreated := true;
            end;
        end;
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        if (Bin."Location Code" <> LocationCode) or
           (Bin.Code <> BinCode)
        then
            Bin.GET(LocationCode, BinCode);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if Location.Code <> LocationCode then
            Location.GET(LocationCode);
    end;

    local procedure GetItem2(ItemNo: Code[20])
    begin
        if Item."No." <> ItemNo then
            Item.GET(ItemNo);
    end;

    procedure CalcLineSpacing(FromWhseActivLine: Record "Warehouse Activity Line") LineSpacing: Integer
    var
        WhseActivLine2: Record "Warehouse Activity Line";
    begin
        WhseActivLine2 := FromWhseActivLine;
        WhseActivLine2.SETRANGE("No.", FromWhseActivLine."No.");
        if WhseActivLine2.FIND('>') then
            LineSpacing := (WhseActivLine2."Line No." - FromWhseActivLine."Line No.") div 2
        else
            LineSpacing := 10000;
    end;

    procedure CreateSalesOrder(var FromWhseActivHeader: Record "Warehouse Activity Header"; var ToSalesHeader: Record "Sales Header") SalesOrderCreatedOk: Boolean
    begin
        with ToSalesHeader do begin
            INIT();
            SetHideValidationDialog(true);
            "Document Type" := ToSalesHeader."Document Type"::Order;
            "No." := '';
            "BC6_Sales Counter" := WhseActivHeader."BC6_Sales Counter";
            INSERT(true);

            VALIDATE("Sell-to Customer No.", FromWhseActivHeader."Destination No.");
            VALIDATE("Location Code", FromWhseActivHeader."Location Code");
            "External Document No." := FromWhseActivHeader."External Document No.";
            "Your Reference" := FromWhseActivHeader."BC6_Your Reference";
            VALIDATE("Requested Delivery Date", ToSalesHeader."Posting Date");
            MODIFY(true);
            SalesOrderCreatedOk := true;
        end;
    end;

    procedure CreateSalesLine(var FromWhseActivLine: Record "Warehouse Activity Line"; var FromSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line") LineCreatedOk: Boolean
    begin
        LineCreatedOk := false;
        with ToSalesLine do begin

            INIT();
            SetHideValidationDialog(true);
            SuspendStatusCheck(true);
            "Document Type" := FromSalesHeader."Document Type"::Order;
            "Document No." := FromSalesHeader."No.";
            "Line No." := NextSourceLineNo;

            VALIDATE(Type, Type::Item);
            VALIDATE("No.", FromWhseActivLine."Item No.");
            VALIDATE("Variant Code", FromWhseActivLine."Variant Code");
            VALIDATE(Quantity, FromWhseActivLine.Quantity);
            VALIDATE("Unit of Measure Code", FromWhseActivLine."Unit of Measure Code");
            if Purchasing.Code <> '' then
                VALIDATE("Purchasing Code", Purchasing.Code);
            if INSERT(true) then
                LineCreatedOk := true;
        end;
    end;
}
