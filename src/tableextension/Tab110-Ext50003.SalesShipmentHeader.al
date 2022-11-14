tableextension 50003 "BC6_SalesShipmentHeader" extends "Sales Shipment Header" //110
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
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[20])
        {
            Caption = 'Goupe Marge Vente Client', comment = 'FRA="Goupe Marge Vente Client"';
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
            Caption = 'Purchase Cost', comment = 'FRA="Coût d''achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS', comment = 'FRA="Ventes DS"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS', comment = 'FRA="Marge DS"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente', comment = 'FRA="% de marge sur vente"';
            DataClassification = CustomerContent;
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced', comment = 'FRA="Facturé"';
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Version No.', comment = 'FRA="N° version"';
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description', comment = 'FRA="Libellé document"';
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
            Caption = 'Sell-to E-Mail Address', comment = 'FRA="N° télécopie donneur d''ordre"';
            DataClassification = CustomerContent;

        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter', comment = 'FRA="Filtre vendeur"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(65000; "BC6_Assigned User ID"; Code[50])
        {
            CalcFormula = Lookup("Sales Header"."Assigned User ID" WHERE("Document Type" = CONST(Order),
                                                                          "No." = FIELD("Order No.")));
            Caption = 'Assigned User ID', comment = 'FRA="Code utilisateur affecté"';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        key(Key8; "External Document No.", "No.")
        {
        }
    }
}

