table 50004 "BC6_Navi+ Setup"
{
    Caption = 'Navi+ Setup';

    fields
    {
        field(1; "Key"; Code[10])
        {
            Caption = 'Key';
        }
        field(2; "Parm Msg franco de port"; Boolean)
        {
            Caption = 'Print Msg about sending';
        }
        field(3; "Parm Ctrl price on order"; Boolean)
        {
            Caption = 'Ctrl order price';
        }
        field(4; "Parm Sample Order"; Boolean)
        {
            Caption = 'Sample Order';
        }
        field(5; "Parm Eco Emballage"; Boolean)
        {
            Caption = 'Eco-Emballage';
        }
        field(6; "Parm Logistique"; Boolean)
        {
            Caption = 'Logistique';
        }
        field(7; "Filing Sales Quotes"; Boolean)
        {
            Caption = 'Filing Sales Quotes';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis]';
        }
        field(8; "Filing Sales Orders"; Boolean)
        {
            Caption = 'Filing Sales Orders';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Cde]';
        }
        field(9; "Eclater nomenclature en auto"; Boolean)
        {
            Caption = 'Explode BOM automaticaly';
        }
        field(10; "Date jour en factur/livraison"; Boolean)
        {
            Caption = 'Day date for invoices and deliveries';
        }
        field(11; "Used Post-it"; Code[10])
        {
            Caption = 'Used Post-it';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It]';
        }
        field(12; "Affichage du N° BL"; Boolean)
        {
        }
        field(13; "Affichage du N° BR"; Boolean)
        {
        }
        field(14; "Four: Date jour en Fact/recept"; Boolean)
        {
        }
        field(15; "Affichage N° facture Ventes"; Boolean)
        {
        }
        field(16; "Affichage N° facture Achat"; Boolean)
        {
        }
        field(17; "Date jour ds date facture Acha"; Boolean)
        {
        }
        field(101; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(102; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            Description = 'DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut Standard';
            OptionCaption = 'Standard,FIFO,LIFO,Specific,Average';
            OptionMembers = Standard,FIFO,LIFO,Specific,"Average";
        }
        field(103; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(104; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(105; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(106; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(107; "Replenishment System"; Option)
        {
            Caption = 'Replenishment System';
            OptionCaption = 'Purchase,Prod. Order, ';
            OptionMembers = Purchase,"Prod. Order"," ";
        }
        field(108; "Lead Time Calculation Item"; DateFormula)
        {
            Caption = 'Lead Time Calculation Item';
        }
        field(109; "Reordering Policy"; Option)
        {
            Caption = 'Reordering Policy';
            Description = 'DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut Maximum Qty.,';
            OptionCaption = 'Maximum Qty.,Fixed Reorder Qty.,Order,Lot-for-Lot';
            OptionMembers = "Maximum Qty.","Fixed Reorder Qty.","Order","Lot-for-Lot";
        }
        field(110; "Include Inventory"; Boolean)
        {
            Caption = 'Include Inventory';
        }
        field(111; "Reserve Item"; Option)
        {
            Caption = 'Reserve Item';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(112; "Order Tracking Policy"; Option)
        {
            Caption = 'Order Tracking Policy';
            OptionCaption = 'None,Tracking Only,Tracking & Action Msg.';
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";


        }
        field(201; "Gen. Bus. Posting Group Vendor"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group Vendor';
            TableRelation = "Gen. Business Posting Group";
        }
        field(202; "VAT Bus. Posting Group Vendor"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group Vendor';
            TableRelation = "VAT Business Posting Group";
        }
        field(203; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(204; "Lead Time Calculation Vendor"; DateFormula)
        {
            Caption = 'Lead Time Calculation Vendor';
        }
        field(205; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(206; "Application Method Vendor"; Option)
        {
            Caption = 'Application Method Vendor';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(207; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(208; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(209; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(301; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(302; "Gen. Bus. Posting Group Cust."; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group Cust.';
            TableRelation = "Gen. Business Posting Group";
        }
        field(303; "VAT Bus. Posting Group Cust."; Code[10])
        {
            Caption = 'VAT Bus. Posting Group Cust.';
            TableRelation = "VAT Business Posting Group";
        }
        field(304; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(306; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(307; "Application Method Customer"; Option)
        {
            Caption = 'Application Method Customer';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(308; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(309; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(310; "Reserve Customer"; Option)
        {
            Caption = 'Reserve Customer';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(311; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(312; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }
        field(313; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(314; "Catalog import Path"; Text[250])
        {
            Caption = 'Catalog Import Path';
        }
        field(315; "Customer Location Code"; Code[10])
        {
            Caption = 'Code magasin client';
            TableRelation = Location.Code;
        }
        field(316; "Vendor Location Code"; Code[10])
        {
            Caption = 'Code magasin fournisseur';
            TableRelation = Location.Code;
        }
        field(317; "Filing Purchases Orders"; Boolean)
        {
            Caption = 'Filing Purchase Order';
        }
        field(318; "Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE';
            Description = 'DEEE1.00';
        }
        field(319; "Posting DEEE"; Boolean)
        {
            Caption = 'Posting DEEE';
            Description = 'DEEE1.00';
        }
        field(320; "Default Directory"; Text[250])
        {
            Caption = 'Default Directory';
            Description = 'CNE2.05';
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

