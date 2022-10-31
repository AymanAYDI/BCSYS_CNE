tableextension 50004 "BC6_SalesShipmentLine" extends "Sales Shipment Line"
{
    LookupPageID = "Posted Sales Shipment Lines";
    DrillDownPageID = "Posted Sales Shipment Lines";
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = const("G/L Account")) "G/L Account"
            ELSE
            IF (Type = const(Item)) Item
            ELSE
            IF (Type = const(Resource)) Resource
            ELSE
            IF (Type = const("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = const("Charge (Item)")) "Item Charge";
            CaptionClass = GetCaptionClass(FIELDNO("No."));
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type = const(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = const("Fixed Asset")) "FA Posting Group";
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = const("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
        }
        modify("Bin Code")
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Item Filter" = FIELD("No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type = const(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            Description = 'GRPMARGEPROD SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "BC6_Item Sales Profit Group";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe';

            trigger OnLookup()
            var
                Rec_ShptHeader: Record "Sales Shipment Header";
                PagLSalesShipments: Page "Posted Sales Shipments";
            begin
                Rec_ShptHeader.RESET();
                Rec_ShptHeader.SETFILTER(Rec_ShptHeader."External Document No.", "BC6_External Document No.");
                IF Rec_ShptHeader.FIND('-') THEN BEGIN
                    PagLSalesShipments.SETRECORD(Rec_ShptHeader);
                    PagLSalesShipments.RUN();
                END;
            end;
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Description = 'Pour Le Besoin De l''Etat Bible';
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Description = 'FE004 pour generer demande prix';
            TableRelation = Vendor;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50028; "BC6_Purch. Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'FE004';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity';
            Description = 'FE001.V1';
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity';
            Description = 'FE001.V1';
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
        }
        field(50033; "BC6_Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost';
            Editable = false;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order';
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected';
            Editable = false;
        }
        field(50060; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            Description = 'CNEIC';
        }
        field(50061; "BC6_Purchase No. Line Lien"; Integer)
        {
            Caption = 'Purchase No. Line Lien';
            Description = 'CNEIC';
        }
        field(50100; "BC6_Item Disc. Group"; Code[10])
        {
            Caption = 'Groupe remise article';
            Description = 'CNE1.02';
            TableRelation = "Item Discount Group";
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation';
            Description = 'CNE1.02';
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire';
            Description = 'CNE1.02';
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé';
            Description = 'CNE1.02';
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard';
            Description = 'CNE1.02';
        }
    }
    keys
    {
        key(Key8; "Document No.", "Sell-to Customer No.", "No.")
        {
        }
        key(Key9; "No.")
        {
        }
        key(Key10; Type, "No.")
        {
        }
    }

    procedure InitFromSalesLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line")
    begin
        INIT();
        TRANSFERFIELDS(SalesLine);
        //TODO  // IF ("No." = '') AND (Type IN [Type::"G/L Account" .. Type::"Charge (Item)"]) THEN
        Type := Type::" ";
        "Posting Date" := SalesShptHeader."Posting Date";
        "Document No." := SalesShptHeader."No.";
        Quantity := SalesLine."Qty. to Ship";
        "Quantity (Base)" := SalesLine."Qty. to Ship (Base)";
        "BC6_Ordered Quantity" := SalesLine.Quantity;
        "BC6_Outstanding Quantity" := SalesLine."Outstanding Quantity" - SalesLine."Qty. to Ship";
        "BC6_Qty Shipped" := SalesLine."Quantity Shipped" + SalesLine."Qty. to Ship";
        IF ABS(SalesLine."Qty. to Invoice") > ABS(SalesLine."Qty. to Ship") THEN BEGIN
            "Quantity Invoiced" := SalesLine."Qty. to Ship";
            "Qty. Invoiced (Base)" := SalesLine."Qty. to Ship (Base)";
        END ELSE BEGIN
            "Quantity Invoiced" := SalesLine."Qty. to Invoice";
            "Qty. Invoiced (Base)" := SalesLine."Qty. to Invoice (Base)";
        END;
        "Qty. Shipped Not Invoiced" := Quantity - "Quantity Invoiced";
        IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
            "Order No." := SalesLine."Document No.";
            "Order Line No." := SalesLine."Line No.";
        END;
    end;

    local procedure CalcBaseQuantities(var SalesLine: Record "Sales Line"; QtyFactor: Decimal)
    begin
        SalesLine."Quantity (Base)" := ROUND(SalesLine.Quantity * QtyFactor, 0.00001);
        SalesLine."Qty. to Asm. to Order (Base)" := ROUND(SalesLine."Qty. to Assemble to Order" * QtyFactor, 0.00001);
        SalesLine."Outstanding Qty. (Base)" := ROUND(SalesLine."Outstanding Quantity" * QtyFactor, 0.00001);
        SalesLine."Qty. to Ship (Base)" := ROUND(SalesLine."Qty. to Ship" * QtyFactor, 0.00001);
        SalesLine."Qty. Shipped (Base)" := ROUND(SalesLine."Quantity Shipped" * QtyFactor, 0.00001);
        SalesLine."Qty. Shipped Not Invd. (Base)" := ROUND(SalesLine."Qty. Shipped Not Invoiced" * QtyFactor, 0.00001);
        SalesLine."Qty. to Invoice (Base)" := ROUND(SalesLine."Qty. to Invoice" * QtyFactor, 0.00001);
        SalesLine."Qty. Invoiced (Base)" := ROUND(SalesLine."Quantity Invoiced" * QtyFactor, 0.00001);
        SalesLine."Return Qty. to Receive (Base)" := ROUND(SalesLine."Return Qty. to Receive" * QtyFactor, 0.00001);
        SalesLine."Return Qty. Received (Base)" := ROUND(SalesLine."Return Qty. Received" * QtyFactor, 0.00001);
        SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := ROUND(SalesLine."Return Qty. Rcd. Not Invd." * QtyFactor, 0.00001);
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record Field;
    begin
        Field.GET(DATABASE::"Sales Shipment Line", FieldNumber);
        EXIT(Field."Field Caption");
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    begin
        CASE FieldNumber OF
            FIELDNO("No."):
                BEGIN
                    IF ApplicationAreaSetup.IsFoundationEnabled() THEN  //TODO
                        EXIT(STRSUBSTNO('3,%1', ItemNoFieldCaptionTxt));
                    EXIT(STRSUBSTNO('3,%1', GetFieldCaption(FieldNumber)));
                END;
        END;
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";

        CstG1000000000: Label '%1-%2-%3-%4';
        "--CstG1000000000": Label '%1-%2-%3-%4';
        CstG1000000001: Label 'Your Reference : ';
        CstG1000000002: Label '%1 %2';

        ItemNoFieldCaptionTxt: Label 'Item No.';
}

