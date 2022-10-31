tableextension 50069 "BC6_ReturnReceiptHeader" extends "Return Receipt Header"
{
    fields
    {
        //Unsupported feature: Property Insertion (Editable) on ""User ID"(Field 112)". TODO:
        field(50000; "BC6_Cause filing"; Option)
        {
            Caption = 'Cause filing';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID';
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d''achats & ventes';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50020; "BC6_Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order';
            Description = 'FE018 regroupement BL par CMD';
        }
        field(50026; "BC6_Purchase Cost"; Decimal)
        {
            Description = 'SM Besoin pour Etat Bible';
            Editable = false;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS';
            Description = 'SM Besoin pour Etat Bible';
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS';
            Description = 'SM  Besoin Etat Bible';
            Editable = true;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente';
            Description = 'SM Besoin pour Etat Bible';
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description';
        }
        field(50060; "BC6_Quote statut"; Option)
        {
            Caption = 'Quote status';
            OptionCaption = ' ,Approved,Locked';
            OptionMembers = " ",approved,locked;
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
    }

}

