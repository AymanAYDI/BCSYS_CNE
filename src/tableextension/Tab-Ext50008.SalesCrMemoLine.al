tableextension 50008 "BC6_SalesCrMemoLine" extends "Sales Cr.Memo Line"
{
    LookupPageID = "Posted Sales Credit Memo Lines";
    DrillDownPageID = "Posted Sales Credit Memo Lines";
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
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            TableRelation = "BC6_Item Sales Profit Group";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            Editable = false;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Editable = false;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Editable = false;
        }
        field(50028; "BC6_Purch. Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity';
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity';
            Enabled = false;
        }
        field(50031; "BC6_Discount unit price"; Decimal)
        {
            Caption = 'Discount unit price';
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
        }
        field(50033; "BC6_Outstanding qty"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Enabled = false;
        }
        field(50041; "BC6_Purchase cost"; Decimal)
        {
            Caption = 'Purchase cost';
            Editable = false;
        }
        field(50051; "BC6_Affect purchase order"; Boolean)
        {
            Caption = 'Affect purchase order';
        }
        field(50052; "BC6_Order purchase affected"; Boolean)
        {
            Caption = 'Order purchase affected';
            Editable = false;
        }
        field(50100; "BC6_Item Disc. Group"; Code[10])
        {
            Caption = 'Groupe remise article';

            TableRelation = "Item Discount Group";
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation';

        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire';

        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé';

        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard';

        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';

            TableRelation = "BC6_Categories of item".Category;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price';

            Editable = false;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';

            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';

            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';

            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';

            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';

            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {
        key(Key10; "No.")
        {
        }
        key(Key9; "BC6_Buy-from Vendor No.")
        {
        }
    }


}

