tableextension 50060 "BC6_HandledICInboxPurchHeader" extends "Handled IC Inbox Purch. Header" //440
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
