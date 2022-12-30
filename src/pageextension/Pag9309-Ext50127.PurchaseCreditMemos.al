pageextension 50127 "BC6_PurchaseCreditMemos" extends "Purchase Credit Memos" //9309
{
    layout
    {
        modify("Amount")
        {
            Visible = false;
        }
        addafter("Job Queue Status")
        {
            field(BC6_ID; ID)
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
            field(BC6_Amount; Amount)
            {
            }
        }
    }
}

