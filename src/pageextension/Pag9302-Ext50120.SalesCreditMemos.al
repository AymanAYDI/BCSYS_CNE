pageextension 50120 "BC6_SalesCreditMemos" extends "Sales Credit Memos" //9302
{
    layout
    {
        addafter("Job Queue Status")
        {
            field(BC6_ID; BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Amount)
            {
                ApplicationArea = All;
            }
        }
    }
}

