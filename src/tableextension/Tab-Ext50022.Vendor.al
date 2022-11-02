tableextension 50022 "BC6_Vendor" extends Vendor
{
    LookupPageID = "Vendor List";
    DrillDownPageID = "Vendor List";
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            trigger OnAfterValidate()
            var
                GenBusPostingGrp: Record "Gen. Business Posting Group";
            begin
                GenBusPostingGrp.GET("Gen. Bus. Posting Group");
                "BC6_Posting DEEE" := GenBusPostingGrp."BC6_Subject to DEEE";

            end;
        }




        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date';

            Editable = false;
        }
        field(50001; BC6_User; Code[20])
        {
            Caption = 'User';

            Editable = false;
            TableRelation = User;
        }
        field(50002; "BC6_Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';

            TableRelation = "Transaction Type";
        }
        field(50003; "BC6_Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(50004; "BC6_Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(50005; "BC6_Entry Point"; Code[10])
        {
            Caption = 'Entry  Point';
            TableRelation = "Entry/Exit Point";
        }
        field(50006; BC6_Area; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(50007; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001, "BC6_Pay-to Vend. No.")) THEN
                    updateLedgerEntries("No.", "BC6_Pay-to Vend. No.");
            end;
        }
        field(50010; "BC6_Mini Amount"; Decimal)
        {
            Caption = 'Montant mini franco ';
            Description = 'MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant';
        }
        field(50012; BC6_MinFranco; Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Franco';
            Enabled = false;
        }
        field(50013; "BC6_Order Minimum"; Decimal)
        {
            Caption = 'Order Minimum';
        }
        field(50014; "BC6_Freight Amount"; Decimal)
        {
            Caption = 'Freight Amount';
        }
        field(50015; "BC6_Blocked Prices"; Boolean)
        {
            Caption = 'Blocked Prices';
        }
        field(50016; "BC6_% Mini Margin"; Decimal)
        {
            Caption = '% Mini Margin';
            MaxValue = 100;
            MinValue = 0;
        }
        field(80800; "BC6_Posting DEEE"; Boolean)
        {
            Caption = 'Posting DEEE';
            Description = 'DEEE1.00';
        }
    }
    keys
    {
        key(Key22; "BC6_Pay-to Vend. No.")
        {
        }
        key(Key23; "IC Partner Code")
        {
        }
    }



    local procedure MarkVendorsWithSimilarName(var Vendor: Record Vendor; VendorText: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        VendorCount: Integer;
        VendorTextLenght: Integer;
        Treshold: Integer;
    begin
        IF VendorText = '' THEN
            EXIT;
        IF STRLEN(VendorText) > MAXSTRLEN(Vendor.Name) THEN
            EXIT;
        VendorTextLenght := STRLEN(VendorText);
        Treshold := VendorTextLenght DIV 5;
        IF Treshold = 0 THEN
            EXIT;
        Vendor.RESET;
        Vendor.ASCENDING(FALSE); // most likely to search for newest Vendors
        IF Vendor.FINDSET THEN
            REPEAT
                VendorCount += 1;
                IF ABS(VendorTextLenght - STRLEN(Vendor.Name)) <= Treshold THEN
                    IF TypeHelper.TextDistance(UPPERCASE(VendorText), UPPERCASE(Vendor.Name)) <= Treshold THEN
                        Vendor.MARK(TRUE);
            UNTIL Vendor.MARK OR (Vendor.NEXT = 0) OR (VendorCount > 1000);
        Vendor.MARKEDONLY(TRUE);
    end;

    local procedure CreateNewVendor(VendorName: Text[50]): Code[20]
    var
        Vendor: Record Vendor;
        MiniVendorTemplate: Record "Mini Vendor Template";
        VendorCard: Page "Vendor Card";
    begin
        IF NOT MiniVendorTemplate.NewVendorFromTemplate(Vendor) THEN
            ERROR(SelectVendorErr);

        Vendor.Name := VendorName;
        Vendor.MODIFY(TRUE);
        COMMIT;
        Vendor.SETRANGE("No.", Vendor."No.");
        VendorCard.SETTABLEVIEW(Vendor);
        IF NOT (VendorCard.RUNMODAL = ACTION::OK) THEN
            ERROR(SelectVendorErr);

        EXIT(Vendor."No.");
    end;

    local procedure PickVendor(var Vendor: Record Vendor; NoFiltersApplied: Boolean): Code[20]
    var
        VendorList: Page "Vendor List";
    begin
        IF NOT NoFiltersApplied THEN
            MarkVendorsByFilters(Vendor);

        VendorList.SETTABLEVIEW(Vendor);
        VendorList.SETRECORD(Vendor);
        VendorList.LOOKUPMODE := TRUE;
        IF VendorList.RUNMODAL = ACTION::LookupOK THEN
            VendorList.GETRECORD(Vendor)
        ELSE
            CLEAR(Vendor);

        EXIT(Vendor."No.");
    end;

    local procedure MarkVendorsByFilters(var Vendor: Record Vendor)
    begin
        IF Vendor.FINDSET THEN
            REPEAT
                Vendor.MARK(TRUE);
            UNTIL Vendor.NEXT = 0;
        IF Vendor.FINDFIRST THEN;
        Vendor.MARKEDONLY := TRUE;
    end;

    PROCEDURE updateLedgerEntries(CodLVendNo: Code[20]; CodLPayToNo: Code[20]);
    VAR
        RecLVendLedgEntry: Record "Vendor Ledger Entry";
        RecLDetVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    BEGIN
        RecLVendLedgEntry.RESET;
        RecLVendLedgEntry.SETRANGE("Vendor No.", CodLVendNo);
        RecLVendLedgEntry.SETRANGE(Open, TRUE);
        IF RecLVendLedgEntry.FINDSET(TRUE, FALSE) THEN
            REPEAT
                //TODO
                // RecLVendLedgEntry."Pay-to Vend. No." := CodLPayToNo;
                RecLVendLedgEntry.MODIFY;

                //Mise … jour de la Table 380 Ecriture Forunisseur d‚taill‚
                RecLDetVendLedgEntry.RESET;
                RecLDetVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", RecLVendLedgEntry."Entry No.");
                IF RecLDetVendLedgEntry.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        RecLDetVendLedgEntry."Pay-to Vend. No." := CodLPayToNo;
                        RecLDetVendLedgEntry.MODIFY;
                    UNTIL RecLDetVendLedgEntry.NEXT = 0;
            UNTIL RecLVendLedgEntry.NEXT = 0;
    END;

    var
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?';
        SelectVendorErr: Label 'You must select an existing vendor.';

}

