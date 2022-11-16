tableextension 50046 "BC6_HandledICOutboxPurchHdr" extends "Handled IC Outbox Purch. Hdr" //432
{

    fields
    {
        field(50000; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact', comment = 'FRA="Contact destinataire"';
            DataClassification = CustomerContent;
        }
    }
}

