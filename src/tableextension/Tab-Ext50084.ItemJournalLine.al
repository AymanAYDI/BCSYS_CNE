tableextension 50084 "BC6_ItemJournalLine" extends "Item Journal Line"
{
    fields
    {

        modify("Qty. (Phys. Inventory)")
        {
            trigger OnAfterValidate()
            begin
                "BC6_Qty. Refreshed (Phys. Inv.)" := FALSE;
            end;
        }

        modify("Bin Code")
        {
            TableRelation = IF ("Entry Type" = FILTER(Purchase | "Positive Adjmt." | Output),
                                Quantity = FILTER(>= 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Item Filter" = FIELD("Item No."),
                                                                      "Variant Filter" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Purchase | "Positive Adjmt." | Output),
                                                                               Quantity = FILTER(< 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                    "Item No." = FIELD("Item No."),
                                                                                                                                    "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Sale | "Negative Adjmt." | Consumption),
                                                                                                                                             Quantity = FILTER(> 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                  "Item No." = FIELD("Item No."),
                                                                                                                                                                                                  "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Sale | "Negative Adjmt." | Transfer | Consumption),
                                                                                                                                                                                                           Quantity = FILTER(<= 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                 "Item Filter" = FIELD("Item No."),
                                                                                                                                                                                                                                                 "Variant Filter" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Transfer),
                                                                                                                                                                                                                                                          Quantity = FILTER(> 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                                                               "Item Filter" = FIELD("Item No."),
                                                                                                                                                                                                                                                                                               "Variant Filter" = FIELD("Variant Code"));
        }












        field(50046; "BC6_Whse. Document Type"; Option)
        {
            Caption = 'Whse. Document Type';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ' ,Invt. Pick';
            OptionMembers = " ","Invt. Pick";
        }
        field(50047; "BC6_Whse. Document No."; Code[20])
        {
            Caption = 'Whse. Document No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF ("BC6_Whse. Document Type" = CONST("Invt. Pick")) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"));
        }
        field(50048; "BC6_Whse. Document Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50060; "BC6_Qty. Refreshed (Phys. Inv.)"; Boolean)
        {
            Caption = 'Qty. (Phys. Inventory)';
            Description = 'CNE4.01';
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD("Phys. Inventory", TRUE);
            end;
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
            Editable = false;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Description = 'DEEE1.00';
        }
    }
    keys
    {

        //Unsupported feature: Property Modification (SumIndexFields) on ""Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date"(Key)". TODO:

        key(Key6; "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key7; "Phys. Inventory", "Item No.", "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
    }
    fieldgroups
    {
        // addlast(Brick;"Line No.","Journal Template Name","Item No.","Document No.","Bin Code","New Bin Code") // TODO: filed Brick not exist in "Item Journal Line"
        // { 
        // }
    }

    procedure "---DEEE1.00---"()
    begin
    end;

    procedure CalculateDEEE(PCodNewReasonCode: Code[10])
    var
        RecLCustomer: Record Customer;
        RecLReasonCode: Record "Reason Code";
        RecLDEEETariffs: Record "BC6_DEEE Tariffs";
        RecLSalesSetup: Record "Sales & Receivables Setup";
        RecLItem: Record Item;
        CntTxt100: Label 'Paramétrage incorrect pour les filtres %1.';
    begin
        IF ("Reason Code" = '') OR (RecLReasonCode.GET("Reason Code")) THEN BEGIN
            RecLSalesSetup.GET;
            IF (NOT RecLSalesSetup."DEEE Management") OR ("BC6_DEEE Category Code" = '')
              OR (RecLReasonCode."Disable DEEE")
              OR (("Entry Type" <> "Entry Type"::Output) AND ("Entry Type" <> "Entry Type"::"Positive Adjmt.")) THEN BEGIN
                "BC6_DEEE Unit Price" := 0;
                "BC6_DEEE HT Amount" := 0;
                "BC6_DEEE VAT Amount" := 0;
                "BC6_DEEE TTC Amount" := 0;
                "BC6_Eco partner DEEE" := '';
                EXIT;
            END;
        END;

        RecLItem.GET("Item No.");
        RecLDEEETariffs.RESET;
        RecLDEEETariffs.SETRANGE("DEEE Code", "BC6_DEEE Category Code");
        RecLDEEETariffs.SETRANGE("Eco Partner", RecLItem."Eco partner DEEE");
        RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', "Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
            ERROR(CntTxt100, RecLDEEETariffs.GETFILTERS);
        END;

        "BC6_DEEE Unit Price" := RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."Number of Units DEEE";
        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := 0; //pas de tva
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_Eco partner DEEE" := RecLItem."Eco partner DEEE";
        "BC6_DEEE HT Amount (LCY)" := "BC6_DEEE HT Amount";
    end;

}

