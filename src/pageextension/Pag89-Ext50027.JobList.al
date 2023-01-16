pageextension 50027 "BC6_JobList" extends "Job List" //89
{
    layout
    {
        addafter("% Invoiced")
        {
            field(BC6_Awarder; Rec."BC6_Awarder")
            {
                ApplicationArea = All;
            }
            field("BC6_Awarder Contact Name"; Rec."BC6_Awarder Contact Name")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair Responsible"; Rec."BC6_Affair Responsible")
            {
                ApplicationArea = All;
            }
            field(BC6_Address; Rec."BC6_Address")
            {
                ApplicationArea = All;
            }
            field("BC6_Address 2"; Rec."BC6_Address 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Post Code"; Rec."BC6_Post Code")
            {
                ApplicationArea = All;
            }
            field(BC6_City; Rec."BC6_City")
            {
                ApplicationArea = All;
            }
            field(BC6_Country; Rec."BC6_Country")
            {
                ApplicationArea = All;
            }
            field(BC6_Contact; Rec."Bill-to Contact")
            {
                ApplicationArea = All;
                Caption = 'Bill-to Contact', comment = 'FRA="Montant projet"';
            }
            field("BC6_Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
            }
            field("BC6_Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
