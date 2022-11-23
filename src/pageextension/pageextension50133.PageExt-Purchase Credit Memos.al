pageextension 50133 pageextension50133 extends "Purchase Credit Memos"
{
    layout
    {
        modify("Control 39")
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

