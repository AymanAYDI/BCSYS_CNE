table 50013 "Salesperson authorized"
{
    // ---------------------------------------------------------------
    //  Prodware - www.prodware.fr
    // ---------------------------------------------------------------
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Create

    Caption = 'Salesperson authorized';
    DrillDownPageID = 50046;
    LookupPageID = 50046;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; "Salesperson code"; Code[10])
        {
            Caption = 'Salesperson code';
            TableRelation = Salesperson/Purchaser;
        }
        field(3;authorized;Boolean)
        {
            Caption = 'authorized';

            trigger OnValidate()
            begin
                IF NOT authorized THEN BEGIN
                   RecGCustomer.GET("Customer No.");
                   IF RecGCustomer."Salesperson Code" = "Salesperson code" THEN
                      ERROR(Error001);
                END;
            end;
        }
    }

    keys
    {
        key(Key1;"Customer No.","Salesperson code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecGCustomer: Record "18";
        Error001: Label 'You can not uncheck for the salesperson of the customer card';
}

