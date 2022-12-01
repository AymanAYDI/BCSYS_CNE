pageextension 50000 "BC6_CompanyInformation" extends "Company Information" //1
{
    layout
    {
        addafter("IC Inbox Details")
        {
            field("BC6_Branch Company"; "BC6_Branch Company")
            {
                ApplicationArea = All;
            }
            field("BC6_Purchaser E-Mail"; "BC6_Purchaser E-Mail")
            {
                ApplicationArea = All;
            }
        }
        addafter("System Indicator")
        {
            group("BC6_Alt Company")
            {
                Caption = 'Alt Company', Comment = 'FRA="Alt Société"';
                field("BC6_Alt Name"; "BC6_Alt Name")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Name 2"; "BC6_Alt Name 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Address"; "BC6_Alt Address")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Address 2"; "BC6_Alt Address 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt City"; "BC6_Alt City")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Phone No."; "BC6_Alt Phone No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Phone No. 2"; "BC6_Alt Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Telex No."; "BC6_Alt Telex No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Fax No."; "BC6_Alt Fax No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Post Code"; "BC6_Alt Post Code")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt E-Mail"; "BC6_Alt E-Mail")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Country Code"; "BC6_Alt Country Code")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Home Page"; "BC6_Alt Home Page")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Picture"; "BC6_Alt Picture")
                {
                    ApplicationArea = All;
                }
            }
            group("BC6_Alt2 Company")
            {
                Caption = 'Alt2 Company', Comment = 'FRA="Alt2 Société"';
                field("BC6_Alt2 Name"; "BC6_Alt2 Name")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt2 Phone No."; "BC6_Alt2 Phone No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt2 Fax No."; "BC6_Alt2 Fax No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt2 E-Mail"; "BC6_Alt2 E-Mail")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
