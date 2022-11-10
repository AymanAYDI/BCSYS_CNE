pageextension 50077 pageextension50077 extends "Sales List Archive"
{
    layout
    {
        modify("Control 3")
        {
            Visible = false;
        }
        addfirst("Control 1")
        {
            field("Cause filing"; "Cause filing")
            {
            }
            field("No."; "No.")
            {
            }
        }
        addafter("Control 40")
        {
            field(Amount; Amount)
            {
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
            }
        }
    }
}

