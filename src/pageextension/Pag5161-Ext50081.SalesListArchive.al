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
                ApplicationArea = All;
            }
            field(BC6_NO; Rec."No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field(BC6_Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("BC6_Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
    }
}
