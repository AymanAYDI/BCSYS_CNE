tableextension 50047 "BC6_ICInboxSalesHeader" extends "IC Inbox Sales Header" //434
{
    fields
    {
        field(50006; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact', Comment = 'FRA="Contact destinataire"';
            DataClassification = CustomerContent;
        }
    }
}

