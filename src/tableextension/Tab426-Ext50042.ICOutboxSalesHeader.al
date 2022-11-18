<<<<<<<< HEAD:src/tableextension/Tab426-Ext50052.ICOutboxSalesHeader.al
tableextension 50052 "BC6_ICOutboxSalesHeader" extends "IC Outbox Sales Header" //426
========
tableextension 50042 "BC6_ICOutboxSalesHeader" extends "IC Outbox Sales Header" //426
>>>>>>>> 8827ca9eb83f82febb492d6f99c251815d558837:src/tableextension/Tab426-Ext50042.ICOutboxSalesHeader.al
{
    fields
    {

        field(50006; "BC6_Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

