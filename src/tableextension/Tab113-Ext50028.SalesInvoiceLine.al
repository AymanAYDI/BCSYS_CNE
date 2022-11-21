tableextension 50028 "BC6_SalesInvoiceLine" extends "Sales Invoice Line" //113
{
    fields
    {
        field(50020; "BC6_Custom. Sales Profit Group"; Code[20])
        {
            Caption = 'Custom. Sales Profit Group', comment = 'FRA="Goupe Marge Vente Client"';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[20])
        {
            Caption = 'Item Sales Profit Group', comment = 'FRA="Goupe Marge Vente Article"';
            TableRelation = "BC6_Item Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Public Price', comment = 'FRA="Tarif Public"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.', comment = 'FRA="N° doc. externe"';
            DataClassification = CustomerContent;
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)', comment = 'FRA="Montant DS"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.', comment = 'FRA="N° preneur d''ordre"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', comment = 'FRA="N° commande achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.', comment = 'FRA="N° ligne commande achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50028; "BC6_Purch. Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type', comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity', comment = 'FRA="Quantité commandée"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity', comment = 'FRA="Quantité livrée"';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price', comment = 'FRA="Prix unitaire remisé"';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item', comment = 'FRA="Disponibilité article"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Outstanding Qty"; Decimal)
        {
            Caption = 'Outstanding Quantity', comment = 'FRA="quantité restante"';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost', comment = 'FRA="Coût d''achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order', comment = 'FRA="Affecter commande achat"';
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected', comment = 'FRA="Commande achat affectée"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50100; "BC6_Item Disc. Group"; Code[10])
        {
            Caption = 'Item Disc. Group', comment = 'FRA="Groupe remise article"';
            TableRelation = "Item Discount Group";
            DataClassification = CustomerContent;
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'Dispensation No.', comment = 'FRA="N° dérogation"';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = 'Additional Discount %', comment = 'FRA="% remise complémentaire"';
            DataClassification = CustomerContent;
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Dispensed Purchase Cost', comment = 'FRA="coût d''achat dérogé"';
            DataClassification = CustomerContent;
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Standard Net Price', comment = 'FRA="Prix net standard"';
            DataClassification = CustomerContent;
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
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80803; "BC6_DEEE Bases VAT Amount"; Decimal)
        {
            Caption = 'DEEE Bases VAT Amount', comment = 'FRA="Montant Base TVA DEEE"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="=Montant HT DEEE (DS)"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="=Eco partenaire DEEE"';
            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key10; "No.")
        {
        }
        key(Key11; "BC6_Buy-from Vendor No.")
        {
        }
        key(Key12; "Document No.", "No.")
        {
        }
    }
}
