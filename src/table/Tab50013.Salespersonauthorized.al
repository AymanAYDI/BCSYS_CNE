table 50013 "BC6_Salesperson authorized"
{
    Caption = 'Salesperson authorized';
    //TODO:Page
    // DrillDownPageID = 50046;
    // LookupPageID = 50046;

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
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; authorized; Boolean)
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
        key(Key1; "Customer No.", "Salesperson code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecGCustomer: Record Customer;
        Error001: Label 'You can not uncheck for the salesperson of the customer card';
}

