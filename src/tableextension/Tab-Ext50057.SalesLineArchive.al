tableextension 50057 "BC6_SalesLineArchive" extends "Sales Line Archive"
{

    fields
    {
        field(50000; "BC6_Document Date flow"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Document Date" WHERE("No." = FIELD("Document No."), "Document Type" = FIELD("Document Type")));
            Caption = 'Document Date';
            Description = 'CNE1.00';
            FieldClass = FlowField;
        }
        field(50001; "BC6_To Prepare"; Boolean)
        {
            Caption = 'To Prepare';
            Description = 'CNE1.00';
        }
        field(50002; "BC6_Purchase Receipt Date"; Date)
        {
            Caption = 'Purchase Receipt Date';
            Description = 'CNE1.00';
        }
        field(50003; "BC6_Qty. To Order"; Decimal)
        {
            Caption = 'Qty. To Order';
            Description = 'CNE1.00';
        }
        field(50004; "BC6_Document Date"; Date)
        {
            Description = 'CNE1.00';
        }
        field(50005; "BC6_Forecast Inventory"; Integer)
        {
            Caption = 'Forecast Inventory';
            Description = 'CNE1.00';
            Editable = false;
        }
        field(50007; "BC6_To Order"; Boolean)
        {
            Caption = 'To Order';
            Description = 'CNE2.05';
        }
        field(50008; "BC6_Promised Purchase Receipt Date"; Boolean)
        {
            Caption = 'Purchase Receipt Date';
            Description = 'CNE6.01';
        }
        field(50020; "BC6_Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            Description = 'GRPMARGEPROD SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            // TableRelation = "Item Sales Profit Group"; TODO:
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            DecimalPlaces = 2 : 5;
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe // SU-DADE cf appel TI193466';
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
        field(50028; "BC6_Purch. Document Type"; enum "BC6_Sales Document Type")
        {
            Caption = 'Document Type';
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
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
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
        field(50040; "BC6_Pick Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37),
                                                                                         "Source Subtype" = CONST(1),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Action Type" = CONST(Take)));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0 : 5;
            Description = 'CNE.4.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost';
            DecimalPlaces = 2 : 5;
            Description = 'hors taxe';
            Editable = false;

            trigger OnValidate()
            begin
                //COUT_ACHAT FG 20/12/06 NSC1.01
                //>>Propoagation CASC 18/01/2007
                //CalcProfit ;
                //<<propagation CASC 18/01/2007
                //CalcDiscount ;
                //Fin COUT_ACHAT FG 20/12/06 NSC1.01
            end;
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
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            // TableRelation = "Categories of item".Category; TODO:
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
            end;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
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
        key(Key1; "Document Type", Type, "No.")
        {
        }
    }
}

