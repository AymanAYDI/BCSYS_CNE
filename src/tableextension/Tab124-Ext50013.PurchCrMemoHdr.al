tableextension 50013 "BC6_PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr." //124
{
    LookupPageID = "Posted Purchase Credit Memos";
    DrillDownPageID = "Posted Purchase Credit Memos";
    fields
    {
        field(50000; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° Affaire"';
            TableRelation = Job."No.";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[50])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
            //TODO : COD418
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit "User Management";
            //     CodLUserID: Code[50];
            // begin
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            // end;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module', comment = 'FRA="Depuis Module Vente"';
            Editable = false;
            DataClassification = CustomerContent;
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

