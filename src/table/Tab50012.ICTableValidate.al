table 50012 "BC6_IC Table Validate"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Partner Code"; Code[20])
        {
            Caption = 'Partner Code', comment = 'FRA="Code Partenaire IC"';
            DataClassification = CustomerContent;
        }
        field(2; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.', comment = 'FRA="N° Bon Expédition"';
            DataClassification = CustomerContent;
        }
        field(10; "Navision Company"; Text[250])
        {
            Caption = 'Navision Company', comment = 'FRA="Code Société"';
            DataClassification = CustomerContent;
        }
        field(11; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code', comment = 'FRA="N° Client"';
            DataClassification = CustomerContent;
        }
        field(12; "Purch Order IC No."; Code[20])
        {
            Caption = 'Purch Order IC No.', comment = 'FRA="N° Commande Achat IC Lien"';
            DataClassification = CustomerContent;
        }
        field(13; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.', comment = 'FRA="N° ligne Bon Expédition"';
            DataClassification = CustomerContent;
        }
        field(14; "Purch Order IC Line"; Integer)
        {
            Caption = 'Purch Order IC Line', comment = 'FRA="N° ligne commande achat IC lien"';
            DataClassification = CustomerContent;
        }
        field(15; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive', comment = 'FRA="Qté à recevoir"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(16; "Purchase cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Purchase cost', comment = 'FRA="Coût d`achat"';
            DecimalPlaces = 2 : 5;
            Description = 'hors taxe';
            DataClassification = CustomerContent;
        }
        field(20; "Validate"; Boolean)
        {
            Caption = 'Validate', comment = 'FRA="Valider"';
            DataClassification = CustomerContent;
        }
        field(21; "Validate Date"; Date)
        {
            Caption = 'Validate Date', comment = 'FRA="Date de validation"';
            DataClassification = CustomerContent;
        }
        field(33000; Canceled; Boolean)
        {
            Caption = 'Canceled', comment = 'FRA="Annulé"';
            DataClassification = CustomerContent;
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
