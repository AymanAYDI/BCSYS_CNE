xmlport 50021 "BC6_Catalog Integration"
{
    Caption = 'Catalog Integration', Comment = 'FRA="Intégration catalogue"';
    Direction = Import;
    FieldDelimiter = 'NONE';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;
                XmlName = 'Items';
                SourceTableView = SORTING("No.");
                textelement(REF_EXT)
                {
                }
                textelement(REF_INT)
                {
                }
                textelement(Designation)
                {
                }
                textelement(PX_PUBLIC)
                {
                }
                textelement(FAMILLE)
                {
                }
                textelement(REM_DISTI)
                {
                }
                textelement(PX_NET)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    IF REF_INT = '' THEN
                        REF_INT := TextGabbreviation + REF_EXT;

                    create_disc_familly(); // test si famille et remise existe et les crée si necessaire

                    IF NOT RecGItem.GET(REF_INT) THEN BEGIN
                        RecGItem.INIT();
                        RecGItem.VALIDATE("No.", REF_INT);
                        RecGItem.VALIDATE("Vendor No.", Num);
                        RecGItem.VALIDATE("Vendor Item No.", REF_EXT);
                        RecGItem.VALIDATE("Item Category Code", Cat);
                        RecGItem.VALIDATE(Description, COPYSTR(Designation, 1, 30));
                        RecGItem.VALIDATE("Item Disc. Group", FAMILLE);
                        EVALUATE(RecGItem."Unit Price", PX_PUBLIC);
                        RecGItem.VALIDATE(RecGItem."Unit Price");

                        RecGItem.INSERT(TRUE);
                    END
                    ELSE BEGIN
                        RecGItem.VALIDATE("Vendor Item No.", REF_EXT);
                        RecGItem.VALIDATE("Item Category Code", Cat);
                        RecGItem.VALIDATE(Description, COPYSTR(Designation, 1, 30));
                        RecGItem.VALIDATE("Item Disc. Group", FAMILLE);
                        EVALUATE(RecGItem."Unit Price", PX_PUBLIC);
                        RecGItem.VALIDATE(RecGItem."Unit Price");
                        RecGItem.MODIFY(TRUE)
                    END;
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
                //TODO:OCX 
                // field(FileName; FileName)
                // {
                //     Caption = 'Open File';

                //     trigger OnAssistEdit()
                //     begin

                //         Common_Dlg.DialogTitle(textG001);
                //         Common_Dlg.Filter := '.xls';
                //         Common_Dlg.InitDir(ENVIRON('userprofile'));
                //         Common_Dlg.ShowOpen;
                //         FileName := Common_Dlg.FileName;
                //     end;
                // }
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
        RecGItem: Record Item;
        RecLItemdiscGrp: Record "Item Discount Group";
        Vendor: Record Vendor;
        Cat: Code[10];
        GRPProduit: Code[10];
        Num: Code[10];
        TextGabbreviation: Code[10];
        DateDeb: Date;
        DateFin: Date;
        // Common_Dlg: OCX;
        Text008: Label 'Starting Date %1 must be less than end date %2', Comment = 'FRA="Date début %1 doit être inférieur à date fin %2"';
        textG001: Label 'Import File', Comment = 'FRA="Importer le fichier"';
        TextG002: Label 'Please fill up start date and Vendor No', Comment = 'FRA="Veuillez valoriser les champs date de début et N° de fournisseur"';
        FileName: Text[250];


    procedure create_disc_familly()
    begin
        IF NOT RecLItemdiscGrp.GET(FAMILLE) THEN BEGIN
            RecLItemdiscGrp.INIT();
            RecLItemdiscGrp.Code := FAMILLE;
            RecLItemdiscGrp.INSERT(TRUE);
        END;
    end;
}

