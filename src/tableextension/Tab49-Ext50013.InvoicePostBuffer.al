tableextension 50013 "BC6_InvoicePostBuffer" extends "Invoice Post. Buffer" //49
{
    fields
    {
        field(50003; "BC6_Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Categorie DEEE"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE', Comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE', Comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', Comment = 'FRA="Montant TTC DEEE"';
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant HT DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Vendor;
        }
    }
}
