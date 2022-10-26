table 99008 "Vendor Test"
{
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl]         Ajout des champs 50000, 50001
    //                                                              Ajout de code dans le trigger OnInsert() pour alimenter ces champs
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm]             Ajout des champs 50002..50006
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50007 "Pay-to Vend. No."
    //                                                              Ajout de code pour mise à jour du champ "Pay-to Vend. No."
    //                                                              Ajout de la clé: "Pay-to Vend. No."
    //                                                              Mise à jour des Ecritures fournisseurs suite à la modification
    //                                                              du Fournisseur Payeur
    //                                                              Ajout de code sur le trigger "Pay-to Vend. No. - OnValidate()"
    //                                                              Ajout de la fonction updateLedgerEntries()
    // //MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant 50010

    Caption = 'Vendor';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = 27;
    LookupPageID = 27;
    Permissions = TableData 25 = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(21; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = Salesperson/Purchaser;
        }
        field(30;"Shipment Method Code";Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(31;"Shipping Agent Code";Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(33;"Invoice Disc. Code";Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35;"Country Code";Code[10])
        {
            Caption = 'Country Code';
            TableRelation = Country/Region;
        }
        field(38;Comment;Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE (Table Name=CONST(Vendor),
                                                      No.=FIELD(No.)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39;Blocked;Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(45;"Pay-to Vendor No.";Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
        }
        field(46;Priority;Integer)
        {
            Caption = 'Priority';
        }
        field(47;"Payment Method Code";Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(54;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56;"Global Dimension 1 Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(57;"Global Dimension 2 Filter";Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(58;Balance;Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59;"Balance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60;"Net Change";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61;"Net Change (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62;"Purchases (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Vendor Ledger Entry"."Purchase (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                             Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                             Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                             Posting Date=FIELD(Date Filter),
                                                                             Currency Code=FIELD(Currency Filter)));
            Caption = 'Purchases (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64;"Inv. Discounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Vendor Ledger Entry"."Inv. Discount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                  Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                                  Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65;"Pmt. Discounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                  Entry Type=FILTER(Payment Discount..'Payment Discount (VAT Adjustment)'),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66;"Balance Due";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Vendor No.=FIELD(No.),
                                                                           Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                                           Initial Entry Due Date=FIELD(Date Filter),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67;"Balance Due (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                   Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                                                   Initial Entry Due Date=FIELD(Date Filter),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69;Payments;Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Payment),
                                                                          Entry Type=CONST(Initial Entry),
                                                                          Vendor No.=FIELD(No.),
                                                                          Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                          Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                          Posting Date=FIELD(Date Filter),
                                                                          Currency Code=FIELD(Currency Filter)));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70;"Invoice Amounts";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Invoice),
                                                                           Entry Type=CONST(Initial Entry),
                                                                           Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71;"Cr. Memo Amounts";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Credit Memo),
                                                                          Entry Type=CONST(Initial Entry),
                                                                          Vendor No.=FIELD(No.),
                                                                          Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                          Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                          Posting Date=FIELD(Date Filter),
                                                                          Currency Code=FIELD(Currency Filter)));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72;"Finance Charge Memo Amounts";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Finance Charge Memo),
                                                                           Entry Type=CONST(Initial Entry),
                                                                           Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74;"Payments (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Payment),
                                                                                  Entry Type=CONST(Initial Entry),
                                                                                  Vendor No.=FIELD(No.),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75;"Inv. Amounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Invoice),
                                                                                   Entry Type=CONST(Initial Entry),
                                                                                   Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76;"Cr. Memo Amounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Credit Memo),
                                                                                  Entry Type=CONST(Initial Entry),
                                                                                  Vendor No.=FIELD(No.),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77;"Fin. Charge Memo Amounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Finance Charge Memo),
                                                                                   Entry Type=CONST(Initial Entry),
                                                                                   Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78;"Outstanding Orders";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE (Document Type=CONST(Order),
                                                                          Pay-to Vendor No.=FIELD(No.),
                                                                          Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                          Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                          Currency Code=FIELD(Currency Filter)));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79;"Amt. Rcd. Not Invoiced";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE (Document Type=CONST(Order),
                                                                              Pay-to Vendor No.=FIELD(No.),
                                                                              Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                              Currency Code=FIELD(Currency Filter)));
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80;"Application Method";Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82;"Prices Including VAT";Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                PurchPrice: Record "7012";
                Item: Record "27";
                VATPostingSetup: Record "325";
                Currency: Record "4";
            begin
            end;
        }
        field(84;"Fax No.";Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85;"Telex Answer Back";Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86;"VAT Registration No.";Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "381";
            begin
            end;
        }
        field(88;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(89;Picture;BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92;County;Text[30])
        {
            Caption = 'County';
        }
        field(97;"Debit Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE (Vendor No.=FIELD(No.),
                                                                                  Entry Type=FILTER(<>Application),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98;"Credit Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE (Vendor No.=FIELD(No.),
                                                                                   Entry Type=FILTER(<>Application),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99;"Debit Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                        Entry Type=FILTER(<>Application),
                                                                                        Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                        Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                        Posting Date=FIELD(Date Filter),
                                                                                        Currency Code=FIELD(Currency Filter)));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100;"Credit Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                         Entry Type=FILTER(<>Application),
                                                                                         Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                         Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                         Posting Date=FIELD(Date Filter),
                                                                                         Currency Code=FIELD(Currency Filter)));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
        }
        field(103;"Home Page";Text[80])
        {
            Caption = 'Home Page';
        }
        field(104;"Reminder Amounts";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Reminder),
                                                                           Entry Type=CONST(Initial Entry),
                                                                           Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105;"Reminder Amounts (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Reminder),
                                                                                   Entry Type=CONST(Initial Entry),
                                                                                   Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108;"Tax Area Code";Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(109;"Tax Liable";Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110;"VAT Bus. Posting Group";Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(111;"Currency Filter";Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113;"Outstanding Orders (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE (Document Type=CONST(Order),
                                                                                Pay-to Vendor No.=FIELD(No.),
                                                                                Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                                Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                                Currency Code=FIELD(Currency Filter)));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114;"Amt. Rcd. Not Invoiced (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" WHERE (Document Type=CONST(Order),
                                                                                    Pay-to Vendor No.=FIELD(No.),
                                                                                    Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                                    Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                                    Currency Code=FIELD(Currency Filter)));
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(116;"Block Payment Tolerance";Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117;"Pmt. Disc. Tolerance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                  Entry Type=FILTER(Payment Discount Tolerance|'Payment Discount Tolerance (VAT Adjustment)'|'Payment Discount Tolerance (VAT Excl.)'),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118;"Pmt. Tolerance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(No.),
                                                                                  Entry Type=FILTER(Payment Tolerance|'Payment Tolerance (VAT Adjustment)'|'Payment Tolerance (VAT Excl.)'),
                                                                                  Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                  Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                  Posting Date=FIELD(Date Filter),
                                                                                  Currency Code=FIELD(Currency Filter)));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119;"IC Partner Code";Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                VendLedgEntry: Record "25";
                AccountingPeriod: Record "50";
                ICPartner: Record "413";
            begin
            end;
        }
        field(120;Refunds;Decimal)
        {
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(Refund),
                                                                           Entry Type=CONST(Initial Entry),
                                                                           Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121;"Refunds (LCY)";Decimal)
        {
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(Refund),
                                                                                   Entry Type=CONST(Initial Entry),
                                                                                   Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(122;"Other Amounts";Decimal)
        {
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Initial Document Type=CONST(" "),
                                                                           Entry Type=CONST(Initial Entry),
                                                                           Vendor No.=FIELD(No.),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Currency Filter)));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123;"Other Amounts (LCY)";Decimal)
        {
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Initial Document Type=CONST(" "),
                                                                                   Entry Type=CONST(Initial Entry),
                                                                                   Vendor No.=FIELD(No.),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Currency Filter)));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(5049;"Primary Contact No.";Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record "5050";
                ContBusRel: Record "5054";
            begin
            end;

            trigger OnValidate()
            var
                Cont: Record "5050";
                ContBusRel: Record "5054";
            begin
            end;
        }
        field(5700;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5701;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE (Use As In-Transit=CONST(No));
        }
        field(5790;"Lead Time Calculation";DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(6200;"Reverse Auction Participant";Boolean)
        {
            Caption = 'Reverse Auction Participant';
        }
        field(6207;"Notification Process Code";Code[10])
        {
            Caption = 'Notification Process Code';
            TableRelation = Table6221;
        }
        field(6209;"Queue Priority";Option)
        {
            Caption = 'Queue Priority';
            InitValue = Medium;
            OptionCaption = 'Very Low,,Low,Medium,High,,,Very High';
            OptionMembers = "Very Low",,Low,Medium,High,,,"Very High";
        }
        field(7600;"Base Calendar Code";Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(10810;"Default Bank Account Code";Code[10])
        {
            Caption = 'Default Bank Account Code';
            TableRelation = "Vendor Bank Account".Code WHERE (Vendor No.=FIELD(No.));
        }
        field(10860;"Payment in progress (LCY)";Decimal)
        {
            CalcFormula = Sum("Payment Line"."Amount (LCY)" WHERE (Account Type=CONST(Vendor),
                                                                   Account No.=FIELD(No.),
                                                                   Copied To Line=CONST(0),
                                                                   Payment in Progress=CONST(Yes)));
            Caption = 'Payment in progress (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Creation Date";Date)
        {
            Caption = 'Creation Date';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001;User;Code[20])
        {
            Caption = 'User';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
            TableRelation = Table2000000002;
        }
        field(50002;"Transaction Type";Code[10])
        {
            Caption = 'Transaction Type';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Nature Transaction';
            TableRelation = "Transaction Type";
        }
        field(50003;"Transaction Specification";Code[10])
        {
            Caption = 'Transaction Specification';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Régime';
            TableRelation = "Transaction Specification";
        }
        field(50004;"Transport Method";Code[10])
        {
            Caption = 'Transport Method';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode transport';
            TableRelation = "Transport Method";
        }
        field(50005;"Entry Point";Code[10])
        {
            Caption = 'Entry  Point';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays';
            TableRelation = "Entry/Exit Point";
        }
        field(50006;"Area";Code[10])
        {
            Caption = 'Area';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Département';
            TableRelation = Area;
        }
        field(50007;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010;"Mini Amount";Decimal)
        {
            Caption = 'Montant Mini cde';
            Description = 'MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant';
        }
        field(50011;MinCde;Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Commande';
        }
        field(50012;MinFranco;Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Franco';
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"Search Name")
        {
        }
        key(Key3;"Vendor Posting Group")
        {
        }
        key(Key4;"Currency Code")
        {
        }
        key(Key5;Priority)
        {
        }
        key(Key6;"Country Code")
        {
        }
        key(Key7;"Gen. Bus. Posting Group")
        {
        }
        key(Key8;"VAT Registration No.")
        {
        }
        key(Key9;"Reverse Auction Participant")
        {
        }
        key(Key10;"Pay-to Vend. No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemVendor: Record "99";
        PurchPrice: Record "7012";
        PurchLineDiscount: Record "7014";
    begin
    end;

    var
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: Label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: Label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "312";
        CommentLine: Record "97";
        PurchOrderLine: Record "39";
        PostCode: Record "225";
        VendBankAcc: Record "288";
        OrderAddr: Record "224";
        GenBusPostingGrp: Record "250";
        ItemCrossReference: Record "5717";
        RMSetup: Record "5079";
        ServiceItem: Record "5940";
        NoSeriesMgt: Codeunit "396";
        MoveEntries: Codeunit "361";
        UpdateContFromVend: Codeunit "5057";
        DimMgt: Codeunit "408";
        InsertFromContact: Boolean;
        Text004: Label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: Label 'post';
        Text006: Label 'create';
        Text007: Label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        "--NSC1.00--": ;
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?';

    [Scope('Internal')]
    procedure AssistEdit(OldVend: Record "23"): Boolean
    var
        Vend: Record "23";
    begin
    end;

    [Scope('Internal')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
    end;

    [Scope('Internal')]
    procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
    end;

    [Scope('Internal')]
    procedure ShowContact()
    var
        ContBusRel: Record "5054";
        Cont: Record "5050";
    begin
    end;

    [Scope('Internal')]
    procedure SetInsertFromContact(FromContact: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure CheckBlockedVendOnDocs(Vend2: Record "23";Transaction: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure CheckBlockedVendOnJnls(Vend2: Record "23";DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge",Reminder,Refund;Transaction: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure VendBlockedErrorMessage(Vend2: Record "23";Transaction: Boolean)
    var
        "Action": Text[30];
    begin
    end;

    [Scope('Internal')]
    procedure "---NSC1.00---"()
    begin
    end;

    [Scope('Internal')]
    procedure updateLedgerEntries(CodLVendNo: Code[20];CodLPayToNo: Code[20])
    var
        RecLVendLedgEntry: Record "25";
        RecLDetVendLedgEntry: Record "380";
    begin
    end;
}

