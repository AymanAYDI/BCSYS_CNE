pageextension 50008 "BC6_VendorList" extends "Vendor List" //27
{
    layout
    {
        addafter(Name)
        {
            field("BC6_Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
            field(BC6_Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("BC6_Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(BC6_City; Rec.City)
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("BC6_Mini Amount"; Rec."BC6_Mini Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_Posting DEEE"; Rec."BC6_Posting DEEE")
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }
}
