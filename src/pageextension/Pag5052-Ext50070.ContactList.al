pageextension 50070 "BC6_ContactList" extends "Contact List" //5052
{
    Editable = true;
    layout
    {
        modify("E-Mail")
        {
            Visible = false;
        }
        addafter("Name")
        {
            field(BC6_EMail; "E-Mail")
            {
            }
        }
    }
}

