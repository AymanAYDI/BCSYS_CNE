tableextension 50006 "BC6_SalesInvoiceLine" extends "Sales Invoice Line"
{
    LookupPageID = "Posted Sales Invoice Lines";
    DrillDownPageID = "Posted Sales Invoice Lines";
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
            CaptionClass = GetCaptionClass(FIELDNO("No."));
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
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
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
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
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
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
            Enabled = false;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price';
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
        }
        field(50033; "BC6_Outstanding Qty"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
            Enabled = false;
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
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80803; "BC6_DEEE Bases VAT Amount"; Decimal)
        {
            Caption = 'DEEE Bases VAT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {
        key(Key10; "No.")
        {
        }
        key(Key11; "BC6_Buy-from Vendor No.")
        {
        }
        key(Key12; "Document No.", "No.")
        {
        }
    }


}

