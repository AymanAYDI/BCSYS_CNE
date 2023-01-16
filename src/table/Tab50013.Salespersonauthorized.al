table 50013 "BC6_Salesperson authorized"
{
    DataClassification = CustomerContent;
    DrillDownPageID = "BC6_Salesperson authorized";
    LookupPageID = "BC6_Salesperson authorized";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', comment = 'FRA="N° client"';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(2; "Salesperson code"; Code[20])
        {
            Caption = 'Salesperson code', comment = 'FRA="Code vendeur"';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; authorized; Boolean)
        {
            Caption = 'authorized', comment = 'FRA="Autorisé"';
            DataClassification = CustomerContent;

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
        Error001: Label 'You can not uncheck for the salesperson of the customer card', comment = 'FRA="Vous ne pouvez décocher pour le vendeur de la fiche client"';
}
