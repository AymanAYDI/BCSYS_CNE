table 99006 "BC6_Customer Test"
{
    Caption = 'Customer', comment = 'FRA="Client"';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Customer List";
    LookupPageID = "Customer List";
    Permissions = TableData "Cust. Ledger Entry" = r;

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
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name', comment = 'FRA="Nom du groupe"';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount', comment = 'FRA="Montant budgété"';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)', comment = 'FRA="Crédit autorisé DS"';
        }
        field(21; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group', comment = 'FRA="Groupe compta. client"';
            TableRelation = "Customer Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code', comment = 'FRA="Code devise"';
            TableRelation = Currency;
        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group', comment = 'FRA="Groupe prix client"';
            TableRelation = "Customer Price Group";
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
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code', comment = 'FRA="Code vendeur"';
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
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export', comment = 'FRA="Lieu d''exportation"';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code', comment = 'FRA="Code remise facture"';
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group', comment = 'FRA="Groupe rem. client"';
            TableRelation = "Customer Discount Group";
        }
        field(35; "Country Code"; Code[10])
        {
            Caption = 'Country Code', comment = 'FRA="Code pays"';
            TableRelation = "Country/Region";
        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method', comment = 'FRA="Mode de recouvrement"';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'FRA="Montant"';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment', comment = 'FRA="Commentaires"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked', comment = 'FRA="Bloqué"';
        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies', comment = 'FRA="Nombre exemplaires facture"';
        }
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.', comment = 'FRA="N° dern. relevé"';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements', comment = 'FRA="Imprimer relevés"';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', comment = 'FRA="N° client facturé"';
            TableRelation = Customer;
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter")
                                                                         , "Currency Code" = field("Currency Filter")
                                                                         ));
            Caption = 'Balance', comment = 'FRA="Solde"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter")
                                                              , "Currency Code" = field("Currency Filter")
                                                                         ));
            Caption = 'Balance (LCY)', comment = 'FRA="Solde DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter")
                                                                        , "Currency Code" = field("Currency Filter")
                                                                         ));
            Caption = 'Net Change', comment = 'FRA="Solde période"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change (LCY)', comment = 'FRA="Solde période DS"';
            Editable = false;
        }
        field(62; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Cust. Ledger Entry"."Sales (LCY)" WHERE("Customer No." = field("No."),
                                                                                 //TODO    //  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 //  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Sales (LCY)', comment = 'FRA="Ventes DS"';
            Editable = false;
        }
        field(63; "Profit (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Profit (LCY)" WHERE("Customer No." = field("No."),
                                                                                 //TODO  //  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 //  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Profit (LCY)', comment = 'FRA="Marge DS"';
            Editable = false;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Inv. Discount (LCY)" WHERE("Customer No." = field("No."),
                                                                                 //TODO  //  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 //  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)', comment = 'FRA="Remises facture DS"';
            Editable = false;

        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = field("No."),
                                                                                  "Entry Type" = FILTER("Payment Discount" .. 'Payment Discount (VAT Adjustment)'),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)', comment = 'FRA="Escomptes DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = field("No."),
                                                                         "Posting Date" = field(UPPERLIMIT("Date Filter")),
                                                                         "Initial Entry Due Date" = field("Date Filter"),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due', comment = 'FRA="Solde dû"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = field("No."),
                                                                         "Posting Date" = field(UPPERLIMIT("Date Filter")),
                                                                         "Initial Entry Due Date" = field("Date Filter"),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due (LCY)', comment = 'FRA="Solde dû DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Payment),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Payments', comment = 'FRA="Paiements"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Invoice),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Invoice Amounts', comment = 'FRA="Montants factures"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts', comment = 'FRA="Montants avoirs"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts', comment = 'FRA="Montants intérêts de retard"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Payments (LCY)', comment = 'FRA="Paiements DS"';
            Editable = false;

        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)', comment = 'FRA="Montants factures DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)', comment = 'FRA="Montants avoirs DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)', comment = 'FRA="Montants int. retard DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders', comment = 'FRA="Commandes ouvertes"';
            Editable = false;

        }
        field(79; "Shipped Not Invoiced"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                         "Bill-to Customer No." = field("No."),
                                                                         "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced', comment = 'FRA="Livré non facturé"';
            Editable = false;

        }
        field(80; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method', comment = 'FRA="Mode de lettrage"';
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT', comment = 'FRA="Prix TTC"';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'FRA="Code magasin"';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
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
        field(87; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments', comment = 'FRA="Regroupement B.L."';
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
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount" WHERE("Customer No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount" WHERE("Customer No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
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
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code', comment = 'FRA="Code condition relance"';
            TableRelation = "Reminder Terms";
        }
        field(105; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Reminder),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts', comment = 'FRA="Montants relances"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Reminder),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
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
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)', comment = 'FRA="Commandes ouvertes DS"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
                                                                               "Bill-to Customer No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)', comment = 'FRA="Livré non facturé DS"';
            Editable = false;

        }
        field(115; Reserve; Enum "Reserve Method")
        {
            Caption = 'Reserve', comment = 'FRA="Réserver"';
            InitValue = Optional;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance', comment = 'FRA="Bloquer écart de règlement"';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Refund),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds', comment = 'FRA="Remboursements"';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Refund),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds (LCY)', comment = 'FRA="Remboursements DS"';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(" "),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts', comment = 'FRA="Autres montants"';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(" "),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
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
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            Caption = 'Shipping Advice', comment = 'FRA="Option d''expédition"';
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time', comment = 'FRA="Délai d''expédition"';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code', comment = 'FRA="Code prestation transporteur"';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code', comment = 'FRA="Code zone service"';
            TableRelation = "Service Zone";
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Gain/Loss Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                       "Ship-to Code" = FIELD("Ship-to Filter"),
                                                                       "Change Date" = FIELD("Date Filter")));
            Caption = 'Contract Gain/Loss Amount', comment = 'FRA="Montant gain/perte contrat"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter', comment = 'FRA="Filtre destinataire"';
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }
        field(6207; "Notification Process Code"; Code[10])
        {
            Caption = 'Notification Process Code', comment = 'FRA="Code processus de notification"';
            //TODO //tab6221 is missing    TableRelation = Table6221;
        }
        field(6209; "Queue Priority"; Enum "BC6_Queue Priority")
        {
            Caption = 'Queue Priority', comment = 'FRA="Priorité file"';
            InitValue = Medium;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.', comment = 'FRA="Autoriser remise ligne"';
            InitValue = true;
        }
        field(7171; "No. of Quotes"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Quote),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Quotes', comment = 'FRA="Nbre de devis"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7172; "No. of Blanket Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Blanket Orders', comment = 'FRA="Nbre de commandes ouvertes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7173; "No. of Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Orders', comment = 'FRA="Nbre de commandes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7174; "No. of Invoices"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Invoices', comment = 'FRA="Nbre de factures"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7175; "No. of Return Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Return Order"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Return Orders', comment = 'FRA="Nbre de retours"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Credit Memos', comment = 'FRA="Nbre d''avoirs"';
            Editable = false;

        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = Count("Sales Shipment Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Shipments', comment = 'FRA="Nbre d''expéditions enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Sales Invoice Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Invoices', comment = 'FRA="Nbre de factures enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = Count("Return Receipt Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Return Receipts', comment = 'FRA="Nbre de réceptions retour enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Credit Memos', comment = 'FRA="Nbre d''avoirs enregistrés"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = Count("Ship-to Address" WHERE("Customer No." = FIELD("No.")));
            Caption = 'No. of Ship-to Addresses', comment = 'FRA="Nbre d''adresses destinataire"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Quote"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Quotes', comment = 'FRA="Facturation - Nbre de devis"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Blanket Orders', comment = 'FRA="Facturation - Nbre de commandes ouvertes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Orders', comment = 'FRA="Facturation - Nbre de commandes"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Invoices', comment = 'FRA="Facturation - Nbre de factures"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Return Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Return Orders', comment = 'FRA="Facturation - Nbre de retours"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Credit Memos', comment = 'FRA="Facturation - Nbre d''avoirs"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = Count("Sales Shipment Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments', comment = 'FRA="Facturation - Nbre d''expéditions enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Sales Invoice Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices', comment = 'FRA="Facturation - Nbre de factures enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = Count("Return Receipt Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Return Receipts', comment = 'FRA="Facturation - Nbre de réceptions retour enregistrées"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Credit Memos', comment = 'FRA="Facturation - Nbre d''avoirs enregistrés"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code', comment = 'FRA="Code calendrier principal"';
            TableRelation = "Base Calendar";
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Enum "Contact Type")
        {
            Caption = 'Copy Sell-to Addr. to Qte From', comment = 'FRA="Copier adr donn ordre => devis"';
        }
        field(10810; "Default Bank Account Code"; Code[10])
        {
            Caption = 'Default Bank Account Code', comment = 'FRA="Code compte bancaire par défaut"';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("No."));
        }
        field(10860; "Payment in progress (LCY)"; Decimal)
        {
            CalcFormula = - Sum("Payment Line"."Amount (LCY)" WHERE("Account Type" = CONST("Customer"),
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
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001; User; Code[20])
        {
            Caption = 'User', comment = 'FRA="Utilisateur"';
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
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode de transport';
            TableRelation = "Transport Method";
        }
        field(50005; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point', comment = 'FRA="Pays Destination"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays Destination';
            TableRelation = "Entry/Exit Point";
        }
        field(50006; "Area"; Code[10])
        {
            Caption = 'Area', comment = 'FRA="Departement Destination"';
            TableRelation = Area;
        }
        field(50007; "SFAC Contract Date"; Date)
        {
            Caption = 'SFAC Contract Date', comment = 'FRA="Date contrat SFAC"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50008; "SFAC Contract No."; Code[20])
        {
            Caption = 'SFAC Contract No.', comment = 'FRA="N° contrat SFAC"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50009; "Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', comment = 'FRA="Tiers payeur"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(50020; "Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', comment = 'FRA="Goupe Marge Vente Client"';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; LockedQuote; Boolean)
        {
            Caption = 'LockedQuote', comment = 'FRA="DevisBloqué"';
        }
        field(50022; UnlokedQuote; Boolean)
        {
            Caption = 'UnlokedQuote', comment = 'FRA="DevisDébloqué"';
        }
        field(50023; NumUnlockedQuote; Code[20])
        {
            Caption = 'NumUnlockedQuote', comment = 'FRA="NumDevisDébloqué"';
        }
        field(50024; "Code SIREN"; Code[14])
        {
            Description = 'ImportFichiersBase RD 14/11/06 NCS1.01 [FE019V1] Reprise des données';
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
        key(Key3; "Customer Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; "Country Code")
        {
        }
        key(Key6; "Gen. Bus. Posting Group")
        {
        }
        key(Key7; Name, Address, City)
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
        key(Key9; "Pay-to Customer No.")
        {
        }
    }

    fieldgroups
    {
    }



    var
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.', comment = 'FRA="Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 vente ouverte pour ce client."';
        Text002: Label 'Do you wish to create a contact for %1 %2?', comment = 'FRA="Souhaitez-vous créer un contact pour %1 %2 ?"';
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        ServContract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: Label 'Contact %1 %2 is not related to customer %3 %4.', comment = 'FRA="Le contact %1 %2 n''est pas associé au client %3 %4."';
        Text004: Label 'post', comment = 'FRA="valider"';
        Text005: Label 'create', comment = 'FRA="créer"';
        Text006: Label 'You cannot %1 this type of document when Customer %2 is blocked with type %3', comment = 'FRA="Vous ne pouvez pas %1 ce type de document lorsque le client %2 est bloqué avec le type %3"';
        Text007: Label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.', comment = 'FRA="Vous ne pouvez pas supprimer l''enregistrement %1 %2 car il existe au moins un contrat service qui n''a pas été annulé pour ce client."';
        Text008: Label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?', comment = 'FRA="Supprimer l''enregistrement %1 %2 va entraîner la suppression de la valeur %3 pour les articles de service associés. Souhaitez-vous continuer ?"';
        Text009: Label 'Cannot delete customer.', comment = 'FRA="Impossible de supprimer ce client."';
        Text010: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.', comment = 'FRA="La valeur %1 %2 a été affectée à %3 %4.\La même valeur %1 ne peut pas être entrée sur plus d''un/une %3. Entrez un autre code."';
        Text011: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?', comment = 'FRA="Le rapprochement des transactions IC risque de poser problème si vous modifiez le code partenaire IC car ce/cette %1 comporte des écritures appartenant à un exercice comptable qui n''a pas encore été clôturé.\ Souhaitez-vous quand même modifier le code partenaire IC ?"';
        Text012: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.', comment = 'FRA="Vous ne pouvez pas modifier la valeur du champ %1 car ce/cette %2 comporte une ou plusieurs écritures ouvertes."';
        "--NSC1.00--": Label '';
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?', comment = 'FRA="Vous ne pouvez pas modifier la valeur du champ %1 car ce/cette %2 comporte une ou plusieurs écritures ouvertes."';


}

