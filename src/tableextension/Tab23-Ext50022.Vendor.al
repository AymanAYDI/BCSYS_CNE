tableextension 50022 "BC6_Vendor" extends Vendor //23
{
    fields
    {

        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date', Comment = 'FRA="Date de création"';

            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; BC6_User; Code[20])
        {
            Caption = 'User', Comment = 'FRA="Utilisateur"';

            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type', Comment = 'FRA="Nature Transaction"';

            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification', Comment = 'FRA="Régime"';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Transport Method"; Code[10])
        {
            Caption = 'Transport Method', Comment = 'FRA="Mode transport"';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Entry Point"; Code[10])
        {
            Caption = 'Entry  Point', Comment = 'FRA="Pays Provenance"';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(50006; BC6_Area; Code[10])
        {
            Caption = 'Area', Comment = 'FRA="Departement Destination"';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001, "BC6_Pay-to Vend. No.")) THEN
                    updateLedgerEntries("No.", "BC6_Pay-to Vend. No.");
            end;
        }
        field(50010; "BC6_Mini Amount"; Decimal)
        {
            Caption = 'Montant mini franco ', Comment = 'FRA="Montant mini franco "';
            DataClassification = CustomerContent;
        }
        field(50012; BC6_MinFranco; Decimal)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_Order Minimum"; Decimal)
        {
            Caption = 'Order Minimum', Comment = 'FRA="Minimum de commande"';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Freight Amount"; Decimal)
        {
            Caption = 'Freight Amount', Comment = 'FRA="montant port si franco non atteint"';
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Blocked Prices"; Boolean)
        {
            Caption = 'Blocked Prices', Comment = 'FRA="Prix bloqués"';
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_% Mini Margin"; Decimal)
        {
            Caption = '% Mini Margin', Comment = 'FRA="% marge mini"';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_Posting DEEE"; Boolean)
        {
            Caption = 'Posting DEEE', Comment = 'FRA="Comptabilisation DEEE"';
            DataClassification = CustomerContent;
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

    PROCEDURE "---NSC1.00---"()
    BEGIN
    END;

    PROCEDURE updateLedgerEntries(CodLVendNo: Code[20]; CodLPayToNo: Code[20]);
    VAR
        RecLDetVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        RecLVendLedgEntry: Record "Vendor Ledger Entry";
    BEGIN
        RecLVendLedgEntry.RESET();
        RecLVendLedgEntry.SETRANGE("Vendor No.", CodLVendNo);
        RecLVendLedgEntry.SETRANGE(Open, TRUE);
        IF RecLVendLedgEntry.FINDSET(TRUE, FALSE) THEN
            REPEAT

                RecLVendLedgEntry."BC6_Pay-to Vend. No." := CodLPayToNo;
                RecLVendLedgEntry.MODIFY();
                RecLDetVendLedgEntry.RESET();
                RecLDetVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", RecLVendLedgEntry."Entry No.");
                IF RecLDetVendLedgEntry.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        RecLDetVendLedgEntry."BC6_Pay-to Vend. No." := CodLPayToNo;
                        RecLDetVendLedgEntry.MODIFY();
                    UNTIL RecLDetVendLedgEntry.NEXT() = 0;
            UNTIL RecLVendLedgEntry.NEXT() = 0;
    END;

    var
        SelectVendorErr: Label 'You must select an existing vendor.', Comment = 'FRA="Vous devez sélectionner un fournisseur existant."';
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?', Comment = 'FRA="Voulez-vous mettre à jour les Ecritures ouvertes avec le Nouveau N° Tiers payeur %1?"';

}