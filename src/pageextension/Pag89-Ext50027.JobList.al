pageextension 50027 "BC6_JobList" extends "Job List" //89
{
    layout
    {
        addafter("% Invoiced")
        {
            field(BC6_Awarder; "BC6_Awarder")
            {
            }
            field("BC6_Awarder Contact Name"; "BC6_Awarder Contact Name")
            {
            }
            field("BC6_Affair Responsible"; "BC6_Affair Responsible")
            {
            }
            field(BC6_Address; "BC6_Address")
            {
            }
            field("BC6_Address 2"; "BC6_Address 2")
            {
            }
            field("BC6_Post Code"; "BC6_Post Code")
            {
            }
            field(BC6_City; "BC6_City")
            {
            }
            field(BC6_Country; "BC6_Country")
            {
            }
            field(BC6_Contact; "Bill-to Contact")
            {
                Caption = 'Bill-to Contact', comment = 'FRA="Montant projet"';
            }
            field("BC6_Starting Date"; "Starting Date")
            {
            }
            field("BC6_Ending Date"; "Ending Date")
            {
            }

        }
    }
}
