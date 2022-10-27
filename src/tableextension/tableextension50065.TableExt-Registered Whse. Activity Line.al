tableextension 50065 tableextension50065 extends "Registered Whse. Activity Line"
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
    LookupPageID = 7364;
    DrillDownPageID = 7364;
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
        modify("Bin Code")
        {
            TableRelation = IF (Action Type=FILTER(<>Take)) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                            Zone Code=FIELD(Zone Code))
                                                                            ELSE IF (Action Type=FILTER(<>Take),
                                                                                     Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                                                                                     ELSE IF (Action Type=CONST(Take)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                       Zone Code=FIELD(Zone Code))
                                                                                                                                                       ELSE IF (Action Type=CONST(Take),
                                                                                                                                                                Zone Code=FILTER('')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code));
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
    }


    //Unsupported feature: Code Modification on "ShowRegisteredActivityDoc(PROCEDURE 23)".

    //procedure ShowRegisteredActivityDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RegisteredWhseActivHeader.SETRANGE(Type,"Activity Type");
        RegisteredWhseActivHeader.SETRANGE("No.","No.");
        CASE "Activity Type" OF
          "Activity Type"::Pick:
            BEGIN
              RegisteredPickCard.SETTABLEVIEW(RegisteredWhseActivHeader);
              RegisteredPickCard.RUNMODAL;
            END;
          "Activity Type"::"Put-away":
            BEGIN
              RegisteredPutAwayCard.SETTABLEVIEW(RegisteredWhseActivHeader);
              RegisteredPutAwayCard.RUNMODAL;
            END;
          "Activity Type"::Movement:
            BEGIN
              RegisteredMovCard.SETTABLEVIEW(RegisteredWhseActivHeader);
              RegisteredMovCard.RUNMODAL;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RegisteredWhseActivHeader.SETRANGE(Type,"Activity Type");
        RegisteredWhseActivHeader.SETRANGE("No.","No.");
        RegisteredWhseActivHeader.FINDFIRST;
        #3..5
              RegisteredPickCard.SETRECORD(RegisteredWhseActivHeader);
        #6..10
              RegisteredPutAwayCard.SETRECORD(RegisteredWhseActivHeader);
        #11..15
              RegisteredMovCard.SETRECORD(RegisteredWhseActivHeader);
        #16..19
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
              WhseInternalPickHeader.SETRANGE("No.","Whse. Document No.");
              WhseInternalPickCard.SETTABLEVIEW(WhseInternalPickHeader);
              WhseInternalPickCard.RUNMODAL;
            END;
          "Whse. Document Type"::"Internal Put-away":
            BEGIN
              WhseInternalPutawayHeader.SETRANGE("No.","Whse. Document No.");
              WhseInternalPutawayCard.SETTABLEVIEW(WhseInternalPutawayHeader);
              WhseInternalPutawayCard.RUNMODAL;
            END;
        #26..36
              PAGE.RUN(PAGE::"Assembly Order",AssemblyHeader);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
              WhseInternalPickHeader.FINDFIRST;
              WhseInternalPickCard.SETRECORD(WhseInternalPickHeader);
        #17..22
              WhseInternalPutawayHeader.FINDFIRST;
              WhseInternalPutawayCard.SETRECORD(WhseInternalPutawayHeader);
        #23..39
        */
    //end;
}

