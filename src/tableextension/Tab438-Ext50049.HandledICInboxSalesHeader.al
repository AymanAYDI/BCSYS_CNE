tableextension 50049 "BC6_HandledICInboxSalesHeader" extends "Handled IC Inbox Sales Header" //438
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

