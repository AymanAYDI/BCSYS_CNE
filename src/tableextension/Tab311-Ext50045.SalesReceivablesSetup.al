tableextension 50045 "BC6_SalesReceivablesSetup" extends "Sales & Receivables Setup" //311
{
    Caption = 'Sales & Receivables Setup', comment = 'FRA="Paramètres ventes"';
    fields
    {
        field(50000; "BC6_Active Quantity Management"; Boolean)
        {
            Caption = 'Active Quantity Management', comment = 'FRA="Activation Quantité Modification"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Acti. Releas. Print. Order"; Boolean)
        {
            Caption = 'Acti. Releas. Print. Order', comment = 'FRA="Activation Lancement de commande obligatoire"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Purcha. Code Grouping Line"; Code[10])
        {
            Caption = 'Purchasing Code Grouping Line', comment = 'FRA="Type procédure achat groupés"';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Technicals Directory Path"; Text[250])
        {
            Caption = 'Technicals Directory Path', comment = 'FRA="Chemin dossiers techniques"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_SAV Return Order Nos."; Code[10])
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'SAV Return Order Nos.', comment = 'FRA="N° Retour SAV"';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60000; BC6_Repertoire; Text[250])
        {
            Caption = 'Repertoire';
            DataClassification = CustomerContent;
        }
        field(60001; "BC6_E-Mail Administrateur"; Text[250])
        {
            Caption = 'E-Mail Administrateur', comment = 'FRA="-Mail Administrateur"';
            DataClassification = CustomerContent;
        }
        field(60002; "BC6_Promised Delivery Date"; Boolean)
        {
            Caption = 'Promised Delivery Date', comment = 'FRA="Date Livraison Confirmée"';
            DataClassification = CustomerContent;
        }
        field(60003; "BC6_Requested Delivery Date"; Boolean)
        {
            Caption = 'Requested Delivery Date', comment = 'FRA="Date Livraison Demandée"';
            DataClassification = CustomerContent;
        }
        field(60004; "Période"; DateFormula)
        {
            Caption = 'Period', comment = 'FRA="Période"';
            DataClassification = CustomerContent;
        }
        field(60005; BC6_Nbr_Devis; Integer)
        {
            Caption = 'Sales Qote', comment = 'FRA="Nombre de Devis"';
            DataClassification = CustomerContent;
        }
        field(60006; "BC6_PDF Mail Tag"; Text[30])
        {
            Caption = 'PDF Mail Tags', comment = 'FRA="Mots Clés PDF Mail"';
            DataClassification = CustomerContent;
        }
        field(60007; "BC6_Upd. Price AllowLine disc."; Boolean)
        {
            Caption = 'Update Price Allow Line disc.', comment = 'FRA="Maj aut. remise ligne dans prix"';
            DataClassification = CustomerContent;
        }
        field(60008; "BC6_allow Profit% to"; Code[20])
        {
            Caption = 'Allow Profit % visualisation to ', comment = 'FRA="Autoriser la visualisation des marges à"';
            TableRelation = "Permission Set"."Role ID"; //TODO: Table 'Permission Set' is marked for removal
            DataClassification = CustomerContent;
        }
        field(60009; "Contact's Address on sales doc"; Boolean)
        {
            Caption = 'Contact''s Address on sales doc', comment = 'FRA="Adresse du contact sur doc de vente"';
            DataClassification = CustomerContent;
        }
        field(60010; "BC6_RTE Fax Tag"; Text[30])
        {
            Caption = 'RTE Fax Tag', comment = 'FRA="RTE Fax Tag"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management', comment = 'FRA="Gestion DEEE"';
            DataClassification = CustomerContent;
        }
    }
}
