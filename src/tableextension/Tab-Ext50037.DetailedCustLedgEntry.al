tableextension 50037 "BC6_DetailedCustLedgEntry" extends "Detailed Cust. Ledg. Entry"
{
    LookupPageID = 573;
    DrillDownPageID = 573;
    fields
    {
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            TableRelation = Customer;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE';
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE';
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Editable = false;
            TableRelation = Vendor;
        }
    }
}

