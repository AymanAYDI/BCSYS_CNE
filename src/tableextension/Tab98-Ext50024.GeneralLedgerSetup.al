tableextension 50024 "BC6_GeneralLedgerSetup" extends "General Ledger Setup" //98
{
    fields
    {
        field(80800; "BC6_DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management', comment = 'FRA="Activation de la gestion DEEE"';
            DataClassification = CustomerContent;
        }
        field(80810; "BC6_DEEE Sales line prefix"; Text[30])
        {
            Caption = 'DEEE Sales line prefix', comment = 'FRA="Prefixe lignes de vente"';
            DataClassification = CustomerContent;
        }
        field(80811; "BC6_DEEE Purchases line prefix"; Text[30])
        {
            Caption = 'DEEE Purchases line prefix', comment = 'FRA="Prefixe lignes d''achat"';
            DataClassification = CustomerContent;
        }
        field(80820; "BC6_Sales Tax Recalcul"; Boolean)
        {
            Caption = 'Sales Tax Recalcul', comment = 'FRA="Recalculer Sales Tax"';
            DataClassification = CustomerContent;
        }
        field(80840; "BC6_DEEE Business Group ID"; Code[10])
        {
            Caption = 'DEEE Business Group ID', comment = 'FRA="Identifiant Groupe Compta Marché DEEE"';
            TableRelation = "Gen. Business Posting Group".Code;
            DataClassification = CustomerContent;
        }
        field(80841; "BC6_Defaut Eco partner DEEE"; Code[20])
        {
            Caption = 'Defaut Eco partnaire', comment = 'FRA="Eco partenaire DEEE par défaut"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }

}

