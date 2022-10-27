tableextension 50062 tableextension50062 extends "Warehouse Activity Header"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>> CNE4.02
    // C:FE10 01.11.2011 : Invt. Pick - Direct Sales
    //                   - Add Field 50000 Sales Counter
    //                   - TestField Source Document - OnValidate()
    LookupPageID = 5774;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 10)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Lines"(Field 13)".

        modify("Last Registering No.")
        {
            TableRelation = IF (Type = CONST (Put-away)) "Registered Whse. Activity Hdr.".No. WHERE (Type=CONST(Put-away))
                            ELSE IF (Type=CONST(Pick)) "Registered Whse. Activity Hdr.".No. WHERE (Type=CONST(Pick))
                            ELSE IF (Type=CONST(Movement)) "Registered Whse. Activity Hdr.".No. WHERE (Type=CONST(Movement));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Breakbulk Filter"(Field 7305)".

        modify("Destination No.")
        {
            TableRelation = IF (Destination Type=CONST(Vendor)) Vendor
                            ELSE IF (Destination Type=CONST(Customer)) Customer
                            ELSE IF (Destination Type=CONST(Location)) Location
                            ELSE IF (Destination Type=CONST(Item)) Item
                            ELSE IF (Destination Type=CONST(Family)) Family
                            ELSE IF (Destination Type=CONST(Sales Order)) "Sales Header".No. WHERE (Document Type=CONST(Order));
        }


        //Unsupported feature: Code Modification on ""Location Code"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Location Code" <> '' THEN
          IF NOT WMSManagement.LocationIsAllowed("Location Code") THEN
            ERROR(STRSUBSTNO(Text001,USERID) + STRSUBSTNO(' %1 %2.',FIELDCAPTION("Location Code"),"Location Code"));

        GetLocation("Location Code");
        CASE Type OF
          Type::"Invt. Put-away":
            IF Location.RequireReceive("Location Code") THEN
              Location.TESTFIELD("Require Receive",FALSE);
          Type::"Invt. Pick":
            IF Location.RequireShipment("Location Code") THEN
              Location.TESTFIELD("Require Shipment",FALSE);
          Type::"Invt. Movement":
            Location.TESTFIELD("Directed Put-away and Pick",FALSE);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
            IF Location.RequireReceive("Location Code") AND ("Source Document" <> "Source Document"::"Prod. Output") THEN
              VALIDATE("Source Document","Source Document"::"Prod. Output");
        #10..15
        */
        //end;


        //Unsupported feature: Code Modification on ""Source Document"(Field 7307).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Source Document" <> xRec."Source Document" THEN BEGIN
          IF LineExist THEN
            ERROR(Text002,FIELDCAPTION("Source Document"));
          "Source No." := '';
          ClearDestinationFields;
        END;

        CASE "Source Document" OF
        #9..19
            BEGIN
              "Source Type" := 37;
              "Source Subtype" := 1;
            END;
          "Source Document"::"Sales Return Order":
            BEGIN
        #26..56
          "Source Type" := 0;
          "Source Subtype" := 0;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Source Document" <> xRec."Source Document" THEN BEGIN
          //>>MIGRATION NAV 2013
          //>> C:FE10
          TESTFIELD("Sales Counter",FALSE);
          //<<MIGRATION NAV2013
        #2..5
          IF Type = Type::"Invt. Put-away" THEN BEGIN
            GetLocation("Location Code");
            IF Location.RequireReceive("Location Code") THEN
              TESTFIELD("Source Document","Source Document"::"Prod. Output");
          END;
        #6..22
              "Destination Type" := "Destination Type"::Customer;
        #23..59
        */
        //end;


        //Unsupported feature: Code Insertion on ""Destination No."(Field 7311)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //>>MIGRATION NAV 2013
        //>> C:FE10
        CASE "Destination Type" OF
          "Destination Type"::Customer:
            BEGIN
              Customer.GET("Destination No.");
              CASE Customer.Blocked OF
                1,3:
                Customer.TESTFIELD(Blocked,0);
              END;
          END;
        END;
        */
        //end;
        field(50000; "Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter';
            Description = 'CNE4.01';

            trigger OnValidate()
            begin
                IF "Sales Counter" THEN BEGIN
                    TESTFIELD("Source Document", "Source Document"::"Sales Order");
                    TESTFIELD("Source No.", '');
                    IF LineExist THEN
                        ERROR(Text002, FIELDCAPTION("Sales Counter"));
                    VALIDATE("Posting Date", WORKDATE);
                END;
            end;
        }
        field(50001; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(50002; "Destination Name"; Text[50])
        {
            Caption = 'Destination Name.';
        }
        field(50003; "Destination Name 2"; Text[50])
        {
            Caption = 'Destination Name 2';
        }
        field(50004; Comments; Text[50])
        {
            Caption = 'Comments';
        }
        field(50403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'CN4.01';

            trigger OnLookup()
            var
                WMSManagement: Codeunit "7302";
                BinCode: Code[20];
            begin
                //>> C:FE09 Begin
                BinCode := WMSManagement.BinLookUp("Location Code", '', '', '');

                IF BinCode <> '' THEN
                    VALIDATE("Bin Code", BinCode);
                //<< End
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "7302";
            begin
                //>> C:FE09 Begin
                IF xRec."Bin Code" <> "Bin Code" THEN BEGIN
                END;

                IF "Bin Code" <> '' THEN BEGIN
                    TESTFIELD(Type, Type::"Invt. Pick");
                    GetLocation("Location Code");
                    TESTFIELD("Location Code");
                    Location.GET("Location Code");
                    Location.TESTFIELD("Bin Mandatory");
                END;
                //>> End
            end;
        }
    }


    //Unsupported feature: Code Modification on "SortWhseDoc(PROCEDURE 3)".

    //procedure SortWhseDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseActivLine2.LOCKTABLE;
    WhseActivLine2.SETRANGE("Activity Type",Type);
    WhseActivLine2.SETRANGE("No.","No.");
    CASE "Sorting Method" OF
      "Sorting Method"::Item:
        WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Item No.");
      "Sorting Method"::Document:
        WhseActivLine2.SETCURRENTKEY(
          "Activity Type","No.","Location Code","Source Document","Source No.");
      "Sorting Method"::"Shelf or Bin":
        BEGIN
          GetLocation("Location Code");
          IF Location."Bin Mandatory" THEN BEGIN
            WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Bin Code");
            IF WhseActivLine2.FIND('-') THEN
              IF WhseActivLine2."Activity Type" <> WhseActivLine2."Activity Type"::Pick
              THEN BEGIN
                SequenceNo := 10000;
                WhseActivLine2.SETRANGE("Action Type",WhseActivLine2."Action Type"::Place);
                WhseActivLine2.SETRANGE("Breakbulk No.",0);
                IF WhseActivLine2.FIND('-') THEN
                  REPEAT
                    TempWhseActivLine.INIT;
                    TempWhseActivLine.COPY(WhseActivLine2);
                    TempWhseActivLine.INSERT;
                  UNTIL WhseActivLine2.NEXT = 0;
                TempWhseActivLine.SETRANGE("Breakbulk No.",0);
                IF TempWhseActivLine.FIND('-') THEN
                  REPEAT
                    WhseActivLine2.SETRANGE("Breakbulk No.",0);
                    WhseActivLine2.SETRANGE(
                      "Action Type",WhseActivLine2."Action Type"::Take);
                    WhseActivLine2.SETRANGE(
                      "Whse. Document Type",TempWhseActivLine."Whse. Document Type");
                    WhseActivLine2.SETRANGE(
                      "Whse. Document No.",TempWhseActivLine."Whse. Document No.");
                    WhseActivLine2.SETRANGE(
                      "Whse. Document Line No.",TempWhseActivLine."Whse. Document Line No.");
                    IF WhseActivLine2.FIND('-') THEN
                      REPEAT
                        SortTakeLines(WhseActivLine2,SequenceNo);
                        WhseActivLine3.GET(
                          TempWhseActivLine."Activity Type",
                          TempWhseActivLine."No.",TempWhseActivLine."Line No.");
                        WhseActivLine3."Sorting Sequence No." := SequenceNo;
                        WhseActivLine3.MODIFY;
                        SequenceNo := SequenceNo + 10000;
                      UNTIL WhseActivLine2.NEXT = 0;
                  UNTIL TempWhseActivLine.NEXT = 0;
              END ELSE BEGIN
                SortLinesBinShelf(WhseActivLine2,SequenceNo,SortingOrder::Bin);
                WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Sorting Sequence No.");
              END;
          END ELSE BEGIN
            SortLinesBinShelf(WhseActivLine2,SequenceNo,SortingOrder::Shelf);
            WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Sorting Sequence No.");
          END;
        END;
      "Sorting Method"::"Due Date":
        WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Due Date");
      "Sorting Method"::"Ship-To":
        WhseActivLine2.SETCURRENTKEY(
          "Activity Type","No.","Destination Type","Destination No.");
      "Sorting Method"::"Bin Ranking":
        BEGIN
          WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Bin Ranking");
          WhseActivLine2.SETRANGE("Breakbulk No.",0);
          IF WhseActivLine2.FIND('-') THEN BEGIN
            SequenceNo := 10000;
            WhseActivLine2.SETRANGE("Action Type",WhseActivLine2."Action Type"::Take);
            IF WhseActivLine2.FIND('-') THEN
              REPEAT
                WhseActivLine3.COPY(WhseActivLine2);
                WhseActivLine3.SETRANGE("Bin Code",WhseActivLine2."Bin Code");
                WhseActivLine3.SETFILTER("Breakbulk No.",'<>0');
                WhseActivLine3.SETRANGE(
                  "Whse. Document Type",WhseActivLine2."Whse. Document Type");
                WhseActivLine3.SETRANGE(
                  "Whse. Document No.",WhseActivLine2."Whse. Document No.");
                WhseActivLine3.SETRANGE(
                  "Whse. Document Line No.",WhseActivLine2."Whse. Document Line No.");
                IF WhseActivLine3.FIND('-') THEN
                  REPEAT
                    WhseActivLine3."Sorting Sequence No." := SequenceNo;
                    WhseActivLine3.MODIFY;
                    SequenceNo := SequenceNo + 10000;
                    BreakBulkWhseActivLine.COPY(WhseActivLine3);
                    BreakBulkWhseActivLine.SETRANGE("Action Type",WhseActivLine3."Action Type"::Place);
                    BreakBulkWhseActivLine.SETRANGE("Breakbulk No.",WhseActivLine3."Breakbulk No.");
                    IF BreakBulkWhseActivLine.FIND('-') THEN
                      REPEAT
                        BreakBulkWhseActivLine."Sorting Sequence No." := SequenceNo;
                        BreakBulkWhseActivLine.MODIFY;
                        SequenceNo := SequenceNo + 10000;
                      UNTIL BreakBulkWhseActivLine.NEXT = 0;
                  UNTIL WhseActivLine3.NEXT = 0;
                WhseActivLine2."Sorting Sequence No." := SequenceNo;
                WhseActivLine2.MODIFY;
                SequenceNo := SequenceNo + 10000;
              UNTIL WhseActivLine2.NEXT = 0;
            WhseActivLine2.SETRANGE("Action Type",WhseActivLine2."Action Type"::Place);
            WhseActivLine2.SETRANGE("Breakbulk No.",0);
            IF WhseActivLine2.FIND('-') THEN
              REPEAT
                WhseActivLine2."Sorting Sequence No." := SequenceNo;
                WhseActivLine2.MODIFY;
                SequenceNo := SequenceNo + 10000;
              UNTIL WhseActivLine2.NEXT = 0;
          END;
        END;
      "Sorting Method"::"Action Type":
        BEGIN
          WhseActivLine2.SETCURRENTKEY("Activity Type","No.","Action Type","Bin Code");
          WhseActivLine2.SETRANGE("Action Type",WhseActivLine2."Action Type"::Take);
          IF WhseActivLine2.FIND('-') THEN BEGIN
            SequenceNo := 10000;
            REPEAT
              WhseActivLine2."Sorting Sequence No." := SequenceNo;
              WhseActivLine2.MODIFY;
              SequenceNo := SequenceNo + 10000;
              IF WhseActivLine2."Breakbulk No." <> 0 THEN BEGIN
                WhseActivLine3.COPY(WhseActivLine2);
                WhseActivLine3.SETRANGE("Action Type",WhseActivLine2."Action Type"::Place);
                WhseActivLine3.SETRANGE("Breakbulk No.",WhseActivLine2."Breakbulk No.");
                IF WhseActivLine3.FIND('-') THEN
                  REPEAT
                    WhseActivLine3."Sorting Sequence No." := SequenceNo;
                    WhseActivLine3.MODIFY;
                    SequenceNo := SequenceNo + 10000;
                  UNTIL WhseActivLine3.NEXT = 0;
              END;
            UNTIL WhseActivLine2.NEXT = 0;
          END;
          WhseActivLine2.SETRANGE("Action Type",WhseActivLine2."Action Type"::Place);
          WhseActivLine2.SETRANGE("Breakbulk No.",0);
          IF WhseActivLine2.FIND('-') THEN
            REPEAT
              WhseActivLine2."Sorting Sequence No." := SequenceNo;
              WhseActivLine2.MODIFY;
              SequenceNo := SequenceNo + 10000;
            UNTIL WhseActivLine2.NEXT = 0;
        END;
    END;

    IF SequenceNo = 0 THEN BEGIN
      WhseActivLine2.SETRANGE("Breakbulk No.",0);
      IF WhseActivLine2.FIND('-') THEN BEGIN
        SequenceNo := 10000;
        REPEAT
          WhseActivLine3.COPY(WhseActivLine2);
          WhseActivLine3.SETRANGE("Bin Code",WhseActivLine2."Bin Code");
          WhseActivLine3.SETFILTER("Breakbulk No.",'<>0');
          WhseActivLine3.SETRANGE(
            "Whse. Document Type",WhseActivLine2."Whse. Document Type");
          WhseActivLine3.SETRANGE(
            "Whse. Document No.",WhseActivLine2."Whse. Document No.");
          WhseActivLine3.SETRANGE(
            "Whse. Document Line No.",WhseActivLine2."Whse. Document Line No.");
          IF WhseActivLine3.FIND('-') THEN
            REPEAT
              WhseActivLine3."Sorting Sequence No." := SequenceNo;
              WhseActivLine3.MODIFY;
              SequenceNo := SequenceNo + 10000;
            UNTIL WhseActivLine3.NEXT = 0;

          WhseActivLine2."Sorting Sequence No." := SequenceNo;
          WhseActivLine2.MODIFY;
          SequenceNo := SequenceNo + 10000;
        UNTIL WhseActivLine2.NEXT = 0;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..72
                SetActivityFilter(WhseActivLine2,WhseActivLine3);
    #82..149
          SetActivityFilter(WhseActivLine2,WhseActivLine3);
    #159..171
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "SortLinesBinShelf(PROCEDURE 12)".


    //Unsupported feature: Property Insertion (Local) on "DeleteWhseActivHeader(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ErrorIfUserIsNotWhseEmployee(PROCEDURE 15)".

    //procedure ErrorIfUserIsNotWhseEmployee();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF USERID <> '' THEN BEGIN
      WhseEmployee.SETRANGE("User ID",USERID);
      IF NOT WhseEmployee.FINDFIRST THEN
        ERROR(Text001,USERID);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF USERID <> '' THEN BEGIN
      WhseEmployee.SETRANGE("User ID",USERID);
      IF WhseEmployee.ISEMPTY THEN
        ERROR(Text001,USERID);
    END;
    */
    //end;

    local procedure SetActivityFilter(var WhseActivLineFrom: Record "5767"; var WhseActivLineTo: Record "5767")
    begin
        WhseActivLineTo.COPY(WhseActivLineFrom);
        WhseActivLineTo.SETRANGE("Bin Code", WhseActivLineFrom."Bin Code");
        WhseActivLineTo.SETFILTER("Breakbulk No.", '<>0');
        WhseActivLineTo.SETRANGE("Whse. Document Type", WhseActivLineFrom."Whse. Document Type");
        WhseActivLineTo.SETRANGE("Whse. Document No.", WhseActivLineFrom."Whse. Document No.");
        WhseActivLineTo.SETRANGE("Whse. Document Line No.", WhseActivLineFrom."Whse. Document Line No.");
    end;

    var
        Customer: Record "18";
}

