pageextension 50025 "BC6_PostedPurchaseCreditMemos" extends "Posted Purchase Credit Memos" //147
{
    layout
    {
        addafter("Applies-to Doc. Type")
        {
            field("BC6_Return Order No."; "Return Order No.")
            {
            }
        }
    }
}

