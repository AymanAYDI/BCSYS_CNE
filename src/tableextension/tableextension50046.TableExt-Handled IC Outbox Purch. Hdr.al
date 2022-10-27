tableextension 50046 tableextension50046 extends "Handled IC Outbox Purch. Hdr"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            Editable = false;
        }
        field(50000; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

