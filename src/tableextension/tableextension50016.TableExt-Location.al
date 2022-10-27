tableextension 50016 tableextension50016 extends Location
{
    LookupPageID = 15;
    DrillDownPageID = 15;
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("Post Code")
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("E-Mail")
        {
            Caption = 'Email';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use As In-Transit"(Field 5724)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Require Put-away"(Field 5726)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Require Pick"(Field 5727)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Dock Due Date Calc."(Field 5728)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Cross-Docking"(Field 5729)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Require Receive"(Field 5730)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Require Shipment"(Field 5731)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bin Mandatory"(Field 5732)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Directed Put-away and Pick"(Field 5733)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Default Bin Selection"(Field 5734)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Put-away Worksheet"(Field 7306)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Pick According to FEFO"(Field 7307)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Allow Breakbulk"(Field 7308)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bin Capacity Policy"(Field 7309)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Always Create Put-away Line"(Field 7319)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Always Create Pick Line"(Field 7320)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Equipment"(Field 7321)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use ADCS"(Field 7700)".


        //Unsupported feature: Code Modification on ""Require Put-away"(Field 5726).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            WhseRcptHeader.SETCURRENTKEY("Location Code");
            WhseRcptHeader.SETRANGE("Location Code",Code);
            IF WhseRcptHeader.FINDFIRST THEN
              ERROR(Text008,FIELDCAPTION("Require Put-away"),xRec."Require Put-away",WhseRcptHeader.TABLECAPTION);

            IF NOT "Require Put-away" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
              WhseActivHeader.SETRANGE("Location Code",Code);
              IF WhseActivHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Put-away"),TRUE,WhseActivHeader.TABLECAPTION);
              "Use Cross-Docking" := FALSE;
              "Cross-Dock Bin Code" := '';
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            WhseRcptHeader.SETRANGE("Location Code",Code);
            IF NOT WhseRcptHeader.ISEMPTY THEN
            #4..9
              IF NOT WhseActivHeader.ISEMPTY THEN
            #11..13
            END ELSE
              CreateInboundWhseRequest;
            */
        //end;


        //Unsupported feature: Code Modification on ""Require Pick"(Field 5727).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            WhseShptHeader.SETCURRENTKEY("Location Code");
            WhseShptHeader.SETRANGE("Location Code",Code);
            IF WhseShptHeader.FINDFIRST THEN
              ERROR(Text008,FIELDCAPTION("Require Pick"),xRec."Require Pick",WhseShptHeader.TABLECAPTION);

            IF NOT "Require Pick" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
              WhseActivHeader.SETRANGE("Location Code",Code);
              IF WhseActivHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Pick"),TRUE,WhseActivHeader.TABLECAPTION);
              "Use Cross-Docking" := FALSE;
              "Cross-Dock Bin Code" := '';
              "Pick According to FEFO" := FALSE;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            WhseShptHeader.SETRANGE("Location Code",Code);
            IF NOT WhseShptHeader.ISEMPTY THEN
            #4..9
              IF NOT WhseActivHeader.ISEMPTY THEN
            #11..15
            */
        //end;


        //Unsupported feature: Code Modification on ""Require Receive"(Field 5730).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT "Require Receive" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseRcptHeader.SETCURRENTKEY("Location Code");
              WhseRcptHeader.SETRANGE("Location Code",Code);
              IF WhseRcptHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Receive"),TRUE,WhseRcptHeader.TABLECAPTION);
              "Receipt Bin Code" := '';
              "Use Cross-Docking" := FALSE;
              "Cross-Dock Bin Code" := '';
            END ELSE BEGIN
              WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
              WhseActivHeader.SETRANGE("Location Code",Code);
              IF WhseActivHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Receive"),FALSE,WhseActivHeader.TABLECAPTION);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT "Require Receive" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseRcptHeader.SETRANGE("Location Code",Code);
              IF NOT WhseRcptHeader.ISEMPTY THEN
            #6..12
              IF NOT WhseActivHeader.ISEMPTY THEN
                ERROR(Text008,FIELDCAPTION("Require Receive"),FALSE,WhseActivHeader.TABLECAPTION);

              CreateInboundWhseRequest;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Require Shipment"(Field 5731).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT "Require Shipment" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseShptHeader.SETCURRENTKEY("Location Code");
              WhseShptHeader.SETRANGE("Location Code",Code);
              IF WhseShptHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Shipment"),TRUE,WhseShptHeader.TABLECAPTION);
              "Shipment Bin Code" := '';
              "Use Cross-Docking" := FALSE;
              "Cross-Dock Bin Code" := '';
            END ELSE BEGIN
              WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
              WhseActivHeader.SETRANGE("Location Code",Code);
              IF WhseActivHeader.FINDFIRST THEN
                ERROR(Text008,FIELDCAPTION("Require Shipment"),FALSE,WhseActivHeader.TABLECAPTION);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT "Require Shipment" THEN BEGIN
              TESTFIELD("Directed Put-away and Pick",FALSE);
              WhseShptHeader.SETRANGE("Location Code",Code);
              IF NOT WhseShptHeader.ISEMPTY THEN
            #6..12
              IF NOT WhseActivHeader.ISEMPTY THEN
                ERROR(Text008,FIELDCAPTION("Require Shipment"),FALSE,WhseActivHeader.TABLECAPTION);
            END;
            */
        //end;
        field(50000;Blocked;Boolean)
        {
            Caption = 'Blocked';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on "Name(Key)".

    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: StockkeepingUnit)()
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
        WMSCheckWarehouse;

        TransferRoute.SETRANGE("Transfer-from Code",Code);
        #4..14
            WorkCenter.VALIDATE("Location Code",'');
            WorkCenter.MODIFY(TRUE);
          UNTIL WorkCenter.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        StockkeepingUnit.SETRANGE("Location Code",Code);
        IF NOT StockkeepingUnit.ISEMPTY THEN
          ERROR(CannotDeleteLocSKUExistErr,Code);

        #1..17
        */
    //end;


    //Unsupported feature: Code Modification on "GetLocationSetup(PROCEDURE 3)".

    //procedure GetLocationSetup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT GET(LocationCode) THEN
          WITH Location2 DO BEGIN
            INIT;
            WhseSetup.GET;
            Code := LocationCode;
            "Use As In-Transit" := FALSE;
            "Require Put-away" := WhseSetup."Require Put-away";
        #8..14

        Location2 := Rec;
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
            InvtSetup.GET;
        #5..17
        */
    //end;


    //Unsupported feature: Code Modification on "CheckWhseAdjmtJnl(PROCEDURE 7303)".

    //procedure CheckWhseAdjmtJnl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseJnlTemplate.SETRANGE(Type,WhseJnlTemplate.Type::Item);
        IF WhseJnlTemplate.FIND('-') THEN
          REPEAT
            WhseJnlLine.SETRANGE("Journal Template Name",WhseJnlTemplate.Name);
            WhseJnlLine.SETRANGE("Location Code",Code);
            IF WhseJnlLine.FINDFIRST THEN
              ERROR(
                Text007,
                FIELDCAPTION("Adjustment Bin Code"));
          UNTIL WhseJnlTemplate.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
            IF NOT WhseJnlLine.ISEMPTY THEN
        #7..10
        */
    //end;

    procedure IsInTransit(LocationCode: Code[10]): Boolean
    begin
        IF Location.GET(LocationCode) THEN
          EXIT(Location."Use As In-Transit");
        EXIT(FALSE);
    end;

    local procedure CreateInboundWhseRequest()
    var
        TransferHeader: Record "5740";
        TransferLine: Record "5741";
        WarehouseRequest: Record "5765";
        WhseTransferRelease: Codeunit "5773";
    begin
        TransferLine.SETRANGE("Transfer-to Code",Code);
        IF TransferLine.FINDSET THEN
          REPEAT
            IF TransferLine."Quantity Received" <> TransferLine."Quantity Shipped" THEN BEGIN
              TransferHeader.GET(TransferLine."Document No.");
              WhseTransferRelease.InitializeWhseRequest(WarehouseRequest,TransferHeader,TransferHeader.Status);
              WhseTransferRelease.CreateInboundWhseRequest(WarehouseRequest,TransferHeader);

              TransferLine.SETRANGE("Document No.",TransferLine."Document No.");
              TransferLine.FINDLAST;
              TransferLine.SETRANGE("Document No.");
            END;
          UNTIL TransferLine.NEXT = 0;
    end;

    var
        StockkeepingUnit: Record "5700";

    var
        CannotDeleteLocSKUExistErr: Label 'You cannot delete %1 because one or more stockkeeping units exist at this location.', Comment='%1: Field(Code)';
}

