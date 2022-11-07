codeunit 50013 "Create SalesDoc Directory"
{
    // //>> CNE6.01
    // TDL:EC07 15.12.2014 : Create Technicals Sales Directory
    //                       Fct CopyAndRenameClientFile

    TableNo = 36;

    trigger OnRun()
    begin
        SalesHeader := Rec;
        Code;
        Rec := SalesHeader;
    end;

    var
        SalesSetup: Record "311";
        SalesHeader: Record "36";
        FileMngt: Codeunit "419";
        SalesLine: Record "37";
        Window: Dialog;
        Text001: Label 'Création dossier %1 ...';
        Text002: Label 'URL #1#############';
        Text003: Label 'Nombre fichier(s) copié(s) #2####';
        Text010: Label 'Il n''y a pas de ligne article';
        Item: Record "27";
        ItemExist: Boolean;
        ItemRecRef: RecordRef;
        ItemRecID: RecordID;
        RecLink: Record "2000000068";
        SourceFilePath: Text;
        TargetDirectoryPath: Text;
        TargetNewSubDirectory: Text;
        TargetFileName: Text;
        FileCounter: Integer;
        TargetDirectoryName: Text;
        Text011: Label 'Dossier technique : %1 fichier(s) copié(s)';
        Text012: Label 'Aucun fichier copié';
        LastTargetFileName: Text;

    [Scope('Internal')]
    procedure "Code"()
    begin
        WITH SalesHeader DO BEGIN
            IF NOT ("Document Type" IN ["Document Type"::Quote, "Document Type"::Order]) THEN
                TESTFIELD("Document Type", "Document Type"::Order);
            TESTFIELD("No.");

            SalesSetup.GET;
            SalesSetup.TESTFIELD("Technicals Directory Path");

            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            IF NOT SalesLine.FINDFIRST THEN
                ERROR(Text010);

            Window.OPEN(STRSUBSTNO(Text001, "No.") + '\' +
                        Text002 + '\' +
                        Text003);

            CLEAR(FileMngt);


            TargetDirectoryPath := SalesSetup."Technicals Directory Path";
            TargetNewSubDirectory := "No.";
            TargetDirectoryName := '';

            // Suppresion des liens
            // IF SalesHeader.HASLINKS THEN
            //  SalesHeader.DELETELINKS;
            REPEAT

                ItemExist := Item.GET(SalesLine."No.");
                ItemRecRef.GETTABLE(Item);
                ItemRecID := ItemRecRef.RECORDID;

                RecLink.SETRANGE(Type, RecLink.Type::Link);
                RecLink.SETRANGE("Record ID", ItemRecID);
                IF RecLink.FINDSET THEN
                    REPEAT

                        CLEAR(FileMngt);
                        CLEAR(TargetFileName);

                        Window.UPDATE(1, RecLink.Description);

                        SourceFilePath := RecLink.URL1;
                        TargetFileName := FileMngt.CopyAndRenameClientFile(SourceFilePath, TargetDirectoryPath, TargetNewSubDirectory);
                        IF TargetFileName <> '' THEN BEGIN
                            FileCounter += 1;
                            Window.UPDATE(2, FileCounter);
                            LastTargetFileName := TargetFileName;
                            IF TargetDirectoryName = '' THEN
                                TargetDirectoryName := FileMngt.GetDirectoryName(TargetFileName);
                            IF NOT (COPYSTR(TargetDirectoryName, STRLEN(TargetDirectoryName)) = '\') THEN
                                TargetDirectoryName := TargetDirectoryName + '\';
                        END;

                    UNTIL RecLink.NEXT = 0;
            UNTIL SalesLine.NEXT = 0;

            IF FileMngt.ClientDirectoryExists(TargetDirectoryName) THEN
                SalesHeader.ADDLINK(TargetDirectoryName, STRSUBSTNO(Text011, FileCounter))
            //IF FileMngt.ClientFileExists(LastTargetFileName) THEN
            //  SalesHeader.ADDLINK(LastTargetFileName,STRSUBSTNO(Text011,FileCounter))
            ELSE
                ERROR(Text012);
        END;
        SLEEP(500);
        Window.CLOSE;
    end;
}

