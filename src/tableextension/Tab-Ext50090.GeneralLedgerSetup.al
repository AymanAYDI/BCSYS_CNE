tableextension 50090 "BC6_GeneralLedgerSetup" extends "General Ledger Setup"
{
    fields
    {
        field(80800; "BC6_DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management';
        }
        field(80810; "BC6_DEEE Sales line prefix"; Text[30])
        {
            Caption = 'DEEE Sales line prefix';
        }
        field(80811; "BC6_DEEE Purchases line prefix"; Text[30])
        {
            Caption = 'DEEE Purchases line prefix';
        }
        field(80820; "BC6_Sales Tax Recalcul"; Boolean)
        {
            Caption = 'Sales Tax Recalcul';
        }
        field(80840; "BC6_DEEE Business Group ID"; Code[10])
        {
            Caption = 'DEEE Business Group ID';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(80841; "BC6_Defaut Eco partner DEEE"; Code[20])
        {
            Caption = 'Defaut Eco partnaire';
            TableRelation = Vendor;
        }
    }

}

