codeunit 50013 "BC6_Create SalesDoc Directory"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        SalesHeader := Rec;
        Code();
        Rec := SalesHeader;
    end;

    var
        Item: Record Item;
        RecLink: Record "Record Link"; //2000000068
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";

        FileMngt: Codeunit "File Management";
        ItemRecID: RecordID;
        ItemRecRef: RecordRef;
        Window: Dialog;
        FileCounter: Integer;
        Text001: Label 'Création dossier %1 ...';
        Text002: Label 'URL #1#############';
        Text003: Label 'Nombre fichier(s) copié(s) #2####';
        Text010: Label 'Il n''y a pas de ligne article';
        LastTargetFileName: Text;
        SourceFilePath: Text;
        TargetDirectoryName: Text;
        TargetDirectoryPath: Text;
        TargetFileName: Text;
        TargetNewSubDirectory: Text;

    procedure "Code"()
    begin
        IF NOT (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order]) THEN
            SalesHeader.TESTFIELD("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.TESTFIELD("No.");

        SalesSetup.GET();
        SalesSetup.TESTFIELD("BC6_Technicals Directory Path");

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF NOT SalesLine.FINDFIRST() THEN
            ERROR(Text010);

        Window.OPEN(STRSUBSTNO(Text001, SalesHeader."No.") + '\' +
                    Text002 + '\' +
                    Text003);

        CLEAR(FileMngt);

        TargetDirectoryPath := SalesSetup."BC6_Technicals Directory Path";
        TargetNewSubDirectory := SalesHeader."No.";
        TargetDirectoryName := '';
        REPEAT

            ItemRecRef.GETTABLE(Item);
            ItemRecID := ItemRecRef.RECORDID;

            RecLink.SETRANGE(Type, RecLink.Type::Link);
            RecLink.SETRANGE("Record ID", ItemRecID);
            IF RecLink.FINDSET() THEN
                REPEAT

                    CLEAR(FileMngt);
                    CLEAR(TargetFileName);

                    Window.UPDATE(1, RecLink.Description);

                    SourceFilePath := RecLink.URL1;
                    // TargetFileName := FileMngt.CopyAndRenameClientFile(SourceFilePath, TargetDirectoryPath, TargetNewSubDirectory);
                    IF TargetFileName <> '' THEN BEGIN
                        FileCounter += 1;
                        Window.UPDATE(2, FileCounter);
                        LastTargetFileName := TargetFileName;
                        IF TargetDirectoryName = '' THEN
                            TargetDirectoryName := FileMngt.GetDirectoryName(TargetFileName);
                        IF NOT (COPYSTR(TargetDirectoryName, STRLEN(TargetDirectoryName)) = '\') THEN
                            TargetDirectoryName := TargetDirectoryName + '\';
                    END;
                UNTIL RecLink.NEXT() = 0;
        UNTIL SalesLine.NEXT() = 0;
        //LORSQU'on Ajoute la proc CopyAndRenameClientFile
        //    IF FileMngt.ClientDirectoryExists(TargetDirectoryName) THEN //TODO
        //         SalesHeader.ADDLINK(TargetDirectoryName, STRSUBSTNO(Text011, FileCounter))
        //     ELSE
        //         ERROR(Text012);
        SLEEP(500);
        Window.CLOSE();
    end;
}
