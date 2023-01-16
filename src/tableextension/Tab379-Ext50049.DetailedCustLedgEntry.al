tableextension 50049 "BC6_DetailedCustLedgEntry" extends "Detailed Cust. Ledg. Entry" //379
{
    fields
    {
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Customer;
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
            Caption = 'DEEE TTC Amount';
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
