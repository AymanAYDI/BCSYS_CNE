table 99004 "G/L Account Test"
{
    Caption = 'G/L Account';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = 16;
    LookupPageID = 18;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            var
                GLEntry: Record "17";
                GLBudgetEntry: Record "96";
            begin
            end;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(9; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance';
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement","Balance Sheet";
        }
        field(10; "Debit/Credit"; Option)
        {
            Caption = 'Debit/Credit';
            OptionCaption = 'Both,Debit,Credit';
            OptionMembers = Both,Debit,Credit;
        }
        field(11; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist ("Comment Line" WHERE (Table Name=CONST(G/L Account),
                                                      No.=FIELD(No.)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;Blocked;Boolean)
        {
            Caption = 'Blocked';
        }
        field(14;"Direct Posting";Boolean)
        {
            Caption = 'Direct Posting';
            InitValue = true;
        }
        field(16;"Reconciliation Account";Boolean)
        {
            Caption = 'Reconciliation Account';
        }
        field(17;"New Page";Boolean)
        {
            Caption = 'New Page';
        }
        field(18;"No. of Blank Lines";Integer)
        {
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(19;Indentation;Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(26;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(28;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(29;"Global Dimension 1 Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(30;"Global Dimension 2 Filter";Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(31;"Balance at Date";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                        G/L Account No.=FIELD(FILTER(Totaling)),
                                                        Business Unit Code=FIELD(Business Unit Filter),
                                                        Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                        Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                        Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                        Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Balance at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32;"Net Change";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                        G/L Account No.=FIELD(FILTER(Totaling)),
                                                        Business Unit Code=FIELD(Business Unit Filter),
                                                        Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                        Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                        Posting Date=FIELD(Date Filter),
                                                        Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33;"Budgeted Amount";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                               G/L Account No.=FIELD(FILTER(Totaling)),
                                                               Business Unit Code=FIELD(Business Unit Filter),
                                                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                               Date=FIELD(Date Filter),
                                                               Budget Name=FIELD(Budget Filter)));
            Caption = 'Budgeted Amount';
            FieldClass = FlowField;
        }
        field(34;Totaling;Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35;"Budget Filter";Code[10])
        {
            Caption = 'Budget Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }
        field(36;Balance;Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                        G/L Account No.=FIELD(FILTER(Totaling)),
                                                        Business Unit Code=FIELD(Business Unit Filter),
                                                        Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                        Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                        Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37;"Budget at Date";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                               G/L Account No.=FIELD(FILTER(Totaling)),
                                                               Business Unit Code=FIELD(Business Unit Filter),
                                                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                               Date=FIELD(UPPERLIMIT(Date Filter)),
                                                               Budget Name=FIELD(Budget Filter)));
            Caption = 'Budget at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39;"Consol. Translation Method";Option)
        {
            Caption = 'Consol. Translation Method';
            OptionCaption = 'Average Rate (Manual),Closing Rate,Historical Rate,Composite Rate,Equity Rate';
            OptionMembers = "Average Rate (Manual)","Closing Rate","Historical Rate","Composite Rate","Equity Rate";

            trigger OnValidate()
            var
                ConflictGLAcc: Record "15";
            begin
            end;
        }
        field(40;"Consol. Debit Acc.";Code[20])
        {
            Caption = 'Consol. Debit Acc.';

            trigger OnValidate()
            var
                ConflictGLAcc: Record "15";
            begin
            end;
        }
        field(41;"Consol. Credit Acc.";Code[20])
        {
            Caption = 'Consol. Credit Acc.';

            trigger OnValidate()
            var
                ConflictGLAcc: Record "15";
            begin
            end;
        }
        field(42;"Business Unit Filter";Code[10])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(43;"Gen. Posting Type";Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale';
            OptionMembers = " ",Purchase,Sale;
        }
        field(44;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            var
                GenBusPostingGrp: Record "250";
            begin
            end;
        }
        field(45;"Gen. Prod. Posting Group";Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "251";
            begin
            end;
        }
        field(46;Picture;BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(47;"Debit Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                G/L Account No.=FIELD(FILTER(Totaling)),
                                                                Business Unit Code=FIELD(Business Unit Filter),
                                                                Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                Posting Date=FIELD(Date Filter),
                                                                Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(48;"Credit Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                 G/L Account No.=FIELD(FILTER(Totaling)),
                                                                 Business Unit Code=FIELD(Business Unit Filter),
                                                                 Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                 Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                 Posting Date=FIELD(Date Filter),
                                                                 Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49;"Automatic Ext. Texts";Boolean)
        {
            Caption = 'Automatic Ext. Texts';
        }
        field(52;"Budgeted Debit Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                               G/L Account No.=FIELD(FILTER(Totaling)),
                                                               Business Unit Code=FIELD(Business Unit Filter),
                                                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                               Date=FIELD(Date Filter),
                                                               Budget Name=FIELD(Budget Filter)));
            Caption = 'Budgeted Debit Amount';
            FieldClass = FlowField;
        }
        field(53;"Budgeted Credit Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = -Sum("G/L Budget Entry".Amount WHERE (G/L Account No.=FIELD(No.),
                                                                G/L Account No.=FIELD(FILTER(Totaling)),
                                                                Business Unit Code=FIELD(Business Unit Filter),
                                                                Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                Date=FIELD(Date Filter),
                                                                Budget Name=FIELD(Budget Filter)));
            Caption = 'Budgeted Credit Amount';
            FieldClass = FlowField;
        }
        field(54;"Tax Area Code";Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(55;"Tax Liable";Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(56;"Tax Group Code";Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(57;"VAT Bus. Posting Group";Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(58;"VAT Prod. Posting Group";Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(60;"Additional-Currency Net Change";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                              G/L Account No.=FIELD(FILTER(Totaling)),
                                                                              Business Unit Code=FIELD(Business Unit Filter),
                                                                              Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                              Posting Date=FIELD(Date Filter),
                                                                              Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Additional-Currency Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61;"Add.-Currency Balance at Date";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                              G/L Account No.=FIELD(FILTER(Totaling)),
                                                                              Business Unit Code=FIELD(Business Unit Filter),
                                                                              Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                              Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                                              Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Add.-Currency Balance at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62;"Additional-Currency Balance";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                              G/L Account No.=FIELD(FILTER(Totaling)),
                                                                              Business Unit Code=FIELD(Business Unit Filter),
                                                                              Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                              Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Additional-Currency Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63;"Exchange Rate Adjustment";Option)
        {
            Caption = 'Exchange Rate Adjustment';
            OptionCaption = 'No Adjustment,Adjust Amount,Adjust Additional-Currency Amount';
            OptionMembers = "No Adjustment","Adjust Amount","Adjust Additional-Currency Amount";
        }
        field(64;"Add.-Currency Debit Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Debit Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                              G/L Account No.=FIELD(FILTER(Totaling)),
                                                                              Business Unit Code=FIELD(Business Unit Filter),
                                                                              Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                              Posting Date=FIELD(Date Filter),
                                                                              Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Add.-Currency Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65;"Add.-Currency Credit Amount";Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Credit Amount" WHERE (G/L Account No.=FIELD(No.),
                                                                               G/L Account No.=FIELD(FILTER(Totaling)),
                                                                               Business Unit Code=FIELD(Business Unit Filter),
                                                                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                               Posting Date=FIELD(Date Filter),
                                                                               Entry Type=FIELD(G/L Entry Type Filter)));
            Caption = 'Add.-Currency Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66;"Default IC Partner G/L Acc. No";Code[20])
        {
            Caption = 'Default IC Partner G/L Acc. No';
            TableRelation = "IC G/L Account".No.;
        }
        field(10810;"G/L Entry Type Filter";Option)
        {
            Caption = 'G/L Entry Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Definitives,Simulations';
            OptionMembers = Definitives,Simulations;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        GLBudgetEntry: Record "96";
        CommentLine: Record "97";
        ExtTextHeader: Record "279";
        AnalysisViewEntry: Record "365";
        AnalysisViewBudgetEntry: Record "366";
        MoveEntries: Codeunit "361";
    begin
    end;

    var
        Text000: Label 'You cannot change %1 because there are one or more ledger entries associated with this account.';
        Text001: Label 'You cannot change %1 because this account is part of one or more budgets.';
        GLSetup: Record "98";
        DimMgt: Codeunit "408";
        GLSetupRead: Boolean;
        Text002: Label 'There is another %1: %2; which refers to the same %3, but with a different %4: %5.';
        Text10800: Label 'The first number in %1 must be from 1 to 9.';

    [Scope('Internal')]
    procedure SetupNewGLAcc(OldGLAcc: Record "15";BelowOldGLAcc: Boolean)
    var
        OldGLAcc2: Record "15";
    begin
    end;

    [Scope('Internal')]
    procedure CheckGLAcc()
    begin
    end;

    [Scope('Internal')]
    procedure GetCurrencyCode(): Code[10]
    begin
    end;

    [Scope('Internal')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
    end;

    [Scope('Internal')]
    procedure TranslationMethodConflict(var GLAcc: Record "15"): Boolean
    begin
    end;
}

