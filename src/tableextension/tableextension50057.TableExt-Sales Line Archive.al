tableextension 50057 tableextension50057 extends "Sales Line Archive"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Cde] Ajout de la clé:
    //                                                       Document Type,Type,No.
    // //Demande de prix FE004 06/12/2006 ajout du champ 50025 "Buy-from Vendor No."
    //                   FE004.2 11/12/2006 ajout champ 50026 à 50028
    // 
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                         50020 Customer Sales Profit Group
    //                                         50021 Item Sales Profit Group
    //                                         50022 Public Price
    //                                         50023 External Document No.
    //                                         50024 Amount(LCY)
    //                                         50029 Ordere Quantity
    //                                         50030 Qty Shipped
    //                                         50031 Discount Unit Price
    //                                         50032 Availability Item
    //                                         50033 Outstanding qty
    //                                         50041 Purchase cost
    //                                         50051 Affect purchase order
    //                                         50052 Order purchase affected
    // 
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - add field 50100 to 50104
    // 
    // ------------------------------------------------------------------------
    // 
    // //>>CNE ARCHIVAGE
    //   ARCHIVAGE-DEVIS 29/01/16 : - add field 50000..50008
    //                              - add field 80800..80808
    //                              - add field 50040 + 50060..50061
    fields
    {
        modify("Document No.")
        {
            TableRelation = "Sales Header Archive".No. WHERE (Document Type=FIELD(Document Type),
                                                              Version No.=FIELD(Version No.));
        }
        modify("No.")
        {
            TableRelation = IF (Type=CONST(" ")) "Standard Text"
                            ELSE IF (Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(Resource)) Resource
                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type=CONST(Item)) "Inventory Posting Group"
                            ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. to Ship"(Field 18)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Quantity Shipped"(Field 60)".

        modify("Purch. Order Line No.")
        {
            TableRelation = IF (Drop Shipment=CONST(Yes)) "Purchase Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                            Document No.=FIELD(Purchase Order No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        modify("Attached to Line No.")
        {
            TableRelation = "Sales Line Archive"."Line No." WHERE (Document Type=FIELD(Document Type),
                                                                   Document No.=FIELD(Document No.),
                                                                   Doc. No. Occurrence=FIELD(Doc. No. Occurrence),
                                                                   Version No.=FIELD(Version No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 96)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                           Document No.=FIELD(Blanket Order No.));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Substitution Available"(Field 5702)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".

        modify("Special Order Purch. Line No.")
        {
            TableRelation = IF (Special Order=CONST(Yes)) "Purchase Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                            Document No.=FIELD(Special Order Purchase No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 5796)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Allow Item Charge Assignment"(Field 5800)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-from Item Entry"(Field 5811)".

        modify("Service Contract No.")
        {
            TableRelation = "Service Contract Header"."Contract No." WHERE (Contract Type=CONST(Contract),
                                                                            Customer No.=FIELD(Sell-to Customer No.),
                                                                            Bill-to Customer No.=FIELD(Bill-to Customer No.));
        }
        field(1700;"Deferral Code";Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(1702;"Returns Deferral Start Date";Date)
        {
            Caption = 'Returns Deferral Start Date';
        }
        field(50000;"Document Date flow";Date)
        {
            CalcFormula = Lookup("Sales Header"."Document Date" WHERE (No.=FIELD(Document No.),
                                                                       Document Type=FIELD(Document Type)));
            Caption = 'Document Date';
            Description = 'CNE1.00';
            FieldClass = FlowField;
        }
        field(50001;"To Prepare";Boolean)
        {
            Caption = 'To Prepare';
            Description = 'CNE1.00';
        }
        field(50002;"Purchase Receipt Date";Date)
        {
            Caption = 'Purchase Receipt Date';
            Description = 'CNE1.00';
        }
        field(50003;"Qty. To Order";Decimal)
        {
            Caption = 'Qty. To Order';
            Description = 'CNE1.00';
        }
        field(50004;"Document Date";Date)
        {
            Description = 'CNE1.00';
        }
        field(50005;"Forecast Inventory";Integer)
        {
            Caption = 'Forecast Inventory';
            Description = 'CNE1.00';
            Editable = false;
        }
        field(50007;"To Order";Boolean)
        {
            Caption = 'To Order';
            Description = 'CNE2.05';
        }
        field(50008;"Promised Purchase Receipt Date";Boolean)
        {
            Caption = 'Purchase Receipt Date';
            Description = 'CNE6.01';
        }
        field(50020;"Customer Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021;"Item Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            Description = 'GRPMARGEPROD SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Item Sales Profit Group";
        }
        field(50022;"Public Price";Decimal)
        {
            Caption = 'Tarif Public';
            DecimalPlaces = 2:5;
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023;"External Document No.";Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe // SU-DADE cf appel TI193466';
        }
        field(50024;"Amount(LCY)";Decimal)
        {
            Caption = 'Amount (LCY)';
            Description = 'Pour Le Besoin De l''Etat Bible';
        }
        field(50025;"Buy-from Vendor No.";Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Description = 'FE004 pour generer demande prix';
            TableRelation = Vendor;
        }
        field(50026;"Purch. Order No.";Code[20])
        {
            Caption = 'Purchase Order No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50027;"Purch. Line No.";Integer)
        {
            Caption = 'Purch. Order Line No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50028;"Purch. Document Type";Option)
        {
            Caption = 'Document Type';
            Description = 'FE004';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50029;"Ordered Quantity";Decimal)
        {
            Caption = 'Ordered Quantity';
            Description = 'FE001.V1';
        }
        field(50030;"Qty Shipped";Decimal)
        {
            Caption = 'Delivered Quantity';
            Description = 'FE001.V1';
            Enabled = false;
        }
        field(50031;"Discount Unit Price";Decimal)
        {
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
        }
        field(50032;"Availability Item";Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
        }
        field(50033;"Outstanding Qty";Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
            Enabled = false;
        }
        field(50040;"Pick Qty.";Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE (Source Type=CONST(37),
                                                                                         Source Subtype=CONST(1),
                                                                                         Source No.=FIELD(Document No.),
                                                                                         Source Line No.=FIELD(Line No.),
                                                                                         Action Type=CONST(Take)));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0:5;
            Description = 'CNE.4.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041;"Purchase Cost";Decimal)
        {
            Caption = 'Purchase cost';
            DecimalPlaces = 2:5;
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
        field(50051;"Affect Purchase Order";Boolean)
        {
            Caption = 'Affect purchase order';
        }
        field(50052;"Order Purchase Affected";Boolean)
        {
            Caption = 'Order purchase affected';
            Editable = false;
        }
        field(50060;"Purchase No. Order Lien";Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            Description = 'CNEIC';
        }
        field(50061;"Purchase No. Line Lien";Integer)
        {
            Caption = 'Purchase No. Line Lien';
            Description = 'CNEIC';
        }
        field(50100;"Item Disc. Group";Code[10])
        {
            Caption = 'Groupe remise article';
            Description = 'CNE1.02';
            TableRelation = "Item Discount Group";
        }
        field(50101;"Dispensation No.";Code[20])
        {
            Caption = 'N° dérogation';
            Description = 'CNE1.02';
        }
        field(50102;"Additional Discount %";Decimal)
        {
            Caption = '% remise complémentaire';
            Description = 'CNE1.02';
        }
        field(50103;"Dispensed Purchase Cost";Decimal)
        {
            Caption = 'Coût d''achat dérogé';
            Description = 'CNE1.02';
        }
        field(50104;"Standard Net Price";Decimal)
        {
            Caption = 'Prix net standard';
            Description = 'CNE1.02';
        }
        field(80800;"DEEE Category Code";Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
        }
        field(80801;"DEEE Unit Price";Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';

            trigger OnValidate()
            var
                RecLCurrency: Record "4";
            begin
            end;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "4";
            begin
            end;
        }
        field(80803;"DEEE Unit Price (LCY)";Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80804;"DEEE VAT Amount";Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805;"DEEE TTC Amount";Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806;"DEEE HT Amount (LCY)";Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807;"Eco partner DEEE";Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
        field(80808;"DEEE Amount (LCY) for Stat";Decimal)
        {
            Description = 'DEEE1.00';
        }
    }
    keys
    {
        key(Key1;"Document Type",Type,"No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: DeferralHeaderArchive)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesCommentLinearch.SETRANGE("Document Type","Document Type");
        SalesCommentLinearch.SETRANGE("No.","Document No.");
        SalesCommentLinearch.SETRANGE("Document Line No.","Line No.");
        SalesCommentLinearch.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        SalesCommentLinearch.SETRANGE("Version No.","Version No.");
        IF NOT SalesCommentLinearch.ISEMPTY THEN
          SalesCommentLinearch.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7

        IF "Deferral Code" <> '' THEN
          DeferralHeaderArchive.DeleteHeader(DeferralUtilities.GetSalesDeferralDocType,
            "Document Type","Document No.","Doc. No. Occurrence","Version No.","Line No.");
        */
    //end;

    procedure ShowDeferrals()
    begin
        DeferralUtilities.OpenLineScheduleArchive(
          "Deferral Code",DeferralUtilities.GetSalesDeferralDocType,
          "Document Type","Document No.",
          "Doc. No. Occurrence","Version No.","Line No.");
    end;

    procedure CopyTempLines(SalesHeaderArchive: Record "5107";var TempSalesLine: Record "37" temporary)
    var
        SalesLineArchive: Record "5108";
    begin
        DELETEALL;

        SalesLineArchive.SETRANGE("Document Type",SalesHeaderArchive."Document Type");
        SalesLineArchive.SETRANGE("Document No.",SalesHeaderArchive."No.");
        SalesLineArchive.SETRANGE("Version No.",SalesHeaderArchive."Version No.");
        IF SalesLineArchive.FINDSET THEN
          REPEAT
            INIT;
            Rec := SalesLineArchive;
            INSERT;
            TempSalesLine.TRANSFERFIELDS(SalesLineArchive);
            TempSalesLine.INSERT;
          UNTIL SalesLineArchive.NEXT = 0;
    end;

    var
        DeferralHeaderArchive: Record "5127";

    var
        DeferralUtilities: Codeunit "1720";
}

