xmlport 50023 "Intégration catalogue"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // 
    // //Bug Compilation CASC 18/01/2007
    // //>>Item import FLGR 24/01/2007 FE06.V2 NSC1.01 -add "net weight" and "barcode" management
    // //TODOLIST point 55 FLGR 07/02/2007 change desig var to 250 char lenght
    // //TODOLIST point 56 FLGR 08/02/2007 ending date not mandatory
    // 
    // //DEEE LD 09.02.2007 DEEE1.00
    // //todolist point 63 FLGR 15/02/2007 check item unicity
    // //todolist point 62 FLGR 15/02/2007 better DEEE management
    // 
    // //>> Visible false File Name
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add C/AL in Temporaryimportcatalogue - Import::OnBeforeInsertRecord()
    // 
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50005; Table50005)
            {
                XmlName = 'Temporaryimportcatalogue';
                SourceTableView = SORTING (Field1);
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

                    "Temporary import catalogue".RESET;
                    IF "Temporary import catalogue".FINDLAST THEN
                        "Temporary import catalogue".key += 1
                    ELSE
                        "Temporary import catalogue".key := 1;
                end;

                trigger OnAfterInitRecord()
                begin
                    ref_ext := '';
                    ref_int := '';
                    desig := '';
                    //px_pub :=0;
                    px_pub := '';
                    DecGpx_pub := 0;
                    //px_net :=0;
                    px_net := '';
                    DecGpx_net := 0;
                    //rem := 0;
                    rem := '';
                    DecGrem := 0;
                    fam := '';
                    //>>Item import FLGR 24/01/2007 FE06.V2 NSC1.01
                    codebarre := '';
                    //<<Item import FLGR 24/01/2007 FE06.V2 NSC1.01

                    //>>DEEE LD 09.02.2007 DEEE1.00
                    DEEECategoryCode := '';
                    //NumberOfUnitsDEEE := 0;
                    NumberOfUnitsDEEE := '';
                    DecGNumberOfUnitsDEEE := 0;
                    //DEEEUnitAmount := 0;
                    DEEEUnitAmount := '';
                    DecGDEEEUnitAmount := 0;
                    //<<Fin DEEE LD 09.02.2007 DEEE1.00
                end;

                trigger OnBeforeInsertRecord()
                var
                    reclCatalogue: Record "50005";
                begin
                    //>>TDL.76
                    IntGLine += 1;
                    IF (IntGLine MOD 123 = 0) OR (IntGLine MOD 357 = 0) THEN
                        DlgGWin.UPDATE(1, IntGLine);
                    //<<TDL.76

                    "Temporary import catalogue".INIT;
                    IF ref_int = '' THEN BEGIN
                        IF ref_ext <> '' THEN
                            "Temporary import catalogue".Ref_Interne := TextGabbreviation + ref_ext
                        ELSE
                            currXMLport.SKIP;
                    END
                    ELSE
                        "Temporary import catalogue".Ref_Interne := ref_int;

                    "Temporary import catalogue".Ref_externe := ref_ext;
                    //>> 05.01.2012 ValidateRefIntern
                    "Temporary import catalogue".VALIDATE(Ref_Interne);

                    //>>todolist point 63
                    reclCatalogue.RESET;
                    //>>TDL.76
                    reclCatalogue.SETCURRENTKEY(Ref_Interne);
                    //<<TDL.76
                    reclCatalogue.SETFILTER(Ref_Interne, "Temporary import catalogue".Ref_Interne);
                    //>>TDL.76
                    //IF reclCatalogue.FIND('-') THEN
                    IF NOT reclCatalogue.ISEMPTY THEN
                        //<<TDL.76
                        ERROR(TextG003, "Temporary import catalogue".Ref_Interne);
                    //<<todolist point 63

                    "Temporary import catalogue".key += 1;
                    "Temporary import catalogue".designation := desig;
                    IF EVALUATE(DecGpx_pub, px_pub) THEN;
                    "Temporary import catalogue".Prix_public := DecGpx_pub;
                    IF EVALUATE(DecGpx_net, px_net) THEN;
                    "Temporary import catalogue".prix_net := DecGpx_net;
                    IF EVALUATE(DecGrem, rem) THEN;
                    "Temporary import catalogue".remise := DecGrem;
                    "Temporary import catalogue".famille := fam;

                    "Temporary import catalogue"."date debut" := DateDeb;
                    "Temporary import catalogue"."date fin" := DateFin;
                    "Temporary import catalogue".Vendor := Num;
                    "Temporary import catalogue"."Product Group Code" := GRPProduit;
                    "Temporary import catalogue"."Item Category Code" := Cat;
                    "Temporary import catalogue".BarCode := codebarre;
                    //>> 05.01.2012 ValidateBarCode
                    "Temporary import catalogue".VALIDATE(BarCode);

                    //>>Item import FLGR 24/01/2007 FE06.V2 NSC1.01
                    IF EVALUATE(DecGpoidsnet, poidsnet) THEN;
                    "Temporary import catalogue"."Net Weight" := DecGpoidsnet;
                    //<<Item import FLGR 24/01/2007 FE06.V2 NSC1.01

                    //>>DEEE LD 09.02.2007 DEEE1.00
                    //>>todolist point 62
                    GeneralLedgerSetup.GET;
                    IF GeneralLedgerSetup."DEEE Management" THEN BEGIN
                        IF DEEECategoryCode <> '' THEN BEGIN
                            IF NOT CategoriesOfItem.GET(DEEECategoryCode, GeneralLedgerSetup."Defaut Eco partner DEEE") THEN BEGIN
                                MESSAGE(Textg004, "Temporary import catalogue".FIELDCAPTION("DEEE Category Code"), DEEECategoryCode);
                            END;
                        END;
                        IF DEEECategoryCode = '' THEN BEGIN

                            //celui de l'art
                            RecGDEEETariffs.SETFILTER("Eco Partner", GeneralLedgerSetup."Defaut Eco partner DEEE");
                            IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN;
                            RecGDEEETariffs.SETRANGE("HT Unit Tax (LCY)", ROUND(DecGDEEEUnitAmount, 0.01, '>'));
                            RecGDEEETariffs.SETFILTER("Date beginning", '<= %1', "Temporary import catalogue"."date debut");
                            IF "Temporary import catalogue"."date fin" <> 0D THEN
                                RecGDEEETariffs.SETFILTER("Date beginning", '<= %1', "Temporary import catalogue"."date fin");

                            //BCSYS - MM
                            //    IF RecGDEEETariffs.FIND('+') THEN
                            //      DEEECategoryCode := RecGDEEETariffs."DEEE Code"
                            //    ELSE
                            //      MESSAGE(Textg005,"Temporary import catalogue".Ref_Interne);

                            IF NOT RecGDEEETariffs.FINDLAST THEN BEGIN
                                RecGDEEETariffs.INIT;
                                RecGDEEETariffs."Date beginning" := CALCDATE('<-CY>', TODAY);
                                RecGDEEETariffs."Eco Partner" := GeneralLedgerSetup."Defaut Eco partner DEEE";
                                IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN
                                    RecGDEEETariffs."HT Unit Tax (LCY)" := ROUND(DecGDEEEUnitAmount, 0.01, '>');
                                RecGDEEETariffs."DEEE Code" := FORMAT(RecGDEEETariffs."HT Unit Tax (LCY)");
                                RecGDEEETariffs.INSERT;

                                CategoriesOfItem.SETRANGE(Category, RecGDEEETariffs."DEEE Code");
                                CategoriesOfItem.SETRANGE("Eco Partner", RecGDEEETariffs."Eco Partner");
                                IF NOT CategoriesOfItem.FINDFIRST THEN BEGIN
                                    CategoriesOfItem.INIT;
                                    CategoriesOfItem.Category := RecGDEEETariffs."DEEE Code";
                                    CategoriesOfItem."Eco Partner" := RecGDEEETariffs."Eco Partner";
                                    CategoriesOfItem.INSERT;
                                END;
                            END;
                            DEEECategoryCode := RecGDEEETariffs."DEEE Code";
                            //FIN BCSYS - MM
                        END;

                        "Temporary import catalogue"."DEEE Category Code" := DEEECategoryCode;
                        IF EVALUATE(DecGNumberOfUnitsDEEE, NumberOfUnitsDEEE) THEN;
                        "Temporary import catalogue"."Number of Units DEEE" := DecGNumberOfUnitsDEEE;
                        IF EVALUATE(DecGDEEEUnitAmount, DEEEUnitAmount) THEN;
                        "Temporary import catalogue"."DEEE Unit Amount" := ROUND(DecGDEEEUnitAmount, 0.01, '>');
                        //<<DEEE LD 09.02.2007 DEEE1.00
                    END;
                    //<<todolist point 62
                end;
            }

            trigger OnBeforePassVariable()
            begin

                //currXMLport.FILENAME := FileName;

                //TODOLIST point 56 FLGR 08/02/2007 ending date not mandatory
                //IF (DateDeb = 0D) OR (DateFin = 0D) OR NOT Vendor.GET(Num) THEN
                IF (DateDeb = 0D) OR NOT Vendor.GET(Num) THEN
                    //TODOLIST point 56 FLGR 08/02/2007 ending date not mandatory
                    ERROR(TextG002);


                //TODOLIST point 56 FLGR 08/02/2007 ending date not mandatory
                //IF DateDeb >= DateFin THEN
                IF (DateDeb >= DateFin) AND (DateFin <> 0D) THEN
                    //TODOLIST point 56 FLGR 08/02/2007 ending date not mandatory
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
                        cduFileMngt: Codeunit "419";
                    begin

                        RecGNavisetup.GET;
                        //>>MIGRATION 2013
                        //Common_Dlg.InitDir := RecGNavisetup."Catalog import Path";
                        //Common_Dlg.DialogTitle(textG001);
                        //Common_Dlg.ShowOpen;
                        FileName := cduFileMngt.OpenFileDialog(textG001, RecGNavisetup."Catalog import Path", '');
                        //FileName:=Common_Dlg.FileName;
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

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        RecGGroupePrdArt.RESET;
                        RecGGroupePrdArt.SETRANGE("Item Category Code", Cat);
                        IF RecGGroupePrdArt.FIND('-') THEN BEGIN
                            CLEAR(FrmGGroupePrdArt);
                            FrmGGroupePrdArt.SETTABLEVIEW(RecGGroupePrdArt);
                            FrmGGroupePrdArt.EDITABLE := FALSE;
                            FrmGGroupePrdArt.LOOKUPMODE := TRUE;
                            IF FrmGGroupePrdArt.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                FrmGGroupePrdArt.GETRECORD(RecGGroupePrdArt);
                                GRPProduit := RecGGroupePrdArt.Code;
                            END;
                        END;
                    end;
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

    trigger OnPostXmlPort()
    begin
        //>>TDL.76
        DlgGWin.CLOSE;
        //<<TDL.76
    end;

    trigger OnPreXmlPort()
    begin
        //>>TDL.76
        IntGLine := 1;
        DlgGWin.OPEN(CstG001)
        //<<TDL.76
    end;

    var
        DecGpx_pub: Decimal;
        DecGpx_net: Decimal;
        DecGrem: Decimal;
        DecGNumberOfUnitsDEEE: Decimal;
        DecGDEEEUnitAmount: Decimal;
        DecGpoidsnet: Decimal;
        FileName: Text[250];
        DateDeb: Date;
        DateFin: Date;
        Vendor: Record "23";
        Cat: Code[10];
        Num: Code[10];
        GRPProduit: Code[10];
        TextGabbreviation: Code[10];
        RecGGroupePrdArt: Record "5723";
        FrmGGroupePrdArt: Page "5731";
        RecGNavisetup: Record "50004";
        "---DEEE---": Integer;
        GeneralLedgerSetup: Record "98";
        CategoriesOfItem: Record "50006";
        RecGDEEETariffs: Record "50007";
        Text008: Label 'Starting Date %1 must be less than end date %2';
        textG001: Label 'Import File';
        TextG002: Label 'Starting date and Vendor No fields are mandatory';
        TextG003: Label 'Another instance of item %1 already exist';
        Textg004: Label '%1 %2 doesn''t exist, \ please create it.';
        Textg005: Label 'No DEEE category matching for item %1';
        "- TDL.76 -": Integer;
        DlgGWin: Dialog;
        "-- TDL.76 --": ;
        CstG001: Label 'Import de la ligne #1#######';
        IntGLine: Integer;
}

