tableextension 50048 tableextension50048 extends "IC Inbox Purchase Header"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".

        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            Editable = false;
        }
        field(50000; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

