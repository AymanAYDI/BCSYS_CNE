pageextension 50041 "BC6_VendorList" extends "Vendor List" //27
{
    layout
    {
        addafter(Name)
        {
            field("BC6_Name 2"; "Name 2")
            {
                ApplicationArea = All;
            }
            field(BC6_Address; Address)
            {
                ApplicationArea = All;
            }
            field("BC6_Address 2"; "Address 2")
            {
                ApplicationArea = All;
            }
            field(BC6_City; City)
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("BC6_Mini Amount"; "BC6_Mini Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_Posting DEEE"; "BC6_Posting DEEE")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }
}

