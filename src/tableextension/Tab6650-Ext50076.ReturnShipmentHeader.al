tableextension 50076 "BC6_ReturnShipmentHeader" extends "Return Shipment Header" //6650
{
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
            TableRelation = User;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module', Comment = 'FRA="Depuis Module Vente"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.', Comment = 'FRA="N° télécopie preneur d''ordre"';
            DataClassification = CustomerContent;
        }
    }
}
