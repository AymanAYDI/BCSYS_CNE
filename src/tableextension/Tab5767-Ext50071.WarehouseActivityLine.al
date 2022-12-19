tableextension 50071 "BC6_WarehouseActivityLine" extends "Warehouse Activity Line" //5767
{
    fields
    {

        modify("Qty. to Handle (Base)")
        {
            trigger OnAfterValidate()
            begin
                UseBaseQty := true;
            end;
        }
        field(50040; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No.', Comment = 'FRA="Lien n° origine"';
            Editable = false;
            TableRelation = IF ("BC6_Source Document 2" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50041; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.', Comment = 'FRA="Lien n° ligne origine"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50042; "BC6_Source Document 2"; enum "BC6_Source Document 2")
        {
            BlankZero = true;
            Caption = 'Source Document', Comment = 'FRA="Lien document origine"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50043; "BC6_Source Bin Code"; Code[20])
        {
            Caption = 'Lien code emplacement origine', Comment = 'FRA="Lien code emplacement origine"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                WMSMgt.BinLookUp("Location Code", "Item No.", "Variant Code", '');
            end;
        }
        field(50045; "BC6_Warehouse Comment"; Text[50])
        {
            Caption = 'Warehouse Comments', Comment = 'FRA="Commentaire magasin"';
            DataClassification = CustomerContent;
        }
        field(50046; "BC6_Qty. Picked"; Decimal)
        {
            Caption = 'Qty. picked', Comment = 'FRA="Quantité prélevée"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecLUserSetup: Record "User Setup";
                FctMangt: Codeunit "BC6_Functions Mgt";
                CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter';
            begin
                IF "Qty. to Handle" > "Qty. Outstanding" THEN
                    ERROR(
                      Text002,
                      "Qty. Outstanding");

                //>>CNE5.00
                IF RecLUserSetup.GET(USERID) THEN BEGIN
                    IF NOT RecLUserSetup."BC6_Auth.Qty.to Handle Change" THEN
                        ERROR(CstL001);
                END ELSE
                    ERROR(CstL001);
                //<<CNE5.00

                FctMangt.GetLocation("Location Code");
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
                    "Qty. to Handle (Base)" := CalcBaseQty("Qty. to Handle", FieldCaption("Qty. to Handle"), FieldCaption("Qty. Outstanding (Base)"));
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

                IF "Qty. to Handle" = 0 THEN
                    FctMangt.UpdateReservation(Rec, FALSE)
            end;
        }
        field(50047; BC6_DeleteWhseActivityHeader; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }


    local procedure CalcBaseQty(Qty: Decimal; FromFieldName: Text; ToFieldName: Text): Decimal
    begin
        exit(UOMMgt.CalcBaseQty(
            "Item No.", "Variant Code", "Unit of Measure Code", Qty, "Qty. per Unit of Measure", "Qty. Rounding Precision (Base)", FieldCaption("Qty. Rounding Precision"), FromFieldName, ToFieldName));
    end;

    var
        Location: Record Location;
        WMSMgt: Codeunit "WMS Management";
        UOMMgt: Codeunit "Unit of Measure Management";
        UseBaseQty: Boolean;
        Text002: Label 'You cannot handle more than the outstanding %1 units.', Comment = 'FRA="Vous ne pouvez pas traiter plus que les %1 unités restantes."';
}
