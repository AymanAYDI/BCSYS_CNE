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
            field(BC6_ID; BC6_ID)
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

