tableextension 50013 "BC6_PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr."
{
    LookupPageID = "Posted Purchase Credit Memos";
    DrillDownPageID = "Posted Purchase Credit Memos";
    fields
    {
        field(50000; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            TableRelation = Job."No.";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            TableRelation = Vendor;
        }
        field(50010; BC6_ID; Code[50])
        {
            TableRelation = User;
            //TODO : COD418
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit "418";
            //     CodLUserID: Code[50];
            // begin
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            // end;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.';
        }
    }
    keys
    {
        key(Key9; "Posting Date")
        {
        }
    }
}

