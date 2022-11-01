tableextension 50036 "BC6_SalesLine" extends "Sales Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //VENTES BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
    // //MARGE  SOBH           NSC1.01 [024] Marge Ventes
    // //GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020,50021 et CALCULE des marges vente
    // //TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50022 Tarif public + ramener le prix depuis la table Prix d'achat 7012
    // //Demande de prix FE004 06/12/2006 ajout du champ 50025 "Buy-from Vendor No."
    //                                    ajout de la clef "Document Type","Buy-from Vendor No."
    //                   FE004.2 11/12/2006 ajout champ 50026 à 50028 et controle sur delete
    // // blocage devis FE015 FLGR 07/12/2006
    // //GESTION_REMISE FG 06/12/06 NSC1.01
    // //Process achat vente FE25/26 FLGR 14/12/2006 modif gestion prix public ajout fonction calcprofit et calcunitprice;
    // //BIBLE FG 19/12/06 NSC1.01 Création clé Document Type,Document No.,Sell-to Customer No.,No.
    // //PRIX_VENTE_REMISE FG 20/12/06 NSC1.01
    // //COUT_ACHAT FG 20/12/06 NSC1.01
    // //CASC 12/01/2007 NSC1.01 : To authorize 5 figures after the comma on fields Purchase cost and Public Price
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                         50024 Amount(LCY)
    //                                         50029 Ordered Quantity
    // //FE004.4 ajout lookup sur commande d'achat liée à la ligne.
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80002..80007
    //           - OnInsert()
    //           - No. - OnValidate()
    //           - Quantity - OnValidate()
    //           - CalcVATAmountLines
    //           - Add function CalculateDEEE
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 09/11/2007 : - Suivi des historiques
    //                                          - Add key "No."
    // 
    // //TODOLIST point 49  FLGR 07/02/2007 : autorisation modification du cout d'achat => purchase cost : editable = true !
    //                                        bien avoir conscience que si un doc d'achat et lié, c'est la valeur du doc d'achat
    //                                        qui serat mise à jour si on lance la cmd / devis, si il y a validation
    //                                        des champs qte prix uitaire , etc... ou modification de l'article etc ...
    //                                        et que par conséquent la saisie manuelle serat perdue
    // 
    // //TODOLIST point 54 FLGR 07/02/2007 : modif affichage des decimaux => modification format des champs 50022, 50031 et 50041
    // //>>DEEE1.01:FLGR 19/02/2007 correct bug in quotes with customer template
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // //>>NSC2.01
    // FE032.001:PA 21/05/2007 : Quantity Modification
    //                           - Don't modify the Price, Discount %, Merge %, Purchase Cost When quantity modification.
    // 
    // //>>NSC02.02
    // TDL94.001:PA 24/05/2007 : Correct DEEE Stat
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 08/11/2007 : Achats groupés
    //                                           - Add Field 50001 : "To Prepare"
    // 
    // FEP-ACHAT-200706_18_A.001:MA 09/11/2007 : Achats groupés
    //                                           - Add Field 50002 : "Purchase Receipt Date"
    // 
    // FEP-ACHAT-200706_18_A.001:MA 12/11/2007 : Achats groupés
    //                                           - Add Field 50003 : "Qty. To Order"
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 13/11/2007 : Achats groupés
    //                                           - Add Field 50005 : "Forecast Inventory"
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 15/11/2007 : Achats groupés
    //                                           - Add Keys :
    //                                               "Buy-from Vendor No.","Shipment Date"
    //                                               "Buy-from Vendor No.","No.","Shipment Date"
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 19/11/2007 : Achats groupés
    //                                           - Add Field 50007 : "To Order"
    // 
    // //CNE2.05
    // FEP-ACHAT-200706_18_A.001 09/01/2008 : - Change CaptionML
    // FEP-ACHAT-200706_18_A.002 15/01/2008 : - Add test if a Purchase Order always existing for this sales line.
    //                                        - Add key
    //                                          "Buy-from Vendor No.","Qty. To Order","To Order"
    // 
    // //>>SUP_CNE1.00.00.01
    // I005590.001 : DO 02/04/2008 : Modify Qty to Order affectation
    // 
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - calc line discount %
    // 
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change Qty To order Affectation
    // 
    // //>> MODIF HL 28/01/2010 SU-LALE cf appel I016274
    //                        Ajout clé de tri To Order,Buy-from Vendor No.,No.,Purchase cost,Qty. To Order
    // 
    // //>> CNE4.01
    // B:FE06 01.09.2011 : Sales Order Line - Show Quantity on Invt Pick List
    //                   - Add Field : 50040 Pick Qty
    // 
    // //>> CNE4.02
    // C:FE09 05.10.2011 : Availability Customer Area - Shipping Bin
    //                   - Mod Function GetDefaultBin
    // 
    // //>> CNE6.01
    // TDL:EC11 12.12.2014 : Not Group By Item
    //                       - Add Key To Order,Buy-from Vendor No.,Document No.,Line No.,Qty. To Order
    // 
    // //>>MODIF HL
    // TI271161 DO.GEPO 24/03/2015 : add new key "Shimpment Date","Document Type","Sell-to Customer No.","Document No.","Line No."
    // 
    // 
    // ---------------------------------------------------------------------------------------------------------------------------------
    // //>>PWD(SPI) : le 01/06/15 : Temporaire : on force le fournisseur CNE pour le nouvelle sté.
    // //>>CNEIC : 06/2015 : Ajout des champs 50060 et 50061 pour le lien avec la ligne de commande Achat.
    //                       Validate sur le champ "Purchase cost" lors du passage du Item."Standard Cost"
    //                       Si sté non filiale + commande pour IC ==> Prix unitaire = Prix d'achat.
    // 
    // //>>TI301087 : RO : 08/12/2015
    //                     - Add Keys
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code,Drop Shipment
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code,Buy-from Vendor No.,Shipment Date
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code,Drop Shipment,Buy-from Vendor No.,No.,Shipment Date
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code,Buy-from Vendor No.,No.,Shipment Date
    //                              Document Type,Type,Outstanding Quantity,Purchasing Code,Drop Shipment,Buy-from Vendor No.,Shipment Date
    // 
    // //BCSYS 260418 ajout date facturation prévue = shipment date
    LookupPageID = 516;
    DrillDownPageID = 516;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST(G/L Account),
                                     System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
                                                                                          Account Type=CONST(Posting),
                                                                                          Blocked=CONST(No))
                                                                                          ELSE IF (Type=CONST(G/L Account),
                                                                                                   System-Created Entry=CONST(Yes)) "G/L Account"
                                                                                                   ELSE IF (Type=CONST(Item)) Item
                                                                                                   ELSE IF (Type=CONST(Resource)) Resource
                                                                                                   ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                                   ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""No."(Field 6)".

            CaptionClass = GetCaptionClass(FIELDNO("No."));
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type=CONST(Item)) "Inventory Posting Group"
                            ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipment Date"(Field 10)".

        modify(Description)
        {
            Caption = 'Description';
            TableRelation = IF (Type=CONST(G/L Account),
                                System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
                                                                                     Account Type=CONST(Posting),
                                                                                     Blocked=CONST(No))
                                                                                     ELSE IF (Type=CONST(G/L Account),
                                                                                              System-Created Entry=CONST(Yes)) "G/L Account"
                                                                                              ELSE IF (Type=CONST(Item)) Item
                                                                                              ELSE IF (Type=CONST(Resource)) Resource
                                                                                              ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                              ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

            //Unsupported feature: Property Insertion (ValidateTableRelation) on "Description(Field 11)".

        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. to Ship"(Field 18)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".

        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1),
                                                          Blocked=CONST(No));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2),
                                                          Blocked=CONST(No));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Quantity Shipped"(Field 60)".

        modify("Profit %")
        {

            //Unsupported feature: Property Modification (DecimalPlaces) on ""Profit %"(Field 67)".


            //Unsupported feature: Property Modification (Editable) on ""Profit %"(Field 67)".

            Description = 'GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Editable = yes';
        }
        modify("Inv. Discount Amount")
        {
            CaptionClass = GetCaptionClass(FIELDNO("Inv. Discount Amount"));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Purchase Order No."(Field 71)".

        modify("Purch. Order Line No.")
        {
            TableRelation = IF (Drop Shipment=CONST(Yes)) "Purchase Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                            Document No.=FIELD(Purchase Order No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Purch. Order Line No."(Field 72)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        modify("Attached to Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=FIELD(Document Type),
                                                           Document No.=FIELD(Document No.));
        }

        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Tax Group Code"(Field 87)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 95)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Quantity"(Field 95)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 96)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order No."(Field 97)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                           Document No.=FIELD(Blanket Order No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Line No."(Field 98)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Partner Ref. Type"(Field 107)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Partner Reference"(Field 108)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. to Assemble to Order"(Field 900)".


        //Unsupported feature: Property Modification (CalcFormula) on ""ATO Whse. Outstanding Qty."(Field 902)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""ATO Whse. Outstanding Qty."(Field 902)".


        //Unsupported feature: Property Modification (CalcFormula) on ""ATO Whse. Outstd. Qty. (Base)"(Field 903)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""ATO Whse. Outstd. Qty. (Base)"(Field 903)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Contract Entry No."(Field 1002)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Posting Date"(Field 1300)".

        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item),
                                No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                                ELSE IF (Type=CONST(Resource),
                                         No.=FILTER(<>'')) "Resource Unit of Measure".Code WHERE (Resource No.=FIELD(No.))
                                         ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. (Base)"(Field 5495)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. (Base)"(Field 5495)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""FA Posting Date"(Field 5600)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Depr. until FA Posting Date"(Field 5605)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Duplication List"(Field 5613)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Substitution Available"(Field 5702)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered No."(Field 5703)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered Var. Code"(Field 5704)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Unit of Measure (Cross Ref.)"(Field 5706)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Nonstock(Field 5710)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Purchasing Code"(Field 5711)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order"(Field 5713)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order Purchase No."(Field 5714)".

        modify("Special Order Purch. Line No.")
        {
            TableRelation = IF (Special Order=CONST(Yes)) "Purchase Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                            Document No.=FIELD(Special Order Purchase No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order Purch. Line No."(Field 5715)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Whse. Outstanding Qty."(Field 5749)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Whse. Outstanding Qty."(Field 5749)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Promised Delivery Date"(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Planned Delivery Date"(Field 5794)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Planned Shipment Date"(Field 5795)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 5796)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Service Code"(Field 5797)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Allow Item Charge Assignment"(Field 5800)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. to Assign"(Field 5801)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. Assigned"(Field 5802)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Qty. to Receive"(Field 5803)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Qty. Received"(Field 5809)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-from Item Entry"(Field 5811)".

        modify("Return Reason Code")
        {
            TableRelation = IF (Document Type=FILTER(Return Order),
                                Return Order Type=FILTER(Location)) "Return Reason" WHERE (Type=FILTER(Location))
                                ELSE IF (Document Type=FILTER(Return Order),
                                         Return Order Type=FILTER(SAV)) "Return Reason" WHERE (Type=FILTER(SAV));
            Description = 'BCSYS';
        }


        //Unsupported feature: Code Insertion (VariableCollection) on "Type(Field 5).OnValidate".

        //trigger (Variable: TempSalesLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "Type(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            GetSalesHeader;
            #4..13

            CheckAssocPurchOrder(FIELDCAPTION(Type));

            IF Type <> xRec.Type THEN
              CASE xRec.Type OF
                Type::Item:
                  BEGIN
            #21..32
                Type::"Charge (Item)":
                  DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
              END;

            AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
            TempSalesLine := Rec;
            INIT;
            Type := TempSalesLine.Type;
            "System-Created Entry" := TempSalesLine."System-Created Entry";

            IF Type = Type::Item THEN
              "Allow Item Charge Assignment" := TRUE
            #45..49
              IF SalesHeader.WhseShpmntConflict("Document Type","Document No.",SalesHeader."Shipping Advice") THEN
                ERROR(Text052,SalesHeader."Shipping Advice");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..16
            IF Type <> xRec.Type THEN BEGIN
            #18..35
              IF xRec."Deferral Code" <> '' THEN
                DeferralUtilities.RemoveOrSetDeferralSchedule('',
                  DeferralUtilities.GetSalesDeferralDocType,'','',
                  xRec."Document Type",xRec."Document No.",xRec."Line No.",
                  xRec.GetDeferralAmount,xRec."Posting Date",'',xRec."Currency Code",TRUE);
            END;
            #37..39
            IF xRec."Line Amount" <> 0 THEN
              "Recalculate Invoice Disc." := TRUE;

            Type := TempSalesLine.Type;
            "System-Created Entry" := TempSalesLine."System-Created Entry";
            "Currency Code" := SalesHeader."Currency Code";
            #42..52
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""No."(Field 6).OnValidate".

        //trigger (Variable: TempSalesLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            CheckItemAvailable(FIELDNO("No."));

            IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
              TESTFIELD("Qty. to Asm. to Order (Base)",0);
              CALCFIELDS("Reserved Qty. (Base)");
              TESTFIELD("Reserved Qty. (Base)",0);
              IF Type = Type::Item THEN
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            END;

            TESTFIELD("Qty. Shipped Not Invoiced",0);
            TESTFIELD("Quantity Shipped",0);
            TESTFIELD("Shipment No.",'');

            TESTFIELD("Prepmt. Amt. Inv.",0);

            TESTFIELD("Return Qty. Rcd. Not Invd.",0);
            TESTFIELD("Return Qty. Received",0);
            TESTFIELD("Return Receipt No.",'');

            IF "No." = '' THEN
              ATOLink.DeleteAsmFromSalesLine(Rec);
            CheckAssocPurchOrder(FIELDCAPTION("No."));
            AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

            TempSalesLine := Rec;
            INIT;
            Type := TempSalesLine.Type;
            "No." := TempSalesLine."No.";
            IF "No." = '' THEN
              EXIT;
            IF Type <> Type::" " THEN
              Quantity := TempSalesLine.Quantity;

            "System-Created Entry" := TempSalesLine."System-Created Entry";
            GetSalesHeader;
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
              IF (SalesHeader."Sell-to Customer No." = '') AND
                 (SalesHeader."Sell-to Customer Template Code" = '')
              THEN
                ERROR(
                  Text031,
                  SalesHeader.FIELDCAPTION("Sell-to Customer No."),
                  SalesHeader.FIELDCAPTION("Sell-to Customer Template Code"));
              IF (SalesHeader."Bill-to Customer No." = '') AND
                 (SalesHeader."Bill-to Customer Template Code" = '')
              THEN
                ERROR(
                  Text031,
                  SalesHeader.FIELDCAPTION("Bill-to Customer No."),
                  SalesHeader.FIELDCAPTION("Bill-to Customer Template Code"));
            END ELSE
              SalesHeader.TESTFIELD("Sell-to Customer No.");

            "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            "Currency Code" := SalesHeader."Currency Code";
            IF NOT IsServiceItem THEN
              "Location Code" := SalesHeader."Location Code";
            "Customer Price Group" := SalesHeader."Customer Price Group";
            "Customer Disc. Group" := SalesHeader."Customer Disc. Group";
            "Allow Line Disc." := SalesHeader."Allow Line Disc.";
            "Transaction Type" := SalesHeader."Transaction Type";
            "Transport Method" := SalesHeader."Transport Method";
            "Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
            "Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
            "VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
            "Exit Point" := SalesHeader."Exit Point";
            Area := SalesHeader.Area;
            "Transaction Specification" := SalesHeader."Transaction Specification";
            "Tax Area Code" := SalesHeader."Tax Area Code";
            "Tax Liable" := SalesHeader."Tax Liable";
            IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND (Type <> Type::" ") THEN
              "Prepayment %" := SalesHeader."Prepayment %";
            "Prepayment Tax Area Code" := SalesHeader."Tax Area Code";
            "Prepayment Tax Liable" := SalesHeader."Tax Liable";
            "Responsibility Center" := SalesHeader."Responsibility Center";

            "Shipping Agent Code" := SalesHeader."Shipping Agent Code";
            "Shipping Agent Service Code" := SalesHeader."Shipping Agent Service Code";
            "Outbound Whse. Handling Time" := SalesHeader."Outbound Whse. Handling Time";
            "Shipping Time" := SalesHeader."Shipping Time";
            CALCFIELDS("Substitution Available");

            "Promised Delivery Date" := SalesHeader."Promised Delivery Date";
            "Requested Delivery Date" := SalesHeader."Requested Delivery Date";
            "Shipment Date" :=
              CalendarMgmt.CalcDateBOC(
                '',
                SalesHeader."Shipment Date",
                CalChange."Source Type"::Location,
                "Location Code",
                '',
                CalChange."Source Type"::"Shipping Agent",
                "Shipping Agent Code",
                "Shipping Agent Service Code",
                FALSE);
            UpdateDates;

            CASE Type OF
              Type::" ":
                BEGIN
                  StdTxt.GET("No.");
                  Description := StdTxt.Description;
                  "Allow Item Charge Assignment" := FALSE;
                END;
              Type::"G/L Account":
                BEGIN
                  GLAcc.GET("No.");
                  GLAcc.CheckGLAcc;
                  IF NOT "System-Created Entry" THEN
                    GLAcc.TESTFIELD("Direct Posting",TRUE);
                  Description := GLAcc.Name;
                  "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                  "Tax Group Code" := GLAcc."Tax Group Code";
                  "Allow Invoice Disc." := FALSE;
                  "Allow Item Charge Assignment" := FALSE;
                END;
              Type::Item:
                BEGIN
                  GetItem;
                  Item.TESTFIELD(Blocked,FALSE);
                  Item.TESTFIELD("Gen. Prod. Posting Group");
                  IF Item.Type = Item.Type::Inventory THEN BEGIN
                    Item.TESTFIELD("Inventory Posting Group");
                    "Posting Group" := Item."Inventory Posting Group";
                  END;
                  Description := Item.Description;
                  "Description 2" := Item."Description 2";
                  GetUnitCost;
                  "Allow Invoice Disc." := Item."Allow Invoice Disc.";
                  "Units per Parcel" := Item."Units per Parcel";
                  "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                  "Tax Group Code" := Item."Tax Group Code";
                  "Item Category Code" := Item."Item Category Code";
                  "Product Group Code" := Item."Product Group Code";
                  Nonstock := Item."Created From Nonstock Item";
                  "Profit %" := Item."Profit %";
                  "Allow Item Charge Assignment" := TRUE;
                  PrepaymentMgt.SetSalesPrepaymentPct(Rec,SalesHeader."Posting Date");

                  IF SalesHeader."Language Code" <> '' THEN
                    GetItemTranslation;

                  IF Item.Reserve = Item.Reserve::Optional THEN
                    Reserve := SalesHeader.Reserve
                  ELSE
                    Reserve := Item.Reserve;

                  "Unit of Measure Code" := Item."Sales Unit of Measure";
                END;
              Type::Resource:
                BEGIN
                  Res.GET("No.");
                  Res.TESTFIELD(Blocked,FALSE);
                  Res.TESTFIELD("Gen. Prod. Posting Group");
                  Description := Res.Name;
                  "Description 2" := Res."Name 2";
                  "Unit of Measure Code" := Res."Base Unit of Measure";
                  "Unit Cost (LCY)" := Res."Unit Cost";
                  "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := Res."VAT Prod. Posting Group";
                  "Tax Group Code" := Res."Tax Group Code";
                  "Allow Item Charge Assignment" := FALSE;
                  FindResUnitCost;
                END;
              Type::"Fixed Asset":
                BEGIN
                  FA.GET("No.");
                  FA.TESTFIELD(Inactive,FALSE);
                  FA.TESTFIELD(Blocked,FALSE);
                  GetFAPostingGroup;
                  Description := FA.Description;
                  "Description 2" := FA."Description 2";
                  "Allow Invoice Disc." := FALSE;
                  "Allow Item Charge Assignment" := FALSE;
                END;
              Type::"Charge (Item)":
                BEGIN
                  ItemCharge.GET("No.");
                  Description := ItemCharge.Description;
                  "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
                  "Tax Group Code" := ItemCharge."Tax Group Code";
                  "Allow Invoice Disc." := FALSE;
                  "Allow Item Charge Assignment" := FALSE;
                END;
            END;

            VALIDATE("Prepayment %");

            IF Type <> Type::" " THEN BEGIN
              IF Type <> Type::"Fixed Asset" THEN
                VALIDATE("VAT Prod. Posting Group");
              VALIDATE("Unit of Measure Code");
              IF Quantity <> 0 THEN BEGIN
                InitOutstanding;
                IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
                  InitQtyToReceive
                ELSE
                  InitQtyToShip;
                InitQtyToAsm;
                UpdateWithWarehouseShip;
              END;
              UpdateUnitPrice(FIELDNO("No."));
            END;

            CreateDim(
              DimMgt.TypeToTableID3(Type),"No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Responsibility Center","Responsibility Center");

            IF "No." <> xRec."No." THEN BEGIN
              IF Type = Type::Item THEN
                IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
                  ReserveSalesLine.VerifyChange(Rec,xRec);
                  WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
                END;
              GetDefaultBin;
              AutoAsmToOrder;
              DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
              IF Type = Type::"Charge (Item)" THEN
                DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
            END;

            GetItemCrossRef(FIELDNO("No."));

            SalesHeader.GET("Document Type","Document No.");
            InitICPartner;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

            #1..29
            IF xRec."Line Amount" <> 0 THEN
              "Recalculate Invoice Disc." := TRUE;
            #30..38
            InitHeaderDefaults(SalesHeader);

            //>>MIGRATION NAV 2013
            //GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020,50021 et CALCULE des marges vente
            "Customer Sales Profit Group" := SalesHeader."Customer Sales Profit Group";
            //FIN GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020,50021 et CALCULE des marges vente
            //<<MIGRATION NAV 2013

            //>>MIGRATION NAV 2013
            //InsertNumDocExt HJ 31/10/06 NCS1.01 [18] Insertion Num Doc Externe Au Niveau Detail Vente
            "External Document No.":= SalesHeader."External Document No.";
            //Fin InsertNumDocExt HJ 31/10/06 NCS1.01 [18] Insertion Num Doc Externe Au Niveau Detail Vente
            //<<MIGRATION NAV 2013
            #84..98

            //BCSYS 260418
            "Invoiced Date (Expected)"  := "Shipment Date";
            //fin BCSYS 260418
            #99..103
                  StandardText.GET("No.");
                  Description := StandardText.Description;
            #106..119
                  InitDeferralCode;
            #120..140

                  //>>MIGRATION NAV 2013
                  // STD "Profit %" := Item."Profit %";
                  //TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ + ramener le prix depuis la table Prix d'achat 7012
                  //Importation du prix public
                  //>>FE25/26.01
                   "Public Price" := Item."Unit Price";
                   //>>FE004
                   "Buy-from Vendor No." := Item."Vendor No.";
                   //>>FE004
                   //>>PWD(SPI) : le 01/06/15
                   IF COMPANYNAME = 'SCENEO_Bourgogne' THEN
                     "Buy-from Vendor No." := 'CNE';
                   //<<PWD(SPI) : le 01/06/15


                  //>> 19.03.2012 TDL07 Begin
                  IF "Document Type" IN ["Document Type"::Quote,"Document Type"::Order] THEN
                    BEGIN
                      SalesSetup.GET;
                      VALIDATE("Purchasing Code",SalesSetup."Purchasing Code Grouping Line");
                  END;
                  //<< End

                  //>>FEP_ADVE_200711_21_1-DEROGATOIRE
                  "Item Disc. Group" := Item."Item Disc. Group";
                  //<<FEP_ADVE_200711_21_1-DEROGATOIRE

                  //COUT_ACHAT FG 20/12/06 NSC1.01
                  //>>CNEIC : 06/2015
                  //"Purchase cost" := Item."Standard Cost" ;
                  //BC6 - MM 280219 >>
                  SkipPurchCostVerif := TRUE;
                  //BC6 - MM 280219 <<
                  VALIDATE("Purchase cost",Item."Standard Cost");
                  //<<CNEIC : 06/2015
                  //Fin COUT_ACHAT FG 20/12/06 NSC1.01

                  //<<FE25/26.01
                  //<<MIGRATION NAV 2013
                  "Allow Item Charge Assignment" := TRUE;
                  //>>MIGRATION NAV 2013
                  //>>
                  "Forecast Inventory" := Item.Inventory - Item."Qty. on Sales Order" + Item."Qty. on Purch. Order";
                  //<<
                  //<<MIGRATION NAV 2013

            #143..153
                  InitDeferralCode;
                  SetDefaultItemQuantity;
                  //>>MIGRATION NAV 2013
                  //>>DEEE1.00 : update category code
                  VALIDATE("DEEE Category Code",Item."DEEE Category Code");
                  //<<DEEE1.00 : update category code
                  "To Prepare" := TRUE;
                  //<<MIGRATION NAV 2013

            #154..168
                  InitDeferralCode;
            #169..171
                  FixedAsset.GET("No.");
                  FixedAsset.TESTFIELD(Inactive,FALSE);
                  FixedAsset.TESTFIELD(Blocked,FALSE);
                  GetFAPostingGroup;
                  Description := FixedAsset.Description;
                  "Description 2" := FixedAsset."Description 2";
            #178..192
            IF NOT (Type IN [Type::" ",Type::"Fixed Asset"]) THEN
              VALIDATE("VAT Prod. Posting Group");

            UpdatePrepmtSetupFields;

            IF Type <> Type::" " THEN BEGIN
              VALIDATE("Unit of Measure Code");
              //BC6 - MM 280219 >>
              SkipPurchCostVerif := FALSE;
              //BC6 - MM 280219 <<
            #199..210
            IF NOT ISTEMPORARY THEN
              CreateDim(
                DimMgt.TypeToTableID3(Type),"No.",
                DATABASE::Job,"Job No.",
                DATABASE::"Responsibility Center","Responsibility Center");
            #215..228
            UpdateItemCrossRef;

            //>>MIGRATION NAV 2013
            //>>FE25/26
            CalcProfit;
            CalcDiscountUnitPrice ;
            //<<FE25/26
            //>>FEP_ADVE_200711_21_1-DEROGATOIRE
            FctGCalcLineDiscount();
            //<<FEP_ADVE_200711_21_1-DEROGATOIRE
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            CheckAssocPurchOrder(FIELDCAPTION("Location Code"));
            #4..27
                "Shipping Agent Service Code",
                FALSE);

            CheckItemAvailable(FIELDNO("Location Code"));

            IF NOT "Drop Shipment" THEN BEGIN
            #34..37
                IF Location.GET("Location Code") THEN
                  "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            END ELSE
              EVALUATE("Outbound Whse. Handling Time",'<0D>');

            IF "Location Code" <> xRec."Location Code" THEN BEGIN
              InitItemAppl(TRUE);
            #45..59
              GetUnitCost;

            CheckWMS;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..30
            //BCSYS 260418
            "Invoiced Date (Expected)"  := "Shipment Date";
            //fin BCSYS

            #31..40

              //>>MIGRATION NAV 2013
              // STD EVALUATE("Outbound Whse. Handling Time",'<0D>');

              //>>VENTES BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
              //std EVALUATE("Outbound Whse. Handling Time",'0D');
              EVALUATE("Outbound Whse. Handling Time",TextDate);
              //<<VENTES BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
              //<<MIGRATION NAV 2013

            #42..62

            IF "Document Type" = "Document Type"::"Return Order" THEN
              ValidateReturnReasonCode(FIELDNO("Location Code"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Shipment Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF CurrFieldNo <> 0 THEN
              AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

            #5..24
            AutoAsmToOrder;
            IF (xRec."Shipment Date" <> "Shipment Date") AND
               (Quantity <> 0) AND
               (Reserve <> Reserve::Never) AND
               NOT StatusCheckSuspended
            THEN
              CheckDateConflict.SalesLineCheck(Rec,CurrFieldNo <> 0);

            IF NOT PlannedShipmentDateCalculated THEN
              "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
            IF NOT PlannedDeliveryDateCalculated THEN
              "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            #2..27
            #29..36

            //BCSYS 260418
            "Invoiced Date (Expected)" := "Shipment Date";
            //FIN BCSYS 260418
            */
        //end;


        //Unsupported feature: Code Insertion on "Description(Field 11)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Item: Record "27";
            //TypeHelper: Codeunit "10";
            //ReturnValue: Text[50];
            //ItemDescriptionIsNo: Boolean;
            //DefaultCreate: Boolean;
        //begin
            /*
            IF Type = Type::" " THEN
              EXIT;

            CASE Type OF
              Type::Item:
                BEGIN
                  IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
                    ItemDescriptionIsNo := Item.GET(Description)
                  ELSE
                    ItemDescriptionIsNo := FALSE;

                  IF ("No." <> '') AND (NOT ItemDescriptionIsNo) AND (Description <> '') THEN BEGIN
                    Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '*''');
                    IF NOT Item.FINDFIRST THEN
                      EXIT;
                    IF Item."No." = "No." THEN
                      EXIT;
                    IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
                      VALIDATE("No.",Item."No.");
                    EXIT;
                  END;

                  GetSalesSetup;
                  DefaultCreate := ("No." = '') AND SalesSetup."Create Item from Description";
                  IF Item.TryGetItemNoOpenCard(ReturnValue,Description,DefaultCreate,NOT HideValidationDialog) THEN
                    CASE ReturnValue OF
                      '':
                        BEGIN
                          LookupRequested := TRUE;
                          Description := xRec.Description;
                        END;
                      "No.":
                        Description := xRec.Description;
                      ELSE BEGIN
                        CurrFieldNo := FIELDNO("No.");
                        VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
                      END;
                    END;
                END;
              ELSE
                IF "No." = '' THEN
                  IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
                    CurrFieldNo := FIELDNO("No.");
                    VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
                  END;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;

            #4..45
              ELSE
                InitQtyToShip;
              InitQtyToAsm;
            END;

            CheckItemAvailable(FIELDNO(Quantity));

            IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
              InitItemAppl(FALSE);

            IF Type = Type::Item THEN BEGIN
              UpdateUnitPrice(FIELDNO(Quantity));
              IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
                ReserveSalesLine.VerifyQuantity(Rec,xRec);
                IF NOT "Drop Shipment" THEN
            #61..80
              "VAT Base Amount" := 0;
            END;

            IF ("Document Type" = "Document Type"::Invoice) AND ("Prepayment %" <> 0) THEN
              UpdatePrePaymentAmounts;

            CheckWMS;

            CALCFIELDS("Reserved Qty. (Base)");
            VALIDATE("Reserved Qty. (Base)");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            //BC6 - MM 180319 >>
            SkipPurchCostVerif := TRUE;
            //BC6 - MM 180319 <<
            #1..48
              SetDefaultQuantity;
            #49..56

              //>>MIGRATION NAV 2013
              //STD UpdateUnitPrice(FIELDNO(Quantity));
              //>>FE032.001
              RecLSalesReceivablesSetup.GET;
              IF NOT RecLSalesReceivablesSetup."Active Quantity Management" THEN
                UpdateUnitPrice(FIELDNO(Quantity))
              ELSE
                VALIDATE("Unit Price",Rec."Unit Price");
              //<<FE032.001
              //<<MIGRATION NAV 2013

            #58..83
            UpdatePrePaymentAmounts;
            #86..88
            UpdatePlanned;
            //>>MIGRATION NAV 2013
            //<<DEEE1.00
            //CalculateDEEE('');
            //>>TDL94.001
            VALIDATE("DEEE HT Amount",0) ;
            "DEEE VAT Amount" := 0;
            "DEEE TTC Amount" := 0;
            "DEEE Amount (LCY) for Stat":=0;

            RecGCustomer.GET("Sell-to Customer No.");
            IF RecGCustomer."Submitted to DEEE" THEN BEGIN
            //<<TDL94.001
              VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
              "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
              "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
              "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
            END;
            //<<DEEE1.00

            //>>CorrectionSOBI
            //>>FEP-ACHAT-200706_18_A.001
            //>>I005590.001
            "Qty. To Order" := Quantity;

            //EVALUATE("Qty. To Order",FORMAT(Quantity,0,'<integer>'));

            //<<I005590.001
            //<<FEP-ACHAT-200706_18_A.001
            //<<CorrectionSOBI
            //<<MIGRATION NAV 2013

            //BC6 - MM 180319 >>
            SkipPurchCostVerif := FALSE;
            //BC6 - MM 180319 <<
            */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Ship"(Field 18).OnValidate".

        //trigger  to Ship"(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetLocation("Location Code");
            IF (CurrFieldNo <> 0) AND
               (Type = Type::Item) AND
            #4..31
                Text008,
                "Outstanding Qty. (Base)");

            IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Qty. to Ship" < 0) THEN
              CheckApplFromItemLedgEntry(ItemLedgEntry);

            ATOLink.UpdateQtyToAsmFromSalesLine(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..34
            //>>MIGRATION NAV 2013
            //>>FEP-ACHAT-200706_18_A.001
            //>>I005590.001
            "Qty. To Order" := "Qty. to Ship";
            //EVALUATE("Qty. To Order",FORMAT("Qty. to Ship",0,'<integer>'));
            //<<I005590.001
            //<<FEP-ACHAT-200706_18_A.001
            //<<MIGRATION NAV 2013
            #35..38
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Line Discount %"(Field 27).OnValidate".

        //trigger (Variable: L_Item)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount %"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            "Line Discount Amount" :=
            #4..6
            "Inv. Discount Amount" := 0;
            "Inv. Disc. Amount to Invoice" := 0;
            UpdateAmounts;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9

            //>>MIGRATION ANV 2013
            //>>FE25/26
            CalcDiscountUnitPrice;
            //CalcProfit;
            //<<FE25/26
            //<<MIGRATION NAV 2013

            //BC6 - MM 15/02/19 >>
            IF (("Document Type" = "Document Type"::Quote) OR ("Document Type" = "Document Type"::Order)) AND
               NOT SkipPurchCostVerif THEN BEGIN
              IF L_UserSetup.GET(USERID) AND L_UserSetup."Activ. Mini Margin Control" THEN BEGIN
                IF Type = Type::Item THEN BEGIN
                  L_Item.GET("No.");
                  IF L_Vendor.GET(L_Item."Vendor No.") AND (L_Vendor."% Mini Margin" <> 0) THEN BEGIN
                    CalcIncreasePurchCost(L_IncrPurchCost);
                    CalcIncreaseProfit(L_IncrProfit,L_IncrPurchCost);
                    IF L_IncrProfit < L_Vendor."% Mini Margin" THEN
                      ERROR(UpdateProfitErr,FIELDCAPTION("Profit %"),L_Vendor.FIELDCAPTION("% Mini Margin"),L_Vendor.TABLECAPTION,L_Vendor."No.");
                  END;
                END;
              END;
            END;
            //BC6 - MM 15/02/19 <<
            */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            TESTFIELD(Quantity);
            #4..11
            "Inv. Discount Amount" := 0;
            "Inv. Disc. Amount to Invoice" := 0;
            UpdateAmounts;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetSalesHeader;
            "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
            #1..14
            */
        //end;


        //Unsupported feature: Code Modification on ""Appl.-to Item Entry"(Field 38).OnValidate".

        //trigger -to Item Entry"(Field 38)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Appl.-to Item Entry" <> 0 THEN BEGIN
              AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

            #4..11
              END;
              ItemLedgEntry.GET("Appl.-to Item Entry");
              ItemLedgEntry.TESTFIELD(Positive,TRUE);
              IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
              IF ABS("Qty. to Ship (Base)") > ItemLedgEntry.Quantity THEN
                ERROR(ShippingMoreUnitsThanReceivedErr,ItemLedgEntry.Quantity,ItemLedgEntry."Document No.");
            #19..22
              IF NOT ItemLedgEntry.Open THEN
                MESSAGE(Text042,"Appl.-to Item Entry");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..14
              IF ItemLedgEntry.TrackingExists THEN
            #16..25
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Work Type Code"(Field 52).OnValidate".

        //trigger (Variable: WorkType)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Insertion on ""Profit %"(Field 67)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>FE25/26
            CalcDiscount;
            CalcDiscountUnitPrice;
            VALIDATE("Line Discount %");
            //<<FE25/26
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Drop Shipment"(Field 73).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Document Type","Document Type"::Order);
            TESTFIELD(Type,Type::Item);
            TESTFIELD("Quantity Shipped",0);
            TESTFIELD("Job No.",'');
            TESTFIELD("Qty. to Asm. to Order (Base)",0);

            IF "Drop Shipment" THEN
              TESTFIELD("Special Order",FALSE);

            CheckAssocPurchOrder(FIELDCAPTION("Drop Shipment"));

            IF "Drop Shipment" THEN BEGIN
              Reserve := Reserve::Never;
              VALIDATE(Quantity,Quantity);
              IF "Drop Shipment" THEN BEGIN
                EVALUATE("Outbound Whse. Handling Time",'<0D>');
                EVALUATE("Shipping Time",'<0D>');
                UpdateDates;
                "Bin Code" := '';
              END;
            END ELSE BEGIN
              GetItem;
              IF Item.Reserve = Item.Reserve::Optional THEN BEGIN
                GetSalesHeader;
                Reserve := SalesHeader.Reserve;
              END ELSE
                Reserve := Item.Reserve;
              IF "Special Order" THEN
                Reserve := Reserve::Never;
            END;

            IF "Drop Shipment" THEN
              "Bin Code" := '';

            CheckItemAvailable(FIELDNO("Drop Shipment"));

            AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
            IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
              IF NOT "Drop Shipment" THEN BEGIN
                InitQtyToAsm;
                AutoAsmToOrder;
                UpdateWithWarehouseShip
              END ELSE
                InitQtyToShip;
              WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              IF NOT FullReservedQtyIsForAsmToOrder THEN
                ReserveSalesLine.VerifyChange(Rec,xRec);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..11
            IF "Special Order" THEN
              Reserve := Reserve::Never
            ELSE
              IF "Drop Shipment" THEN BEGIN
                Reserve := Reserve::Never;
                VALIDATE(Quantity,Quantity);
                IF "Drop Shipment" THEN BEGIN
                  EVALUATE("Outbound Whse. Handling Time",'<0D>');
                  EVALUATE("Shipping Time",'<0D>');
                  UpdateDates;
                  "Bin Code" := '';
                END;
              END ELSE
                SetReserveWithoutPurchasingCode;
            #34..48
            */
        //end;


        //Unsupported feature: Code Modification on ""Tax Group Code"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            UpdateAmounts;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            ValidateTaxGroupCode;
            UpdateAmounts;
            */
        //end;


        //Unsupported feature: Code Modification on ""Blanket Order No."(Field 97).OnLookup".

        //trigger "(Field 97)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Quantity Shipped",0);
            BlanketOrderLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            BlanketOrderLookup;
            */
        //end;


        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Quantity Shipped",0);
            IF "Blanket Order Line No." <> 0 THEN BEGIN
              SalesLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
              SalesLine2.TESTFIELD(Type,Type);
              SalesLine2.TESTFIELD("No.","No.");
              SalesLine2.TESTFIELD("Bill-to Customer No.","Bill-to Customer No.");
              SalesLine2.TESTFIELD("Sell-to Customer No.","Sell-to Customer No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
              VALIDATE("Variant Code",SalesLine2."Variant Code");
              VALIDATE("Location Code",SalesLine2."Location Code");
              VALIDATE("Unit of Measure Code",SalesLine2."Unit of Measure Code");
              VALIDATE("Unit Price",SalesLine2."Unit Price");
              VALIDATE("Line Discount %",SalesLine2."Line Discount %");
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""IC Partner Ref. Type"(Field 107).OnValidate".

        //trigger  Type"(Field 107)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "IC Partner Code" <> '' THEN
              "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
            IF "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" THEN
              "IC Partner Reference" := '';
            IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN
              BEGIN
              IF Item."No." <> "No." THEN
                Item.GET("No.");
              "IC Partner Reference" := Item."Common Item No.";
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN BEGIN
              IF Item."No." <> "No." THEN
                Item.GET("No.");
              Item.TESTFIELD("Common Item No.");
              "IC Partner Reference" := Item."Common Item No.";
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment %"(Field 109).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Prepayment %" <> 0) AND (Type <> Type::" ") THEN BEGIN
              TESTFIELD("Document Type","Document Type"::Order);
              TESTFIELD("No.");
              IF CurrFieldNo = FIELDNO("Prepayment %") THEN
                IF "System-Created Entry" THEN
                  FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,0));
              IF "System-Created Entry" THEN
                "Prepayment %" := 0;
              GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
              IF GenPostingSetup."Sales Prepayments Account" <> '' THEN BEGIN
                GLAcc.GET(GenPostingSetup."Sales Prepayments Account");
                VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
              END ELSE
                CLEAR(VATPostingSetup);
              "Prepayment VAT %" := VATPostingSetup."VAT %";
              "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
              "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
              CASE "Prepmt. VAT Calc. Type" OF
                "VAT Calculation Type"::"Reverse Charge VAT",
                "VAT Calculation Type"::"Sales Tax":
                  "Prepayment VAT %" := 0;
                "VAT Calculation Type"::"Full VAT":
                  FIELDERROR("Prepmt. VAT Calc. Type",STRSUBSTNO(Text041,"Prepmt. VAT Calc. Type"));
              END;
              "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
            END;

            TestStatusOpen;

            IF Type <> Type::" " THEN
              UpdateAmounts;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            UpdatePrepmtSetupFields;
            #29..31
            */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Line Amount"(Field 110).OnValidate".

        //trigger  Line Amount"(Field 110)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            PrePaymentLineAmountEntered := TRUE;
            TESTFIELD("Line Amount");
            #4..6
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,"Line Amount"));
            IF "System-Created Entry" THEN
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,0));
            IF Quantity <> 0 THEN
              VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" /
                  ("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity) * 100,0.00001))
            ELSE
              VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Dimension Set ID"(Field 480)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Assemble to Order"(Field 900).OnValidate".

        //trigger  to Assemble to Order"(Field 900)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);

            "Qty. to Asm. to Order (Base)" := CalcBaseQty("Qty. to Assemble to Order");
            #4..24
            END;

            CheckItemAvailable(FIELDNO("Qty. to Assemble to Order"));
            GetDefaultBin;
            AutoAsmToOrder;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..27
            IF NOT (CurrFieldNo IN [FIELDNO(Quantity),FIELDNO("Qty. to Assemble to Order")]) THEN
              GetDefaultBin;
            AutoAsmToOrder;
            */
        //end;


        //Unsupported feature: Code Modification on ""Variant Code"(Field 5402).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            IF "Variant Code" <> '' THEN
              TESTFIELD(Type,Type::Item);
            #4..28
              WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            END;

            GetItemCrossRef(FIELDNO("Variant Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..31
            UpdateItemCrossRef;
            */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Bin Code" <> '' THEN BEGIN
              IF NOT IsInbound AND ("Quantity (Base)" <> 0) AND ("Qty. to Asm. to Order (Base)" = 0) THEN
                WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
              ELSE
                WMSManagement.FindBin("Location Code","Bin Code",'');
            END;

            IF "Drop Shipment" THEN
              CheckAssocPurchOrder(FIELDCAPTION("Bin Code"));
            #10..17
              CheckWarehouse;
            END;
            ATOLink.UpdateAsmBinCodeFromSalesLine(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Bin Code" <> '' THEN BEGIN

            //>>MIGRATION NAV 2013
            {
            #2..6
             }
              //>> C:FE09 Begin
              // IF (("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]) AND (Quantity >= 0)) OR
              IF (("Document Type" IN ["Document Type"::Invoice]) AND (Quantity >= 0)) OR
                 (("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) AND (Quantity < 0))
              THEN
                WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
              ELSE
                WMSManagement.FindBin("Location Code","Bin Code",'');
            END;
            //<<MIGRATION NAV 2013
            #7..20
            */
        //end;

        //Unsupported feature: Property Deletion (TableRelation) on ""Bin Code"(Field 5403)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestJobPlanningLine;
            TestStatusOpen;
            TESTFIELD("Quantity Shipped",0);
            TESTFIELD("Qty. Shipped (Base)",0);
            IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
              TESTFIELD("Shipment No.",'');
              TESTFIELD("Return Receipt No.",'');
            #8..22
                  "Unit of Measure" := UnitOfMeasureTranslation.Description;
              END;
            END;
            GetItemCrossRef(FIELDNO("Unit of Measure Code"));
            CASE Type OF
              Type::Item:
                BEGIN
            #30..54
                "Qty. per Unit of Measure" := 1;
            END;
            VALIDATE(Quantity);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            TESTFIELD("Return Qty. Received",0);
            TESTFIELD("Return Qty. Received (Base)",0);
            #5..25
            DistIntegration.EnterSalesItemCrossRef(Rec);
            #27..57
            */
        //end;

        //Unsupported feature: Deletion on ""Reserved Qty. (Base)"(Field 5495).OnValidate".



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetSalesHeader;
            "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            ReturnedCrossRef.INIT;
            #4..20
              Description := ReturnedCrossRef.Description;

            UpdateUnitPrice(FIELDNO("Cross-Reference No."));

            IF SalesHeader."Send IC Document" AND (SalesHeader."IC Direction" = SalesHeader."IC Direction"::Outgoing) THEN BEGIN
              "IC Partner Ref. Type" := "IC Partner Ref. Type"::"Cross Reference";
              "IC Partner Reference" := "Cross-Reference No.";
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..23
            UpdateICPartner;
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Purchasing Code"(Field 5711).OnValidate".

        //trigger (Variable: PurchasingCode)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Purchasing Code"(Field 5711).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            TESTFIELD(Type,Type::Item);
            CheckAssocPurchOrder(FIELDCAPTION(Type));
            #4..8
                TESTFIELD("Qty. to Asm. to Order (Base)",0);
                CALCFIELDS("Reserved Qty. (Base)");
                TESTFIELD("Reserved Qty. (Base)",0);
                IF (Quantity <> 0) AND (Quantity = "Quantity Shipped") THEN
                  ERROR(SalesLineCompletelyShippedErr);
                Reserve := Reserve::Never;
                VALIDATE(Quantity,Quantity);
                IF "Drop Shipment" THEN BEGIN
                  EVALUATE("Outbound Whse. Handling Time",'<0D>');
                  EVALUATE("Shipping Time",'<0D>');
                  UpdateDates;
                  "Bin Code" := '';
                END;
              END;
            END ELSE BEGIN
              "Drop Shipment" := FALSE;
              "Special Order" := FALSE;

              GetItem;
              IF Item.Reserve = Item.Reserve::Optional THEN BEGIN
                GetSalesHeader;
                Reserve := SalesHeader.Reserve;
              END ELSE
                Reserve := Item.Reserve;
            END;

            IF ("Purchasing Code" <> xRec."Purchasing Code") AND
            #36..49
              END;
              UpdateDates;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..11
                ReserveSalesLine.VerifyChange(Rec,xRec);

            #12..16
                  //>>MIGRATION NAV 2013
                  //>>VENTES BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
                  //std EVALUATE("Outbound Whse. Handling Time",'0D');
                  //std EVALUATE("Shipping Time",'0D');
                  EVALUATE("Outbound Whse. Handling Time",TextDate);
                  EVALUATE("Shipping Time",TextDate);
                  //<<VENTES BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
                  //<<MIGRATION NAV 2013
            #19..21
              END ELSE
                SetReserveWithoutPurchasingCode;
            #23..25
              SetReserveWithoutPurchasingCode;
            #33..52
            */
        //end;


        //Unsupported feature: Code Modification on ""Planned Shipment Date"(Field 5795).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF "Planned Shipment Date" <> 0D THEN BEGIN
              PlannedShipmentDateCalculated := TRUE;
            #4..7
                  CalendarMgmt.CalcDateBOC2(
                    FORMAT("Outbound Whse. Handling Time"),
                    "Planned Shipment Date",
                    CalChange."Source Type"::"Shipping Agent",
                    "Shipping Agent Code",
                    "Shipping Agent Service Code",
                    CalChange."Source Type"::Location,
                    "Location Code",
                    '',
                    FALSE))
              ELSE
                VALIDATE(
            #20..28
                    '',
                    FALSE));
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            #14..16
            #11..13
            #17..31
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Shipping Agent Service Code"(Field 5797).OnValidate".

        //trigger (Variable: ShippingAgentServices)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Shipping Agent Service Code"(Field 5797).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" THEN
              EVALUATE("Shipping Time",'<>');

            IF "Drop Shipment" THEN BEGIN
              EVALUATE("Shipping Time",'<0D>');
              UpdateDates;
            END ELSE BEGIN
              IF ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
                "Shipping Time" := ShippingAgentServices."Shipping Time"
              ELSE BEGIN
                GetSalesHeader;
                "Shipping Time" := SalesHeader."Shipping Time";
              END;
            END;

            IF ShippingAgentServices."Shipping Time" <> xRec."Shipping Time" THEN
              VALIDATE("Shipping Time","Shipping Time");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            END ELSE
            #9..14
            #16..18
            */
        //end;


        //Unsupported feature: Code Modification on ""Return Reason Code"(Field 6608).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Return Reason Code" = '' THEN
              UpdateUnitPrice(FIELDNO("Return Reason Code"));

            IF ReturnReason.GET("Return Reason Code") THEN BEGIN
              IF ReturnReason."Default Location Code" <> '' THEN
                VALIDATE("Location Code",ReturnReason."Default Location Code");
              IF ReturnReason."Inventory Value Zero" THEN BEGIN
                VALIDATE("Unit Cost (LCY)",0);
                VALIDATE("Unit Price",0);
              END ELSE
                IF "Unit Price" = 0 THEN
                  UpdateUnitPrice(FIELDNO("Return Reason Code"));
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
            */
        //end;
        field(56; "BC6_Recalculate Invoice Disc."; Boolean)
        {
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
        }
        field(84; "BC6_Tax Category"; Code[10])
        {
            Caption = 'Tax Category';
        }
        field(1700; "BC6_Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";

            trigger OnValidate()
            begin
                GetSalesHeader;
                DeferralPostDate := SalesHeader."Posting Date";

                DeferralUtilities.DeferralCodeOnValidate(
                  "Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
                  "Document Type","Document No.","Line No.",
                  GetDeferralAmount,DeferralPostDate,
                  Description,SalesHeader."Currency Code");

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  "Returns Deferral Start Date" :=
                    DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetSalesDeferralDocType,
                      "Document Type","Document No.","Line No.","Deferral Code",SalesHeader."Posting Date");
            end;
        }
        field(1702; "BC6_Returns Deferral Start Date"; Date)
        {
            Caption = 'Returns Deferral Start Date';

            trigger OnValidate()
            var
                DeferralHeader: Record "1701";
            begin
                GetSalesHeader;
                IF DeferralHeader.GET(DeferralUtilities.GetSalesDeferralDocType,'','',"Document Type","Document No.","Line No.") THEN
                  DeferralUtilities.CreateDeferralSchedule("Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
                    "Document Type","Document No.","Line No.",GetDeferralAmount,
                    DeferralHeader."Calc. Method","Returns Deferral Start Date",
                    DeferralHeader."No. of Periods",TRUE,
                    DeferralHeader."Schedule Description",FALSE,
                    SalesHeader."Currency Code");
            end;
        }
        field(50000; "BC6_Document Date flow"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Document Date" WHERE (No.=FIELD(Document No.),
                                                                       Document Type=FIELD(Document Type)));
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

            trigger OnValidate()
            begin
                //>>FEP-ACHAT-200706_18_A.002
                IF "Purch. Order No." <> '' THEN
                BEGIN
                  IF NOT CONFIRM(TextG005) THEN
                    ERROR('');
                END;
                //<<FEP-ACHAT-200706_18_A.002
            end;
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
            TableRelation = "Item Sales Profit Group";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Tarif Public';
            DecimalPlaces = 2:5;
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

            trigger OnLookup()
            var
                reclPurchHdr: Record "38";
            begin
                //>>FE004.4
                reclPurchHdr.SETFILTER("Document Type", '%1', "Purch. Document Type");
                reclPurchHdr.SETFILTER("No.","Purch. Order No.");
                CASE "Purch. Document Type" OF
                "Purch. Document Type"::Order :
                  PAGE.RUNMODAL(PAGE::"Purchase Order", reclPurchHdr) ;
                "Purch. Document Type"::Quote :
                  PAGE.RUNMODAL(PAGE::"Purchase Quote", reclPurchHdr) ;
                END;
                //<<FE004.4
            end;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50028; "BC6_Purch. Document Type"; Option)
        {
            Caption = 'Purch. Document Type';
            Description = 'CNE2.05';
            Editable = false;
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
        field(50031; "BC6_Discount unit price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
        }
        field(50033; "BC6_Outstanding qty"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
            Enabled = false;
        }
        field(50040; "BC6_Pick Qty."; Decimal)
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
        field(50041; "BC6_Purchase cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Purchase cost';
            DecimalPlaces = 2:5;
            Description = 'hors taxe';

            trigger OnValidate()
            var
                L_Item: Record "27";
                L_Vendor: Record "23";
                L_UserSetup: Record "91";
                ShowErrorMsg: Boolean;
            begin
                //BC6 - MM 15/02/19 >>
                IF (("Document Type" = "Document Type"::Quote) OR ("Document Type" = "Document Type"::Order)) AND
                   NOT SkipPurchCostVerif AND
                   (xRec."Purchase cost" <> Rec."Purchase cost") THEN BEGIN
                  ShowErrorMsg := FALSE;
                  IF L_UserSetup.GET(USERID) AND L_UserSetup."Activ. Mini Margin Control" THEN BEGIN
                    IF Type = Type::Item THEN BEGIN
                      L_Item.GET("No.");
                      ShowErrorMsg := (L_Item."Cost Increase Coeff %" <> 0);
                      IF NOT ShowErrorMsg THEN
                        IF L_Vendor.GET(L_Item."Vendor No.") THEN
                          ShowErrorMsg := L_Vendor."Blocked Prices";
                    END;
                  END;
                  IF ShowErrorMsg THEN
                    ERROR(UpdatePurchCostErr,FIELDCAPTION("Purchase cost"));
                END;
                //BC6 - MM 15/02/19 <<

                //COUT_ACHAT FG 20/12/06 NSC1.01
                CalcProfit ;
                //CalcDiscount ;
                //Fin COUT_ACHAT FG 20/12/06 NSC1.01

                //>>CNEIC : 06/2015
                RecGCompanyInfo.FINDFIRST;
                IF (RecGCompanyInfo."Branch Company" = FALSE) AND (SalesHeader."Sell-to IC Partner Code" <> '') THEN
                  BEGIN
                    // prix de vente avec 2 dec.
                    //VALIDATE("Unit Price","Purchase cost");
                    VALIDATE("Unit Price",ROUND("Purchase cost",0.01));
                  END;
                //<<CNEIC : 06/2015
            end;
        }
        field(50042; "BC6_Invoiced Date (Expected)"; Date)
        {
            Caption = 'Date facturation prévue';
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
        field(50120; "BC6_Return Order Type"; Option)
        {
            Caption = 'Return Order Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;
        }
        field(50121; "BC6_Solution Code"; Code[10])
        {
            Caption = 'Solution Code';
            Description = 'BCSYS';
            TableRelation = IF (Document Type=FILTER(Return Order),
                                Return Order Type=FILTER(Location)) "Return Solution" WHERE (Type=FILTER(Location))
                                ELSE IF (Document Type=FILTER(Return Order),
                                         Return Order Type=FILTER(SAV)) "Return Solution" WHERE (Type=FILTER(SAV));
        }
        field(50122; "BC6_Return Comment"; Text[50])
        {
            Caption = 'Return Comment';
            Description = 'BCSYS';
        }
        field(50123; "BC6_Return Order-Shpt Sales Order"; Code[20])
        {
            Caption = 'Return-Sales Order';
            Description = 'BCSYS';
        }
        field(50124; "BC6_Series No."; Text[250])
        {
            Caption = 'N° de série';
            Description = 'BCSYS';
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;

            trigger OnValidate()
            begin
                //>>DEEE1.00
                CalculateDEEE('');
                //<<DEEE1.00
            end;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';

            trigger OnValidate()
            var
                RecLCurrency: Record "4";
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetSalesHeader;
                RecLCurrency.InitRoundingPrecision;
                IF SalesHeader."Currency Code" <> '' THEN
                  "DEEE Unit Price (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "DEEE Unit Price",SalesHeader."Currency Factor"),
                      RecLCurrency."Amount Rounding Precision")
                ELSE
                  "DEEE Unit Price (LCY)" :=
                    ROUND("DEEE Unit Price",RecLCurrency."Amount Rounding Precision");

                VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
                "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
                "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
                "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;

                //<<DEEE1.00  : calculate DEEE amount (LCY)
            end;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "4";
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetSalesHeader;
                Currency2.InitRoundingPrecision;
                IF SalesHeader."Currency Code" <> '' THEN
                  "DEEE HT Amount (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "DEEE HT Amount",SalesHeader."Currency Factor"),
                      Currency2."Amount Rounding Precision")
                ELSE
                  "DEEE HT Amount (LCY)" :=
                    ROUND("DEEE HT Amount",Currency2."Amount Rounding Precision");

                //<<DEEE1.00  : calculate DEEE amount (LCY)
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

        //Unsupported feature: Property Modification (SumIndexFields) on ""Document Type,Document No.,Line No."(Key)".


        //Unsupported feature: Property Deletion (SIFTLevelsToMaintain) on ""Document Type,Type,No.,Variant Code,Drop Shipment,Location Code,Shipment Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Type,No.,Variant Code,Drop Shipment,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Location Code,Shipment Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Bill-to Customer No.,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Blanket Order No.,Blanket Order Line No."(Key)".

        key(Key1;"Document Type","Buy-from Vendor No.")
        {
        }
        key(Key2;"Document Type","Document No.","Sell-to Customer No.","No.")
        {
        }
        key(Key3;"Buy-from Vendor No.","Qty. To Order","To Order")
        {
        }
        key(Key4;"Document Type","No.")
        {
        }
        key(Key5;"Document Type","Sell-to Customer No.","No.")
        {
        }
        key(Key6;"Document Date","Document Type","No.")
        {
        }
        key(Key7;"Buy-from Vendor No.","Shipment Date")
        {
        }
        key(Key8;"Buy-from Vendor No.","No.","Shipment Date")
        {
        }
        key(Key9;"Document Type","Document No.","No.","Document Date")
        {
        }
        key(Key10;"Purch. Document Type","Purch. Order No.","Purch. Line No.")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key11;"To Order","Buy-from Vendor No.","No.","Purchase cost","Qty. To Order")
        {
        }
        key(Key12;"To Order","Buy-from Vendor No.","Document No.","Line No.","Qty. To Order")
        {
        }
        key(Key13;"Shipment Date","Document Type","Sell-to Customer No.","Document No.","Line No.")
        {
        }
        key(Key14;"Document Type",Type,"Outstanding Quantity","Purchasing Code")
        {
        }
        key(Key15;"Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment")
        {
        }
        key(Key16;"Document Type",Type,"Outstanding Quantity","Purchasing Code","Buy-from Vendor No.","Shipment Date")
        {
        }
        key(Key17;"Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment","Buy-from Vendor No.","Shipment Date")
        {
        }
        key(Key18;"Document Type",Type,"Outstanding Quantity","Purchasing Code","Buy-from Vendor No.","No.","Shipment Date")
        {
        }
        key(Key19;"Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment","Buy-from Vendor No.","No.","Shipment Date")
        {
        }
        key(Key20;Type,"No.")
        {
        }
        key(Key21;"Document Type","Document No.","Completely Shipped")
        {
        }
        key(Key22;"Document Type","Document No.",Type)
        {
        }
        key(Key23;"Bill-to Customer No.","Document Type","Document No.","Line No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: RecLPurchLine)()
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
        TestStatusOpen;
        IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
           (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
        THEN
        #5..15
        END;

        IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
          TESTFIELD("Prepmt. Amt. Inv.",0);

        CheckAssocPurchOrder('');
        NonstockItemMgt.DelNonStockSales(Rec);

        IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
        #25..56
        SalesCommentLine.SETRANGE("Document Line No.","Line No.");
        IF NOT SalesCommentLine.ISEMPTY THEN
          SalesCommentLine.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TestStatusOpen;
        //>>MIGRATION NAV 2013
        //>>FE004.2 et FE004.3
        IF ("Purch. Order No." <> '') OR ("Purch. Line No." <> 0) THEN
          IF NOT CONFIRM(textg002, FALSE, "Document No.", "Line No.", "Purch. Document Type", "Purch. Order No.", "Purch. Line No." ) THEN
            ERROR('')
          ELSE
          BEGIN
            RecLPurchLine.RESET;
            RecLPurchLine.SETFILTER("Sales Document Type", '%1' , "Document Type");
            RecLPurchLine.SETFILTER("Sales Line No." , '%1' ,"Line No.");
            RecLPurchLine.SETFILTER("Sales No." , "Document No.");
            IF RecLPurchLine.FIND('-') THEN
              REPEAT
                RecLPurchLine."Sales No." := '';
                RecLPurchLine."Sales Line No." := 0;
                //BC6 EABO 04/06/18 Error On Delete >>
                "Purch. Order No." := '';
                "Purch. Line No." := 0;
                //BC6 EABO 04/06/18 Error On Delete <<
                RecLPurchLine.MODIFY(TRUE);
              UNTIL RecLPurchLine.NEXT = 0 ;
          END;
        //<<FE004.2 et FE004.3
        //<<MIGRATION NAV 2013
        #2..18
          TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

        CleanDropShipmentFields;
        CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
        #22..59

        IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
          SalesLine2.COPY(Rec);
          IF SalesLine2.FIND('<>') THEN BEGIN
            SalesLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
            SalesLine2.MODIFY;
          END;
        END;

        IF "Deferral Code" <> '' THEN
          DeferralUtilities.DeferralCodeOnDelete(
            DeferralUtilities.GetSalesDeferralDocType,'','',
            "Document Type","Document No.","Line No.");
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnInsert".

    //trigger 00---)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TestStatusOpen;
        IF Quantity <> 0 THEN
          ReserveSalesLine.VerifyQuantity(Rec,xRec);
        LOCKTABLE;
        SalesHeader."No." := '';
        IF Type = Type::Item THEN
          IF SalesHeader.InventoryPickConflict("Document Type","Document No.",SalesHeader."Shipping Advice") THEN
            ERROR(Text056,SalesHeader."Shipping Advice");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TestStatusOpen;
        //>>MIGRATION NAV 2013
        //>>FE015
        TestStatusLocked;
        //<<FE015
        //<<MIGRATION NAV 2013

        #2..8
        IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
          UpdateDeferralAmounts;
        //>>MIGRATION NAV 2013
        //>>DEEE1.00 : update category code
        IF ((Type=Type:: Item) AND (RecLItem.GET("No."))) THEN
          VALIDATE("DEEE Category Code",RecLItem."DEEE Category Code");
        //<<DEEE1.00 : update category code
        //<<MIGRATION NAV 2013

        //>>BCSYS
        UpdateReturnOrderTypeFromSalesHeader;
        //<<BCSYS
        */
    //end;


    //Unsupported feature: Code Modification on "InitOutstanding(PROCEDURE 16)".

    //procedure InitOutstanding();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          "Outstanding Quantity" := Quantity - "Return Qty. Received";
          "Outstanding Qty. (Base)" := "Quantity (Base)" - "Return Qty. Received (Base)";
        #4..8
          "Qty. Shipped Not Invoiced" := "Quantity Shipped" - "Quantity Invoiced";
          "Qty. Shipped Not Invd. (Base)" := "Qty. Shipped (Base)" - "Qty. Invoiced (Base)";
        END;
        CALCFIELDS("Reserved Quantity");
        Planned := "Reserved Quantity" = "Outstanding Quantity";
        "Completely Shipped" := (Quantity <> 0) AND ("Outstanding Quantity" = 0);
        InitOutstandingAmount;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
        UpdatePlanned;
        "Completely Shipped" := (Quantity <> 0) AND ("Outstanding Quantity" = 0);
        InitOutstandingAmount;
        */
    //end;


    //Unsupported feature: Code Modification on "InitOutstandingAmount(PROCEDURE 17)".

    //procedure InitOutstandingAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Quantity = 0 THEN BEGIN
          "Outstanding Amount" := 0;
          "Outstanding Amount (LCY)" := 0;
          "Shipped Not Invoiced" := 0;
          "Shipped Not Invoiced (LCY)" := 0;
          "Return Rcd. Not Invd." := 0;
          "Return Rcd. Not Invd. (LCY)" := 0;
        END ELSE BEGIN
          GetSalesHeader;
          IF SalesHeader.Status = SalesHeader.Status::Released THEN
            AmountInclVAT := "Amount Including VAT"
          ELSE
            IF SalesHeader."Prices Including VAT" THEN
              AmountInclVAT := "Line Amount" - "Inv. Discount Amount"
            ELSE
              IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN
                AmountInclVAT :=
                  "Line Amount" - "Inv. Discount Amount" +
                  ROUND(
                    SalesTaxCalculate.CalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                      "Line Amount" - "Inv. Discount Amount","Quantity (Base)",SalesHeader."Currency Factor"),
                    Currency."Amount Rounding Precision")
              ELSE
                AmountInclVAT :=
                  ROUND(
                    ("Line Amount" - "Inv. Discount Amount") *
                    (1 + "VAT %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100)),
                    Currency."Amount Rounding Precision");
          VALIDATE(
            "Outstanding Amount",
            ROUND(
              AmountInclVAT * "Outstanding Quantity" / Quantity,
              Currency."Amount Rounding Precision"));
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
            VALIDATE(
              "Return Rcd. Not Invd.",
              ROUND(
                AmountInclVAT * "Return Qty. Rcd. Not Invd." / Quantity,
                Currency."Amount Rounding Precision"))
          ELSE
            VALIDATE(
              "Shipped Not Invoiced",
              ROUND(
                AmountInclVAT * "Qty. Shipped Not Invoiced" / Quantity,
                Currency."Amount Rounding Precision"));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
          AmountInclVAT := "Amount Including VAT";
        #30..47
        */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToShip(PROCEDURE 15)".

    //procedure InitQtyToShip();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Qty. to Ship" := "Outstanding Quantity";
        "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";

        CheckServItemCreation;

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetSalesSetup;
        IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
           ("Document Type" = "Document Type"::Invoice)
        THEN BEGIN
          "Qty. to Ship" := "Outstanding Quantity";
          "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Qty. to Ship" <> 0 THEN
            "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");
        #3..6
        */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToReceive(PROCEDURE 5803)".

    //procedure InitQtyToReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Return Qty. to Receive" := "Outstanding Quantity";
        "Return Qty. to Receive (Base)" := "Outstanding Qty. (Base)";

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetSalesSetup;
        IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
           ("Document Type" = "Document Type"::"Credit Memo")
        THEN BEGIN
          "Return Qty. to Receive" := "Outstanding Quantity";
          "Return Qty. to Receive (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Return Qty. to Receive" <> 0 THEN
            "Return Qty. to Receive (Base)" := CalcBaseQty("Return Qty. to Receive");

        InitQtyToInvoice;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetResource(PROCEDURE 49)".



    //Unsupported feature: Code Modification on "UpdateUnitPrice(PROCEDURE 2)".

    //procedure UpdateUnitPrice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0) THEN
          EXIT;

        #4..8
            BEGIN
              PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,Rec);
              PriceCalcMgt.FindSalesLinePrice(SalesHeader,Rec,CalledByFieldNo);
            END;
        END;
        VALIDATE("Unit Price");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11

              //>>MIGRATION NAV 2013
              //GESTION_REMISE FG 06/12/06 NSC1.01
              PriceCalcMgt.FindVeryBestPrice(Rec,SalesHeader) ;
              //Fin GESTION_REMISE FG 06/12/06 NSC1.01
              //>>FEP_ADVE_200711_21_1-DEROGATOIRE
              FctGCalcLineDiscount();
              //<<FEP_ADVE_200711_21_1-DEROGATOIRE
              //<<MIGRATION NAV 2013

        #12..14
        */
    //end;


    //Unsupported feature: Code Modification on "FindResUnitCost(PROCEDURE 5)".

    //procedure FindResUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ResCost.INIT;
        ResCost.Code := "No.";
        ResCost."Work Type Code" := "Work Type Code";
        ResFindUnitCost.RUN(ResCost);
        VALIDATE("Unit Cost (LCY)",ResCost."Unit Cost" * "Qty. per Unit of Measure");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        CODEUNIT.RUN(CODEUNIT::"Resource-Find Cost",ResCost);
        VALIDATE("Unit Cost (LCY)",ResCost."Unit Cost" * "Qty. per Unit of Measure");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: VATBaseAmount) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: LineAmountChanged) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CurrFieldNo <> FIELDNO("Allow Invoice Disc.") THEN
          TESTFIELD(Type);
        GetSalesHeader;

        IF "Line Amount" <> xRec."Line Amount" THEN
          "VAT Difference" := 0;
        IF "Line Amount" <> ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Discount Amount" THEN BEGIN
          "Line Amount" := ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Discount Amount";
          "VAT Difference" := 0;
        END;
        UpdateVATAmounts;
        IF NOT "Prepayment Line" THEN BEGIN
        #13..28
              IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
                FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
            END;
          END;
        END;
        InitOutstandingAmount;
        IF (CurrFieldNo <> 0) AND
           NOT ((Type = Type::Item) AND (CurrFieldNo = FIELDNO("No.")) AND (Quantity <> 0) AND
                // a write transaction may have been started
                ("Qty. per Unit of Measure" <> xRec."Qty. per Unit of Measure")) AND // ...continued condition
           ("Document Type" <= "Document Type"::Invoice) AND
           (("Outstanding Amount" + "Shipped Not Invoiced") > 0)
        THEN
          CustCheckCreditLimit.SalesLineCheck(Rec);

        IF Type = Type::"Charge (Item)" THEN
          UpdateItemChargeAssgnt;

        CalcPrepaymentToDeduct;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Type = Type::" " THEN
          EXIT;
        GetSalesHeader;
        VATBaseAmount := "VAT Base Amount";
        "Recalculate Invoice Disc." := TRUE;

        IF "Line Amount" <> xRec."Line Amount" THEN BEGIN
          "VAT Difference" := 0;
          LineAmountChanged := TRUE;
        END;
        #7..9
          LineAmountChanged := TRUE;
        #10..31
          END ELSE
            IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
               ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
            THEN BEGIN
              IF "Line Amount" < xRec."Line Amount" THEN
                FIELDERROR("Line Amount",STRSUBSTNO(Text044,xRec."Line Amount"));
              FIELDERROR("Line Amount",STRSUBSTNO(Text045,xRec."Line Amount"));
            END;
        #33..39
           (("Outstanding Amount" + "Shipped Not Invoiced") > 0) AND
           (CurrFieldNo <> FIELDNO("Blanket Order No.")) AND
           (CurrFieldNo <> FIELDNO("Blanket Order Line No."))
        #41..46
        //>>MIGRATION NAV 2013
        //PRIX_VENTE_REMISE FG 20/12/06 NSC1.01
        //IF "Line Discount %" <> 0 THEN
          CalcDiscountUnitPrice ;
        CalcProfit;
        //Fin PRIX_VENTE_REMISE FG 20/12/06 NSC1.01
        //<<MIGRATION NAV 2013

        CalcPrepaymentToDeduct;
        IF VATBaseAmount <> "VAT Base Amount" THEN
          LineAmountChanged := TRUE;

        IF LineAmountChanged THEN BEGIN
          UpdateDeferralAmounts;
          LineAmountChanged := FALSE;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetSalesHeader;
        SalesLine2.SETRANGE("Document Type","Document Type");
        SalesLine2.SETRANGE("Document No.","Document No.");
        SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
        IF "Line Amount" = 0 THEN
          IF xRec."Line Amount" >= 0 THEN
            SalesLine2.SETFILTER(Amount,'>%1',0)
          ELSE
            SalesLine2.SETFILTER(Amount,'<%1',0)
        ELSE
          IF "Line Amount" > 0 THEN
            SalesLine2.SETFILTER(Amount,'>%1',0)
          ELSE
            SalesLine2.SETFILTER(Amount,'<%1',0);
        SalesLine2.SETRANGE("VAT Identifier","VAT Identifier");
        SalesLine2.SETRANGE("Tax Group Code","Tax Group Code");

        IF "Line Amount" = "Inv. Discount Amount" THEN BEGIN
          Amount := 0;
          "VAT Base Amount" := 0;
          "Amount Including VAT" := 0;
        END ELSE BEGIN
          TotalLineAmount := 0;
          TotalInvDiscAmount := 0;
          TotalAmount := 0;
          TotalAmountInclVAT := 0;
          TotalQuantityBase := 0;
          IF ("VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax") OR
             (("VAT Calculation Type" IN
               ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"]) AND ("VAT %" <> 0))
          THEN BEGIN
            IF SalesLine2.FINDSET THEN
              REPEAT
                TotalLineAmount := TotalLineAmount + SalesLine2."Line Amount";
                TotalInvDiscAmount := TotalInvDiscAmount + SalesLine2."Inv. Discount Amount";
                TotalAmount := TotalAmount + SalesLine2.Amount;
                TotalAmountInclVAT := TotalAmountInclVAT + SalesLine2."Amount Including VAT";
                TotalQuantityBase := TotalQuantityBase + SalesLine2."Quantity (Base)";
              UNTIL SalesLine2.NEXT = 0;
          END;

          IF SalesHeader."Prices Including VAT" THEN
            CASE "VAT Calculation Type" OF
              "VAT Calculation Type"::"Normal VAT",
              "VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                  Amount :=
                    ROUND(
                      (TotalLineAmount - TotalInvDiscAmount + "Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
                      Currency."Amount Rounding Precision") -
                    TotalAmount;
                  "VAT Base Amount" :=
                    ROUND(
                      Amount * (1 - SalesHeader."VAT Base Discount %" / 100),
                      Currency."Amount Rounding Precision");
                  "Amount Including VAT" :=
                    TotalLineAmount + "Line Amount" +
                    ROUND(
                      (TotalAmount + Amount) * (SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                      Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                    TotalAmountInclVAT - TotalInvDiscAmount;
                END;
              "VAT Calculation Type"::"Full VAT":
                BEGIN
                  Amount := 0;
                  "VAT Base Amount" := 0;
                END;
              "VAT Calculation Type"::"Sales Tax":
                BEGIN
                  SalesHeader.TESTFIELD("VAT Base Discount %",0);
                  Amount :=
                    SalesTaxCalculate.ReverseCalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                      TotalAmountInclVAT + "Amount Including VAT",TotalQuantityBase + "Quantity (Base)",
                      SalesHeader."Currency Factor") -
                    TotalAmount;
                  IF Amount <> 0 THEN
                    "VAT %" :=
                      ROUND(100 * ("Amount Including VAT" - Amount) / Amount,0.00001)
                  ELSE
                    "VAT %" := 0;
                  Amount := ROUND(Amount,Currency."Amount Rounding Precision");
                  "VAT Base Amount" := Amount;
                END;
            END
          ELSE
            CASE "VAT Calculation Type" OF
              "VAT Calculation Type"::"Normal VAT",
              "VAT Calculation Type"::"Reverse Charge VAT":
                BEGIN
                  Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
                  "VAT Base Amount" :=
                    ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
                  "Amount Including VAT" :=
                    TotalAmount + Amount +
                    ROUND(
                      (TotalAmount + Amount) * (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                      Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                    TotalAmountInclVAT;
                END;
              "VAT Calculation Type"::"Full VAT":
                BEGIN
                  Amount := 0;
                  "VAT Base Amount" := 0;
                  "Amount Including VAT" := "Line Amount" - "Inv. Discount Amount";
                END;
              "VAT Calculation Type"::"Sales Tax":
                BEGIN
                  Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
                  "VAT Base Amount" := Amount;
                  "Amount Including VAT" :=
                    TotalAmount + Amount +
                    ROUND(
                      SalesTaxCalculate.CalculateTax(
                        "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                        TotalAmount + Amount,TotalQuantityBase + "Quantity (Base)",
                        SalesHeader."Currency Factor"),Currency."Amount Rounding Precision") -
                    TotalAmountInclVAT;
                  IF "VAT Base Amount" <> 0 THEN
                    "VAT %" :=
                      ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                  ELSE
                    "VAT %" := 0;
                END;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..30
          THEN
            IF NOT SalesLine2.ISEMPTY THEN BEGIN
              SalesLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
              TotalLineAmount := SalesLine2."Line Amount";
              TotalInvDiscAmount := SalesLine2."Inv. Discount Amount";
              TotalAmount := SalesLine2.Amount;
              TotalAmountInclVAT := SalesLine2."Amount Including VAT";
              TotalQuantityBase := SalesLine2."Quantity (Base)";
            END;
        #41..56
                    TotalLineAmount + "Line Amount" -
        #58..60
                    TotalAmountInclVAT - TotalInvDiscAmount - "Inv. Discount Amount";
        #62..126
        */
    //end;


    //Unsupported feature: Code Modification on "CheckItemAvailable(PROCEDURE 4)".

    //procedure CheckItemAvailable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Reserve = Reserve::Always THEN
          EXIT;

        #4..14
           ("Outstanding Quantity" > 0) AND
           ("Job Contract Entry No." = 0) AND
           NOT (Nonstock OR "Special Order")
        THEN
          IF ItemCheckAvail.SalesLineCheck(Rec) THEN
            ItemCheckAvail.RaiseUpdateInterruptedError;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17
        THEN BEGIN
          IF ItemCheckAvail.SalesLineCheck(Rec) THEN
            ItemCheckAvail.RaiseUpdateInterruptedError;
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Reservation) (VariableCollection) on "ShowReservation(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "ShowReservation(PROCEDURE 10)".

    //procedure ShowReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.");
        TESTFIELD(Reserve);
        CLEAR(Reservation);
        Reservation.SetSalesLine(Rec);
        Reservation.RUNMODAL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        UpdatePlanned;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ReservEntry) (VariableCollection) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Variable Insertion (Variable: ReservEngineMgt) (VariableCollection) on "ShowReservationEntries(PROCEDURE 21)".


    //Unsupported feature: Variable Insertion (Variable: ReservMgt) (VariableCollection) on "AutoReserve(PROCEDURE 11)".


    //Unsupported feature: Property Insertion (Local) on "GetDate(PROCEDURE 22)".


    //Unsupported feature: Property Insertion (Local) on "BlanketOrderLookup(PROCEDURE 23)".



    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 29)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        VerifyItemLineDim;
        */
    //end;


    //Unsupported feature: Code Modification on "ShowNonstock(PROCEDURE 32)".

    //procedure ShowNonstock();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.",'');
        IF PAGE.RUNMODAL(PAGE::"Nonstock Item List",NonstockItem) = ACTION::LookupOK THEN BEGIN
          NonstockItem.TESTFIELD("Item Category Code");
          ItemCategory.GET(NonstockItem."Item Category Code");
          ItemCategory.TESTFIELD("Def. Gen. Prod. Posting Group");
          ItemCategory.TESTFIELD("Def. Inventory Posting Group");

          "No." := NonstockItem."Entry No.";
          NonstockItemMgt.NonStockSales(Rec);
          VALIDATE("No.","No.");
          VALIDATE("Unit Price",NonstockItem."Unit Price");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          NonstockItem.TESTFIELD("Item Template Code");
          ConfigTemplateHeader.SETRANGE(Code,NonstockItem."Item Template Code");
          ConfigTemplateHeader.FINDFIRST;
          TempItemTemplate.InitializeTempRecordFromConfigTemplate(TempItemTemplate,ConfigTemplateHeader);
          TempItemTemplate.TESTFIELD("Gen. Prod. Posting Group");
          TempItemTemplate.TESTFIELD("Inventory Posting Group");
        #8..13
        */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesHeader2.GET("Document Type","Document No.") THEN;
        IF SalesHeader2."Prices Including VAT" THEN
          EXIT('2,1,' + GetFieldCaption(FieldNumber))
        ELSE
          EXIT('2,0,' + GetFieldCaption(FieldNumber));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF SalesHeader2.GET("Document Type","Document No.") THEN;
        CASE FieldNumber OF
          FIELDNO("No."):
            BEGIN
              IF ApplicationAreaSetup.IsFoundationEnabled THEN
                EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
              EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
            END;
          ELSE BEGIN
            IF SalesHeader2."Prices Including VAT" THEN
              EXIT('2,1,' + GetFieldCaption(FieldNumber));
            EXIT('2,0,' + GetFieldCaption(FieldNumber));
          END;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CalcUnitCost(PROCEDURE 5809)".

    //procedure CalcUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ValueEntry DO BEGIN
          SETCURRENTKEY("Item Ledger Entry No.");
          SETRANGE("Item Ledger Entry No.",ItemLedgEntry."Entry No.");
          CALCSUMS("Cost Amount (Actual)","Cost Amount (Expected)");
          UnitCost :=
            ("Cost Amount (Expected)" + "Cost Amount (Actual)") / ItemLedgEntry.Quantity;
        END;

        EXIT(ABS(UnitCost * "Qty. per Unit of Measure"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          IF IsServiceItem THEN BEGIN
            CALCSUMS("Cost Amount (Non-Invtbl.)");
            UnitCost := "Cost Amount (Non-Invtbl.)" / ItemLedgEntry.Quantity;
          END ELSE BEGIN
            CALCSUMS("Cost Amount (Actual)","Cost Amount (Expected)");
            UnitCost :=
              ("Cost Amount (Expected)" + "Cost Amount (Actual)") / ItemLedgEntry.Quantity;
          END;
        #7..9
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntSales) (VariableCollection) on "ShowItemChargeAssgnt(PROCEDURE 5801)".



    //Unsupported feature: Code Modification on "ShowItemChargeAssgnt(PROCEDURE 5801)".

    //procedure ShowItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GET("Document Type","Document No.","Line No.");
        TESTFIELD(Type,Type::"Charge (Item)");
        TESTFIELD("No.");
        #4..19
                Currency."Amount Rounding Precision")
          ELSE
            ItemChargeAssgntLineAmt := "Line Amount" - "Inv. Discount Amount";
        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
        ItemChargeAssgntSales.SETRANGE("Document No.","Document No.");
        #26..34
              Currency."Unit-Amount Rounding Precision");
        END;

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          AssignItemChargeSales.CreateDocChargeAssgn(ItemChargeAssgntSales,"Return Receipt No.")
        ELSE
        #41..44
        ItemChargeAssgnts.Initialize(Rec,ItemChargeAssgntLineAmt);
        ItemChargeAssgnts.RUNMODAL;
        CALCFIELDS("Qty. to Assign");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..22

        #23..37
        ItemChargeAssgntLineAmt :=
          ROUND(
            ItemChargeAssgntLineAmt * ("Qty. to Invoice" / Quantity),
            Currency."Amount Rounding Precision");

        #38..47
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntSales) (VariableCollection) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".



    //Unsupported feature: Code Modification on "UpdateItemChargeAssgnt(PROCEDURE 5807)".

    //procedure UpdateItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Qty. Assigned","Qty. to Assign");
        IF ABS("Quantity Invoiced") > ABS(("Qty. Assigned" + "Qty. to Assign")) THEN
          ERROR(Text055,FIELDCAPTION("Quantity Invoiced"),FIELDCAPTION("Qty. Assigned"),FIELDCAPTION("Qty. to Assign"));
        #4..7
        ItemChargeAssgntSales.SETRANGE("Document Line No.","Line No.");
        ItemChargeAssgntSales.CALCSUMS("Qty. to Assign");
        TotalQtyToAssign := ItemChargeAssgntSales."Qty. to Assign";
        IF (CurrFieldNo <> 0) AND (Amount <> xRec.Amount) THEN BEGIN
          ItemChargeAssgntSales.SETFILTER("Qty. Assigned",'<>0');
          IF NOT ItemChargeAssgntSales.ISEMPTY THEN
            ERROR(Text026,
        #15..17

        IF ItemChargeAssgntSales.FINDSET THEN BEGIN
          GetSalesHeader;
          IF SalesHeader."Prices Including VAT" THEN
            TotalAmtToAssign :=
              ROUND(("Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
                Currency."Amount Rounding Precision")
          ELSE
            TotalAmtToAssign := "Line Amount" - "Inv. Discount Amount";
          REPEAT
            ShareOfVAT := 1;
            IF SalesHeader."Prices Including VAT" THEN
        #30..35
                ItemChargeAssgntSales."Unit Cost" :=
                  ROUND(("Line Amount" - "Inv. Discount Amount") / Quantity / ShareOfVAT,
                    Currency."Unit-Amount Rounding Precision");
            IF TotalQtyToAssign > 0 THEN BEGIN
              ItemChargeAssgntSales."Amount to Assign" :=
                ROUND(ItemChargeAssgntSales."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
                  Currency."Amount Rounding Precision");
        #43..46
          UNTIL ItemChargeAssgntSales.NEXT = 0;
          CALCFIELDS("Qty. to Assign");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
          EXIT;

        #1..10
        IF (CurrFieldNo <> 0) AND (Amount <> xRec.Amount) AND
           NOT ((Quantity <> xRec.Quantity) AND (TotalQtyToAssign = 0))
        THEN BEGIN
        #12..20
          TotalAmtToAssign := CalcTotalAmtToAssign(TotalQtyToAssign);
        #27..38
            IF TotalQtyToAssign <> 0 THEN BEGIN
        #40..49
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntSales) (VariableCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802)".



    //Unsupported feature: Code Modification on "DeleteItemChargeAssgnt(PROCEDURE 5802)".

    //procedure DeleteItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemChargeAssgntSales.SETCURRENTKEY(
          "Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. Type",DocType);
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. No.",DocNo);
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. Line No.",DocLineNo);
        IF NOT ItemChargeAssgntSales.ISEMPTY THEN
          ItemChargeAssgntSales.DELETEALL(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..7
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntSales) (VariableCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".



    //Unsupported feature: Code Modification on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".

    //procedure DeleteChargeChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF DocType <> "Document Type"::"Blanket Order" THEN
          IF "Quantity Invoiced" <> 0 THEN BEGIN
            CALCFIELDS("Qty. Assigned");
            TESTFIELD("Qty. Assigned","Quantity Invoiced");
          END;
        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type",DocType);
        ItemChargeAssgntSales.SETRANGE("Document No.",DocNo);
        ItemChargeAssgntSales.SETRANGE("Document Line No.",DocLineNo);
        IF NOT ItemChargeAssgntSales.ISEMPTY THEN
          ItemChargeAssgntSales.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5

        #6..11
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckItemChargeAssgnt(PROCEDURE 5800)".



    //Unsupported feature: Code Modification on "CheckItemChargeAssgnt(PROCEDURE 5800)".

    //procedure CheckItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemChargeAssgntSales.SETCURRENTKEY(
          "Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. Type","Document Type");
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. No.","Document No.");
        ItemChargeAssgntSales.SETRANGE("Applies-to Doc. Line No.","Line No.");
        #6..10
            ItemChargeAssgntSales.TESTFIELD("Qty. to Assign",0);
          UNTIL ItemChargeAssgntSales.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..13
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: LineWasModified) (ReturnValueCollection) on "UpdateVATOnLines(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: DeferralAmount) (VariableCollection) on "UpdateVATOnLines(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 36)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF QtyType = QtyType::Shipping THEN
          EXIT;
        IF SalesHeader."Currency Code" = '' THEN
        #4..13
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                VATAmountLine.GET("VAT Identifier","VAT Calculation Type","Tax Group Code",FALSE,"Line Amount" >= 0);
                IF VATAmountLine.Modified THEN BEGIN
                  IF NOT TempVATAmountLineRemainder.GET(
        #20..30
                      ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");

                  IF "Allow Invoice Disc." THEN BEGIN
                    IF VATAmountLine."Inv. Disc. Base Amount" = 0 THEN
                      InvDiscAmount := 0
                    ELSE BEGIN
                      LineAmountToInvoiceDiscounted :=
        #38..41
                      InvDiscAmount :=
                        ROUND(
                          TempVATAmountLineRemainder."Invoice Discount Amount",Currency."Amount Rounding Precision");
                      LineAmountToInvoiceDiscounted := ROUND(LineAmountToInvoiceDiscounted,Currency."Amount Rounding Precision");
                      IF (InvDiscAmount < 0) AND (LineAmountToInvoiceDiscounted = 0) THEN
                        InvDiscAmount := 0;
                      TempVATAmountLineRemainder."Invoice Discount Amount" :=
                        TempVATAmountLineRemainder."Invoice Discount Amount" - InvDiscAmount;
                    END;
        #51..123
                  IF Type = Type::"Charge (Item)" THEN
                    UpdateItemChargeAssgnt;
                  MODIFY;

                  TempVATAmountLineRemainder."Amount Including VAT" :=
                    NewAmountIncludingVAT - ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
        #130..133
              END;
            UNTIL NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        LineWasModified := FALSE;
        #1..16
                DeferralAmount := GetDeferralAmount;
        #17..33
                    IF (VATAmountLine."Inv. Disc. Base Amount" = 0) OR (LineAmountToInvoice = 0) THEN
        #35..44
        #48..126
                  LineWasModified := TRUE;

                  IF ("Deferral Code" <> '') AND (DeferralAmount <> GetDeferralAmount) THEN
                    UpdateDeferralAmounts;
        #127..136
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: AmtToHandle) (VariableCollection) on "CalcVATAmountLines(PROCEDURE 35)".



    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 35)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesHeader."Currency Code" = '' THEN
          Currency.InitRoundingPrecision
        ELSE
          Currency.GET(SalesHeader."Currency Code");

        VATAmountLine.DELETEALL;

        WITH SalesLine DO BEGIN
          SETRANGE("Document Type",SalesHeader."Document Type");
          SETRANGE("Document No.",SalesHeader."No.");
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                IF (Type = Type::"G/L Account") AND NOT "Prepayment Line" THEN
                  RoundingLineInserted := ("No." = GetCPGInvRoundAcc(SalesHeader)) OR RoundingLineInserted;
                IF "VAT Calculation Type" IN
                   ["VAT Calculation Type"::"Reverse Charge VAT","VAT Calculation Type"::"Sales Tax"]
                THEN
                  "VAT %" := 0;
                IF NOT VATAmountLine.GET(
                     "VAT Identifier","VAT Calculation Type","Tax Group Code",FALSE,"Line Amount" >= 0)
                THEN BEGIN
                  VATAmountLine.INIT;
                  VATAmountLine."VAT Identifier" := "VAT Identifier";
                  VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                  VATAmountLine."Tax Group Code" := "Tax Group Code";
                  VATAmountLine."VAT %" := "VAT %";
                  VATAmountLine.Modified := TRUE;
                  VATAmountLine.Positive := "Line Amount" >= 0;
                  VATAmountLine.INSERT;
                END;
                CASE QtyType OF
                  QtyType::General:
                    BEGIN
                      VATAmountLine.Quantity := VATAmountLine.Quantity + "Quantity (Base)";
                      VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + "Line Amount";
                      IF "Allow Invoice Disc." THEN
                        VATAmountLine."Inv. Disc. Base Amount" :=
                          VATAmountLine."Inv. Disc. Base Amount" + "Line Amount";
                      VATAmountLine."Invoice Discount Amount" :=
                        VATAmountLine."Invoice Discount Amount" + "Inv. Discount Amount";
                      VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                      IF "Prepayment Line" THEN
                        VATAmountLine."Includes Prepayment" := TRUE;
                      VATAmountLine.MODIFY;
                    END;
                  QtyType::Invoicing:
                    BEGIN
                      CASE TRUE OF
                        ("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]) AND
                        (NOT SalesHeader.Ship) AND SalesHeader.Invoice AND (NOT "Prepayment Line"):
                          BEGIN
                            IF "Shipment No." = '' THEN BEGIN
                              QtyToHandle := GetAbsMin("Qty. to Invoice","Qty. Shipped Not Invoiced");
                              VATAmountLine.Quantity :=
                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)","Qty. Shipped Not Invd. (Base)");
                            END ELSE BEGIN
                              QtyToHandle := "Qty. to Invoice";
                              VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                            END;
                          END;
                        ("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) AND
                        (NOT SalesHeader.Receive) AND SalesHeader.Invoice:
                          BEGIN
                            IF "Return Receipt No." = '' THEN BEGIN
                              QtyToHandle := GetAbsMin("Qty. to Invoice","Return Qty. Rcd. Not Invd.");
                              VATAmountLine.Quantity :=
                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)","Ret. Qty. Rcd. Not Invd.(Base)");
                            END ELSE BEGIN
                              QtyToHandle := "Qty. to Invoice";
                              VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                            END;
                          END;
                        ELSE
                          BEGIN
                          QtyToHandle := "Qty. to Invoice";
                          VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                        END;
                      END;
                      VATAmountLine."Line Amount" :=
                        VATAmountLine."Line Amount" + GetLineAmountToHandle(QtyToHandle);
                      IF "Allow Invoice Disc." THEN
                        VATAmountLine."Inv. Disc. Base Amount" :=
                          VATAmountLine."Inv. Disc. Base Amount" + GetLineAmountToHandle(QtyToHandle);
                      IF SalesHeader."Invoice Discount Calculation" <> SalesHeader."Invoice Discount Calculation"::Amount THEN
                        VATAmountLine."Invoice Discount Amount" :=
                          VATAmountLine."Invoice Discount Amount" +
                          ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision")
                      ELSE
                        VATAmountLine."Invoice Discount Amount" :=
                          VATAmountLine."Invoice Discount Amount" + "Inv. Disc. Amount to Invoice";
                      VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                      IF "Prepayment Line" THEN
                        VATAmountLine."Includes Prepayment" := TRUE;
                      VATAmountLine.MODIFY;
                    END;
                  QtyType::Shipping:
                    BEGIN
                      IF "Document Type" IN
                         ["Document Type"::"Return Order","Document Type"::"Credit Memo"]
                      THEN BEGIN
                        QtyToHandle := "Return Qty. to Receive";
                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Return Qty. to Receive (Base)";
                      END ELSE BEGIN
                        QtyToHandle := "Qty. to Ship";
                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Ship (Base)";
                      END;
                      VATAmountLine."Line Amount" :=
                        VATAmountLine."Line Amount" + GetLineAmountToHandle(QtyToHandle);
                      IF "Allow Invoice Disc." THEN
                        VATAmountLine."Inv. Disc. Base Amount" :=
                          VATAmountLine."Inv. Disc. Base Amount" + GetLineAmountToHandle(QtyToHandle);
                      VATAmountLine."Invoice Discount Amount" :=
                        VATAmountLine."Invoice Discount Amount" +
                        ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision");
                      VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                      IF "Prepayment Line" THEN
                        VATAmountLine."Includes Prepayment" := TRUE;
                      VATAmountLine.MODIFY;
                    END;
                END;
                TotalVATAmount := TotalVATAmount + "Amount Including VAT" - Amount;
              END;
            UNTIL NEXT = 0;
        END;

        WITH VATAmountLine DO
          IF FINDSET THEN
            REPEAT
              IF (PrevVatAmountLine."VAT Identifier" <> "VAT Identifier") OR
                 (PrevVatAmountLine."VAT Calculation Type" <> "VAT Calculation Type") OR
                 (PrevVatAmountLine."Tax Group Code" <> "Tax Group Code") OR
                 (PrevVatAmountLine."Use Tax" <> "Use Tax")
              THEN
                PrevVatAmountLine.INIT;
              IF SalesHeader."Prices Including VAT" THEN BEGIN
                CASE "VAT Calculation Type" OF
                  "VAT Calculation Type"::"Normal VAT",
                  "VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                      "VAT Base" :=
                        ROUND(
                          ("Line Amount" - "Invoice Discount Amount") / (1 + "VAT %" / 100),
                          Currency."Amount Rounding Precision") - "VAT Difference";
                      "VAT Amount" :=
                        "VAT Difference" +
                        ROUND(
                          PrevVatAmountLine."VAT Amount" +
                          ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                          (1 - SalesHeader."VAT Base Discount %" / 100),
                          Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      "Amount Including VAT" := "VAT Base" + "VAT Amount";
                      IF Positive THEN
                        PrevVatAmountLine.INIT
                      ELSE BEGIN
                        PrevVatAmountLine := VATAmountLine;
                        PrevVatAmountLine."VAT Amount" :=
                          ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                          (1 - SalesHeader."VAT Base Discount %" / 100);
                        PrevVatAmountLine."VAT Amount" :=
                          PrevVatAmountLine."VAT Amount" -
                          ROUND(PrevVatAmountLine."VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      END;
                    END;
                  "VAT Calculation Type"::"Full VAT":
                    BEGIN
                      "VAT Base" := 0;
                      "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                      "Amount Including VAT" := "VAT Amount";
                    END;
                  "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                      "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount";
                      "VAT Base" :=
                        ROUND(
                          SalesTaxCalculate.ReverseCalculateTax(
                            SalesHeader."Tax Area Code","Tax Group Code",SalesHeader."Tax Liable",
                            SalesHeader."Posting Date","Amount Including VAT",Quantity,SalesHeader."Currency Factor"),
                          Currency."Amount Rounding Precision");
                      "VAT Amount" := "VAT Difference" + "Amount Including VAT" - "VAT Base";
                      IF "VAT Base" = 0 THEN
                        "VAT %" := 0
                      ELSE
                        "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base",0.00001);
                    END;
                END;
              END ELSE
                CASE "VAT Calculation Type" OF
                  "VAT Calculation Type"::"Normal VAT",
                  "VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                      "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                      "VAT Amount" :=
                        "VAT Difference" +
                        ROUND(
                          PrevVatAmountLine."VAT Amount" +
                          "VAT Base" * "VAT %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100),
                          Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount" + "VAT Amount";
                      IF Positive THEN
                        PrevVatAmountLine.INIT
                      ELSE
                        IF NOT "Includes Prepayment" THEN BEGIN
                          PrevVatAmountLine := VATAmountLine;
                          PrevVatAmountLine."VAT Amount" :=
                            "VAT Base" * "VAT %" / 100 * (1 - SalesHeader."VAT Base Discount %" / 100);
                          PrevVatAmountLine."VAT Amount" :=
                            PrevVatAmountLine."VAT Amount" -
                            ROUND(PrevVatAmountLine."VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                        END;
                    END;
                  "VAT Calculation Type"::"Full VAT":
                    BEGIN
                      "VAT Base" := 0;
                      "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                      "Amount Including VAT" := "VAT Amount";
                    END;
                  "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                      "VAT Base" := "Line Amount" - "Invoice Discount Amount";
                      "VAT Amount" :=
                        SalesTaxCalculate.CalculateTax(
                          SalesHeader."Tax Area Code","Tax Group Code",SalesHeader."Tax Liable",
                          SalesHeader."Posting Date","VAT Base",Quantity,SalesHeader."Currency Factor");
                      IF "VAT Base" = 0 THEN
                        "VAT %" := 0
                      ELSE
                        "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base",0.00001);
                      "VAT Amount" :=
                        "VAT Difference" +
                        ROUND("VAT Amount",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      "Amount Including VAT" := "VAT Base" + "VAT Amount";
                    END;
                END;

              IF RoundingLineInserted THEN
                TotalVATAmount := TotalVATAmount - "VAT Amount";
              "Calculated VAT Amount" := "VAT Amount" - "VAT Difference";
              MODIFY;
            UNTIL NEXT = 0;

        IF RoundingLineInserted AND (TotalVATAmount <> 0) THEN
          IF VATAmountLine.GET(SalesLine."VAT Identifier",SalesLine."VAT Calculation Type",
               SalesLine."Tax Group Code",FALSE,SalesLine."Line Amount" >= 0)
          THEN BEGIN
            VATAmountLine."VAT Amount" := VATAmountLine."VAT Amount" + TotalVATAmount;
            VATAmountLine."Amount Including VAT" := VATAmountLine."Amount Including VAT" + TotalVATAmount;
            VATAmountLine."Calculated VAT Amount" := VATAmountLine."Calculated VAT Amount" + TotalVATAmount;
            VATAmountLine.MODIFY;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Currency.Initialize(SalesHeader."Currency Code");
        #5..21
                THEN
                  VATAmountLine.InsertNewLine(
                    "VAT Identifier","VAT Calculation Type","Tax Group Code",FALSE,"VAT %","Line Amount" >= 0,FALSE);

        #32..34
                      VATAmountLine.Quantity += "Quantity (Base)";

                    //>>MIGRATION NAV 2013
                    //<<DEEE1.00 : Update VAT details (F9 without clic)
                    VATAmountLine."DEEE HT Amount":=VATAmountLine."DEEE HT Amount"+"DEEE HT Amount" ;
                    VATAmountLine."DEEE VAT Amount":=VATAmountLine."DEEE VAT Amount"+ROUND("DEEE VAT Amount"
                          ,Currency."Amount Rounding Precision");
                    VATAmountLine."DEEE TTC Amount":=VATAmountLine."DEEE TTC Amount"+ROUND("DEEE TTC Amount"
                          ,Currency."Amount Rounding Precision");
                      VATAmountLine."DEEE Amount (LCY) for Stat":=VATAmountLine."DEEE Amount (LCY) for Stat"+
                      "DEEE Amount (LCY) for Stat" ; //ooo

                    //>>DEEE1.00 : Update VAT details (F9 without clic)
                    //<<MIGRATION NAV 2013

                      VATAmountLine.SumLine(
                        "Line Amount","Inv. Discount Amount","VAT Difference","Allow Invoice Disc.","Prepayment Line");
        #46..51
                          IF "Shipment No." = '' THEN BEGIN
                            QtyToHandle := GetAbsMin("Qty. to Invoice","Qty. Shipped Not Invoiced");
                            VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Qty. Shipped Not Invd. (Base)");
                          END ELSE BEGIN
                            QtyToHandle := "Qty. to Invoice";
                            VATAmountLine.Quantity += "Qty. to Invoice (Base)";
        #61..63
                          IF "Return Receipt No." = '' THEN BEGIN
                            QtyToHandle := GetAbsMin("Qty. to Invoice","Return Qty. Rcd. Not Invd.");
                            VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Ret. Qty. Rcd. Not Invd.(Base)");
                          END ELSE BEGIN
                            QtyToHandle := "Qty. to Invoice";
                            VATAmountLine.Quantity += "Qty. to Invoice (Base)";
        #73..76
                          VATAmountLine.Quantity += "Qty. to Invoice (Base)";
                        END;
                      END;
                      AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                      IF SalesHeader."Invoice Discount Calculation" <> SalesHeader."Invoice Discount Calculation"::Amount THEN
                        VATAmountLine.SumLine(
                          AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                          "VAT Difference","Allow Invoice Disc.","Prepayment Line")
                      ELSE
                        VATAmountLine.SumLine(
                          AmtToHandle,"Inv. Disc. Amount to Invoice","VAT Difference","Allow Invoice Disc.","Prepayment Line");
        #96..102
                        VATAmountLine.Quantity += "Return Qty. to Receive (Base)";
                      END ELSE BEGIN
                        QtyToHandle := "Qty. to Ship";
                        VATAmountLine.Quantity += "Qty. to Ship (Base)";
                      END;
                      AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                      VATAmountLine.SumLine(
                        AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                        "VAT Difference","Allow Invoice Disc.","Prepayment Line");
                    END;
                END;
                TotalVATAmount += "Amount Including VAT" - Amount;
        #123..126
        VATAmountLine.UpdateLines(
          TotalVATAmount,Currency,SalesHeader."Currency Factor",SalesHeader."Prices Including VAT",
          SalesHeader."VAT Base Discount %",SalesHeader."Tax Area Code",SalesHeader."Tax Liable",SalesHeader."Posting Date");
        #241..245
            VATAmountLine."VAT Amount" += TotalVATAmount;
            VATAmountLine."Amount Including VAT" += TotalVATAmount;
            VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
            VATAmountLine.MODIFY;
          END;
        */
    //end;


    //Unsupported feature: Code Modification on "GetCPGInvRoundAcc(PROCEDURE 71)".

    //procedure GetCPGInvRoundAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;
        IF SalesSetup."Invoice Rounding" THEN
          IF Cust.GET(SalesHeader."Bill-to Customer No.") THEN
            CustPostingGroup.GET(Cust."Customer Posting Group")
          ELSE
            IF CustTemplate.GET(SalesHeader."Sell-to Customer Template Code") THEN
              CustPostingGroup.GET(CustTemplate."Customer Posting Group");

        EXIT(CustPostingGroup."Invoice Rounding Account");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetSalesSetup;
        #2..9
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateDates(PROCEDURE 43)".


    //Unsupported feature: Variable Insertion (Variable: ItemTranslation) (VariableCollection) on "GetItemTranslation(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Name) on "GetItemCrossRef(PROCEDURE 48)".


    //Unsupported feature: Property Insertion (Local) on "GetItemCrossRef(PROCEDURE 48)".



    //Unsupported feature: Code Modification on "GetItemCrossRef(PROCEDURE 48)".

    //procedure GetItemCrossRef();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CalledByFieldNo <> 0 THEN
          DistIntegration.EnterSalesItemCrossRef(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DistIntegration.EnterSalesItemCrossRef(Rec);
        UpdateICPartner;
        */
    //end;


    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 50)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type <> Type::Item THEN
          EXIT;

        #4..11
              IF GetATOBin(Location,"Bin Code") THEN
                EXIT;

            WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            HandleDedicatedBin(FALSE);
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14
            //>>MIGRATION NAV 2013
            //>> C:FE09 Begin
            IF Location."Require Pick" AND NOT (Location."Require Shipment") THEN
            BEGIN
              GetSalesHeader;
              "Bin Code" := SalesHeader."Bin Code";
              IF "Bin Code" = '' THEN
                "Bin Code" := Location."Shipment Bin Code";
            END
            ELSE
              WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            // WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            // End
            //<<MIGRATION NAV 2013

        #16..18
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckAssocPurchOrder(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "CrossReferenceNoLookUp(PROCEDURE 53)".

    //procedure CrossReferenceNoLookUp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE Type OF
          Type::Item:
            BEGIN
        #4..12
                VALIDATE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
                PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,Rec);
                PriceCalcMgt.FindSalesLinePrice(SalesHeader,Rec,FIELDNO("Cross-Reference No."));
                VALIDATE("Unit Price");
              END;
            END;
          Type::"G/L Account",Type::Resource:
            BEGIN
              GetSalesHeader;
              SalesHeader.TESTFIELD("Sell-to IC Partner Code");
              IF PAGE.RUNMODAL(PAGE::"IC G/L Account List") = ACTION::LookupOK THEN
                "Cross-Reference No." := ICGLAcc."No.";
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..15

                //>>MIGRATION NAV 2013
                //GESTION_REMISE FG 06/12/06 NSC1.01
                PriceCalcMgt.FindVeryBestPrice(Rec,SalesHeader) ;
                //Fin GESTION_REMISE FG 06/12/06 NSC1.01
                //<<MIGRATION NAV 2013

        #16..22
              IF PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAcc) = ACTION::LookupOK THEN
        #24..26
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckServItemCreation(PROCEDURE 52)".



    //Unsupported feature: Code Modification on "CheckApplFromItemLedgEntry(PROCEDURE 157)".

    //procedure CheckApplFromItemLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Appl.-from Item Entry" = 0 THEN
          EXIT;

        #4..17
        ItemLedgEntry.TESTFIELD(Positive,FALSE);
        ItemLedgEntry.TESTFIELD("Item No.","No.");
        ItemLedgEntry.TESTFIELD("Variant Code","Variant Code");
        IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
          ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-from Item Entry"));

        IF ABS("Quantity (Base)") > -ItemLedgEntry.Quantity THEN
        #25..43
              -QtyReturned,ItemLedgEntry.FIELDCAPTION("Document No."),
              ItemLedgEntry."Document No.",-QtyNotReturned);
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20
        IF ItemLedgEntry.TrackingExists THEN
        #22..46
        */
    //end;


    //Unsupported feature: Code Modification on "GetLineAmountToHandle(PROCEDURE 117)".

    //procedure GetLineAmountToHandle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetSalesHeader;
        LineAmount := ROUND(QtyToHandle * "Unit Price",Currency."Amount Rounding Precision");
        LineDiscAmount := ROUND("Line Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision");
        EXIT(LineAmount - LineDiscAmount);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Line Discount %" = 100 THEN
          EXIT(0);

        GetSalesHeader;
        LineAmount := ROUND(QtyToHandle * "Unit Price",Currency."Amount Rounding Precision");
        LineDiscAmount :=
          ROUND(
            LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision");
        EXIT(LineAmount - LineDiscAmount);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: JobPostLine) (VariableCollection) on "TestJobPlanningLine(PROCEDURE 60)".


    //Unsupported feature: Property Insertion (Local) on "TestJobPlanningLine(PROCEDURE 60)".



    //Unsupported feature: Code Modification on "TestJobPlanningLine(PROCEDURE 60)".

    //procedure TestJobPlanningLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Job Contract Entry No." = 0 THEN
          EXIT;
        JobPostLine.TestSalesLine(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Job Contract Entry No." = 0 THEN
          EXIT;

        JobPostLine.TestSalesLine(Rec);
        */
    //end;


    //Unsupported feature: Code Modification on "BlockDynamicTracking(PROCEDURE 58)".

    //procedure BlockDynamicTracking();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TrackingBlocked := SetBlock;
        ReserveSalesLine.Block(SetBlock);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ReserveSalesLine.Block(SetBlock);
        */
    //end;


    //Unsupported feature: Code Modification on "SetDefaultQuantity(PROCEDURE 62)".

    //procedure SetDefaultQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;
        IF SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Blank THEN BEGIN
          IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Quote) THEN BEGIN
            "Qty. to Ship" := 0;
        #5..12
            "Qty. to Invoice (Base)" := 0;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetSalesSetup;
        #2..15
        */
    //end;


    //Unsupported feature: Code Modification on "UpdatePrePaymentAmounts(PROCEDURE 64)".

    //procedure UpdatePrePaymentAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT ShipmentLine.GET("Shipment No.","Shipment Line No.") THEN BEGIN
          "Prepmt Amt to Deduct" := 0;
          "Prepmt VAT Diff. to Deduct" := 0;
        END ELSE BEGIN
          IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,ShipmentLine."Order No.",ShipmentLine."Order Line No.") THEN BEGIN
            IF ("Prepayment %" = 100) AND (Quantity <> SalesOrderLine.Quantity - SalesOrderLine."Quantity Invoiced") THEN
              "Prepmt Amt to Deduct" := "Line Amount"
        #8..14
            "Prepmt Amt to Deduct" := 0;
            "Prepmt VAT Diff. to Deduct" := 0;
          END;
        END;

        GetSalesHeader;
        SalesHeader.TESTFIELD("Prices Including VAT",SalesOrderHeader."Prices Including VAT");
        #22..36
        "Prepmt. VAT Base Amt." := "Prepayment Amount";
        "Prepmt. Amount Inv. Incl. VAT" := "Prepmt. Amt. Incl. VAT";
        "Prepmt Amt Deducted" := 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ("Document Type" <> "Document Type"::Invoice) OR ("Prepayment %" = 0) THEN
          EXIT;

        #1..3
        END ELSE
        #5..17
        #19..39
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TaxGroup) (VariableCollection) on "ValidateTaxGroupCode(PROCEDURE 79)".


    //Unsupported feature: Variable Insertion (Variable: TaxDetail) (VariableCollection) on "ValidateTaxGroupCode(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Name) on "ShowAsmToOrder(PROCEDURE 79)".


    //Unsupported feature: Property Insertion (Local) on "ShowAsmToOrder(PROCEDURE 79)".



    //Unsupported feature: Code Modification on "ShowAsmToOrder(PROCEDURE 79)".

    //procedure ShowAsmToOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ATOLink.ShowAsm(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Tax Group Code" = '' THEN
          EXIT;
        IF NOT TaxGroup.GET("Tax Group Code") THEN BEGIN
          TaxGroup.SETFILTER(Code,"Tax Group Code" + '*');
          IF TaxGroup.FINDFIRST THEN
            "Tax Group Code" := TaxGroup.Code
          ELSE
            TaxGroup.CreateTaxGroup("Tax Group Code");
        END;
        IF "Tax Area Code" <> '' THEN
          TaxDetail.ValidateTaxSetup("Tax Area Code","Tax Group Code");
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "InitICPartner(PROCEDURE 78)".



    //Unsupported feature: Code Modification on "InitICPartner(PROCEDURE 78)".

    //procedure InitICPartner();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesHeader."Bill-to IC Partner Code" <> '' THEN
          CASE Type OF
            Type::" ",Type::"Charge (Item)":
              BEGIN
                "IC Partner Ref. Type" := Type;
                "IC Partner Reference" := "No.";
              END;
            Type::"G/L Account":
              BEGIN
                "IC Partner Ref. Type" := Type;
                "IC Partner Reference" := GLAcc."Default IC Partner G/L Acc. No";
              END;
            Type::Item:
              BEGIN
                IF SalesHeader."Sell-to IC Partner Code" <> '' THEN
                  ICPartner.GET(SalesHeader."Sell-to IC Partner Code")
                ELSE
                  ICPartner.GET(SalesHeader."Bill-to IC Partner Code");
                CASE ICPartner."Outbound Sales Item No. Type" OF
                  ICPartner."Outbound Sales Item No. Type"::"Common Item No.":
                    VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Common Item No.");
                  ICPartner."Outbound Sales Item No. Type"::"Internal No.":
                    BEGIN
                      "IC Partner Ref. Type" := "IC Partner Ref. Type"::Item;
                      "IC Partner Reference" := "No.";
                    END;
                  ICPartner."Outbound Sales Item No. Type"::"Cross Reference":
                    BEGIN
                      VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Cross Reference");
                      ItemCrossReference.SETRANGE("Cross-Reference Type",
                        ItemCrossReference."Cross-Reference Type"::Customer);
                      ItemCrossReference.SETRANGE("Cross-Reference Type No.",
                        "Sell-to Customer No.");
                      ItemCrossReference.SETRANGE("Item No.","No.");
                      IF ItemCrossReference.FINDFIRST THEN
                        "IC Partner Reference" := ItemCrossReference."Cross-Reference No.";
                    END;
                END;
              END;
            Type::"Fixed Asset":
              BEGIN
                "IC Partner Ref. Type" := "IC Partner Ref. Type"::" ";
                "IC Partner Reference" := '';
              END;
            Type::Resource:
              BEGIN
                Resource.GET("No.");
                "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
                "IC Partner Reference" := Resource."IC Partner Purch. G/L Acc. No.";
              END;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF SalesHeader."Send IC Document" AND
           (SalesHeader."IC Direction" = SalesHeader."IC Direction"::Outgoing) AND
           (SalesHeader."Bill-to IC Partner Code" <> '')
        THEN
        #2..21
                  ICPartner."Outbound Sales Item No. Type"::"Internal No.",
                  ICPartner."Outbound Sales Item No. Type"::"Cross Reference":
                    BEGIN
                      IF ICPartner."Outbound Sales Item No. Type" = ICPartner."Outbound Sales Item No. Type"::"Internal No." THEN
                        VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::Item)
                      ELSE
                        VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Cross Reference");
                      ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Customer);
                      ItemCrossReference.SETRANGE("Cross-Reference Type No.","Sell-to Customer No.");
                      ItemCrossReference.SETRANGE("Item No.","No.");
                      ItemCrossReference.SETRANGE("Variant Code","Variant Code");
                      ItemCrossReference.SETRANGE("Unit of Measure","Unit of Measure Code");
                      IF ItemCrossReference.FINDFIRST THEN
                        "IC Partner Reference" := ItemCrossReference."Cross-Reference No."
                      ELSE
                        "IC Partner Reference" := "No.";
        #37..51
        */
    //end;


    //Unsupported feature: Code Modification on "VerifyItemLineDim(PROCEDURE 87)".

    //procedure VerifyItemLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Dimension Set ID" <> xRec."Dimension Set ID") AND (Type = Type::Item) THEN
          IF ("Qty. Shipped Not Invoiced" <> 0) OR ("Return Rcd. Not Invd." <> 0) THEN
            IF NOT CONFIRM(Text053,TRUE,TABLECAPTION) THEN
              ERROR(Text054);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsShippedReceivedItemDimChanged THEN
          ConfirmShippedReceivedItemDimChange;
        */
    //end;


    //Unsupported feature: Code Modification on "CheckWMS(PROCEDURE 98)".

    //procedure CheckWMS();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DialogText := Text035;
        IF (CurrFieldNo <> 0) AND (Type = Type::Item) THEN
          IF "Quantity (Base)" <> 0 THEN
            CASE "Document Type" OF
              "Document Type"::Invoice:
                IF "Shipment No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Shipment"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
              "Document Type"::"Credit Memo":
                IF "Return Receipt No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Receive"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
            END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF CurrFieldNo <> 0 THEN
          CheckLocationOnWMS;
        */
    //end;

    procedure UpdatePrepmtSetupFields()
    var
        GenPostingSetup: Record "252";
        GLAcc: Record "15";
    begin
        IF ("Prepayment %" <> 0) AND (Type <> Type::" ") THEN BEGIN
          TESTFIELD("Document Type","Document Type"::Order);
          TESTFIELD("No.");
          IF CurrFieldNo = FIELDNO("Prepayment %") THEN
            IF "System-Created Entry" THEN
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,0));
          IF "System-Created Entry" THEN
            "Prepayment %" := 0;
          GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
          IF GenPostingSetup."Sales Prepayments Account" <> '' THEN BEGIN
            GLAcc.GET(GenPostingSetup."Sales Prepayments Account");
            VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
            VATPostingSetup.TESTFIELD("VAT Calculation Type","VAT Calculation Type");
          END ELSE
            CLEAR(VATPostingSetup);
          "Prepayment VAT %" := VATPostingSetup."VAT %";
          "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
          "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
          IF "Prepmt. VAT Calc. Type" IN
             ["Prepmt. VAT Calc. Type"::"Reverse Charge VAT","Prepmt. VAT Calc. Type"::"Sales Tax"]
          THEN
            "Prepayment VAT %" := 0;
          "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
        END;
    end;

    procedure CalcShipmentDate(): Date
    begin
        IF "Planned Shipment Date" = 0D THEN
          EXIT("Shipment Date");

        IF FORMAT("Outbound Whse. Handling Time") <> '' THEN
          EXIT(
            CalendarMgmt.CalcDateBOC2(
              FORMAT("Outbound Whse. Handling Time"),
              "Planned Shipment Date",
              CalChange."Source Type"::Location,
              "Location Code",
              '',
              CalChange."Source Type"::"Shipping Agent",
              "Shipping Agent Code",
              "Shipping Agent Service Code",
              FALSE));

        EXIT(
          CalendarMgmt.CalcDateBOC(
            FORMAT(FORMAT('')),
            "Planned Shipment Date",
            CalChange."Source Type"::"Shipping Agent",
            "Shipping Agent Code",
            "Shipping Agent Service Code",
            CalChange."Source Type"::Location,
            "Location Code",
            '',
            FALSE));
    end;

    local procedure GetSalesSetup()
    begin
        IF NOT SalesSetupRead THEN
          SalesSetup.GET;
        SalesSetupRead := TRUE;
    end;

    local procedure SetReserveWithoutPurchasingCode()
    begin
        GetItem;
        IF Item.Reserve = Item.Reserve::Optional THEN BEGIN
          GetSalesHeader;
          Reserve := SalesHeader.Reserve;
        END ELSE
          Reserve := Item.Reserve;
    end;

    local procedure SetDefaultItemQuantity()
    begin
        GetSalesSetup;
        IF SalesSetup."Default Item Quantity" THEN BEGIN
          VALIDATE(Quantity,1);
          CheckItemAvailable(CurrFieldNo);
        END;
    end;

    procedure IsShippedReceivedItemDimChanged(): Boolean
    begin
        EXIT(("Dimension Set ID" <> xRec."Dimension Set ID") AND (Type = Type::Item) AND
          (("Qty. Shipped Not Invoiced" <> 0) OR ("Return Rcd. Not Invd." <> 0)));
    end;

    procedure ConfirmShippedReceivedItemDimChange(): Boolean
    begin
        IF NOT CONFIRM(Text053,TRUE,TABLECAPTION) THEN
          ERROR(Text054);

        EXIT(TRUE);
    end;

    procedure CheckLocationOnWMS()
    var
        DialogText: Text;
    begin
        IF Type = Type::Item THEN BEGIN
          DialogText := Text035;
          IF "Quantity (Base)" <> 0 THEN
            CASE "Document Type" OF
              "Document Type"::Invoice:
                IF "Shipment No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Shipment"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
              "Document Type"::"Credit Memo":
                IF "Return Receipt No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Receive"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
            END;
        END;
    end;

    local procedure ValidateReturnReasonCode(CallingFieldNo: Integer)
    var
        ReturnReason: Record "6635";
    begin
        IF CallingFieldNo = 0 THEN
          EXIT;
        IF "Return Reason Code" = '' THEN
          UpdateUnitPrice(CallingFieldNo);

        IF ReturnReason.GET("Return Reason Code") THEN BEGIN
          IF (CallingFieldNo <> FIELDNO("Location Code")) AND (ReturnReason."Default Location Code" <> '') THEN
            VALIDATE("Location Code",ReturnReason."Default Location Code");
          IF ReturnReason."Inventory Value Zero" THEN
            VALIDATE("Unit Cost (LCY)",0)
          ELSE
            IF "Unit Price" = 0 THEN
              UpdateUnitPrice(CallingFieldNo);
        END;
    end;

    procedure HasTypeToFillMandatotyFields(): Boolean
    begin
        EXIT(Type <> Type::" ");
    end;

    procedure GetDeferralAmount() DeferralAmount: Decimal
    begin
        IF "VAT Base Amount" <> 0 THEN
          DeferralAmount := "VAT Base Amount"
        ELSE
          DeferralAmount := "Line Amount" - "Inv. Discount Amount";
    end;

    local procedure UpdateDeferralAmounts()
    var
        AdjustStartDate: Boolean;
    begin
        GetSalesHeader;
        DeferralPostDate := SalesHeader."Posting Date";
        AdjustStartDate := TRUE;
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
          IF "Returns Deferral Start Date" = 0D THEN
            "Returns Deferral Start Date" := SalesHeader."Posting Date";
          DeferralPostDate := "Returns Deferral Start Date";
          AdjustStartDate := FALSE;
        END;

        DeferralUtilities.RemoveOrSetDeferralSchedule(
          "Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
          "Document Type","Document No.","Line No.",
          GetDeferralAmount,DeferralPostDate,Description,SalesHeader."Currency Code",AdjustStartDate);
    end;

    procedure ShowDeferrals(PostingDate: Date;CurrencyCode: Code[10]): Boolean
    begin
        EXIT(DeferralUtilities.OpenLineScheduleEdit(
            "Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
            "Document Type","Document No.","Line No.",
            GetDeferralAmount,PostingDate,Description,CurrencyCode));
    end;

    local procedure InitHeaderDefaults(SalesHeader: Record "36")
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
          IF (SalesHeader."Sell-to Customer No." = '') AND
             (SalesHeader."Sell-to Customer Template Code" = '')
          THEN
            ERROR(
              Text031,
              SalesHeader.FIELDCAPTION("Sell-to Customer No."),
              SalesHeader.FIELDCAPTION("Sell-to Customer Template Code"));
          IF (SalesHeader."Bill-to Customer No." = '') AND
             (SalesHeader."Bill-to Customer Template Code" = '')
          THEN
            ERROR(
              Text031,
              SalesHeader.FIELDCAPTION("Bill-to Customer No."),
              SalesHeader.FIELDCAPTION("Bill-to Customer Template Code"));
        END ELSE
          SalesHeader.TESTFIELD("Sell-to Customer No.");

        "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        "Currency Code" := SalesHeader."Currency Code";
        IF NOT IsServiceItem THEN
          "Location Code" := SalesHeader."Location Code";
        "Customer Price Group" := SalesHeader."Customer Price Group";
        "Customer Disc. Group" := SalesHeader."Customer Disc. Group";
        "Allow Line Disc." := SalesHeader."Allow Line Disc.";
        "Transaction Type" := SalesHeader."Transaction Type";
        "Transport Method" := SalesHeader."Transport Method";
        "Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
        "Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
        "Exit Point" := SalesHeader."Exit Point";
        Area := SalesHeader.Area;
        "Transaction Specification" := SalesHeader."Transaction Specification";
        "Tax Area Code" := SalesHeader."Tax Area Code";
        "Tax Liable" := SalesHeader."Tax Liable";
        IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND (Type <> Type::" ") THEN
          "Prepayment %" := SalesHeader."Prepayment %";
        "Prepayment Tax Area Code" := SalesHeader."Tax Area Code";
        "Prepayment Tax Liable" := SalesHeader."Tax Liable";
        "Responsibility Center" := SalesHeader."Responsibility Center";

        "Shipping Agent Code" := SalesHeader."Shipping Agent Code";
        "Shipping Agent Service Code" := SalesHeader."Shipping Agent Service Code";
        "Outbound Whse. Handling Time" := SalesHeader."Outbound Whse. Handling Time";
        "Shipping Time" := SalesHeader."Shipping Time";
    end;

    local procedure InitDeferralCode()
    begin
        IF "Document Type" IN
           ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Credit Memo","Document Type"::"Return Order"]
        THEN
          CASE Type OF
            Type::"G/L Account":
              VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");
            Type::Item:
              VALIDATE("Deferral Code",Item."Default Deferral Template Code");
            Type::Resource:
              VALIDATE("Deferral Code",Res."Default Deferral Template Code");
          END;
    end;

    procedure DefaultDeferralCode()
    begin
        CASE Type OF
          Type::"G/L Account":
            BEGIN
              GLAcc.GET("No.");
              InitDeferralCode;
            END;
          Type::Item:
            BEGIN
              GetItem;
              InitDeferralCode;
            END;
          Type::Resource:
            BEGIN
              Res.GET("No.");
              InitDeferralCode;
            END;
        END;
    end;

    procedure IsCreditDocType(): Boolean
    begin
        EXIT("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
    end;

    local procedure IsFullyInvoiced(): Boolean
    begin
        EXIT(("Qty. Shipped Not Invd. (Base)" = 0) AND ("Qty. Shipped (Base)" = "Quantity (Base)"))
    end;

    local procedure CleanDropShipmentFields()
    begin
        IF ("Purch. Order Line No." <> 0) AND IsFullyInvoiced THEN
          IF CleanPurchaseLineDropShipmentFields THEN BEGIN
            "Purchase Order No." := '';
            "Purch. Order Line No." := 0;
          END;
    end;

    local procedure CleanSpecialOrderFieldsAndCheckAssocPurchOrder()
    begin
        IF ("Special Order Purch. Line No." <> 0) AND IsFullyInvoiced THEN
          IF CleanPurchaseLineSpecialOrderFields THEN BEGIN
            "Special Order Purchase No." := '';
            "Special Order Purch. Line No." := 0;
          END;
        CheckAssocPurchOrder('');
    end;

    local procedure CleanPurchaseLineDropShipmentFields(): Boolean
    var
        PurchaseLine: Record "39";
    begin
        IF PurchaseLine.GET(PurchaseLine."Document Type"::Order,"Purchase Order No.","Purch. Order Line No.") THEN BEGIN
          IF PurchaseLine."Qty. Received (Base)" < "Qty. Shipped (Base)" THEN
            EXIT(FALSE);

          PurchaseLine."Sales Order No." := '';
          PurchaseLine."Sales Order Line No." := 0;
          PurchaseLine.MODIFY;
        END;

        EXIT(TRUE);
    end;

    local procedure CleanPurchaseLineSpecialOrderFields(): Boolean
    var
        PurchaseLine: Record "39";
    begin
        IF PurchaseLine.GET(PurchaseLine."Document Type"::Order,"Special Order Purchase No.","Special Order Purch. Line No.") THEN BEGIN
          IF PurchaseLine."Qty. Received (Base)" < "Qty. Shipped (Base)" THEN
            EXIT(FALSE);

          PurchaseLine."Special Order" := FALSE;
          PurchaseLine."Special Order Sales No." := '';
          PurchaseLine."Special Order Sales Line No." := 0;
          PurchaseLine.MODIFY;
        END;

        EXIT(TRUE);
    end;

    procedure CanEditUnitOfMeasureCode(): Boolean
    var
        ItemUnitOfMeasure: Record "5404";
    begin
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
          ItemUnitOfMeasure.SETRANGE("Item No.","No.");
          EXIT(ItemUnitOfMeasure.COUNT > 1);
        END;
        EXIT(TRUE);
    end;

    procedure InsertFreightLine(var FreightAmount: Decimal)
    var
        SalesLine: Record "37";
    begin
        IF FreightAmount <= 0 THEN BEGIN
          FreightAmount := 0;
          EXIT;
        END;

        SalesSetup.GET;
        SalesSetup.TESTFIELD("Freight G/L Acc. No.");

        TESTFIELD("Document Type");
        TESTFIELD("Document No.");

        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","Document No.");

        SalesLine.SETRANGE(Type,SalesLine.Type::"G/L Account");
        SalesLine.SETRANGE("No.",SalesSetup."Freight G/L Acc. No.");
        IF SalesLine.FINDFIRST THEN BEGIN
          SalesLine.VALIDATE(Quantity,1);
          SalesLine.VALIDATE("Unit Price",FreightAmount);
          SalesLine.MODIFY;
        END ELSE BEGIN
          SalesLine.SETRANGE(Type);
          SalesLine.SETRANGE("No.");
          SalesLine.FINDLAST;
          SalesLine."Line No." += 10000;

          SalesLine.INIT;
          SalesLine.VALIDATE(Type,SalesLine.Type::"G/L Account");
          SalesLine.VALIDATE("No.",SalesSetup."Freight G/L Acc. No.");
          SalesLine.VALIDATE(Description,FreightLineDescriptionTxt);
          SalesLine.VALIDATE(Quantity,1);
          SalesLine.VALIDATE("Unit Price",FreightAmount);
          SalesLine.INSERT;
        END;
    end;

    local procedure CalcTotalAmtToAssign(TotalQtyToAssign: Decimal) TotalAmtToAssign: Decimal
    begin
        TotalAmtToAssign := ("Line Amount" - "Inv. Discount Amount") * TotalQtyToAssign / Quantity;
        IF SalesHeader."Prices Including VAT" THEN
          TotalAmtToAssign := TotalAmtToAssign / (1 + "VAT %" / 100) - "VAT Difference";

        TotalAmtToAssign := ROUND(TotalAmtToAssign,Currency."Amount Rounding Precision");
    end;

    procedure IsLookupRequested() Result: Boolean
    begin
        Result := LookupRequested;
        LookupRequested := FALSE;
    end;

    procedure ClearSalesHeader()
    begin
        CLEAR(SalesHeader);
    end;

    procedure RenameNo(LineType: Option;OriginalNo: Code[20];NewNo: Code[20])
    begin
        RESET;
        SETRANGE(Type,LineType);
        SETRANGE("No.",OriginalNo);
        MODIFYALL("No.",NewNo);
    end;

    procedure UpdatePlanned(): Boolean
    begin
        TESTFIELD("Qty. per Unit of Measure");
        CALCFIELDS("Reserved Quantity");
        IF Planned = ("Reserved Quantity" = "Outstanding Quantity") THEN
          EXIT(FALSE);
        Planned := NOT Planned;
        EXIT(TRUE);
    end;

    procedure "---NSC1,0---"()
    begin
    end;

    local procedure TestStatusLocked()
    begin
        GetSalesHeader;
        IF SalesHeader."Quote statut" = SalesHeader."Quote statut"::locked THEN
          ERROR(TextG001);
    end;

    procedure CalcProfit()
    var
        reclPurchLine: Record "39";
    begin
        GetSalesHeader;
        IF (Type = Type::Item) AND ("Discount unit price" <> 0) THEN BEGIN
          //"Profit %" := ROUND(100 * (1 - ("Purchase cost" / "Discount unit price")),Currency."Amount Rounding Precision") ;
        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        IF (("Purchase cost" <> "Dispensed Purchase Cost") AND ("Dispensed Purchase Cost" <> 0)) THEN
           "Profit %" := 100 * (1 - ("Dispensed Purchase Cost" / "Discount unit price"))
        ELSE
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE

          "Profit %" := 100 * (1 - ("Purchase cost" / "Discount unit price"));
        END ;
    end;

    procedure CalcDiscount()
    var
        reclpurchline: Record "39";
    begin
        IF "Profit %" <> 100 THEN
          IF (Type = Type::Item) AND ("Purchase cost" <= (getUnitpriceHT * (1 - "Profit %" / 100))) THEN
           "Line Discount %" := 100 * (1 - ("Purchase cost" / (getUnitpriceHT * (1 - "Profit %" / 100))))
          ELSE
           "Line Discount %" := 0;

        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        FctGCalcLineDiscount();
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE

        IF "Line Discount %" < 0 THEN BEGIN
        //"Line Discount %" :=0 ;
        MESSAGE(TextG004 , "Profit %", getUnitpriceHT);

        END;
        //UpdateAmounts;
    end;

    procedure CalcDiscountUnitPrice()
    begin
        GetSalesHeader;
        IF Type = Type::Item THEN BEGIN
          "Discount unit price" :=
            //ROUND(getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100), Currency."Amount Rounding Precision");
            getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100);
        END ;
    end;

    procedure CalcLineDiscountAmount_asuppri()
    begin
        GetSalesHeader;
        IF (Type = Type::Item) AND (Quantity <> 0) THEN BEGIN
          VALIDATE("Line Discount Amount",
                     ROUND(getUnitpriceHT - "Discount unit price",
                       Currency."Amount Rounding Precision")) ;
          CalcProfit ;
        END ;
    end;

    procedure updatepurchasecost()
    var
        recLPurchLine: Record "39";
    begin
        IF ("Purch. Order No." <> '') AND ("Purch. Line No." <> 0) THEN
        BEGIN
          recLPurchLine.SETFILTER("Document Type", '%1', "Purch. Document Type");
          recLPurchLine.SETFILTER("Document No." ,"Purch. Order No.");
          recLPurchLine.SETFILTER("Line No." , '%1', "Purch. Line No.");
          IF FINDFIRST THEN
            "Purchase cost":= recLPurchLine."Direct Unit Cost"
          ELSE
            MESSAGE(TextG003 , "Purch. Document Type", "Purch. Order No.", "Purch. Line No.");
        END;
    end;

    procedure getUnitpriceHT() declpuht: Decimal
    begin
        GetSalesHeader;
        IF SalesHeader."Prices Including VAT" THEN
          declpuht := "Unit Price" / (1+ "VAT %" /100)
        ELSE
          declpuht := "Unit Price";
        //EXIT(ROUND(declpuht,Currency."Amount Rounding Precision"));
        EXIT(declpuht);
    end;

    procedure "---DEEE1.00---"()
    begin
    end;

    procedure CalculateDEEE(CodPNewReasonCode: Code[10])
    var
        RecLCustomer: Record "18";
        RecLReasonCode: Record "231";
        RecLDEEETariffs: Record "50007";
        RecLSalesSetup: Record "311";
        RecLItem: Record "27";
        IntLGenerate: Integer;
    begin
        //>>DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
        RecLSalesSetup.GET ;
        GetSalesHeader;
        
        //>>DEEE1.01
        IF SalesHeader."Sell-to Customer No." <> '' THEN BEGIN
        //<<DEEE1.01
          RecLCustomer.GET(SalesHeader."Sell-to Customer No.") ;
        //>>DEEE1.01
          BooGsubmittedtodeee := RecLCustomer."Submitted to DEEE";
        END
        ELSE BEGIN
          IF RecGCustTemplate.GET(SalesHeader."Sell-to Customer Template Code") THEN BEGIN
            BooGsubmittedtodeee := RecGCustTemplate."Submitted to DEEE";
          END;
        END;
        //<<DEEE1.01
        
        IF CodPNewReasonCode<>'' THEN
          SalesHeader."Reason Code":=CodPNewReasonCode ;
        
        IF NOT RecLReasonCode.GET(SalesHeader."Reason Code") THEN
          RecLReasonCode."Disable DEEE":=FALSE ;
        
        IntLGenerate:=0 ;
        
        //assign value 2-> posting + Stat
        //assign value 1-> just for Stat
        //assign value 0-> nothing to do
        
        IF RecLSalesSetup."DEEE Management" THEN BEGIN
          RecLItem.GET("No.");
          IF RecLItem."DEEE Category Code"='' THEN
            IntLGenerate:=0
          ELSE BEGIN
            //>>DEEE1.01
            //IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (RecLCustomer."Submitted to DEEE") THEN
            IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (BooGsubmittedtodeee) THEN
            //<<DEEE1.01
            IntLGenerate:=2 ;
            //>>DEEE1.01
            //IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (NOT RecLCustomer."Submitted to DEEE") THEN
            IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (NOT BooGsubmittedtodeee) THEN
            //<<DEEE1.01
            //TDL94.001
            //IntLGenerate:=1;
            IntLGenerate:=0;
          END ;
        END ;
        
        //"Is Line Submitted":=IntLGenerate ;
        
        IF IntLGenerate=0 THEN
          BEGIN
          //Initvalue
          "DEEE Unit Price":=0 ;
          "DEEE HT Amount":=0 ;
          "DEEE VAT Amount":=0 ;
          "DEEE TTC Amount":=0 ;
          "Eco partner DEEE":='' ;
          "DEEE Amount (LCY) for Stat":=0 ;
          //"Is Line Submitted":=0 ;
          EXIT ; //get out from there
        END ;
        
        
        //found the last tariff with the posting date (just for one eco partner)
        RecLDEEETariffs.RESET ;
        RecLDEEETariffs.SETRANGE("DEEE Code","DEEE Category Code") ;
        RecLDEEETariffs.SETRANGE("Eco Partner",RecLItem."Eco partner DEEE") ;
        //>>DEEE1.01
        IF SalesHeader."Posting Date" <> 0D THEN
        //<<DEEE1.01
          RecLDEEETariffs.SETFILTER("Date beginning",'<=%1',SalesHeader."Posting Date")
        //>>DEEE1.01
        ELSE
          RecLDEEETariffs.SETFILTER("Date beginning",'<=%1',SalesHeader."Document Date");
        //<<DEEE1.01
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
          ERROR('Paramétrage incorrect pour les filtres %1',RecLDEEETariffs.GETFILTERS) ; //textconstant
        END ;
        
        
        VALIDATE("DEEE Unit Price",RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."Number of Units DEEE") ;
        "Eco partner DEEE":=RecLItem."Eco partner DEEE" ;
        
        /*
        VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
        "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
        "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
        "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
        */
        
        IF IntLGenerate<>2 THEN BEGIN
        VALIDATE("DEEE HT Amount",0) ;
        "DEEE VAT Amount" := 0 ;
        "DEEE TTC Amount" := 0 ;
        //"Eco partner DEEE":='' ;
        END ;
        
        VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
        "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
        "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
        "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
        
        //<<DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner

    end;

    procedure "--CNE1.04--"()
    begin
    end;

    procedure FctGCalcLineDiscount()
    var
        RecLSalesLineDiscount: Record "7004";
        BooLCalc: Boolean;
        DecLDiscountAdded: Decimal;
        recLSalesheader: Record "36";
    begin
        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        IF "Discount unit price" <> 0 THEN BEGIN
        CLEAR(DecLDiscountAdded);
        IF "Standard Net Price" = 0 THEN
           "Standard Net Price" := "Discount unit price";
        IF recLSalesheader.GET("Document Type","Document No.") THEN;
        RecLSalesLineDiscount.RESET;
        RecLSalesLineDiscount.SETFILTER(Type,'%1|%2',RecLSalesLineDiscount.Type::Item,RecLSalesLineDiscount.Type::"Item Disc. Group");
        RecLSalesLineDiscount.SETFILTER(Code,'%1|%2',"No.","Item Disc. Group");
        RecLSalesLineDiscount.SETFILTER("Sales Type",'%1',RecLSalesLineDiscount."Sales Type"::Customer);
        RecLSalesLineDiscount.SETFILTER("Sales Code","Sell-to Customer No.");
        RecLSalesLineDiscount.SETFILTER("Minimum Quantity",'<=%1',Quantity);
        RecLSalesLineDiscount.SETFILTER("Added Discount %",'<>%1',0);
        IF RecLSalesLineDiscount.FIND('-') THEN REPEAT
           BooLCalc := TRUE;
           IF ((RecLSalesLineDiscount."Starting Date" <> 0D) AND (RecLSalesLineDiscount."Starting Date" >
           recLSalesheader."Order Date")) THEN
              BooLCalc := FALSE;
           IF ((RecLSalesLineDiscount."Ending Date" <> 0D) AND (RecLSalesLineDiscount."Ending Date" <
           recLSalesheader."Order Date")) THEN
              BooLCalc := FALSE;
           IF BooLCalc = TRUE THEN BEGIN
              IF RecLSalesLineDiscount."Added Discount %" > DecLDiscountAdded THEN BEGIN
                 DecLDiscountAdded := RecLSalesLineDiscount."Added Discount %";
                 "Dispensation No." := RecLSalesLineDiscount."Dispensation No.";
                 "Additional Discount %" := RecLSalesLineDiscount."Added Discount %";
              END;
           END;
        UNTIL RecLSalesLineDiscount.NEXT = 0;


        IF DecLDiscountAdded <> 0 THEN BEGIN
           //"Line Discount %" := "Line Discount %" + ((1 - "Line Discount %"/100)* DecLDiscountAdded);
           "Dispensed Purchase Cost" := ("Purchase cost" * (1 - DecLDiscountAdded/100));
        END;
        END;
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE
    end;

    procedure FctGDeletePurchLink()
    var
        PurchLine: Record "39";
    begin
        TESTFIELD("Document Type","Document Type"::Order);
        IF PurchLine.GET("Purch. Document Type","Purch. Order No.","Purch. Line No.") THEN
          BEGIN
            ERROR(TextG006);
        END ELSE BEGIN
          "Purch. Document Type" := 0;
          "Purch. Order No."  := '';
          "Purch. Line No." := 0;
          MODIFY;
        END;
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    procedure CalcIncreasePurchCost(var _IncrPurchCost: Decimal)
    var
        L_Item: Record "27";
    begin
        IF Type = Type::Item THEN
          IF (L_Item.GET("No.")) THEN
            //BC6 - MM 050319 >>
            IF L_Item."Cost Increase Coeff %" = 0 THEN
              _IncrPurchCost := "Purchase cost"
            ELSE
            //BC6 - MM 050319 <<
              _IncrPurchCost := ROUND("Purchase cost" * (1 + (L_Item."Cost Increase Coeff %" / 100)),0.01);
    end;

    procedure CalcIncreaseProfit(var _IncrProfit: Decimal;_IncrPurchCost: Decimal)
    var
        L_Item: Record "27";
    begin
        //BC6 - MM 050319 >>
        IF Type = Type::Item THEN
          IF (L_Item.GET("No.")) THEN
            IF L_Item."Cost Increase Coeff %" = 0 THEN
              _IncrProfit := "Profit %"
            ELSE
        //BC6 - MM 050319 <<
              IF "Discount unit price" <> 0 THEN
                _IncrProfit := ROUND(100 * (1 - (_IncrPurchCost / "Discount unit price")),0.01)
              ELSE
                _IncrProfit := 0;
    end;

    procedure ValidateIncreasePurchCost(var _IncrPurchCost: Decimal)
    begin
        CalcDecreasePurchCost(_IncrPurchCost);
        VALIDATE("Purchase cost", _IncrPurchCost);
        CalcIncreasePurchCost(_IncrPurchCost);
    end;

    local procedure CalcDecreasePurchCost(var _IncrPurchCost: Decimal)
    var
        L_Item: Record "27";
    begin
        IF Type = Type::Item THEN BEGIN
          IF L_Item.GET("No.") THEN
            _IncrPurchCost := ROUND(_IncrPurchCost / (1 + (L_Item."Cost Increase Coeff %" / 100)),0.01);
        END;
    end;

    procedure ValidateIncreaseProfit(var _IncrProfit: Decimal;var _IncrPurchCost: Decimal)
    var
        TargetedProfit: Decimal;
    begin
        CalcIncreasePurchCost(_IncrPurchCost);
        CalcDiscountIncreased(_IncrProfit,_IncrPurchCost);
        CalcDiscountUnitPriceIncreased;
        VALIDATE("Line Discount %");
    end;

    procedure CalcDiscountIncreased(IncreasedProfit: Decimal;IncreasedPurchaseCost: Decimal)
    var
        reclpurchline: Record "39";
    begin
        IF IncreasedProfit <> 100 THEN
          IF (Type = Type::Item) AND (IncreasedPurchaseCost <= (getUnitpriceHT * (1 - IncreasedProfit / 100))) THEN
           "Line Discount %" := 100 * (1 - (IncreasedPurchaseCost / (getUnitpriceHT * (1 - IncreasedProfit / 100))))
          ELSE
           "Line Discount %" := 0;

        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        FctGCalcLineDiscountIncreased();
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE

        IF "Line Discount %" < 0 THEN BEGIN
        //"Line Discount %" :=0 ;
        MESSAGE(TextG004 , IncreasedProfit, getUnitpriceHT);

        END;
        //UpdateAmounts;
    end;

    procedure CalcDiscountUnitPriceIncreased()
    begin
        GetSalesHeader;
        IF Type = Type::Item THEN BEGIN
          "Discount unit price" :=
            //ROUND(getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100), Currency."Amount Rounding Precision");
            getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100);
        END ;
    end;

    procedure FctGCalcLineDiscountIncreased()
    var
        RecLSalesLineDiscount: Record "7004";
        BooLCalc: Boolean;
        DecLDiscountAdded: Decimal;
        recLSalesheader: Record "36";
    begin
        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        IF "Discount unit price" <> 0 THEN BEGIN
        CLEAR(DecLDiscountAdded);
        IF "Standard Net Price" = 0 THEN
           "Standard Net Price" := "Discount unit price";
        IF recLSalesheader.GET("Document Type","Document No.") THEN;
        RecLSalesLineDiscount.RESET;
        RecLSalesLineDiscount.SETFILTER(Type,'%1|%2',RecLSalesLineDiscount.Type::Item,RecLSalesLineDiscount.Type::"Item Disc. Group");
        RecLSalesLineDiscount.SETFILTER(Code,'%1|%2',"No.","Item Disc. Group");
        RecLSalesLineDiscount.SETFILTER("Sales Type",'%1',RecLSalesLineDiscount."Sales Type"::Customer);
        RecLSalesLineDiscount.SETFILTER("Sales Code","Sell-to Customer No.");
        RecLSalesLineDiscount.SETFILTER("Minimum Quantity",'<=%1',Quantity);
        RecLSalesLineDiscount.SETFILTER("Added Discount %",'<>%1',0);
        IF RecLSalesLineDiscount.FIND('-') THEN REPEAT
           BooLCalc := TRUE;
           IF ((RecLSalesLineDiscount."Starting Date" <> 0D) AND (RecLSalesLineDiscount."Starting Date" >
           recLSalesheader."Order Date")) THEN
              BooLCalc := FALSE;
           IF ((RecLSalesLineDiscount."Ending Date" <> 0D) AND (RecLSalesLineDiscount."Ending Date" <
           recLSalesheader."Order Date")) THEN
              BooLCalc := FALSE;
           IF BooLCalc = TRUE THEN BEGIN
              IF RecLSalesLineDiscount."Added Discount %" > DecLDiscountAdded THEN BEGIN
                 DecLDiscountAdded := RecLSalesLineDiscount."Added Discount %";
                 "Dispensation No." := RecLSalesLineDiscount."Dispensation No.";
                 "Additional Discount %" := RecLSalesLineDiscount."Added Discount %";
              END;
           END;
        UNTIL RecLSalesLineDiscount.NEXT = 0;


        IF DecLDiscountAdded <> 0 THEN BEGIN
           //"Line Discount %" := "Line Discount %" + ((1 - "Line Discount %"/100)* DecLDiscountAdded);
           "Dispensed Purchase Cost" := ("Purchase cost" * (1 - DecLDiscountAdded/100));
        END;
        END;
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE
    end;

    local procedure UpdateReturnOrderTypeFromSalesHeader()
    var
        L_SalesHeader: Record "36";
    begin
        //>>BCSYS
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
          IF L_SalesHeader.GET("Document Type","Document No.") THEN;
          "Return Order Type" := L_SalesHeader."Return Order Type";
        END;
        //<<BCSYS
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Move on "ShowItemChargeAssgnt(PROCEDURE 5801).AssignItemChargeSales(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 35).PrevVatAmountLine(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 35).Currency(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 35).SalesTaxCalculate(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCPGInvRoundAcc(PROCEDURE 71).SalesSetup(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemCrossRef(PROCEDURE 48).CalledByFieldNo(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "SetDefaultQuantity(PROCEDURE 62).SalesSetup(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowAsmToOrder(PROCEDURE 79).ATOLink(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckWMS(PROCEDURE 98).DialogText(Variable 1001)".


    //Unsupported feature: Property Deletion (PasteIsValid).


    var
        TempSalesLine: Record "37" temporary;

    var
        TempSalesLine: Record "37" temporary;
        StandardText: Record "7";
        FixedAsset: Record "5600";

    var
        TypeHelper: Codeunit "10";
        "**NSC1.01**": Integer;
        SalesLineProfit: Record "7004";
        PurchPrice: Record "7012";
        SalesSetup: Record "311";

    var
        "--- FE032.001 ---": Integer;
        RecLSalesReceivablesSetup: Record "311";

    var
        L_Item: Record "27";
        L_Vendor: Record "23";
        L_UserSetup: Record "91";
        L_IncrPurchCost: Decimal;
        L_IncrProfit: Decimal;

    var
        WorkType: Record "200";

    var
        PurchasingCode: Record "5721";
        ShippingAgentServices: Record "5790";

    var
        ShippingAgentServices: Record "5790";


    //Unsupported feature: Property Modification (Id) on "OnDelete.SalesCommentLine(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //OnDelete.SalesCommentLine : 1003;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OnDelete.SalesCommentLine : 1001;
        //Variable type has not been exported.

    var
        RecLPurchLine: Record "39";

    var
        "---DEEE1.00---": Integer;
        RecLItem: Record "27";


    //Unsupported feature: Property Modification (Id) on "CalendarMgmt(Variable 1101)".

    //var
        //>>>> ORIGINAL VALUE:
        //CalendarMgmt : 1101;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CalendarMgmt : 1056;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CalChange(Variable 1102)".

    //var
        //>>>> ORIGINAL VALUE:
        //CalChange : 1102;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CalChange : 1052;
        //Variable type has not been exported.

    var
        SalesSetup: Record "311";
        ApplicationAreaSetup: Record "9178";
        TempItemTemplate: Record "1301" temporary;

    var
        ConfigTemplateHeader: Record "8618";

    var
        DeferralUtilities: Codeunit "1720";

    var
        AnotherItemWithSameDescrQst: Label 'We found an item with the description "%2" (No. %1).\Did you mean to change the current item to %1?', Comment='%1=Item no., %2=item description';

    var
        SalesSetupRead: Boolean;
        LookupRequested: Boolean;
        DeferralPostDate: Date;
        ItemNoFieldCaptionTxt: Label 'Item';
        FreightLineDescriptionTxt: Label 'Freight Amount';
        "--COR001--": ;
        TextDate: Label '0D';
        "--NSC1.01--": Integer;
        GLSetup: Record "98";
        TextG001: Label 'Quote Locked';
        textg002: Label 'You will lost link between Sales document No %1 line %2 \ and purchase document of type %3, No %4 ,  line %5 \ Are you sure?';
        TextG003: Label 'Document %1, No %2 line %3 not found';
        TextG004: Label 'Profit % %1 notpossible with %2 as Unit price (excluding VAT) ';
        BooGsubmittedtodeee: Boolean;
        RecGCustTemplate: Record "5105";
        "--- TDL94.001---": Integer;
        RecGCustomer: Record "18";
        TextG005: Label 'There is a Purchase Order existing for this Line. Do you want to continue ?';
        TextG006: Label 'Vous devez supprimer la ligne de commande d''achat pour cette ligne. ';
        RecGCompanyInfo: Record "79";
        UpdatePurchCostErr: Label 'Unable to modify %1';
        UpdateProfitErr: Label '%1 cannot be less than %2 in %3 %4';
        "---BC6---": Integer;
        SkipPurchCostVerif: Boolean;
}

