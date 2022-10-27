tableextension 50070 tableextension50070 extends "Return Receipt Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //Demande de prix FE004 06/12/2006 ajout du champ 50025 "Buy-from Vendor No."
    //                   FE004.2 11/12/2006 ajout champ 50026 et 50027
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
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 09/11/2007 : Suivi historique
    //                - Add key "No."
    // ------------------------------------------------------------------------
    LookupPageID = 6663;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (G/L Account)) "G/L Account"
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

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order No."(Field 97)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                           Document No.=FIELD(Blanket Order No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Line No."(Field 98)".

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
        field(50041;"Purchase Cost";Decimal)
        {
            Caption = 'Purchase cost';
            DecimalPlaces = 2:5;
            Description = 'hors taxe';
            Editable = false;

            trigger OnValidate()
            begin
                //COUT_ACHAT FG 20/12/06 NSC1.01
                //>>Propagation CASC 18/01/2007
                //CalcProfit ;
                //<<Propagation CASC 18/01/2007
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
    }
    keys
    {
        key(Key1;"No.")
        {
        }
    }

    //Unsupported feature: Variable Insertion (Variable: ItemTrackingDocMgt) (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ShowItemTrackingLines(PROCEDURE 3)".

    //procedure ShowItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemTrackingMgt.CallPostedItemTrackingForm(DATABASE::"Return Receipt Line",0,"Document No.",'',0,"Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForShptRcptLine(DATABASE::"Return Receipt Line",0,"Document No.",'',0,"Line No.");
        */
    //end;


    //Unsupported feature: Code Modification on "InsertInvLineFromRetRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRetRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETRANGE("Document No.","Document No.");

        TempSalesLine := SalesLine;
        #4..82
            SalesLine."Allow Line Disc." := SalesOrderLine."Allow Line Disc.";
            SalesLine."Allow Invoice Disc." := SalesOrderLine."Allow Invoice Disc.";
            SalesLine.VALIDATE("Line Discount %",SalesOrderLine."Line Discount %");
            IF NOT SalesSetup."Calc. Inv. Discount" THEN
              SalesLine.VALIDATE("Inv. Discount Amount",SalesOrderLine."Inv. Discount Amount");
          END;
          SalesLine."Attached to Line No." :=
            TransferOldExtLines.TransferExtendedText(
              SalesOrderLine."Line No.",
              NextLineNo,
              SalesOrderLine."Attached to Line No.");
          SalesLine."Shortcut Dimension 1 Code" := SalesOrderLine."Shortcut Dimension 1 Code";
          SalesLine."Shortcut Dimension 2 Code" := SalesOrderLine."Shortcut Dimension 2 Code";
          SalesLine."Dimension Set ID" := SalesOrderLine."Dimension Set ID";
        #97..107
          SalesOrderHeader."Get Shipment Used" := TRUE;
          SalesOrderHeader.MODIFY;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..85
            IF SalesOrderLine.Quantity = 0 THEN
              SalesLine.VALIDATE("Inv. Discount Amount",0)
            ELSE
              SalesLine.VALIDATE(
                "Inv. Discount Amount",
                ROUND(
                  SalesOrderLine."Inv. Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                  Currency."Amount Rounding Precision"));
        #88..92
              "Attached to Line No.");
        #94..110
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetSalesCrMemoLines(PROCEDURE 4)".


    procedure InitFromSalesLine(ReturnRcptHeader: Record "6660";SalesLine: Record "37")
    begin
        INIT;
        TRANSFERFIELDS(SalesLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := ReturnRcptHeader."Posting Date";
        "Document No." := ReturnRcptHeader."No.";
        Quantity := SalesLine."Return Qty. to Receive";
        "Quantity (Base)" := SalesLine."Return Qty. to Receive (Base)";
        IF ABS(SalesLine."Qty. to Invoice") > ABS(SalesLine."Return Qty. to Receive") THEN BEGIN
          "Quantity Invoiced" := SalesLine."Return Qty. to Receive";
          "Qty. Invoiced (Base)" := SalesLine."Return Qty. to Receive (Base)";
        END ELSE BEGIN
          "Quantity Invoiced" := SalesLine."Qty. to Invoice";
          "Qty. Invoiced (Base)" := SalesLine."Qty. to Invoice (Base)";
        END;
        "Return Qty. Rcd. Not Invd." :=
          Quantity - "Quantity Invoiced";
        IF SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" THEN BEGIN
          "Return Order No." := SalesLine."Document No.";
          "Return Order Line No." := SalesLine."Line No.";
        END;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3).ItemTrackingMgt(Variable 1000)".

}

