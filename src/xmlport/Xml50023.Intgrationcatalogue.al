xmlport 50023 "BC6_Intégration catalogue"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Caption = 'Intégration catalogue';

    schema
    {
        textelement(Root)
        {
            tableelement("BC6_Temporary import catalogue"; "BC6_Temporary import catalogue")
            {
                XmlName = 'Temporaryimportcatalogue';
                SourceTableView = SORTING("key");
                textelement(ref_ext)
                {
                }
                textelement(ref_int)
                {
                }
                textelement(desig)
                {
                }
                textelement(px_pub)
                {
                }
                textelement(fam)
                {
                }
                textelement(rem)
                {
                }
                textelement(px_net)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(codebarre)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(poidsnet)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DEEECategoryCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(NumberOfUnitsDEEE)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DEEEUnitAmount)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }

                trigger OnPreXmlItem()
                begin

                    "BC6_Temporary import catalogue".RESET();
                    IF "BC6_Temporary import catalogue".FINDLAST() THEN
                        "BC6_Temporary import catalogue".key += 1
                    ELSE
                        "BC6_Temporary import catalogue".key := 1;
                end;

                trigger OnAfterInitRecord()
                begin
                    ref_ext := '';
                    ref_int := '';
                    desig := '';
                    px_pub := '';
                    DecGpx_pub := 0;
                    px_net := '';
                    DecGpx_net := 0;
                    rem := '';
                    DecGrem := 0;
                    fam := '';
                    codebarre := '';
                    DEEECategoryCode := '';
                    NumberOfUnitsDEEE := '';
                    DecGNumberOfUnitsDEEE := 0;
                    DEEEUnitAmount := '';
                    DecGDEEEUnitAmount := 0;
                end;

                trigger OnBeforeInsertRecord()
                var
                    reclCatalogue: Record "BC6_Temporary import catalogue";
                begin
                    IntGLine += 1;
                    IF (IntGLine MOD 123 = 0) OR (IntGLine MOD 357 = 0) THEN
                        DlgGWin.UPDATE(1, IntGLine);

                    "BC6_Temporary import catalogue".INIT();
                    IF ref_int = '' THEN BEGIN
                        IF ref_ext <> '' THEN
                            "BC6_Temporary import catalogue".Ref_Interne := TextGabbreviation + ref_ext
                        ELSE
                            currXMLport.SKIP();
                    END
                    ELSE
                        "BC6_Temporary import catalogue".Ref_Interne := ref_int;

                    "BC6_Temporary import catalogue".Ref_externe := ref_ext;
                    "BC6_Temporary import catalogue".VALIDATE(Ref_Interne);

                    reclCatalogue.RESET();
                    reclCatalogue.SETCURRENTKEY(Ref_Interne);
                    reclCatalogue.SETFILTER(Ref_Interne, "BC6_Temporary import catalogue".Ref_Interne);
                    IF NOT reclCatalogue.ISEMPTY THEN
                        ERROR(TextG003, "BC6_Temporary import catalogue".Ref_Interne);

                    "BC6_Temporary import catalogue".key += 1;
                    "BC6_Temporary import catalogue".designation := desig;
                    IF EVALUATE(DecGpx_pub, px_pub) THEN;
                    "BC6_Temporary import catalogue".Prix_public := DecGpx_pub;
                    IF EVALUATE(DecGpx_net, px_net) THEN;
                    "BC6_Temporary import catalogue".prix_net := DecGpx_net;
                    IF EVALUATE(DecGrem, rem) THEN;
                    "BC6_Temporary import catalogue".remise := DecGrem;
                    "BC6_Temporary import catalogue".famille := fam;

                    "BC6_Temporary import catalogue"."date debut" := DateDeb;
                    "BC6_Temporary import catalogue"."date fin" := DateFin;
                    "BC6_Temporary import catalogue".Vendor := Num;
                    "BC6_Temporary import catalogue"."Product Group Code" := GRPProduit;
                    "BC6_Temporary import catalogue"."Item Category Code" := Cat;
                    "BC6_Temporary import catalogue".BarCode := codebarre;
                    "BC6_Temporary import catalogue".VALIDATE(BarCode);

                    IF EVALUATE(DecGpoidsnet, poidsnet) THEN;
                    "BC6_Temporary import catalogue"."Net Weight" := DecGpoidsnet;
                    GeneralLedgerSetup.GET();
                    IF GeneralLedgerSetup."BC6_DEEE Management" THEN BEGIN
                        IF DEEECategoryCode <> '' THEN BEGIN
                            IF NOT CategoriesOfItem.GET(DEEECategoryCode, GeneralLedgerSetup."BC6_Defaut Eco partner DEEE") THEN BEGIN
                                MESSAGE(Textg004, "BC6_Temporary import catalogue".FIELDCAPTION("DEEE Category Code"), DEEECategoryCode);
                            END;
                        END;
                        IF DEEECategoryCode = '' THEN BEGIN

                            //celui de l'art
                            RecGDEEETariffs.SETFILTER("Eco Partner", GeneralLedgerSetup."BC6_Defaut Eco partner DEEE");
                            IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN;
                            RecGDEEETariffs.SETRANGE("HT Unit Tax (LCY)", ROUND(DecGDEEEUnitAmount, 0.01, '>'));
                            RecGDEEETariffs.SETFILTER("Date beginning", '<= %1', "BC6_Temporary import catalogue"."date debut");
                            IF "BC6_Temporary import catalogue"."date fin" <> 0D THEN
                                RecGDEEETariffs.SETFILTER("Date beginning", '<= %1', "BC6_Temporary import catalogue"."date fin");

                            IF NOT RecGDEEETariffs.FINDLAST() THEN BEGIN
                                RecGDEEETariffs.INIT();
                                RecGDEEETariffs."Date beginning" := CALCDATE('<-CY>', TODAY);
                                RecGDEEETariffs."Eco Partner" := GeneralLedgerSetup."BC6_Defaut Eco partner DEEE";
                                IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN
                                    RecGDEEETariffs."HT Unit Tax (LCY)" := ROUND(DecGDEEEUnitAmount, 0.01, '>');
                                RecGDEEETariffs."DEEE Code" := FORMAT(RecGDEEETariffs."HT Unit Tax (LCY)");
                                RecGDEEETariffs.INSERT();

                                CategoriesOfItem.SETRANGE(Category, RecGDEEETariffs."DEEE Code");
                                CategoriesOfItem.SETRANGE("Eco Partner", RecGDEEETariffs."Eco Partner");
                                IF NOT CategoriesOfItem.FINDFIRST() THEN BEGIN
                                    CategoriesOfItem.INIT();
                                    CategoriesOfItem.Category := RecGDEEETariffs."DEEE Code";
                                    CategoriesOfItem."Eco Partner" := RecGDEEETariffs."Eco Partner";
                                    CategoriesOfItem.INSERT();
                                END;
                            END;
                            DEEECategoryCode := RecGDEEETariffs."DEEE Code";
                        END;

                        "BC6_Temporary import catalogue"."DEEE Category Code" := DEEECategoryCode;
                        IF EVALUATE(DecGNumberOfUnitsDEEE, NumberOfUnitsDEEE) THEN;
                        "BC6_Temporary import catalogue"."Number of Units DEEE" := DecGNumberOfUnitsDEEE;
                        IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN;
                        "BC6_Temporary import catalogue"."DEEE Unit Amount" := ROUND(DecGDEEEUnitAmount, 0.01, '>');
                    END;
                end;
            }

            trigger OnBeforePassVariable()
            begin

                IF (DateDeb = 0D) OR NOT Vendor.GET(Num) THEN
                    ERROR(TextG002);

                IF (DateDeb >= DateFin) AND (DateFin <> 0D) THEN
                    ERROR(Text008, DateDeb, DateFin);
            end;
        }
    }

    requestpage
    {
        Caption = 'Options';

        layout
        {
            area(content)
            {
                field(FileName; FileName)
                {
                    Caption = 'Open File';
                    Visible = false;

                    trigger OnAssistEdit()
                    var
                        cduFileMngt: Codeunit "File Management";
                    begin

                        RecGNavisetup.GET();
                        //TODO      // FileName := cduFileMngt.OpenFileDialog(textG001, RecGNavisetup."Catalog import Path", '');
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
                    TableRelation = Vendor;

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
                    //TODO
                    // trigger OnLookup(var Text: Text): Boolean
                    // begin

                    //     RecGGroupePrdArt.RESET;
                    //     RecGGroupePrdArt.SETRANGE("Item Category Code", Cat);
                    //     IF RecGGroupePrdArt.FIND('-') THEN BEGIN
                    //         CLEAR(FrmGGroupePrdArt);
                    //         FrmGGroupePrdArt.SETTABLEVIEW(RecGGroupePrdArt);
                    //         FrmGGroupePrdArt.EDITABLE := FALSE;
                    //         FrmGGroupePrdArt.LOOKUPMODE := TRUE;
                    //         IF FrmGGroupePrdArt.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    //             FrmGGroupePrdArt.GETRECORD(RecGGroupePrdArt);
                    //             GRPProduit := RecGGroupePrdArt.Code;
                    //         END;
                    //     END;
                    // end;
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

    trigger OnPostXmlPort()
    begin
        DlgGWin.CLOSE();
    end;

    trigger OnPreXmlPort()
    begin
        IntGLine := 1;
        DlgGWin.OPEN(CstG001)
    end;

    var
        CategoriesOfItem: Record "BC6_Categories of item";
        RecGDEEETariffs: Record "BC6_DEEE Tariffs";
        //TODO : REcord & page removed // RecGGroupePrdArt: Record "Product Group";
        // FrmGGroupePrdArt: Page 5731;
        RecGNavisetup: Record "BC6_Navi+ Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Vendor: Record Vendor;
        Cat: Code[10];
        GRPProduit: Code[10];
        Num: Code[10];
        TextGabbreviation: Code[10];
        DateDeb: Date;
        DateFin: Date;
        DecGDEEEUnitAmount: Decimal;
        DecGNumberOfUnitsDEEE: Decimal;
        DecGpoidsnet: Decimal;
        DecGpx_net: Decimal;
        DecGpx_pub: Decimal;
        DecGrem: Decimal;
        DlgGWin: Dialog;
        IntGLine: Integer;
        CstG001: Label 'Import de la ligne #1#######';
        Text008: Label 'Starting Date %1 must be less than end date %2', Comment = 'FRA="Date début %1 doit être inférieur à date fin %2"';
        textG001: Label 'Import File', Comment = 'FRA="Importer le fichier"';
        TextG002: Label 'Starting date and Vendor No fields are mandatory', Comment = 'FRA="les champs date de début et N° de fournisseur sont obligatoires"';
        TextG003: Label 'Another instance of item %1 already exist', Comment = 'FRA="L''article %1 est en doublon"';
        Textg004: Label '%1 %2 doesn''t exist, \ please create it.', Comment = 'FRA="%1 %2 n''existe pas, \ merci de le créer."';
        FileName: Text[250];
}

