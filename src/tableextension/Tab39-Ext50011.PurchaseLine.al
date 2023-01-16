tableextension 50011 "BC6_PurchaseLine" extends "Purchase Line" //39
{
    fields
    {
        modify("Return Reason Code")
        {
            TableRelation = IF ("Document Type" = FILTER("Return Order"),
                             "BC6_Return Order Type" = FILTER(Location)) "Return Reason" WHERE("BC6_Type" = FILTER(Location))
            ELSE
            IF ("Document Type" = FILTER("Return Order"),
                               "BC6_Return Order Type" = FILTER(SAV)) "Return Reason" WHERE("BC6_Type" = FILTER(SAV));
        }
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.', comment = 'FRA="No commande vente"';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnLookup()
            var
                reclSalesHeader: Record "Sales Header";
            begin
                reclSalesHeader.SETFILTER("Document Type", '%1', reclSalesHeader."Document Type"::Order);
                reclSalesHeader.SETFILTER("No.", "BC6_Sales No.");
                PAGE.RUNMODAL(PAGE::"Sales Order", reclSalesHeader);
            end;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.', comment = 'FRA="No ligne commande vente"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "BC6_Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type', comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "BC6_Document Date flow"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Document Date" WHERE("No." = FIELD("Document No.")));
            Caption = 'Document Date', comment = 'FRA="Date document"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "BC6_Document Date"; Date)
        {
            Caption = 'Document Date', comment = 'FRA="Date Document"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Public Price', comment = 'FRA="Tarif Public"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Sales Order Qty (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Sales Line"."Quantity (Base)" WHERE("BC6_Purch. Document Type" = FIELD("Document Type"),
                                                                    "BC6_Purch. Order No." = FIELD("Document No."),
                                                                    "BC6_Purch. Line No." = FIELD("Line No.")));
            Caption = 'Sales Assigned Qty (Base)', comment = 'FRA="Quantité affecte vente (Base)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT', comment = 'FRA="Coût unitaire direct remisé HT"';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(50060; "BC6_Sales No. Order Lien"; Code[20])
        {
            Caption = 'Sales No. Order Lien', comment = 'FRA="N° Commande Vente Lien"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Sales No. Line Lien"; Integer)
        {
            Caption = 'Sales No. Line Lien', comment = 'FRA="No ligne Commande Vente Lien"';
            DataClassification = CustomerContent;
        }
        field(50120; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type', comment = 'FRA="Type retour achat"';
            DataClassification = CustomerContent;
        }
        field(50121; "BC6_Solution Code"; Code[10])
        {
            Caption = 'Solution Code', comment = 'FRA="Code Solution"';
            DataClassification = CustomerContent;
            TableRelation = IF ("Document Type" = FILTER("Return Order"),
                                "BC6_Return Order Type" = FILTER(Location)) "BC6_Return Solution" WHERE(Type = FILTER(Location))
            ELSE
            IF ("Document Type" = FILTER("Return Order"),
                                         "BC6_Return Order Type" = FILTER(SAV)) "BC6_Return Solution" WHERE(Type = FILTER(SAV));
        }
        field(50122; "BC6_Return Comment"; Text[50])
        {
            Caption = 'Return Comment', comment = 'FRA="Commentaire retour"';
            DataClassification = CustomerContent;
        }
        field(50123; "BC6_Retrn. Sales OrderShpt"; Code[20])
        {
            Caption = 'Return-Sales Order', comment = 'FRA="Retour-Commande vente"';
            DataClassification = CustomerContent;
        }
        field(50124; "BC6_Series No."; Text[250])
        {
            Caption = 'N° de série', comment = 'FRA="N° de série"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', comment = 'FRA="Code Catégorie DEEE"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Categories of item".Category;

            trigger OnValidate()
            begin
                CalculateDEEE('');
            end;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price', comment = 'FRA="Prix Unitaire DEEE"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
                GetPurchHeader(PurchHeader, RecLCurrency);
                RecLCurrency.InitRoundingPrecision();
                IF PurchHeader."Currency Code" <> '' THEN
                    "BC6_DEEE Unit Price (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate(), "Currency Code",
                          "BC6_DEEE Unit Price", PurchHeader."Currency Factor"),
                        RecLCurrency."Amount Rounding Precision")
                ELSE
                    "BC6_DEEE Unit Price (LCY)" :=
                      ROUND("BC6_DEEE Unit Price", RecLCurrency."Amount Rounding Precision");

                VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
                "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
                "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
                "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";
            end;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
                GetPurchHeader();
                RecLCurrency.InitRoundingPrecision();
                IF PurchHeader."Currency Code" <> '' THEN
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate(), "Currency Code",
                          "BC6_DEEE HT Amount", PurchHeader."Currency Factor"),
                        RecLCurrency."Amount Rounding Precision")
                ELSE
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND("BC6_DEEE HT Amount", RecLCurrency."Amount Rounding Precision");
            end;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)', comment = 'FRA="Prix Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', comment = 'FRA="Montant TTC DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', comment = 'FRA="Montant Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'DEEE Amount (LCY) for Stat', comment = 'FRA="Montant pour (DS)"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
    }

    procedure CalcDiscountDirectUnitCost()
    var
        RecLSalesLine: Record "Sales Line";
    begin
        IF (Type = Type::Item) THEN BEGIN
            GetPurchHeader();
            "BC6_Discount Direct Unit Cost" :=
              ROUND("Direct Unit Cost" - ("Direct Unit Cost" * "Line Discount %" / 100), Currency."Amount Rounding Precision");

            IF PurchHeader."Prices Including VAT" THEN
                "BC6_Discount Direct Unit Cost" := "BC6_Discount Direct Unit Cost" / (1 + "VAT %" / 100);
            //BCSYS 200618 remis le IF commenté
            IF ("BC6_Sales No." <> '') AND ("BC6_Sales Line No." <> 0) THEN BEGIN
                RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
                RecLSalesLine.SETFILTER("BC6_Purch. Document Type", '%1', "Document Type");
                RecLSalesLine.SETFILTER("BC6_Purch. Order No.", "Document No.");
                RecLSalesLine.SETFILTER("BC6_Purch. Line No.", '%1', "Line No.");
                IF RecLSalesLine.FIND('-') THEN
                    REPEAT
                        //>>PDW : le 03/08/2015 : Même si la commande est lancée.
                        RecLSalesLine.SuspendStatusCheck(TRUE);
                        //<<PDW : le 03/08/2015
                        RecLSalesLine.VALIDATE("BC6_Purchase cost", "BC6_Discount Direct Unit Cost");
                        RecLSalesLine.MODIFY();
                    UNTIL RecLSalesLine.NEXT() = 0;
            END;
        END;
    end;

    procedure CalculateDEEE(CodPNewReasonCode: Code[10])
    var
        RecLDEEETariffs: Record "BC6_DEEE Tariffs";
        RecLItem: Record Item;
        RecLPurchSetup: Record "Purchases & Payables Setup";
        RecLReasonCode: Record "Reason Code";
        RecLVendor: Record Vendor;
        IntLGenerate: Integer;
    begin
        RecLPurchSetup.GET();
        GetPurchHeader(PurchHeader, Currency);
        RecLVendor.GET(PurchHeader."Buy-from Vendor No.");

        IF CodPNewReasonCode <> ''
           THEN
            PurchHeader."Reason Code" := CodPNewReasonCode;

        IF NOT RecLReasonCode.GET(PurchHeader."Reason Code")
           THEN
            RecLReasonCode."BC6_Disable DEEE" := FALSE;

        IntLGenerate := 0;
        IF RecLPurchSetup."BC6_DEEE Management" THEN BEGIN
            RecLItem.GET("No.");
            IF RecLItem."BC6_DEEE Category Code" = '' THEN
                IntLGenerate := 0
            ELSE BEGIN
                IF ((PurchHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (RecLVendor."BC6_Posting DEEE") THEN
                    IntLGenerate := 2;
                IF ((PurchHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (NOT RecLVendor."BC6_Posting DEEE") THEN
                    IntLGenerate := 0;
            END;
        END;

        IF IntLGenerate = 0 THEN BEGIN
            "BC6_DEEE Unit Price" := 0;
            "BC6_DEEE HT Amount" := 0;
            "BC6_DEEE VAT Amount" := 0;
            "BC6_DEEE TTC Amount" := 0;
            "BC6_Eco partner DEEE" := '';
            "BC6_DEEE Amount (LCY) for Stat" := 0;
            EXIT;
        END;

        //found the last tariff with the posting date (just one eco partner)
        RecLDEEETariffs.RESET();
        RecLDEEETariffs.SETRANGE("DEEE Code", "BC6_DEEE Category Code");
        RecLDEEETariffs.SETRANGE("Eco Partner", RecLItem."BC6_Eco partner DEEE");
        RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', PurchHeader."Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN
            ERROR('Paramétrage incorrect pour les filtres %1', RecLDEEETariffs.GETFILTERS);

        VALIDATE("BC6_DEEE Unit Price", RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."BC6_Number of Units DEEE");
        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_Eco partner DEEE" := RecLItem."BC6_Eco partner DEEE";
        "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";

        IF IntLGenerate <> 2 THEN BEGIN
            VALIDATE("BC6_DEEE HT Amount", 0);
            "BC6_DEEE VAT Amount" := 0;
            "BC6_DEEE TTC Amount" := 0;
        END;

        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";
    end;

    procedure UpdateReturnOrderTypeFromSalesHeader()
    var
        L_PurchaseHeader: Record "Purchase Header";
    begin
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            IF L_PurchaseHeader.GET("Document Type", "Document No.") THEN;
            "BC6_Return Order Type" := L_PurchaseHeader."BC6_Return Order Type";
        END;
    end;

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        RecGSalesLine: Record "Sales Line";
        TextG001: Label 'There is nothing to affect', comment = 'FRA="Il n''y a rien à affecter"';
}
