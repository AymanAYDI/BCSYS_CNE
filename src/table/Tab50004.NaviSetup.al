table 50004 "BC6_Navi+ Setup"
{
    Caption = 'Navi+ Setup', comment = 'FRA="Paramètres Navi+"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Key"; Code[10])
        {
            Caption = 'Key', comment = 'FRA="Clé"';
            DataClassification = CustomerContent;
        }
        field(2; "Parm Msg franco de port"; Boolean)
        {
            Caption = 'Print Msg about sending', comment = 'FRA="Edt Msg Franco de Port"';
            DataClassification = CustomerContent;
        }
        field(3; "Parm Ctrl price on order"; Boolean)
        {
            Caption = 'Ctrl order price', comment = 'FRA="Ctrl prix sur cde"';
            DataClassification = CustomerContent;
        }
        field(4; "Parm Sample Order"; Boolean)
        {
            Caption = 'Sample Order', comment = 'FRA="Cde d''échantillon"';
            DataClassification = CustomerContent;
        }
        field(5; "Parm Eco Emballage"; Boolean)
        {
            Caption = 'Eco-Emballage', comment = 'FRA="Eco-Emballage"';
            DataClassification = CustomerContent;
        }
        field(6; "Parm Logistique"; Boolean)
        {
            Caption = 'Logistique', comment = 'FRA="Logistique"';
            DataClassification = CustomerContent;
        }
        field(7; "Filing Sales Quotes"; Boolean)
        {
            Caption = 'Filing Sales Quotes', comment = 'FRA="Archivage Devis vente"';
            DataClassification = CustomerContent;
        }
        field(8; "Filing Sales Orders"; Boolean)
        {
            Caption = 'Filing Sales Orders', comment = 'FRA="Archivage Commande Vente"';
            DataClassification = CustomerContent;
        }
        field(9; "Eclater nomenclature en auto"; Boolean)
        {
            Caption = 'Explode BOM automaticaly', comment = 'FRA="Eclater nomenclature en Auto"';
            DataClassification = CustomerContent;
        }
        field(10; "Date jour en factur/livraison"; Boolean)
        {
            Caption = 'Day date for invoices and deliveries', comment = 'FRA="Date du jour pour les dates de facture ou livraisons"';
            DataClassification = CustomerContent;
        }
        field(11; "Used Post-it"; Code[10])
        {
            Caption = 'Utilisé Post-it', comment = 'FRA="Utilisé Post-it"';
            DataClassification = CustomerContent;
        }
        field(12; "Affichage du N° BL"; Boolean)
        {
            Caption = 'Affichage du N° BL', comment = 'FRA="Affichage du N° BL"';
            DataClassification = CustomerContent;
        }
        field(13; "Affichage du N° BR"; Boolean)
        {
            Caption = 'Affichage du N° BR', comment = 'FRA="Affichage du N° BR"';
            DataClassification = CustomerContent;
        }
        field(14; "Four: Date jour en Fact/recept"; Boolean)
        {
            Caption = 'Four: Date jour en Fact/recept', comment = 'FRA="Four: Date jour en Fact/recept"';
            DataClassification = CustomerContent;
        }
        field(15; "Affichage N° facture Ventes"; Boolean)
        {
            Caption = 'Affichage N° facture Ventes', comment = 'FRA="Affichage N° facture Ventes"';
            DataClassification = CustomerContent;
        }
        field(16; "Affichage N° facture Achat"; Boolean)
        {
            Caption = 'Affichage N° facture Achat', comment = 'FRA="Affichage N° facture Achat"';
            DataClassification = CustomerContent;
        }
        field(17; "Date jour ds date facture Acha"; Boolean)
        {
            Caption = 'Date jour ds date facture Acha', comment = 'FRA="Date jour ds date facture Acha"';
            DataClassification = CustomerContent;
        }
        field(101; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure', comment = 'FRA="Unité de base"';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(102; "Costing Method"; Enum "Costing Method")
        {
            Caption = 'Costing Method', comment = 'FRA="Mode évaluation stock"';
            DataClassification = CustomerContent;
        }
        field(103; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', comment = 'FRA="Groupe compta. produit"';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(104; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', comment = 'FRA="Groupe compta. produit TVA"';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(105; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group', comment = 'FRA="Groupe compta. stock"';
            TableRelation = "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(106; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure', comment = 'FRA="Unité de vente"';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(107; "Replenishment System"; Option)
        {
            Caption = 'Replenishment System', comment = 'FRA="Système réappro."';
            OptionCaption = 'Purchase,Prod. Order, ';
            OptionMembers = Purchase,"Prod. Order"," ";
            DataClassification = CustomerContent;
        }
        field(108; "Lead Time Calculation Item"; DateFormula)
        {
            Caption = 'Lead Time Calculation Item', comment = 'FRA="Délai de réappro. article"';
            DataClassification = CustomerContent;
        }
        field(109; "Reordering Policy"; Enum "BC6_Reordering Policy")
        {
            Caption = 'Reordering Policy', comment = 'FRA="Méthode réapprovisionnement"';
            DataClassification = CustomerContent;
        }
        field(110; "Include Inventory"; Boolean)
        {
            Caption = 'Include Inventory', comment = 'FRA="Inclure stock"';
            DataClassification = CustomerContent;
        }
        field(111; "Reserve Item"; Enum "Reserve Method")
        {
            Caption = 'Reserve Item', comment = 'FRA="Réserver article"';
            InitValue = Optional;
            DataClassification = CustomerContent;
        }
        field(112; "Order Tracking Policy"; Enum "Order Tracking Policy")
        {
            Caption = 'Order Tracking Policy', comment = 'FRA="Chaînage dynamique"';
            DataClassification = CustomerContent;
        }
        field(201; "Gen. Bus. Posting Group Vendor"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group Vendor', comment = 'FRA="Groupe compta. marché fournisseur"';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(202; "VAT Bus. Posting Group Vendor"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group Vendor', comment = 'FRA="Groupe compta. marché TVA fournisseur"';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(203; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group', comment = 'FRA="Groupe compta. fournisseur"';
            TableRelation = "Vendor Posting Group";
            DataClassification = CustomerContent;
        }
        field(204; "Lead Time Calculation Vendor"; DateFormula)
        {
            Caption = 'Lead Time Calculation Vendor', comment = 'FRA="Délai de réappro. fournisseur"';
            DataClassification = CustomerContent;
        }
        field(205; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code', comment = 'FRA="Code acheteur"';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(206; "Application Method Vendor"; Enum "BC6_App. Meth. Cust")
        {
            Caption = 'Application Method Vendor', comment = 'FRA="Mode de lettrage fournisseur"';
            DataClassification = CustomerContent;
        }
        field(207; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'FRA="Code condition paiement"';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(208; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'FRA="Code mode de règlement"';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(209; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code', comment = 'FRA="Code calendrier principal"';
            TableRelation = "Base Calendar";
            DataClassification = CustomerContent;
        }
        field(301; "Country Code"; Code[10])
        {
            Caption = 'Country Code', comment = 'FRA="Code pays"';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(302; "Gen. Bus. Posting Group Cust."; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group Cust.', comment = 'FRA="Groupe compta. marché client"';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(303; "VAT Bus. Posting Group Cust."; Code[10])
        {
            Caption = 'VAT Bus. Posting Group Cust.', comment = 'FRA="Groupe compta. marché TVA client"';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(304; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group', comment = 'FRA="Groupe compta. client"';
            TableRelation = "Customer Posting Group";
            DataClassification = CustomerContent;
        }
        field(306; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.', comment = 'FRA="Autoriser remise ligne"';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(307; "Application Method Customer"; Enum "BC6_App. Meth. Cust")
        {
            Caption = 'Application Method Customer', comment = 'FRA="Mode de lettrage client"';
            DataClassification = CustomerContent;
        }
        field(308; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements', comment = 'FRA="Imprimer relevés"';
            DataClassification = CustomerContent;
        }
        field(309; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments', comment = 'FRA="Regroupement B.L."';
            DataClassification = CustomerContent;
        }
        field(310; "Reserve Customer"; Enum "Reserve Method")
        {
            Caption = 'Reserve Customer', comment = 'FRA="Réserver client"';
            InitValue = Optional;
            DataClassification = CustomerContent;
        }
        field(311; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            Caption = 'Shipping Advice', comment = 'FRA="Option d''expédition"';
            DataClassification = CustomerContent;
        }
        field(312; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies', comment = 'FRA="Nombre exemplaires facture"';
            DataClassification = CustomerContent;
        }
        field(313; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time', comment = 'FRA="Délai d''expédition"';
            DataClassification = CustomerContent;
        }
        field(314; "Catalog import Path"; Text[250])
        {
            Caption = 'Catalog Import Path', comment = 'FRA="Chemin d''import catalog"';
            DataClassification = CustomerContent;
        }
        field(315; "Customer Location Code"; Code[10])
        {
            Caption = 'Customer Location Code', comment = 'FRA="Code magasin client"';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(316; "Vendor Location Code"; Code[10])
        {
            Caption = 'Vendor Location Code', comment = 'FRA="Code magasin fournisseur"';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(317; "Filing Purchases Orders"; Boolean)
        {
            Caption = 'Filing Purchase Order', comment = 'FRA="Archivage commandes d''achats"';
            DataClassification = CustomerContent;
        }
        field(318; "Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE', comment = 'FRA="Soumis à la DEEE"';
            DataClassification = CustomerContent;
        }
        field(319; "Posting DEEE"; Boolean)
        {
            Caption = 'Posting DEEE', comment = 'FRA="Comptabilisation DEEE"';
            DataClassification = CustomerContent;
        }
        field(320; "Default Directory"; Text[250])
        {
            Caption = 'Default Directory', comment = 'FRA="Répertoire par defaut"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
