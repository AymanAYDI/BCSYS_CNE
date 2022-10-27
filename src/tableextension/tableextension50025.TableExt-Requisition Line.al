tableextension 50025 tableextension50025 extends "Requisition Line"
{
    // //GESTION_REMISE FLGR 08/01/2007 NSC1.01
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>> MODIF HL 27/07/2012 SU-LALE cf appel TI113954
    //               Modif C/AL Code dans trigger Location Code - OnValidate()
    LookupPageID = 517;
    DrillDownPageID = 517;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item WHERE (Type=CONST(Inventory));
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 31)".

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

        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. (Base)"(Field 5431)".

        modify("Demand Type")
        {
            TableRelation = AllObjWithCaption."Object ID" WHERE (Object Type=CONST(Table));
        }
        modify("Supply From")
        {
            TableRelation = IF (Replenishment System=CONST(Purchase)) Vendor
                            ELSE IF (Replenishment System=CONST(Transfer)) Location WHERE (Use As In-Transit=CONST(No));
        }

        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5701)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5705)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Transfer Shipment Date"(Field 5707)".

        modify("Operation No.")
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
                                                                              Prod. Order No.=FIELD(Prod. Order No.),
                                                                              Routing No.=FIELD(Routing No.));
        }
        modify("Prod. Order Line No.")
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE (Status=CONST(Finished),
                                                                 Prod. Order No.=FIELD(Prod. Order No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Low-Level Code"(Field 99000884)".


        //Unsupported feature: Property Modification (Data type) on ""Production BOM Version Code"(Field 99000885)".


        //Unsupported feature: Property Modification (Data type) on ""Routing Version Code"(Field 99000886)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Scrap %"(Field 99000892)".

        modify("Ref. Order No.")
        {
            TableRelation = IF (Ref. Order Type=CONST(Prod. Order)) "Production Order".No. WHERE (Status=FIELD(Ref. Order Status))
                            ELSE IF (Ref. Order Type=CONST(Purchase)) "Purchase Header".No. WHERE (Document Type=CONST(Order))
                            ELSE IF (Ref. Order Type=CONST(Transfer)) "Transfer Header".No. WHERE (No.=FIELD(Ref. Order No.))
                            ELSE IF (Ref. Order Type=CONST(Assembly)) "Assembly Header".No. WHERE (Document Type=CONST(Order));
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Expected Operation Cost Amt."(Field 99000909)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Expected Component Cost Amt."(Field 99000910)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Type(Field 4).OnValidate".

        //trigger (Variable: NewType)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "Type(Field 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF Type <> xRec.Type THEN BEGIN
              TempReqLine := Rec;

              DeleteRelations;
              "Dimension Set ID" := 0;
            #6..9
              ReserveReqLine.VerifyChange(Rec,xRec);
              AddOnIntegrMgt.ResetReqLineFields(Rec);
              INIT;
              Type := TempReqLine.Type;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF Type <> xRec.Type THEN BEGIN
              NewType := Type;
            #3..12
              Type := NewType;
            END;
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""No."(Field 5).OnValidate".

        //trigger (Variable: TempSKU)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 5).OnValidate".

        //trigger "(Field 5)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckActionMessageNew;
            ReserveReqLine.VerifyChange(Rec,xRec);
            DeleteRelations;
            #4..46
                      DATABASE::Item,Item.GETPOSITION);
                  Item.TESTFIELD("Base Unit of Measure");
                  "Indirect Cost %" := Item."Indirect Cost %";
                  GetPlanningParameters.AtSKU(SKU,"No.","Variant Code","Location Code");
                  IF Subcontracting THEN
                    SKU."Replenishment System" := SKU."Replenishment System"::"Prod. Order";
                  VALIDATE("Replenishment System",SKU."Replenishment System");
                  "Accept Action Message" := TRUE;
                  "Product Group Code" := Item."Product Group Code";
                  GetDirectCost(FIELDNO("No."));
                  IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
                    GetLocation("Location Code");
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                      WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
                  END;
                END;
            END;

            #65..72
            CreateDim(
              DimMgt.TypeToTableID3(Type),
              "No.",DATABASE::Vendor,"Vendor No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..49
                  GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
                  IF Subcontracting THEN
                    TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
                  VALIDATE("Replenishment System",TempSKU."Replenishment System");
            #54..56
                  SetFromBinCode;
            #62..75
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Vendor No."(Field 9).OnValidate".

        //trigger (Variable: TempSKU)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Vendor No."(Field 9).OnValidate".

        //trigger "(Field 9)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckActionMessageNew;
            IF "Vendor No." <> '' THEN
              IF Vend.GET("Vendor No.") THEN BEGIN
            #4..29
                "Vendor Item No." := ItemVend."Vendor Item No.";
                UpdateOrderReceiptDate(ItemVend."Lead Time Calculation");
              END ELSE BEGIN
                IF "Vendor No." = Item."Vendor No." THEN
                  "Vendor Item No." := Item."Vendor Item No."
                ELSE
                  "Vendor Item No." := '';
              END;
            #38..41
            CreateDim(
              DATABASE::Vendor,"Vendor No.",
              DimMgt.TypeToTableID3(Type),"No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..32
                GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
                IF "Vendor No." = TempSKU."Vendor No." THEN
                  "Vendor Item No." := TempSKU."Vendor Item No."
            #35..44
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Location Code"(Field 17).OnValidate".

        //trigger (Variable: TempSKU)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 17).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ValidateLocationChange;
            CheckActionMessageNew;
            "Bin Code" := '';
            ReserveReqLine.VerifyChange(Rec,xRec);

            IF Type = Type::Item THEN BEGIN
              GetPlanningParameters.AtSKU(SKU,"No.","Variant Code","Location Code");
              IF Subcontracting THEN
                SKU."Replenishment System" := SKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",SKU."Replenishment System");
              IF "Location Code" <> xRec."Location Code" THEN BEGIN
                IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
                  GetLocation("Location Code");
                  IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                    WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
                END;
                IF "Location Code" = '' THEN
                  UpdateDescription;
              END;
              IF ItemVend.GET("Vendor No.","No.","Variant Code") THEN
                "Vendor Item No." := ItemVend."Vendor Item No.";
            END;
            GetDirectCost(FIELDNO("Location Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
              GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
              IF Subcontracting THEN
                TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",TempSKU."Replenishment System");
              IF "Location Code" <> xRec."Location Code" THEN BEGIN
                IF ("Location Code" <> '') AND ("No." <> '') AND NOT IsDropShipment THEN BEGIN
                  GetLocation("Location Code");
                  IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
            //>>MIGRATION NAV 2013
            //>> MODIF HL 27/07/2012 SU-LALE cf appel TI113954
            //        WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
                IF Location."Require Put-away" AND NOT (Location."Require Receive") THEN
                  "Bin Code" := Location."Receipt Bin Code"
                ELSE
                    WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            //<< MODIF HL 27/07/2012 SU-LALE cf appel TI113954
            //<<MIGRATION NAV 2013
            #16..23
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


        //Unsupported feature: Code Insertion (VariableCollection) on ""Variant Code"(Field 5402).OnValidate".

        //trigger (Variable: TempSKU)()
        //Parameters and return type have not been exported.
        //begin
            /*
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
            CheckActionMessageNew;
            #4..8
            GetDirectCost(FIELDNO("Variant Code"));
            IF "Variant Code" <> '' THEN BEGIN
              UpdateDescription;
              GetPlanningParameters.AtSKU(SKU,"No.","Variant Code","Location Code");
              IF Subcontracting THEN
                SKU."Replenishment System" := SKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",SKU."Replenishment System");
              IF "Variant Code" <> xRec."Variant Code" THEN BEGIN
                "Bin Code" := '';
                IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
            #19..24
                "Vendor Item No." := ItemVend."Vendor Item No.";
            END ELSE
              VALIDATE("No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..11
              GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
              IF Subcontracting THEN
                TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
              VALIDATE("Replenishment System",TempSKU."Replenishment System");
            #16..27
            */
        //end;


        //Unsupported feature: Code Modification on ""Routing No."(Field 99000750).OnValidate".

        //trigger "(Field 99000750)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckActionMessageNew;
            "Routing Version Code" := '';

            #4..7
              RtngDate := "Starting Date"
            ELSE
              RtngDate := "Ending Date";

            VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.",RtngDate,TRUE));
            IF "Routing Version Code" = '' THEN BEGIN
            #14..18
              RtngHeader.TESTFIELD(Status,RtngHeader.Status::Certified);
              "Routing Type" := RtngHeader.Type;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            IF RtngDate = 0D THEN
              RtngDate := "Order Date";
            #11..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Work Center No."(Field 99000752).OnValidate".

        //trigger "(Field 99000752)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            WorkCenter.GET("Work Center No.");
            VALIDATE("Vendor No.",WorkCenter."Subcontractor No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetWorkCenter;
            VALIDATE("Vendor No.",WorkCenter."Subcontractor No.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Starting Date"(Field 99000894).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF Type = Type::Item THEN BEGIN
              IF WorkCenter.GET("Work Center No.") THEN
                IF WorkCenter."Subcontractor No." <> '' THEN
                  IsSubcontracting := TRUE;
              IF NOT IsSubcontracting THEN BEGIN
                VALIDATE("Production BOM No.");
                VALIDATE("Routing No.");
              END;
              VALIDATE("Starting Time");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF Type = Type::Item THEN BEGIN
              GetWorkCenter;
              IF NOT Subcontracting THEN BEGIN
            #6..10
            */
        //end;


        //Unsupported feature: Code Modification on ""Ending Date"(Field 99000896).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckEndingDate(ValidateFields);

            IF Type = Type::Item THEN BEGIN
              VALIDATE("Ending Time");
              IF WorkCenter.GET("Work Center No.") THEN
                IF WorkCenter."Subcontractor No." <> '' THEN
                  IsSubcontracting := TRUE;
              IF NOT IsSubcontracting THEN BEGIN
                VALIDATE("Production BOM No.");
                VALIDATE("Routing No.");
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
              GetWorkCenter;
              IF NOT Subcontracting THEN BEGIN
            #9..12
            */
        //end;


        //Unsupported feature: Code Modification on ""Production BOM No."(Field 99000898).OnValidate".

        //trigger "(Field 99000898)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Type,Type::Item);
            CheckActionMessageNew;
            "Production BOM Version Code" := '';
            IF "Production BOM No." = '' THEN
              EXIT;

            IF CurrFieldNo = FIELDNO("Starting Date") THEN
              BOMDate := "Starting Date"
            ELSE
              BOMDate := "Ending Date";

            VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.",BOMDate,TRUE));
            IF "Production BOM Version Code" = '' THEN BEGIN
            #14..21

              ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
            ELSE BEGIN
              BOMDate := "Ending Date";
              IF BOMDate = 0D THEN
                BOMDate := "Order Date";
            END;
            #11..24
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost"(Field 99000901).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Type,Type::Item);
            TESTFIELD("No.");

            Item.GET("No.");
            IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
              IF CurrFieldNo = FIELDNO("Unit Cost") THEN
                ERROR(
                  Text006,
                  FIELDCAPTION("Unit Cost"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
              "Unit Cost" := Item."Unit Cost" * "Qty. per Unit of Measure";
            END;
            "Cost Amount" := ROUND("Unit Cost" * Quantity);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
            #6..12
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Replenishment System"(Field 99000903).OnValidate".

        //trigger (Variable: TempSKU)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Replenishment System"(Field 99000903).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Type,Type::Item);
            CheckActionMessageNew;
            IF ValidateFields AND
               ("Replenishment System" = xRec."Replenishment System") AND
               ("No." = xRec."No.") AND
               ("Location Code" = xRec."Location Code") AND
               ("Variant Code" = xRec."Variant Code")
            THEN
              EXIT;

            TESTFIELD(Type,Type::Item);
            TESTFIELD("No.");
            GetItem;
            GetPlanningParameters.AtSKU(SKU,"No.","Variant Code","Location Code");
            IF Subcontracting THEN
              SKU."Replenishment System" := SKU."Replenishment System"::"Prod. Order";

            "Supply From" := '';

            CASE "Replenishment System" OF
              "Replenishment System"::Purchase:
                BEGIN
                  "Ref. Order Type" := "Ref. Order Type"::Purchase;
                  CLEAR("Ref. Order Status");
                  "Ref. Order No." := '';
                  DeleteRelations;
                  VALIDATE("Production BOM No.",'');
                  VALIDATE("Routing No.",'');
                  IF Item."Purch. Unit of Measure" <> '' THEN
                    VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure");
                  VALIDATE("Transfer-from Code",'');
                  IF CurrFieldNo = FIELDNO("Location Code") THEN
                    VALIDATE("Vendor No.")
                  ELSE
                    VALIDATE("Vendor No.",SKU."Vendor No.");
                END;
              "Replenishment System"::"Prod. Order":
                BEGIN
                  IF ReqWkshTmpl.GET("Worksheet Template Name") AND (ReqWkshTmpl.Type = ReqWkshTmpl.Type::"Req.") AND
                     (ReqWkshTmpl.Name <> '')
                  THEN
                    ERROR(ReplenishmentErr);
                  IF PlanningResiliency AND (Item."Base Unit of Measure" = '') THEN
                    TempPlanningErrorLog.SetError(
                      STRSUBSTNO(
                        Text032,Item.TABLECAPTION,Item."No.",
                        Item.FIELDCAPTION("Base Unit of Measure")),
                      DATABASE::Item,Item.GETPOSITION);
                  Item.TESTFIELD("Base Unit of Measure");
                  IF "Ref. Order No." = '' THEN BEGIN
                    "Ref. Order Type" := "Ref. Order Type"::"Prod. Order";
                    "Ref. Order Status" := "Ref. Order Status"::Planned;

                    MfgSetup.GET;
                    IF PlanningResiliency AND (MfgSetup."Planned Order Nos." = '') THEN
                      TempPlanningErrorLog.SetError(
                        STRSUBSTNO(Text032,MfgSetup.TABLECAPTION,'',
                          MfgSetup.FIELDCAPTION("Planned Order Nos.")),
                        DATABASE::"Manufacturing Setup",MfgSetup.GETPOSITION);
                    MfgSetup.TESTFIELD("Planned Order Nos.");

                    IF PlanningResiliency THEN
                      CheckNoSeries(MfgSetup."Planned Order Nos.","Due Date");
                    IF NOT Subcontracting THEN
                      NoSeriesMgt.InitSeries(
                        MfgSetup."Planned Order Nos.",xRec."No. Series","Due Date","Ref. Order No.","No. Series");
                  END;
                  VALIDATE("Vendor No.",'');

                  IF NOT Subcontracting THEN BEGIN
                    IF PlanningResiliency AND
                       ProdBOMHeader.GET(Item."Production BOM No.") AND
                       (ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified)
                    THEN
                      TempPlanningErrorLog.SetError(
                        STRSUBSTNO(
                          Text033,ProdBOMHeader.TABLECAPTION,
                          ProdBOMHeader.FIELDCAPTION("No."),ProdBOMHeader."No."),
                        DATABASE::"Production BOM Header",ProdBOMHeader.GETPOSITION);
                    VALIDATE("Production BOM No.",Item."Production BOM No.");
                    VALIDATE("Routing No.",Item."Routing No.");
                  END ELSE BEGIN
                    "Production BOM No." := Item."Production BOM No.";
                    "Routing No." := Item."Routing No.";
                  END;
                  VALIDATE("Transfer-from Code",'');
                  VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");

                  IF ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") AND
                     ValidateFields
                  THEN
                    PlngLnMgt.Calculate(Rec,1,TRUE,TRUE,0);
                END;
              "Replenishment System"::Assembly:
                BEGIN
                  IF PlanningResiliency AND (Item."Base Unit of Measure" = '') THEN
                    TempPlanningErrorLog.SetError(
                      STRSUBSTNO(
                        Text032,Item.TABLECAPTION,Item."No.",
                        Item.FIELDCAPTION("Base Unit of Measure")),
                      DATABASE::Item,Item.GETPOSITION);
                  Item.TESTFIELD("Base Unit of Measure");
                  IF "Ref. Order No." = '' THEN BEGIN
                    "Ref. Order Type" := "Ref. Order Type"::Assembly;
                    "Ref. Order Status" := AsmHeader."Document Type"::Order;
                  END;
                  VALIDATE("Vendor No.",'');
                  VALIDATE("Production BOM No.",'');
                  VALIDATE("Routing No.",'');
                  VALIDATE("Transfer-from Code",'');
                  VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");

                  IF ("Planning Line Origin" = "Planning Line Origin"::"Order Planning") AND
                     ValidateFields
                  THEN
                    PlngLnMgt.Calculate(Rec,1,TRUE,TRUE,0);
                END;
              "Replenishment System"::Transfer:
                BEGIN
                  "Ref. Order Type" := "Ref. Order Type"::Transfer;
                  CLEAR("Ref. Order Status");
                  "Ref. Order No." := '';
                  DeleteRelations;
                  VALIDATE("Vendor No.",'');
                  VALIDATE("Production BOM No.",'');
                  VALIDATE("Routing No.",'');
                  VALIDATE("Transfer-from Code",SKU."Transfer-from Code");
                  VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..13
            GetPlanningParameters.AtSKU(TempSKU,"No.","Variant Code","Location Code");
            IF Subcontracting THEN
              TempSKU."Replenishment System" := TempSKU."Replenishment System"::"Prod. Order";
            #17..31
                  IF TempSKU."Vendor No." = '' THEN
                    VALIDATE("Vendor No.")
                  ELSE
                    VALIDATE("Vendor No.",TempSKU."Vendor No.");
            #36..39
                     (ReqWkshTmpl.Name <> '') AND NOT SourceDropShipment
            #41..70
            #80..126
                  VALIDATE("Transfer-from Code",TempSKU."Transfer-from Code");
            #128..130
            */
        //end;
        field(7100;"Blanket Purch. Order Exists";Boolean)
        {
            CalcFormula = Exist("Purchase Line" WHERE (Document Type=CONST(Blanket Order),
                                                       Type=CONST(Item),
                                                       No.=FIELD(No.),
                                                       Outstanding Quantity=FILTER(<>0)));
            Caption = 'Blanket Purch. Order Exists';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Type,No.,Variant Code,Transfer-from Code,Transfer Shipment Date"(Key)".

        key(Key1;"Replenishment System",Type,"No.","Variant Code","Transfer-from Code","Transfer Shipment Date")
        {
            MaintainSQLIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
    }

    //Unsupported feature: Property Insertion (Local) on "UpdateOrderReceiptDate(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "LookupFromLocation(PROCEDURE 44)".


    //Unsupported feature: Variable Insertion (Variable: SalesLine) (VariableCollection) on "UpdateDescription(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Local) on "UpdateDescription(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "UpdateDescription(PROCEDURE 8)".

    //procedure UpdateDescription();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (Type <> Type::Item) OR ("No." = '') THEN
          EXIT;
        IF "Variant Code" = '' THEN BEGIN
          GetItem;
          Description := Item.Description;
          "Description 2" := Item."Description 2";
        END ELSE BEGIN
          ItemVariant.GET("No.","Variant Code");
          Description := ItemVariant.Description;
          "Description 2" := ItemVariant."Description 2";
        END;
        IF "Vendor No." <> '' THEN BEGIN
          Vend.GET("Vendor No.");
          IF Vend."Language Code" <> '' THEN
            IF ItemTranslation.GET("No.","Variant Code",Vend."Language Code") THEN BEGIN
              Description := ItemTranslation.Description;
              "Description 2" := ItemTranslation."Description 2";
            END;
        END;
        IF (CurrFieldNo <> 0) AND (CurrFieldNo <> FIELDNO("Location Code")) THEN BEGIN
          ReserveReqLine.FilterReservFor(ReservEntry,Rec);
          IF ReservEntry.ISEMPTY THEN
            IF "Vendor No." <> '' THEN BEGIN
              "Location Code" := Vend."Location Code";
              IF ItemVend.GET("Vendor No.","No.","Variant Code") THEN
                IF ItemCrossRef.GET(
                     "No.","Variant Code","Unit of Measure Code",
                     ItemCrossRef."Cross-Reference Type"::Vendor,
                     "Vendor No.",ItemVend."Vendor Item No.")
                THEN
                  Description := ItemCrossRef.Description;
            END ELSE
              "Location Code" := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11

        IF SalesLine.GET(SalesLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.") THEN BEGIN
          Description := SalesLine.Description;
          "Description 2" := SalesLine."Description 2";
        END;

        IF "Vendor No." <> '' THEN
          IF ItemCrossRef.GetItemDescription(
               Description,"No.","Variant Code","Unit of Measure Code",ItemCrossRef."Cross-Reference Type"::Vendor,"Vendor No.")
          THEN
            "Description 2" := ''
          ELSE BEGIN
            Vend.GET("Vendor No.");
            IF Vend."Language Code" <> '' THEN
              IF ItemTranslation.GET("No.","Variant Code",Vend."Language Code") THEN BEGIN
                Description := ItemTranslation.Description;
                "Description 2" := ItemTranslation."Description 2";
              END;
          END;

        IF (CurrFieldNo <> 0) AND (CurrFieldNo <> FIELDNO("Location Code")) AND
           ("Planning Line Origin" = "Planning Line Origin"::" ")
        THEN
          IF ("Vendor No." <> '') AND NOT IsDropShipment THEN
            "Location Code" := Vend."Location Code"
          ELSE
            "Location Code" := '';
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CreateDim(PROCEDURE 2)".


    //Unsupported feature: Property Insertion (Local) on "CheckEndingDate(PROCEDURE 26)".


    //Unsupported feature: Property Insertion (Local) on "CheckDueDateToDemandDate(PROCEDURE 41)".


    //Unsupported feature: Property Insertion (Local) on "CheckActionMessageNew(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "SetActionMessage(PROCEDURE 23)".

    //procedure SetActionMessage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ValidateFields AND
           ("Action Message" <> "Action Message"::" ") AND
           ("Action Message" <> "Action Message"::New)
        #4..16
            ELSE
              IF "Original Due Date" <> 0D THEN
                "Action Message" := "Action Message"::Reschedule;
          CLEAR("Planning Line Origin");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19

          IF "Action Message" <> xRec."Action Message" THEN
            CLEAR("Planning Line Origin");
        END;
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "SetCurrentFieldNo(PROCEDURE 58)".



    //Unsupported feature: Code Modification on "SetCurrentFieldNo(PROCEDURE 58)".

    //procedure SetCurrentFieldNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentFieldNo := NewCurrFieldNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SourceDropShipment := NewDropShipment;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetDirectCost(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "GetDirectCost(PROCEDURE 12)".

    //procedure GetDirectCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Replenishment System" = "Replenishment System"::Purchase THEN BEGIN
          PurchPriceCalcMgt.FindReqLineDisc(Rec);
          PurchPriceCalcMgt.FindReqLinePrice(Rec,CalledByFieldNo);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetWorkCenter;
        IF ("Replenishment System" = "Replenishment System"::Purchase) AND NOT Subcontracting THEN BEGIN
          PurchPriceCalcMgt.FindReqLineDisc(Rec);
          PurchPriceCalcMgt.FindReqLinePrice(Rec,CalledByFieldNo);
          //>>MIGRATION NAv 2013
          //>>GESTION_REMISE FLGR 08/01/2007 NSC1.01
          PurchPriceCalcMgt.FindVeryBestCostreq(Rec) ;
          //<<Fin GESTION_REMISE FLGR 08/01/2007 NSC1.01
          //<<MIGRATION NAV 2013

        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateLocationChange(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "CalcEndingDate(PROCEDURE 37)".

    //procedure CalcEndingDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Ref. Order Type" OF
          "Ref. Order Type"::Purchase:
            IF LeadTime = '' THEN
              LeadTime := LeadTimeMgt.PurchaseLeadTime("No.","Location Code","Variant Code","Vendor No.");
          "Ref. Order Type"::"Prod. Order",
          "Ref. Order Type"::Assembly:
            BEGIN
              IF "Routing No." <> '' THEN
                EXIT;
              IF LeadTime = '' THEN
                LeadTime := LeadTimeMgt.ManufacturingLeadTime("No.","Location Code","Variant Code");
            END;
        #13..18
        "Ending Date" :=
          LeadTimeMgt.PlannedEndingDate2(
            "No.","Location Code","Variant Code","Vendor No.",LeadTime,"Ref. Order Type","Starting Date");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
              IF RoutingLineExists THEN
                EXIT;

        #10..21
        */
    //end;


    //Unsupported feature: Code Modification on "CalcStartingDate(PROCEDURE 51)".

    //procedure CalcStartingDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Ref. Order Type" OF
          "Ref. Order Type"::Purchase:
            IF LeadTime = '' THEN
        #4..6
          "Ref. Order Type"::"Prod. Order",
          "Ref. Order Type"::Assembly:
            BEGIN
              IF "Routing No." <> '' THEN
                EXIT;
              IF LeadTime = '' THEN
                LeadTime := LeadTimeMgt.ManufacturingLeadTime("No.","Location Code","Variant Code");
            END;
        #15..19
          LeadTimeMgt.PlannedStartingDate(
            "No.","Location Code","Variant Code","Vendor No.",LeadTime,"Ref. Order Type","Ending Date");

        "Order Date" := "Starting Date";

        IF "Ref. Order Type" = "Ref. Order Type"::Transfer THEN
          CalcTransferShipmentDate;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
              IF RoutingLineExists THEN
                EXIT;

        #12..22
        VALIDATE("Order Date","Starting Date");
        #24..26
        */
    //end;


    //Unsupported feature: Code Modification on "TransferFromUnplannedDemand(PROCEDURE 46)".

    //procedure TransferFromUnplannedDemand();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        INIT;
        "Line No." := "Line No." + 10000;
        "Planning Line Origin" := "Planning Line Origin"::"Order Planning";
        #4..7
        "Bin Code" := UnplannedDemand."Bin Code";
        VALIDATE("No.");
        VALIDATE("Variant Code",UnplannedDemand."Variant Code");
        Description := UnplannedDemand.Description;
        "Unit Of Measure Code (Demand)" := UnplannedDemand."Unit of Measure Code";
        "Qty. per UOM (Demand)" := UnplannedDemand."Qty. per Unit of Measure";
        Reserve := UnplannedDemand.Reserve;
        #15..28
        "Demand Order No." := UnplannedDemand."Demand Order No.";
        "Demand Line No." := UnplannedDemand."Demand Line No.";
        "Demand Ref. No." := UnplannedDemand."Demand Ref. No.";
        IF UnplannedDemand."Special Order" THEN BEGIN
          "Sales Order No." := UnplannedDemand."Demand Order No.";
          "Sales Order Line No." := UnplannedDemand."Demand Line No.";
          "Sell-to Customer No." := UnplannedDemand."Sell-to Customer No.";
          "Purchasing Code" := UnplannedDemand."Purchasing Code";
        END;

        Status := UnplannedDemand.Status;

        Level := 1;
        "Action Message" := ReqLine."Action Message"::New;
        "User ID" := USERID;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        UpdateDescription;
        #12..31
        #38..43
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckExchRate(PROCEDURE 50)".


    //Unsupported feature: Property Insertion (Local) on "CheckNoSeries(PROCEDURE 53)".



    //Unsupported feature: Code Modification on "CheckNoSeries(PROCEDURE 53)".

    //procedure CheckNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TRUE OF
          NOT NoSeries.GET(NoSeriesCode):
            TempPlanningErrorLog.SetError(
        #4..14
              SeriesDate := WORKDATE;

            NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine,NoSeriesCode,SeriesDate);
            IF NOT NoSeriesLine.FIND('-') THEN BEGIN
              NoSeriesLine.SETRANGE("Starting Date");
              IF NoSeriesLine.FIND('-') THEN BEGIN
                TempPlanningErrorLog.SetError(
                  STRSUBSTNO(Text039,NoSeriesCode,SeriesDate),DATABASE::"No. Series",NoSeries.GETPOSITION);
                EXIT;
        #24..68
                STRSUBSTNO(Text044,NoSeriesLine."Ending No.",NoSeriesCode),
                DATABASE::"No. Series",NoSeries.GETPOSITION);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17
            IF NOT NoSeriesLine.FINDFIRST THEN BEGIN
              NoSeriesLine.SETRANGE("Starting Date");
              IF NoSeriesLine.FINDFIRST THEN BEGIN
        #21..71
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "FilterLinesWithItemToPlan(PROCEDURE 70)".


    procedure SetRefFilter(RefOrderType: Option;RefOrderStatus: Option;RefOrderNo: Code[20];RefLineNo: Integer)
    begin
        SETCURRENTKEY("Ref. Order Type","Ref. Order Status","Ref. Order No.","Ref. Line No.");
        SETRANGE("Ref. Order Type",RefOrderType);
        SETRANGE("Ref. Order Status",RefOrderStatus);
        SETRANGE("Ref. Order No.",RefOrderNo);
        SETRANGE("Ref. Line No.",RefLineNo);
    end;

    local procedure SetFromBinCode()
    begin
        IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
          GetLocation("Location Code");
          CASE "Ref. Order Type" OF
            "Ref. Order Type"::"Prod. Order":
              BEGIN
                IF "Bin Code" = '' THEN
                  "Bin Code" := WMSManagement.GetLastOperationFromBinCode("Routing No.","Routing Version Code","Location Code",FALSE,0);
                IF "Bin Code" = '' THEN
                  "Bin Code" := Location."From-Production Bin Code";
              END;
            "Ref. Order Type"::Assembly:
              IF "Bin Code" = '' THEN
                "Bin Code" := Location."From-Assembly Bin Code";
          END;
          IF ("Bin Code" = '') AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
            WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
        END;
    end;

    local procedure IsDropShipment(): Boolean
    var
        SalesLine: Record "37";
    begin
        IF SourceDropShipment THEN
          EXIT(TRUE);

        IF "Replenishment System" = "Replenishment System"::Purchase THEN
          IF SalesLine.GET(SalesLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.") THEN
            EXIT(SalesLine."Drop Shipment");
        EXIT(FALSE);
    end;

    local procedure GetWorkCenter()
    begin
        IF WorkCenter."No." = "Work Center No." THEN
          EXIT;

        CLEAR(WorkCenter);
        IF WorkCenter.GET("Work Center No.") THEN
          SetSubcontracting(WorkCenter."Subcontractor No." <> '')
        ELSE
          SetSubcontracting(FALSE);
    end;

    local procedure RoutingLineExists(): Boolean
    var
        RoutingLine: Record "99000764";
    begin
        IF "Routing No." <> '' THEN BEGIN
          RoutingLine.SETRANGE("Routing No.","Routing No.");
          EXIT(NOT RoutingLine.ISEMPTY);
        END;

        EXIT(FALSE);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "UpdateDescription(PROCEDURE 8).ItemVend(Variable 1000)".


    //Unsupported feature: Property Modification (Name) on "SetCurrentFieldNo(PROCEDURE 58).NewCurrFieldNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "SetCurrentFieldNo(PROCEDURE 58).NewCurrFieldNo(Parameter 1000)".


    //Unsupported feature: Move on "CalcTransferShipmentDate(PROCEDURE 31).TransferRoute(Variable 1001)".


    var
        NewType: Option;

    var
        TempSKU: Record "5700" temporary;

    var
        TempSKU: Record "5700" temporary;

    var
        TempSKU: Record "5700" temporary;

    var
        TempSKU: Record "5700" temporary;

    var
        TempSKU: Record "5700" temporary;


    //Unsupported feature: Property Modification (Id) on "Reservation(Variable 1025)".

    //var
        //>>>> ORIGINAL VALUE:
        //Reservation : 1025;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Reservation : 1009;
        //Variable type has not been exported.

    var
        SourceDropShipment: Boolean;
}

