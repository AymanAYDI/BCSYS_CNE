tableextension 50048 "BC6_ICInboxPurchaseHeader" extends "IC Inbox Purchase Header"
{
    Caption = 'IC Inbox Purchase Header', Comment = 'FRA="En-tête achat de la boîte de réception IC"';
    fields
    {
        field(50000; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact', Comment = 'FRA="Contact destinataire"';
        }
    }
}

