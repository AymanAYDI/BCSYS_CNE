tableextension 50020 "BC6_GenJournalLine" extends "Gen. Journal Line" //81
{
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'FRA="Code mode de règlement"';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.', comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[20])
        {
            Caption = 'DEEE Category Code', comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant HT DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';
            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
}
