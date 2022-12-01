pageextension 50004 "BC6_GeneralLedgerEntries" extends "General Ledger Entries" //20
{
    layout
    {
        addafter("Posting Date")
        {
            field("BC6_VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}

