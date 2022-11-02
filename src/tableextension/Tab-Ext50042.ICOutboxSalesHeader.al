tableextension 50042 "BC6_ICOutboxSalesHeader" extends "IC Outbox Sales Header"
{
    fields
    {

        field(5791; "BC6_Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            Editable = false;
        }
        field(50006; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

