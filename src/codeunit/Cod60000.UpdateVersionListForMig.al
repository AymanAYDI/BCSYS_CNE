codeunit 60000 "BC6_UpdateVersionListForMig"
{

    trigger OnRun()
    begin
        MyTag := 'MIG2017';
        AddATag();
        MESSAGE('End');
    end;

    var
        "Object": Record Object;
        MyTag: Text;

    local procedure DeleteATag()
    var
        Pos: Integer;
    begin
        Object.SETRANGE(Modified, true);
        Object.SETFILTER("Version List", '*%1*', MyTag);
        ERROR('%1', Object.COUNT);
        if Object.FindSet() then
            repeat
                Pos := STRPOS(Object."Version List", ',MyTag');
                if Pos <> 0 then begin
                    Object."Version List" := DELSTR(Object."Version List", Pos, STRLEN(',MyTag'));
                    Object.MODIFY();
                end;
            until Object.NEXT() = 0;
        MESSAGE('End');

        exit;
    end;

    local procedure AddATag()
    begin
        Object.SETRANGE(Modified, true);
        Object.SETFILTER("Version List", '<>*%1*', MyTag);
        Object.SETFILTER(Object.Type, '<>%1&', Object.Type::TableData);
        Object.SETFILTER(ID, '<50000|>99999');
        if Object.FINDFIRST() then
            ERROR('%1', Object);
        repeat
            if STRPOS(Object."Version List", MyTag) = 0 then begin
                if Object."Version List" <> '' then
                    Object."Version List" := Object."Version List" + ',' + MyTag
                else
                    Object."Version List" := MyTag;
                Object.MODIFY();
            end;
        until Object.NEXT() = 0;
    end;
}

