pageextension 50042 "BC6_VendorLedgerEntries" extends "Vendor Ledger Entries" //29
{
    actions
    {
        addfirst("Ent&ry")
        {
            action("BC6_Apply Entries Pay-to Vendor No.")
            {
                Caption = 'Apply Entries Pay-to Vendor No.', Comment = 'FRA="Ecritures ouvertes Tiers payeur"';
                Image = Approve;
                RunObject = Page "Apply Vendor Entries";
                RunPageLink = "BC6_Pay-to Vend. No." = FIELD("Vendor No."),
                              Open = CONST(true);
                RunPageView = SORTING("Vendor No.", Open);
                ShortCutKey = 'Ctrl+F9';
            }
        }
    }
}

