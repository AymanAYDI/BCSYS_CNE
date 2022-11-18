tableextension 50053 "BC6_ICOutboxPurchaseHeader" extends "IC Outbox Purchase Header" //428 
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

