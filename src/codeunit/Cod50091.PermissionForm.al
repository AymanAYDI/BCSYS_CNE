codeunit 50091 "BC6_Permission Form"
{


    procedure HasEditablePermission(UserID2: Text[65]; ObjectType: Integer; ObjectID: Integer): Boolean
    var
        AllObjWithCaption: Record AllObjWithCaption;
        WinAccControl: Record "Access Control";
        HasPermission: Boolean;
    begin
        HasPermission := WinAccControl.ISEMPTY;
        IF NOT HasPermission THEN
            HasPermission := HasWinPermission(UserID2, ObjectType, ObjectID);
        EXIT(HasPermission);

    end;




    procedure HasWinPermission(UserID2: Text[65]; ObjectType: Integer; ObjectID: Integer): Boolean
    var
        WinLogin: Record User;
        WinLogin2: Record User;
        WinAccessControl: Record "Access Control";
        Permission: Record Permission;
        LoginManagement: Codeunit "User Management";
        Found: Boolean;
        MorePermissions: Boolean;
        HasPermission: Boolean;
    begin

        IF WinLogin2.FINDSET() THEN
            REPEAT
                Found := UPPERCASE(WinLogin2."User Name") = UPPERCASE(UserID2);
                IF Found THEN
                    WinLogin := WinLogin2;
            UNTIL Found OR (WinLogin2.NEXT() = 0);
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
        IF Permission.FINDSET() THEN
            REPEAT
                HasPermission := WinAccessControl.GET(WinLogin."User Security ID", Permission."Role ID", COMPANYNAME);
                IF NOT HasPermission THEN
                    HasPermission := WinAccessControl.GET(WinLogin."User Security ID", Permission."Role ID", '');
            UNTIL HasPermission OR (Permission.NEXT() = 0);
        EXIT(HasPermission);
        //<<MIGRATION NAV 2013

    end;


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
