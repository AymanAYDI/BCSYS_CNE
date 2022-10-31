tableextension 50028 "BC6_Item" extends Item
{
    LookupPageID = "Item List";
    DrillDownPageID = "Item List";
    fields
    {
        modify("Price/Profit Calculation")
        {
            trigger OnAfterValidate()
            var
                InvSetup: Record "Inventory Setup";
                VATPostingSetup2: Record "VAT Posting Setup";
            begin
                IF NOT "Price Includes VAT" THEN
                    IF "VAT Prod. Posting Group" <> '' THEN BEGIN
                        "BC6_Unit Price Includes VAT" := 0;
                        GetGLSetup;
                        InvSetup.GET;
                        IF InvSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN BEGIN
                            VATPostingSetup2.GET(InvSetup."VAT Bus. Posting Gr. (Price)", "VAT Prod. Posting Group");
                            "BC6_Unit Price Includes VAT" := ROUND("Unit Price" * (1 + VATPostingSetup2."VAT %" / 100), GLSetup."Unit-Amount Rounding Precision")
                        END;
                    END;
            end;
        }

        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(50001; BC6_User; Code[50])
        {
            Caption = 'User';
            Editable = false;
            TableRelation = User;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            TableRelation = "BC6_Item Sales Profit Group";
        }
        field(50040; "BC6_Pick Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Location Code" = FIELD("Location Filter"),
                                                                                         "Bin Code" = FIELD("Bin Filter"),
                                                                                         "Item No." = FIELD("No."),
                                                                                         "Variant Code" = FIELD("Variant Filter"),
                                                                                         "Action Type" = CONST(Take),
                                                                                         "Lot No." = FIELD("Lot No. Filter"),
                                                                                         "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "BC6_Unit Price Includes VAT"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price Includes VAT';
            MinValue = 0;
        }
        field(50042; "BC6_Print Unit Price Incl. VAT"; Boolean)
        {
            AutoFormatType = 2;
            Caption = 'Print Unit Price Includes VAT On Label';
            MinValue = false;
        }
        field(50050; "BC6_Cost Increase Coeff %"; Decimal)
        {
            Caption = 'Cost Increase Coeff (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50051; "BC6_Search Description 2"; Code[50])
        {
            Caption = 'Search Description 2';
        }
        field(50060; "BC6_Qty. Return Order SAV"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Return Order"),
                                                                            Type = CONST(Item),
                                                                            "No." = FIELD("No."),
                                                                            //TODO variabel specifique      // "BC6_Return Order Type" = FILTER(SAV),
                                                                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Shipment Date" = FIELD("Date Filter")));
            Caption = ' Qty. Return Order SAV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code ';
            TableRelation = "BC6_Categories of item".Category WHERE("Eco Partner" = FIELD("BC6_Eco partner DEEE"));

            trigger OnValidate()
            var
                LRecDEEECategory: Record "BC6_Categories of item";
            begin
                //<<DEEE1.00
                IF ("BC6_DEEE Category Code") = ''
                  THEN BEGIN
                    "BC6_DEEE Category Code" := '';
                    "BC6_DEEE Unit Tax" := 0;
                    "BC6_Number of Units DEEE" := 0;
                    "BC6_Eco partner DEEE" := '';
                END;
                //>>DEEE1.00
            end;
        }
        field(80801; "BC6_DEEE Unit Tax"; Decimal)
        {
            Caption = 'DEEE Unit Tax';
            Description = 'DEEE1.00';
        }
        field(80802; "BC6_Number of Units DEEE"; Decimal)
        {
            Caption = 'Number of Units DEEE';
            Description = 'DEEE1.00';
        }
        field(80803; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF ("BC6_Eco partner DEEE") = ''
                  THEN BEGIN
                    "BC6_DEEE Category Code" := '';
                    "BC6_DEEE Unit Tax" := 0;
                    "BC6_Number of Units DEEE" := 0;
                    "BC6_Eco partner DEEE" := '';
                END;
            end;
        }
    }
    keys
    {
        key(Key20; "BC6_Search Description 2")
        {
        }
    }
    local procedure TestNoOpenDocumentsWithTrackingExist()
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservationEntry: Record "Reservation Entry";
        RecRef: RecordRef;
        SourceType: Integer;
        SourceID: Code[20];
        ItemTrackingCode2: Record "Item Tracking Code";
    begin
        IF ItemTrackingCode2.Code = '' THEN
            EXIT;

        TrackingSpecification.SETRANGE("Item No.", "No.");
        IF TrackingSpecification.FINDFIRST() THEN BEGIN
            SourceType := TrackingSpecification."Source Type";
            SourceID := TrackingSpecification."Source ID";
        END ELSE BEGIN
            ReservationEntry.SETRANGE("Item No.", "No.");
            ReservationEntry.SETFILTER("Item Tracking", '<>%1', ReservationEntry."Item Tracking"::None);
            IF ReservationEntry.FINDFIRST() THEN BEGIN
                SourceType := ReservationEntry."Source Type";
                SourceID := ReservationEntry."Source ID";
            END;
        END;

        IF SourceType = 0 THEN
            EXIT;

        RecRef.OPEN(SourceType);
        ERROR(OpenDocumentTrackingErr, RecRef.CAPTION, SourceID);
    end;


    procedure CalcQtyAvailToPick(ExcludeQty: Decimal): Decimal
    var
        InvNotToPick: Decimal;
    begin
        CALCFIELDS(Inventory, "BC6_Pick Qty.");
        EXIT(Inventory - ("BC6_Pick Qty." - ExcludeQty));
    end;

    LOCAL PROCEDURE GetGLSetup();
    BEGIN
        IF NOT GLSetupRead THEN
            GLSetup.GET;
        GLSetupRead := TRUE;
    END;

    procedure CalcQtyNotToPick(): Decimal
    var
        FromBinContent: Record "Bin Content";
        InvNotToPick: Decimal;
        ItemInvNotToPick: Decimal;
    begin
        ItemInvNotToPick := 0;
        InvNotToPick := 0;
        FromBinContent.SETCURRENTKEY(Default, "Location Code", "Item No.", "Variant Code", "Bin Code");
        IF "Location Filter" <> '' THEN
            FromBinContent.SETFILTER("Location Code", "Location Filter");
        FromBinContent.SETRANGE("Item No.", "No.");
        IF "Serial No. Filter" <> '' THEN
            FromBinContent.SETFILTER("Serial No. Filter", "Serial No. Filter");
        IF "Lot No. Filter" <> '' THEN
            FromBinContent.SETFILTER("Lot No. Filter", "Lot No. Filter");
        IF FromBinContent.FIND('-') THEN
            REPEAT
                FromBinContent.CALCFIELDS(Quantity, "Pick Qty.");
                InvNotToPick := (FromBinContent.Quantity - FromBinContent."Pick Qty.") - FromBinContent.CalcQtyAvailToPick(0);
                IF InvNotToPick > 0 THEN
                    ItemInvNotToPick += InvNotToPick;
            UNTIL FromBinContent.NEXT() = 0;
        EXIT(ItemInvNotToPick);
    end;

    var
        OpenDocumentTrackingErr: Label 'You cannot change "Item Tracking Code" because there is at least one open document that includes this item with specified tracking: Source Type = %1, Document No. = %2.';
        SelectItemErr: Label 'You must select an existing item.';
        CreateNewItemTxt: Label 'Create a new item card for %1.', Comment = '%1 is the name to be used to create the customer. ';
        ItemNotRegisteredTxt: Label 'This item is not registered. To continue, choose one of the following options:';
        SelectItemTxt: Label 'Select an existing item.';
        "-NSC1.01-": Integer;
        NaviSetup: Record "BC6_Navi+ Setup";
        "-- MIGNAV2013 --": Label '';
        CstG001: Label 'Vous n''avez pas l''autorisation d''''effectuer cette opération.';
        GLSetupRead: Boolean;
        GLSetup: Record "General Ledger Setup";

}

