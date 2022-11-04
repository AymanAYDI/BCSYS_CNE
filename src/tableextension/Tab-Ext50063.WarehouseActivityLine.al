tableextension 50063 "BC6_WarehouseActivityLine" extends "Warehouse Activity Line"
{
    fields
    {
        field(50040; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            TableRelation = IF ("BC6_Source Document 2" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50041; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            Editable = false;
        }
        field(50042; "BC6_Source Document 2"; enum "BC6_Source Document 2")
        {
            BlankZero = true;
            Caption = 'Source Document';
            Editable = false;
        }
        field(50043; "BC6_Source Bin Code"; Code[20])
        {
            Caption = 'Lien code emplacement origine';
            Editable = false;

            trigger OnLookup()
            begin
                WMSMgt.BinLookUp("Location Code", "Item No.", "Variant Code", '');
            end;
        }
        field(50045; "BC6_Warehouse Comment"; Text[50])
        {
            Caption = 'Warehouse Comments';
        }
        field(50046; "BC6_Qty. Picked"; Decimal)
        {
            Caption = 'Qty. picked';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                RecLUserSetup: Record "User Setup";
                CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
            begin
                IF "Qty. to Handle" > "Qty. Outstanding" THEN
                    ERROR(
                      Text002,
                      "Qty. Outstanding");

                //>>CNE5.00
                IF RecLUserSetup.GET(USERID) THEN BEGIN
                    IF NOT RecLUserSetup."BC6_Autorize Qty. to Handle Change" THEN
                        ERROR(CstL001);
                END ELSE
                    ERROR(CstL001);
                //<<CNE5.00

                GetLocation("Location Code");
                IF Location."Directed Put-away and Pick" THEN
                    WMSMgt.CalcCubageAndWeight(
                      "Item No.", "Unit of Measure Code", "Qty. to Handle", Cubage, Weight);

                IF (CurrFieldNo <> 0) AND
                   ("Action Type" = "Action Type"::Place) AND
                   ("Breakbulk No." = 0) AND
                   ("Qty. to Handle" > 0) AND
                   Location."Directed Put-away and Pick"
                THEN
                    IF GetBin("Location Code", "Bin Code") THEN
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
                        UpdateBreakbulkQtytoHandle();

                IF ("Activity Type" IN ["Activity Type"::Pick, "Activity Type"::"Invt. Pick", "Activity Type"::"Invt. Movement"]) AND
                   ("Action Type" <> "Action Type"::Place) AND ("Lot No." <> '') AND (CurrFieldNo <> 0)
                THEN
                    CheckReservedItemTrkg(1, "Lot No.");

                // IF "Qty. to Handle" = 0 THEN //TODO: function local "UpdateReservation"
                // UpdateReservation(Rec, FALSE)
            end;
        }
    }



    var
        RecLUserSetup: Record "User Setup";
        WMSMgt: Codeunit "WMS Management";
        CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
        CstL002: Label 'Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée.';
        Text002: Label 'You cannot handle more than the outstanding %1 units.';
}

