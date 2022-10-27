tableextension 50051 "BC6_InvoicePostBuffer" extends "Invoice Post. Buffer"
{
    Caption = 'Invoice Post. Buffer', Comment = 'FRA="Tampon valid. facture"';
    fields
    {
        field(50003; "BC6_Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.', Comment = 'FRA="Tiers payeur"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Cat‚gorie DEEE"';
            Description = 'DEEE1.00';
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE', Comment = 'FRA="Montant HT DEEE"';
            Description = 'DEEE1.00';
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE', Comment = 'FRA="Montant TVA DEEE"';
            Description = 'DEEE1.00';
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Description = 'DEEE1.00';
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant HT DEEE (DS)"';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Type,G/L Account,Gen. Bus. Posting Group,Gen. Prod. Posting Group,VAT Bus. Posting Group,VAT Prod. Posting Group,Tax Area Code,Tax Group Code,Tax Liable,Use Tax,Dimension Set ID,Job No.,Fixed Asset Line No."(Key)".
        // key(Key1; Type, "G/L Account", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Area Code", "Tax Group Code", "Tax Liable", "Use Tax", "Dimension Set ID", "Job No.", "Fixed Asset Line No.", "Deferral Code") TODO:
        // {
        //     Clustered = true;
        // }
    }

}

