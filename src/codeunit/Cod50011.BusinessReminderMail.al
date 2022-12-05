codeunit 50011 "BC6_Business Reminder Mail"
{


    trigger OnRun()
    begin
        RecGUserSetup.RESET();
        RecGUserSetup.SETFILTER("BC6_E-mail Business Reminder", '<>%1', '');
        IF RecGUserSetup.FINDSET() THEN
            REPEAT
                FctGCreateMail(RecGUserSetup."User ID");
            UNTIL RecGUserSetup.NEXT() = 0;
    end;

    var
        RecGUser: Record User;
        RecGUserSetup: Record "User Setup";
        Char1: Char;
        CstG0001: Label 'Affair No.', Comment = 'FRA="Nø affaire"';
        CstG0002: Label 'Affair description', Comment = 'FRA="Nom affaire"';
        CstG0003: Label 'Reminder date', Comment = 'FRA="Date de relance"';
        CstG0004: Label 'Description', Comment = 'FRA="Désignation"';

    procedure FctGCreateMail(CodPUserID: Code[50])
    var
        //TODO//CHECK ME PLEASE !
        // CduLSMTP: Codeunit 400;
        RecLAffaireSteps: Record "BC6_Affair Steps";
        Email: Codeunit "email";
        CduLSMTP: Codeunit "Email Message";
    begin
        RecGUser.RESET();
        RecGUser.SETRANGE("User Name", CodPUserID);
        IF RecGUser.FINDFIRST() THEN;
        Char1 := 11;

        RecLAffaireSteps.RESET();
        RecLAffaireSteps.SETCURRENTKEY(RecLAffaireSteps.Interlocutor, RecLAffaireSteps."Reminder Date", RecLAffaireSteps.Terminated);
        RecLAffaireSteps.SETFILTER(RecLAffaireSteps.Interlocutor, CodPUserID);
        RecLAffaireSteps.SETFILTER("Reminder Date", '..%1', TODAY);
        RecLAffaireSteps.SETRANGE(RecLAffaireSteps.Terminated, FALSE);
        IF RecLAffaireSteps.FINDSET() THEN BEGIN
            CLEAR(CduLSMTP);
            CduLSMTP.Create('', RecGUserSetup."BC6_E-mail Business Reminder"
              , '', FALSE);

            CduLSMTP.AppendToBody(
               PADSTR(CstG0001, 20, ' ') +
               PADSTR(CstG0003, 20, ' ') +
               PADSTR(CstG0002, 50, ' ') +
               PADSTR(CstG0004, 50, ' ') + FORMAT(Char1));

            CduLSMTP.AppendToBody(
               PADSTR('', 190, '-') + FORMAT(Char1));

            REPEAT
                CduLSMTP.AppendToBody(
                   PADSTR(RecLAffaireSteps."Affair No.", 20, ' ') +
                   PADSTR(FORMAT(RecLAffaireSteps."Reminder Date"), 20, ' ') +
                   RecLAffaireSteps."Affair Description" +
                   '   --->   ' +
                   RecLAffaireSteps.Description + FORMAT(Char1));
            UNTIL RecLAffaireSteps.NEXT() = 0;

            Email.Send(CduLSMTP);
        END;
    end;
}

