pageextension 50003 "BC6_GeneralLedgerEntries" extends "General Ledger Entries" //20
{
    layout
    {
        addafter("Posting Date")
        {
            field("BC6_VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
