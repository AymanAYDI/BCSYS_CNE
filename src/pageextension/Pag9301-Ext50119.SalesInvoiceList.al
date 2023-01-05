pageextension 50119 "BC6_SalesInvoiceList" extends "Sales Invoice List" //9301
{
    layout
    {
        modify("Amount")
        {
            Visible = false;
        }
        addafter("Job Queue Status")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
            }
            field(BC6_Amount; Rec.Amount)
            {
            }
        }
    }
}

