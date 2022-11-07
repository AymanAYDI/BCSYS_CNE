codeunit 50091 "Permission Form"
{

    trigger OnRun()
    var
        Text001: Label 'User %1 has not been set up to be allowed to run %2 %3 - %4.';
    begin
    end;

    [Scope('Internal')]
    procedure HasEditablePermission(UserID2: Text[65]; ObjectType: Integer; ObjectID: Integer): Boolean
    var
        AllObjWithCaption: Record "2000000058";
        WinAccControl: Record "2000000053";
        HasPermission: Boolean;
    begin
        //>>MIGRATION NAV 2013
        //>>OLD
        /*
        HasPermission := MemberOf.ISEMPTY AND WinAccControl.ISEMPTY;
        IF NOT HasPermission AND NOT MemberOf.ISEMPTY THEN
          HasPermission := HasDBPermission(UserID2,ObjectType,ObjectID);
        IF NOT HasPermission THEN
          HasPermission := HasWinPermission(UserID2,ObjectType,ObjectID);
        EXIT(HasPermission);
        */
        //>>NEW
        HasPermission := WinAccControl.ISEMPTY;
        IF NOT HasPermission THEN
            HasPermission := HasWinPermission(UserID2, ObjectType, ObjectID);
        EXIT(HasPermission);
        //<<MIGRATION NAV 2013

    end;

    [Scope('Internal')]
    procedure HasDBPermission(UserID2: Text[65]; ObjectType: Integer; ObjectID: Integer): Boolean
    var
        Permission: Record "2000000005";
        MorePermissions: Boolean;
        HasPermission: Boolean;
    begin
        //>>MIGRATION NAV 2013
        /*
        HasPermission := MemberOf.GET(UserID2,'SUPER',COMPANYNAME);
        IF NOT HasPermission THEN
          HasPermission := MemberOf.GET(UserID2,'SUPER','');
        IF HasPermission THEN
          EXIT(TRUE);
        
        Permission.SETRANGE("Object Type",ObjectType);
        Permission.SETFILTER("Object ID",'%1|%2',0,ObjectID);
        Permission.SETRANGE("Modify Permission",Permission."Modify Permission"::Yes);
        IF Permission.FINDSET THEN
          REPEAT
            HasPermission := MemberOf.GET(UserID2,Permission."Role ID",COMPANYNAME);
            IF NOT HasPermission THEN
              HasPermission := MemberOf.GET(UserID2,Permission."Role ID",'');
          UNTIL HasPermission OR (Permission.NEXT = 0);
        EXIT(HasPermission);
        */
        //>>MIGRATION NAV 2013

    end;

    [Scope('Internal')]
    procedure HasWinPermission(UserID2: Text[65]; ObjectType: Integer; ObjectID: Integer): Boolean
    var
        WinLogin: Record "2000000120";
        WinLogin2: Record "2000000120";
        WinAccessControl: Record "2000000053";
        Permission: Record "2000000005";
        LoginManagement: Codeunit "418";
        Found: Boolean;
        MorePermissions: Boolean;
        HasPermission: Boolean;
    begin
        //>>MIGRATION NAV 2013
        //>>OLD
        /*
        IF WinLogin2.FINDSET THEN
          REPEAT
            WinLogin2.CALCFIELDS(ID);
            Found := UPPERCASE(ShortUserID(WinLogin2.ID)) = UPPERCASE(UserID2);
            IF Found THEN
              WinLogin := WinLogin2;
          UNTIL Found OR (WinLogin2.NEXT = 0);
        IF NOT Found THEN
          EXIT(FALSE);
        
        HasPermission := WinAccessControl.GET(WinLogin.SID,'SUPER',COMPANYNAME);
        IF NOT HasPermission THEN
          HasPermission := WinAccessControl.GET(WinLogin.SID,'SUPER','');
        IF HasPermission THEN
          EXIT(TRUE);
        
        Permission.SETRANGE("Object Type",ObjectType);
        Permission.SETFILTER("Object ID",'%1|%2',0,ObjectID);
        Permission.SETRANGE("Modify Permission",Permission."Modify Permission"::Yes);
        IF Permission.FINDSET THEN
          REPEAT
            HasPermission := WinAccessControl.GET(WinLogin.SID,Permission."Role ID",COMPANYNAME);
            IF NOT HasPermission THEN
              HasPermission := WinAccessControl.GET(WinLogin.SID,Permission."Role ID",'');
          UNTIL HasPermission OR (Permission.NEXT = 0);
        EXIT(HasPermission);
        */
        //>>NEW
        IF WinLogin2.FINDSET THEN
            REPEAT
                Found := UPPERCASE(WinLogin2."User Name") = UPPERCASE(UserID2);
                IF Found THEN
                    WinLogin := WinLogin2;
            UNTIL Found OR (WinLogin2.NEXT = 0);
        IF NOT Found THEN
            EXIT(FALSE);

        HasPermission := WinAccessControl.GET(WinLogin."User Security ID", 'SUPER', COMPANYNAME);
        IF NOT HasPermission THEN
            HasPermission := WinAccessControl.GET(WinLogin."User Security ID", 'SUPER', '');
        IF HasPermission THEN
            EXIT(TRUE);

        Permission.SETRANGE("Object Type", ObjectType);
        Permission.SETFILTER("Object ID", '%1|%2', 0, ObjectID);
        Permission.SETRANGE("Modify Permission", Permission."Modify Permission"::Yes);
        IF Permission.FINDSET THEN
            REPEAT
                HasPermission := WinAccessControl.GET(WinLogin."User Security ID", Permission."Role ID", COMPANYNAME);
                IF NOT HasPermission THEN
                    HasPermission := WinAccessControl.GET(WinLogin."User Security ID", Permission."Role ID", '');
            UNTIL HasPermission OR (Permission.NEXT = 0);
        EXIT(HasPermission);
        //<<MIGRATION NAV 2013

    end;

    [Scope('Internal')]
    procedure ShortUserID(UserID: Text[100]): Code[20]
    begin
        IF STRPOS(UserID, '\') IN [0, STRLEN(UserID)] THEN
            IF STRLEN(UserID) <= 20 THEN
                EXIT(UserID)
            ELSE
                EXIT('')
        ELSE
            EXIT(COPYSTR(UserID, STRPOS(UserID, '\') + 1, 20));
    end;
}

