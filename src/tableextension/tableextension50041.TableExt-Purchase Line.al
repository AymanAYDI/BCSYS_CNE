tableextension 50041 tableextension50041 extends "Purchase Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //ACHATS BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
    // //Demande de prix FE004.2 11/12/2003 ajout champ 50000 à 50002
    //                                      Ajout controle sur Delete
    // //GESTION_REMISE FG 06/12/06 NSC1.01 FE25/26
    // //COUT_ACHAT FG 20/12/06 NSC1.01
    //              FLGR 26/12/06 NSC1.01 FE25/26
    // //Affect Sale Order CASC 10/01/2007 NSC1.01
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
    // FEP-ADVE-200706_18_B : MA 10/11/2007 : Suivi historique
    //           - Add key "No."
    //           - Add fields "Docuement Date flow", "Document Date"
    // FEP-ADVE-200706_18_E:MA 14/11/2007
    //           - Add Key Buy-from Vendor No.,Type,Document Type
    //           - Add Key Buy-from Vendor No.,Type,Document Type,Planned Receipt Date
    // ------------------------------------------------------------------------
    // 
    // //TODO point 57 FLGR 08/02/2007 : parametrer la demande de creation de prix négocié
    // 
    // //>>NSC2.02
    // TDL94.001:PA 24/05/2007 : Correct DEEE Stat
    // 
    // ////>>CNE2.05
    // FEP-ACHAT-200706_18_A.01:LY 25/01/2008 : Update linked sales line
    // 
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - add setcurrentkey
    // 
    // //>> CNE4.02
    // C:FE09 05.10.2011 : Availability Customer Area - Shipping Bin
    //                     - Lod Func    : GetDefaultBin
    // 
    // //>> MODIF HL 22/10/2012 SU-LALE cf appel TI127191
    //                      Ajout clé Sales Document Type,Sales Line No.,Sales No.
    // 
    // //>>CNEIC : 06/2015 : Ajout des champs 50060 et 50061 pour lien vers la ligne de commande de vente associée
    // //>>PDW : le 03/08/2015 : Même si la commande est lancée, il faut mettre à jour. (Fonction CalcDiscountDirectUnitCost)
    // ------------------------------------------------------------------------
    LookupPageID = 518;
    DrillDownPageID = 518;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (" ")) "Standard Text"
            ELSE
            IF (Type = CONST (G/L Account),
                                     System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
                                                                                          Account Type=CONST(Posting),
                                                                                          Blocked=CONST(No))
                                                                                          ELSE IF (Type=CONST(G/L Account),
                                                                                                   System-Created Entry=CONST(Yes)) "G/L Account"
                                                                                                   ELSE IF (Type=CONST(Item)) Item
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

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Expected Receipt Date"(Field 10)".

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
                                                                                              ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                              ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

            //Unsupported feature: Property Insertion (ValidateTableRelation) on "Description(Field 11)".

        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. to Receive"(Field 18)".


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

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Quantity Received"(Field 60)".

        modify("Sales Order Line No.")
        {
            TableRelation = IF (Drop Shipment=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                         Document No.=FIELD(Sales Order No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        modify("Attached to Line No.")
        {
            TableRelation = "Purchase Line"."Line No." WHERE (Document Type=FIELD(Document Type),
                                                              Document No.=FIELD(Document No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Amt. Rcd. Not Invoiced (LCY)"(Field 93)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 95)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Quantity"(Field 95)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order No."(Field 97)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Purchase Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                              Document No.=FIELD(Blanket Order No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Line No."(Field 98)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Partner Ref. Type"(Field 107)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Partner Reference"(Field 108)".

        modify("Job Line Type")
        {
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable';

            //Unsupported feature: Property Modification (OptionString) on ""Job Line Type"(Field 1002)".


            //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Type"(Field 1002)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Price"(Field 1003)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Price"(Field 1004)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Amount"(Field 1005)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Discount Amount"(Field 1006)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Discount %"(Field 1007)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Price (LCY)"(Field 1008)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Price (LCY)"(Field 1009)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Amount (LCY)"(Field 1010)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Disc. Amount (LCY)"(Field 1011)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Planning Line No."(Field 1019)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Remaining Qty."(Field 1030)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Prod. Order No."(Field 5401)".

        modify("Bin Code")
        {
            TableRelation = IF (Document Type=FILTER(Order|Invoice),
                                Quantity=FILTER(<0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                     Item No.=FIELD(No.),
                                                                                     Variant Code=FIELD(Variant Code))
                                                                                     ELSE IF (Document Type=FILTER(Return Order|Credit Memo),
                                                                                              Quantity=FILTER(>=0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                    Item No.=FIELD(No.),
                                                                                                                                                    Variant Code=FIELD(Variant Code))
                                                                                                                                                    ELSE Bin.Code WHERE (Location Code=FIELD(Location Code));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item),
                                No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                                ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. (Base)"(Field 5495)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""FA Posting Type"(Field 5601)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Depr. until FA Posting Date"(Field 5605)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Depr. Acquisition Cost"(Field 5606)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Duplication List"(Field 5613)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Nonstock(Field 5710)".


        //Unsupported feature: Property Insertion (Editable) on ""Purchasing Code"(Field 5711)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order Sales No."(Field 5714)".

        modify("Special Order Sales Line No.")
        {
            TableRelation = IF (Special Order=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                         Document No.=FIELD(Special Order Sales No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order Sales Line No."(Field 5715)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Promised Receipt Date"(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Planned Receipt Date"(Field 5794)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 5795)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Allow Item Charge Assignment"(Field 5800)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. to Assign"(Field 5801)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. Assigned"(Field 5802)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Qty. to Ship"(Field 5803)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Qty. Shipped"(Field 5809)".

        modify("Return Reason Code")
        {
            TableRelation = IF (Document Type=FILTER(Return Order),
                                Return Order Type=FILTER(Location)) "Return Reason" WHERE (Type=FILTER(Location))
                                ELSE IF (Document Type=FILTER(Return Order),
                                         Return Order Type=FILTER(SAV)) "Return Reason" WHERE (Type=FILTER(SAV));
        }
        modify("Operation No.")
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
                                                                              Prod. Order No.=FIELD(Prod. Order No.),
                                                                              Routing No.=FIELD(Routing No.));
        }
        modify("Prod. Order Line No.")
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE (Status=FILTER(Released..),
                                                                 Prod. Order No.=FIELD(Prod. Order No.));
        }


        //Unsupported feature: Code Insertion (VariableCollection) on "Type(Field 5).OnValidate".

        //trigger (Variable: TempPurchLine)()
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
            GetPurchHeader;
            TestStatusOpen;

            #4..37
              END;
              IF xRec.Type = Type::"Charge (Item)" THEN
                DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
            END;
            TempPurchLine := Rec;
            INIT;
            Type := TempPurchLine.Type;
            "System-Created Entry" := TempPurchLine."System-Created Entry";
            VALIDATE("FA Posting Type");

            IF Type = Type::Item THEN
              "Allow Item Charge Assignment" := TRUE
            ELSE
              "Allow Item Charge Assignment" := FALSE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..40
              IF xRec."Deferral Code" <> '' THEN
                DeferralUtilities.RemoveOrSetDeferralSchedule('',
                  DeferralUtilities.GetPurchDeferralDocType,'','',
                  xRec."Document Type",xRec."Document No.",xRec."Line No.",
                  xRec.GetDeferralAmount,PurchHeader."Posting Date",'',xRec."Currency Code",TRUE);
            #41..43

            IF xRec."Line Amount" <> 0 THEN
              "Recalculate Invoice Disc." := TRUE;

            #44..51
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""No."(Field 6).OnValidate".

        //trigger (Variable: TempPurchLine)()
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
            TestStatusOpen;
            TESTFIELD("Qty. Rcd. Not Invoiced",0);
            TESTFIELD("Quantity Received",0);
            TESTFIELD("Receipt No.",'');

            TESTFIELD("Prepmt. Amt. Inv.",0);

            TESTFIELD("Return Qty. Shipped Not Invd.",0);
            TESTFIELD("Return Qty. Shipped",0);
            TESTFIELD("Return Shipment No.",'');

            IF "Drop Shipment" THEN
              ERROR(
                Text001,
                FIELDCAPTION("No."),"Sales Order No.");

            IF "Special Order" THEN
              ERROR(
                Text001,
                FIELDCAPTION("No."),"Special Order Sales No.");

            IF "Prod. Order No." <> '' THEN
              ERROR(
                Text044,
                FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

            IF "No." <> xRec."No." THEN BEGIN
              IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
                ReservePurchLine.VerifyChange(Rec,xRec);
                CALCFIELDS("Reserved Qty. (Base)");
                TESTFIELD("Reserved Qty. (Base)",0);
                IF Type = Type::Item THEN
                  WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
              END;
              IF Type = Type::Item THEN
                DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
              IF Type = Type::"Charge (Item)" THEN
                DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
            END;
            TempPurchLine := Rec;
            INIT;
            Type := TempPurchLine.Type;
            "No." := TempPurchLine."No.";
            IF "No." = '' THEN
              EXIT;
            IF Type <> Type::" " THEN BEGIN
              Quantity := TempPurchLine.Quantity;
              "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
            END;

            "System-Created Entry" := TempPurchLine."System-Created Entry";
            GetPurchHeader;
            PurchHeader.TESTFIELD("Buy-from Vendor No.");

            "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
            "Currency Code" := PurchHeader."Currency Code";
            "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
            "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
            IF NOT IsServiceItem THEN
              "Location Code" := PurchHeader."Location Code";
            "Transaction Type" := PurchHeader."Transaction Type";
            "Transport Method" := PurchHeader."Transport Method";
            "Pay-to Vendor No." := PurchHeader."Pay-to Vendor No.";
            "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
            "VAT Bus. Posting Group" := PurchHeader."VAT Bus. Posting Group";
            "Entry Point" := PurchHeader."Entry Point";
            Area := PurchHeader.Area;
            "Transaction Specification" := PurchHeader."Transaction Specification";
            "Tax Area Code" := PurchHeader."Tax Area Code";
            "Tax Liable" := PurchHeader."Tax Liable";
            IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND (Type <> Type::" ") THEN
              "Prepayment %" := PurchHeader."Prepayment %";
            "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
            "Prepayment Tax Liable" := PurchHeader."Tax Liable";
            "Responsibility Center" := PurchHeader."Responsibility Center";

            "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
            "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
            "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
            "Order Date" := PurchHeader."Order Date";
            UpdateLeadTimeFields;
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
                  GetGLSetup;
                  Item.TESTFIELD(Blocked,FALSE);
                  Item.TESTFIELD("Gen. Prod. Posting Group");
                  IF Item.Type = Item.Type::Inventory THEN BEGIN
                    Item.TESTFIELD("Inventory Posting Group");
                    "Posting Group" := Item."Inventory Posting Group";
                  END;
                  Description := Item.Description;
                  "Description 2" := Item."Description 2";
                  "Unit Price (LCY)" := Item."Unit Price";
                  "Units per Parcel" := Item."Units per Parcel";
                  "Indirect Cost %" := Item."Indirect Cost %";
                  "Overhead Rate" := Item."Overhead Rate";
                  "Allow Invoice Disc." := Item."Allow Invoice Disc.";
                  "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                  "Tax Group Code" := Item."Tax Group Code";
                  Nonstock := Item."Created From Nonstock Item";
                  "Item Category Code" := Item."Item Category Code";
                  "Product Group Code" := Item."Product Group Code";
                  "Allow Item Charge Assignment" := TRUE;
                  PrepmtMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");

                  IF Item."Price Includes VAT" THEN BEGIN
                    IF NOT VATPostingSetup.GET(
                         Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
                    THEN
                      VATPostingSetup.INIT;
                    CASE VATPostingSetup."VAT Calculation Type" OF
                      VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                        VATPostingSetup."VAT %" := 0;
                      VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                        ERROR(
                          Text002,
                          VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                          VATPostingSetup."VAT Calculation Type");
                    END;
                    "Unit Price (LCY)" :=
                      ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT %" / 100),
                        GLSetup."Unit-Amount Rounding Precision");
                  END;

                  IF PurchHeader."Language Code" <> '' THEN
                    GetItemTranslation;

                  "Unit of Measure Code" := Item."Purch. Unit of Measure";
                END;
              Type::"3":
                ERROR(Text003);
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
                  "Indirect Cost %" := 0;
                  "Overhead Rate" := 0;
                END;
            END;

            VALIDATE("Prepayment %");

            IF Type <> Type::" " THEN BEGIN
              IF Type <> Type::"Fixed Asset" THEN
                VALIDATE("VAT Prod. Posting Group");
              Quantity := xRec.Quantity;
              VALIDATE("Unit of Measure Code");
              IF Quantity <> 0 THEN BEGIN
                InitOutstanding;
                IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
                  InitQtyToShip
                ELSE
                  InitQtyToReceive;
              END;
              UpdateWithWarehouseReceive;
              UpdateDirectUnitCost(FIELDNO("No."));
              "Job No." := xRec."Job No.";
              "Job Line Type" := xRec."Job Line Type";
              IF xRec."Job Task No." <> '' THEN BEGIN
                VALIDATE("Job Task No.",xRec."Job Task No.");
                IF "No." = xRec."No." THEN
                  VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
              END;
            END;

            CreateDim(
              DimMgt.TypeToTableID3(Type),"No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Responsibility Center","Responsibility Center",
              DATABASE::"Work Center","Work Center No.");
            DistIntegration.EnterPurchaseItemCrossRef(Rec);

            GetDefaultBin;

            PurchHeader.GET("Document Type","Document No.");
            IF PurchHeader."Send IC Document" THEN
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
                    ICPartner.GET(PurchHeader."Buy-from IC Partner Code");
                    CASE ICPartner."Outbound Purch. Item No. Type" OF
                      ICPartner."Outbound Purch. Item No. Type"::"Common Item No.":
                        VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Common Item No.");
                      ICPartner."Outbound Purch. Item No. Type"::"Internal No.":
                        BEGIN
                          "IC Partner Ref. Type" := "IC Partner Ref. Type"::Item;
                          "IC Partner Reference" := "No.";
                        END;
                      ICPartner."Outbound Purch. Item No. Type"::"Cross Reference":
                        BEGIN
                          VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Cross Reference");
                          ItemCrossReference.SETRANGE("Cross-Reference Type",
                            ItemCrossReference."Cross-Reference Type"::Vendor);
                          ItemCrossReference.SETRANGE("Cross-Reference Type No.",
                            "Buy-from Vendor No.");
                          ItemCrossReference.SETRANGE("Item No.","No.");
                          IF ItemCrossReference.FINDFIRST THEN
                            "IC Partner Reference" := ItemCrossReference."Cross-Reference No.";
                        END;
                      ICPartner."Outbound Purch. Item No. Type"::"Vendor Item No.":
                        BEGIN
                          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"Vendor Item No.";
                          "IC Partner Reference" := "Vendor Item No.";
                        END;
                    END;
                  END;
                Type::"Fixed Asset":
                  BEGIN
                    "IC Partner Ref. Type" := "IC Partner Ref. Type"::" ";
                    "IC Partner Reference" := '';
                  END;
              END;

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(TRUE);
              UpdatePricesFromJobJnlLine;
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

            #1..7
            TestReturnFieldsZero;
            #11..41
            IF xRec."Line Amount" <> 0 THEN
              "Recalculate Invoice Disc." := TRUE;
            #42..87
                  StandardText.GET("No.");
                  Description := StandardText.Description;
            #90..103
                  InitDeferralCode;
            #104..128

                  //>>MIGRATION NAV 2013
                  //>>FE25/26.01
                  "Public Price" := Item."Unit Price";
                   //<<MIGRATION NAv 2013
            #129..153
                  InitDeferralCode;
                  //>>MIGRATION NAV 2013
                  //>>DEEE1.00 : update category code
                  VALIDATE("DEEE Category Code",Item."DEEE Category Code");
                  //<<DEEE1.00 : update category code
                  //<<MIGRATION NAV 2013
            #154..158
                  FixedAsset.GET("No.");
                  FixedAsset.TESTFIELD(Inactive,FALSE);
                  FixedAsset.TESTFIELD(Blocked,FALSE);
                  GetFAPostingGroup;
                  Description := FixedAsset.Description;
                  "Description 2" := FixedAsset."Description 2";
            #165..181
            IF NOT (Type IN [Type::" ",Type::"Fixed Asset"]) THEN
              VALIDATE("VAT Prod. Posting Group");

            UpdatePrepmtSetupFields;

            IF Type <> Type::" " THEN BEGIN
            #187..197
              IF xRec."Job No." <> '' THEN
                VALIDATE("Job No.",xRec."Job No.");
            #199..206
            IF NOT ISTEMPORARY THEN
              CreateDim(
                DimMgt.TypeToTableID3(Type),"No.",
                DATABASE::Job,"Job No.",
                DATABASE::"Responsibility Center","Responsibility Center",
                DATABASE::"Work Center","Work Center No.");

            PurchHeader.GET("Document Type","Document No.");
            UpdateItemReference;
            #213..215
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(TRUE);
              UpdateJobPrices;
            END;
            //>>MIGRATION NAV 2013
            //COUT_ACHAT FG 20/12/06 NSC1.01
            CalcDiscountDirectUnitCost ;
            //Fin COUT_ACHAT FG 20/12/06 NSC1.01
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            IF "Location Code" <> '' THEN
              IF IsServiceItem THEN
                Item.TESTFIELD(Type,Item.Type::Inventory);
            IF xRec."Location Code" <> "Location Code" THEN BEGIN
              IF "Prepmt. Amt. Inv." <> 0 THEN
                IF NOT CONFIRM(Text046,FALSE,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code")) THEN BEGIN
                  "Location Code" := xRec."Location Code";
                  EXIT;
                END;
            #12..49

            GetDefaultBin;
            CheckWMS;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
                IF NOT CONFIRM(Text046,FALSE,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL) THEN BEGIN
            #9..52

            IF "Document Type" = "Document Type"::"Return Order" THEN
              ValidateReturnReasonCode(FIELDNO("Location Code"));
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Expected Receipt Date"(Field 10).OnValidate".

        //trigger (Variable: RecLSalesLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT TrackingBlocked THEN
              CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

            CheckReservationDateConflict(FIELDNO("Expected Receipt Date"));

            IF "Expected Receipt Date" <> 0D THEN
              VALIDATE(
                "Planned Receipt Date",
                CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
                  CalChange."Source Type"::Location,"Location Code",'',
                  CalChange."Source Type"::Location,"Location Code",'',FALSE))
            ELSE
              VALIDATE("Planned Receipt Date","Expected Receipt Date");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            #6..13

            //>>MIGRATION NAV 2013
            //>>ACHAT-200706-18-A.001:GR
            IF "Expected Receipt Date" <> 0D THEN
            BEGIN
              RecLSalesLine.RESET;
              //>>CorrectionSOBI
              RecLSalesLine.SETCURRENTKEY("Purch. Document Type","Purch. Order No.","Purch. Line No.");
              //<<CorrectionSOBI
              RecLSalesLine.SETRANGE("Purch. Document Type","Document Type");
              RecLSalesLine.SETRANGE("Purch. Order No.","Document No.");
              RecLSalesLine.SETRANGE("Purch. Line No.","Line No.");
              IF RecLSalesLine.FIND('-') THEN
              BEGIN
                REPEAT
                  RecLSalesLine.VALIDATE("Purchase Receipt Date","Expected Receipt Date");
                  //>> CNE6.01
                  RecLSalesLine."Promised Purchase Receipt Date" := (PurchHeader."Expected Receipt Date" <> 0D);
                  RecLSalesLine.MODIFY;
                UNTIL RecLSalesLine.NEXT = 0;
              END;
            END;
            //<<ACHAT-200706-18-A.001:GR
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Insertion on "Description(Field 11)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Item: Record "27";
            //TypeHelper: Codeunit "10";
            //ReturnValue: Text[50];
            //DescriptionIsNo: Boolean;
        //begin
            /*
            IF Type = Type::" " THEN
              EXIT;

            IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
              IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
                DescriptionIsNo := Item.GET(Description)
              ELSE
                DescriptionIsNo := FALSE;

              IF NOT DescriptionIsNo THEN BEGIN
                Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
                IF NOT Item.FINDFIRST THEN
                  EXIT;
                IF Item."No." = "No." THEN
                  EXIT;
                IF IsReceivedFromOcr THEN
                  EXIT;
                IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
                  VALIDATE("No.",Item."No.");
                EXIT;
              END;

              IF Item.TryGetItemNoOpenCard(ReturnValue,Description,FALSE,FALSE) THEN
                CASE ReturnValue OF
                  '',"No.":
                    Description := xRec.Description;
                  ELSE
                    VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
                END;
            END ELSE
              IF "No." = '' THEN
                IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
                  CurrFieldNo := FIELDNO("No.");
                  VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
                END;
            */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;

            IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
            #4..54
            ELSE
              VALIDATE("Line Discount %");

            IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
              ReservePurchLine.VerifyQuantity(Rec,xRec);
              UpdateWithWarehouseReceive;
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
              CheckApplToItemLedgEntry;
            END;
            #64..69
              "VAT Base Amount" := 0;
            END;

            IF ("Document Type" = "Document Type"::Invoice) AND ("Prepayment %" <> 0) THEN
              UpdatePrePaymentAmounts;

            IF "Job Planning Line No." <> 0 THEN
              VALIDATE("Job Planning Line No.");

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(TRUE);
              UpdatePricesFromJobJnlLine;
            END;

            CheckWMS;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..57
            UpdateWithWarehouseReceive;
            IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
              ReservePurchLine.VerifyQuantity(Rec,xRec);
            #61..72
            UpdatePrePaymentAmounts;
            #75..80
              UpdateJobPrices;
            #82..84

            //>>MIGRATION NAV 2013
            //<<DEEE1.00
            //CalculateDEEE('');
            //>>TDL94.001
            VALIDATE("DEEE HT Amount",0) ;
            "DEEE VAT Amount" := 0;
            "DEEE TTC Amount" := 0;
            "DEEE Amount (LCY) for Stat":=0;

            RecGVendor.GET("Buy-from Vendor No.");
            IF RecGVendor."Posting DEEE" THEN BEGIN
            //<<TDL94.001
              VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
              "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
              "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
              "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
            END;
            //<<DEEE1.00
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Direct Unit Cost"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VALIDATE("Line Discount %");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VALIDATE("Line Discount %");

            //>>MIGRATION NAV 2013
            //>>FE025/26 FLGR 26/12/06
            IF (xRec."Direct Unit Cost" <> "Direct Unit Cost") AND (xRec."Direct Unit Cost" <> 0) THEN
            BEGIN
            //>>//TODO point 57 FLGR 08/02/2007
              RecGPurchsetup.GET;
              IF RecGPurchsetup."Ask custom purch price" THEN
              BEGIN
            //<<//TODO point 57 FLGR 08/02/2007

              IF CONFIRM(Tectg003, FALSE) THEN
              BEGIN
                RecGPurchPrice.RESET;
                RecGPurchPrice.SETFILTER("Vendor No.", "Buy-from Vendor No.");
                RecGPurchPrice.SETFILTER("Item No.", "No.");
                RecGPurchPrice.SETFILTER("Starting Date", '%1', WORKDATE);
                IF NOT RecGPurchPrice.FIND('-') THEN
                BEGIN
                  RecGPurchPrice.INIT;
                  RecGPurchPrice.VALIDATE("Item No.", "No.");
                  RecGPurchPrice.VALIDATE("Vendor No.", "Buy-from Vendor No.");
                  RecGPurchPrice.VALIDATE("Starting Date", WORKDATE);
                  RecGPurchPrice.VALIDATE("Direct Unit Cost","Direct Unit Cost");
                  RecGPurchPrice.INSERT(TRUE);
                END;
                RecGPurchPrice.SETFILTER("Starting Date", '');
                PAGE.RUN(7012,RecGPurchPrice);
              END;
            //>>//TODO point 57 FLGR 08/02/2007
              END;
            //<<//TODO point 57 FLGR 08/02/2007

            END;
            //<<FE025/26 FLGR 26/12/06
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger (Variable: IndirectCostPercent)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            TESTFIELD("No.");
            TESTFIELD(Quantity);
            #4..9
            IF CurrFieldNo = FIELDNO("Unit Cost (LCY)") THEN
              IF Type = Type::Item THEN BEGIN
                GetItem;
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                  ERROR(
                    Text010,
                    FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
            #17..30

            IF ("Direct Unit Cost" <> 0) AND
               ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
            THEN
              "Indirect Cost %" :=
                ROUND(
                  (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
                  ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001)
            ELSE
              "Indirect Cost %" := 0;

            UpdateSalesCost;

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
              UpdatePricesFromJobJnlLine;
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
              IF Item."Costing Method" = Item."Costing Method"::Average THEN
            #14..33
            THEN BEGIN
              IndirectCostPercent :=
                ROUND(
                  (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
                  ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001);
              IF IndirectCostPercentCheck(IndirectCostPercent) THEN
                "Indirect Cost %" := IndirectCostPercent
              ELSE
                ERROR(CannotBeNegativeErr,FIELDCAPTION("Indirect Cost %"));
            END ELSE
            #40..45
              TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
              UpdateJobPrices;
            END
            */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            TESTFIELD(Quantity);
            IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
            #4..12
            "Inv. Disc. Amount to Invoice" := 0;
            UpdateAmounts;
            UpdateUnitCost;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetPurchHeader;
            "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
            #1..15
            */
        //end;


        //Unsupported feature: Code Modification on ""Indirect Cost %"(Field 54).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("No.");
            TestStatusOpen;

            IF Type = Type::"Charge (Item)" THEN
              TESTFIELD("Indirect Cost %",0);

            IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
              GetItem;
              IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                ERROR(
                  Text010,
                  FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
            END;

            UpdateUnitCost;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
              IF Item."Costing Method" = Item."Costing Method"::Average THEN
            #10..15
            */
        //end;


        //Unsupported feature: Code Modification on ""Drop Shipment"(Field 73).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
              ReservePurchLine.VerifyChange(Rec,xRec);
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            END;
            IF "Drop Shipment" THEN BEGIN
              "Bin Code" := '';
              EVALUATE("Inbound Whse. Handling Time",'<0D>');
              VALIDATE("Inbound Whse. Handling Time");
              InitOutstanding;
              InitQtyToReceive;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6

              //>>MIGRATION NAV 2013
              //STD EVALUATE("Inbound Whse. Handling Time",'<0D>');

              //>>ACHATS BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
              //std EVALUATE("Inbound Whse. Handling Time",'0D');
              EVALUATE("Inbound Whse. Handling Time",TextDate);
              //<<ACHATS BRRI 01.08.2006 COR001 [14] Ajout TextConstant TextDate
              //<<MIGRATION NAV 2013

            #8..11
            */
        //end;


        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Quantity Received",0);
            IF "Blanket Order Line No." <> 0 THEN BEGIN
              PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
              PurchLine2.TESTFIELD(Type,Type);
              PurchLine2.TESTFIELD("No.","No.");
              PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
              PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
              VALIDATE("Variant Code",PurchLine2."Variant Code");
              VALIDATE("Location Code",PurchLine2."Location Code");
              VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
              VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
              VALIDATE("Line Discount %",PurchLine2."Line Discount %");
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
              GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
              IF GenPostingSetup."Purch. Prepayments Account" <> '' THEN BEGIN
                GLAcc.GET(GenPostingSetup."Purch. Prepayments Account");
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
                  FIELDERROR("Prepmt. VAT Calc. Type",STRSUBSTNO(Text036,"Prepmt. VAT Calc. Type"));
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
            #24..26
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
            IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text038,"Prepmt. Amt. Inv."));
            IF "Prepmt. Line Amount" > "Line Amount" THEN
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,"Line Amount"));
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
            #1..7
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


        //Unsupported feature: Code Modification on ""Job Task No."(Field 1001).OnValidate".

        //trigger "(Field 1001)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');

            IF "Job Task No." <> xRec."Job Task No." THEN BEGIN
            #4..6
            END;

            IF "Job Task No." = '' THEN BEGIN
              CLEAR(JobJnlLine);
              "Job Line Type" := "Job Line Type"::" ";
              UpdatePricesFromJobJnlLine;
              EXIT;
            END;

            JobSetCurrencyFactor;
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(TRUE);
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
              CLEAR(TempJobJnlLine);
              "Job Line Type" := "Job Line Type"::" ";
              UpdateJobPrices;
              CreateDim(
                DimMgt.TypeToTableID3(Type),"No.",
                DATABASE::Job,"Job No.",
                DATABASE::"Responsibility Center","Responsibility Center",
                DATABASE::"Work Center","Work Center No.");
            #13..18
              UpdateJobPrices;
            END;
            UpdateDimensionsFromJobTask;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Unit Price"(Field 1003).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Unit Price","Job Unit Price");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Amount"(Field 1005).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Line Amount","Job Line Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Discount Amount"(Field 1006).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Discount %"(Field 1007).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Unit Price (LCY)"(Field 1008).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Unit Price (LCY)","Job Unit Price (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Unit Price (LCY)","Job Unit Price (LCY)");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Amount (LCY)"(Field 1010).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Disc. Amount (LCY)"(Field 1011).OnValidate".

        //trigger  Amount (LCY)"(Field 1011)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Receipt No.",'');
            IF "Document Type" = "Document Type"::Order THEN
              TESTFIELD("Quantity Received",0);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(FALSE);
              JobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Variant Code"(Field 5402).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Variant Code" <> '' THEN
              TESTFIELD(Type,Type::Item);
            TestStatusOpen;
            #4..26
            UpdateLeadTimeFields;
            UpdateDates;
            GetDefaultBin;
            DistIntegration.EnterPurchaseItemCrossRef(Rec);

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine(TRUE);
              UpdatePricesFromJobJnlLine;
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..29
            UpdateItemReference;
            #31..33
              UpdateJobPrices;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            TESTFIELD("Quantity Received",0);
            TESTFIELD("Qty. Received (Base)",0);
            TESTFIELD("Qty. Rcd. Not Invoiced",0);
            IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
              TESTFIELD("Receipt No.",'');
              TESTFIELD("Return Shipment No.",'');
            #8..25
                  "Unit of Measure" := UnitOfMeasureTranslation.Description;
              END;
            END;
            DistIntegration.EnterPurchaseItemCrossRef(Rec);
            IF "Prod. Order No." = '' THEN BEGIN
              IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
                GetItem;
            #33..43
              "Qty. per Unit of Measure" := 0;

            VALIDATE(Quantity);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            TESTFIELD("Return Qty. Shipped",0);
            TESTFIELD("Return Qty. Shipped (Base)",0);
            #5..28
            UpdateItemReference;
            #30..46
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Budgeted FA No."(Field 5611).OnValidate".

        //trigger (Variable: FixedAsset)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Budgeted FA No."(Field 5611).OnValidate".

        //trigger "(Field 5611)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Budgeted FA No." <> '' THEN BEGIN
              FA.GET("Budgeted FA No.");
              FA.TESTFIELD("Budgeted Asset",TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Budgeted FA No." <> '' THEN BEGIN
              FixedAsset.GET("Budgeted FA No.");
              FixedAsset.TESTFIELD("Budgeted Asset",TRUE);
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetPurchHeader;
            "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";

            #4..20
            IF ReturnedCrossRef.Description <> '' THEN
              Description := ReturnedCrossRef.Description;

            IF PurchHeader."Send IC Document" AND (PurchHeader."IC Direction" = PurchHeader."IC Direction"::Outgoing) THEN BEGIN
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


        //Unsupported feature: Code Modification on ""Lead Time Calculation"(Field 5792).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF "Requested Receipt Date" <> 0D THEN BEGIN
              VALIDATE("Planned Receipt Date");
            END ELSE
              GetUpdateBasicDates;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TestStatusOpen;
            LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

            #2..5
            */
        //end;


        //Unsupported feature: Code Modification on ""Planned Receipt Date"(Field 5794).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF "Promised Receipt Date" <> 0D THEN BEGIN
              IF "Planned Receipt Date" <> 0D THEN
            #4..21

            IF NOT TrackingBlocked THEN
              CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
            CheckReservationDateConflict(FIELDNO("Planned Receipt Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..24
            */
        //end;


        //Unsupported feature: Code Modification on ""Order Date"(Field 5795).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestStatusOpen;
            IF (CurrFieldNo <> 0) AND
               ("Document Type" = "Document Type"::Order) AND
            #4..23

            IF NOT TrackingBlocked THEN
              CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
            CheckReservationDateConflict(FIELDNO("Order Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..26
            */
        //end;


        //Unsupported feature: Code Modification on ""Return Reason Code"(Field 6608).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Return Reason Code" = '' THEN
              UpdateDirectUnitCost(FIELDNO("Return Reason Code"));

            IF ReturnReason.GET("Return Reason Code") THEN BEGIN
              IF ReturnReason."Default Location Code" <> '' THEN
                VALIDATE("Location Code",ReturnReason."Default Location Code");
              IF ReturnReason."Inventory Value Zero" THEN
                VALIDATE("Direct Unit Cost",0)
              ELSE
                UpdateDirectUnitCost(FIELDNO("Return Reason Code"));
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
            */
        //end;
        field(56;"Recalculate Invoice Disc.";Boolean)
        {
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
        }
        field(1700;"Deferral Code";Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";

            trigger OnValidate()
            var
                DeferralPostDate: Date;
            begin
                GetPurchHeader;
                DeferralPostDate := PurchHeader."Posting Date";

                DeferralUtilities.DeferralCodeOnValidate(
                  "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
                  "Document Type","Document No.","Line No.",
                  GetDeferralAmount,DeferralPostDate,
                  Description,PurchHeader."Currency Code");

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  "Returns Deferral Start Date" :=
                    DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetPurchDeferralDocType,
                      "Document Type","Document No.","Line No.","Deferral Code",PurchHeader."Posting Date");
            end;
        }
        field(1702;"Returns Deferral Start Date";Date)
        {
            Caption = 'Returns Deferral Start Date';

            trigger OnValidate()
            var
                DeferralHeader: Record "1701";
                DeferralUtilities: Codeunit "1720";
            begin
                GetPurchHeader;
                IF DeferralHeader.GET(DeferralUtilities.GetPurchDeferralDocType,'','',"Document Type","Document No.","Line No.") THEN
                  DeferralUtilities.CreateDeferralSchedule("Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
                    "Document Type","Document No.","Line No.",GetDeferralAmount,
                    DeferralHeader."Calc. Method","Returns Deferral Start Date",
                    DeferralHeader."No. of Periods",TRUE,
                    DeferralHeader."Schedule Description",FALSE,
                    PurchHeader."Currency Code");
            end;
        }
        field(50000;"Sales No.";Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;

            trigger OnLookup()
            var
                reclSalesHeader: Record "36";
            begin
                //>>MIG2013
                reclSalesHeader.SETFILTER("Document Type", '%1', reclSalesHeader."Document Type"::Order);
                reclSalesHeader.SETFILTER("No.","Sales No.");
                PAGE.RUNMODAL(PAGE::"Sales Order", reclSalesHeader) ;
                //<<MIG2013
            end;
        }
        field(50001;"Sales Line No.";Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(50002;"Sales Document Type";Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50003;"Document Date flow";Date)
        {
            CalcFormula = Lookup("Purchase Header"."Document Date" WHERE (No.=FIELD(Document No.)));
            Caption = 'Document Date';
            Description = 'CNE1.00';
            FieldClass = FlowField;
        }
        field(50004;"Document Date";Date)
        {
            Description = 'CNE1.00';
        }
        field(50022;"Public Price";Decimal)
        {
            Caption = 'Tarif Public';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
        }
        field(50025;"Sales Order Qty (Base)";Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Sales Line"."Quantity (Base)" WHERE (Purch. Document Type=FIELD(Document Type),
                                                                    Purch. Order No.=FIELD(Document No.),
                                                                    Purch. Line No.=FIELD(Line No.)));
            Caption = 'Sales Assigned Qty (Base)';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031;"Discount Direct Unit Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(50060;"Sales No. Order Lien";Code[20])
        {
            Caption = 'Sales No. Order Lien';
            Description = 'CNEIC';
        }
        field(50061;"Sales No. Line Lien";Integer)
        {
            Caption = 'Sales No. Line Lien';
            Description = 'CNEIC';
        }
        field(50120;"Return Order Type";Option)
        {
            Caption = 'Return Order Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;
        }
        field(50121;"Solution Code";Code[10])
        {
            Caption = 'Solution Code';
            Description = 'BCSYS';
            TableRelation = IF (Document Type=FILTER(Return Order),
                                Return Order Type=FILTER(Location)) "Return Solution" WHERE (Type=FILTER(Location))
                                ELSE IF (Document Type=FILTER(Return Order),
                                         Return Order Type=FILTER(SAV)) "Return Solution" WHERE (Type=FILTER(SAV));
        }
        field(50122;"Return Comment";Text[50])
        {
            Caption = 'Return Comment';
            Description = 'BCSYS';
        }
        field(50123;"Return Order-Shpt Sales Order";Code[20])
        {
            Caption = 'Return-Sales Order';
            Description = 'BCSYS';
        }
        field(50124;"Series No.";Text[250])
        {
            Caption = 'N° de série';
            Description = 'BCSYS';
        }
        field(80800;"DEEE Category Code";Code[10])
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
        field(80801;"DEEE Unit Price";Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';

            trigger OnValidate()
            var
                RecLCurrency: Record "4";
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetPurchHeader;
                RecLCurrency.InitRoundingPrecision;
                IF PurchHeader."Currency Code" <> '' THEN
                  "DEEE Unit Price (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "DEEE Unit Price",PurchHeader."Currency Factor"),
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
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00 onvalidate';
            Editable = false;

            trigger OnValidate()
            var
                RecLCurrency: Record "4";
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetPurchHeader;
                RecLCurrency.InitRoundingPrecision;
                IF PurchHeader."Currency Code" <> '' THEN
                  "DEEE HT Amount (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "DEEE HT Amount",PurchHeader."Currency Factor"),
                      RecLCurrency."Amount Rounding Precision")
                ELSE
                  "DEEE HT Amount (LCY)" :=
                    ROUND("DEEE HT Amount",RecLCurrency."Amount Rounding Precision");

                //<<DEEE1.00  : calculate DEEE amount (LCY)
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
            TableRelation = Vendor;
        }
        field(80808;"DEEE Amount (LCY) for Stat";Decimal)
        {
            Description = 'DEEE1.00';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Type,No.,Variant Code,Drop Shipment,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Location Code,Expected Receipt Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Pay-to Vendor No.,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Blanket Order No.,Blanket Order Line No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Type,Prod. Order No.,Prod. Order Line No.,Routing No.,Operation No."(Key)".

        key(Key1;"Document Type",Type,"No.")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key2;"No.")
        {
        }
        key(Key3;"Buy-from Vendor No.")
        {
        }
        key(Key4;"Document Type","Buy-from Vendor No.","No.")
        {
        }
        key(Key5;"Document Type","No.")
        {
        }
        key(Key6;"Document Date","Document Type","No.")
        {
        }
        key(Key7;"Buy-from Vendor No.",Type,"Document Type")
        {
        }
        key(Key8;"Buy-from Vendor No.",Type,"Document Type","Planned Receipt Date")
        {
        }
        key(Key9;"Sales Document Type","Sales Line No.","Sales No.")
        {
        }
        key(Key10;Type,"No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: SalesOrderLine)()
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
        IF NOT StatusCheckSuspended AND (PurchHeader.Status = PurchHeader.Status::Released) AND
           (Type IN [Type::"G/L Account",Type::"Charge (Item)"])
        THEN
        #5..16
        END;

        IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
          TESTFIELD("Prepmt. Amt. Inv.",0);

        IF "Sales Order Line No." <> 0 THEN BEGIN
          LOCKTABLE;
        #24..35
            SalesOrderLine."Special Order Purchase No." := '';
            SalesOrderLine."Special Order Purch. Line No." := 0;
            SalesOrderLine.MODIFY;
          END ELSE BEGIN
            IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") THEN
              BEGIN
              SalesOrderLine."Special Order Purchase No." := '';
              SalesOrderLine."Special Order Purch. Line No." := 0;
              SalesOrderLine.MODIFY;
            END;
          END;
        END;

        NonstockItemMgt.DelNonStockPurch(Rec);

        #51..76
        PurchCommentLine.SETRANGE("Document Line No.","Line No.");
        IF NOT PurchCommentLine.ISEMPTY THEN
          PurchCommentLine.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TestStatusOpen;

        //>>MIGRATION NAV 2013
        //>>FE004.2 et fe004.3
        //IF ("Sales No." <> '') OR ("Sales Line No." <> 0) THEN
        //BEGIN
        {  RecLSalesLine.RESET;
          RecGSalesLine.SETCURRENTKEY("Purch. Document Type","Purch. Order No.","Purch. Line No.");
          RecLSalesLine.SETRANGE("Purch. Document Type","Document Type");
          RecLSalesLine.SETFILTER("Purch. Order No.","Document No.");
          RecLSalesLine.SETRANGE("Purch. Line No.","Line No.");
          IF RecLSalesLine.FIND('-') THEN BEGIN
            REPEAT
            IF NOT CONFIRM(textg002, FALSE, "Document No.", "Line No.", RecLSalesLine."Document Type",
              RecLSalesLine."Document No.", RecLSalesLine."Line No." )
              THEN
                ERROR('');
        //    REPEAT
              RecLSalesLine.VALIDATE("Purch. Order No." , '');
              RecLSalesLine.VALIDATE("Purch. Line No." , 0);
              RecLSalesLine.MODIFY(TRUE);
            UNTIL RecLSalesLine.NEXT = 0 ;
          END;
        //END; }
        //<<FE004.2 et fe004.3
        //<<MIGRATION NAV 2013

        #2..19
          TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");
        #21..38
          END ELSE
        #40..45
        END;

        //>>MIGRATION NAV 2013
        //>> 19.03.2012 Delete Assign Sales Order
        IF "Document Type" = "Document Type"::Order THEN
          BEGIN
            LOCKTABLE;
            SalesOrderLine.LOCKTABLE;
            SalesOrderLine.RESET;
            SalesOrderLine.SETCURRENTKEY("Purch. Document Type","Purch. Order No.","Purch. Line No.");
            SalesOrderLine.SETRANGE("Purch. Document Type","Document Type");
            SalesOrderLine.SETRANGE("Purch. Order No.","Document No.");
            SalesOrderLine.SETRANGE("Purch. Line No.","Line No.");
            IF SalesOrderLine.FIND('-') THEN
              REPEAT
                SalesOrderLine."Purch. Document Type" := 0;
                SalesOrderLine."Purch. Order No."  := '';
                SalesOrderLine."Purch. Line No." := 0;
                SalesOrderLine.MODIFY;
            UNTIL SalesOrderLine.NEXT = 0 ;
        END;
        //<<MIGRATION NAV 2013
        #48..79

        IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
          PurchLine2.COPY(Rec);
          IF PurchLine2.FIND('<>') THEN BEGIN
            PurchLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
            PurchLine2.MODIFY;
        #46..48
        IF "Deferral Code" <> '' THEN
          DeferralUtilities.DeferralCodeOnDelete(
            DeferralUtilities.GetPurchDeferralDocType,'','',
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
          ReservePurchLine.VerifyQuantity(Rec,xRec);

        LOCKTABLE;
        PurchHeader."No." := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
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


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Document Type" = "Document Type"::"Blanket Order") AND
           ((Type <> xRec.Type) OR ("No." <> xRec."No."))
        THEN BEGIN
        #4..13

        IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") THEN
          ReservePurchLine.VerifyChange(Rec,xRec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16

        //>>MIGRATION NAV 2013
        //>>COUT_ACHAT
        CalcDiscountDirectUnitCost;
        //<<COUT_ACHAT
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "InitOutstandingAmount(PROCEDURE 19)".

    //procedure InitOutstandingAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Quantity = 0 THEN BEGIN
          "Outstanding Amount" := 0;
          "Outstanding Amount (LCY)" := 0;
          "Amt. Rcd. Not Invoiced" := 0;
          "Amt. Rcd. Not Invoiced (LCY)" := 0;
          "Return Shpd. Not Invd." := 0;
          "Return Shpd. Not Invd. (LCY)" := 0;
        END ELSE BEGIN
          GetPurchHeader;
          IF PurchHeader.Status = PurchHeader.Status::Released THEN
            AmountInclVAT := "Amount Including VAT"
          ELSE
            IF PurchHeader."Prices Including VAT" THEN
              AmountInclVAT := "Line Amount" - "Inv. Discount Amount"
            ELSE
              IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
                IF "Use Tax" THEN
                  AmountInclVAT := "Line Amount" - "Inv. Discount Amount"
                ELSE
                  AmountInclVAT :=
                    "Line Amount" - "Inv. Discount Amount" +
                    ROUND(
                      SalesTaxCalculate.CalculateTax(
                        "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                        "Line Amount" - "Inv. Discount Amount","Quantity (Base)",PurchHeader."Currency Factor"),
                      Currency."Amount Rounding Precision")
              END ELSE
                AmountInclVAT :=
                  ROUND(
                    ("Line Amount" - "Inv. Discount Amount") *
                    (1 + "VAT %" / 100 * (1 - PurchHeader."VAT Base Discount %" / 100)),
                    Currency."Amount Rounding Precision");
          VALIDATE(
            "Outstanding Amount",
            ROUND(
              AmountInclVAT * "Outstanding Quantity" / Quantity,
              Currency."Amount Rounding Precision"));
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
            VALIDATE(
              "Return Shpd. Not Invd.",
              ROUND(
                AmountInclVAT * "Return Qty. Shipped Not Invd." / Quantity,
                Currency."Amount Rounding Precision"))
          ELSE
            VALIDATE(
              "Amt. Rcd. Not Invoiced",
              ROUND(
                AmountInclVAT * "Qty. Rcd. Not Invoiced" / Quantity,
                Currency."Amount Rounding Precision"));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          "Outstanding Amt. Ex. VAT (LCY)" := 0;
        #4..9
          AmountInclVAT := "Amount Including VAT";
        #33..50
        */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToReceive(PROCEDURE 15)".

    //procedure InitQtyToReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Qty. to Receive" := "Outstanding Quantity";
        "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchSetup;
        IF (PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Remainder) OR
           ("Document Type" = "Document Type"::Invoice)
        THEN BEGIN
          "Qty. to Receive" := "Outstanding Quantity";
          "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Qty. to Receive" <> 0 THEN
            "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");

        InitQtyToInvoice;
        */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToShip(PROCEDURE 5803)".

    //procedure InitQtyToShip();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Return Qty. to Ship" := "Outstanding Quantity";
        "Return Qty. to Ship (Base)" := "Outstanding Qty. (Base)";

        InitQtyToInvoice;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchSetup;
        IF (PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Remainder) OR
           ("Document Type" = "Document Type"::"Credit Memo")
        THEN BEGIN
          "Return Qty. to Ship" := "Outstanding Quantity";
          "Return Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
        END ELSE
          IF "Return Qty. to Ship" <> 0 THEN
            "Return Qty. to Ship (Base)" := CalcBaseQty("Return Qty. to Ship");

        InitQtyToInvoice;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateDirectUnitCost(PROCEDURE 2)".

    //procedure UpdateDirectUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (CurrFieldNo <> 0) AND ("Prod. Order No." <> '') THEN
          UpdateAmounts;

        #4..9
          GetPurchHeader;
          PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
          PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
          VALIDATE("Direct Unit Cost");

          IF CalledByFieldNo IN [FIELDNO("No."),FIELDNO("Variant Code"),FIELDNO("Location Code")] THEN
            SetVendorItemNo;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12

          //>>MIGRATION NAV 2013
          //GESTION_REMISE FG 06/12/06 NSC1.01
          PurchPriceCalcMgt.FindVeryBestCost(Rec,PurchHeader) ;
          //Fin GESTION_REMISE FG 06/12/06 NSC1.01
          //<<MIGRATION NAV 2013

        #13..15
            UpdateItemReference;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateUnitCost(PROCEDURE 5)".

    //procedure UpdateUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchHeader;
        GetGLSetup;
        IF Quantity = 0 THEN
        #4..29

        IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
          GetItem;
          IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
            IF GetSKU THEN
              "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
            ELSE
        #37..46

        IF JobTaskIsSet AND NOT UpdateFromVAT AND NOT "Prepayment Line" THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          JobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdatePricesFromJobJnlLine;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..32
          IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
        #34..49
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        END;
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
        GetPurchHeader;

        IF "Line Amount" <> xRec."Line Amount" THEN
          "VAT Difference" := 0;
        IF "Line Amount" <> ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount" THEN BEGIN
          "Line Amount" :=
            ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount";
          "VAT Difference" := 0;
        END;

        IF NOT "Prepayment Line" THEN BEGIN
        #14..29
              IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
                FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
            END;
          END;
        END;
        UpdateVATAmounts;

        InitOutstandingAmount;

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
        GetPurchHeader;

        VATBaseAmount := "VAT Base Amount";
        "Recalculate Invoice Disc." := TRUE;

        IF "Line Amount" <> xRec."Line Amount" THEN BEGIN
          "VAT Difference" := 0;
          LineAmountChanged := TRUE;
        END;
        #7..10
          LineAmountChanged := TRUE;
        #11..32
          END ELSE
            IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
               ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
            THEN BEGIN
              IF "Line Amount" < xRec."Line Amount" THEN
                FIELDERROR("Line Amount",STRSUBSTNO(Text038,xRec."Line Amount"));
              FIELDERROR("Line Amount",STRSUBSTNO(Text039,xRec."Line Amount"));
            END;
        END;
        UpdateVATAmounts;
        IF VATBaseAmount <> "VAT Base Amount" THEN
          LineAmountChanged := TRUE;

        IF LineAmountChanged THEN BEGIN
          UpdateDeferralAmounts;
          LineAmountChanged := FALSE;
        END;
        #36..42

        //>>MIGRATION NAV 2013
        //COUT_ACHAT FG 20/12/06 NSC1.01
        CalcDiscountDirectUnitCost ;
        //Fin COUT_ACHAT FG 20/12/06 NSC1.01
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchHeader;
        PurchLine2.SETRANGE("Document Type","Document Type");
        PurchLine2.SETRANGE("Document No.","Document No.");
        #4..28
             (("VAT Calculation Type" IN
               ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"]) AND ("VAT %" <> 0))
          THEN
            IF PurchLine2.FINDSET THEN
              REPEAT
                TotalLineAmount := TotalLineAmount + PurchLine2."Line Amount";
                TotalInvDiscAmount := TotalInvDiscAmount + PurchLine2."Inv. Discount Amount";
                TotalAmount := TotalAmount + PurchLine2.Amount;
                TotalAmountInclVAT := TotalAmountInclVAT + PurchLine2."Amount Including VAT";
                TotalQuantityBase := TotalQuantityBase + PurchLine2."Quantity (Base)";
              UNTIL PurchLine2.NEXT = 0;

          IF PurchHeader."Prices Including VAT" THEN
            CASE "VAT Calculation Type" OF
        #43..56
                    ROUND(
                      (TotalAmount + Amount) * (PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                      Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                    TotalAmountInclVAT - TotalInvDiscAmount;
                END;
              "VAT Calculation Type"::"Full VAT":
                BEGIN
        #64..132
                END;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31
            IF NOT PurchLine2.ISEMPTY THEN BEGIN
              PurchLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
              TotalLineAmount := PurchLine2."Line Amount";
              TotalInvDiscAmount := PurchLine2."Inv. Discount Amount";
              TotalAmount := PurchLine2.Amount;
              TotalAmountInclVAT := PurchLine2."Amount Including VAT";
              TotalQuantityBase := PurchLine2."Quantity (Base)";
            END;
        #40..59
                    TotalAmountInclVAT - TotalInvDiscAmount - "Inv. Discount Amount";
        #61..135
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalesOrderLine) (VariableCollection) on "UpdateSalesCost(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "UpdateSalesCost(PROCEDURE 6)".

    //procedure UpdateSalesCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TRUE OF
          "Sales Order Line No." <> 0:
            // Drop Shipment
            SalesOrderLine.GET(
              SalesOrderLine."Document Type"::Order,
              "Sales Order No.",
              "Sales Order Line No.");
          "Special Order Sales Line No." <> 0:
            // Special Order
            BEGIN
              IF NOT
                 SalesOrderLine.GET(
                   SalesOrderLine."Document Type"::Order,
                   "Special Order Sales No.",
                   "Special Order Sales Line No.")
              THEN
                EXIT;
            END;
        #19..22
        SalesOrderLine."Unit Cost" := "Unit Cost" * SalesOrderLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure";
        SalesOrderLine.VALIDATE("Unit Cost (LCY)");
        SalesOrderLine.MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
            SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");
        #8..11
                 SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.")
        #16..25
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: FADeprBook) (VariableCollection) on "GetFAPostingGroup(PROCEDURE 10)".


    //Unsupported feature: Variable Insertion (Variable: FASetup) (VariableCollection) on "GetFAPostingGroup(PROCEDURE 10)".


    //Unsupported feature: Variable Insertion (Variable: Reservation) (VariableCollection) on "ShowReservation(PROCEDURE 8)".


    //Unsupported feature: Variable Insertion (Variable: ReservEntry) (VariableCollection) on "ShowReservationEntries(PROCEDURE 21)".



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

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntPurch) (VariableCollection) on "ShowItemChargeAssgnt(PROCEDURE 5801)".



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
        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
        #26..34
              Currency."Unit-Amount Rounding Precision");
        END;

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch,"Return Shipment No.")
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

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntPurch) (VariableCollection) on "UpdateItemChargeAssgnt(PROCEDURE 5807)".



    //Unsupported feature: Code Modification on "UpdateItemChargeAssgnt(PROCEDURE 5807)".

    //procedure UpdateItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Qty. Assigned","Qty. to Assign");
        IF ABS("Quantity Invoiced") > ABS(("Qty. Assigned" + "Qty. to Assign")) THEN
          ERROR(Text032,FIELDCAPTION("Quantity Invoiced"),FIELDCAPTION("Qty. Assigned"),FIELDCAPTION("Qty. to Assign"));

        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
        ItemChargeAssgntPurch.SETRANGE("Document Line No.","Line No.");
        ItemChargeAssgntPurch.CALCSUMS("Qty. to Assign");
        TotalQtyToAssign := ItemChargeAssgntPurch."Qty. to Assign";
        IF (CurrFieldNo <> 0) AND ("Unit Cost" <> xRec."Unit Cost") THEN BEGIN
          ItemChargeAssgntPurch.SETFILTER("Qty. Assigned",'<>0');
          IF ItemChargeAssgntPurch.FINDFIRST THEN
            ERROR(Text022,
              FIELDCAPTION("Unit Cost"));
          ItemChargeAssgntPurch.SETRANGE("Qty. Assigned");
        END;

        IF (CurrFieldNo <> 0) AND (Quantity <> xRec.Quantity) THEN BEGIN
          ItemChargeAssgntPurch.SETFILTER("Qty. Assigned",'<>0');
          IF ItemChargeAssgntPurch.FINDFIRST THEN
            ERROR(Text022,
              FIELDCAPTION(Quantity));
          ItemChargeAssgntPurch.SETRANGE("Qty. Assigned");
        END;

        IF ItemChargeAssgntPurch.FINDSET THEN BEGIN
          GetPurchHeader;
          IF PurchHeader."Prices Including VAT" THEN
            TotalAmtToAssign :=
              ROUND(("Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
                Currency."Amount Rounding Precision")
          ELSE
            TotalAmtToAssign := "Line Amount" - "Inv. Discount Amount";
          REPEAT
            ShareOfVAT := 1;
            IF PurchHeader."Prices Including VAT" THEN
        #38..43
                ItemChargeAssgntPurch."Unit Cost" :=
                  ROUND(("Line Amount" - "Inv. Discount Amount") / Quantity / ShareOfVAT,
                    Currency."Unit-Amount Rounding Precision");
            IF TotalQtyToAssign > 0 THEN BEGIN
              ItemChargeAssgntPurch."Amount to Assign" :=
                ROUND(ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
                  Currency."Amount Rounding Precision");
        #51..54
          UNTIL ItemChargeAssgntPurch.NEXT = 0;
          CALCFIELDS("Qty. to Assign");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
          EXIT;

        #1..4
        #6..12
          IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
        #14..20
          IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
        #22..28
          TotalAmtToAssign := CalcTotalAmtToAssign(TotalQtyToAssign);
        #35..46
            IF TotalQtyToAssign <> 0 THEN BEGIN
        #48..57
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntPurch) (VariableCollection) on "DeleteItemChargeAssgnt(PROCEDURE 5802)".



    //Unsupported feature: Code Modification on "DeleteItemChargeAssgnt(PROCEDURE 5802)".

    //procedure DeleteItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemChargeAssgntPurch.SETCURRENTKEY(
          "Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",DocType);
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",DocNo);
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",DocLineNo);
        IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
          ItemChargeAssgntPurch.DELETEALL(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..7
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemChargeAssgntPurch) (VariableCollection) on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".



    //Unsupported feature: Code Modification on "DeleteChargeChargeAssgnt(PROCEDURE 5804)".

    //procedure DeleteChargeChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Quantity Invoiced" <> 0 THEN BEGIN
          CALCFIELDS("Qty. Assigned");
          TESTFIELD("Qty. Assigned","Quantity Invoiced");
        END;
        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type",DocType);
        ItemChargeAssgntPurch.SETRANGE("Document No.",DocNo);
        ItemChargeAssgntPurch.SETRANGE("Document Line No.",DocLineNo);
        IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
          ItemChargeAssgntPurch.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF DocType <> "Document Type"::"Blanket Order" THEN
          IF "Quantity Invoiced" <> 0 THEN BEGIN
            CALCFIELDS("Qty. Assigned");
            TESTFIELD("Qty. Assigned","Quantity Invoiced");
          END;

        #5..10
        */
    //end;


    //Unsupported feature: Code Modification on "CheckItemChargeAssgnt(PROCEDURE 5800)".

    //procedure CheckItemChargeAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemChargeAssgntPurch.SETCURRENTKEY(
          "Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type","Document Type");
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.","Document No.");
        ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.","Line No.");
        #6..10
            ItemChargeAssgntPurch.TESTFIELD("Qty. to Assign",0);
          UNTIL ItemChargeAssgntPurch.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..13
        */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT PurchHeader.GET("Document Type","Document No.") THEN BEGIN
          PurchHeader."No." := '';
          PurchHeader.INIT;
        END;
        IF PurchHeader."Prices Including VAT" THEN
          EXIT('2,1,' + GetFieldCaption(FieldNumber));

        EXIT('2,0,' + GetFieldCaption(FieldNumber));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        CASE FieldNumber OF
          FIELDNO("No."):
            BEGIN
              IF ApplicationAreaSetup.IsFoundationEnabled THEN
                EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
              EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
            END;
          ELSE BEGIN
            IF PurchHeader."Prices Including VAT" THEN
              EXIT('2,1,' + GetFieldCaption(FieldNumber));
            EXIT('2,0,' + GetFieldCaption(FieldNumber));
          END
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateLeadTimeFields(PROCEDURE 11)".

    //procedure UpdateLeadTimeFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type = Type::Item THEN BEGIN
          GetPurchHeader;
          IF "Document Type" IN
             ["Document Type"::Quote,"Document Type"::Order]
          THEN
            StartingDate := PurchHeader."Order Date"
          ELSE
            StartingDate := PurchHeader."Posting Date";

          EVALUATE("Lead Time Calculation",
            LeadTimeMgt.PurchaseLeadTime(
        #12..14
            "Lead Time Calculation" := PurchHeader."Lead Time Calculation";
          EVALUATE("Safety Lead Time",LeadTimeMgt.SafetyLeadTime("No.","Location Code","Variant Code"));
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Type = Type::Item THEN BEGIN
          GetPurchHeader;
        #9..17
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: LineWasModified) (ReturnValueCollection) on "UpdateVATOnLines(PROCEDURE 32)".


    //Unsupported feature: Variable Insertion (Variable: DeferralAmount) (VariableCollection) on "UpdateVATOnLines(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 32)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF QtyType = QtyType::Shipping THEN
          EXIT;
        IF PurchHeader."Currency Code" = '' THEN
        #4..13
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                VATAmountLine.GET("VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","Line Amount" >= 0);
                IF VATAmountLine.Modified THEN BEGIN
                  IF NOT TempVATAmountLineRemainder.GET(
        #20..30
                      ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");

                  IF "Allow Invoice Disc." THEN BEGIN
                    IF VATAmountLine."Inv. Disc. Base Amount" = 0 THEN
                      InvDiscAmount := 0
                    ELSE BEGIN
                      IF QtyType = QtyType::General THEN
        #38..46
                      InvDiscAmount :=
                        ROUND(
                          TempVATAmountLineRemainder."Invoice Discount Amount",Currency."Amount Rounding Precision");
                      LineAmountToInvoiceDiscounted := ROUND(LineAmountToInvoiceDiscounted,Currency."Amount Rounding Precision");
                      IF (InvDiscAmount < 0) AND (LineAmountToInvoiceDiscounted = 0) THEN
                        InvDiscAmount := 0;
                      TempVATAmountLineRemainder."Invoice Discount Amount" :=
                        TempVATAmountLineRemainder."Invoice Discount Amount" - InvDiscAmount;
                    END;
        #56..132
                  IF Type = Type::"Charge (Item)" THEN
                    UpdateItemChargeAssgnt;
                  MODIFY;

                  TempVATAmountLineRemainder."Amount Including VAT" :=
                    NewAmountIncludingVAT - ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
        #139..142
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
        #35..49
        #53..135
                  LineWasModified := TRUE;

                  IF ("Deferral Code" <> '') AND (DeferralAmount <> GetDeferralAmount) THEN
                    UpdateDeferralAmounts;
        #136..145
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: AmtToHandle) (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 24)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF PurchHeader."Currency Code" = '' THEN
          Currency.InitRoundingPrecision
        ELSE
          Currency.GET(PurchHeader."Currency Code");

        VATAmountLine.DELETEALL;

        WITH PurchLine DO BEGIN
          SETRANGE("Document Type",PurchHeader."Document Type");
          SETRANGE("Document No.",PurchHeader."No.");
          IF FINDSET THEN
            REPEAT
              IF NOT ZeroAmountLine(QtyType) THEN BEGIN
                IF (Type = Type::"G/L Account") AND NOT "Prepayment Line" THEN
                  RoundingLineInserted := ("No." = GetVPGInvRoundAcc) OR RoundingLineInserted;
                IF "VAT Calculation Type" IN
                   ["VAT Calculation Type"::"Reverse Charge VAT","VAT Calculation Type"::"Sales Tax"]
                THEN
                  "VAT %" := 0;
                IF NOT VATAmountLine.GET(
                     "VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","Line Amount" >= 0)
                THEN BEGIN
                  VATAmountLine.INIT;
                  VATAmountLine."VAT Identifier" := "VAT Identifier";
                  VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                  VATAmountLine."Tax Group Code" := "Tax Group Code";
                  VATAmountLine."Use Tax" := "Use Tax";
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
                        (NOT PurchHeader.Receive) AND PurchHeader.Invoice AND (NOT "Prepayment Line"):
                          BEGIN
                            IF "Receipt No." = '' THEN BEGIN
                              QtyToHandle := GetAbsMin("Qty. to Invoice","Qty. Rcd. Not Invoiced");
                              VATAmountLine.Quantity :=
                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)","Qty. Rcd. Not Invoiced (Base)");
                            END ELSE BEGIN
                              QtyToHandle := "Qty. to Invoice";
                              VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                            END;
                          END;
                        ("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) AND
                        (NOT PurchHeader.Ship) AND PurchHeader.Invoice:
                          BEGIN
                            IF "Return Shipment No." = '' THEN BEGIN
                              QtyToHandle := GetAbsMin("Qty. to Invoice","Return Qty. Shipped Not Invd.");
                              VATAmountLine.Quantity :=
                                VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)","Ret. Qty. Shpd Not Invd.(Base)");
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
                      IF PurchHeader."Invoice Discount Calculation" <> PurchHeader."Invoice Discount Calculation"::Amount THEN
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
                        QtyToHandle := "Return Qty. to Ship";
                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Return Qty. to Ship (Base)";
                      END ELSE BEGIN
                        QtyToHandle := "Qty. to Receive";
                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Receive (Base)";
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
              IF PurchHeader."Prices Including VAT" THEN BEGIN
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
                          (1 - PurchHeader."VAT Base Discount %" / 100),
                          Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      "Amount Including VAT" := "VAT Base" + "VAT Amount";
                      IF Positive THEN
                        PrevVatAmountLine.INIT
                      ELSE BEGIN
                        PrevVatAmountLine := VATAmountLine;
                        PrevVatAmountLine."VAT Amount" :=
                          ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                          (1 - PurchHeader."VAT Base Discount %" / 100);
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
                      IF "Use Tax" THEN
                        "VAT Base" := "Amount Including VAT"
                      ELSE
                        "VAT Base" :=
                          ROUND(
                            SalesTaxCalculate.ReverseCalculateTax(
                              PurchHeader."Tax Area Code","Tax Group Code",PurchHeader."Tax Liable",
                              PurchHeader."Posting Date","Amount Including VAT",Quantity,PurchHeader."Currency Factor"),
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
                          "VAT Base" * "VAT %" / 100 * (1 - PurchHeader."VAT Base Discount %" / 100),
                          Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
                      "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount" + "VAT Amount";
                      IF Positive THEN
                        PrevVatAmountLine.INIT
                      ELSE
                        IF NOT "Includes Prepayment" THEN BEGIN
                          PrevVatAmountLine := VATAmountLine;
                          PrevVatAmountLine."VAT Amount" :=
                            "VAT Base" * "VAT %" / 100 * (1 - PurchHeader."VAT Base Discount %" / 100);
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
                      IF "Use Tax" THEN
                        "VAT Amount" := 0
                      ELSE
                        "VAT Amount" :=
                          SalesTaxCalculate.CalculateTax(
                            PurchHeader."Tax Area Code","Tax Group Code",PurchHeader."Tax Liable",
                            PurchHeader."Posting Date","VAT Base",Quantity,PurchHeader."Currency Factor");
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
          IF VATAmountLine.GET(PurchLine."VAT Identifier",PurchLine."VAT Calculation Type",
               PurchLine."Tax Group Code",PurchLine."Use Tax",PurchLine."Line Amount" >= 0)
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
        Currency.Initialize(PurchHeader."Currency Code");
        #5..14
                  RoundingLineInserted := ("No." = GetVPGInvRoundAcc(PurchHeader)) OR RoundingLineInserted;
        #16..21
                THEN
                  VATAmountLine.InsertNewLine(
                    "VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","VAT %","Line Amount" >= 0,FALSE);

                //>>MIGRATION NAV 2013
                //<<DEEE1.00 : Update VAT details (F9 without clic)
                //VATAmountLine."Is Line Submitted":="Is Line Submitted" ;
                //>>DEEE1.00 : Update VAT details (F9 without clic)
                //<<MIGRATION NAV 2013
        #33..35
                      VATAmountLine.Quantity += "Quantity (Base)";

                    //>>MIGRATION NAV 2013
                    //<<DEEE1.00 : Update VAT details (F9 without clic)
                    //IF VATAmountLine."Is Line Submitted"=2 THEN BEGIN
                      VATAmountLine."DEEE HT Amount":=VATAmountLine."DEEE HT Amount"+"DEEE HT Amount" ;
                      VATAmountLine."DEEE VAT Amount":=VATAmountLine."DEEE VAT Amount"+ROUND("DEEE VAT Amount"
                          ,Currency."Amount Rounding Precision");
                      VATAmountLine."DEEE TTC Amount":=VATAmountLine."DEEE TTC Amount"+ROUND("DEEE TTC Amount"
                          ,Currency."Amount Rounding Precision");
                      VATAmountLine."DEEE Amount (LCY) for Stat":=VATAmountLine."DEEE Amount (LCY) for Stat"+
                      "DEEE Amount (LCY) for Stat" ; //ooo
                    //END ;
                    //>>DEEE1.00 : Update VAT details (F9 without clic)
                    //<<MIGRATION NAV 2013

                      VATAmountLine.SumLine(
                        "Line Amount","Inv. Discount Amount","VAT Difference","Allow Invoice Disc.","Prepayment Line");
        #47..52
                          IF "Receipt No." = '' THEN BEGIN
                            QtyToHandle := GetAbsMin("Qty. to Invoice","Qty. Rcd. Not Invoiced");
                            VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Qty. Rcd. Not Invoiced (Base)");
                          END ELSE BEGIN
                            QtyToHandle := "Qty. to Invoice";
                            VATAmountLine.Quantity += "Qty. to Invoice (Base)";
        #62..64
                          IF "Return Shipment No." = '' THEN BEGIN
                            QtyToHandle := GetAbsMin("Qty. to Invoice","Return Qty. Shipped Not Invd.");
                            VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Ret. Qty. Shpd Not Invd.(Base)");
                          END ELSE BEGIN
                            QtyToHandle := "Qty. to Invoice";
                            VATAmountLine.Quantity += "Qty. to Invoice (Base)";
                          END;
                        ELSE BEGIN
                          QtyToHandle := "Qty. to Invoice";
                          VATAmountLine.Quantity += "Qty. to Invoice (Base)";
                        END;
                      END;
                      AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                      IF PurchHeader."Invoice Discount Calculation" <> PurchHeader."Invoice Discount Calculation"::Amount THEN
                        VATAmountLine.SumLine(
                          AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                          "VAT Difference","Allow Invoice Disc.","Prepayment Line")
                      ELSE
                        VATAmountLine.SumLine(
                          AmtToHandle,"Inv. Disc. Amount to Invoice","VAT Difference","Allow Invoice Disc.","Prepayment Line");
        #97..103
                        VATAmountLine.Quantity += "Return Qty. to Ship (Base)";
                      END ELSE BEGIN
                        QtyToHandle := "Qty. to Receive";
                        VATAmountLine.Quantity += "Qty. to Receive (Base)";
                      END;
                      AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                      VATAmountLine.SumLine(
                        AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                        "VAT Difference","Allow Invoice Disc.","Prepayment Line");
                    END;
                END;
                TotalVATAmount += "Amount Including VAT" - Amount;
        #124..127
        VATAmountLine.UpdateLines(
          TotalVATAmount,Currency,PurchHeader."Currency Factor",PurchHeader."Prices Including VAT",
          PurchHeader."VAT Base Discount %",PurchHeader."Tax Area Code",PurchHeader."Tax Liable",PurchHeader."Posting Date");
        #248..252
            VATAmountLine."VAT Amount" += TotalVATAmount;
            VATAmountLine."Amount Including VAT" += TotalVATAmount;
            VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
            VATAmountLine.MODIFY;
          END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemTranslation) (VariableCollection) on "GetItemTranslation(PROCEDURE 44)".



    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 50)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type <> Type::Item THEN
          EXIT;

        #4..7
        IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
          GetLocation("Location Code");
          IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
            WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            HandleDedicatedBin(FALSE);
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10

            //>>MIGRATION NAv 2013
            //STD WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            //>> C:FE09 Begin
            IF Location."Require Put-away" AND NOT (Location."Require Receive") THEN
              "Bin Code" := Location."Receipt Bin Code"
            ELSE
              WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            //<<MIGRATION NAV 2013
        #12..14
        */
    //end;


    //Unsupported feature: Code Modification on "CrossReferenceNoLookUp(PROCEDURE 51)".

    //procedure CrossReferenceNoLookUp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type = Type::Item THEN BEGIN
          GetPurchHeader;
          ItemCrossReference.RESET;
        #4..10
            VALIDATE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
            PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,FIELDNO("Cross-Reference No."));
            PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
            VALIDATE("Direct Unit Cost");
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13

            //>>MIGRATION ANV 2013
            //GESTION_REMISE FG 06/12/06 NSC1.01
            PurchPriceCalcMgt.FindVeryBestCost(Rec,PurchHeader) ;
            //Fin GESTION_REMISE FG 06/12/06 NSC1.01
            //<<MIGRATION NAv 2013
        #14..16
        */
    //end;


    //Unsupported feature: Code Modification on "CheckApplToItemLedgEntry(PROCEDURE 53)".

    //procedure CheckApplToItemLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Appl.-to Item Entry" = 0 THEN
          EXIT;

        #4..16
        END;
        ItemLedgEntry.GET("Appl.-to Item Entry");
        ItemLedgEntry.TESTFIELD(Positive,TRUE);
        IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
          ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));

        ItemLedgEntry.TESTFIELD("Item No.","No.");
        #24..48
          END;

        EXIT(ItemLedgEntry."Location Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19
        IF ItemLedgEntry.TrackingExists THEN
        #21..51
        */
    //end;


    //Unsupported feature: Code Modification on "GetLineAmountToHandle(PROCEDURE 117)".

    //procedure GetLineAmountToHandle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchHeader;
        LineAmount := ROUND(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision");
        LineDiscAmount := ROUND("Line Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision");
        EXIT(LineAmount - LineDiscAmount);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Line Discount %" = 100 THEN
          EXIT(0);

        GetPurchHeader;
        LineAmount := ROUND(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision");
        LineDiscAmount :=
          ROUND(
            LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision");
        EXIT(LineAmount - LineDiscAmount);
        */
    //end;


    //Unsupported feature: Code Modification on "CreateTempJobJnlLine(PROCEDURE 55)".

    //procedure CreateTempJobJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchHeader;
        CLEAR(JobJnlLine);
        JobJnlLine.DontCheckStdCost;
        JobJnlLine.VALIDATE("Job No.","Job No.");
        JobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        JobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
        JobJnlLine.SetCurrencyFactor("Job Currency Factor");
        IF Type = Type::"G/L Account" THEN
          JobJnlLine.VALIDATE(Type,JobJnlLine.Type::"G/L Account")
        ELSE
          JobJnlLine.VALIDATE(Type,JobJnlLine.Type::Item);
        JobJnlLine.VALIDATE("No.","No.");
        JobJnlLine.VALIDATE("Variant Code","Variant Code");
        JobJnlLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
        JobJnlLine.VALIDATE(Quantity,Quantity);

        IF NOT GetPrices THEN BEGIN
          IF xRec."Line No." <> 0 THEN BEGIN
            JobJnlLine."Unit Cost" := xRec."Unit Cost";
            JobJnlLine."Unit Cost (LCY)" := xRec."Unit Cost (LCY)";
            JobJnlLine."Unit Price" := xRec."Job Unit Price";
            JobJnlLine."Line Amount" := xRec."Job Line Amount";
            JobJnlLine."Line Discount %" := xRec."Job Line Discount %";
            JobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
          END ELSE BEGIN
            JobJnlLine."Unit Cost" := "Unit Cost";
            JobJnlLine."Unit Cost (LCY)" := "Unit Cost (LCY)";
            JobJnlLine."Unit Price" := "Job Unit Price";
            JobJnlLine."Line Amount" := "Job Line Amount";
            JobJnlLine."Line Discount %" := "Job Line Discount %";
            JobJnlLine."Line Discount Amount" := "Job Line Discount Amount";
          END;
          JobJnlLine.VALIDATE("Unit Price");
        END ELSE
          JobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchHeader;
        CLEAR(TempJobJnlLine);
        TempJobJnlLine.DontCheckStdCost;
        TempJobJnlLine.VALIDATE("Job No.","Job No.");
        TempJobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        TempJobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
        TempJobJnlLine.SetCurrencyFactor("Job Currency Factor");
        IF Type = Type::"G/L Account" THEN
          TempJobJnlLine.VALIDATE(Type,TempJobJnlLine.Type::"G/L Account")
        ELSE
          TempJobJnlLine.VALIDATE(Type,TempJobJnlLine.Type::Item);
        TempJobJnlLine.VALIDATE("No.","No.");
        TempJobJnlLine.VALIDATE(Quantity,Quantity);
        TempJobJnlLine.VALIDATE("Variant Code","Variant Code");
        TempJobJnlLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
        #16..18
            TempJobJnlLine."Unit Cost" := xRec."Unit Cost";
            TempJobJnlLine."Unit Cost (LCY)" := xRec."Unit Cost (LCY)";
            TempJobJnlLine."Unit Price" := xRec."Job Unit Price";
            TempJobJnlLine."Line Amount" := xRec."Job Line Amount";
            TempJobJnlLine."Line Discount %" := xRec."Job Line Discount %";
            TempJobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
          END ELSE BEGIN
            TempJobJnlLine."Unit Cost" := "Unit Cost";
            TempJobJnlLine."Unit Cost (LCY)" := "Unit Cost (LCY)";
            TempJobJnlLine."Unit Price" := "Job Unit Price";
            TempJobJnlLine."Line Amount" := "Job Line Amount";
            TempJobJnlLine."Line Discount %" := "Job Line Discount %";
            TempJobJnlLine."Line Discount Amount" := "Job Line Discount Amount";
          END;
          TempJobJnlLine.VALIDATE("Unit Price");
        END ELSE
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PurchRcptLine) (VariableCollection) on "UpdateJobPrices(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Name) on "UpdatePricesFromJobJnlLine(PROCEDURE 69)".



    //Unsupported feature: Code Modification on "UpdatePricesFromJobJnlLine(PROCEDURE 69)".

    //procedure UpdatePricesFromJobJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Job Unit Price" := JobJnlLine."Unit Price";
        "Job Total Price" := JobJnlLine."Total Price";
        "Job Unit Price (LCY)" := JobJnlLine."Unit Price (LCY)";
        "Job Total Price (LCY)" := JobJnlLine."Total Price (LCY)";
        "Job Line Amount (LCY)" := JobJnlLine."Line Amount (LCY)";
        "Job Line Disc. Amount (LCY)" := JobJnlLine."Line Discount Amount (LCY)";
        "Job Line Amount" := JobJnlLine."Line Amount";
        "Job Line Discount %" := JobJnlLine."Line Discount %";
        "Job Line Discount Amount" := JobJnlLine."Line Discount Amount";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Receipt No." = '' THEN BEGIN
          "Job Unit Price" := TempJobJnlLine."Unit Price";
          "Job Total Price" := TempJobJnlLine."Total Price";
          "Job Unit Price (LCY)" := TempJobJnlLine."Unit Price (LCY)";
          "Job Total Price (LCY)" := TempJobJnlLine."Total Price (LCY)";
          "Job Line Amount (LCY)" := TempJobJnlLine."Line Amount (LCY)";
          "Job Line Disc. Amount (LCY)" := TempJobJnlLine."Line Discount Amount (LCY)";
          "Job Line Amount" := TempJobJnlLine."Line Amount";
          "Job Line Discount %" := TempJobJnlLine."Line Discount %";
          "Job Line Discount Amount" := TempJobJnlLine."Line Discount Amount";
        END ELSE BEGIN
          PurchRcptLine.GET("Receipt No.","Receipt Line No.");
          "Job Unit Price" := PurchRcptLine."Job Unit Price";
          "Job Total Price" := PurchRcptLine."Job Total Price";
          "Job Unit Price (LCY)" := PurchRcptLine."Job Unit Price (LCY)";
          "Job Total Price (LCY)" := PurchRcptLine."Job Total Price (LCY)";
          "Job Line Amount (LCY)" := PurchRcptLine."Job Line Amount (LCY)";
          "Job Line Disc. Amount (LCY)" := PurchRcptLine."Job Line Disc. Amount (LCY)";
          "Job Line Amount" := PurchRcptLine."Job Line Amount";
          "Job Line Discount %" := PurchRcptLine."Job Line Discount %";
          "Job Line Discount Amount" := PurchRcptLine."Job Line Discount Amount";
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "JobSetCurrencyFactor(PROCEDURE 54)".

    //procedure JobSetCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetPurchHeader;
        CLEAR(JobJnlLine);
        JobJnlLine.VALIDATE("Job No.","Job No.");
        JobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        JobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
        "Job Currency Factor" := JobJnlLine."Currency Factor";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchHeader;
        CLEAR(TempJobJnlLine);
        TempJobJnlLine.VALIDATE("Job No.","Job No.");
        TempJobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        TempJobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
        "Job Currency Factor" := TempJobJnlLine."Currency Factor";
        */
    //end;


    //Unsupported feature: Code Modification on "SetDefaultQuantity(PROCEDURE 63)".

    //procedure SetDefaultQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchSetup.GET;
        IF PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Blank THEN BEGIN
          IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Quote) THEN BEGIN
            "Qty. to Receive" := 0;
        #5..12
            "Qty. to Invoice (Base)" := 0;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchSetup;
        #2..15
        */
    //end;


    //Unsupported feature: Code Modification on "UpdatePrePaymentAmounts(PROCEDURE 65)".

    //procedure UpdatePrePaymentAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT ReceiptLine.GET("Receipt No.","Receipt Line No.") THEN BEGIN
          "Prepmt Amt to Deduct" := 0;
          "Prepmt VAT Diff. to Deduct" := 0;
        #4..35
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

        #1..38
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemVend) (VariableCollection) on "SetVendorItemNo(PROCEDURE 64)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchHeader) (ParameterCollection) on "GetVPGInvRoundAcc(PROCEDURE 72)".



    //Unsupported feature: Code Modification on "GetVPGInvRoundAcc(PROCEDURE 72)".

    //procedure GetVPGInvRoundAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchSetup.GET;
        IF PurchSetup."Invoice Rounding" THEN
          IF Vendor.GET(PurchHeader."Pay-to Vendor No.") THEN
            VendorPostingGroup.GET(Vendor."Vendor Posting Group");

        EXIT(VendorPostingGroup."Invoice Rounding Account");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetPurchSetup;
        #2..6
        */
    //end;


    //Unsupported feature: Code Modification on "VerifyItemLineDim(PROCEDURE 73)".

    //procedure VerifyItemLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Dimension Set ID" <> xRec."Dimension Set ID") AND (Type = Type::Item) THEN
          IF ("Qty. Rcd. Not Invoiced" <> 0) OR ("Return Qty. Shipped Not Invd." <> 0) THEN
            IF NOT CONFIRM(Text049,TRUE,TABLECAPTION) THEN
              ERROR(Text050);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsReceivedShippedItemDimChanged THEN
          ConfirmReceivedShippedItemDimChange;
        */
    //end;


    //Unsupported feature: Code Modification on "CheckWMS(PROCEDURE 76)".

    //procedure CheckWMS();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DialogText := Text033;
        IF (CurrFieldNo <> 0) AND (Type = Type::Item) THEN
          IF "Quantity (Base)" <> 0 THEN
            CASE "Document Type" OF
              "Document Type"::Invoice:
                IF "Receipt No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Receive"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
              "Document Type"::"Credit Memo":
                IF "Return Shipment No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Shipment"));
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
          GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
          IF GenPostingSetup."Purch. Prepayments Account" <> '' THEN BEGIN
            GLAcc.GET(GenPostingSetup."Purch. Prepayments Account");
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

    local procedure GetPurchSetup()
    begin
        IF NOT PurchSetupRead THEN
          PurchSetup.GET;
        PurchSetupRead := TRUE;
    end;

    procedure ClearQtyIfBlank()
    begin
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          GetPurchSetup;
          IF PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Blank THEN BEGIN
            "Qty. to Receive" := 0;
            "Qty. to Receive (Base)" := 0;
          END;
        END;
    end;

    procedure IsReceivedShippedItemDimChanged(): Boolean
    begin
        EXIT(("Dimension Set ID" <> xRec."Dimension Set ID") AND (Type = Type::Item) AND
          (("Qty. Rcd. Not Invoiced" <> 0) OR ("Return Qty. Shipped Not Invd." <> 0)));
    end;

    procedure ConfirmReceivedShippedItemDimChange(): Boolean
    begin
        IF NOT CONFIRM(Text049,TRUE,TABLECAPTION) THEN
          ERROR(Text050);

        EXIT(TRUE);
    end;

    procedure CheckLocationOnWMS()
    var
        DialogText: Text;
    begin
        IF Type = Type::Item THEN BEGIN
          DialogText := Text033;
          IF "Quantity (Base)" <> 0 THEN
            CASE "Document Type" OF
              "Document Type"::Invoice:
                IF "Receipt No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Receive"));
                    ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
                  END;
              "Document Type"::"Credit Memo":
                IF "Return Shipment No." = '' THEN
                  IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
                    DialogText += Location.GetRequirementText(Location.FIELDNO("Require Shipment"));
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
          UpdateDirectUnitCost(CallingFieldNo);

        IF ReturnReason.GET("Return Reason Code") THEN BEGIN
          IF (CallingFieldNo <> FIELDNO("Location Code")) AND (ReturnReason."Default Location Code" <> '') THEN
            VALIDATE("Location Code",ReturnReason."Default Location Code");
          IF ReturnReason."Inventory Value Zero" THEN
            VALIDATE("Direct Unit Cost",0)
          ELSE
            UpdateDirectUnitCost(CallingFieldNo);
        END;
    end;

    local procedure UpdateDimensionsFromJobTask()
    var
        DimSetArrID: array [10] of Integer;
        DimValue1: Code[20];
        DimValue2: Code[20];
    begin
        DimSetArrID[1] := "Dimension Set ID";
        DimSetArrID[2] := DimMgt.CreateDimSetFromJobTaskDim("Job No.","Job Task No.",DimValue1,DimValue2);
        "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetArrID,DimValue1,DimValue2);
        "Shortcut Dimension 1 Code" := DimValue1;
        "Shortcut Dimension 2 Code" := DimValue2;
    end;

    local procedure UpdateItemCrossRef()
    begin
        DistIntegration.EnterPurchaseItemCrossRef(Rec);
        UpdateICPartner;
    end;

    local procedure UpdateItemReference()
    begin
        IF Type <> Type::Item THEN
          EXIT;

        UpdateItemCrossRef;
        IF "Cross-Reference No." = '' THEN
          SetVendorItemNo
        ELSE
          VALIDATE("Vendor Item No.","Cross-Reference No.");
    end;

    local procedure UpdateICPartner()
    var
        ICPartner: Record "413";
        ItemCrossReference: Record "5717";
    begin
        IF PurchHeader."Send IC Document" AND
           (PurchHeader."IC Direction" = PurchHeader."IC Direction"::Outgoing)
        THEN
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
                ICPartner.GET(PurchHeader."Buy-from IC Partner Code");
                CASE ICPartner."Outbound Purch. Item No. Type" OF
                  ICPartner."Outbound Purch. Item No. Type"::"Common Item No.":
                    VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Common Item No.");
                  ICPartner."Outbound Purch. Item No. Type"::"Internal No.",
                  ICPartner."Outbound Purch. Item No. Type"::"Cross Reference":
                    BEGIN
                      IF ICPartner."Outbound Purch. Item No. Type" = ICPartner."Outbound Purch. Item No. Type"::"Internal No." THEN
                        VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::Item)
                      ELSE
                        VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Cross Reference");
                      ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Vendor);
                      ItemCrossReference.SETRANGE("Cross-Reference Type No.","Buy-from Vendor No.");
                      ItemCrossReference.SETRANGE("Item No.","No.");
                      ItemCrossReference.SETRANGE("Variant Code","Variant Code");
                      ItemCrossReference.SETRANGE("Unit of Measure","Unit of Measure Code");
                      IF ItemCrossReference.FINDFIRST THEN
                        "IC Partner Reference" := ItemCrossReference."Cross-Reference No."
                      ELSE
                        "IC Partner Reference" := "No.";
                    END;
                  ICPartner."Outbound Purch. Item No. Type"::"Vendor Item No.":
                    BEGIN
                      "IC Partner Ref. Type" := "IC Partner Ref. Type"::"Vendor Item No.";
                      "IC Partner Reference" := "Vendor Item No.";
                    END;
                END;
              END;
            Type::"Fixed Asset":
              BEGIN
                "IC Partner Ref. Type" := "IC Partner Ref. Type"::" ";
                "IC Partner Reference" := '';
              END;
          END;
    end;

    local procedure CalcTotalAmtToAssign(TotalQtyToAssign: Decimal) TotalAmtToAssign: Decimal
    begin
        TotalAmtToAssign := ("Line Amount" - "Inv. Discount Amount") * TotalQtyToAssign / Quantity;

        IF PurchHeader."Prices Including VAT" THEN
          TotalAmtToAssign := TotalAmtToAssign / (1 + "VAT %" / 100) - "VAT Difference";

        TotalAmtToAssign := ROUND(TotalAmtToAssign,Currency."Amount Rounding Precision");
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
        DeferralPostDate: Date;
        AdjustStartDate: Boolean;
    begin
        GetPurchHeader;
        DeferralPostDate := PurchHeader."Posting Date";
        AdjustStartDate := TRUE;
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
          IF "Returns Deferral Start Date" = 0D THEN
            "Returns Deferral Start Date" := PurchHeader."Posting Date";
          DeferralPostDate := "Returns Deferral Start Date";
          AdjustStartDate := FALSE;
        END;

        DeferralUtilities.RemoveOrSetDeferralSchedule(
          "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
          "Document Type","Document No.","Line No.",
          GetDeferralAmount,DeferralPostDate,Description,PurchHeader."Currency Code",AdjustStartDate);
    end;

    procedure ShowDeferrals(PostingDate: Date;CurrencyCode: Code[10]): Boolean
    begin
        EXIT(DeferralUtilities.OpenLineScheduleEdit(
            "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
            "Document Type","Document No.","Line No.",
            GetDeferralAmount,PostingDate,Description,CurrencyCode));
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
        END;
    end;

    procedure IsCreditDocType(): Boolean
    begin
        EXIT("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
    end;

    procedure IsInvoiceDocType(): Boolean
    begin
        EXIT("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]);
    end;

    local procedure IsReceivedFromOcr(): Boolean
    var
        IncomingDocument: Record "130";
    begin
        GetPurchHeader;
        IF NOT IncomingDocument.GET(PurchHeader."Incoming Document Entry No.") THEN
          EXIT(FALSE);
        EXIT(IncomingDocument."OCR Status" = IncomingDocument."OCR Status"::Success);
    end;

    local procedure TestReturnFieldsZero()
    begin
        TESTFIELD("Return Qty. Shipped Not Invd.",0);
        TESTFIELD("Return Qty. Shipped",0);
        TESTFIELD("Return Shipment No.",'');
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

    procedure ClearPurchaseHeader()
    begin
        CLEAR(PurchHeader);
    end;

    procedure RenameNo(LineType: Option;OriginalNo: Code[20];NewNo: Code[20])
    begin
        RESET;
        SETRANGE(Type,LineType);
        SETRANGE("No.",OriginalNo);
        MODIFYALL("No.",NewNo);
    end;

    local procedure IndirectCostPercentCheck(IndirectCostPercent: Decimal): Boolean
    begin
        EXIT(
          (IndirectCostPercent >= 0) AND
          ("Document Type" IN
           ["Document Type"::Quote,"Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Blanket Order"]) OR
          (IndirectCostPercent <= 0) AND
          ("Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"])
          );
    end;

    procedure "---NSC1.01---"()
    begin
    end;

    procedure CalcDiscountDirectUnitCost()
    var
        RecLSalesLine: Record "37";
    begin
        IF (Type = Type::Item) THEN BEGIN
          GetPurchHeader;
          "Discount Direct Unit Cost" :=
            ROUND("Direct Unit Cost" - ("Direct Unit Cost" * "Line Discount %" / 100) ,Currency."Amount Rounding Precision");

          IF PurchHeader."Prices Including VAT" THEN
          BEGIN
            "Discount Direct Unit Cost" := "Discount Direct Unit Cost" / (1 + "VAT %" / 100 );
          END;
          //BCSYS 200618 remis le IF commenté
          IF ("Sales No." <> '') AND ("Sales Line No." <> 0) THEN
          BEGIN
            RecLSalesLine.SETCURRENTKEY("Purch. Document Type","Purch. Order No.","Purch. Line No.");
            RecLSalesLine.SETFILTER("Purch. Document Type", '%1', "Document Type");
            RecLSalesLine.SETFILTER("Purch. Order No." ,"Document No.");
            RecLSalesLine.SETFILTER("Purch. Line No." , '%1', "Line No.");
            IF RecLSalesLine.FIND('-') THEN BEGIN
              REPEAT
        //        RecLSalesLine.VALIDATE("Profit %", 0);
                //>>PDW : le 03/08/2015 : Même si la commande est lancée.
                RecLSalesLine.SuspendStatusCheck(TRUE);
                //<<PDW : le 03/08/2015
                RecLSalesLine.VALIDATE("Purchase cost", "Discount Direct Unit Cost");
                RecLSalesLine.MODIFY;
              UNTIL RecLSalesLine.NEXT = 0;
            END;
          END;
        END ;
    end;

    procedure ChooseSalesLineOrderToAffect()
    var
        RecLSalesLine: Record "37";
        FrmLLinkPurchSales: Page "50013";
    begin
        IF (Type=Type::Item) AND
           ("No."<>'') AND
           (Quantity<>0) AND
           // ("Sales No."='') AND
           // ("Sales Line No."=0) AND
           ("Discount Direct Unit Cost" <> 0) THEN BEGIN
          RecLSalesLine.RESET ;
          RecLSalesLine.SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Shipment Date") ;
          RecLSalesLine.FILTERGROUP(2) ;
          RecLSalesLine.SETRANGE(RecLSalesLine."Document Type",RecLSalesLine."Document Type"::Order) ;
          RecLSalesLine.SETRANGE(RecLSalesLine.Type,RecLSalesLine.Type::Item) ;
          RecLSalesLine.SETRANGE(RecLSalesLine."No.","No.") ;
          RecLSalesLine.SETRANGE(RecLSalesLine."Location Code","Location Code") ;
          RecLSalesLine.SETRANGE(RecLSalesLine."Purch. Order No.",'') ;
          RecLSalesLine.SETRANGE(RecLSalesLine."Purch. Line No.",0) ;
          RecLSalesLine.SETFILTER(RecLSalesLine.Quantity,'<>%1',0) ;
          //>> 05.01.2012
          RecGSalesLine.SETFILTER("Outstanding Quantity",'<>%1',0);
          // RecLSalesLine.SETRANGE(RecLSalesLine."Quantity Shipped",0) ;
          RecLSalesLine.FILTERGROUP(0) ;
          IF RecLSalesLine.FIND('-') THEN BEGIN
            FrmLLinkPurchSales.SETTABLEVIEW(RecLSalesLine) ;
            FrmLLinkPurchSales.LOOKUPMODE:=TRUE ;
            IF FrmLLinkPurchSales.RUNMODAL = ACTION::LookupOK THEN BEGIN
              RecLSalesLine.SETRANGE(RecLSalesLine."Affect purchase order",TRUE) ;
              IF RecLSalesLine.FIND('-') THEN BEGIN
                REPEAT
                  RecLSalesLine.VALIDATE("Purch. Document Type",RecLSalesLine."Purch. Document Type"::Order) ;
                  RecLSalesLine.VALIDATE("Purch. Order No.","Document No.") ;
                  RecLSalesLine.VALIDATE("Purch. Line No.","Line No.") ;
                  RecLSalesLine.VALIDATE("Purchase cost","Discount Direct Unit Cost") ;
                  RecLSalesLine.VALIDATE("Order purchase affected",TRUE) ;
                  RecLSalesLine.MODIFY ;

                  RecLSalesLine.MARK(TRUE) ;
                UNTIL RecLSalesLine.NEXT=0 ;

                RecLSalesLine.MARKEDONLY(TRUE) ;
                RecLSalesLine.MODIFYALL(RecLSalesLine."Affect purchase order",FALSE) ;

                MESSAGE('Affectation terminée.') ;
              END ;
            END;
          END
          //>>CASC Affect Sale Order
          ELSE
            MESSAGE(TextG001);
          //<<CASC Affect Sale Order
        END
        //>>CASC Affect Sale Order
        ELSE
          MESSAGE(TextG001);
        //<< CASC Affect Sale Order
    end;

    procedure "---DEEE1.00---"()
    begin
    end;

    procedure CalculateDEEE(CodPNewReasonCode: Code[10])
    var
        RecLVendor: Record "23";
        RecLReasonCode: Record "231";
        RecLDEEETariffs: Record "50007";
        RecLPurchSetup: Record "312";
        RecLItem: Record "27";
        IntLGenerate: Integer;
    begin
        //>>DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
        RecLPurchSetup.GET ;
        GetPurchHeader;
        RecLVendor.GET(PurchHeader."Buy-from Vendor No.") ;

        IF CodPNewReasonCode<>''
           THEN PurchHeader."Reason Code":=CodPNewReasonCode ;

        IF NOT RecLReasonCode.GET(PurchHeader."Reason Code")
           THEN RecLReasonCode."Disable DEEE":=FALSE ;

        IntLGenerate:=0 ;

        //assign value 2-> posting + Stat
        //assign value 1-> just for Stat
        //assign value 0-> nothing to do

        IF RecLPurchSetup."DEEE Management" THEN BEGIN
          RecLItem.GET("No.");
          IF RecLItem."DEEE Category Code"='' THEN
            IntLGenerate:=0
          ELSE BEGIN
            IF ((PurchHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (RecLVendor."Posting DEEE") THEN
              IntLGenerate:=2 ;
            IF ((PurchHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (NOT RecLVendor."Posting DEEE") THEN
            //>>TDL94.001
              IntLGenerate:=0;
              //IntLGenerate:=1;
            //<<TDL94.001
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

        //found the last tariff with the posting date (just one eco partner)
        RecLDEEETariffs.RESET ;
        RecLDEEETariffs.SETRANGE("DEEE Code","DEEE Category Code") ;
        RecLDEEETariffs.SETRANGE("Eco Partner",RecLItem."Eco partner DEEE") ;
        RecLDEEETariffs.SETFILTER("Date beginning",'<=%1',PurchHeader."Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
          ERROR('Paramétrage incorrect pour les filtres %1',RecLDEEETariffs.GETFILTERS) ; //textconstant
        END ;

        VALIDATE("DEEE Unit Price",RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."Number of Units DEEE") ;
        VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
        "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
        "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
        "Eco partner DEEE":=RecLItem."Eco partner DEEE" ;
        "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;

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

    local procedure UpdateReturnOrderTypeFromSalesHeader()
    var
        L_PurchaseHeader: Record "38";
    begin
        //>>BCSYS
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
          IF L_PurchaseHeader.GET("Document Type","Document No.") THEN;
          "Return Order Type" := L_PurchaseHeader."Return Order Type";
        END;
        //<<BCSYS
    end;

    //Unsupported feature: Move on "ShowItemChargeAssgnt(PROCEDURE 5801).AssignItemChargePurch(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateLeadTimeFields(PROCEDURE 11).StartingDate(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24).PrevVatAmountLine(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24).Currency(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcVATAmountLines(PROCEDURE 24).SalesTaxCalculate(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "SetDefaultQuantity(PROCEDURE 63).PurchSetup(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetVPGInvRoundAcc(PROCEDURE 72).PurchSetup(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckWMS(PROCEDURE 76).DialogText(Variable 1001)".


    //Unsupported feature: Property Deletion (PasteIsValid).


    var
        TempPurchLine: Record "39" temporary;

    var
        TempPurchLine: Record "39" temporary;
        StandardText: Record "7";
        FixedAsset: Record "5600";

    var
        TypeHelper: Codeunit "10";

    var
        RecLSalesLine: Record "37";

    var
        IndirectCostPercent: Decimal;

    var
        FixedAsset: Record "5600";

    var
        PurchasingCode: Record "5721";

    var
        SalesOrderLine: Record "37";
        RecLSalesLine: Record "37";

    var
        "---DEEE1.00---": Integer;
        RecLItem: Record "27";


    //Unsupported feature: Property Modification (TextConstString) on "Text046(Variable 1091)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text046 : ENU=Microsoft Dynamics NAV will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?;FRA=Microsoft Dynamics NAV ne mettra pas à jour %1 si vous modifiez %2 car une facture d'acompte a été validée. Êtes-vous certain de vouloir continuer ?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text046 : @@@=%1 - product name;ENU=%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?;FRA=%3 ne mettra pas à jour %1 si vous modifiez %2 car une facture d'acompte a été validée. Êtes-vous certain de vouloir continuer ?;
        //Variable type has not been exported.

    var
        TempJobJnlLine: Record "210" temporary;
        PurchSetup: Record "312";
        ApplicationAreaSetup: Record "9178";

    var
        DeferralUtilities: Codeunit "1720";

    var
        AnotherItemWithSameDescrQst: Label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment='%1=Item no., %2=item description';
        PurchSetupRead: Boolean;
        ItemNoFieldCaptionTxt: Label 'Item';
        CannotBeNegativeErr: Label 'The %1 field cannot be negative on the purchase line.', Comment='%1 - Field Caption';
        "--COR001--": ;
        TextDate: Label '0D';
        textg002: Label 'You will lost link between purchase document No %1 line %2 \ and sale document of type %3, No %4 ,  line %5 \ Are you sure?';
        "-NSC1.01-": Integer;
        RecGSalesLine: Record "37";
        Tectg003: Label 'Do you want to create a Purchase Price ? ';
        RecGPurchPrice: Record "7012";
        TextG001: Label 'There is nothing to affect';
        RecGPurchsetup: Record "312";
        RecGVendor: Record "23";
}

