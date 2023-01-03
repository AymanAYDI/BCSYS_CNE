xmlport 50022 "BC6_Intégration catalogue2"
{
    Direction = Import;
    FieldDelimiter = 'NONE';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Caption = 'Intégration catalogue2';

    schema
    {
        textelement(Root)
        {
            tableelement("BC6_Temporary import catalogue"; "BC6_Temporary import catalogue")
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

                    "BC6_Temporary import catalogue".DELETEALL();
#pragma warning disable AA0206
                    clef := 0;
#pragma warning restore AA0206
                end;

                trigger OnAfterInitRecord()
                begin

                    "BC6_Temporary import catalogue".INIT();
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
                    //TODO:OCX
                    // trigger OnAssistEdit()
                    // begin

                    //     Common_Dlg.DialogTitle(textG001);
                    //     Common_Dlg.Filter := '.xls';
                    //     Common_Dlg.InitDir(ENVIRON('userprofile'));
                    //     Common_Dlg.ShowOpen;
                    //     FileName := Common_Dlg.FileName;
                    // end;
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
                    Caption = 'Product Group', Comment = 'FRA="Groupe Produit Article"';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        DateDeb := WORKDATE();
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := FileName;
        IF (DateDeb = 0D) OR NOT Vendor.GET(Num) THEN
            ERROR(TextG002);
    end;

    var
        RecLItemdiscGrp: Record "Item Discount Group";
        Vendor: Record Vendor;
        Cat: Code[10];
        GRPProduit: Code[10];
        Num: Code[10];
        TextGabbreviation: Code[10];
        DateDeb: Date;
        // Common_Dlg: OCX;
        DateFin: Date;
        clef: Integer;
        textG001: Label 'Import File', Comment = 'FRA="Importer le fichier"';
        TextG002: Label 'Please fill up start date and Vendor No', Comment = 'FRA="Veuillez valoriser les champs date de début et N° de fournisseur"';
        FileName: Text[250];


    procedure create_disc_familly()
    begin
        IF NOT RecLItemdiscGrp.GET(famille) THEN BEGIN
            RecLItemdiscGrp.INIT();
            RecLItemdiscGrp.Code := famille;
            RecLItemdiscGrp.INSERT(TRUE);
        END;
    end;
}

