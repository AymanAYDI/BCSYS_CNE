codeunit 50010 "BC6_ReportHelper"
{

    procedure DownloadToClientFileName(ServerFileName: Text[250]; ToFile: Text[250]): Text[250]
    var
        //TODO objScript: Automation;
        //CR: Text[50];
        ClientFileName: Text[250];
    begin
        ClientFileName := ToFile;
        // IF NOT DOWNLOAD(ServerFileName, '', '<TEMP>', '', ClientFileName) THEN
        //     EXIT('');
        //TODO IF CREATE(objScript, TRUE, TRUE) THEN BEGIN
        //     CR := ' ';
        //     CR[1] := 13;
        //     objScript.Language := 'VBScript';
        //     objScript.AddCode(
        //     'function RenameTempFile(fromFile, toFile)' + CR +
        //     'set fso = createobject("Scripting.FileSystemObject")' + CR +
        //     'set x = createobject("Scriptlet.TypeLib")' + CR +
        //     'path = fso.getparentfoldername(fromFile)' + CR +
        //     'toPath = path+"\"+left(x.GUID,38)' + CR +
        //     'fso.CreateFolder toPath' + CR +
        //     'fso.MoveFile fromFile, toPath+"\"+toFile' + CR +
        //     'RenameTempFile = toPath' + CR +
        //     'end function');
        //     ClientFileName := objScript.Eval('RenameTempFile("' + ClientFileName + '","' + ToFile + '")');
        //     ClientFileName := ClientFileName + '\' + ToFile;
        // END;
        EXIT(ClientFileName);
    end;
}

