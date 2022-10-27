tableextension 50047 tableextension50047 extends "IC Inbox Sales Header"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {
        field(50006; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

