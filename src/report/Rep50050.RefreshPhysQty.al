report 50050 "BC6_Refresh Phys. Qty"
{

    Caption = 'Refresh Phys. Qty', Comment = 'FRA="Actualiser quantité constatée"';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", Blocked, Inventory, "Location Filter", "Bin Filter";
            dataitem(ItemJournalLine; "Item Journal Line")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Location Code" = FIELD("Location Filter"),
                               "Bin Code" = FIELD("Bin Filter");
                DataItemTableView = SORTING("Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date");
                RequestFilterFields = "Journal Batch Name";

                trigger OnAfterGetRecord()
                var
                    ByBin: Boolean;
                begin
                    IF NOT "Drop Shipment" THEN BEGIN
                        GetLocation("Location Code");
                        ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                    END;

                    IF ItemJnlBatch2.GET("Journal Template Name", "Journal Batch Name") AND
                       ItemJnlBatch2."BC6_Phys. Inv. Survey" AND
                       (ItemJnlBatch2."BC6_Phys. Inv. Check Bat. Name" = ItemJnlBatch.Name) THEN BEGIN
                        IF ByBin THEN
                            UpdateBuffer("Bin Code", "Qty. (Phys. Inventory)")
                        ELSE
                            UpdateBuffer('', "Qty. (Phys. Inventory)")
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    WITH QuantityOnHandBuffer DO BEGIN
                        RESET();
                        IF FIND('-') THEN BEGIN
                            REPEAT
                                GetLocation("Location Code");

                                InsertItemJnlLine(
                                  "Item No.", "Variant Code", "Dimension Entry No.",
                                  "Bin Code", Quantity, Quantity);

                            UNTIL NEXT() = 0;
                            DELETEALL();
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date");
                    SETRANGE("Journal Template Name", ItemJnlBatch."Journal Template Name");
                    SETRANGE("Phys. Inventory", TRUE);

                    QuantityOnHandBuffer.RESET();
                    QuantityOnHandBuffer.DELETEALL();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT HideValidationDialog THEN
                    Window.UPDATE();

                ItemJnlLine2.SETRANGE("Item No.", Item."No.");
                IF (Item.GETFILTER("Location Filter") <> '') THEN
                    ItemJnlLine2.SETFILTER("Location Code", '%1', Item.GETFILTER("Location Filter"));
                IF (Item.GETFILTER("Bin Filter") <> '') THEN
                    ItemJnlLine2.SETFILTER("Bin Code", '%1', Item.GETFILTER("Bin Filter"));
                IF ItemJnlLine2.FIND('-') THEN
                    REPEAT
                        ItemJnlLine2.VALIDATE("Qty. (Phys. Inventory)", 0);
                        ItemJnlLine2."BC6_Qty.(Phys. Inv.)" := TRUE;
                        ItemJnlLine2.MODIFY(FALSE);
                    UNTIL ItemJnlLine2.NEXT() = 0;
                ItemJnlLine2.SETRANGE("Item No.");
                ItemJnlLine2.SETRANGE("Location Code");
                ItemJnlLine2.SETRANGE("Bin Code");
            end;

            trigger OnPreDataItem()
            var
                ItemJnlBatch: Record "Item Journal Batch";
                ItemJnlTemplate: Record "Item Journal Template";
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text000);

                ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
                ItemJnlBatch.TESTFIELD("BC6_Phys. Inv. Survey", FALSE);

                ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                IF ItemJnlLine.FIND('-') THEN
                    NextDocNo := ItemJnlLine."Document No.";
                NextLineNo := 0;

                CLEAR(ItemJnlLine2);
                ItemJnlLine2.COPY(ItemJnlLine);

                IF NOT HideValidationDialog THEN
                    Window.OPEN(Text002, Item."No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date', Comment = 'FRA="Date comptabilisation"';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate();
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

            IF PostingDate = 0D THEN
                PostingDate := WORKDATE();
            ValidatePostingDate();
            Item.SETRANGE(Blocked, FALSE);
            Item.SETFILTER("Location Filter", 'ACTI');
            Item.SETFILTER(Inventory, '<>0');
        end;
    }

    labels
    {
    }

    var
        DimSelectionBuf: Record "Dimension Selection Buffer";
        QuantityOnHandBuffer: Record "Inventory Buffer" temporary;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlBatch2: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlLine2: Record "Item Journal Line";
        Location: Record Location;
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AdjustPosQty: Boolean;
        HideValidationDialog: Boolean;
        ZeroQtySave: Boolean;
        NextDocNo: Code[20];
        PostingDate: Date;
        NegQty: Decimal;
        PosQty: Decimal;
        Window: Dialog;
        FirstEntryNo: Integer;
        NextLineNo: Integer;
        Step: Integer;
        Text000: Label 'Please enter the posting date.', Comment = 'FRA="Veuillez saisir une date de comptabilisation."';
        Text001: Label 'Please enter the document no.', Comment = 'FRA="Veuillez saisir un numéro de document."';
        Text002: Label 'Refresh items    #1##########', Comment = 'FRA="Actualiser quantité constatée #1##########"';
        Text003: Label 'Retain Dimensions', Comment = 'FRA="Conserver axes"';
        Text004: Label 'You must not filter on dimensions if you calculate locations with %1 is %2.', Comment = 'FRA="Vous ne devez pas positionner de filtres sur les axes si vous calculez sur des magasins pour lesquels %1 est %2."';
        ColumnDim: Text[250];


    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        IF ItemJnlBatch."No. Series" = '' THEN
            NextDocNo := ''
        ELSE BEGIN
            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, FALSE);
            CLEAR(NoSeriesMgt);
        END;
    end;


    procedure InsertItemJnlLine(var ItemNo: Code[20]; var VariantCode2: Code[10]; var DimEntryNo2: Integer; var BinCode2: Code[20]; var Quantity2: Decimal; PhysInvQuantity: Decimal)
    var
        Bin: Record Bin;
        GLSetup: Record "General Ledger Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        NoBinExist: Boolean;
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
    begin
        GLSetup.GET();
        WITH ItemJnlLine DO BEGIN
            IF NextLineNo = 0 THEN BEGIN
                LOCKTABLE();
                SETRANGE("Journal Template Name", "Journal Template Name");
                SETRANGE("Journal Batch Name", "Journal Batch Name");
                IF FIND('+') THEN
                    NextLineNo := "Line No.";
                SourceCodeSetup.GET();
            END;
            NextLineNo := NextLineNo + 10000;

            IF (Quantity2 <> 0) THEN BEGIN
                IF (Quantity2 = 0) AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick"
                THEN
                    IF NOT Bin.GET(Location.Code, BinCode2) THEN
                        NoBinExist := TRUE;

                SETRANGE("Item No.", ItemNo);
                SETRANGE("Variant Code", VariantCode2);
                SETRANGE("Location Code", Location.Code);
                IF NOT NoBinExist THEN
                    SETRANGE("Bin Code", BinCode2)
                ELSE
                    SETRANGE("Bin Code");
                IF FIND('-') THEN BEGIN
                    VALIDATE("Qty. (Phys. Inventory)", PhysInvQuantity);
                    "BC6_Qty.(Phys. Inv.)" := TRUE;
                    MODIFY(TRUE);
                END ELSE BEGIN
                    INIT();
                    "Line No." := NextLineNo;
                    VALIDATE("Posting Date", PostingDate);
                    VALIDATE("Entry Type", "Entry Type"::"Positive Adjmt.");
                    VALIDATE("Document No.", NextDocNo);
                    VALIDATE("Item No.", ItemNo);
                    VALIDATE("Variant Code", VariantCode2);
                    VALIDATE("Location Code", Location.Code);
                    IF NOT NoBinExist THEN
                        VALIDATE("Bin Code", BinCode2)
                    ELSE
                        VALIDATE("Bin Code", '');
                    VALIDATE("Source Code", SourceCodeSetup."Phys. Inventory Journal");
                    "Qty. (Phys. Inventory)" := PhysInvQuantity;
                    "Phys. Inventory" := TRUE;
                    VALIDATE("Qty. (Calculated)", 0);
                    "Posting No. Series" := ItemJnlBatch."Posting No. Series";
                    "Reason Code" := ItemJnlBatch."Reason Code";
                    "Phys Invt Counting Period Code" := '';
                    "Phys Invt Counting Period Type" := 0;
                    "Last Item Ledger Entry No." := 0;
                    "BC6_Qty.(Phys. Inv.)" := TRUE;
                    INSERT(TRUE);

                END;

            END;
        END;

    end;


    procedure InitializeRequest(NewPostingDate: Date; DocNo: Code[20]; ItemsNotOnInvt: Boolean)
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                IF Location.GET(LocationCode) THEN BEGIN
                    IF Location."Directed Put-away and Pick" THEN
                        Location.TESTFIELD("Directed Put-away and Pick", FALSE);

                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
                        IF (Item.GETFILTER("Global Dimension 1 Code") <> '') OR
                           (Item.GETFILTER("Global Dimension 2 Code") <> '')
                        THEN
                            ERROR(Text004, Location.FIELDCAPTION("Bin Mandatory"), Location."Bin Mandatory");
                    END;
                END;
    end;

    local procedure UpdateBuffer(BinCode: Code[20]; NewQuantity: Decimal)
    var
        DimEntryNo: Integer;
    begin
        WITH QuantityOnHandBuffer DO BEGIN
            IF NOT HasNewQuantity(NewQuantity) THEN
                EXIT;
            IF RetrieveBuffer(BinCode) THEN BEGIN
                Quantity := Quantity + NewQuantity;
                MODIFY();
            END ELSE BEGIN
                Quantity := NewQuantity;
                INSERT();
            END;
        END;
    end;


    procedure RetrieveBuffer(BinCode: Code[20]): Boolean
    begin
        WITH QuantityOnHandBuffer DO BEGIN
            RESET();
            "Item No." := ItemJournalLine."Item No.";
            "Variant Code" := ItemJournalLine."Variant Code";
            "Location Code" := ItemJournalLine."Location Code";
            "Bin Code" := BinCode;
            EXIT(FIND());
        END;
    end;


    procedure HasNewQuantity(NewQuantity: Decimal): Boolean
    begin
        EXIT((NewQuantity <> 0));
    end;
}

