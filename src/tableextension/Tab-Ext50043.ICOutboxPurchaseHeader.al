tableextension 50043 "BC6_ICOutboxPurchaseHeader" extends "IC Outbox Purchase Header"
{
    fields
    {
        field(50000; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

