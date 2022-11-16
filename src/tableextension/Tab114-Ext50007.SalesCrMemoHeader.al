tableextension 50007 "BC6_SalesCrMemoHeader" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(50000; "BC6_Cause filing"; Enum "BC6_Cause Filing")
        {
            Caption = 'Cause filing', comment = 'FRA="Cause archivage"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment', comment = 'FRA="Acompte payé"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° Affaire"';
            TableRelation = Job."No.";
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID', comment = 'FRA="Code utilisateur"';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Custom. Sales Profit Group', comment = 'FRA="Goupe Marge Vente Client"';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order', comment = 'FRA="Regrouper BL par commande"';
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            Caption = 'Purchase Cost', comment = 'FRA="Coùt d''achat"';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Sales LCY', comment = 'FRA="Ventes DS"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Profit LCY', comment = 'FRA="Marge DS"';
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% Profit', comment = 'FRA="% de marge sur vente"';
            DataClassification = CustomerContent;
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced', comment = 'FRA="Facturé"';
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Prod. Version No.', comment = 'FRA="Version No."';
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description', comment = 'FRA="Libelle document"';
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Quote statut"; Enum "BC6_Quote statut")
        {
            Caption = 'Quote status', comment = 'FRA="Statut devis"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.', comment = 'FRA="N° télécopie donneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
            Caption = 'Sell-to E-Mail Address', comment = 'FRA="Email donneur d''ordre"';
            DataClassification = CustomerContent;

        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter', comment = 'FRA="Filtre vendeur"';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {

        key(Key10; "Posting Date")
        {
        }
    }


}

