xmlport 50022 "Intégration catalogue2"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //Bug Compilation CASC 18/01/2007
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = 'NONE';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50005; Table50005)
            {
                XmlName = 'Temporaryimportcatalogue';
                textelement(Ref_externe)
                {
                }
                textelement(Ref_Interne)
                {
                }
                textelement(designation)
                {
                }
                textelement(Prix_public)
                {
                }
                textelement(famille)
                {
                }
                textelement(remise)
                {
                }
                textelement(prix_net)
                {
                }

                trigger OnPreXmlItem()
                begin

                    "Temporary import catalogue".DELETEALL;
                    clef := 0;
                end;

                trigger OnAfterInitRecord()
                begin

                    "Temporary import catalogue".INIT;
                    clef += 1;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(FileName; FileName)
                {
                    Caption = 'Open File';

                    trigger OnAssistEdit()
                    begin

                        Common_Dlg.DialogTitle(textG001);
                        Common_Dlg.Filter := '.xls';
                        Common_Dlg.InitDir(ENVIRON('userprofile'));
                        Common_Dlg.ShowOpen;
                        FileName := Common_Dlg.FileName;
                    end;
                }
                field(DateDeb; DateDeb)
                {
                    Caption = 'Date début';
                }
                field(DateFin; DateFin)
                {
                    Caption = 'Date fin';

                    trigger OnValidate()
                    begin

                        IF DateDeb > DateFin THEN
                            ERROR('Date début(%1) doit être inférieur à date fin (%2)', DateDeb, DateFin)
                    end;
                }
                field(Num; Num)
                {
                    Caption = 'Fournisseur';

                    trigger OnValidate()
                    begin

                        IF Vendor.GET(Num) THEN
                            TextGabbreviation := COPYSTR(Vendor.Name, 1, 3);
                    end;
                }
                field(TextGabbreviation; TextGabbreviation)
                {
                    Caption = 'Vendor abbreviation';
                }
                field(Cat; Cat)
                {
                    Caption = 'Catégorie Article';

                    trigger OnValidate()
                    begin

                        IF Cat = '' THEN
                            GRPProduit := '';
                    end;
                }
                field(GRPProduit; GRPProduit)
                {
                    Caption = 'Product Group';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        DateDeb := WORKDATE;
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := FileName;
        IF (DateDeb = 0D) OR NOT Vendor.GET(Num) THEN
            ERROR(TextG002);
    end;

    var
        RecLItemdiscGrp: Record "341";
        clef: Integer;
        DateDeb: Date;
        FileName: Text[250];
        Vendor: Record "23";
        Num: Code[10];
        Text008: Label 'Starting Date %1 must be less than end date %2';
        textG001: Label 'Import File';
        TextG002: Label 'Please fill up start date and Vendor No';
        Common_Dlg: OCX;
        DateFin: Date;
        TextGabbreviation: Code[10];
        Cat: Code[10];
        GRPProduit: Code[10];

    [Scope('Internal')]
    procedure create_disc_familly()
    begin
        IF NOT RecLItemdiscGrp.GET(famille) THEN BEGIN
            RecLItemdiscGrp.INIT;
            RecLItemdiscGrp.Code := famille;
            RecLItemdiscGrp.INSERT(TRUE);
        END;
    end;
}

