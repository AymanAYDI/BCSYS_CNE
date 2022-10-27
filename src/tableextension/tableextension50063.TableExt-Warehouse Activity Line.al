tableextension 50063 tableextension50063 extends "Warehouse Activity Line"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    //                   - Add Field 50040 Source No. 2
    //                   - Add Field 50041 Source Line No. 2
    //                   - Add Field 50041 Source Document 2
    // 
    // 
    // //>>CNE5.00
    // TDL.71/CSC 02/12/2013 : Add C/AL in Qty. to Handle - OnValidate()
    // 
    // //>> CNE6.01
    // TDL:EC01 15.12.2014 : Add Field Qty. Picked
    LookupPageID = 5785;
    DrillDownPageID = 5785;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Destination No.")
        {
            TableRelation = IF (Destination Type=CONST(Vendor)) Vendor
                            ELSE IF (Destination Type=CONST(Customer)) Customer
                            ELSE IF (Destination Type=CONST(Location)) Location
                            ELSE IF (Destination Type=CONST(Item)) Item
                            ELSE IF (Destination Type=CONST(Family)) Family
                            ELSE IF (Destination Type=CONST(Sales Order)) "Sales Header".No. WHERE (Document Type=CONST(Order));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Assemble to Order"(Field 900)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Serial No. Blocked"(Field 6504)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Lot No. Blocked"(Field 6505)".

        modify("Bin Code")
        {
            TableRelation = IF (Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                            ELSE IF (Zone Code=FILTER(<>'')) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                             Zone Code=FIELD(Zone Code));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Bin Code"(Field 7300)".

        }
        modify("Whse. Document No.")
        {
            TableRelation = IF (Whse. Document Type=CONST(Receipt)) "Posted Whse. Receipt Header".No. WHERE (No.=FIELD(Whse. Document No.))
                            ELSE IF (Whse. Document Type=CONST(Shipment)) "Warehouse Shipment Header".No. WHERE (No.=FIELD(Whse. Document No.))
                            ELSE IF (Whse. Document Type=CONST(Internal Put-away)) "Whse. Internal Put-away Header".No. WHERE (No.=FIELD(Whse. Document No.))
                            ELSE IF (Whse. Document Type=CONST(Internal Pick)) "Whse. Internal Pick Header".No. WHERE (No.=FIELD(Whse. Document No.))
                            ELSE IF (Whse. Document Type=CONST(Production)) "Production Order".No. WHERE (No.=FIELD(Whse. Document No.))
                            ELSE IF (Whse. Document Type=CONST(Assembly)) "Assembly Header".No. WHERE (Document Type=CONST(Order),
                                                                                                       No.=FIELD(Whse. Document No.));
        }
        modify("Whse. Document Line No.")
        {
            TableRelation = IF (Whse. Document Type=CONST(Receipt)) "Posted Whse. Receipt Line"."Line No." WHERE (No.=FIELD(Whse. Document No.),
                                                                                                                  Line No.=FIELD(Whse. Document Line No.))
                                                                                                                  ELSE IF (Whse. Document Type=CONST(Shipment)) "Warehouse Shipment Line"."Line No." WHERE (No.=FIELD(Whse. Document No.),
                                                                                                                                                                                                            Line No.=FIELD(Whse. Document Line No.))
                                                                                                                                                                                                            ELSE IF (Whse. Document Type=CONST(Internal Put-away)) "Whse. Internal Put-away Line"."Line No." WHERE (No.=FIELD(Whse. Document No.),
                                                                                                                                                                                                                                                                                                                    Line No.=FIELD(Whse. Document Line No.))
                                                                                                                                                                                                                                                                                                                    ELSE IF (Whse. Document Type=CONST(Internal Pick)) "Whse. Internal Pick Line"."Line No." WHERE (No.=FIELD(Whse. Document No.),
                                                                                                                                                                                                                                                                                                                                                                                                                    Line No.=FIELD(Whse. Document Line No.))
                                                                                                                                                                                                                                                                                                                                                                                                                    ELSE IF (Whse. Document Type=CONST(Production)) "Prod. Order Line"."Line No." WHERE (Prod. Order No.=FIELD(No.),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Line No.=FIELD(Line No.))
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ELSE IF (Whse. Document Type=CONST(Assembly)) "Assembly Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Document No.=FIELD(Whse. Document No.),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Line No.=FIELD(Whse. Document Line No.));
        }


        //Unsupported feature: Code Insertion (VariableCollection) on ""Qty. to Handle"(Field 26).OnValidate".

        //trigger (Variable: RecLUserSetup)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Handle"(Field 26).OnValidate".

        //trigger  to Handle"(Field 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Qty. to Handle" > "Qty. Outstanding" THEN
              ERROR(
                Text002,
                "Qty. Outstanding");

            GetLocation("Location Code");
            IF Location."Directed Put-away and Pick" THEN
              WMSMgt.CalcCubageAndWeight(
            #9..29
              IF ("Breakbulk No." <> 0) OR "Original Breakbulk" THEN
                UpdateBreakbulkQtytoHandle;

            IF ("Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"]) AND
               ("Action Type" <> "Action Type"::Place) AND ("Lot No." <> '') AND (CurrFieldNo <> 0)
            THEN
              CheckReservedItemTrkg(1,"Lot No.");

            IF "Qty. to Handle" = 0 THEN
              UpdateReservation(Rec)
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
            //>>CNE5.00
            IF RecLUserSetup.GET(USERID) THEN BEGIN
              IF NOT RecLUserSetup."Autorize Qty. to Handle Change" THEN
                ERROR(CstL001);
              IF RecLUserSetup."Aut. Qty. to Han. Test PickQty" THEN
                IF "Qty. to Handle" > "Qty. Picked" THEN
                  ERROR(CstL002);

            END ELSE
              ERROR(CstL001);
            //<<CNE5.00

            #6..32
            IF ("Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"]) AND
            #34..37
            IF ("Qty. to Handle" = 0) AND RegisteredWhseActLineIsEmpty THEN
              UpdateReservation(Rec,FALSE)
            */
        //end;


        //Unsupported feature: Code Modification on ""Serial No."(Field 6500).OnValidate".

        //trigger "(Field 6500)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Serial No." <> '' THEN BEGIN
              ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,TRUE);
              TESTFIELD("Qty. per Unit of Measure",1);

              IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] THEN
                CheckReservedItemTrkg(0,"Serial No.");

              CheckSNSpecificationExists;
            #9..12

            IF "Serial No." <> xRec."Serial No." THEN
              "Expiration Date" := 0D;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
              IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] THEN
            #6..15
            */
        //end;


        //Unsupported feature: Code Modification on ""Lot No."(Field 6501).OnValidate".

        //trigger "(Field 6501)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Lot No." <> '' THEN BEGIN
              ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,TRUE);

              IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] THEN
                CheckReservedItemTrkg(1,"Lot No.");
            END;

            IF "Lot No." <> xRec."Lot No." THEN
              "Expiration Date" := 0D;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] THEN
            #5..9
            */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 7300).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckBinInSourceDoc;

            IF "Bin Code" <> '' THEN
              IF NOT "Assemble to Order" AND ("Action Type" = "Action Type"::Take) THEN
                WMSMgt.FindBinContent("Location Code","Bin Code","Item No.","Variant Code","Zone Code")
              ELSE
                WMSMgt.FindBin("Location Code","Bin Code","Zone Code");

            IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
              CheckInvalidBinCode;
              IF GetBin("Location Code","Bin Code") THEN BEGIN
                IF CurrFieldNo <> 0 THEN BEGIN
                  IF ("Activity Type" = "Activity Type"::"Put-away") AND
                     ("Breakbulk No." <> 0)
                  THEN
                    ERROR(Text005,FIELDCAPTION("Bin Code"));
                  CheckWhseDocLine;
                  IF "Action Type" = "Action Type"::Take THEN BEGIN
                    IF (("Whse. Document Type" <> "Whse. Document Type"::Receipt) AND
                        (Bin."Bin Type Code" <> ''))
                    THEN
                      IF BinType.GET(Bin."Bin Type Code") THEN
                        BinType.TESTFIELD(Receive,FALSE);
                    GetLocation("Location Code");
                    IF Location."Directed Put-away and Pick" THEN BEGIN
                      UOMCode := "Unit of Measure Code";
                      QtyOutstanding := "Qty. Outstanding";
                    END ELSE BEGIN
                      UOMCode := WMSMgt.GetBaseUOM("Item No.");
                      QtyOutstanding := "Qty. Outstanding (Base)";
                    END;
                    NewBinCode := "Bin Code";
                    IF BinContent.GET("Location Code","Bin Code","Item No.","Variant Code",UOMCode) THEN BEGIN
                      IF "Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] THEN
                        QtyAvail := BinContent.CalcQtyAvailToPick(0)
                      ELSE
                        QtyAvail := BinContent.CalcQtyAvailToTake(0);
                      IF Location."Directed Put-away and Pick" THEN BEGIN
                        CreatePick.SetCrossDock(Bin."Cross-Dock Bin");
                        AvailableQty :=
                          CreatePick.CalcTotalAvailQtyToPick(
                            "Location Code","Item No.","Variant Code","Lot No.","Serial No.",
                            "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",0);
                        AvailableQty := AvailableQty + "Qty. Outstanding (Base)";
                        IF AvailableQty < 0 THEN
                          AvailableQty := 0;

                        IF AvailableQty = 0 THEN
                          ERROR(Text015);
                        IF "Bin Code" <> '' THEN BEGIN
                          IF "Qty. to Handle" <> 0 THEN
                            CreatePick.CheckReservation(
                              AvailableQty,"Location Code","Source Type","Source Subtype","Source No.",
                              "Source Line No.","Source Subline No.","Qty. per Unit of Measure",
                              "Qty. to Handle","Qty. to Handle (Base)");
                          CreatePick.GetReservationStatus(ReservationExists,ReservedForItemLedgEntry);
                          IF ReservationExists AND NOT ReservedForItemLedgEntry THEN
                            ERROR(Text016,"Item No.");
                        END;
                      END ELSE
                        AvailableQty := QtyAvail;

                      IF AvailableQty < QtyAvail THEN
                        QtyAvail := AvailableQty;

                      IF (QtyAvail < QtyOutstanding) AND NOT "Assemble to Order" THEN BEGIN
                        IF NOT
                           CONFIRM(
                             STRSUBSTNO(
                               Text012,
                               FIELDCAPTION("Qty. Outstanding"),QtyOutstanding,
                               QtyAvail,BinContent.TABLECAPTION,FIELDCAPTION("Bin Code")),
                             FALSE)
                        THEN
                          ERROR(Text006);

                        "Bin Code" := NewBinCode;
                        MODIFY;
                      END;
                    END ELSE BEGIN
                      IF NOT "Assemble to Order" THEN
                        IF NOT
                           CONFIRM(
                             STRSUBSTNO(
                               Text012,
                               FIELDCAPTION("Qty. Outstanding"),QtyOutstanding,
                               QtyAvail,BinContent.TABLECAPTION,FIELDCAPTION("Bin Code")),
                             FALSE)
                        THEN
                          ERROR(Text006);

                      "Bin Code" := NewBinCode;
                      MODIFY;
                    END;
                  END ELSE BEGIN
                    IF "Qty. to Handle" > 0 THEN
                      CheckIncreaseCapacity(FALSE);
                    DeleteBinContent(xRec);
                  END;
                END;
                Dedicated := Bin.Dedicated;
                IF Location."Directed Put-away and Pick" THEN BEGIN
                  "Bin Ranking" := Bin."Bin Ranking";
                  "Bin Type Code" := Bin."Bin Type Code";
                  "Zone Code" := Bin."Zone Code";
                END;
              END ELSE BEGIN
                Dedicated := FALSE;
                "Bin Ranking" := 0;
                "Bin Type Code" := '';
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..42
                            "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",0,FALSE);
            #44..49
            #60..97
                    xRec.DeleteBinContent(xRec."Action Type"::Place);
            #99..107
                xRec.DeleteBinContent(xRec."Action Type"::Place);
            #108..112
            */
        //end;


        //Unsupported feature: Code Modification on ""Zone Code"(Field 7301).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF xRec."Zone Code" <> "Zone Code" THEN BEGIN
              GetLocation("Location Code");
              Location.TESTFIELD("Directed Put-away and Pick");
              IF "Action Type" = "Action Type"::Place THEN
                DeleteBinContent(xRec);
              "Bin Code" := '';
              "Bin Ranking" := 0;
              "Bin Type Code" := '';
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              xRec.DeleteBinContent(xRec."Action Type"::Place);
            #6..9
            */
        //end;
        field(901;"ATO Component";Boolean)
        {
            Caption = 'ATO Component';
            Editable = false;
        }
        field(50040;"Source No. 2";Code[20])
        {
            Caption = 'Source No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF (Source Document 2=CONST(Sales Order)) "Sales Header".No. WHERE (Document Type=CONST(Order));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50041;"Source Line No. 2";Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50042;"Source Document 2";Option)
        {
            BlankZero = true;
            Caption = 'Source Document';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output';
            OptionMembers = ,"Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order","Inbound Transfer","Outbound Transfer","Prod. Consumption","Prod. Output";
        }
        field(50043;"Source Bin Code";Code[20])
        {
            Caption = 'Lien code emplacement origine';
            Description = 'CNE4.01';
            Editable = false;

            trigger OnLookup()
            begin
                WMSMgt.BinLookUp("Location Code","Item No.","Variant Code",'');
            end;
        }
        field(50045;"Warehouse Comment";Text[50])
        {
            Caption = 'Warehouse Comments';
            Description = 'CNE4.01';
        }
        field(50046;"Qty. Picked";Decimal)
        {
            Caption = 'Qty. picked';
            DecimalPlaces = 0:5;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                RecLUserSetup: Record "91";
                CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
            begin
                IF "Qty. to Handle" > "Qty. Outstanding" THEN
                  ERROR(
                    Text002,
                    "Qty. Outstanding");

                //>>CNE5.00
                IF RecLUserSetup.GET(USERID) THEN BEGIN
                  IF NOT RecLUserSetup."Autorize Qty. to Handle Change" THEN
                    ERROR(CstL001);
                END ELSE
                  ERROR(CstL001);
                //<<CNE5.00

                GetLocation("Location Code");
                IF Location."Directed Put-away and Pick" THEN
                  WMSMgt.CalcCubageAndWeight(
                    "Item No.","Unit of Measure Code","Qty. to Handle",Cubage,Weight);

                IF (CurrFieldNo <> 0) AND
                   ("Action Type" = "Action Type"::Place) AND
                   ("Breakbulk No." = 0) AND
                   ("Qty. to Handle" > 0) AND
                   Location."Directed Put-away and Pick"
                THEN
                  IF GetBin("Location Code","Bin Code") THEN
                    CheckIncreaseCapacity(TRUE);

                IF NOT UseBaseQty THEN BEGIN
                  "Qty. to Handle (Base)" := CalcBaseQty("Qty. to Handle");
                  IF "Qty. to Handle (Base)" > "Qty. Outstanding (Base)" THEN // rounding error- qty same, not base qty
                    "Qty. to Handle (Base)" := "Qty. Outstanding (Base)";
                END;

                IF ("Activity Type" = "Activity Type"::"Put-away") AND
                   ("Action Type" = "Action Type"::Take) AND
                   (CurrFieldNo <> 0)
                THEN
                  IF ("Breakbulk No." <> 0) OR "Original Breakbulk" THEN
                    UpdateBreakbulkQtytoHandle;

                IF ("Activity Type" IN ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"]) AND
                   ("Action Type" <> "Action Type"::Place) AND ("Lot No." <> '') AND (CurrFieldNo <> 0)
                THEN
                  CheckReservedItemTrkg(1,"Lot No.");

                IF "Qty. to Handle" = 0 THEN
                  UpdateReservation(Rec,FALSE)
            end;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Bin Code,Location Code,Action Type,Variant Code,Unit of Measure Code,Breakbulk No.,Activity Type,Lot No.,Serial No.,Original Breakbulk,Assemble to Order"(Key)".

        key(Key1;"Item No.","Bin Code","Location Code","Action Type","Variant Code","Unit of Measure Code","Breakbulk No.","Activity Type","Lot No.","Serial No.","Original Breakbulk","Assemble to Order","ATO Component")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Quantity,"Qty. (Base)","Qty. Outstanding","Qty. Outstanding (Base)",Cubage,Weight;
        }
    }


    //Unsupported feature: Code Modification on "DeleteRelatedWhseActivLines(PROCEDURE 13)".

    //procedure DeleteRelatedWhseActivLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH WhseActivLine DO BEGIN
          IF ("Activity Type" IN ["Activity Type"::"Invt. Put-away","Activity Type"::"Invt. Pick"]) AND
             (NOT CalledFromHeader)
        #4..61
          IF WhseActivLine2.FIND('-') THEN
            REPEAT
              WhseActivLine2.DELETE; // to ensure correct item tracking update
              DeleteBinContent(WhseActivLine2);
              UpdateRelatedItemTrkg(WhseActivLine2);
            UNTIL WhseActivLine2.NEXT = 0;
          IF (NOT CalledFromHeader) AND
        #69..74
              MESSAGE(Text013);
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..64
              WhseActivLine2.DeleteBinContent(WhseActivLine2."Action Type"::Place);
        #66..77
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetItemUnitOfMeasure(PROCEDURE 18)".


    //Unsupported feature: Property Insertion (Local) on "GetLocation(PROCEDURE 2)".


    //Unsupported feature: Property Insertion (Local) on "CheckIncreaseCapacity(PROCEDURE 6)".


    //Unsupported feature: Variable Insertion (Variable: NewLineNo) (VariableCollection) on "SplitLine(PROCEDURE 27)".



    //Unsupported feature: Code Modification on "SplitLine(PROCEDURE 27)".

    //procedure SplitLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseActivLine.TESTFIELD("Qty. to Handle");
        IF WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::"Put-away" THEN BEGIN
          IF WhseActivLine."Breakbulk No." <> 0 THEN
        #4..14
        ELSE
          LineSpacing := 10000;

        NewWhseActivLine.RESET;
        NewWhseActivLine.INIT;
        NewWhseActivLine := WhseActivLine;
        #21..56
            WhseActivLine."Item No.",WhseActivLine."Unit of Measure Code",
            WhseActivLine."Qty. to Handle",WhseActivLine.Cubage,WhseActivLine.Weight);
        WhseActivLine.MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17
        IF LineSpacing = 0 THEN BEGIN
          ReNumberAllLines(NewWhseActivLine,WhseActivLine."Line No.",NewLineNo);
          WhseActivLine.GET(WhseActivLine."Activity Type",WhseActivLine."No.",NewLineNo);
          LineSpacing := 5000;
        END;

        #18..59
        */
    //end;


    //Unsupported feature: Code Modification on "ShowWhseDoc(PROCEDURE 22)".

    //procedure ShowWhseDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Whse. Document Type" OF
          "Whse. Document Type"::Shipment:
            BEGIN
        #4..13
          "Whse. Document Type"::"Internal Pick":
            BEGIN
              WhseIntPickHeader.SETRANGE("No.","Whse. Document No.");
              WhseIntPickCard.SETTABLEVIEW(WhseIntPickHeader);
              WhseIntPickCard.RUNMODAL;
            END;
          "Whse. Document Type"::"Internal Put-away":
            BEGIN
              WhseIntPutawayHeader.SETRANGE("No.","Whse. Document No.");
              WhseIntPutawayCard.SETTABLEVIEW(WhseIntPutawayHeader);
              WhseIntPutawayCard.RUNMODAL;
            END;
        #26..35
              PAGE.RUNMODAL(PAGE::"Assembly Order",AssemblyHeader);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
              WhseIntPickHeader.FINDFIRST;
              WhseIntPickCard.SETRECORD(WhseIntPickHeader);
        #17..22
              WhseIntPutawayHeader.FINDFIRST;
              WhseIntPutawayCard.SETRECORD(WhseIntPutawayHeader);
        #23..38
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CreateNewUOMLine(PROCEDURE 34)".


    //Unsupported feature: Property Insertion (Local) on "UpdateRelatedItemTrkg(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateRelatedItemTrkg(PROCEDURE 3)".

    //procedure UpdateRelatedItemTrkg();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (WhseActivLine."Serial No." <> '') OR (WhseActivLine."Lot No." <> '') THEN BEGIN
          WhseItemTrkgLine.SETCURRENTKEY("Serial No.","Lot No.");
          WhseItemTrkgLine.SETRANGE("Serial No.",WhseActivLine."Serial No.");
          WhseItemTrkgLine.SETRANGE("Lot No.",WhseActivLine."Lot No.");
        #5..63
          IF WhseItemTrkgLine.FIND('-') THEN
            REPEAT
              ItemTrackingMgt.CalcWhseItemTrkgLine(WhseItemTrkgLine);
              UpdateReservation(WhseActivLine);
              IF ((WhseActivLine."Whse. Document Type" IN
                   [WhseActivLine."Whse. Document Type"::Production,WhseActivLine."Whse. Document Type"::Assembly]) OR
                  (WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::"Invt. Movement")) AND
        #71..74
                WhseItemTrkgLine.MODIFY;
            UNTIL WhseItemTrkgLine.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF WhseActivLine.TrackingExists THEN BEGIN
        #2..66
              UpdateReservation(WhseActivLine,TRUE);
        #68..77
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempWhseActivLine) (VariableCollection) on "CheckReservedItemTrkg(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "CheckReservedItemTrkg(PROCEDURE 7)".

    //procedure CheckReservedItemTrkg();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Activity Type" = "Activity Type"::"Invt. Pick") AND "Assemble to Order" THEN
          EXIT;
        CASE CheckType OF
        #4..30
              Item.CALCFIELDS(Inventory,"Reserved Qty. on Inventory");
              LineReservedQty :=
                WhseAvailMgt.CalcLineReservedQtyOnInvt(
                  "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",TRUE,'',ItemTrkgCode,WhseActivLine);
              ReservEntry.SETCURRENTKEY("Item No.","Variant Code","Location Code","Reservation Status");
              ReservEntry.SETRANGE("Item No.","Item No.");
              ReservEntry.SETRANGE("Variant Code","Variant Code");
        #38..56

              IF (Item.Inventory - ABS(Item."Reserved Qty. on Inventory") +
                  LineReservedQty + AvailQtyFromOtherResvLines +
                  WhseAvailMgt.CalcReservQtyOnPicksShips("Location Code","Item No.","Variant Code",WhseActivLine)) <
                 "Qty. to Handle (Base)"
              THEN
                ERROR(Text017,FIELDCAPTION("Lot No."),ItemTrkgCode);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..33
                  "Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.",TRUE,'',
                  ItemTrkgCode,TempWhseActivLine);
        #35..59
                  WhseAvailMgt.CalcReservQtyOnPicksShips("Location Code","Item No.","Variant Code",TempWhseActivLine)) <
        #61..65
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ActionType) (ParameterCollection) on "DeleteBinContent(PROCEDURE 21)".


    //Unsupported feature: Property Deletion (Local) on "DeleteBinContent(PROCEDURE 21)".



    //Unsupported feature: Code Modification on "DeleteBinContent(PROCEDURE 21)".

    //procedure DeleteBinContent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH WhseActivLine DO BEGIN
          IF "Action Type" <> "Action Type"::Place THEN
            EXIT;

          IF BinContent.GET("Location Code","Bin Code","Item No.","Variant Code","Unit of Measure Code") THEN
            IF NOT BinContent.Fixed THEN BEGIN
              BinContent.CALCFIELDS("Quantity (Base)","Positive Adjmt. Qty. (Base)","Put-away Quantity (Base)");
              IF (BinContent."Quantity (Base)" = 0) AND
                 (BinContent."Positive Adjmt. Qty. (Base)" = 0) AND
                 (BinContent."Put-away Quantity (Base)" - "Qty. Outstanding (Base)" <= 0)
              THEN
                BinContent.DELETE;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Action Type" <> ActionType THEN
          EXIT;

        IF BinContent.GET("Location Code","Bin Code","Item No.","Variant Code","Unit of Measure Code") THEN
          IF NOT BinContent.Fixed THEN BEGIN
            BinContent.CALCFIELDS("Quantity (Base)","Positive Adjmt. Qty. (Base)","Put-away Quantity (Base)");
            IF (BinContent."Quantity (Base)" = 0) AND
               (BinContent."Positive Adjmt. Qty. (Base)" = 0) AND
               (BinContent."Put-away Quantity (Base)" - "Qty. Outstanding (Base)" <= 0)
            THEN
              BinContent.DELETE;
          END;
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Deletion) (ParameterCollection) on "UpdateReservation(PROCEDURE 90)".


    //Unsupported feature: Property Insertion (Local) on "UpdateReservation(PROCEDURE 90)".



    //Unsupported feature: Code Modification on "UpdateReservation(PROCEDURE 90)".

    //procedure UpdateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH TempWhseActivLine2 DO BEGIN
          IF ("Action Type" <> "Action Type"::Take) AND ("Breakbulk No." = 0) AND
             ("Whse. Document Type" = "Whse. Document Type"::Shipment)
        #4..15
            TempTrackingSpecification.INSERT;
          END;
          ItemTrackingMgt.SetPick("Activity Type" = "Activity Type"::Pick);
          ItemTrackingMgt.SynchronizeWhseItemTracking(TempTrackingSpecification,'');
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
          ItemTrackingMgt.SynchronizeWhseItemTracking(TempTrackingSpecification,'',Deletion);
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "TransferAllButWhseDocDetailsFromAssemblyLine(PROCEDURE 31)".

    //procedure TransferAllButWhseDocDetailsFromAssemblyLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Activity Type" := "Activity Type"::Pick;
        "Source Type" := DATABASE::"Assembly Line";
        "Source Subtype" := AssemblyLine."Document Type";
        #4..12
        AsmHeader.GET(AssemblyLine."Document Type",AssemblyLine."Document No.");
        AsmHeader.CALCFIELDS("Assemble to Order");
        "Assemble to Order" := AsmHeader."Assemble to Order";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..15
        "ATO Component" := TRUE;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckSNSpecificationExists(PROCEDURE 30)".



    //Unsupported feature: Code Modification on "InitTrackingSpecFromWhseActivLine(PROCEDURE 37)".

    //procedure InitTrackingSpecFromWhseActivLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH WhseActivityLine DO BEGIN
          TrackingSpecification.INIT;
          TrackingSpecification."Source Type" := "Source Type";
        #4..9
          TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
          TrackingSpecification."Serial No." := "Serial No.";
          TrackingSpecification."Lot No." := "Lot No.";
          TrackingSpecification."Bin Code" := "Bin Code";
          TrackingSpecification."Source Batch Name" := '';
          TrackingSpecification."Source Prod. Order Line" := "Source Subline No.";
          TrackingSpecification."Source Ref. No." := "Source Line No.";
          TrackingSpecification."Qty. to Handle (Base)" := "Qty. to Handle (Base)";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
          TrackingSpecification."Expiration Date" := "Expiration Date";
        #13..18
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: CheckGlobalEntrySummary) (VariableCollection) on "FindLotNoBySerialNo(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "FindLotNoBySerialNo(PROCEDURE 32)".

    //procedure FindLotNoBySerialNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InitTrackingSpecFromWhseActivLine(TempTrackingSpecification,Rec);

        VALIDATE("Lot No.",ItemTrackingDataCollection.FindLotNoBySN(TempTrackingSpecification));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        InitTrackingSpecFromWhseActivLine(TempTrackingSpecification,Rec);
        CheckGlobalEntrySummary :=
          ("Activity Type" <> "Activity Type"::"Put-away") AND
          (NOT ("Source Document" IN
                ["Source Document"::"Purchase Order","Source Document"::"Prod. Output","Source Document"::"Assembly Order"]));
        VALIDATE("Lot No.",ItemTrackingDataCollection.FindLotNoBySN(TempTrackingSpecification,CheckGlobalEntrySummary));
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Direction) (VariableCollection) on "CheckInvalidBinCode(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "CheckInvalidBinCode(PROCEDURE 33)".

    //procedure CheckInvalidBinCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Location.GET("Location Code");
        IF ("Action Type" = 0) OR (NOT Location."Bin Mandatory") THEN
          EXIT;
        WhseActivLine.SETRANGE("Activity Type","Activity Type");
        WhseActivLine.SETRANGE("No.","No.");
        WhseActivLine.SETRANGE("Whse. Document Line No.","Whse. Document Line No.");
        WhseActivLine.SETFILTER("Action Type",'<>%1',"Action Type");
        IF WhseActivLine.FINDFIRST THEN BEGIN
          IF ("Location Code" = WhseActivLine."Location Code") AND ("Bin Code" = WhseActivLine."Bin Code") THEN
            ERROR(Text019,FORMAT("Action Type"),FORMAT(WhseActivLine."Action Type"),Location.Code);

          IF (("Activity Type" = "Activity Type"::"Put-away") AND ("Action Type" = "Action Type"::Place) AND
              Location.IsBWReceive OR ("Activity Type" = "Activity Type"::Pick) AND
              ("Action Type" = "Action Type"::Take) AND Location.IsBWShip) AND Location.IsBinBWReceiveOrShip("Bin Code")
          THEN
            ERROR(Text020,FORMAT("Action Type"),Location.Code);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        WhseActivLine := Rec;
        #4..7
        IF "Action Type" = "Action Type"::Take THEN
          Direction := '>'
        ELSE
          Direction := '<';
        IF WhseActivLine.FIND(Direction) THEN BEGIN
          IF ("Location Code" = WhseActivLine."Location Code") AND
             ("Bin Code" = WhseActivLine."Bin Code") AND
             ("Unit of Measure Code" = WhseActivLine."Unit of Measure Code")
          THEN
        #10..17
        */
    //end;

    local procedure RegisteredWhseActLineIsEmpty(): Boolean
    var
        RegisteredWhseActivityLine: Record "5773";
    begin
        RegisteredWhseActivityLine.SETRANGE("Activity Type","Activity Type"::Pick);
        RegisteredWhseActivityLine.SETRANGE("Source No.","Source No.");
        RegisteredWhseActivityLine.SETRANGE("Source Line No.","Source Line No.");
        RegisteredWhseActivityLine.SETRANGE("Source Type","Source Type");
        RegisteredWhseActivityLine.SETRANGE("Source Subtype","Source Subtype");
        RegisteredWhseActivityLine.SETRANGE("Lot No.","Lot No.");
        RegisteredWhseActivityLine.SETRANGE("Serial No.","Serial No.");
        EXIT(RegisteredWhseActivityLine.ISEMPTY);
    end;

    procedure TrackingExists(): Boolean
    begin
        EXIT(("Lot No." <> '') OR ("Serial No." <> ''));
    end;

    procedure SetSourceFilter()
    begin
        SETCURRENTKEY("Source Type","Source Subtype","Source No.","Source Line No.","Source Subline No.");
        SETRANGE("Source Type","Source Type");
        SETRANGE("Source Subtype","Source Subtype");
        SETRANGE("Source No.","Source No.");
        SETRANGE("Source Line No.","Source Line No.");
        SETRANGE("Source Subline No.","Source Subline No.");
        SETRANGE("Source Document","Source Document");
    end;

    local procedure ReNumberAllLines(var NewWhseActivityLine: Record "5767";OldLineNo: Integer;var NewLineNo: Integer)
    var
        WarehouseActivityLine: Record "5767";
        LineNo: Integer;
    begin
        LineNo := 10000 * NewWhseActivityLine.COUNT;
        NewWhseActivityLine.FIND('+');
        REPEAT
          WarehouseActivityLine := NewWhseActivityLine;
          NewWhseActivityLine.DELETE;
          NewWhseActivityLine := WarehouseActivityLine;
          NewWhseActivityLine."Line No." := LineNo;
          NewWhseActivityLine.INSERT;

          IF WarehouseActivityLine."Line No." = OldLineNo THEN
            NewLineNo := LineNo;
          LineNo -= 10000;
        UNTIL NewWhseActivityLine.NEXT(-1) = 0;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "CheckReservedItemTrkg(PROCEDURE 7).WhseActivLine(Variable 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "DeleteBinContent(PROCEDURE 21).WhseActivLine(Parameter 1001)".


    //Unsupported feature: Property Deletion (PasteIsValid).


    var
        RecLUserSetup: Record "91";
        CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
        CstL002: Label 'Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée.';
}

