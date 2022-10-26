table 50012 "IC Table Validate"
{
    // // CNEIC : 06/2015 : nouvelle table pour valider les doc IC


    fields
    {
        field(1; "Partner Code"; Code[20])
        {
            Caption = 'Partner Code';
        }
        field(2; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
        }
        field(10; "Navision Company"; Text[250])
        {
            Caption = 'Navision Company';
        }
        field(11; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
        }
        field(12; "Purch Order IC No."; Code[20])
        {
            Caption = 'Purch Order IC No.';
        }
        field(13; "Shipment Line No."; Integer)
        {
            Caption = 'N° ligne Bon Expédition';
        }
        field(14; "Purch Order IC Line"; Integer)
        {
            Caption = 'N° ligne commande achat IC lien';
        }
        field(15; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Purchase cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Purchase cost';
            DecimalPlaces = 2 : 5;
            Description = 'hors taxe';
        }
        field(20; Validate; Boolean)
        {
            Caption = 'Validate';
        }
        field(21; "Validate Date"; Date)
        {
            Caption = 'Validate Date';
        }
        field(33000; Canceled; Boolean)
        {
            Caption = 'Canceled';
        }
    }

    keys
    {
        key(Key1; "Partner Code", "Shipment No.", "Purch Order IC No.", "Purch Order IC Line")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

