pageextension 50042 pageextension50042 extends "Vendor Ledger Entries"
{
    actions
    {
        addfirst("Action 53")
        {
            action("Apply Entries Pay-to Vendor No.")
            {
                Caption = 'Apply Entries Pay-to Vendor No.';
                Image = Approve;
                RunObject = Page 233;
                RunPageLink = Pay-to Vend. No.=FIELD(Vendor No.),
                              Open=CONST(Yes);
                RunPageView = SORTING(Vendor No.,Open);
                ShortCutKey = 'Ctrl+F9';
            }
        }
    }
}

