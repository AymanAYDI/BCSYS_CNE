tableextension 50055 "BC6_HandledICOutboxSalesHeader" extends "Handled IC Outbox Sales Header" //430
{
    fields
    {
        field(50006; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact', comment = 'FRA="Contact destinataire"';
            DataClassification = CustomerContent;
        }
    }
}
