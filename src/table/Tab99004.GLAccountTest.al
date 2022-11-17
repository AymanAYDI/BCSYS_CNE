table 99004 "BC6_G/L Account Test"
{
    Caption = 'G/L Account';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Chart of Accounts";
    LookupPageID = "G/L Account List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', comment = 'FRA="N°"';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name', comment = 'FRA="Nom"';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name', comment = 'FRA="Nom de recherche"';
        }
        field(4; "Account Type"; Enum "G/L Account Type")
        {
            Caption = 'Account Type', comment = 'FRA="Type compte"';
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code', comment = 'FRA="Code axe principal 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code', comment = 'FRA="Code axe principal 2"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Income/Balance"; Enum "BC6_IncomeBalance")
        {
            Caption = 'Income/Balance', comment = 'FRA="Gestion/Bilan"';
        }
        field(10; "Debit/Credit"; Enum BC6_DebitCredit)
        {
            Caption = 'Debit/Credit', comment = 'FRA="Débit/Crédit"';
        }
        field(11; "No. 2"; Code[20])
        {
            Caption = 'No. 2', comment = 'FRA="N° 2"';
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("G/L Account"),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment', comment = 'FRA="Commentaires"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked', comment = 'FRA="Bloqué"';
        }
        field(14; "Direct Posting"; Boolean)
        {
            Caption = 'Direct Posting', comment = 'FRA="Imputation directe"';
            InitValue = true;
        }
        field(16; "Reconciliation Account"; Boolean)
        {
            Caption = 'Reconciliation Account', comment = 'FRA="Compte de simulation"';
        }
        field(17; "New Page"; Boolean)
        {
            Caption = 'New Page', comment = 'FRA="Nouvelle page"';
        }
        field(18; "No. of Blank Lines"; Integer)
        {
            Caption = 'No. of Blank Lines', comment = 'FRA="Nbre lignes blanches"';
            MinValue = 0;
        }
        field(19; Indentation; Integer)
        {
            Caption = 'Indentation', comment = 'FRA="Indentation"';
            MinValue = 0;
        }
        field(26; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified', comment = 'FRA="Date dern. modification"';
            Editable = false;
        }
        field(28; "Date Filter"; Date)
        {
            Caption = 'Date Filter', comment = 'FRA="Filtre date"';
            FieldClass = FlowFilter;
        }
        field(29; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter', comment = 'FRA="Filtre axe principal 1"';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter', comment = 'FRA="Filtre axe principal 2"';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Balance at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Balance at Date', comment = 'FRA="Solde au"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Net Change"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Net Change', comment = 'FRA="Solde période"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD("Date Filter"),
                                                               "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budgeted Amount', comment = 'FRA="Montant budgété"';
            FieldClass = FlowField;
        }
        field(34; Totaling; Text[250])
        {
            Caption = 'Totaling', comment = 'FRA="Totalisation"';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Budget Filter"; Code[10])
        {
            Caption = 'Budget Filter', comment = 'FRA="Totalisation"';
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }
        field(36; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Balance', comment = 'FRA="Solde"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Budget at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD(UPPERLIMIT("Date Filter")),
                                                               "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budget at Date', comment = 'FRA="Budget période"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Consol. Translation Method"; Enum "BC6_ConsolTranslationMeth")
        {
            Caption = 'Consol. Translation Method', comment = 'FRA="Consolider la méthode de traduction"';
        }
        field(40; "Consol. Debit Acc."; Code[20])
        {
            Caption = 'Consol. Debit Acc.', comment = 'FRA="Compte débit consolidation"';
        }
        field(41; "Consol. Credit Acc."; Code[20])
        {
            Caption = 'Consol. Credit Acc.', comment = 'FRA="Compte crédit consolidation"';


        }
        field(42; "Business Unit Filter"; Code[10])
        {
            Caption = 'Business Unit Filter', comment = 'FRA="Filtre centre de profit"';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(43; "Gen. Posting Type"; Enum "General Posting Type")
        {
            Caption = 'Gen. Posting Type', comment = 'FRA="Type compta. TVA"';
        }
        field(44; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'FRA="Groupe compta. marché"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(45; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group', comment = 'FRA="Groupe compta. produit"';
            TableRelation = "Gen. Product Posting Group";


        }
        field(46; Picture; BLOB)
        {
            Caption = 'Picture', comment = 'FRA="Image"';
            SubType = Bitmap;
        }
        field(47; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                "Posting Date" = FIELD("Date Filter")
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Debit Amount', comment = 'FRA="Montant débit"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                 "Posting Date" = FIELD("Date Filter")
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Credit Amount', comment = 'FRA="Montant crédit"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Automatic Ext. Texts"; Boolean)
        {
            Caption = 'Automatic Ext. Texts', comment = 'FRA="Textes étendus automatiques"';
        }
        field(52; "Budgeted Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD("Date Filter"),
                                                               "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budgeted Debit Amount', comment = 'FRA="Montant débit budgété"';
            FieldClass = FlowField;
        }
        field(53; "Budgeted Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = - Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                Date = FIELD("Date Filter"),
                                                                "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budgeted Credit Amount', comment = 'FRA="Montant crédit budgété"';
            FieldClass = FlowField;
        }
        field(54; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'FRA="Code zone recouvrement"';
            TableRelation = "Tax Area";
        }
        field(55; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'FRA="Soumis à recouvrement"';
        }
        field(56; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code', comment = 'FRA="Code groupe taxes"';
            TableRelation = "Tax Group";
        }
        field(57; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group', comment = 'FRA="Groupe compta. marché TVA"';
            TableRelation = "VAT Business Posting Group";
        }
        field(58; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group', comment = 'FRA="Groupe compta. produit TVA"';
            TableRelation = "VAT Product Posting Group";
        }
        field(60; "Additional-Currency Net Change"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Posting Date" = FIELD("Date Filter")
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Additional-Currency Net Change', comment = 'FRA="Solde période DR"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Add.-Currency Balance at Date"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Add.-Currency Balance at Date', comment = 'FRA="Solde au DR"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Additional-Currency Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")
                                                                              //TODO:is removed      //   ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                              ));
            Caption = 'Additional-Currency Balance', comment = 'FRA="Solde DR"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Exchange Rate Adjustment"; Enum "Exch. Rate Adjustment Type")
        {
            Caption = 'Exchange Rate Adjustment', comment = 'FRA="Ajustement taux de change"';
        }
        field(64; "Add.-Currency Debit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Debit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD("Date Filter")
                                                                              //TODO:is removed    //  ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                              ));
            Caption = 'Add.-Currency Debit Amount', comment = 'FRA="Montant débit DR"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Add.-Currency Credit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER("Totaling")),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Posting Date" = FIELD("Date Filter")
                                                                               //TODO:is removed // ,"Entry Type" = FIELD("G/L Entry Type Filter")
                                                                               ));
            Caption = 'Add.-Currency Credit Amount', comment = 'FRA="Montant crédit DR"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Default IC Partner G/L Acc. No"; Code[20])
        {
            Caption = 'Default IC Partner G/L Acc. No', comment = 'FRA="N° cpte gén par déf parten IC"';
            TableRelation = "IC G/L Account"."No.";
        }
        field(10810; "G/L Entry Type Filter"; Enum BC6_EntryTypeFilter)
        {
            Caption = 'G/L Entry Type Filter', comment = 'FRA="Filtre type écriture"';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }



    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
        Text000: Label 'You cannot change %1 because there are one or more ledger entries associated with this account.', comment = 'FRA="Vous ne pouvez pas modifier %1 car il existe des écritures associées à ce compte."';
        Text001: Label 'You cannot change %1 because this account is part of one or more budgets.', comment = 'FRA="Vous ne pouvez pas modifier %1 car ce compte fait partie d un ou plusieurs budget(s)."';
        Text002: Label 'There is another %1: %2; which refers to the same %3, but with a different %4: %5.', comment = 'FRA="Il existe un autre %1 : %2, qui concerne le(la) même %3, mais avec un(e) autre %4 : %5."';
        Text10800: Label 'The first number in %1 must be from 1 to 9.', comment = 'FRA="Le premier nombre dans %1 doit se trouver entre 1 et 9."';


    procedure SetupNewGLAcc(OldGLAcc: Record "G/L Account"; BelowOldGLAcc: Boolean)
    var
        OldGLAcc2: Record "G/L Account";
    begin
    end;


    procedure CheckGLAcc()
    begin
    end;


    procedure GetCurrencyCode(): Code[10]
    begin
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;


    procedure TranslationMethodConflict(var GLAcc: Record "G/L Account"): Boolean
    begin
    end;
}

