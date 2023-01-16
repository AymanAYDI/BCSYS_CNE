pageextension 50108 "BC6_Account. Manag. RoleCenter" extends "Accounting Manager Role Center" //9001
{
    actions
    {
        addbefore("&G/L Trial Balance")
        {
            action("BC6_Statement avec traite")
            {
                ApplicationArea = All;
                Caption = '&G/L Trial Balance', Comment = 'FRA="Relevé client CNE avec traite"';
                Image = Report;
                RunObject = Report "BC6_Statement avec traite";
            }
            action("BC6_Statement sans traite")
            {
                ApplicationArea = All;
                Caption = '&G/L Trial Balance', Comment = 'FRA="Relevé client CNE sans traite"';
                Image = Report;
                RunObject = Report "BC6_Statement sans traite";
                Visible = FALSE;
            }
            action("BC6_Statement sans traite V2")
            {
                ApplicationArea = All;
                Caption = '&G/L Trial Balance', Comment = 'FRA="Relevé client CNE sans traite V2"';
                Image = Report;
                RunObject = Report "BC6_Statement sans traite V2";
            }
        }
        addafter("Bank Account Posting Groups")
        {
            action("BC6_Liste des sessions")
            {
                ApplicationArea = All;
                Caption = 'List of sessions', Comment = 'FRA="Liste des sessions"';
                RunObject = Page "Concurrent Session List";
            }
        }
    }
}
