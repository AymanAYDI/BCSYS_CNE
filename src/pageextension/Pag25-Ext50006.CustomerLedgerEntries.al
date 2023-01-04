pageextension 50006 "BC6_CustomerLedgerEntries" extends "Customer Ledger Entries" //25
{
    layout
    {
        addafter("Customer No.")
        {
            field("BC6_External Document No."; Rec."External Document No.")
            {
                Editable = false;
                Visible = false;
            }
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action("BC6_Apply Entries Payto CustNo")
            {
                Caption = 'Apply Entries Pay-to Customer No.', Comment = 'FRA="Ecritures ouvertes Tiers payeur"';
                Image = EntriesList;
                RunObject = Page "Apply Customer Entries";
                RunPageLink = "BC6_Pay-to Customer No." = FIELD("Customer No."),
                              Open = CONST(true);
                RunPageView = SORTING("Customer No.", Open);
                ShortCutKey = 'Ctrl+F9';
            }
        }
    }
}

