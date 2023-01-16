pageextension 50085 "BC6_ResponsibilityCenterCard" extends "Responsibility Center Card" //5714
{
    layout
    {
        addafter("Location Code")
        {
            field(BC6_Picture; Rec."BC6_Picture")
            {
                ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("BC6_Alt Name 2"; Rec."BC6_Alt Name 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Address"; Rec."BC6_Alt Address")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Address 2"; Rec."BC6_Alt Address 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt City"; Rec."BC6_Alt City")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Phone No."; Rec."BC6_Alt Phone No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Phone No. 2"; Rec."BC6_Alt Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Telex No."; Rec."BC6_Alt Telex No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Fax No."; Rec."BC6_Alt Fax No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Post Code"; Rec."BC6_Alt Post Code")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt E-Mail"; Rec."BC6_Alt E-Mail")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Country Code"; Rec."BC6_Alt Country Code")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Home Page"; Rec."BC6_Alt Home Page")
                {
                    ApplicationArea = All;
                }
                field("BC6_Alt Picture"; Rec."BC6_Alt Picture")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
