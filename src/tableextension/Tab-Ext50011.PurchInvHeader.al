tableextension 50011 "BC6_PurchInvHeader" extends "Purch. Inv. Header"
{
    LookupPageID = 146;
    DrillDownPageID = 146;
    fields
    { //TODO //Paid n'est pas declarer dans le STD 
        // modify(Paid)
        // {

        //     Caption = 'Closed';
        // }
        field(50000; "BC6_Affaire No."; Code[20])
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
            //TODO: codeunit418
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
            Description = 'FE005 SEBC 08/01/2007';
        }
    }
    keys
    {
    }
}

