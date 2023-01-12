pageextension 50085 "BC6_ResponsibilityCenterCard" extends "Responsibility Center Card" //5714
{
    layout
    {
        addafter("Location Code")
        {
            field(BC6_Picture; Rec."BC6_Picture")
            {
                Caption = 'Picture', Comment = 'FRA="Image"';

            }
        }
        addafter("Communication")
        {
            group("BC6_Alt Centre de Gestion")
            {
                Caption = 'Alt Centre de Gestion';
                field("BC6_Alt Name"; Rec."BC6_Alt Name")
                {
                }
                field("BC6_Alt Name 2"; Rec."BC6_Alt Name 2")
                {
                }
                field("BC6_Alt Address"; Rec."BC6_Alt Address")
                {
                }
                field("BC6_Alt Address 2"; Rec."BC6_Alt Address 2")
                {
                }
                field("BC6_Alt City"; Rec."BC6_Alt City")
                {
                }
                field("BC6_Alt Phone No."; Rec."BC6_Alt Phone No.")
                {
                }
                field("BC6_Alt Phone No. 2"; Rec."BC6_Alt Phone No. 2")
                {
                }
                field("BC6_Alt Telex No."; Rec."BC6_Alt Telex No.")
                {
                }
                field("BC6_Alt Fax No."; Rec."BC6_Alt Fax No.")
                {
                }
                field("BC6_Alt Post Code"; Rec."BC6_Alt Post Code")
                {
                }
                field("BC6_Alt E-Mail"; Rec."BC6_Alt E-Mail")
                {
                }
                field("BC6_Alt Country Code"; Rec."BC6_Alt Country Code")
                {
                }
                field("BC6_Alt Home Page"; Rec."BC6_Alt Home Page")
                {
                }
                field("BC6_Alt Picture"; Rec."BC6_Alt Picture")
                {
                }
            }
        }
    }

}

