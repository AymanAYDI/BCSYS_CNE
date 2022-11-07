codeunit 50012 "Session Killer"
{

    trigger OnRun()
    var
        gSession: Record "2000000110";
    begin
        IF ISCLEAR(ADOConnection) THEN
            IF NOT CREATE(ADOConnection, FALSE, TRUE) THEN
                ERROR('erreur');

        IF ADOConnection.State = 1 THEN
            ADOConnection.Close;

        ADOConnection.Open(
          'Driver={SQL Server Native Client 10.0};' +
          'Server=SRVNAV1;' +
          'Database=CNE_TEST;' +
          'Trusted_Connection=yes;');
        ADOConnection.CommandTimeout(0);

        //gSession.SETFILTER("Idle Time",'>%1',Setup."Session Idle Time");
        IF gSession.FINDSET THEN
            REPEAT
                //gSession.DELETE;
                //COMMIT;
                ADOConnection.Execute(STRSUBSTNO('KILL %1', gSession."Session ID"));
            UNTIL gSession.NEXT = 0;

        ADOConnection.Close;
        CLEAR(ADOConnection);
    end;

    var
        ADOConnection: Automation;
}

