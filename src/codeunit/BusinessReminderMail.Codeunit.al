codeunit 50011 "Business Reminder Mail"
{
    // ------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------
    // //>>CNE3.01
    //   FE-Emailsuiviaffaires-20090818:SOBI 12/11/09 : - creation


    trigger OnRun()
    begin
        RecGUserSetup.RESET;
        RecGUserSetup.SETFILTER("E-mail Business Reminder", '<>%1', '');
        //test
        //RecGUserSetup.SETRANGE("E-mail Business Reminder",'Stephane.desmasures@sceneo.fr');

        IF RecGUserSetup.FINDSET THEN
            REPEAT
                FctGCreateMail(RecGUserSetup."User ID");
            UNTIL RecGUserSetup.NEXT = 0;
    end;

    var
        RecGUserSetup: Record "91";
        CstG0001: Label 'Affair No.';
        CstG0002: Label 'Affair description';
        CstG0003: Label 'Reminder date';
        CstG0004: Label 'Description';
        CstG0005: Label 'Result';
        CstG0006: Label 'Affair Reminder';
        Char1: Char;
        RecGUser: Record "2000000120";
        AffaireResponsableEmail: Text[100];

    [Scope('Internal')]
    procedure FctGCreateMail(CodPUserID: Code[50])
    var
        CduLSMTP: Codeunit "400";
        RecLAffaireSteps: Record "50010";
        RecLJob: Record "167";
    begin
        //MIGRATION NAV 2013
        //OLD RecGUser.GET(CodPUserID);
        RecGUser.RESET;
        RecGUser.SETRANGE("User Name", CodPUserID);
        IF RecGUser.FINDFIRST THEN;
        //<<MIGRATION NAV 2013
        Char1 := 11;

        RecLAffaireSteps.RESET;
        RecLAffaireSteps.SETCURRENTKEY(RecLAffaireSteps.Interlocutor, RecLAffaireSteps."Reminder Date", RecLAffaireSteps.Terminated);
        RecLAffaireSteps.SETFILTER(RecLAffaireSteps.Interlocutor, CodPUserID);
        RecLAffaireSteps.SETFILTER("Reminder Date", '..%1', TODAY);
        RecLAffaireSteps.SETRANGE(RecLAffaireSteps.Terminated, FALSE);
        IF RecLAffaireSteps.FINDSET THEN BEGIN
            CLEAR(CduLSMTP);
            //MIGRATION NAV 2013
            //OLD CduLSMTP.CreateMessage(RecGUser.Name,RecGUserSetup."E-mail Business Reminder",
            CduLSMTP.CreateMessage('', RecGUserSetup."E-mail Business Reminder",
               RecGUserSetup."E-mail Business Reminder", CstG0006, '', FALSE);

            CduLSMTP.AppendBody(
               PADSTR(CstG0001, 20, ' ') +
               PADSTR(CstG0003, 20, ' ') +
               PADSTR(CstG0002, 50, ' ') +
               //PADSTR(CstG0005,50,' ')+
               PADSTR(CstG0004, 50, ' ') + FORMAT(Char1));

            CduLSMTP.AppendBody(
               PADSTR('', 190, '-') + FORMAT(Char1));

            REPEAT
                CduLSMTP.AppendBody(
                   PADSTR(RecLAffaireSteps."Affair No.", 20, ' ') +
                   PADSTR(FORMAT(RecLAffaireSteps."Reminder Date"), 20, ' ') +
                   //PADSTR(RecLAffaireSteps."Affair Description",50,' ')+
                   RecLAffaireSteps."Affair Description" +
                   '   --->   ' +
                   //PADSTR(RecLAffaireSteps.Result,50,' ')+
                   //PADSTR(RecLAffaireSteps.Description,50,' ')+FORMAT(Char1));
                   RecLAffaireSteps.Description + FORMAT(Char1));
            UNTIL RecLAffaireSteps.NEXT = 0;

            CduLSMTP.Send();
        END;
    end;
}

