tableextension 50049 tableextension50049 extends "Handled IC Inbox Sales Header"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            Editable = false;
        }
        field(50006; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

