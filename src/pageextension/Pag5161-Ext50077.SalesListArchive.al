pageextension 50077 "BC6_SalesListArchive" extends "Sales List Archive" //5161
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("BC6_Cause filing"; "BC6_Cause filing")
            {
            }
            field(BC6_NO; "No.")
            {
            }
        }
        addafter("Posting Date")
        {
            field(BC6_Amount; Amount)
            {
            }
            field("BC6_Amount Including VAT"; "Amount Including VAT")
            {
            }
        }
    }
}

