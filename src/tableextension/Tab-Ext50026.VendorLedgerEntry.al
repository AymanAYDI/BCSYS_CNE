tableextension 50026 "BC6_VendorLedgerEntry" extends "Vendor Ledger Entry"
{
    LookupPageID = "Vendor Ledger Entries";
    DrillDownPageID = "Vendor Ledger Entries";
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            TableRelation = Vendor;
        }
    }
    keys
    {
        //TODO:keys
        // key(Key26; "BC6_Pay-to Vend. No.", Open, Positive, "Due Date")
        // {
        // }
        // key(Key27; "BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.")
        // {
        // }

    }


    procedure "---NSC1.00---"()
    begin
    end;

    procedure getVendorName(CodLVendNo: Code[20]): Text[30]
    var
        RecgLVendor: Record Vendor;
    begin
        IF RecgLVendor.GET(CodLVendNo) THEN
            EXIT(RecgLVendor.Name)
        ELSE
            EXIT('');
    end;

}

