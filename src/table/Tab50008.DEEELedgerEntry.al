table 50008 "BC6_DEEE Ledger Entry"
{
    Caption = 'DEEE Entry', comment = 'FRA="Ecritures DEEE"';
    DataClassification = CustomerContent;

    DrillDownPageID = 50026;
    LookupPageID = 50026;

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
            TableRelation = Item;
            DataClassification = CustomerContent;
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
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Item)) Item;
            DataClassification = CustomerContent;
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
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'FRA="Quantité"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity', comment = 'FRA="Quantité facturée"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code', comment = 'FRA="Code axe principal 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code', comment = 'FRA="Code axe principal 2"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(41; "Source Type"; Enum "Analysis Source Type")
        {
            Caption = '"Source Type"', comment = 'FRA="Type origine"';
            DataClassification = CustomerContent;
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'FRA="Groupe compta. marché"';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(80800; "DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
        }
        field(80801; "DEEE Unit Tax"; Decimal)
        {
            Caption = 'DEEE Unit Tax', comment = 'FRA="Taxe Unitaire DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80802; "DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80803; "DEEE Unit Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DEEE Unit Price (LCY)';
        }
        field(80804; "DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80805; "DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80806; "DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant HT DEEE (DS)"';
            DataClassification = CustomerContent;
        }
        field(80807; "Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
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
