tableextension 50058 "BC6_PurchaseHeaderArchive" extends "Purchase Header Archive"
{
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010; BC6_ID; Code[20])
        {
            Description = 'FE019';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
    }
}

