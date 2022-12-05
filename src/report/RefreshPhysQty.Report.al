report 50050 "Refresh Phys. Qty"
{
    // 
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>> CNE4.01
    // A:FE14 01.09.2011 : Inventory Control : Refresh Phys. Quantity

    Caption = 'Refresh Phys. Qty';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem8129; Table27)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", Blocked, Inventory, "Location Filter", "Bin Filter";
            dataitem(ItemJournalLine; Table83)
            {
                DataItemLink = Item No.=FIELD(No.),
                               Variant Code=FIELD(Variant Filter),
                               Location Code=FIELD(Location Filter),
                               Bin Code=FIELD(Bin Filter);
                DataItemTableView = SORTING(Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date);
                RequestFilterFields = "Journal Batch Name";

                trigger OnAfterGetRecord()
                var
                    ByBin: Boolean;
                begin
                    IF NOT "Drop Shipment" THEN BEGIN
                      GetLocation("Location Code");
                      ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                    END;

                    IF ItemJnlBatch2.GET("Journal Template Name","Journal Batch Name") AND
                       ItemJnlBatch2."Phys. Inv. Survey" AND
                       (ItemJnlBatch2."Phys. Inv. Check Batch Name" = ItemJnlBatch.Name) THEN
                         BEGIN
                           IF ByBin THEN
                             UpdateBuffer("Bin Code","Qty. (Phys. Inventory)")
                           ELSE
                             UpdateBuffer('',"Qty. (Phys. Inventory)")
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    WITH QuantityOnHandBuffer DO BEGIN
                      RESET;
                      IF FIND('-') THEN BEGIN
                        REPEAT
                          GetLocation("Location Code");

                          InsertItemJnlLine(
                            "Item No.","Variant Code","Dimension Entry No.",
                            "Bin Code",Quantity,Quantity);

                        UNTIL NEXT = 0;
                        DELETEALL;
                      END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETCURRENTKEY("Entry Type","Item No.","Variant Code","Location Code","Bin Code","Posting Date");
                    SETRANGE("Journal Template Name",ItemJnlBatch."Journal Template Name");
                    SETRANGE("Phys. Inventory",TRUE);

                    QuantityOnHandBuffer.RESET;
                    QuantityOnHandBuffer.DELETEALL;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT HideValidationDialog THEN
                  Window.UPDATE;

                // RAZ Qty Phys.
                ItemJnlLine2.SETRANGE("Item No.",Item."No.");
                IF (Item.GETFILTER("Location Filter") <> '') THEN
                  ItemJnlLine2.SETFILTER("Location Code",'%1',Item.GETFILTER("Location Filter"));
                IF (Item.GETFILTER("Bin Filter") <> '') THEN
                  ItemJnlLine2.SETFILTER("Bin Code",'%1',Item.GETFILTER("Bin Filter"));
                IF ItemJnlLine2.FIND('-') THEN
                  REPEAT
                    ItemJnlLine2.VALIDATE("Qty. (Phys. Inventory)",0);
                    ItemJnlLine2."Qty. Refreshed (Phys. Inv.)" := TRUE;
                    ItemJnlLine2.MODIFY(FALSE);
                UNTIL ItemJnlLine2.NEXT = 0;
                ItemJnlLine2.SETRANGE("Item No.");
                ItemJnlLine2.SETRANGE("Location Code");
                ItemJnlLine2.SETRANGE("Bin Code");
            end;

            trigger OnPreDataItem()
            var
                ItemJnlTemplate: Record "82";
                ItemJnlBatch: Record "233";
            begin
                IF PostingDate = 0D THEN
                  ERROR(Text000);

                ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.GET(ItemJnlLine."Journal Template Name",ItemJnlLine."Journal Batch Name");
                ItemJnlBatch.TESTFIELD("Phys. Inv. Survey",FALSE);

                ItemJnlLine.SETRANGE("Journal Template Name",ItemJnlLine."Journal Template Name");
                ItemJnlLine.SETRANGE("Journal Batch Name",ItemJnlLine."Journal Batch Name");
                IF ItemJnlLine.FIND('-') THEN
                  NextDocNo := ItemJnlLine."Document No.";
                NextLineNo := 0;

                CLEAR(ItemJnlLine2);
                ItemJnlLine2.COPY(ItemJnlLine);

                IF NOT HideValidationDialog THEN
                  Window.OPEN(Text002,Item."No.");
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
                    field(PostingDate;PostingDate)
                    {
                        Caption = 'Posting Date';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate;
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
              PostingDate := WORKDATE;
            ValidatePostingDate;

            //BCSYS 111220
            Item.SETRANGE(Blocked,FALSE);
            Item.SETFILTER("Location Filter",'ACTI');
            Item.SETFILTER(Inventory,'<>0');
            //FIN BCSYS 111220
        end;
    }

    labels
    {
    }

    var
        Text000: Label 'Please enter the posting date.';
        Text001: Label 'Please enter the document no.';
        Text002: Label 'Refresh items    #1##########';
        Text003: Label 'Retain Dimensions';
        ItemJnlBatch: Record "233";
        ItemJnlLine: Record "83";
        ItemJnlLine2: Record "83";
        ItemJnlBatch2: Record "233";
        QuantityOnHandBuffer: Record "307" temporary;
        SourceCodeSetup: Record "242";
        DimSelectionBuf: Record "368";
        Location: Record "14";
        NoSeriesMgt: Codeunit "396";
        FirstEntryNo: Integer;
        Window: Dialog;
        PostingDate: Date;
        NextDocNo: Code[20];
        Step: Integer;
        NextLineNo: Integer;
        ZeroQtySave: Boolean;
        HideValidationDialog: Boolean;
        AdjustPosQty: Boolean;
        ColumnDim: Text[250];
        PosQty: Decimal;
        NegQty: Decimal;
        Text004: Label 'You must not filter on dimensions if you calculate locations with %1 is %2.';

    [Scope('Internal')]
    procedure SetItemJnlLine(var NewItemJnlLine: Record "83")
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        ItemJnlBatch.GET(ItemJnlLine."Journal Template Name",ItemJnlLine."Journal Batch Name");
        IF ItemJnlBatch."No. Series" = '' THEN
          NextDocNo := ''
        ELSE BEGIN
          NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series",PostingDate,FALSE);
          CLEAR(NoSeriesMgt);
        END;
    end;

    [Scope('Internal')]
    procedure InsertItemJnlLine(var ItemNo: Code[20];var VariantCode2: Code[10];var DimEntryNo2: Integer;var BinCode2: Code[20];var Quantity2: Decimal;PhysInvQuantity: Decimal)
    var
        GLSetup: Record "98";
        ItemLedgEntry: Record "32";
        ReservEntry: Record "337";
        WhseEntry: Record "7312";
        WhseEntry2: Record "7312";
        Bin: Record "7354";
        CreateReservEntry: Codeunit "99000830";
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
        NoBinExist: Boolean;
    begin
        GLSetup.GET;
        WITH ItemJnlLine DO BEGIN
          IF NextLineNo = 0 THEN BEGIN
            LOCKTABLE;
            SETRANGE("Journal Template Name","Journal Template Name");
            SETRANGE("Journal Batch Name","Journal Batch Name");
            IF FIND('+') THEN
              NextLineNo := "Line No.";
            SourceCodeSetup.GET;
          END;
          NextLineNo := NextLineNo + 10000;
        
          IF (Quantity2 <> 0) THEN BEGIN
            IF (Quantity2 = 0) AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick"
            THEN
              IF NOT Bin.GET(Location.Code,BinCode2) THEN
                NoBinExist := TRUE;
        
            // Find Item Jnl Line
            SETRANGE("Item No.",ItemNo);
            SETRANGE("Variant Code",VariantCode2);
            SETRANGE("Location Code",Location.Code);
            IF NOT NoBinExist THEN
              SETRANGE("Bin Code",BinCode2)
            ELSE
              SETRANGE("Bin Code");
            IF FIND('-') THEN
               BEGIN
                 VALIDATE("Qty. (Phys. Inventory)",PhysInvQuantity);
                 "Qty. Refreshed (Phys. Inv.)" := TRUE;
                 MODIFY(TRUE);
            END ELSE BEGIN
              INIT;
              "Line No." := NextLineNo;
              VALIDATE("Posting Date",PostingDate);
              VALIDATE("Entry Type","Entry Type"::"Positive Adjmt.");
              VALIDATE("Document No.",NextDocNo);
              VALIDATE("Item No.",ItemNo);
              VALIDATE("Variant Code",VariantCode2);
              VALIDATE("Location Code",Location.Code);
              IF NOT NoBinExist THEN
                VALIDATE("Bin Code",BinCode2)
              ELSE
                VALIDATE("Bin Code",'');
              VALIDATE("Source Code",SourceCodeSetup."Phys. Inventory Journal");
              "Qty. (Phys. Inventory)" := PhysInvQuantity;
              "Phys. Inventory" := TRUE;
              VALIDATE("Qty. (Calculated)",0);
              "Posting No. Series" :=ItemJnlBatch."Posting No. Series";
              "Reason Code" := ItemJnlBatch."Reason Code";
              "Phys Invt Counting Period Code" := '';
              "Phys Invt Counting Period Type" := 0;
              // "Shortcut Dimension 1 Code" := '';
              // "Shortcut Dimension 2 Code" := '';
              "Last Item Ledger Entry No." := 0;
              "Qty. Refreshed (Phys. Inv.)" := TRUE;
              INSERT(TRUE);
        
            END;
        
            /*JnlLineDim.SETRANGE("Table ID",DATABASE::"Item Journal Line");
            JnlLineDim.SETRANGE("Journal Template Name","Journal Template Name");
            JnlLineDim.SETRANGE("Journal Batch Name","Journal Batch Name");
            JnlLineDim.SETRANGE("Journal Line No.","Line No.");
            JnlLineDim.SETRANGE("Allocation Line No.",0);
            JnlLineDim.DELETEALL;*/
        
        
          END;
        END;

    end;

    [Scope('Internal')]
    procedure InitializeRequest(NewPostingDate: Date;DocNo: Code[20];ItemsNotOnInvt: Boolean)
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
    end;

    [Scope('Internal')]
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
            IF Location.GET(LocationCode) THEN
              BEGIN
                IF Location."Directed Put-away and Pick" THEN
                  Location.TESTFIELD("Directed Put-away and Pick",FALSE);

                IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
                  IF (Item.GETFILTER("Global Dimension 1 Code") <> '') OR
                     (Item.GETFILTER("Global Dimension 2 Code") <> '')
                  THEN
                     ERROR(Text004,Location.FIELDCAPTION("Bin Mandatory"),Location."Bin Mandatory");
                END;
              END;
    end;

    local procedure UpdateBuffer(BinCode: Code[20];NewQuantity: Decimal)
    var
        DimEntryNo: Integer;
    begin
        WITH QuantityOnHandBuffer DO BEGIN
          IF NOT HasNewQuantity(NewQuantity) THEN
            EXIT;
          IF RetrieveBuffer(BinCode) THEN BEGIN
            Quantity := Quantity + NewQuantity;
            MODIFY;
          END ELSE BEGIN
            Quantity := NewQuantity;
            INSERT;
          END;
        END;
    end;

    [Scope('Internal')]
    procedure RetrieveBuffer(BinCode: Code[20]): Boolean
    begin
        WITH QuantityOnHandBuffer DO BEGIN
          RESET;
          "Item No." := ItemJournalLine."Item No.";
          "Variant Code" := ItemJournalLine."Variant Code";
          "Location Code" := ItemJournalLine."Location Code";
          "Bin Code" := BinCode;
          EXIT(FIND);
        END;
    end;

    [Scope('Internal')]
    procedure HasNewQuantity(NewQuantity: Decimal): Boolean
    begin
        EXIT((NewQuantity <> 0));
    end;
}

