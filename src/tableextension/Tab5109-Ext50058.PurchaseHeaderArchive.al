tableextension 50058 "BC6_PurchaseHeaderArchive" extends "Purchase Header Archive" //5109
{
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[20])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module', Comment = 'FRA="Depuis Module Vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.', Comment = 'FRA="N° télécopie preneur d''ordre"';
            DataClassification = CustomerContent;
        }
    }
}

