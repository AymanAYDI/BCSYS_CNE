tableextension 50040 "BC6_DetailedCVLedgEntryBuffer" extends "Detailed CV Ledg. Entry Buffer"
{
    LookupPageID = 573;
    DrillDownPageID = 573;
    fields
    {
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE';
            Description = 'DEEE1.00';
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE';
            Description = 'DEEE1.00';
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Description = 'DEEE1.00';
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {
    }

}

