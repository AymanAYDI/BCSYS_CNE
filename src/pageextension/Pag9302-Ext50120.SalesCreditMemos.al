pageextension 50120 "BC6_SalesCreditMemos" extends "Sales Credit Memos" //9302
{
    layout
    {
        addafter("Job Queue Status")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
    }
}
