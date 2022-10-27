tableextension 50042 tableextension50042 extends "IC Outbox Sales Header"
{
    // //CNEIC : 06/2015 : ajout du champ 'Ship-to Contact'
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".

        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            Editable = false;
        }
        field(50006; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Description = 'CNEIC';
        }
    }
}

