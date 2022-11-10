pageextension 50125 pageextension50125 extends "Sales Invoice List"
{
    layout
    {
        modify("Control 12")
        {
            Visible = false;
        }
        addafter("Control 3")
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

