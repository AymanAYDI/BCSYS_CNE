pageextension 50081 "BC6_SalesListArchive" extends "Sales List Archive" //5161
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("BC6_Cause filing"; Rec."BC6_Cause filing")
            {
            }
            field(BC6_NO; Rec."No.")
            {
            }
        }
        addafter("Posting Date")
        {
            field(BC6_Amount; Rec.Amount)
            {
            }
            field("BC6_Amount Including VAT"; Rec."Amount Including VAT")
            {
            }
        }
    }
}

