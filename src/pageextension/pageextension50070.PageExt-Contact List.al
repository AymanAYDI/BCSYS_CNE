pageextension 50070 pageextension50070 extends "Contact List"
{
    Editable = true;
    layout
    {
        modify("Control 48")
        {
            Visible = false;
        }
        addafter("Control 4")
        {
            field("E-Mail"; "E-Mail")
            {
            }
        }
    }
}

