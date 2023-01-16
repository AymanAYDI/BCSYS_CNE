table 50008 "BC6_DEEE Ledger Entry"
{
    Caption = 'DEEE Entry', comment = 'FRA="Ecritures DEEE"';
    DataClassification = CustomerContent;
    DrillDownPageID = "BC6_DEEE Ledger Entries";
    LookupPageID = "BC6_DEEE Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', comment = 'FRA="N° séquence"';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.', comment = 'FRA="N° article"';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date', comment = 'FRA="Date comptabilisation"';
            DataClassification = CustomerContent;
        }
        field(4; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Entry Type', comment = 'FRA="Type écriture"';
            DataClassification = CustomerContent;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.', comment = 'FRA="N° origine"';
            DataClassification = CustomerContent;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Item)) Item;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'FRA="N° document"';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description', comment = 'FRA="Désignation"';
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'FRA="Code magasin"';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'FRA="Quantité"';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity', comment = 'FRA="Quantité facturée"';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code', comment = 'FRA="Code axe principal 1"';
            CaptionClass = '1,1,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code', comment = 'FRA="Code axe principal 2"';
            CaptionClass = '1,1,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(41; "Source Type"; Enum "Analysis Source Type")
        {
            Caption = '"Source Type"', comment = 'FRA="Type origine"';
            DataClassification = CustomerContent;
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'FRA="Groupe compta. marché"';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(80800; "DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', comment = 'FRA="Code Catégorie DEEE"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80801; "DEEE Unit Tax"; Decimal)
        {
            Caption = 'DEEE Unit Tax', comment = 'FRA="Taxe Unitaire DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80802; "DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80803; "DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)';
            DataClassification = CustomerContent;
        }
        field(80804; "DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80805; "DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80806; "DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant HT DEEE (DS)"';
            DataClassification = CustomerContent;
        }
        field(80807; "Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(80808; "DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'Amount (LCY) for Stat', comment = 'FRA="Montant (LCY) pour Stat"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
        key(Key3; "DEEE Category Code", "Item No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}
