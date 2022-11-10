pageextension 50138 pageextension50138 extends "Sales Quote Archives"
{
    layout
    {
        modify("Control 3")
        {
            Visible = false;
        }
        addfirst("Control 1")
        {
            field("No."; "No.")
            {
            }
        }
    }
}

