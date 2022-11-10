pageextension 50036 pageextension50036 extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Control 8")
        {
            field("External Document No."; "External Document No.")
            {
                Editable = false;
                Visible = false;
            }
        }
    }
    actions
    {
        addfirst("Action 34")
        {
            action("Apply Entries Payto CustNo")
            {
                Caption = 'Apply Entries Pay-to Customer No.';
                Image = EntriesList;
                RunObject = Page 232;
                RunPageLink = Pay-to Customer No.=FIELD(Customer No.),
                              Open=CONST(Yes);
                RunPageView = SORTING(Customer No.,Open);
                ShortCutKey = 'Ctrl+F9';
            }
        }
    }
}

