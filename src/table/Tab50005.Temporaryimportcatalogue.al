table 50005 "BC6_Temporary import catalogue"
{
    DataClassification = CustomerContent;
    LookupPageID = "BC6_Intégration article";

    fields
    {
        field(1; "key"; Integer)
        {
            Caption = 'key', comment = 'FRA="clef"';
            DataClassification = CustomerContent;
        }
        field(2; Ref_externe; Code[20])
        {
            Caption = 'External Ref.', comment = 'FRA="Réf. Externe"';
            DataClassification = CustomerContent;
        }
        field(3; Ref_Interne; Code[20])
        {
            Caption = 'Internal Ref.', comment = 'FRA="Ref. Interne"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                FunctionMgt: Codeunit "BC6_Functions Mgt";
            begin

                IF (Ref_Interne <> '') THEN BEGIN
                    CLEAR(DistInt);
                    "Item BarCode" := FunctionMgt.GetItemEAN13Code(Ref_Interne);
                END ELSE
                    "Item BarCode" := '';

                VALIDATE("Item BarCode");
            end;
        }
        field(4; designation; Text[250])
        {
            Caption = 'Description', comment = 'FRA="Désignation"';
            DataClassification = CustomerContent;
        }
        field(5; Prix_public; Decimal)
        {
            Caption = 'Public Price', comment = 'FRA="Prix Public"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(6; famille; Code[10])
        {
            Caption = 'Item Disc. Group', comment = 'FRA="Groupe rem. article"';
            DataClassification = CustomerContent;
        }
        field(7; remise; Decimal)
        {
            Caption = 'Rebate', comment = 'FRA="Remise"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(8; prix_net; Decimal)
        {
            Caption = 'Purch. Price', comment = 'FRA="Prix d''achat"';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "date debut"; Date)
        {
            Caption = 'Starting date', comment = 'FRA="Date Début"';
            DataClassification = CustomerContent;
        }
        field(10; "date fin"; Date)
        {
            Caption = 'Ending date', comment = 'FRA="Date Fin"';
            DataClassification = CustomerContent;
        }
        field(11; Vendor; Code[20])
        {
            Caption = 'Vendor', comment = 'FRA="N° fournisseur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(13; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code', comment = 'FRA="Code catégorie article"';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(14; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code', comment = 'FRA="Code groupe produits"';
            DataClassification = CustomerContent;
        }
        field(15; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight', comment = 'FRA="Poids net"';
            DataClassification = CustomerContent;
        }
        field(16; BarCode; Code[30])
        {
            Caption = 'Bar Code', comment = 'FRA="Code barres"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                ReplaceItemBarCode();
            end;
        }
        field(17; "DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code ', comment = 'FRA="Code tarif DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                LRecDEEECategory: Record "BC6_Categories of item";
            begin
            end;
        }
        field(18; "Number of Units DEEE"; Decimal)
        {
            Caption = 'Number of Units DEEE', comment = 'FRA="Nombre d''unités DEEE"';
            DataClassification = CustomerContent;
        }
        field(19; "DEEE Unit Amount"; Decimal)
        {
            Caption = 'DEEE Unit Amount', comment = 'FRA="Montant unitaire DEEE"';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(30; "Item BarCode"; Code[20])
        {
            Caption = 'Item BarCode', comment = 'FRA="Code barres article"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                ReplaceItemBarCode();
            end;
        }
        field(31; "Replace Item BarCode"; Boolean)
        {
            Caption = 'Replace Item BarCode', comment = 'FRA="Remplacer code barres article"';
            DataClassification = CustomerContent;
        }
        field(50000; "Emplacement par défaut"; Code[20])
        {
            Caption = 'Emplacement par défaut', comment = 'FRA="Emplacement par défaut"';
            CalcFormula = Lookup("Bin Content"."Bin Code" WHERE(Default = CONST(true),
                                                                 "Item No." = FIELD(Ref_Interne)));
            FieldClass = FlowField;
        }
        field(50001; Stocks; Decimal)
        {
            Caption = 'Stocks', comment = 'FRA="Stocks"';
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD(Ref_Interne)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "key", Ref_externe, Ref_Interne, Vendor)
        {
            Clustered = true;
        }
        key(Key2; Ref_Interne)
        {
        }
    }

    fieldgroups
    {
    }

    var
        CategoriesOfItem: Record "BC6_Categories of item";
        DEEETariffs: Record "BC6_DEEE Tariffs";
        GeneralLedgerSetup: Record "General Ledger Setup";
        recgItem: Record Item;
        RecGItemCrossRef: Record "Item Reference";
        RecGDiscount: Record "Purchase Line Discount";
        RecGPurchPrice: Record "Purchase Price";
        DistInt: codeunit "Dist. Integration";
        "---DEEE1.00---": Integer;
        Textg001: Label 'No DEEE category matching for item %1', comment = 'FRA="Aucun rapprochement de code tarif DEEE possible pour l''article %1"';
        Textg002: Label '%1 %2 created.', comment = 'FRA="%1 %2  créé."';
        Txt001: Label 'The fields external Reference and Public price should not be empty ', comment = 'FRA="Les champs Réfèrence externe et Prix public ne doivent pas être vides"';
        Txt002: Label 'Finished treatment', comment = 'FRA="Traitement terminé"';

    procedure importdata()
    var
        DiaLWindow: Dialog;
        i: Integer;
        IntLCounter: Integer;
    begin
        FINDFIRST();
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."BC6_DEEE Management" THEN
            GeneralLedgerSetup.TESTFIELD("BC6_Defaut Eco partner DEEE");
        IntLCounter := COUNT;
        i := 0;

        DiaLWindow.OPEN('Import @1@@@@@@@@@@');

        REPEAT

            i := i + 1;
            DiaLWindow.UPDATE(1, ROUND(i / IntLCounter * 10000, 1));

            TESTFIELD(Ref_externe);
            TESTFIELD(Prix_public);
            TESTFIELD(Vendor);
            TESTFIELD("date debut");

            IF Ref_Interne <> '' THEN BEGIN
                create_disc_familly();
                IF NOT recgItem.GET(Ref_Interne) THEN BEGIN
                    recgItem.INIT();
                    recgItem.VALIDATE("No.", Ref_Interne);
                    recgItem.VALIDATE("Vendor No.", Vendor);
                    recgItem.VALIDATE("Vendor Item No.", Ref_externe);
                    recgItem.VALIDATE("Item Category Code", "Item Category Code");
                    recgItem.VALIDATE(Description, COPYSTR(designation, 1, MAXSTRLEN(recgItem.Description)));
                    recgItem.VALIDATE("Item Disc. Group", famille);
                    recgItem.VALIDATE(recgItem."Unit Price", Prix_public);
                    IF "Net Weight" <> 0 THEN
                        recgItem.VALIDATE("Net Weight", "Net Weight");
                    IF ("Number of Units DEEE" <> 0) THEN
                        InsertDEEE();
                    recgItem.INSERT(TRUE);

                    recgItem.VALIDATE("BC6_Number of Units DEEE", Rec."Number of Units DEEE");
                    recgItem.MODIFY(TRUE);
                    insertlongdescription();

                    insertitemcrossref();
                END
                ELSE BEGIN
                    recgItem.Blocked := FALSE;
                    recgItem.VALIDATE("Vendor No.", Vendor);
                    recgItem.VALIDATE("Vendor Item No.", Ref_externe);
                    recgItem.VALIDATE("Item Category Code", "Item Category Code");
                    recgItem.VALIDATE(Description, COPYSTR(designation, 1, MAXSTRLEN(recgItem.Description)));
                    IF famille <> '' THEN
                        recgItem.VALIDATE("Item Disc. Group", famille);
                    recgItem.VALIDATE(recgItem."Unit Price", Prix_public);
                    recgItem.VALIDATE("Item Category Code", "Item Category Code");
                    recgItem.VALIDATE("Item Disc. Group", famille);
                    recgItem.VALIDATE(recgItem."Net Weight", "Net Weight");
                    IF ("Number of Units DEEE" <> 0) THEN InsertDEEE();
                    recgItem.VALIDATE("BC6_Number of Units DEEE", Rec."Number of Units DEEE");
                    recgItem.MODIFY(TRUE);
                    recgItem.MODIFY(TRUE);
                    insertlongdescription();
                    insertitemcrossref();
                END;

                IF remise <> 0 THEN
                    InsertDiscount();
                IF prix_net <> 0 THEN
                    InsertpurchPrice();
            END;
        UNTIL NEXT() = 0;

        DiaLWindow.CLOSE();

        MESSAGE(Txt002);
    end;

    procedure create_disc_familly()
    var
        RecLItemDiscGrp: Record "Item Discount Group";
    begin
        IF NOT RecLItemDiscGrp.GET(famille) THEN BEGIN
            RecLItemDiscGrp.INIT();
            RecLItemDiscGrp.Code := famille;
            RecLItemDiscGrp.INSERT(TRUE);
        END;
    end;

    procedure insertitemcrossref()
    begin
        RecGItemCrossRef.RESET();
        RecGItemCrossRef.SETFILTER("Item No.", recgItem."No.");
        RecGItemCrossRef.SETFILTER("Reference Type", '%1', RecGItemCrossRef."Reference Type"::Vendor);
        RecGItemCrossRef.SETFILTER("Reference Type No.", recgItem."Vendor No.");
        IF NOT RecGItemCrossRef.ISEMPTY THEN
            RecGItemCrossRef.DELETEALL();

        RecGItemCrossRef.INIT();
        RecGItemCrossRef.VALIDATE("Item No.", recgItem."No.");
        RecGItemCrossRef.VALIDATE("Unit of Measure", recgItem."Base Unit of Measure");
        RecGItemCrossRef.VALIDATE(Description, recgItem.Description);
        RecGItemCrossRef.VALIDATE("Reference Type", RecGItemCrossRef."Reference Type"::Vendor);
        RecGItemCrossRef.VALIDATE("Reference Type No.", recgItem."Vendor No.");
        RecGItemCrossRef.VALIDATE("Reference No.", recgItem."Vendor Item No.");
        RecGItemCrossRef.INSERT(TRUE);

        IF (BarCode <> '') THEN BEGIN
            RecGItemCrossRef.RESET();
            RecGItemCrossRef.SETFILTER("Item No.", recgItem."No.");
            RecGItemCrossRef.SETFILTER("Unit of Measure", recgItem."Base Unit of Measure");
            RecGItemCrossRef.SETFILTER("Reference Type", '%1', RecGItemCrossRef."Reference Type"::"Bar Code");
            IF NOT RecGItemCrossRef.ISEMPTY THEN
                RecGItemCrossRef.DELETEALL();

            RecGItemCrossRef.INIT();
            RecGItemCrossRef.VALIDATE("Item No.", recgItem."No.");
            RecGItemCrossRef.VALIDATE("Reference Type", RecGItemCrossRef."Reference Type"::"Bar Code");
            RecGItemCrossRef.VALIDATE("Reference Type No.", 'EAN13');
            RecGItemCrossRef.VALIDATE("Reference No.", BarCode);
            RecGItemCrossRef.VALIDATE("Unit of Measure", recgItem."Base Unit of Measure");
            RecGItemCrossRef.VALIDATE(Description, recgItem.Description);
            RecGItemCrossRef.INSERT(TRUE);
        END;
    end;

    procedure insertlongdescription()
    var
        RecLExtTextHeader: Record "Extended Text Header";
        RecLExtTextLine: Record "Extended Text Line";
        "--point55": Integer;
        intlLineno: Integer;
        intLstartpos: Integer;
        TxtLExtendedtext: Text[250];
    begin
        TxtLExtendedtext := COPYSTR(designation, MAXSTRLEN(recgItem.Description) + 1);
        IF MAXSTRLEN(recgItem.Description) < STRLEN(designation) THEN BEGIN
            RecLExtTextHeader.SETFILTER("Table Name", '%1', RecLExtTextHeader."Table Name"::Item);
            RecLExtTextHeader.SETFILTER("No.", recgItem."No.");
            IF RecLExtTextHeader.FIND('-') THEN
                RecLExtTextHeader.DELETE(TRUE);
            recgItem."Automatic Ext. Texts" := TRUE;
            recgItem.MODIFY();
            RecLExtTextHeader.INIT();
            RecLExtTextLine.INIT();
            RecLExtTextHeader.VALIDATE("Table Name", RecLExtTextHeader."Table Name"::Item);
            RecLExtTextHeader.VALIDATE("No.", recgItem."No.");
            RecLExtTextHeader.VALIDATE("All Language Codes", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Quote", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Invoice", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Order", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Credit Memo", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Quote", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Invoice", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Order", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Credit Memo", TRUE);
            RecLExtTextHeader.VALIDATE(Reminder, TRUE);
            RecLExtTextHeader.VALIDATE("Finance Charge Memo", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Blanket Order", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Blanket Order", TRUE);
            RecLExtTextHeader.VALIDATE("Service Order", TRUE);
            RecLExtTextHeader.VALIDATE("Service Quote", TRUE);
            RecLExtTextHeader.VALIDATE("Sales Return Order", TRUE);
            RecLExtTextHeader.VALIDATE("Purchase Return Order", TRUE);
            RecLExtTextHeader.INSERT(TRUE);
            intLstartpos := 1;
            REPEAT
                intlLineno += 10000;
                RecLExtTextLine.INIT();
                RecLExtTextLine.VALIDATE("Table Name", RecLExtTextHeader."Table Name");
                RecLExtTextLine.VALIDATE("No.", RecLExtTextHeader."No.");
                RecLExtTextLine.VALIDATE("Text No.", RecLExtTextHeader."Text No.");
                RecLExtTextLine.VALIDATE("Line No.", intlLineno);
                RecLExtTextLine.VALIDATE(Text, COPYSTR(TxtLExtendedtext, intLstartpos, MAXSTRLEN(RecLExtTextLine.Text)));
                RecLExtTextLine.INSERT(TRUE);
                intLstartpos += MAXSTRLEN(RecLExtTextLine.Text);
            UNTIL intLstartpos >= STRLEN(TxtLExtendedtext);
        END;
    end;

    procedure InsertpurchPrice()
    begin
        RecGPurchPrice.RESET();
        RecGPurchPrice.SETCURRENTKEY("Item No.", "Vendor No.", "Currency Code");
        RecGPurchPrice.SETRANGE("Item No.", Ref_Interne);
        RecGPurchPrice.SETRANGE("Vendor No.", Vendor);
        RecGPurchPrice.SETFILTER("Currency Code", '%1', '');
        RecGPurchPrice.SETFILTER("Ending Date", '%1', 0D);
        IF NOT RecGPurchPrice.ISEMPTY THEN
            IF RecGPurchPrice.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    RecGPurchPrice.VALIDATE("Ending Date", CALCDATE('<-1D>', "date debut"));
                    RecGPurchPrice.MODIFY(TRUE);
                UNTIL RecGPurchPrice.NEXT() = 0;
        RecGPurchPrice.INIT();
        RecGPurchPrice.VALIDATE("Item No.", Ref_Interne);
        RecGPurchPrice.VALIDATE("Direct Unit Cost", prix_net);
        RecGPurchPrice.VALIDATE("Vendor No.", Vendor);
        RecGPurchPrice.VALIDATE("Starting Date", "date debut");
        RecGPurchPrice.VALIDATE("Ending Date", "date fin");
        RecGPurchPrice.INSERT(TRUE);
    end;

    procedure InsertDEEE()
    var
        reclitem: Record Item;
    begin
        IF GeneralLedgerSetup."BC6_DEEE Management" THEN BEGIN
            IF reclitem.GET(recgItem."No.") THEN BEGIN
                IF reclitem."BC6_Eco partner DEEE" = '' THEN
                    recgItem.VALIDATE("BC6_Eco partner DEEE", GeneralLedgerSetup."BC6_Defaut Eco partner DEEE");
            END ELSE
                recgItem.VALIDATE("BC6_Eco partner DEEE", GeneralLedgerSetup."BC6_Defaut Eco partner DEEE");

            recgItem.VALIDATE("BC6_Number of Units DEEE", Rec."Number of Units DEEE");
            IF ("DEEE Category Code" = '') THEN BEGIN
                IF "DEEE Unit Amount" <> 0 THEN BEGIN
                    DEEETariffs.RESET();
                    DEEETariffs.SETRANGE(DEEETariffs."HT Unit Tax (LCY)", "DEEE Unit Amount");
                    DEEETariffs.SETRANGE(DEEETariffs."Eco Partner", recgItem."BC6_Eco partner DEEE");
                    DEEETariffs.SETFILTER(DEEETariffs."Date beginning", '<= %1', "date debut");
                    IF "date fin" <> 0D THEN
                        DEEETariffs.SETFILTER(DEEETariffs."Date beginning", '<= %1', "date fin");
                    IF DEEETariffs.FINDLAST() THEN BEGIN
                        recgItem.VALIDATE("BC6_DEEE Category Code", DEEETariffs."DEEE Code");
                    END
                    ELSE
                        ERROR(Textg001, recgItem."No.");
                END
                ELSE
                    ERROR(Textg001, recgItem."No.");
            END
            ELSE BEGIN
                recgItem.VALIDATE("BC6_DEEE Category Code", "DEEE Category Code");
            END;
        END;
    end;

    procedure InsertDiscount()
    begin
        RecGDiscount.RESET();
        RecGDiscount.SETCURRENTKEY("Item No.", "Vendor No.", "BC6_Type");
        RecGDiscount.SETFILTER("BC6_Type", '%1', RecGDiscount."BC6_Type"::Item);
        RecGDiscount.SETFILTER(RecGDiscount."Ending Date", FORMAT(0D));
        RecGDiscount.SETRANGE("Item No.", Ref_Interne);
        RecGDiscount.SETRANGE("Vendor No.", Vendor);
        IF NOT RecGDiscount.ISEMPTY THEN
            IF RecGDiscount.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    RecGDiscount.VALIDATE("Ending Date", CALCDATE('<-1D>', "date debut"));
                    RecGDiscount.MODIFY(TRUE);
                UNTIL RecGDiscount.NEXT() = 0;
        RecGDiscount.INIT();
        RecGDiscount.VALIDATE("BC6_Type", RecGDiscount."BC6_Type"::Item);
        RecGDiscount.VALIDATE("Item No.", Ref_Interne);
        RecGDiscount.VALIDATE("Vendor No.", Vendor);
        RecGDiscount.VALIDATE("Line Discount %", remise);
        RecGDiscount.VALIDATE("Starting Date", "date debut");
        RecGDiscount.VALIDATE("Ending Date", "date fin");
        RecGDiscount.INSERT(TRUE);
    end;

    procedure ReplaceItemBarCode()
    begin
        IF BarCode = '' THEN BEGIN
            "Replace Item BarCode" := FALSE;
            EXIT;
        END;

        "Replace Item BarCode" := (BarCode <> "Item BarCode");
    end;
}
