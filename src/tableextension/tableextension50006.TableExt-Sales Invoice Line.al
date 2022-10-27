tableextension 50006 tableextension50006 extends "Sales Invoice Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //Demande de prix FE004 06/12/2006 ajout du champ 50025 "Buy-from Vendor No."
    //                   FE004.2 11/12/2006 ajout champ 50026 à 50028
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                         50024 Amount(LCY)
    //                                         50029 Ordered Quantity
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800..80807
    //           - Update Function CalcVATAmountLines
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 09/11/2007 :Suivi des historiques
    //           - Add key "No."
    // FEP-ADVE-200706_18_E:MA 14/11/2007
    //           - Add Key "Buy-from Vendor No."
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - add field 50100 to 50104
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 526;
    DrillDownPageID = 526;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(Resource)) Resource
                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";
            CaptionClass = GetCaptionClass(FIELDNO("No."));
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

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                           Document No.=FIELD(Blanket Order No.));
        }
        modify("Bin Code")
        {
            TableRelation = Bin.Code WHERE (Location Code=FIELD(Location Code),
                                            Item Filter=FIELD(No.),
                                            Variant Filter=FIELD(Variant Code));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-from Item Entry"(Field 5811)".

        field(84;"Tax Category";Code[10])
        {
            Caption = 'Tax Category';
        }
        field(1700;"Deferral Code";Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";
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
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023;"External Document No.";Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe';
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
            Caption = 'Discount unit price';
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
        field(50041;"Purchase Cost";Decimal)
        {
            Caption = 'Purchase cost';
            Editable = false;
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
            Editable = true;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80803;"DEEE Bases VAT Amount";Decimal)
        {
            Caption = 'DEEE Bases VAT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80804;"DEEE VAT Amount";Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80805;"DEEE TTC Amount";Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80806;"DEEE HT Amount (LCY)";Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = true;
        }
        field(80807;"Eco partner DEEE";Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (Enabled) on ""Sell-to Customer No.,Type,Document No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Blanket Order No.,Blanket Order Line No."(Key)".

        key(Key1;"No.")
        {
        }
        key(Key2;"Buy-from Vendor No.")
        {
        }
        key(Key3;"Document No.","No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostedDeferralHeader)()
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
        SalesDocLineComments.SETRANGE("Document Type",SalesDocLineComments."Document Type"::"Posted Invoice");
        SalesDocLineComments.SETRANGE("No.","Document No.");
        SalesDocLineComments.SETRANGE("Document Line No.","Line No.");
        IF NOT SalesDocLineComments.ISEMPTY THEN
          SalesDocLineComments.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5

        PostedDeferralHeader.DeleteHeader(DeferralUtilities.GetSalesDeferralDocType,'','',
          SalesDocLineComments."Document Type"::"Posted Invoice","Document No.","Line No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemTrackingDocMgt) (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ShowItemTrackingLines(PROCEDURE 3)".

    //procedure ShowItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemTrackingMgt.CallPostedItemTrackingForm3(RowID1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForInvoiceLine(RowID1);
        */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 2)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VATAmountLine.DELETEALL;
        SETRANGE("Document No.",SalesInvHeader."No.");
        IF FIND('-') THEN
          REPEAT
            VATAmountLine.INIT;
            VATAmountLine."VAT Identifier" := "VAT Identifier";
            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
            VATAmountLine."Tax Group Code" := "Tax Group Code";
            VATAmountLine."VAT %" := "VAT %";
            VATAmountLine."VAT Base" := Amount;
            VATAmountLine."VAT Amount" := "Amount Including VAT" - Amount;
            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
            VATAmountLine."Line Amount" := "Line Amount";
            IF "Allow Invoice Disc." THEN
              VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
            VATAmountLine.Quantity := "Quantity (Base)";
            VATAmountLine."Calculated VAT Amount" := "Amount Including VAT" - Amount - "VAT Difference";
            VATAmountLine."VAT Difference" := "VAT Difference";
            VATAmountLine.InsertLine;
          UNTIL NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempVATAmountLine.DELETEALL;
        #2..4
            TempVATAmountLine.INIT;
            TempVATAmountLine.CopyFromSalesInvLine(Rec);

            //>>MIGRATION NAV 2013
            //>>DEEE1.00 : Update DEEE Amount for the VAT line (stat F9)
            TempVATAmountLine."DEEE HT Amount":=TempVATAmountLine."DEEE HT Amount"+"DEEE HT Amount" ;
            TempVATAmountLine."DEEE VAT Amount":=TempVATAmountLine."DEEE VAT Amount"+"DEEE VAT Amount" ;
            TempVATAmountLine."DEEE TTC Amount":=TempVATAmountLine."DEEE TTC Amount"+"DEEE TTC Amount" ;

            IF "Allow Invoice Disc." THEN
              TempVATAmountLine."Inv. Disc. Base Amount" := TempVATAmountLine."Inv. Disc. Base Amount"+"DEEE HT Amount" ;

            //<<DEEE1.00 : Update DEEE Amount for the VAT line (stat F9)
            //<<MIGRATION NAV 2013

            TempVATAmountLine.InsertLine;
          UNTIL NEXT = 0;
        */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT SalesInvHeader.GET("Document No.") THEN
          SalesInvHeader.INIT;
        IF SalesInvHeader."Prices Including VAT" THEN
          EXIT('2,1,' + GetFieldCaption(FieldNumber));

        EXIT('2,0,' + GetFieldCaption(FieldNumber));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT SalesInvHeader.GET("Document No.") THEN
          SalesInvHeader.INIT;
        CASE FieldNumber OF
          FIELDNO("No."):
            BEGIN
              IF ApplicationAreaSetup.IsFoundationEnabled THEN
                EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
              EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
            END;
          ELSE BEGIN
            IF SalesInvHeader."Prices Including VAT" THEN
              EXIT('2,1,' + GetFieldCaption(FieldNumber));
            EXIT('2,0,' + GetFieldCaption(FieldNumber));
          END
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetSalesShptLines(PROCEDURE 4)".


    procedure InitFromSalesLine(SalesInvHeader: Record "112";SalesLine: Record "37")
    begin
        INIT;
        TRANSFERFIELDS(SalesLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := SalesInvHeader."Posting Date";
        "Document No." := SalesInvHeader."No.";
        Quantity := SalesLine."Qty. to Invoice";
        "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";
    end;

    procedure ShowDeferrals()
    begin
        DeferralUtilities.OpenLineScheduleView(
          "Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
          GetDocumentType,"Document No.","Line No.");
    end;

    procedure GetDocumentType(): Integer
    var
        SalesCommentLine: Record "44";
    begin
        EXIT(SalesCommentLine."Document Type"::"Posted Invoice")
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Property Deletion (AsVar) on "CalcVATAmountLines(PROCEDURE 2).SalesInvHeader(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CalcVATAmountLines(PROCEDURE 2).VATAmountLine(Parameter 1001)".


    //Unsupported feature: Property Insertion (Temporary) on "CalcVATAmountLines(PROCEDURE 2).VATAmountLine(Parameter 1001)".


    var
        PostedDeferralHeader: Record "1704";

    var
        ApplicationAreaSetup: Record "9178";

    var
        DeferralUtilities: Codeunit "1720";
        ItemNoFieldCaptionTxt: Label 'Item No.';
}

