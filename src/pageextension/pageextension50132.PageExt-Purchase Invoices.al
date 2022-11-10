pageextension 50132 pageextension50132 extends "Purchase Invoices"
{
    layout
    {
        modify("Control 16")
        {
            Visible = false;
        }
        addafter("Control 5")
        {
            field(ID; ID)
            {
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
            field(Amount; Amount)
            {
            }
        }
    }
}

