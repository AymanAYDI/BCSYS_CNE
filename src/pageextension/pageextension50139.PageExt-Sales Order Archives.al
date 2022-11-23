pageextension 50139 pageextension50139 extends "Sales Order Archives"
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

