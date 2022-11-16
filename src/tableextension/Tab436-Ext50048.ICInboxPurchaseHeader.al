tableextension 50048 "BC6_ICInboxPurchaseHeader" extends "IC Inbox Purchase Header" //436
{
    fields
    {
        field(50000; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact', Comment = 'FRA="Contact destinataire"';
            DataClassification = CustomerContent;
        }
    }
}

