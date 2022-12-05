pageextension 50108 "BC6_Account. Manag. RoleCenter" extends "Accounting Manager Role Center" //9001
{

    actions
    {
        addbefore("&G/L Trial Balance")
        {
            action("BC6_Statement avec traite")
            {
                //TODO : reports  // RunObject = Report 50038;
                Image = Report;
                Caption = 'Statement avec traite';
                ApplicationArea = All;
            }
            action("BC6_Statement sans traite")
            {
                //TODO : reports //  RunObject = Report 50039;
                Visible = FALSE;
                Image = Report;
                Caption = 'Statement sans traite';
                ApplicationArea = All;
            }
            action("BC6_Statement sans traite V2")
            {
                //TODO : reports  // RunObject = Report 50042;
                Image = Report;
                Caption = 'Statement sans traite V2';
                ApplicationArea = All;
            }
        }

        addafter("Bank Account Posting Groups")
        {
            action("BC6_Liste des sessions")
            {
                Caption = 'BC6_Liste des sessions';
                ApplicationArea = All;
                //TODO : reports  // RunObject = Page 9506;
            }
        }
    }
}
