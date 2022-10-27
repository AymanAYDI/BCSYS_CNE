tableextension 50043 tableextension50043 extends "IC Outbox Purchase Header"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {
        field(50000; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

