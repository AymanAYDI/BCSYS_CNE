page 50006 "BC6_Documents Managment"
{
    Caption = 'Documents Managment', comment = 'FRA="Gestion Documents"';
    DataCaptionFields = "Table No.", "Table Name", "Reference No. 1";
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "BC6_Navi+ Documents";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Table Name"; "Table Name")
                {
                    Editable = false;
                }
                field("Reference No. 1"; "Reference No. 1")
                {
                    Editable = false;
                }
                field("Reference No. 2"; "Reference No. 2")
                {
                    Editable = false;
                }
                field("Reference No. 3"; "Reference No. 3")
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = true;
                }
                field(Description; Description)
                {
                }
                field("Path and file"; "Path and file")
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field("In Use By"; "In Use By")
                {
                }
                field(Special; Special)
                {
                }
                field("Created Date"; "Created Date")
                {
                    Editable = false;
                }
                field("Modified Date"; "Modified Date")
                {
                    Editable = false;
                }
                field("Modified By"; "Modified By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Choose a document")
            {
                Caption = 'Choose a document', comment = 'FRA="Choisir un document"';
                Image = SelectChart;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    RecGNaviSetup: Record "BC6_Navi+ Setup";
                    DialogFile: Dialog;
                    InStr: InStream;
                    AllFilesFilterTxt: Label '*.*', Locked = true;
                begin

                    IF "Table No." <> 167 THEN
                        "Path and file" := CduGFileManagement.UploadFile(STRSUBSTNO(TxtG001), "Path and file")
                    //TODO:CHEKME "Path and file" := CduGFileManagement.OpenFileDialog(STRSUBSTNO(TxtG001), "Path and file", '*.*|*.*')
                    // UPLOADINTOSTREAM(STRSUBSTNO(TxtG001), '', '(*.*)|*.*', "Path and file", InStr)

                    ELSE
                        IF RecGNaviSetup.FindFirst() THEN
                            IF RecGNaviSetup."Default Directory" <> '' THEN
                                "Path and file" := CduGFileManagement.UploadFile(STRSUBSTNO(TxtG001), RecGNaviSetup."Default Directory" + '\' + Text004)
                            //TODO:CHECKME "Path and file" := CduGFileManagement.OpenFileDialog(STRSUBSTNO(TxtG001), RecGNaviSetup."Default Directory" + '\' + Text004, '*.*|*.*')
                            // UPLOADINTOSTREAM(STRSUBSTNO(TxtG001), '', '(*.*)|*.*', RecGNaviSetup."Default Directory", InStr)

                            ELSE
                                ERROR(Text003);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            action(View)
            {
                Caption = 'View', comment = 'FRA="Vue"';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF "Path and file" <> '' THEN
                        ExplorerFolder("Path and file")
                    ELSE
                        MESSAGE(TxtG002);
                end;
            }
        }
    }

    var
        CduGFileManagement: Codeunit "File Management"; //does not contain the opendialog proc
        Text003: Label 'You must define a default directory', comment = 'FRA="Veuillez configurer un répertoire par defaut "';
        Text004: Label 'fichier';
        TxtG001: Label 'Select a document', comment = 'FRA="Choisir un document"';
        TxtG002: Label 'The field "Path and file" must not be empty to have the view', comment = 'FRA="Le champ "chemin et fichier" doit être renseigné pour afficher le document"';

    procedure ExplorerFolder(var FolderName: Text[250])
    var
    //TODO WindowsShell: Automation;
    // CduLFileManagement: Codeunit "File Management";
    // FolderName2: Text[250];
    begin
        // IF ISCLEAR(WindowsShell) THEN
        //  CREATE(WindowsShell);

        // WindowsShell.Open(FolderName);
    end;
}
