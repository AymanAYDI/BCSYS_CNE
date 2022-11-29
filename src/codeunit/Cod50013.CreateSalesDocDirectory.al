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
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        RecLink: Record "Record Link"; //2000000068

        FileMngt: Codeunit "File Management";
        Window: Dialog;
        Text001: Label 'Création dossier %1 ...';
        Text002: Label 'URL #1#############';
        Text003: Label 'Nombre fichier(s) copié(s) #2####';
        Text010: Label 'Il n''y a pas de ligne article';
        ItemExist: Boolean;
        ItemRecRef: RecordRef;
        ItemRecID: RecordID;
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

            SalesSetup.GET();
            SalesSetup.TESTFIELD("BC6_Technicals Directory Path");

            SalesLine.RESET();
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            IF NOT SalesLine.FINDFIRST() THEN
                ERROR(Text010);

            Window.OPEN(STRSUBSTNO(Text001, "No.") + '\' +
                        Text002 + '\' +
                        Text003);

            CLEAR(FileMngt);


            TargetDirectoryPath := SalesSetup."BC6_Technicals Directory Path";
            TargetNewSubDirectory := "No.";
            TargetDirectoryName := '';
            REPEAT

                ItemExist := Item.GET(SalesLine."No.");
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
                        //TODO TargetFileName := FileMngt.CopyAndRenameClientFile(SourceFilePath, TargetDirectoryPath, TargetNewSubDirectory);
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
            //TODO IF FileMngt.ClientDirectoryExists(TargetDirectoryName) THEN
            //     SalesHeader.ADDLINK(TargetDirectoryName, STRSUBSTNO(Text011, FileCounter))
            // ELSE
            ERROR(Text012);
        END;
        SLEEP(500);
        Window.CLOSE();
    end;
}

