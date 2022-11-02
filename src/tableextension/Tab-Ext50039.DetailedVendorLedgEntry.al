tableextension 50039 "BC6_DetailedVendorLedgEntry" extends "Detailed Vendor Ledg. Entry"
{
    LookupPageID = "Detailed Vendor Ledg. Entries";
    DrillDownPageID = "Detailed Vendor Ledg. Entries";
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            TableRelation = Vendor;
        }
    }
    keys
    {

        key(Key14; "Ledger Entry Amount", "Vendor Ledger Entry No.", "Posting Date")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)";
        }
        key(Key15; "Initial Document Type", "Entry Type", "Vendor No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key16; "Vendor No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Initial Entry Due Date", "Posting Date")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }


    local procedure SetLedgerEntryAmount()
    begin
        "Ledger Entry Amount" :=
          NOT (("Entry Type" = "Entry Type"::Application) OR ("Entry Type" = "Entry Type"::"Appln. Rounding"));
    end;

}

