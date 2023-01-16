tableextension 50078 "BC6_ReturnReceiptHeader" extends "Return Receipt Header" //6660
{
    fields
    {
        field(50000; "BC6_Cause filing"; enum "BC6_Cause filing")
        {
            Caption = 'Cause filing', Comment = 'FRA="Cause archivage"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment', Comment = 'FRA="Acompte payé"';
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID', Comment = 'FRA="Code utilisateur"';
            DataClassification = CustomerContent;
            TableRelation = User;
        }
        field(50020; "BC6_Cust. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', Comment = 'FRA="Goupe Marge Vente Client"';
            DataClassification = CustomerContent;
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order', Comment = 'FRA="Regrouper BL par commande"';
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS', Comment = 'FRA="Ventes DS"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS', Comment = 'FRA="Marge DS"';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente', Comment = 'FRA="% de marge sur vente"';
            DataClassification = CustomerContent;
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced', Comment = 'FRA="Facturé"';
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Version No.', Comment = 'FRA="N° version"';
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description', Comment = 'FRA="Libellé document"';
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Quote statut"; enum "BC6_Quote statut")
        {
            Caption = 'Quote status', Comment = 'FRA="Statut devis"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.', Comment = 'FRA="N° télécopie donneur d''ordre"';
            DataClassification = CustomerContent;
        }
    }
}
