tableextension 50031 "BC6_PurchRcptHeader" extends "Purch. Rcpt. Header" //120
{
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'ID', comment = 'FRA="Code utilisateur"';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module', comment = 'FRA="Code utilisateur"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.', comment = 'FRA="N° télécopie preneur d''ordre"';
            DataClassification = CustomerContent;
        }
    }
}
