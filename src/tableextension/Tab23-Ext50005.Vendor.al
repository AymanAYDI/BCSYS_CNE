tableextension 50005 "BC6_Vendor" extends Vendor //23
{
    fields
    {
        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date', Comment = 'FRA="Date de création"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; BC6_User; Code[20])
        {
            Caption = 'User', Comment = 'FRA="Utilisateur"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = User;
        }
        field(50002; "BC6_Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type', Comment = 'FRA="Nature Transaction"';
            DataClassification = CustomerContent;
            TableRelation = "Transaction Type";
        }
        field(50003; "BC6_Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification', Comment = 'FRA="Régime"';
            DataClassification = CustomerContent;
            TableRelation = "Transaction Specification";
        }
        field(50004; "BC6_Transport Method"; Code[10])
        {
            Caption = 'Transport Method', Comment = 'FRA="Mode transport"';
            DataClassification = CustomerContent;
            TableRelation = "Transport Method";
        }
        field(50005; "BC6_Entry Point"; Code[10])
        {
            Caption = 'Entry  Point', Comment = 'FRA="Pays Provenance"';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
        }
        field(50006; BC6_Area; Code[10])
        {
            Caption = 'Area', Comment = 'FRA="Departement Destination"';
            DataClassification = CustomerContent;
            TableRelation = Area;
        }
        field(50007; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;

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
            Caption = 'MinFranco';
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(50013; "BC6_Order Minimum"; Decimal)
        {
            Caption = 'Order Minimum', Comment = 'FRA="Minimum de commande"';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Freight Amount"; Decimal)
        {
            Caption = 'Freight Amount', Comment = 'FRA="Montant port si franco non atteint"';
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
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
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
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?', Comment = 'FRA="Voulez-vous mettre à jour les Ecritures ouvertes avec le Nouveau N° Tiers payeur %1?"';
}