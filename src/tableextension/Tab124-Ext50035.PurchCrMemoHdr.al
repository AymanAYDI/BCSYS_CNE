tableextension 50035 "BC6_PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr." //124
{
    fields
    {
        field(50000; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° Affaire"';
            DataClassification = CustomerContent;
            TableRelation = Job."No.";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
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
            Caption = 'From Sales Module', comment = 'FRA="Depuis Module Vente"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.', comment = 'FRA="N° télécopie preneur d''ordre"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key9; "Posting Date")
        {
        }
    }
}
