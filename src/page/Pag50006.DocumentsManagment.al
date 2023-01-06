page 50006 "BC6_Documents Managment"
{
    Caption = 'Documents Managment', comment = 'FRA="Gestion Documents"';
    DataCaptionFields = "Table No.", "Table Name", "Reference No. 1";
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "BC6_Navi+ Documents";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Table Name"; Rec."Table Name")
                {
                    Editable = false;
                }
                field("Reference No. 1"; Rec."Reference No. 1")
                {
                    Editable = false;
                }
                field("Reference No. 2"; Rec."Reference No. 2")
                {
                    Editable = false;
                }
                field("Reference No. 3"; Rec."Reference No. 3")
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                }
                field("Path and file"; Rec."Path and file")
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("In Use By"; Rec."In Use By")
                {
                }
                field(Special; Rec.Special)
                {
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
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
                PromotedOnly = true;

                trigger OnAction()
                var
                    RecGNaviSetup: Record "BC6_Navi+ Setup";
                    InStr: InStream;
                    _text: Text;
                begin

                    IF Rec."Table No." <> 167 THEN begin
                        //TODO:CHEKME "Path and file" := CduGFileManagement.OpenFileDialog(STRSUBSTNO(TxtG001), "Path and file", '*.*|*.*')
                        UPLOADINTOSTREAM(STRSUBSTNO(TxtG001), '', '(*.*)|*.*', Rec."Path and file", InStr);

                        _text := CduGFileManagement.GetDirectoryName(Rec."Path and file");
                        Message('path: %', _text);
                    end ELSE
                        IF RecGNaviSetup.FindFirst() THEN
                            IF RecGNaviSetup."Default Directory" <> '' THEN
                                Rec."Path and file" := CopyStr(CduGFileManagement.UploadFile(STRSUBSTNO(TxtG001), RecGNaviSetup."Default Directory" + '\' + Text004), 1, MaxStrLen(Rec."Path and file"))
                            //TODO:CHECKME "Path and file" := CduGFileManagement.OpenFileDialog(STRSUBSTNO(TxtG001), RecGNaviSetup."Default Directory" + '\' + Text004, '*.*|*.*')
                            // UPLOADINTOSTREAM(STRSUBSTNO(TxtG001), '', '(*.*)|*.*', RecGNaviSetup."Default Directory", InStr)

                            ELSE
                                ERROR(Text003);
                    CurrPage.UPDATE(TRUE);
                end;
            }
        }
    }

    var
        CduGFileManagement: Codeunit "File Management"; //does not contain the opendialog proc
        Text003: Label 'You must define a default directory', comment = 'FRA="Veuillez configurer un répertoire par defaut "';
        Text004: Label 'fichier';
        TxtG001: Label 'Select a document', comment = 'FRA="Choisir un document"';


}
