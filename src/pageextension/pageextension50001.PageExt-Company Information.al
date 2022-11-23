pageextension 50001 pageextension50001 extends "Company Information"
{
    layout
    {
        addafter("Control 82")
        {
            field("Branch Company"; "Branch Company")
            {
            }
            field("Purchaser E-Mail"; "Purchaser E-Mail")
            {
            }
        }
        addafter("Control 1904604101")
        {
            group("Alt Company")
            {
                Caption = 'Alt Company';
                field("Alt Name"; "Alt Name")
                {
                }
                field("Alt Name 2"; "Alt Name 2")
                {
                }
                field("Alt Address"; "Alt Address")
                {
                }
                field("Alt Address 2"; "Alt Address 2")
                {
                }
                field("Alt City"; "Alt City")
                {
                }
                field("Alt Phone No."; "Alt Phone No.")
                {
                }
                field("Alt Phone No. 2"; "Alt Phone No. 2")
                {
                }
                field("Alt Telex No."; "Alt Telex No.")
                {
                }
                field("Alt Fax No."; "Alt Fax No.")
                {
                }
                field("Alt Post Code"; "Alt Post Code")
                {
                }
                field("Alt E-Mail"; "Alt E-Mail")
                {
                }
                field("Alt Country Code"; "Alt Country Code")
                {
                }
                field("Alt Home Page"; "Alt Home Page")
                {
                }
                field("Alt Picture"; "Alt Picture")
                {
                }
            }
            group("Alt2 Company")
            {
                Caption = 'Alt2 Company';
                field("Alt2 Name"; "Alt2 Name")
                {
                }
                field("Alt2 Phone No."; "Alt2 Phone No.")
                {
                }
                field("Alt2 Fax No."; "Alt2 Fax No.")
                {
                }
                field("Alt2 E-Mail"; "Alt2 E-Mail")
                {
                }
            }
        }
    }
}

