tableextension 50051 "BC6_DetailedCVLedgEntryBuffer" extends "Detailed CV Ledg. Entry Buffer" //383
{
    fields
    {
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="DEEE TTC Amount"';
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA=""';
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
    keys
    {
    }
}
