tableextension 50084 tableextension50084 extends "Item Journal Line"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="INTRASTAT"  request="FR-START-40"
    //     releaseversion="FR4.00">Intrastat (France)</add>
    // </changelog>
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80002..80007
    //           - Item No. - OnValidate()
    //           - Quantity - OnValidate()
    //           - Add function CalculateDEEE
    // 
    // //>> CNE4.01
    // A:FE14 01.09.2011 : Inventory Control - Refresh Phys. Quantity
    //                   - Add Field 50049 Qty. Refreshed (Phys. Inv.)
    // 
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    //                   - Add Field 50046 Whse. Document Type
    //                   - Add Field 50047 Whse. Document No.
    //                   - Add Field 50048 Whse. Document Line No.
    //                   - Field 5403 Bin Code : Change Condition Table Field Filter For Transfer
    // 
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013 - 2017
    // //<<DEEE1.00 : Post
    // // Ajout des champs des tables 36/37 vers la table 83
    LookupPageID = 519;
    DrillDownPageID = 519;
    fields
    {
        modify("Source No.")
        {
            TableRelation = IF (Source Type=CONST(Customer)) Customer
                            ELSE IF (Source Type=CONST(Vendor)) Vendor
                            ELSE IF (Source Type=CONST(Item)) Item;
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Source Posting Group")
        {
            TableRelation = IF (Source Type=CONST(Customer)) "Customer Posting Group"
                            ELSE IF (Source Type=CONST(Vendor)) "Vendor Posting Group"
                            ELSE IF (Source Type=CONST(Item)) "Inventory Posting Group";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 46)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 68)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Quantity"(Field 68)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Source Currency Code"(Field 73)".

        modify("Order Line No.")
        {
            TableRelation = IF (Order Type=CONST(Production)) "Prod. Order Line"."Line No." WHERE (Status=CONST(Released),
                                                                                                   Prod. Order No.=FIELD(Order No.));
        }
        modify("Bin Code")
        {
            TableRelation = IF (Entry Type=FILTER(Purchase|Positive Adjmt.|Output),
                                Quantity=FILTER(>=0)) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                      Item Filter=FIELD(Item No.),
                                                                      Variant Filter=FIELD(Variant Code))
                                                                      ELSE IF (Entry Type=FILTER(Purchase|Positive Adjmt.|Output),
                                                                               Quantity=FILTER(<0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                    Item No.=FIELD(Item No.),
                                                                                                                                    Variant Code=FIELD(Variant Code))
                                                                                                                                    ELSE IF (Entry Type=FILTER(Sale|Negative Adjmt.|Consumption),
                                                                                                                                             Quantity=FILTER(>0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                                                  Item No.=FIELD(Item No.),
                                                                                                                                                                                                  Variant Code=FIELD(Variant Code))
                                                                                                                                                                                                  ELSE IF (Entry Type=FILTER(Sale|Negative Adjmt.|Transfer|Consumption),
                                                                                                                                                                                                           Quantity=FILTER(<=0)) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                                                                                                 Item Filter=FIELD(Item No.),
                                                                                                                                                                                                                                                 Variant Filter=FIELD(Variant Code))
                                                                                                                                                                                                                                                 ELSE IF (Entry Type=FILTER(Transfer),
                                                                                                                                                                                                                                                          Quantity=FILTER(>0)) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                                                                                                                                               Item Filter=FIELD(Item No.),
                                                                                                                                                                                                                                                                                               Variant Filter=FIELD(Variant Code));
        }
        modify("New Bin Code")
        {
            TableRelation = Bin.Code WHERE (Location Code=FIELD(New Location Code),
                                            Item Filter=FIELD(Item No.),
                                            Variant Filter=FIELD(Variant Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. (Base)"(Field 5468)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. (Base)"(Field 5468)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered No."(Field 5701)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Originally Ordered Var. Code"(Field 5702)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5704)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Purchasing Code"(Field 5706)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5707)".

        modify("Invoice-to Source No.")
        {
            TableRelation = IF (Source Type=CONST(Customer)) Customer
                            ELSE IF (Source Type=CONST(Vendor)) Vendor;
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on "Type(Field 5830)".

        modify("No.")
        {
            TableRelation = IF (Type=CONST(Machine Center)) "Machine Center"
                            ELSE IF (Type=CONST(Work Center)) "Work Center"
                            ELSE IF (Type=CONST(Resource)) Resource;
        }
        modify("Operation No.")
        {
            TableRelation = IF (Order Type=CONST(Production)) "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
                                                                                                                Prod. Order No.=FIELD(Order No.),
                                                                                                                Routing No.=FIELD(Routing No.),
                                                                                                                Routing Reference No.=FIELD(Routing Reference No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Setup Time"(Field 5841)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Run Time"(Field 5842)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Stop Time"(Field 5843)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Output Quantity"(Field 5846)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Scrap Quantity"(Field 5847)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Concurrent Capacity"(Field 5849)".

        modify("Cap. Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Resource)) "Resource Unit of Measure".Code WHERE (Resource No.=FIELD(No.))
                            ELSE "Capacity Unit of Measure";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Starting Time"(Field 5873)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Ending Time"(Field 5874)".

        modify("Prod. Order Comp. Line No.")
        {
            TableRelation = IF (Order Type=CONST(Production)) "Prod. Order Component"."Line No." WHERE (Status=CONST(Released),
                                                                                                        Prod. Order No.=FIELD(Order No.),
                                                                                                        Prod. Order Line No.=FIELD(Order Line No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on "Finished(Field 5885)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Item No."(Field 3).OnValidate".

        //trigger (Variable: ProdOrderLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Item No." <> xRec."Item No." THEN BEGIN
              "Variant Code" := '';
              "Bin Code" := '';
            #4..25
            GetItem;
            Item.TESTFIELD(Blocked,FALSE);
            Item.TESTFIELD(Type,Item.Type::Inventory);
            Description := Item.Description;
            "Inventory Posting Group" := Item."Inventory Posting Group";
            "Item Category Code" := Item."Item Category Code";
            "Product Group Code" := Item."Product Group Code";

            IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
               ("Item Charge No." <> '')
            THEN BEGIN
            #37..86
              "Entry Type"::Output:
                BEGIN
                  Item.TESTFIELD("Inventory Value Zero",FALSE);
                  SetFilterProdOrderLine;
                  ProdOrderLine.SETRANGE("Item No.","Item No.");
                  IF ProdOrderLine.FINDFIRST THEN BEGIN
                    "Routing No." := ProdOrderLine."Routing No.";
            #94..99
                      ERROR(Text031,"Item No.","Order No.");
                  IF ProdOrderLine.COUNT = 1 THEN BEGIN
                    VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                    "Routing Reference No." := ProdOrderLine."Routing Reference No.";
                    "Unit of Measure Code" := ProdOrderLine."Unit of Measure Code";
                    "Location Code" := ProdOrderLine."Location Code";
                    VALIDATE("Variant Code",ProdOrderLine."Variant Code");
            #107..109
                END;
              "Entry Type"::Consumption:
                BEGIN
                  SetFilterProdOrderComp;
                  ProdOrderComp.SETRANGE("Item No.","Item No.");
                  IF ProdOrderComp.COUNT = 1 THEN BEGIN
                    ProdOrderComp.FINDFIRST;
            #117..144
                DATABASE::"Work Center","Work Center No.");

            ReserveItemJnlLine.VerifyChange(Rec,xRec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..28
            IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
              Item.TESTFIELD("Inventory Value Zero",FALSE);
            #29..33
            //>>MIGRATION NAV 2013
            //>>DEEE1.00
            "DEEE Category Code":=Item."DEEE Category Code" ;
            "Eco partner DEEE":=Item."Eco partner DEEE" ;
            CalculateDEEE('') ;
            //<<DEEE1.00
            //<<MIGRATION ANV 2013

            #34..89
                  ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
            #91..102
            #104..112
                  ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
            #114..147
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
               ("Item Charge No." = '') AND
               ("No." = '')
            #4..28
            VALIDATE("Unit of Measure Code");

            ReserveItemJnlLine.VerifyChange(Rec,xRec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Entry Type" <= "Entry Type"::Transfer THEN
              TESTFIELD("Item No.");

            #1..31
            */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PhysInvtEntered THEN
              TESTFIELD("Phys. Inventory",FALSE);

            #4..37

            IF Item."Item Tracking Code" <> '' THEN
              ReserveItemJnlLine.VerifyQuantity(Rec,xRec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Entry Type" <= "Entry Type"::Transfer) AND (Quantity <> 0) THEN
              TESTFIELD("Item No.");

            #1..40

            //>>MIGRATION NAV 2013
            //>>DEEE1.00
            CalculateDEEE('') ;
            //<<DEEE1.00
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit Amount"(Field 16).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdateAmount;
            IF "Item No." <> '' THEN BEGIN
              IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
            #4..10
                      IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
                        GetItem;
                        IF (CurrFieldNo = FIELDNO("Unit Amount")) AND
                           (Item."Costing Method" = Item."Costing Method"::Standard)
                        THEN
                          ERROR(
                            Text002,
            #18..36
                    BEGIN
                      GetItem;
                      IF (CurrFieldNo = FIELDNO("Unit Amount")) AND
                         (Item."Costing Method" = Item."Costing Method"::Standard)
                      THEN
                        ERROR(
                          Text002,
            #44..49
                    END;
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..13
                           (Item."Costing Method" = Item."Costing Method"::Average)
            #15..39
                         (Item."Costing Method" = Item."Costing Method"::Average)
            #41..52
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost"(Field 17).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Item No.");
            RetrieveCosts;
            IF "Entry Type" IN ["Entry Type"::Purchase,"Entry Type"::"Positive Adjmt.","Entry Type"::Consumption] THEN BEGIN
              IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
                IF CurrFieldNo = FIELDNO("Unit Cost") THEN
                  ERROR(
                    Text002,
            #8..29
                "Entry Type"::Consumption,
                "Entry Type"::"Assembly Consumption":
                  BEGIN
                    IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                      ERROR(
                        Text002,
                        FIELDCAPTION("Unit Cost"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
                    "Unit Amount" := "Unit Cost";
                  END;
              END;
              UpdateAmount;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
            #5..32
                    IF Item."Costing Method" = Item."Costing Method"::Average THEN
            #34..41
            */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Entry"(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Applies-to Entry" <> 0 THEN BEGIN
              ItemLedgEntry.GET("Applies-to Entry");

              IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN BEGIN
                IF "Inventory Value Per" <> "Inventory Value Per"::" " THEN
                  ERROR(Text006,FIELDCAPTION("Applies-to Entry"));

                IF "Inventory Value Per" = "Inventory Value Per"::" " THEN BEGIN
                  GetItem;
                  IF Item."Costing Method" = Item."Costing Method"::Average THEN
                    ERROR(Text034);
                END;

                InitRevalJnlLine(ItemLedgEntry);
                ItemLedgEntry.TESTFIELD(Positive,TRUE);
            #16..20
                  IF Quantity < 0 THEN
                    FIELDERROR(Quantity,Text029);
                END;
                IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                  ERROR(Text033,FIELDCAPTION("Applies-to Entry"),ItemTrackingLines.CAPTION);

                IF NOT ItemLedgEntry.Open THEN
            #28..47
                "Bin Code" := '';
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
                IF "Inventory Value Per" = "Inventory Value Per"::" " THEN
                  IF NOT RevaluationPerEntryAllowed("Item No.") THEN
                    ERROR(Text034);
            #13..23
                IF ItemLedgEntry.TrackingExists THEN
            #25..50
            */
        //end;


        //Unsupported feature: Code Modification on ""Indirect Cost %"(Field 37).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Item No.");
            TESTFIELD("Value Entry Type","Value Entry Type"::"Direct Cost");
            TESTFIELD("Item Charge No.",'');
            #4..6
                FIELDCAPTION("Indirect Cost %"),FIELDCAPTION("Entry Type"),"Entry Type");

            GetItem;
            IF Item."Costing Method" = Item."Costing Method"::Standard THEN
              ERROR(
                Text002,
                FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
            #14..16
                ROUND(
                  "Unit Amount" * (1 + "Indirect Cost %" / 100) +
                  "Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            IF Item."Costing Method" = Item."Costing Method"::Average THEN
            #11..19
            */
        //end;


        //Unsupported feature: Code Modification on ""Qty. (Phys. Inventory)"(Field 54).OnValidate".

        //trigger  (Phys()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Phys. Inventory",TRUE);

            IF CurrFieldNo <> 0 THEN
            #4..12
              VALIDATE(Quantity,"Qty. (Calculated)" - "Qty. (Phys. Inventory)");
            END;
            PhysInvtEntered := FALSE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..15

            //>>MIGRATION NAV 2013
            "Qty. Refreshed (Phys. Inv.)" := FALSE;
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Order No."(Field 91).OnValidate".

        //trigger "(Field 91)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CASE "Order Type" OF
              "Order Type"::Production,"Order Type"::Assembly:
                BEGIN
            #4..41
                      END;
                    "Entry Type" = "Entry Type"::Consumption:
                      BEGIN
                        SetFilterProdOrderLine;
                        ProdOrderLine.FINDFIRST;
                        IF ProdOrderLine.COUNT = 1 THEN
                          VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                      END;
                  END;

            #52..59
              "Order Type"::Transfer,"Order Type"::Service,"Order Type"::" ":
                ERROR(Text002,FIELDCAPTION("Order No."),FIELDCAPTION("Order Type"),"Order Type");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..44
                        ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                        IF ProdOrderLine.COUNT = 1 THEN BEGIN
                          ProdOrderLine.FINDFIRST;
                          VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                        END;
            #49..62
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Order Line No."(Field 92).OnValidate".

        //trigger (Variable: ProdOrderLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Order Line No."(Field 92).OnValidate".

        //trigger "(Field 92)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Order No.");
            CASE "Order Type" OF
              "Order Type"::Production,"Order Type"::Assembly:
                BEGIN
                  IF "Order Type" = "Order Type"::Production THEN BEGIN
                    SetFilterProdOrderLine;
                    ProdOrderLine.SETRANGE("Line No.","Order Line No.");
                    IF ProdOrderLine.FINDFIRST THEN BEGIN
                      "Source Type" := "Source Type"::Item;
                      "Source No." := ProdOrderLine."Item No.";
                      "Order Line No." := ProdOrderLine."Line No.";
                    END;
                  END;

            #15..20
                    END;
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
                    ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
            #7..11
                      "Routing No." := ProdOrderLine."Routing No.";
                      "Routing Reference No." := ProdOrderLine."Routing Reference No.";
                      IF "Entry Type" = "Entry Type"::Output THEN BEGIN
                        "Location Code" := ProdOrderLine."Location Code";
                        "Bin Code" := ProdOrderLine."Bin Code";
                      END;
            #12..23
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


        //Unsupported feature: Code Insertion (VariableCollection) on ""Bin Code"(Field 5403).OnValidate".

        //trigger (Variable: ProdOrderComp)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
              TESTFIELD("Location Code");
              IF "Bin Code" <> '' THEN BEGIN
            #4..20
              THEN BEGIN
                TESTFIELD("Order Type","Order Type"::Production);
                TESTFIELD("Order No.");
                ProdOrderComp.GET(ProdOrder.Status::Released,"Order No.","Order Line No.","Prod. Order Comp. Line No.");
                IF (ProdOrderComp."Bin Code" <> '') AND (ProdOrderComp."Bin Code" <> "Bin Code") THEN
                  IF NOT CONFIRM(
                       Text021,
                       FALSE,
                       "Bin Code",
                       ProdOrderComp."Bin Code",
                       "Order No.")
                  THEN
                    ERROR(Text012);
              END;
            END;

            ReserveItemJnlLine.VerifyChange(Rec,xRec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..23
                ProdOrderComp.GET(ProdOrderComp.Status::Released,"Order No.","Order Line No.","Prod. Order Comp. Line No.");
            #25..32
                    ERROR(UpdateInterruptedErr);
            #34..37
            */
        //end;


        //Unsupported feature: Code Modification on ""Applies-from Entry"(Field 5807).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Applies-from Entry" <> 0 THEN BEGIN
              TESTFIELD(Quantity);
              IF Signed(Quantity) < 0 THEN BEGIN
            #4..7
              END;
              ItemLedgEntry.GET("Applies-from Entry");
              ItemLedgEntry.TESTFIELD(Positive,FALSE);
              IF (ItemLedgEntry."Lot No." <> '') OR (ItemLedgEntry."Serial No." <> '') THEN
                ERROR(Text033,FIELDCAPTION("Applies-from Entry"),ItemTrackingLines.CAPTION);
              "Unit Cost" := CalcUnitCost(ItemLedgEntry);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
              IF ItemLedgEntry.TrackingExists THEN
            #12..14
            */
        //end;


        //Unsupported feature: Code Modification on ""Update Standard Cost"(Field 5812).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Inventory Value Per");
            GetItem;
            Item.TESTFIELD("Costing Method",Item."Costing Method"::Standard);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD("Inventory Value Per");
            GetItem;
            Item.TESTFIELD("Costing Method",Item."Costing Method"::Average);
            */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 5831).OnValidate".

        //trigger "(Field 5831)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF Type = Type::Resource THEN
              TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
            ELSE
              TESTFIELD("Entry Type","Entry Type"::Output);
            IF "No." = '' THEN BEGIN
              "Work Center No." := '';
              VALIDATE("Item No.");
              CreateDim(
                DATABASE::"Work Center","Work Center No.",
                DATABASE::Item,"Item No.",
                DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code");
              EXIT;
            END;

            #15..45
            END;

            IF "Work Center No." <> '' THEN
              CreateDim(
                DATABASE::"Work Center","Work Center No.",
                DATABASE::Item,"Item No.",
                DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
              IF Type IN [Type::"Work Center",Type::"Machine Center"] THEN
                CreateDimWithProdOrderLine
              ELSE
                CreateDim(
                  DATABASE::"Work Center","Work Center No.",
                  DATABASE::Item,"Item No.",
                  DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code");
            #12..48
              CreateDimWithProdOrderLine;
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Operation No."(Field 5838).OnValidate".

        //trigger (Variable: ProdOrderRtngLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Operation No."(Field 5838).OnValidate".

        //trigger "(Field 5838)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Entry Type","Entry Type"::Output);
            IF "Operation No." = '' THEN
              EXIT;

            TESTFIELD("Order Type","Order Type"::Production);
            TESTFIELD("Order No.");
            TESTFIELD("Item No.");

            GetProdOrderRtngLine;

            CASE ProdOrderRtngLine.Type OF
              ProdOrderRtngLine.Type::"Work Center":
            #13..15
            END;
            VALIDATE("No.",ProdOrderRtngLine."No.");
            Description := ProdOrderRtngLine.Description;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
            ConfirmOutputOnFinishedOperation;
            GetProdOrderRtngLine(ProdOrderRtngLine);
            #10..18
            */
        //end;


        //Unsupported feature: Code Modification on ""Setup Time"(Field 5841).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            "Setup Time (Base)" := CalcBaseTime("Setup Time");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF SubcontractingWorkCenterUsed AND ("Setup Time" <> 0) THEN
              ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Setup Time"),"Line No."));
            "Setup Time (Base)" := CalcBaseTime("Setup Time");
            */
        //end;


        //Unsupported feature: Code Modification on ""Run Time"(Field 5842).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            "Run Time (Base)" := CalcBaseTime("Run Time");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF SubcontractingWorkCenterUsed AND ("Run Time" <> 0) THEN
              ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Run Time"),"Line No."));

            "Run Time (Base)" := CalcBaseTime("Run Time");
            */
        //end;


        //Unsupported feature: Code Modification on ""Output Quantity"(Field 5846).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Entry Type","Entry Type"::Output);
            IF LastOutputOperation(Rec) THEN
              WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

            "Output Quantity (Base)" := CalcBaseQty("Output Quantity");

            VALIDATE(Quantity,"Output Quantity");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD("Entry Type","Entry Type"::Output);
            IF SubcontractingWorkCenterUsed AND ("Output Quantity" <> 0) THEN
              ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Output Quantity"),"Line No."));

            ConfirmOutputOnFinishedOperation;

            #2..7
            */
        //end;


        //Unsupported feature: Code Modification on ""Concurrent Capacity"(Field 5849).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Entry Type","Entry Type"::Output);
            IF "Concurrent Capacity" = 0 THEN
              EXIT;

            TESTFIELD("Starting Time");
            TESTFIELD("Ending Time");
            TotalTime := "Ending Time" - "Starting Time";
            IF "Ending Time" < "Starting Time" THEN
              TotalTime := TotalTime + 86400000;
            TESTFIELD("Work Center No.");
            #11..14
              ROUND(
                TotalTime / CalendarMgt.TimeFactor("Cap. Unit of Measure Code") *
                "Concurrent Capacity",WorkCenter."Calendar Rounding Precision"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
            TotalTime := CalendarMgt.CalcTimeDelta("Ending Time","Starting Time");
            #8..17
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Cap. Unit of Measure Code"(Field 5858).OnValidate".

        //trigger (Variable: ProdOrderRtngLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Cap. Unit of Measure Code"(Field 5858).OnValidate".

        //trigger  Unit of Measure Code"(Field 5858)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF Type <> Type::Resource THEN BEGIN
              "Qty. per Cap. Unit of Measure" :=
                ROUND(
            #4..13
              CASE "Order Type" OF
                "Order Type"::Production:
                  BEGIN
                    GetProdOrderRtngLine;
                    "Unit Cost" := ProdOrderRtngLine."Unit Cost per";

                    CostCalcMgt.RoutingCostPerUnit(
            #21..29
            "Unit Amount" :=
              ROUND("Unit Amount" * "Qty. per Cap. Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
            VALIDATE("Unit Amount");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..16
                    GetProdOrderRtngLine(ProdOrderRtngLine);
            #18..32
            */
        //end;
        field(50046;"Whse. Document Type";Option)
        {
            Caption = 'Whse. Document Type';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ' ,Invt. Pick';
            OptionMembers = " ","Invt. Pick";
        }
        field(50047;"Whse. Document No.";Code[20])
        {
            Caption = 'Whse. Document No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF (Whse. Document Type=CONST(Invt. Pick)) "Warehouse Activity Header".No. WHERE (Type=CONST(Invt. Pick));
        }
        field(50048;"Whse. Document Line No.";Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50060;"Qty. Refreshed (Phys. Inv.)";Boolean)
        {
            Caption = 'Qty. (Phys. Inventory)';
            Description = 'CNE4.01';
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD("Phys. Inventory",TRUE);
            end;
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
            Editable = false;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;
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

        //Unsupported feature: Property Modification (SumIndexFields) on ""Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date"(Key)".

        key(Key1;"Item No.","Variant Code","Location Code","Bin Code","Posting Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key2;"Phys. Inventory","Item No.","Journal Template Name","Journal Batch Name","Line No.")
        {
        }
    }

    //Unsupported feature: Property Insertion (Local) on "UpdateAmount(PROCEDURE 23)".


    //Unsupported feature: Variable Insertion (Variable: UnitCostValue) (VariableCollection) on "GetUnitAmount(PROCEDURE 6)".


    //Unsupported feature: Property Insertion (Local) on "GetUnitAmount(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "GetUnitAmount(PROCEDURE 6)".

    //procedure GetUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RetrieveCosts;
        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN
          EXIT;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            PurchPriceCalcMgt.FindItemJnlLinePrice(Rec,CalledByFieldNo);
          "Entry Type"::Sale:
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,CalledByFieldNo);
          "Entry Type"::"Positive Adjmt.":
            "Unit Amount" :=
              ROUND(
                ((UnitCost - "Overhead Rate") * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
                GLSetup."Unit-Amount Rounding Precision");
          "Entry Type"::"Negative Adjmt.":
            "Unit Amount" := UnitCost * "Qty. per Unit of Measure";
          "Entry Type"::Transfer:
            "Unit Amount" := 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        UnitCostValue := UnitCost;
        IF (CalledByFieldNo = FIELDNO(Quantity)) AND
           (Item."No." <> '') AND (Item."Costing Method" <> Item."Costing Method"::Standard)
        THEN
          UnitCostValue := "Unit Cost" / UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

        #7..14
                ((UnitCostValue - "Overhead Rate") * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
                GLSetup."Unit-Amount Rounding Precision");
          "Entry Type"::"Negative Adjmt.":
            "Unit Amount" := UnitCostValue * "Qty. per Unit of Measure";
        #19..21
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: SalesLine) (ParameterCollection) on "CopyFromSalesLine(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Name) on "ShowReservation(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "ShowReservation(PROCEDURE 12)".

    //procedure ShowReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(Reservation);
        Reservation.SetItemJnlLine(Rec);
        Reservation.RUNMODAL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Item No." := SalesLine."No.";
        Description := SalesLine.Description;
        "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SalesLine."Dimension Set ID";
        "Location Code" := SalesLine."Location Code";
        "Bin Code" := SalesLine."Bin Code";
        "Variant Code" := SalesLine."Variant Code";
        "Inventory Posting Group" := SalesLine."Posting Group";
        "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        "Transaction Type" := SalesLine."Transaction Type";
        "Transport Method" := SalesLine."Transport Method";
        "Entry/Exit Point" := SalesLine."Exit Point";
        Area := SalesLine.Area;
        "Transaction Specification" := SalesLine."Transaction Specification";
        "Drop Shipment" := SalesLine."Drop Shipment";
        "Entry Type" := "Entry Type"::Sale;
        "Unit of Measure Code" := SalesLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := SalesLine."Blanket Order No." <> '';
        "Cross-Reference No." := SalesLine."Cross-Reference No.";
        "Originally Ordered No." := SalesLine."Originally Ordered No.";
        "Originally Ordered Var. Code" := SalesLine."Originally Ordered Var. Code";
        "Out-of-Stock Substitution" := SalesLine."Out-of-Stock Substitution";
        "Item Category Code" := SalesLine."Item Category Code";
        Nonstock := SalesLine.Nonstock;
        "Purchasing Code" := SalesLine."Purchasing Code";
        "Product Group Code" := SalesLine."Product Group Code";
        "Return Reason Code" := SalesLine."Return Reason Code";
        "Planned Delivery Date" := SalesLine."Planned Delivery Date";
        "Document Line No." := SalesLine."Line No.";
        "Unit Cost" := SalesLine."Unit Cost (LCY)";
        "Unit Cost (ACY)" := SalesLine."Unit Cost";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Source Type" := "Source Type"::Customer;
        "Source No." := SalesLine."Sell-to Customer No.";
        "Invoice-to Source No." := SalesLine."Bill-to Customer No.";
        //>>MIGRATION NAV 2013 - 2017
        //<<DEEE1.00 : Post
        // Ajout des champs des tables 36/37 vers la table 83
        "DEEE Category Code" := SalesLine."DEEE Category Code";
        "DEEE Unit Price" := SalesLine."DEEE Unit Price";
        "DEEE HT Amount" := SalesLine."DEEE HT Amount";
        "DEEE VAT Amount" := SalesLine."DEEE VAT Amount";
        "DEEE TTC Amount" := SalesLine."DEEE TTC Amount";
        "Eco partner DEEE":=SalesLine."Eco partner DEEE" ;
        "DEEE HT Amount (LCY)":=SalesLine."DEEE HT Amount (LCY)" ;
        "DEEE Unit Price (LCY)":=SalesLine."DEEE Unit Price (LCY)" ;
        "DEEE Amount (LCY) for Stat":=SalesLine."DEEE Amount (LCY) for Stat" ;
        //>>DEEE1.00 : Post
        //<<MIGRATION NAV 2013
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "BlockDynamicTracking(PROCEDURE 17)".



    //Unsupported feature: Code Modification on "BlockDynamicTracking(PROCEDURE 17)".

    //procedure BlockDynamicTracking();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReserveItemJnlLine.Block(SetBlock);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Item No." := ServiceLine."No.";
        "Posting Date" := ServiceLine."Posting Date";
        Description := ServiceLine.Description;
        "Shortcut Dimension 1 Code" := ServiceLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServiceLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServiceLine."Dimension Set ID";
        "Location Code" := ServiceLine."Location Code";
        "Bin Code" := ServiceLine."Bin Code";
        "Variant Code" := ServiceLine."Variant Code";
        "Inventory Posting Group" := ServiceLine."Posting Group";
        "Gen. Bus. Posting Group" := ServiceLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServiceLine."Gen. Prod. Posting Group";
        "Applies-to Entry" := ServiceLine."Appl.-to Item Entry";
        "Transaction Type" := ServiceLine."Transaction Type";
        "Transport Method" := ServiceLine."Transport Method";
        "Entry/Exit Point" := ServiceLine."Exit Point";
        Area := ServiceLine.Area;
        "Transaction Specification" := ServiceLine."Transaction Specification";
        "Entry Type" := "Entry Type"::Sale;
        "Unit of Measure Code" := ServiceLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServiceLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := FALSE;
        "Item Category Code" := ServiceLine."Item Category Code";
        Nonstock := ServiceLine.Nonstock;
        "Product Group Code" := ServiceLine."Product Group Code";
        "Return Reason Code" := ServiceLine."Return Reason Code";
        "Order Type" := "Order Type"::Service;
        "Order No." := ServiceLine."Document No.";
        "Order Line No." := ServiceLine."Line No.";
        "Job No." := ServiceLine."Job No.";
        "Job Task No." := ServiceLine."Job Task No.";
        */
    //end;


    //Unsupported feature: Code Modification on "CreateDim(PROCEDURE 13)".

    //procedure CreateDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID,No,"Source Code",
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);

        IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
          "New Dimension Set ID" := "Dimension Set ID";
          "New Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
          "New Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CreateTableList(TableID,Type1,Type2,Type3);
        CreateCodeList(No,No1,No2,No3);
        PickDimension(TableID,No,0,0);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: StockkeepingUnit) (VariableCollection) on "RetrieveCosts(PROCEDURE 5803)".



    //Unsupported feature: Code Modification on "RetrieveCosts(PROCEDURE 5803)".

    //procedure RetrieveCosts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        THEN
          EXIT;

        ReadGLSetup;
        GetItem;
        IF GetSKU THEN
          UnitCost := SKU."Unit Cost"
        ELSE
          UnitCost := Item."Unit Cost";

        IF "Entry Type" = "Entry Type"::Transfer THEN
          UnitCost := 0
        ELSE
          IF Item."Costing Method" <> Item."Costing Method"::Standard THEN
            UnitCost := ROUND(UnitCost,GLSetup."Unit-Amount Rounding Precision");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        IF StockkeepingUnit.GET("Location Code","Item No.","Variant Code") THEN
          UnitCost := StockkeepingUnit."Unit Cost"
        #10..15
          IF Item."Costing Method" <> Item."Costing Method"::Average THEN
            UnitCost := ROUND(UnitCost,GLSetup."Unit-Amount Rounding Precision");
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetMfgSetup(PROCEDURE 7)".


    //Unsupported feature: Parameter Insertion (Parameter: ProdOrderRtngLine) (ParameterCollection) on "GetProdOrderRtngLine(PROCEDURE 27)".



    //Unsupported feature: Code Modification on "GetProdOrderRtngLine(PROCEDURE 27)".

    //procedure GetProdOrderRtngLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Order Type","Order Type"::Production);
        TESTFIELD("Order No.");
        TESTFIELD("Operation No.");
        IF ("Order No." <> ProdOrderRtngLine."Prod. Order No.") OR
           ("Routing Reference No." <> ProdOrderRtngLine."Routing Reference No.") OR
           ("Routing No." <> ProdOrderRtngLine."Routing No.") OR
           ("Operation No." <> ProdOrderRtngLine."Operation No.")
        THEN
          ProdOrderRtngLine.GET(
            ProdOrderRtngLine.Status::Released,
            "Order No.","Routing Reference No.","Routing No.","Operation No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3

        ProdOrderRtngLine.GET(
          ProdOrderRtngLine.Status::Released,
          "Order No.","Routing Reference No.","Routing No.","Operation No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ProdOrderComp) (VariableCollection) on "LookupProdOrderComp(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: ProdOrderCompLineList) (VariableCollection) on "LookupProdOrderComp(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Name) on "SetFilterProdOrderLine(PROCEDURE 11)".


    //Unsupported feature: Property Insertion (Local) on "SetFilterProdOrderLine(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "SetFilterProdOrderLine(PROCEDURE 11)".

    //procedure SetFilterProdOrderLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ProdOrderLine.RESET;
        ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Item No.");
        ProdOrderLine.SETRANGE(Status,ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.","Order No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
        IF "Order Line No." <> 0 THEN
          ProdOrderComp.SETRANGE("Prod. Order Line No.","Order Line No.");
        ProdOrderComp.Status := ProdOrderComp.Status::Released;
        ProdOrderComp."Prod. Order No." := "Order No.";
        ProdOrderComp."Prod. Order Line No." := "Order Line No.";
        ProdOrderComp."Line No." := "Prod. Order Comp. Line No.";
        ProdOrderComp."Item No." := "Item No.";

        ProdOrderCompLineList.LOOKUPMODE(TRUE);
        ProdOrderCompLineList.SETTABLEVIEW(ProdOrderComp);
        ProdOrderCompLineList.SETRECORD(ProdOrderComp);

        IF ProdOrderCompLineList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ProdOrderCompLineList.GETRECORD(ProdOrderComp);
          IF "Prod. Order Comp. Line No." <> ProdOrderComp."Line No." THEN BEGIN
            VALIDATE("Item No.",ProdOrderComp."Item No.");
            VALIDATE("Prod. Order Comp. Line No.",ProdOrderComp."Line No.");
          END;
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ProdOrderLine) (VariableCollection) on "LookupProdOrderLine(PROCEDURE 32)".


    //Unsupported feature: Variable Insertion (Variable: ProdOrderLineList) (VariableCollection) on "LookupProdOrderLine(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Name) on "SetFilterProdOrderComp(PROCEDURE 32)".


    //Unsupported feature: Property Insertion (Local) on "SetFilterProdOrderComp(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "SetFilterProdOrderComp(PROCEDURE 32)".

    //procedure SetFilterProdOrderComp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ProdOrderComp.RESET;
        ProdOrderComp.SETCURRENTKEY(Status,"Prod. Order No.","Prod. Order Line No.","Item No.","Line No.");
        ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status::Released);
        ProdOrderComp.SETRANGE("Prod. Order No.","Order No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
        ProdOrderLine.Status := ProdOrderLine.Status::Released;
        ProdOrderLine."Prod. Order No." := "Order No.";
        ProdOrderLine."Line No." := "Order Line No.";
        ProdOrderLine."Item No." := "Item No.";

        ProdOrderLineList.LOOKUPMODE(TRUE);
        ProdOrderLineList.SETTABLEVIEW(ProdOrderLine);
        ProdOrderLineList.SETRECORD(ProdOrderLine);

        IF ProdOrderLineList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ProdOrderLineList.GETRECORD(ProdOrderLine);
          VALIDATE("Item No.",ProdOrderLine."Item No.");
          IF "Order Line No." <> ProdOrderLine."Line No." THEN
            VALIDATE("Order Line No.",ProdOrderLine."Line No.");
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckPlanningAssignment(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "LookupItemNo(PROCEDURE 37)".

    //procedure LookupItemNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Entry Type" = "Entry Type"::Output THEN BEGIN
          SetFilterProdOrderLine;
          ProdOrderLine2.Status := ProdOrderLine2.Status::Released;
          ProdOrderLine2."Prod. Order No." := "Order No.";
          ProdOrderLine2."Line No." := "Order Line No.";
          ProdOrderLine2."Item No." := "Item No.";

          ProdOrderLineList.LOOKUPMODE(TRUE);
          ProdOrderLineList.SETTABLEVIEW(ProdOrderLine);
          ProdOrderLineList.SETRECORD(ProdOrderLine2);

          IF ProdOrderLineList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ProdOrderLineList.GETRECORD(ProdOrderLine);
            VALIDATE("Item No.",ProdOrderLine."Item No.");
          END;
        END ELSE BEGIN
          ItemList.LOOKUPMODE := TRUE;
          IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ItemList.GETRECORD(Item);
            VALIDATE("Item No.",Item."No.");
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE "Entry Type" OF
          "Entry Type"::Consumption:
            LookupProdOrderComp;
          "Entry Type"::Output:
            LookupProdOrderLine;
          ELSE BEGIN
            ItemList.LOOKUPMODE := TRUE;
            IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
              ItemList.GETRECORD(Item);
              VALIDATE("Item No.",Item."No.");
            END;
          END;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "RecalculateUnitAmount(PROCEDURE 38)".

    //procedure RecalculateUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetItem;

        IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
        #4..36
        END;

        IF "Entry Type" IN ["Entry Type"::Purchase,"Entry Type"::"Positive Adjmt."] THEN BEGIN
          IF Item."Costing Method" = Item."Costing Method"::Standard THEN
            "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..39
          IF Item."Costing Method" = Item."Costing Method"::Average THEN
            "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        END;
        */
    //end;

    procedure SetDocNos(DocType: Option;DocNo: Code[20];ExtDocNo: Text[35];PostingNos: Code[10])
    begin
        "Document Type" := DocType;
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        "Posting No. Series" := PostingNos;
    end;

    local procedure PickDimension(TableList: array [10] of Integer;CodeList: array [10] of Code[20];InheritFromDimSetID: Integer;InheritFromTableNo: Integer)
    var
        ItemJournalTemplate: Record "82";
        SourceCode: Code[10];
    begin
        SourceCode := "Source Code";
        IF SourceCode = '' THEN
          IF ItemJournalTemplate.GET("Journal Template Name") THEN
            SourceCode := ItemJournalTemplate."Source Code";

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableList,CodeList,SourceCode,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",InheritFromDimSetID,InheritFromTableNo);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

        IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
          "New Dimension Set ID" := "Dimension Set ID";
          "New Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
          "New Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        END;
    end;

    local procedure CreateCodeList(var CodeList: array [10] of Code[20];No1: Code[20];No2: Code[20];No3: Code[20])
    begin
        CLEAR(CodeList);
        CodeList[1] := No1;
        CodeList[2] := No2;
        CodeList[3] := No3;
    end;

    local procedure CreateTableList(var TableID: array [10] of Integer;Type1: Integer;Type2: Integer;Type3: Integer)
    begin
        CLEAR(TableID);
        TableID[1] := Type1;
        TableID[2] := Type2;
        TableID[3] := Type3;
    end;

    local procedure CreateDimWithProdOrderLine()
    var
        ProdOrderLine: Record "5406";
        InheritFromDimSetID: Integer;
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        IF "Order Type" = "Order Type"::Production THEN
          IF ProdOrderLine.GET(ProdOrderLine.Status::Released,"Order No.","Order Line No.") THEN
            InheritFromDimSetID := ProdOrderLine."Dimension Set ID";

        CreateTableList(TableID,DATABASE::"Work Center",DATABASE::"Salesperson/Purchaser",0);
        CreateCodeList(No,"Work Center No.","Salespers./Purch. Code",'');
        PickDimension(TableID,No,InheritFromDimSetID,DATABASE::Item);
    end;

    procedure CopyDocumentFields(DocType: Option;DocNo: Code[20];ExtDocNo: Text[35];SourceCode: Code[10];NoSeriesCode: Code[10])
    begin
        "Document Type" := DocType;
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        "Source Code" := SourceCode;
        IF NoSeriesCode <> '' THEN
          "Posting No. Series" := NoSeriesCode;
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "36")
    begin
        "Posting Date" := SalesHeader."Posting Date";
        "Document Date" := SalesHeader."Document Date";
        "Order Date" := SalesHeader."Order Date";
        "Source Posting Group" := SalesHeader."Customer Posting Group";
        "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
        "Reason Code" := SalesHeader."Reason Code";
        "Source Currency Code" := SalesHeader."Currency Code";
    end;

    procedure CopyFromPurchHeader(PurchHeader: Record "38")
    begin
        "Posting Date" := PurchHeader."Posting Date";
        "Document Date" := PurchHeader."Document Date";
        "Source Posting Group" := PurchHeader."Vendor Posting Group";
        "Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        "Country/Region Code" := PurchHeader."Buy-from Country/Region Code";
        "Reason Code" := PurchHeader."Reason Code";
        "Source Currency Code" := PurchHeader."Currency Code";
    end;

    procedure CopyFromPurchLine(PurchLine: Record "39")
    begin
        "Item No." := PurchLine."No.";
        Description := PurchLine.Description;
        "Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := PurchLine."Dimension Set ID";
        "Location Code" := PurchLine."Location Code";
        "Bin Code" := PurchLine."Bin Code";
        "Variant Code" := PurchLine."Variant Code";
        "Item Category Code" := PurchLine."Item Category Code";
        "Product Group Code" := PurchLine."Product Group Code";
        "Inventory Posting Group" := PurchLine."Posting Group";
        "Gen. Bus. Posting Group" := PurchLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := PurchLine."Gen. Prod. Posting Group";
        "Job No." := PurchLine."Job No.";
        "Job Task No." := PurchLine."Job Task No.";
        IF "Job No." <> '' THEN
          "Job Purchase" := TRUE;
        "Applies-to Entry" := PurchLine."Appl.-to Item Entry";
        "Transaction Type" := PurchLine."Transaction Type";
        "Transport Method" := PurchLine."Transport Method";
        "Entry/Exit Point" := PurchLine."Entry Point";
        Area := PurchLine.Area;
        "Transaction Specification" := PurchLine."Transaction Specification";
        "Drop Shipment" := PurchLine."Drop Shipment";
        "Entry Type" := "Entry Type"::Purchase;
        IF PurchLine."Prod. Order No." <> '' THEN BEGIN
          "Order Type" := "Order Type"::Production;
          "Order No." := PurchLine."Prod. Order No.";
          "Order Line No." := PurchLine."Prod. Order Line No.";
        END;
        "Unit of Measure Code" := PurchLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := PurchLine."Qty. per Unit of Measure";
        "Cross-Reference No." := PurchLine."Cross-Reference No.";
        "Document Line No." := PurchLine."Line No.";
        "Unit Cost" := PurchLine."Unit Cost (LCY)";
        "Unit Cost (ACY)" := PurchLine."Unit Cost";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Source Type" := "Source Type"::Vendor;
        "Source No." := PurchLine."Buy-from Vendor No.";
        "Invoice-to Source No." := PurchLine."Pay-to Vendor No.";
        "Purchasing Code" := PurchLine."Purchasing Code";
        "Indirect Cost %" := PurchLine."Indirect Cost %";
        "Overhead Rate" := PurchLine."Overhead Rate";
        "Return Reason Code" := PurchLine."Return Reason Code";
    end;

    procedure CopyFromServHeader(ServiceHeader: Record "5900")
    begin
        "Document Date" := ServiceHeader."Document Date";
        "Order Date" := ServiceHeader."Order Date";
        "Source Posting Group" := ServiceHeader."Customer Posting Group";
        "Salespers./Purch. Code" := ServiceHeader."Salesperson Code";
        "Country/Region Code" := ServiceHeader."VAT Country/Region Code";
        "Reason Code" := ServiceHeader."Reason Code";
        "Source Type" := "Source Type"::Customer;
        "Source No." := ServiceHeader."Customer No.";
    end;

    procedure CopyFromServShptHeader(ServShptHeader: Record "5990")
    begin
        "Document Date" := ServShptHeader."Document Date";
        "Order Date" := ServShptHeader."Order Date";
        "Country/Region Code" := ServShptHeader."VAT Country/Region Code";
        "Source Posting Group" := ServShptHeader."Customer Posting Group";
        "Salespers./Purch. Code" := ServShptHeader."Salesperson Code";
        "Reason Code" := ServShptHeader."Reason Code";
    end;

    procedure CopyFromServShptLine(ServShptLine: Record "5991")
    begin
        "Item No." := ServShptLine."No.";
        Description := ServShptLine.Description;
        "Gen. Bus. Posting Group" := ServShptLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServShptLine."Gen. Prod. Posting Group";
        "Inventory Posting Group" := ServShptLine."Posting Group";
        "Location Code" := ServShptLine."Location Code";
        "Unit of Measure Code" := ServShptLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Variant Code" := ServShptLine."Variant Code";
        "Bin Code" := ServShptLine."Bin Code";
        "Shortcut Dimension 1 Code" := ServShptLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServShptLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServShptLine."Dimension Set ID";
        "Entry/Exit Point" := ServShptLine."Exit Point";
        "Value Entry Type" := ItemJnlLine."Value Entry Type"::"Direct Cost";
        "Transaction Type" := ServShptLine."Transaction Type";
        "Transport Method" := ServShptLine."Transport Method";
        Area := ServShptLine.Area;
        "Transaction Specification" := ServShptLine."Transaction Specification";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Item Category Code" := ServShptLine."Item Category Code";
        Nonstock := ServShptLine.Nonstock;
        "Product Group Code" := ServShptLine."Product Group Code";
        "Return Reason Code" := ServShptLine."Return Reason Code";
    end;

    procedure CopyFromServShptLineUndo(ServShptLine: Record "5991")
    begin
        "Item No." := ServShptLine."No.";
        "Posting Date" := ServShptLine."Posting Date";
        "Order Date" := ServShptLine."Order Date";
        "Inventory Posting Group" := ServShptLine."Posting Group";
        "Gen. Bus. Posting Group" := ServShptLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServShptLine."Gen. Prod. Posting Group";
        "Location Code" := ServShptLine."Location Code";
        "Variant Code" := ServShptLine."Variant Code";
        "Bin Code" := ServShptLine."Bin Code";
        "Entry/Exit Point" := ServShptLine."Exit Point";
        "Shortcut Dimension 1 Code" := ServShptLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServShptLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServShptLine."Dimension Set ID";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Item No." := ServShptLine."No.";
        Description := ServShptLine.Description;
        "Location Code" := ServShptLine."Location Code";
        "Variant Code" := ServShptLine."Variant Code";
        "Transaction Type" := ServShptLine."Transaction Type";
        "Transport Method" := ServShptLine."Transport Method";
        Area := ServShptLine.Area;
        "Transaction Specification" := ServShptLine."Transaction Specification";
        "Unit of Measure Code" := ServShptLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := FALSE;
        "Item Category Code" := ServShptLine."Item Category Code";
        Nonstock := ServShptLine.Nonstock;
        "Product Group Code" := ServShptLine."Product Group Code";
        "Return Reason Code" := ServShptLine."Return Reason Code";
    end;

    procedure "---DEEE1.00---"()
    begin
    end;

    procedure CalculateDEEE(PCodNewReasonCode: Code[10])
    var
        RecLCustomer: Record "18";
        RecLReasonCode: Record "231";
        RecLDEEETariffs: Record "50007";
        RecLSalesSetup: Record "311";
        RecLItem: Record "27";
        CntTxt100: Label 'Paramétrage incorrect pour les filtres %1.';
    begin
        //>>DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
        IF ("Reason Code"='') OR (RecLReasonCode.GET("Reason Code")) THEN BEGIN
          RecLSalesSetup.GET ;
          IF (NOT RecLSalesSetup."DEEE Management") OR ("DEEE Category Code"='')
            OR (RecLReasonCode."Disable DEEE")
            OR (("Entry Type"<>"Entry Type"::Output) AND ("Entry Type"<>"Entry Type"::"Positive Adjmt.")) THEN BEGIN
              //Initvalue
              "DEEE Unit Price":=0 ;
              "DEEE HT Amount":=0 ;
              "DEEE VAT Amount":=0 ;
              "DEEE TTC Amount":=0 ;
              "Eco partner DEEE":='' ;
              EXIT ;
            END ;
         END ;

        //found the last tariff with the posting date (just for one eco partner)
        RecLItem.GET("Item No.");
        RecLDEEETariffs.RESET ;
        RecLDEEETariffs.SETRANGE("DEEE Code","DEEE Category Code") ;
        RecLDEEETariffs.SETRANGE("Eco Partner",RecLItem."Eco partner DEEE") ;
        RecLDEEETariffs.SETFILTER("Date beginning",'<=%1', "Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
          ERROR(CntTxt100,RecLDEEETariffs.GETFILTERS) ;
        END ;

        "DEEE Unit Price" := RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."Number of Units DEEE" ;
        VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
        "DEEE VAT Amount" := 0 ; //pas de tva
        "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
        "Eco partner DEEE":=RecLItem."Eco partner DEEE" ;
        "DEEE HT Amount (LCY)":="DEEE HT Amount" ;
        //<<DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
    end;

    local procedure RevaluationPerEntryAllowed(ItemNo: Code[20]): Boolean
    var
        ValueEntry: Record "5802";
    begin
        GetItem;
        IF Item."Costing Method" <> Item."Costing Method"::Average THEN
          EXIT(TRUE);

        ValueEntry.SETRANGE("Item No.",ItemNo);
        ValueEntry.SETRANGE("Entry Type",ValueEntry."Entry Type"::Revaluation);
        ValueEntry.SETRANGE("Partial Revaluation",TRUE);
        EXIT(ValueEntry.ISEMPTY);
    end;

    procedure TrackingExists(): Boolean
    begin
        EXIT(("Serial No." <> '') OR ("Lot No." <> ''));
    end;

    procedure IsPurchaseReturn(): Boolean
    begin
        EXIT(
          ("Document Type" IN ["Document Type"::"Purchase Credit Memo",
                               "Document Type"::"Purchase Return Shipment",
                               "Document Type"::"Purchase Invoice",
                               "Document Type"::"Purchase Receipt"]) AND
          (Quantity < 0));
    end;

    procedure IsOpenedFromBatch(): Boolean
    var
        ItemJournalBatch: Record "233";
        TemplateFilter: Text;
        BatchFilter: Text;
    begin
        BatchFilter := GETFILTER("Journal Batch Name");
        IF BatchFilter <> '' THEN BEGIN
          TemplateFilter := GETFILTER("Journal Template Name");
          IF TemplateFilter <> '' THEN
            ItemJournalBatch.SETFILTER("Journal Template Name",TemplateFilter);
          ItemJournalBatch.SETFILTER(Name,BatchFilter);
          ItemJournalBatch.FINDFIRST;
        END;

        EXIT((("Journal Batch Name" <> '') AND ("Journal Template Name" = '')) OR (BatchFilter <> ''));
    end;

    procedure SubcontractingWorkCenterUsed(): Boolean
    var
        WorkCenter: Record "99000754";
    begin
        IF Type = Type::"Work Center" THEN
          IF WorkCenter.GET("Work Center No.") THEN
            EXIT(WorkCenter."Subcontractor No." <> '');

        EXIT(FALSE);
    end;

    procedure CheckItemJournalLineRestriction()
    begin
        OnCheckItemJournalLinePostRestrictions;
    end;

    local procedure ConfirmOutputOnFinishedOperation()
    var
        ProdOrderRtngLine: Record "5409";
    begin
        IF ("Entry Type" <> "Entry Type"::Output) OR ("Output Quantity" = 0) THEN
          EXIT;

        IF NOT ProdOrderRtngLine.GET(
             ProdOrderRtngLine.Status::Released,"Order No.","Routing Reference No.","Routing No.","Operation No.")
        THEN
          EXIT;

        IF ProdOrderRtngLine."Routing Status" <> ProdOrderRtngLine."Routing Status"::Finished THEN
          EXIT;

        IF NOT CONFIRM(FinishedOutputQst) THEN
          ERROR(UpdateInterruptedErr);
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnCheckItemJournalLinePostRestrictions()
    begin
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Property Modification (Name) on "BlockDynamicTracking(PROCEDURE 17).SetBlock(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "BlockDynamicTracking(PROCEDURE 17).SetBlock(Parameter 1000)".


    //Unsupported feature: Property Insertion (Subtype) on "BlockDynamicTracking(PROCEDURE 17).SetBlock(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "LookupItemNo(PROCEDURE 37).ProdOrderLine2(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "LookupItemNo(PROCEDURE 37).ProdOrderLineList(Variable 1001)".


    var
        ProdOrderLine: Record "5406";
        ProdOrderComp: Record "5407";

    var
        ProdOrder: Record "5405";
        ProdOrderLine: Record "5406";

    var
        ProdOrderLine: Record "5406";

    var
        ProdOrderComp: Record "5407";

    var
        ProdOrderRtngLine: Record "5409";

    var
        ProdOrderRtngLine: Record "5409";

    var
        UpdateInterruptedErr: Label 'The update has been interrupted to respect the warning.';

    var
        SubcontractedErr: Label '%1 must be zero in line number %2 because it is linked to the subcontracted work center.', Comment='%1 - Field Caption, %2 - Line No.';
        FinishedOutputQst: Label 'The operation has been finished. Do you want to post output for the finished operation?';
}

