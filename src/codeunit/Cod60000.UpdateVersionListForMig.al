codeunit 60000 "BC6_UpdateVersionListForMig"
{

    trigger OnRun()
    var
        VersionList: Text;
        Pos: Integer;
    begin
        MyTag := 'MIG2017';
        AddATag;
        MESSAGE('End');
    end;

    var
        "Object": Record Object;
        LicPermission: Record "License Permission";
        MyTag: Text;

    local procedure DeleteATag()
    var
        Pos: Integer;
    begin
        Object.SETRANGE(Modified, TRUE);
        Object.SETFILTER("Version List", '*%1*', MyTag);
        ERROR('%1', Object.COUNT);
        IF Object.FINDFIRST THEN   //TODO: Unreachable code detected.
            REPEAT
                Pos := STRPOS(Object."Version List", ',MyTag');
                IF Pos <> 0 THEN BEGIN
                    Object."Version List" := DELSTR(Object."Version List", Pos, STRLEN(',MyTag'));
                    Object.MODIFY;
                END;
            UNTIL Object.NEXT = 0;
        MESSAGE('End');

        EXIT;
    end;

    local procedure AddATag()
    begin
        Object.SETRANGE(Modified, TRUE);
        Object.SETFILTER("Version List", '<>*%1*', MyTag);
        Object.SETFILTER(Object.Type, '<>%1&', Object.Type::TableData);
        Object.SETFILTER(ID, '<50000|>99999');
        IF Object.FINDFIRST THEN
            ERROR('%1', Object);
        REPEAT
            IF STRPOS(Object."Version List", MyTag) = 0 THEN BEGIN
                IF Object."Version List" <> '' THEN
                    Object."Version List" := Object."Version List" + ',' + MyTag
                ELSE
                    Object."Version List" := MyTag;
                Object.MODIFY();
            END;
        UNTIL Object.NEXT = 0;
    end;
}

