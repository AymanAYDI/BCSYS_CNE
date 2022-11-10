pageextension 50041 pageextension50041 extends "Vendor List"
{
    layout
    {
        addafter("Control 4")
        {
            field("Name 2"; "Name 2")
            {
            }
            field(Address; Address)
            {
            }
            field("Address 2"; "Address 2")
            {
            }
            field(City; City)
            {
            }
        }
        addafter("Control 12")
        {
            field("Mini Amount"; "Mini Amount")
            {
            }
            field("Posting DEEE"; "Posting DEEE")
            {
                ShowCaption = false;
            }
        }
    }
}

