tableextension 50076 tableextension50076 extends "Warehouse Journal Line"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    //                   - Add Field 50046 Whse. Document Type 2
    //                   - Add Field 50047 Whse. Document No. 2
    //                   - Add Field 50048 Whse. Document Line No. 2
    LookupPageID = 7319;
    DrillDownPageID = 7319;
    fields
    {
        modify("From Bin Code")
        {
            TableRelation = IF (Phys. Inventory=CONST(No),
                                Item No.=FILTER(''),
                                From Zone Code=FILTER('')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code))
                                ELSE IF (Phys. Inventory=CONST(No),
                                         Item No.=FILTER(<>''),
                                         From Zone Code=FILTER('')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                    Item No.=FIELD(Item No.))
                                                                                                    ELSE IF (Phys. Inventory=CONST(No),
                                                                                                             Item No.=FILTER(''),
                                                                                                             From Zone Code=FILTER(<>'')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                          Zone Code=FIELD(From Zone Code))
                                                                                                                                                                          ELSE IF (Phys. Inventory=CONST(No),
                                                                                                                                                                                   Item No.=FILTER(<>''),
                                                                                                                                                                                   From Zone Code=FILTER(<>'')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                                                                                                Item No.=FIELD(Item No.),
                                                                                                                                                                                                                                                Zone Code=FIELD(From Zone Code))
                                                                                                                                                                                                                                                ELSE IF (Phys. Inventory=CONST(Yes),
                                                                                                                                                                                                                                                         From Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                                                                                                                                                                                                                                                         ELSE IF (Phys. Inventory=CONST(Yes),
                                                                                                                                                                                                                                                                  From Zone Code=FILTER(<>'')) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                                                                                                                                                                               Zone Code=FIELD(From Zone Code));
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Bin Code")
        {
            TableRelation = IF (Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                            ELSE IF (Zone Code=FILTER(<>'')) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                             Zone Code=FIELD(Zone Code));
        }
        modify("To Bin Code")
        {
            TableRelation = IF (To Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                            ELSE IF (To Zone Code=FILTER(<>'')) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                                Zone Code=FIELD(To Zone Code));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Phys Invt Counting Period Type"(Field 7381)".



        //Unsupported feature: Code Modification on ""From Bin Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PhysInvtEntered THEN
              TESTFIELD("Phys. Inventory",FALSE);

            #4..8
              GetBinType("Location Code","From Bin Code");

            Bin.CALCFIELDS("Adjustment Bin");
            Bin.TESTFIELD("Adjustment Bin",FALSE);

            IF "From Bin Code" <> '' THEN
              "From Zone Code" := Bin."Zone Code";
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..11
            IF Bin."Adjustment Bin" AND ("Entry Type" <> "Entry Type"::"Positive Adjmt.") THEN
              Bin.FIELDERROR("Adjustment Bin");
            #13..15
            */
        //end;


        //Unsupported feature: Code Modification on ""To Bin Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PhysInvtEntered THEN
              TESTFIELD("Phys. Inventory",FALSE);

            #4..7
            GetBin("Location Code","To Bin Code");

            Bin.CALCFIELDS("Adjustment Bin");
            Bin.TESTFIELD("Adjustment Bin",FALSE);

            IF "To Bin Code" <> '' THEN
              "To Zone Code" := Bin."Zone Code";
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            IF Bin."Adjustment Bin" AND ("Entry Type" <> "Entry Type"::"Negative Adjmt.") THEN
              Bin.FIELDERROR("Adjustment Bin");
            #12..14
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PhysInvtEntered THEN
              TESTFIELD("Phys. Inventory",FALSE);

            IF "Item No." <> '' THEN BEGIN
              GetItemUnitOfMeasure;
              "Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";
              CheckBin("Location Code","From Bin Code",FALSE);
              CheckBin("Location Code","To Bin Code",TRUE);
            END ELSE
              "Qty. per Unit of Measure" := 1;
            VALIDATE(Quantity);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
              TESTFIELD("Unit of Measure Code");
            #5..11
            */
        //end;
        field(50046;"Whse. Document Type 2";Option)
        {
            Caption = 'Whse. Document Type';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ' ,Invt. Pick';
            OptionMembers = " ","Invt. Pick";
        }
        field(50047;"Whse. Document No. 2";Code[20])
        {
            Caption = 'Whse. Document No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF (Whse. Document Type 2=CONST(Invt. Pick)) "Warehouse Activity Header".No. WHERE (Type=CONST(Invt. Pick));
        }
        field(50048;"Whse. Document Line No. 2";Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50050;"Source Type 2";Integer)
        {
            Caption = 'Source Type 2';
            Description = 'CNE4.02';
        }
        field(50051;"Source Subtype 2";Option)
        {
            Caption = 'Source Subtype';
            Description = 'CNE4.02';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(50052;"Source No. 2";Code[20])
        {
            Caption = 'Source No. 2';
            Description = 'CNE4.02';
        }
        field(50053;"Source Line No. 2";Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No. 2';
            Description = 'CNE4.02';
        }
    }


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 8)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseJnlTemplate.GET("Journal Template Name");
        WhseJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        WhseJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        #4..24
        "Source Code" := WhseJnlTemplate."Source Code";
        "Reason Code" := WhseJnlBatch."Reason Code";
        "Registering No. Series" := WhseJnlBatch."Registering No. Series";
        Location.GET("Location Code");
        IF WhseJnlTemplate.Type <> WhseJnlTemplate.Type::Reclassification THEN BEGIN
          IF Quantity >= 0 THEN
            "Entry Type" := "Entry Type"::"Positive Adjmt."
          ELSE
            "Entry Type" := "Entry Type"::"Negative Adjmt.";
          GetBin(Location.Code,Location."Adjustment Bin Code");
          "From Zone Code" := Bin."Zone Code";
          "From Bin Code" := Bin.Code;
          "From Bin Type Code" := Bin."Bin Type Code";
        END ELSE
          "Entry Type" := "Entry Type"::Movement;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..27
        #29..33
          SetUpAdjustmentBin;
        END ELSE
          "Entry Type" := "Entry Type"::Movement;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CalcQty(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ExchangeFromToBin(PROCEDURE 16)".

    //procedure ExchangeFromToBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetLocation("Location Code");
        WhseJnlLine := Rec;
        "From Zone Code" := WhseJnlLine."To Zone Code";
        #4..20
            "Entry Type" := "Entry Type"::"Positive Adjmt."
          ELSE
            "Entry Type" := "Entry Type"::"Negative Adjmt.";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..23
          SetUpAdjustmentBin;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "GetBin(PROCEDURE 19)".

    //procedure GetBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (LocationCode = '') OR (BinCode = '') THEN
          Bin.INIT
        ELSE
          IF (Bin."Location Code" <> LocationCode) OR
             (Bin.Code <> BinCode)
          THEN
            Bin.GET(LocationCode,BinCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF (LocationCode = '') OR (BinCode = '') THEN
          CLEAR(Bin)
        #3..7
        */
    //end;


    //Unsupported feature: Code Modification on "OpenJnl(PROCEDURE 12)".

    //procedure OpenJnl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckWhseEmployee;
        CheckTemplateName(
          WhseJnlLine.GETRANGEMAX("Journal Template Name"),CurrentLocationCode,CurrentJnlBatchName);
        WhseJnlLine.FILTERGROUP := 2;
        WhseJnlLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
        IF CurrentLocationCode <> '' THEN
          WhseJnlLine.SETRANGE("Location Code",CurrentLocationCode);
        WhseJnlLine.FILTERGROUP := 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WMSMgt.CheckUserIsWhseEmployee;
        #2..8
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckTemplateName(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "CheckTemplateName(PROCEDURE 11)".

    //procedure CheckTemplateName();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseJnlBatch.SETRANGE("Journal Template Name",CurrentJnlTemplateName);
        IF NOT WhseJnlBatch.GET(CurrentJnlTemplateName,CurrentJnlBatchName,CurrentLocationCode) OR
           NOT WhseEmployee.GET(USERID,CurrentLocationCode)
        THEN BEGIN
          IF USERID <> '' THEN BEGIN
            CurrentLocationCode := WmsMgt.GetDefaultLocation;
            WhseJnlBatch.SETRANGE("Location Code",CurrentLocationCode);
          END;
          IF WhseJnlBatch.ISEMPTY THEN BEGIN
            WhseJnlBatch.INIT;
            WhseJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
            WhseJnlBatch.SetupNewBatch;
            WhseJnlBatch.Name := Text002;
            WhseJnlBatch.Description := Text003;
            WhseJnlBatch.INSERT(TRUE);
            CurrentLocationCode := WhseJnlBatch."Location Code";
            COMMIT;
          END;
          CurrentJnlBatchName := WhseJnlBatch.Name;
          CurrentLocationCode := WhseJnlBatch."Location Code";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrentLocationCode := WMSMgt.GetDefaultDirectedPutawayAndPickLocation;

        WhseJnlBatch.SETRANGE("Journal Template Name",CurrentJnlTemplateName);
        WhseJnlBatch.SETRANGE("Location Code",CurrentLocationCode);
        WhseJnlBatch.SETRANGE(Name,CurrentJnlBatchName);
        IF NOT WhseJnlBatch.ISEMPTY THEN
          EXIT;

        WhseJnlBatch.SETRANGE(Name);
        IF NOT WhseJnlBatch.FINDFIRST THEN BEGIN
          WhseJnlBatch.INIT;
          WhseJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
          WhseJnlBatch.SetupNewBatch;
          WhseJnlBatch."Location Code" := CurrentLocationCode;
          WhseJnlBatch.Name := Text002;
          WhseJnlBatch.Description := Text003;
          WhseJnlBatch.INSERT(TRUE);
          COMMIT;
        END;
        CurrentJnlBatchName := WhseJnlBatch.Name;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WhseWkshLine) (VariableCollection) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Variable Insertion (Variable: WhseItemTrackingLines) (VariableCollection) on "OpenItemTrackingLines(PROCEDURE 6500)".



    //Unsupported feature: Code Modification on "OpenItemTrackingLines(PROCEDURE 6500)".

    //procedure OpenItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Item No.");
        TESTFIELD("Qty. (Base)");
        TempWhseWkshLine.INIT;
        TempWhseWkshLine."Worksheet Template Name" := "Journal Template Name";
        TempWhseWkshLine.Name := "Journal Batch Name";
        TempWhseWkshLine."Location Code" := "Location Code";
        TempWhseWkshLine."Line No." := "Line No.";
        TempWhseWkshLine."Item No." := "Item No.";
        TempWhseWkshLine."Variant Code" := "Variant Code";
        TempWhseWkshLine."Qty. (Base)" := "Qty. (Base)";
        TempWhseWkshLine."Qty. to Handle (Base)" := "Qty. (Base)";
        WhseItemTrackingForm.SetSource(TempWhseWkshLine,DATABASE::"Warehouse Journal Line");
        WhseItemTrackingForm.RUNMODAL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Item No.");
        TESTFIELD("Qty. (Base)");
        WhseWkshLine.INIT;
        WhseWkshLine."Worksheet Template Name" := "Journal Template Name";
        WhseWkshLine.Name := "Journal Batch Name";
        WhseWkshLine."Location Code" := "Location Code";
        WhseWkshLine."Line No." := "Line No.";
        WhseWkshLine."Item No." := "Item No.";
        WhseWkshLine."Variant Code" := "Variant Code";
        WhseWkshLine."Qty. (Base)" := "Qty. (Base)";
        WhseWkshLine."Qty. to Handle (Base)" := "Qty. (Base)";
        WhseItemTrackingLines.SetSource(WhseWkshLine,DATABASE::"Warehouse Journal Line");
        WhseItemTrackingLines.RUNMODAL;
        CLEAR(WhseItemTrackingLines);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ItemTrackingExist(PROCEDURE 17)".


    procedure SetUpAdjustmentBin()
    var
        Location: Record "14";
    begin
        WhseJnlTemplate.GET("Journal Template Name");
        IF WhseJnlTemplate.Type = WhseJnlTemplate.Type::Reclassification THEN
          EXIT;

        Location.GET("Location Code");
        GetBin(Location.Code,Location."Adjustment Bin Code");
        CASE "Entry Type" OF
          "Entry Type"::"Positive Adjmt.":
            BEGIN
              "From Zone Code" := Bin."Zone Code";
              "From Bin Code" := Bin.Code;
              "From Bin Type Code" := Bin."Bin Type Code";
            END;
          "Entry Type"::"Negative Adjmt.":
            BEGIN
              "To Zone Code" := Bin."Zone Code";
              "To Bin Code" := Bin.Code;
            END;
        END;
    end;

    procedure IsOpenedFromBatch(): Boolean
    var
        WarehouseJournalBatch: Record "7310";
        TemplateFilter: Text;
        BatchFilter: Text;
    begin
        BatchFilter := GETFILTER("Journal Batch Name");
        IF BatchFilter <> '' THEN BEGIN
          TemplateFilter := GETFILTER("Journal Template Name");
          IF TemplateFilter <> '' THEN
            WarehouseJournalBatch.SETFILTER("Journal Template Name",TemplateFilter);
          WarehouseJournalBatch.SETFILTER(Name,BatchFilter);
          WarehouseJournalBatch.FINDFIRST;
        END;

        EXIT((("Journal Batch Name" <> '') AND ("Journal Template Name" = '')) OR (BatchFilter <> ''));
    end;

    //Unsupported feature: Deletion (VariableCollection) on "SetUpNewLine(PROCEDURE 8).Location(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckTemplateName(PROCEDURE 11).WhseEmployee(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckTemplateName(PROCEDURE 11).WmsMgt(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenItemTrackingLines(PROCEDURE 6500).TempWhseWkshLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenItemTrackingLines(PROCEDURE 6500).WhseItemTrackingForm(Variable 1001)".

}

