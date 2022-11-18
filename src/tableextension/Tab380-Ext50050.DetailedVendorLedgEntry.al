tableextension 50050 "BC6_DetailedVendorLedgEntry" extends "Detailed Vendor Ledg. Entry" //380
{
    fields
    {
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
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
}
