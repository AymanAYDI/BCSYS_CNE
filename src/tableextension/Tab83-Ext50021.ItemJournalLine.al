tableextension 50021 "BC6_ItemJournalLine" extends "Item Journal Line" //83
{
    fields
    {
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
        field(50046; "BC6_Whse. Document Type"; enum "BC6_Whse. Document Type 2")
        {
            Caption = 'Whse. Document Type', Comment = 'FRA="Type document magasin"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50047; "BC6_Whse. Document No."; Code[20])
        {
            Caption = 'Whse. Document No.', Comment = 'FRA="N° document magasin"';
            Editable = false;
            TableRelation = IF ("BC6_Whse. Document Type" = CONST("Invt. Pick")) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"));
            DataClassification = CustomerContent;
        }
        field(50048; "BC6_Whse. Document Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.', Comment = 'FRA="N° ligne document mag."';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Qty.(Phys. Inv.)"; Boolean)
        {
            Caption = 'Qty. (Phys. Inventory)', Comment = 'FRA="Qté (constatée) actualisée"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD("Phys. Inventory", TRUE);
            end;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price', Comment = 'FRA="Prix Unitaire DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', Comment = 'FRA="Montant HT DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)', Comment = 'FRA="Prix Unitaire DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', Comment = 'FRA="Montant TVA DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', Comment = 'FRA="Montant TTC DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant HT DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'DEEE Amount (LCY) for Stat', Comment = 'FRA="Montant HT DEEE (DS) pour les stat"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key50001; "Phys. Inventory", "Item No.", "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }

    procedure CalculateDEEE(PCodNewReasonCode: Code[10])
    var
        RecLDEEETariffs: Record "BC6_DEEE Tariffs";
        RecLItem: Record Item;
        RecLReasonCode: Record "Reason Code";
        RecLSalesSetup: Record "Sales & Receivables Setup";
        CntTxt100: Label 'Incorrect setting for %1 filters.', Comment = 'FRA="Paramétrage incorrect pour les filtres %1."';
    begin
        IF ("Reason Code" = '') OR (RecLReasonCode.GET("Reason Code")) THEN BEGIN
            RecLSalesSetup.GET();
            IF (NOT RecLSalesSetup."BC6_DEEE Management") OR ("BC6_DEEE Category Code" = '')
              OR (RecLReasonCode."BC6_Disable DEEE")
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
        RecLDEEETariffs.RESET();
        RecLDEEETariffs.SETRANGE("DEEE Code", "BC6_DEEE Category Code");
        RecLDEEETariffs.SETRANGE("Eco Partner", RecLItem."BC6_Eco partner DEEE");
        RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', "Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN
            ERROR(CntTxt100, RecLDEEETariffs.GETFILTERS);

        "BC6_DEEE Unit Price" := RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."BC6_Number of Units DEEE";
        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := 0; //pas de tva
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_Eco partner DEEE" := RecLItem."BC6_Eco partner DEEE";
        "BC6_DEEE HT Amount (LCY)" := "BC6_DEEE HT Amount";
    end;
}
