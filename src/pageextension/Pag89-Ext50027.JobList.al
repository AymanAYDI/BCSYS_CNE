pageextension 50027 "BC6_JobList" extends "Job List" //89
{
    layout
    {
        addafter("% Invoiced")
        {
            field(BC6_Awarder; Rec."BC6_Awarder")
            {
            }
            field("BC6_Awarder Contact Name"; Rec."BC6_Awarder Contact Name")
            {
            }
            field("BC6_Affair Responsible"; Rec."BC6_Affair Responsible")
            {
            }
            field(BC6_Address; Rec."BC6_Address")
            {
            }
            field("BC6_Address 2"; Rec."BC6_Address 2")
            {
            }
            field("BC6_Post Code"; Rec."BC6_Post Code")
            {
            }
            field(BC6_City; Rec."BC6_City")
            {
            }
            field(BC6_Country; Rec."BC6_Country")
            {
            }
            field(BC6_Contact; Rec."Bill-to Contact")
            {
                Caption = 'Bill-to Contact', comment = 'FRA="Montant projet"';
            }
            field("BC6_Starting Date"; Rec."Starting Date")
            {
            }
            field("BC6_Ending Date"; Rec."Ending Date")
            {
            }

        }
    }
}
