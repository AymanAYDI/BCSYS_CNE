tableextension 50065 "BC6_SalesHeaderArchive" extends "Sales Header Archive" //5107
{
    fields
    {
        field(50000; "BC6_Cause filing"; enum "BC6_Cause filing")
        {
            Caption = 'Cause filing', Comment = 'FRA="Cause archivage"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Purchaser Comments"; Text[50])
        {
            Caption = 'Purchaser Comments', Comment = 'FRA="Commentaires acheteur"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Warehouse Comments"; Text[50])
        {
            Caption = 'Warehouse Comments', Comment = 'FRA="Commentaires magasins"';
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
        field(50005; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', Comment = 'FRA="N° Affaire"';
            DataClassification = CustomerContent;
            TableRelation = Job."No.";
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'ID';
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
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."BC6_Purchase cost" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Purchase Cost', Comment = 'FRA="Coût d''achat"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "BC6_Copy Sell-to Address"; Boolean)
        {
            Caption = 'Copy Sell-to Address', Comment = 'FRA="Copie adresse donneur d''ordre"';
            DataClassification = CustomerContent;
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
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
            Caption = 'Sell-to E-Mail address', Comment = 'FRA="Adresse mail donneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50070; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter', Comment = 'FRA="Vente comptoire"';
            DataClassification = CustomerContent;
        }
        field(50080; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien', Comment = 'FRA="N° Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50403; "BC6_Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
    }
}
