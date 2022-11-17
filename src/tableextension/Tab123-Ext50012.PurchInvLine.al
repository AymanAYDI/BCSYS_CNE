tableextension 50012 "BC6_PurchInvLine" extends "Purch. Inv. Line" //123
{
    fields
    {
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.', comment = 'FRA="N° commande vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.', comment = 'FRA="N° ligne commande vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Sales Document Type"; enum "Purchase Document Type")
        {
            Caption = 'Document Type', comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Public Price', comment = 'FRA="Tarif Public"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT', comment = 'FRA="Coût unitaire direct remisé HT"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price', comment = 'FRA="Prix Unitaire DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80803; "BC6_DEEE Bases VAT Amount"; Decimal)
        {
            Caption = 'DEEE Bases VAT Amount', comment = 'FRA="Montant Base TVA DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';

            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';

            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant TTC DEEE"';

            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';

            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key9; "No.")
        {
        }
        key(Key8; "Buy-from Vendor No.", Type)
        {
        }
        key(Key7; "No.", "Buy-from Vendor No.", "Document No.", "Line No.")
        {
        }
    }


}

