tableextension 50009 "BC6_PurchRcptHeader" extends "Purch. Rcpt. Header"
{
    LookupPageID = "Posted Purchase Receipts";
    DrillDownPageID = "Posted Purchase Receipts";
    fields
    {
        modify("Bal. Account No.")
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            TableRelation = Vendor;
        }
        field(50010; BC6_ID; Code[50])
        {
            TableRelation = User;
            //TODO
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit "418";
            //     CodLUserID: Code[50];
            // begin
            //     //>>MIGRATION NAV 2013
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            //     //<<MIGRATION NAV 2013
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
    }
}

