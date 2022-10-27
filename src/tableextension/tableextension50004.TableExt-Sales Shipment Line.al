tableextension 50004 tableextension50004 extends "Sales Shipment Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //Demande de prix FE004 06/12/2006 ajout du champ 50025 "Buy-from Vendor No."
    //                   FE004.2 11/12/2006 ajout champ 50026 à 50028
    // //Commercials States CASC 15/12/2006 NSC1.01 [FE001.V1]: Add fields
    //                                                          50029 Ordered Quantity
    //                                                          50030 Delivered Quantity
    //                                                          50031 Outstanding Quantity
    //                                                          50032 Availability Item
    // //BIBLE FG 19/12/06 NSC1.01 Création clé Document No.,Sell-to Customer No.,No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                         50031 Discount Unit Price
    // //REGR_BL FG 27/02/07 ajout information
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //REGR_BL TODOLIST 100 DARI 20/04/07 : Add and modify informations about shipment
    // //REGR_BL TODOLIST 100 DARI 20/04/07 : Add and modify informations about shipment
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - add field 50100 to 50104
    // --------------------------------------------------------------------------
    // //>>CNIC : 06/2015 : ajout des champs 50060 et 5006 ==> Hérité de la table 37
    // //>>MIGRATION NAV 2013 - 2017
    // //>>FE001.V1.NSC1 CASC
    LookupPageID = 525;
    DrillDownPageID = 525;
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


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. Shipped Not Invoiced"(Field 58)".


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


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".


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
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023;"External Document No.";Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe';

            trigger OnLookup()
            var
                Rec_ShptHeader: Record "110";
                PagLSalesShipments: Page "142";
            begin
                  //OnLooKupCode HJ 31/10/06 NSC1.01 [18] Code Necessaire pour permettre
                 // l'affichage de la forme 5708 l'ors du clic sur le champ N° Doc Externe

                  Rec_ShptHeader.RESET;
                  Rec_ShptHeader.SETFILTER(Rec_ShptHeader."External Document No.","External Document No.");
                  IF Rec_ShptHeader.FIND('-') THEN
                    BEGIN
                      PagLSalesShipments.SETRECORD(Rec_ShptHeader);
                      PagLSalesShipments.RUN;
                    END;

                  //Fin OnLooKupCode HJ 31/10/06  NSC1.01 [18] Code Necessaire pour permettre
                 // l'affichage de la forme 5708 l'ors du clic sur le champ N° Doc Externe
            end;
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
        field(50033;"Outstanding Quantity";Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
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
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Blanket Order No.,Blanket Order Line No."(Key)".

        key(Key1;"Document No.","Sell-to Customer No.","No.")
        {
        }
        key(Key2;"No.")
        {
        }
        key(Key3;Type,"No.")
        {
        }
    }

    //Unsupported feature: Variable Insertion (Variable: ItemTrackingDocMgt) (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 6500)".



    //Unsupported feature: Code Modification on "ShowItemTrackingLines(PROCEDURE 6500)".

    //procedure ShowItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemTrackingMgt.CallPostedItemTrackingForm(DATABASE::"Sales Shipment Line",0,"Document No.",'',0,"Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForShptRcptLine(DATABASE::"Sales Shipment Line",0,"Document No.",'',0,"Line No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: LanguageManagement) (VariableCollection) on "InsertInvLineFromShptLine(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: RecLSalesShipmentHeader) (VariableCollection) on "InsertInvLineFromShptLine(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "InsertInvLineFromShptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromShptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETRANGE("Document No.","Document No.");

        TempSalesLine := SalesLine;
        IF SalesLine.FIND('+') THEN
          NextLineNo := SalesLine."Line No." + 10000
        ELSE
          NextLineNo := 10000;

        IF SalesInvHeader."No." <> TempSalesLine."Document No." THEN
          SalesInvHeader.GET(TempSalesLine."Document Type",TempSalesLine."Document No.");

        IF SalesLine."Shipment No." <> "Document No." THEN BEGIN
          SalesLine.INIT;
          SalesLine."Line No." := NextLineNo;
          SalesLine."Document Type" := TempSalesLine."Document Type";
          SalesLine."Document No." := TempSalesLine."Document No.";
          SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
          SalesLine.INSERT;
          NextLineNo := NextLineNo + 10000;
        END;

        TransferOldExtLines.ClearLineNumbers;

        REPEAT
          ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

          IF SalesOrderLine.GET(
               SalesOrderLine."Document Type"::Order,"Order No.","Order Line No.")
          THEN BEGIN
            IF (SalesOrderHeader."Document Type" <> SalesOrderLine."Document Type"::Order) OR
               (SalesOrderHeader."No." <> SalesOrderLine."Document No.")
            THEN
              SalesOrderHeader.GET(SalesOrderLine."Document Type"::Order,"Order No.");

            InitCurrency("Currency Code");

            IF SalesInvHeader."Prices Including VAT" THEN BEGIN
              IF NOT SalesOrderHeader."Prices Including VAT" THEN
                SalesOrderLine."Unit Price" :=
                  ROUND(
                    SalesOrderLine."Unit Price" * (1 + SalesOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END ELSE BEGIN
              IF SalesOrderHeader."Prices Including VAT" THEN
                SalesOrderLine."Unit Price" :=
                  ROUND(
                    SalesOrderLine."Unit Price" / (1 + SalesOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END;
          END ELSE BEGIN
            SalesOrderHeader.INIT;
            IF ExtTextLine OR (Type = Type::" ") THEN BEGIN
              SalesOrderLine.INIT;
              SalesOrderLine."Line No." := "Order Line No.";
              SalesOrderLine.Description := Description;
              SalesOrderLine."Description 2" := "Description 2";
            END ELSE
              ERROR(Text001);
          END;

          SalesLine := SalesOrderLine;
          SalesLine."Line No." := NextLineNo;
          SalesLine."Document Type" := TempSalesLine."Document Type";
          SalesLine."Document No." := TempSalesLine."Document No.";
          SalesLine."Variant Code" := "Variant Code";
          SalesLine."Location Code" := "Location Code";
          SalesLine."Quantity (Base)" := 0;
          SalesLine.Quantity := 0;
          SalesLine."Outstanding Qty. (Base)" := 0;
          SalesLine."Outstanding Quantity" := 0;
          SalesLine."Quantity Shipped" := 0;
          SalesLine."Qty. Shipped (Base)" := 0;
          SalesLine."Quantity Invoiced" := 0;
          SalesLine."Qty. Invoiced (Base)" := 0;
          SalesLine.Amount := 0;
          SalesLine."Amount Including VAT" := 0;
          SalesLine."Purchase Order No." := '';
          SalesLine."Purch. Order Line No." := 0;
          SalesLine."Drop Shipment" := "Drop Shipment";
          SalesLine."Special Order Purchase No." := '';
          SalesLine."Special Order Purch. Line No." := 0;
          SalesLine."Special Order" := FALSE;
          SalesLine."Shipment No." := "Document No.";
          SalesLine."Shipment Line No." := "Line No.";
          SalesLine."Appl.-to Item Entry" := 0;
          SalesLine."Appl.-from Item Entry" := 0;
          SalesLine."Prepmt. Amt. Inv." := 0;
          IF NOT ExtTextLine AND (SalesLine.Type <> 0) THEN BEGIN
            SalesLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            SalesLine.VALIDATE("Unit Price",SalesOrderLine."Unit Price");
            SalesLine."Allow Line Disc." := SalesOrderLine."Allow Line Disc.";
            SalesLine."Allow Invoice Disc." := SalesOrderLine."Allow Invoice Disc.";
            SalesLine.VALIDATE(
              "Line Discount Amount",
              ROUND(
                SalesOrderLine."Line Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                Currency."Amount Rounding Precision"));
            SalesLine."Line Discount %" := SalesOrderLine."Line Discount %";
            SalesLine.UpdatePrePaymentAmounts;
            SalesSetup.GET;
            IF NOT SalesSetup."Calc. Inv. Discount" THEN
              IF SalesOrderLine.Quantity = 0 THEN
                SalesLine.VALIDATE("Inv. Discount Amount",0)
              ELSE BEGIN
                SalesLine.VALIDATE(
                  "Inv. Discount Amount",
                  ROUND(
                    SalesOrderLine."Inv. Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                    Currency."Amount Rounding Precision"));
                SalesLine.VALIDATE("Prepmt. Amt. Inv.",SalesOrderLine."Prepmt. Amt. Inv.");
              END;
          END;

          SalesLine."Attached to Line No." :=
            TransferOldExtLines.TransferExtendedText(
              SalesOrderLine."Line No.",
              NextLineNo,
              SalesOrderLine."Attached to Line No.");
          SalesLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
          SalesLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
          SalesLine."Dimension Set ID" := "Dimension Set ID";
          SalesLine.INSERT;

          ItemTrackingMgt.CopyHandledItemTrkgToInvLine(SalesOrderLine,SalesLine);

          NextLineNo := NextLineNo + 10000;
          IF "Attached to Line No." = 0 THEN
            SETRANGE("Attached to Line No.","Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);

        IF SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order,"Order No.") THEN BEGIN
          SalesOrderHeader."Get Shipment Used" := TRUE;
          SalesOrderHeader.MODIFY;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
          LanguageManagement.SetGlobalLanguageByCode(SalesInvHeader."Language Code");
          //>>MIGRATION NAV 2013
          //STD SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
          //>>REGR_BL TODOLIST 100 DARI 20/04/07
          // //>>REGR_BL FG 27/02/07 ajout information
          // STD ??? //SalesLine.Description := STRSUBSTNO(Text000,"Document No.");

          //  RecLSalesShipmentHeader.GET("Document No.") ;
          //  SalesLine.Description := COPYSTR(
          //                             STRSUBSTNO(CstG1000000000,
          //                               RecLSalesShipmentHeader."Your Reference",
          //                                 "Document No.",
          //                                   RecLSalesShipmentHeader."Posting Date",
          //                                     "Order No."),1,50) ;
          //<<REGR_BL FG 27/02/07 ajout information
          //SalesLine.INSERT;
          //NextLineNo := NextLineNo + 10000;

          //SalesLine.Description := STRSUBSTNO(Text000,"Document No.");

            RecLSalesShipmentHeader.GET("Document No.") ;
            //>>REGR_BL TODOLIST 100 DARI 20/04/07
            {SalesLine.Description := COPYSTR(
                                       STRSUBSTNO(CstG1000000000,
                                           "Document No.",
                                             RecLSalesShipmentHeader."Posting Date"
                                            ),1,50) ;}
            SalesLine.Description := COPYSTR(
                                       STRSUBSTNO(CstG1000000000,
                                           "Document No.",
                                             RecLSalesShipmentHeader."Posting Date","Order No."
                                            ),1,50) ;
           //<<REGR_BL TODOLIST 100 DARI 20/04/07

          //<<REGR_BL FG 27/02/07 ajout information
          LanguageManagement.RestoreGlobalLanguage;
          SalesLine.INSERT;
          NextLineNo := NextLineNo + 10000;
          //                                   Line number 2 //
          SalesLine.INIT;
        #62..64

          //>>REGR_BL TODOLIST 100 DARI 20/04/07
            {SalesLine.Description := COPYSTR(
                                       STRSUBSTNO(CstG1000000002,
                                         CstG1000000001,
                                         RecLSalesShipmentHeader."Your Reference",
                                               "Order No."),1,50) ;}
            SalesLine.Description := COPYSTR(
                                       STRSUBSTNO(CstG1000000002,
                                         CstG1000000001,
                                         RecLSalesShipmentHeader."Your Reference"),1,50);
          //<<REGR_BL TODOLIST 100 DARI 20/04/07

          SalesLine.INSERT;
          NextLineNo := NextLineNo + 10000;
          //>>REGR_BL TODOLIST 100 DARI 20/04/07
         //<<MIGRATION NAV 2013
        #20..26
          IF (Type <> Type::" ") AND SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Order No.","Order Line No.")
        #29..86
          IF NOT ExtTextLine AND (SalesLine.Type <> 0) THEN BEGIN
            SalesLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            CalcBaseQuantities(SalesLine,"Quantity (Base)" / Quantity);
        #90..92
            SalesOrderLine."Line Discount Amount" :=
              ROUND(
                SalesOrderLine."Line Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                Currency."Amount Rounding Precision");
            IF SalesInvHeader."Prices Including VAT" THEN BEGIN
              IF NOT SalesOrderHeader."Prices Including VAT" THEN
                SalesOrderLine."Line Discount Amount" :=
                  ROUND(
                    SalesOrderLine."Line Discount Amount" *
                    (1 + SalesOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            END ELSE BEGIN
              IF SalesOrderHeader."Prices Including VAT" THEN
                SalesOrderLine."Line Discount Amount" :=
                  ROUND(
                    SalesOrderLine."Line Discount Amount" /
                    (1 + SalesOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            END;
            SalesLine.VALIDATE("Line Discount Amount",SalesOrderLine."Line Discount Amount");
            SalesLine."Line Discount %" := SalesOrderLine."Line Discount %";
            SalesLine.UpdatePrePaymentAmounts;
            IF SalesOrderLine.Quantity = 0 THEN
              SalesLine.VALIDATE("Inv. Discount Amount",0)
            ELSE
              SalesLine.VALIDATE(
                "Inv. Discount Amount",
                ROUND(
                  SalesOrderLine."Inv. Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                  Currency."Amount Rounding Precision"));
        #112..117
              "Attached to Line No.");
        #119..134
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetSalesInvLines(PROCEDURE 4)".


    procedure InitFromSalesLine(SalesShptHeader: Record "110";SalesLine: Record "37")
    begin
        INIT;
        TRANSFERFIELDS(SalesLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := SalesShptHeader."Posting Date";
        "Document No." := SalesShptHeader."No.";
        Quantity := SalesLine."Qty. to Ship";
        "Quantity (Base)" := SalesLine."Qty. to Ship (Base)";
        //>>MIGRATION NAV 2013 - 2017
        //>>FE001.V1.NSC1 CASC
        "Ordered Quantity" := SalesLine.Quantity;
        "Outstanding Quantity" := SalesLine."Outstanding Quantity" - SalesLine."Qty. to Ship";
        "Qty Shipped" := SalesLine."Quantity Shipped" + SalesLine."Qty. to Ship";
        //<<FE001.V1.NSC1 CASC
        //<<MIGRATION NAV 2013

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

    local procedure CalcBaseQuantities(var SalesLine: Record "37";QtyFactor: Decimal)
    begin
        SalesLine."Quantity (Base)" := ROUND(SalesLine.Quantity * QtyFactor,0.00001);
        SalesLine."Qty. to Asm. to Order (Base)" := ROUND(SalesLine."Qty. to Assemble to Order" * QtyFactor,0.00001);
        SalesLine."Outstanding Qty. (Base)" := ROUND(SalesLine."Outstanding Quantity" * QtyFactor,0.00001);
        SalesLine."Qty. to Ship (Base)" := ROUND(SalesLine."Qty. to Ship" * QtyFactor,0.00001);
        SalesLine."Qty. Shipped (Base)" := ROUND(SalesLine."Quantity Shipped" * QtyFactor,0.00001);
        SalesLine."Qty. Shipped Not Invd. (Base)" := ROUND(SalesLine."Qty. Shipped Not Invoiced" * QtyFactor,0.00001);
        SalesLine."Qty. to Invoice (Base)" := ROUND(SalesLine."Qty. to Invoice" * QtyFactor,0.00001);
        SalesLine."Qty. Invoiced (Base)" := ROUND(SalesLine."Quantity Invoiced" * QtyFactor,0.00001);
        SalesLine."Return Qty. to Receive (Base)" := ROUND(SalesLine."Return Qty. to Receive" * QtyFactor,0.00001);
        SalesLine."Return Qty. Received (Base)" := ROUND(SalesLine."Return Qty. Received" * QtyFactor,0.00001);
        SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := ROUND(SalesLine."Return Qty. Rcd. Not Invd." * QtyFactor,0.00001);
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "2000000041";
    begin
        Field.GET(DATABASE::"Sales Shipment Line",FieldNumber);
        EXIT(Field."Field Caption");
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    begin
        CASE FieldNumber OF
          FIELDNO("No."):
            BEGIN
              IF ApplicationAreaSetup.IsFoundationEnabled THEN
                EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
              EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
            END;
        END;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 6500).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "InsertInvLineFromShptLine(PROCEDURE 2).SalesSetup(Variable 1010)".


    var
        ApplicationAreaSetup: Record "9178";

    var
        CstG1000000000: Label '%1-%2-%3-%4';
        "--CstG1000000000": Label '%1-%2-%3-%4';
        CstG1000000001: Label 'Your Reference : ';
        CstG1000000002: Label '%1 %2';

    var
        ItemNoFieldCaptionTxt: Label 'Item No.';
}

