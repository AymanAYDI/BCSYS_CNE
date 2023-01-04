table 99008 "BC6_Vendor Test"
{
    Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Vendor List";
    LookupPageID = "Vendor List";
    Permissions = TableData "Vendor Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', comment = 'FRA="N°"';
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name', comment = 'FRA="Nom"';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name', comment = 'FRA="Nom de recherche"';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2', comment = 'FRA="Nom 2"';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address', comment = 'FRA="Adresse"';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2', comment = 'FRA="Adresse (2ème ligne)"';
        }
        field(7; City; Text[30])
        {
            Caption = 'City', comment = 'FRA="Ville"';
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact', comment = 'FRA="Contact"';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', comment = 'FRA="N° téléphone"';
        }
        field(10; "Telex No."; Text[30])
        {
            Caption = 'Telex No.', comment = 'FRA="N° télex"';
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.', comment = 'FRA="Notre n° cpte/fourn."';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code', comment = 'FRA="Code secteur"';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code', comment = 'FRA="Code axe principal 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code', comment = 'FRA="Code axe principal 2"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)', comment = 'FRA="Crédit autorisé DS"';
        }
        field(21; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code', comment = 'FRA="Code devise"';
            TableRelation = Currency;
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code', comment = 'FRA="Code langue"';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group', comment = 'FRA="Groupe statistiques"';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'FRA="Code conditions paiement"';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code', comment = 'FRA="Code condition intérêts"';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code', comment = 'FRA="Code acheteur"';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code', comment = 'FRA="Code condition livraison"';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code', comment = 'FRA="Code transporteur"';
            TableRelation = "Shipping Agent";
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code', comment = 'FRA="Code remise facture"';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Country Code"; Code[10])
        {
            Caption = 'Country Code', comment = 'FRA="Code pays"';
            TableRelation = "Country/Region";
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Vendor),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment', comment = 'FRA="Commentaires"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked', comment = 'FRA="Bloqué"';
        }
        field(45; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.', comment = 'FRA="N° fournisseur à payer"';
            TableRelation = Vendor;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority', comment = 'FRA="Priorité"';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'FRA="Code mode de règlement"';
            TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified', comment = 'FRA="Date dern. modification"';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter', comment = 'FRA="Filtre date"';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter', comment = 'FRA="Filtre axe principal 1"';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter', comment = 'FRA="Filtre axe principal 2"';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(58; Balance; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance', Comment = 'FRA="Solde"';
            Editable = false;

        }
        field(59; "Balance (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance (LCY)', comment = 'FRA="Solde DS"';
            Editable = false;

        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change', comment = 'FRA="Solde période"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change (LCY)', comment = 'FRA="Solde période DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Purchases (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Vendor Ledger Entry"."Purchase (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Purchases (LCY)', comment = 'FRA="Achats DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Vendor Ledger Entry"."Inv. Discount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)', comment = 'FRA="Remises facture DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Discount" .. 'Payment Discount (VAT Adjustment)'),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)', comment = 'FRA="Escomptes DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                           "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due', comment = 'FRA="Solde dû"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                   "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due (LCY)', comment = 'FRA="Solde dû DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Payment),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Vendor No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments', comment = 'FRA="Paiements"';
            Editable = false;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Invoice),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Invoice Amounts', comment = 'FRA="Montants factures"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts', comment = 'FRA="Montants avoirs"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts', comment = 'FRA="Montants intérêts de retard"';
            Editable = false;

        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Vendor No." = FIELD("No."),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments (LCY)', comment = 'FRA="Paiements DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Invoice),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)', comment = 'FRA="Montants factures DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Vendor No." = FIELD("No."),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)', comment = 'FRA="Montants avoirs DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)', comment = 'FRA="Montants int. retard DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                          "Pay-to Vendor No." = FIELD("No."),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders', comment = 'FRA="Commandes ouvertes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                              "Pay-to Vendor No." = FIELD("No."),
                                                                              "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Amt. Rcd. Not Invoiced', comment = 'FRA="Montant reçu non facturé"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method', comment = 'FRA="Mode de lettrage"';
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT', comment = 'FRA="Prix TTC"';
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.', comment = 'FRA="N° télécopie"';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back', comment = 'FRA="Télex retour"';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.', comment = 'FRA="N° identif. intracomm."';
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'FRA="Groupe compta. marché"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(89; Picture; BLOB)
        {
            Caption = 'Picture', comment = 'FRA="Image"';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code', comment = 'FRA="Code postal"';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(92; County; Text[30])
        {
            Caption = 'County', comment = 'FRA="Région"';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount', comment = 'FRA="Montant débit"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount', comment = 'FRA="Montant crédit"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount (LCY)', comment = 'FRA="Montant débit DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount (LCY)', comment = 'FRA="Montant crédit DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail', comment = 'FRA="E-mail"';
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page', comment = 'FRA="Page d''accueil"';
        }
        field(104; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Reminder"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts', comment = 'FRA="Montants relances"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Reminder"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)', comment = 'FRA="Montants relances DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series', comment = 'FRA="Souches de n°"';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'FRA="Code zone recouvrement"';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'FRA="Soumis à recouvrement"';
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group', comment = 'FRA="Groupe compta. marché TVA"';
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter', comment = 'FRA="Filtre devise"';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                                "Pay-to Vendor No." = FIELD("No."),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)', comment = 'FRA="Commandes ouvertes DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
                                                                                    "Pay-to Vendor No." = FIELD("No."),
                                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                    "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)', comment = 'FRA="Livré non facturé DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance', comment = 'FRA="Bloquer écart de règlement"';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Discount Tolerance" | 'Payment Discount Tolerance (VAT Adjustment)' | 'Payment Discount Tolerance (VAT Excl.)'),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)', comment = 'FRA="Ecart d''escompte DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Tolerance" | 'Payment Tolerance (VAT Adjustment)' | 'Payment Tolerance (VAT Excl.)'),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)', comment = 'FRA="Ecart de règlement DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code', comment = 'FRA="Code du partenaire IC"';
            TableRelation = "IC Partner";


        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Refund),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds', comment = 'FRA="Remboursements"';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Refund),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds (LCY)', comment = 'FRA="Remboursements DS"';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(" "),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts', comment = 'FRA="Autres montants"';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(" "),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts (LCY)', comment = 'FRA="Autres montants DS"';
            FieldClass = FlowField;
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.', comment = 'FRA="N° contact principal"';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center', comment = 'FRA="Centre de gestion"';
            TableRelation = "Responsibility Center";
        }
        field(5701; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'FRA="Code magasin"';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(5790; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation', comment = 'FRA="Délai de réappro."';
        }
        field(6200; "Reverse Auction Participant"; Boolean)
        {
            Caption = 'Reverse Auction Participant', comment = 'FRA="Participant appel d''offres"';
        }
        field(6207; "Notification Process Code"; Code[10])
        {
            Caption = 'Notification Process Code', comment = 'FRA="Code processus de notification"';
        }
        field(6209; "Queue Priority"; Enum "BC6_Queue Priority")
        {
            Caption = 'Queue Priority', comment = 'FRA="Priorité file"';
            InitValue = Medium;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code', comment = 'FRA="Code calendrier principal"';
            TableRelation = "Base Calendar";
        }
        field(10810; "Default Bank Account Code"; Code[10])
        {
            Caption = 'Default Bank Account Code', comment = 'FRA="Code compte bancaire par défaut"';
            TableRelation = "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("No."));
        }
        field(10860; "Payment in progress (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Amount (LCY)" WHERE("Account Type" = CONST(Vendor),
                                                                   "Account No." = FIELD("No."),
                                                                   "Copied To Line" = CONST(0),
                                                                   "Payment in Progress" = CONST(true)));
            Caption = 'Payment in progress (LCY)', comment = 'FRA="Règlement en cours DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Creation Date"; Date)
        {
            Caption = 'Creation Date', comment = 'FRA="Date de création"';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001; User; Code[20])
        {
            Caption = 'User', comment = 'FRA="Utilisateur"';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
            TableRelation = User;
        }
        field(50002; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type', comment = 'FRA="Nature Transaction"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Nature Transaction';
            TableRelation = "Transaction Type";
        }
        field(50003; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification', comment = 'FRA="Régime"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Régime';
            TableRelation = "Transaction Specification";
        }
        field(50004; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method', comment = 'FRA="Mode transport"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode transport';
            TableRelation = "Transport Method";
        }
        field(50005; "Entry Point"; Code[10])
        {
            Caption = 'Entry  Point', comment = 'FRA="Pays Provenance"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays';
            TableRelation = "Entry/Exit Point";
        }
        field(50006; "Area"; Code[10])
        {
            Caption = 'Area', comment = 'FRA="Departement Destination"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Département';
            TableRelation = Area;
        }
        field(50007; "Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010; "Mini Amount"; Decimal)
        {
            Caption = 'Montant Mini cde', comment = 'FRA="Montant Mini cde"';
            Description = 'MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant';
        }
        field(50011; MinCde; Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Commande';
        }
        field(50012; MinFranco; Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Franco';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Vendor Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; Priority)
        {
        }
        key(Key6; "Country Code")
        {
        }
        key(Key7; "Gen. Bus. Posting Group")
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
        key(Key9; "Reverse Auction Participant")
        {
        }
        key(Key10; "Pay-to Vend. No.")
        {
        }
    }

    fieldgroups
    {
    }



    var
        CommentLine: Record "Comment Line";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        OrderAddr: Record "Order Address";
        PostCode: Record "Post Code";
        PurchOrderLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        ServiceItem: Record "Service Item";
        VendBankAcc: Record "Vendor Bank Account";
        DimMgt: Codeunit DimensionManagement;
        MoveEntries: Codeunit MoveEntries;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateContFromVend: Codeunit "VendCont-Update";
        InsertFromContact: Boolean;
        "--NSC1.00--": Label '';
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.', comment = 'FRA="Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 achat ouverte pour ce fournisseur."';
        Text002: Label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?', comment = 'FRA="Vous avez paramétré %1 sur %2. Souhaitez-vous mettre à jour la liste des prix %3 en conséquence ?"';
        Text003: Label 'Do you wish to create a contact for %1 %2?', comment = 'FRA="Souhaitez-vous créer un contact pour %1 %2 ?"';
        Text004: Label 'Contact %1 %2 is not related to vendor %3 %4.', comment = 'FRA="Le contact %1 %2 n''est pas associé au fournisseur %3 %4."';
        Text005: Label 'post', comment = 'FRA="valider"';
        Text006: Label 'create', comment = 'FRA="créer"';
        Text007: Label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3', comment = 'FRA="Vous ne pouvez pas %1 ce type de document lorsque le fournisseur %2 est bloqué avec le type %3"';
        Text008: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.', comment = 'FRA="La valeur %1 %2 a été affectée à %3 %4.\La même valeur %1 ne peut pas être entrée sur plus d''un/une %3."';
        Text009: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?', comment = 'FRA="Le rapprochement des transactions IC risque de poser problème si vous modifiez le code partenaire IC car ce/cette %1 comporte des écritures appartenant à un exercice comptable qui n''a pas encore été clôturé.\ Souhaitez-vous quand même modifier le code partenaire IC ?"';
        Text010: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.', comment = 'FRA="Vous ne pouvez pas modifier la valeur du champ %1 car ce/cette %2 comporte une ou plusieurs écritures ouvertes."';
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?', comment = 'FRA="Voulez-vous mettre à jour les Ecritures ouvertes avec le Nouveau N° Tiers payeur %1?"';


}

