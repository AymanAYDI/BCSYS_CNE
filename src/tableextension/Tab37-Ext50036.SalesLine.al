tableextension 50036 "BC6_SalesLine" extends "Sales Line" //37
{
    fields
    {
        modify("Return Reason Code")
        {
            TableRelation = IF ("Document Type" = FILTER("Return Order"),
                                "BC6_Return Order Type" = FILTER(Location)) "Return Reason" WHERE(BC6_Type = FILTER(Location))
            ELSE
            IF ("Document Type" = FILTER("Return Order"),
                                         "BC6_Return Order Type" = FILTER(SAV)) "Return Reason" WHERE(BC6_Type = FILTER(SAV));
        }
        field(50000; "BC6_Document Date flow"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Document Date" WHERE("No." = FIELD("Document No."),
                                                                       "Document Type" = FIELD("Document Type")));
            Caption = 'Document Date', Comment = 'FRA="Date document"';
            FieldClass = FlowField;
        }
        field(50001; "BC6_To Prepare"; Boolean)
        {
            Caption = 'To Prepare', Comment = 'FRA="A préparer"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Purchase Receipt Date"; Date)
        {
            Caption = 'Purchase Receipt Date', Comment = 'FRA="Date réception achat"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Qty. To Order"; Decimal)
        {
            Caption = 'Qty. To Order', Comment = 'FRA="Qté à commander"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Forecast Inventory"; Integer)
        {
            Caption = 'Forecast Inventory', Comment = 'FRA="Stock prévisionnel"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_To Order"; Boolean)
        {
            Caption = 'To Order', Comment = 'FRA="A commander"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>FEP-ACHAT-200706_18_A.002
                IF "BC6_Purch. Order No." <> '' THEN BEGIN
                    IF NOT CONFIRM(TextG005) THEN
                        ERROR('');
                END;
                //<<FEP-ACHAT-200706_18_A.002
            end;
        }
        field(50008; "BC6_Promised Purchase Receipt Date"; Boolean)
        {
            Caption = 'Purchase Receipt Date', Comment = 'FRA="Date réception achat confirmée"';
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', Comment = 'FRA="Goupe Marge Vente Client"';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article', Comment = 'FRA="Goupe Marge Vente Article"';
            TableRelation = "BC6_Item Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Tarif Public', Comment = 'FRA="Tarif Public"';
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.', Comment = 'FRA="N° doc. externe"';
            DataClassification = CustomerContent;
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)', Comment = 'FRA="Montant DS"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.', Comment = 'FRA="N° preneur d''ordre"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', Comment = 'FRA="N° commande achat"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                reclPurchHdr: Record "Purchase Header";
            begin
                //>>FE004.4
                reclPurchHdr.SETFILTER("Document Type", '%1', "BC6_Purch. Document Type");
                reclPurchHdr.SETFILTER("No.", "BC6_Purch. Order No.");
                CASE "BC6_Purch. Document Type" OF
                    "BC6_Purch. Document Type"::Order:
                        PAGE.RUNMODAL(PAGE::"Purchase Order", reclPurchHdr);
                    "BC6_Purch. Document Type"::Quote:
                        PAGE.RUNMODAL(PAGE::"Purchase Quote", reclPurchHdr);
                END;
                //<<FE004.4
            end;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.', Comment = 'FRA="N° ligne commande achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50028; "BC6_Purch. Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Purch. Document Type', Comment = 'FRA="Type document achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity', Comment = 'FRA="Quantité commandée"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity', Comment = 'FRA="Quantité livrée"';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount unit price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Discount unit price excluding VAT', Comment = 'FRA="Prix unitaire remisé HT"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item', Comment = 'FRA="Disponibilité article"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Outstanding qty"; Decimal)
        {
            Caption = 'Outstanding Quantity', Comment = 'FRA="quantité restante"';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Pick Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37),
                                                                                         "Source Subtype" = CONST(1),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Action Type" = CONST(Take)));
            Caption = 'Pick Qty.', Comment = 'FRA="Prélever qté"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "BC6_Purchase cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Purchase cost', Comment = 'FRA="Coût d''achat"';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                L_Item: Record Item;
                L_Vendor: Record Vendor;
                L_UserSetup: Record "User Setup";
                ShowErrorMsg: Boolean;
            begin
                //BC6 - MM 15/02/19 >>
                IF (("Document Type" = "Document Type"::Quote) OR ("Document Type" = "Document Type"::Order)) AND
                   NOT SkipPurchCostVerif AND
                   (xRec."BC6_Purchase cost" <> Rec."BC6_Purchase cost") THEN BEGIN
                    ShowErrorMsg := FALSE;
                    IF L_UserSetup.GET(USERID) AND L_UserSetup."BC6_Activ. Mini Margin Control" THEN BEGIN
                        IF Type = Type::Item THEN BEGIN
                            L_Item.GET("No.");
                            ShowErrorMsg := (L_Item."BC6_Cost Increase Coeff %" <> 0);
                            IF NOT ShowErrorMsg THEN
                                IF L_Vendor.GET(L_Item."Vendor No.") THEN
                                    ShowErrorMsg := L_Vendor."BC6_Blocked Prices";
                        END;
                    END;
                    IF ShowErrorMsg THEN
                        ERROR(UpdatePurchCostErr, FIELDCAPTION("BC6_Purchase cost"));
                END;
                //BC6 - MM 15/02/19 <<

                //COUT_ACHAT FG 20/12/06 NSC1.01
                CalcProfit;
                //CalcDiscount ;
                //Fin COUT_ACHAT FG 20/12/06 NSC1.01

                //>>CNEIC : 06/2015
                RecGCompanyInfo.FINDFIRST;
                IF (RecGCompanyInfo."BC6_Branch Company" = FALSE) AND (SalesHeader."Sell-to IC Partner Code" <> '') THEN BEGIN
                    // prix de vente avec 2 dec.
                    //VALIDATE("Unit Price","Purchase cost");
                    VALIDATE("Unit Price", ROUND("BC6_Purchase cost", 0.01));
                END;
                //<<CNEIC : 06/2015
            end;
        }
        field(50042; "BC6_Invoiced Date (Expected)"; Date)
        {
            Caption = 'Date facturation prévue', Comment = 'FRA="Date facturation prévue"';
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Affect purchase order"; Boolean)
        {
            Caption = 'Affect purchase order', Comment = 'FRA="Affecter commande achat"';
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Order purchase affected"; Boolean)
        {
            Caption = 'Order purchase affected', Comment = 'FRA="Commande achat affectée"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien', Comment = 'FRA="N° Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Purchase No. Line Lien"; Integer)
        {
            Caption = 'Purchase No. Line Lien', Comment = 'FRA="N° ligne Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50100; "BC6_Item Disc. Group"; Code[10])
        {
            Caption = 'Groupe remise article', Comment = 'FRA="Groupe remise article"';
            TableRelation = "Item Discount Group";
            DataClassification = CustomerContent;
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation', Comment = 'FRA="N° dérogation"';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire', Comment = 'FRA="% remise complémentaire"';
            DataClassification = CustomerContent;
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé', Comment = 'FRA="Coût d''achat dérogé"';
            DataClassification = CustomerContent;
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard', Comment = 'FRA="Prix net standard"';
            DataClassification = CustomerContent;
        }
        field(50120; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type', Comment = 'FRA="Type  retour vente"';
            DataClassification = CustomerContent;
        }
        field(50121; "BC6_Solution Code"; Code[10])
        {
            Caption = 'Solution Code', Comment = 'FRA="Code solution"';
            Description = 'BCSYS';
            TableRelation = IF ("Document Type" = FILTER("Return Order"),
                                "BC6_Return Order Type" = FILTER(Location)) "BC6_Return Solution" WHERE(Type = FILTER(Location))
            ELSE
            IF ("Document Type" = FILTER("Return Order"),
                                         "BC6_Return Order Type" = FILTER(SAV)) "BC6_Return Solution" WHERE(Type = FILTER(SAV));
            DataClassification = CustomerContent;
        }
        field(50122; "BC6_Return Comment"; Text[50])
        {
            Caption = 'Return Comment', Comment = 'FRA="Commentaire retour"';
            DataClassification = CustomerContent;
        }
        field(50123; "BC6_Return Order-Shpt Sales Order"; Code[20])
        {
            Caption = 'Return-Sales Order', Comment = 'FRA="Retour-Commande vente"';
            DataClassification = CustomerContent;
        }
        field(50124; "BC6_Series No."; Text[250])
        {
            Caption = 'N° de série', Comment = 'FRA="N° de série"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>DEEE1.00
                CalculateDEEE('');
                //<<DEEE1.00
            end;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price', Comment = 'FRA="Prix Unitaire DEEE"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetSalesHeader;
                RecLCurrency.InitRoundingPrecision;
                IF SalesHeader."Currency Code" <> '' THEN
                    "BC6_DEEE Unit Price (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
                          "BC6_DEEE Unit Price", SalesHeader."Currency Factor"),
                        RecLCurrency."Amount Rounding Precision")
                ELSE
                    "BC6_DEEE Unit Price (LCY)" :=
                      ROUND("BC6_DEEE Unit Price", RecLCurrency."Amount Rounding Precision");

                VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
                "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
                "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
                "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";

                //<<DEEE1.00  : calculate DEEE amount (LCY)
            end;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', Comment = 'FRA="Montant HT DEEE"';
            Description = 'DEEE1.00';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetSalesHeader;
                Currency2.InitRoundingPrecision;
                IF SalesHeader."Currency Code" <> '' THEN
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
                          "BC6_DEEE HT Amount", SalesHeader."Currency Factor"),
                        Currency2."Amount Rounding Precision")
                ELSE
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND("BC6_DEEE HT Amount", Currency2."Amount Rounding Precision");

                //<<DEEE1.00  : calculate DEEE amount (LCY)
            end;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)', Comment = 'FRA="Prix Unitaire DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', Comment = 'FRA="Montant TVA DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', Comment = 'FRA="Montant TTC DEEE"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'DEEE Amount (LCY) for Stat', Comment = 'FRA="DEEE Amount (LCY) pour Stat"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        // key(Key21; "Document Type", "Buy-from Vendor No.")
        // {
        // }
        // key(Key22; "Document Type", "Document No.", "Sell-to Customer No.", "No.")
        // {
        // }
        // key(Key23; "Buy-from Vendor No.", "Qty. To Order", "To Order")
        // {
        // }
        // key(Key24; "Document Type", "No.")
        // {
        // }
        // key(Key25; "Document Type", "Sell-to Customer No.", "No.")
        // {
        // }
        // key(Key26; "Document Date", "Document Type", "No.")
        // {
        // }
        // key(Key27; "Buy-from Vendor No.", "Shipment Date")
        // {
        // }
        // key(Key28; "Buy-from Vendor No.", "No.", "Shipment Date")
        // {
        // }
        // key(Key29; "Document Type", "Document No.", "No.", "Document Date")
        // {
        // }
        // key(Key30; "Purch. Document Type", "Purch. Order No.", "Purch. Line No.")
        // {
        //     SumIndexFields = "Quantity (Base)";
        // }
        // key(Key31; "To Order", "Buy-from Vendor No.", "No.", "Purchase cost", "Qty. To Order")
        // {
        // }
        // key(Key32; "To Order", "Buy-from Vendor No.", "Document No.", "Line No.", "Qty. To Order")
        // {
        // }
        // key(Key33; "Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.")
        // {
        // }
        // key(Key34; "Document Type", Type, "Outstanding Quantity", "Purchasing Code")
        // {
        // }
        // key(Key35; "Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment")
        // {
        // }
        // key(Key36; "Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Buy-from Vendor No.", "Shipment Date")
        // {
        // }
        // key(Key37; "Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "Buy-from Vendor No.", "Shipment Date")
        // {
        // }
        // key(Key38; "Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Buy-from Vendor No.", "No.", "Shipment Date")
        // {
        // }
        // key(Key39; "Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "Buy-from Vendor No.", "No.", "Shipment Date")
        // {
        // }
        // key(Key40; Type, "No.")
        // {
        // }
        // key(Key41; "Document Type", "Document No.", "Completely Shipped")
        // {
        // }
        // key(Key42; "Document Type", "Document No.", Type)
        // {
        // }
        // key(Key43; "Bill-to Customer No.", "Document Type", "Document No.", "Line No.")
        // {
        // }
    }



    procedure TestStatusLocked()
    begin
        GetSalesHeader;
        IF SalesHeader."BC6_Quote statut" = SalesHeader."BC6_Quote statut"::locked THEN
            ERROR(TextG001);
    end;

    procedure CalcProfit()
    var
        reclPurchLine: Record "Purchase Line";
    begin
        GetSalesHeader;
        IF (Type = Type::Item) AND ("BC6_Discount unit price" <> 0) THEN BEGIN
            //"Profit %" := ROUND(100 * (1 - ("Purchase cost" / "Discount unit price")),Currency."Amount Rounding Precision") ;
            //>>FEP_ADVE_200711_21_1-DEROGATOIRE
            IF (("BC6_Purchase cost" <> "BC6_Dispensed Purchase Cost") AND ("BC6_Dispensed Purchase Cost" <> 0)) THEN
                "Profit %" := 100 * (1 - ("BC6_Dispensed Purchase Cost" / "BC6_Discount unit price"))
            ELSE
                //<<FEP_ADVE_200711_21_1-DEROGATOIRE

                "Profit %" := 100 * (1 - ("BC6_Purchase cost" / "BC6_Discount unit price"));
        END;
    end;

    procedure CalcDiscount()
    var
        reclpurchline: Record "Purchase Line";
    begin
        IF "Profit %" <> 100 THEN
            IF (Type = Type::Item) AND ("BC6_Purchase cost" <= (getUnitpriceHT * (1 - "Profit %" / 100))) THEN
                "Line Discount %" := 100 * (1 - ("BC6_Purchase cost" / (getUnitpriceHT * (1 - "Profit %" / 100))))
            ELSE
                "Line Discount %" := 0;

        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        FctGCalcLineDiscount();
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE

        IF "Line Discount %" < 0 THEN BEGIN
            //"Line Discount %" :=0 ;
            MESSAGE(TextG004, "Profit %", getUnitpriceHT);
        END;
        //UpdateAmounts;
    end;

    procedure CalcDiscountUnitPrice()
    begin
        GetSalesHeader;
        IF Type = Type::Item THEN BEGIN
            "BC6_Discount unit price" :=
              //ROUND(getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100), Currency."Amount Rounding Precision");
              getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100);
        END;
    end;

    procedure CalcLineDiscountAmount_asuppri()
    begin
        GetSalesHeader;
        IF (Type = Type::Item) AND (Quantity <> 0) THEN BEGIN
            VALIDATE("Line Discount Amount",
                       ROUND(getUnitpriceHT - "BC6_Discount unit price",
                         Currency."Amount Rounding Precision"));
            CalcProfit;
        END;
    end;

    procedure updatepurchasecost()
    var
        recLPurchLine: Record "Purchase Line";
    begin
        IF ("BC6_Purch. Order No." <> '') AND ("BC6_Purch. Line No." <> 0) THEN BEGIN
            recLPurchLine.SETFILTER("Document Type", '%1', "BC6_Purch. Document Type");
            recLPurchLine.SETFILTER("Document No.", "BC6_Purch. Order No.");
            recLPurchLine.SETFILTER("Line No.", '%1', "BC6_Purch. Line No.");
            IF FINDFIRST THEN
                "BC6_Purchase cost" := recLPurchLine."Direct Unit Cost"
            ELSE
                MESSAGE(TextG003, "BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
        END;
    end;

    procedure getUnitpriceHT() declpuht: Decimal
    begin
        GetSalesHeader;
        IF SalesHeader."Prices Including VAT" THEN
            declpuht := "Unit Price" / (1 + "VAT %" / 100)
        ELSE
            declpuht := "Unit Price";
        //EXIT(ROUND(declpuht,Currency."Amount Rounding Precision"));
        EXIT(declpuht);
    end;

    procedure CalculateDEEE(CodPNewReasonCode: Code[10])
    var
        RecLCustomer: Record Customer;
        RecLReasonCode: Record "Reason Code";
        RecLDEEETariffs: Record "BC6_DEEE Tariffs";
        RecLSalesSetup: Record "Sales & Receivables Setup";
        RecLItem: Record Item;
        IntLGenerate: Integer;
    begin
        //>>DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
        RecLSalesSetup.GET;
        GetSalesHeader;

        //>>DEEE1.01
        IF SalesHeader."Sell-to Customer No." <> '' THEN BEGIN
            //<<DEEE1.01
            RecLCustomer.GET(SalesHeader."Sell-to Customer No.");
            //>>DEEE1.01
            BooGsubmittedtodeee := RecLCustomer."BC6_Submitted to DEEE";
        END
        ELSE BEGIN
            IF RecGCustTemplate.GET(SalesHeader."Sell-to Customer Template Code") THEN BEGIN
                BooGsubmittedtodeee := RecGCustTemplate."BC6_Submitted to DEEE";
            END;
        END;
        //<<DEEE1.01

        IF CodPNewReasonCode <> '' THEN
            SalesHeader."Reason Code" := CodPNewReasonCode;

        IF NOT RecLReasonCode.GET(SalesHeader."Reason Code") THEN
            RecLReasonCode."BC6_Disable DEEE" := FALSE;

        IntLGenerate := 0;

        //assign value 2-> posting + Stat
        //assign value 1-> just for Stat
        //assign value 0-> nothing to do

        IF RecLSalesSetup."BC6_DEEE Management" THEN BEGIN
            RecLItem.GET("No.");
            IF RecLItem."BC6_DEEE Category Code" = '' THEN
                IntLGenerate := 0
            ELSE BEGIN
                //>>DEEE1.01
                //IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (RecLCustomer."Submitted to DEEE") THEN
                IF ((SalesHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (BooGsubmittedtodeee) THEN
                    //<<DEEE1.01
                    IntLGenerate := 2;
                //>>DEEE1.01
                //IF ((SalesHeader."Reason Code"='') OR (NOT RecLReasonCode."Disable DEEE")) AND (NOT RecLCustomer."Submitted to DEEE") THEN
                IF ((SalesHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (NOT BooGsubmittedtodeee) THEN
                    //<<DEEE1.01
                    //TDL94.001
                    //IntLGenerate:=1;
                    IntLGenerate := 0;
            END;
        END;

        //"Is Line Submitted":=IntLGenerate ;

        IF IntLGenerate = 0 THEN BEGIN
            //Initvalue
            "BC6_DEEE Unit Price" := 0;
            "BC6_DEEE HT Amount" := 0;
            "BC6_DEEE VAT Amount" := 0;
            "BC6_DEEE TTC Amount" := 0;
            "BC6_Eco partner DEEE" := '';
            "BC6_DEEE Amount (LCY) for Stat" := 0;
            //"Is Line Submitted":=0 ;
            EXIT; //get out from there
        END;

        //found the last tariff with the posting date (just for one eco partner)
        RecLDEEETariffs.RESET;
        RecLDEEETariffs.SETRANGE("DEEE Code", "BC6_DEEE Category Code");
        RecLDEEETariffs.SETRANGE("Eco Partner", RecLItem."BC6_Eco partner DEEE");
        //>>DEEE1.01
        IF SalesHeader."Posting Date" <> 0D THEN
            //<<DEEE1.01
            RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', SalesHeader."Posting Date")
        //>>DEEE1.01
        ELSE
            RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', SalesHeader."Document Date");
        //<<DEEE1.01
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
            ERROR('Paramétrage incorrect pour les filtres %1', RecLDEEETariffs.GETFILTERS); //textconstant
        END;

        VALIDATE("BC6_DEEE Unit Price", RecLDEEETariffs."HT Unit Tax (LCY)" * RecLItem."BC6_Number of Units DEEE");
        "BC6_Eco partner DEEE" := RecLItem."BC6_Eco partner DEEE";

        /*
        VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
        "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
        "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
        "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
        */

        IF IntLGenerate <> 2 THEN BEGIN
            VALIDATE("BC6_DEEE HT Amount", 0);
            "BC6_DEEE VAT Amount" := 0;
            "BC6_DEEE TTC Amount" := 0;
            //"Eco partner DEEE":='' ;
        END;

        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";

        //<<DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
    end;

    procedure FctGCalcLineDiscount()
    var
        RecLSalesLineDiscount: Record "Sales Line Discount";
        BooLCalc: Boolean;
        DecLDiscountAdded: Decimal;
        recLSalesheader: Record "Sales Header";
    begin
        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        IF "BC6_Discount unit price" <> 0 THEN BEGIN
            CLEAR(DecLDiscountAdded);
            IF "BC6_Standard Net Price" = 0 THEN
                "BC6_Standard Net Price" := "BC6_Discount unit price";
            IF recLSalesheader.GET("Document Type", "Document No.") THEN;
            RecLSalesLineDiscount.RESET;
            RecLSalesLineDiscount.SETFILTER(Type, '%1|%2', RecLSalesLineDiscount.Type::Item, RecLSalesLineDiscount.Type::"Item Disc. Group");
            RecLSalesLineDiscount.SETFILTER(Code, '%1|%2', "No.", "BC6_Item Disc. Group");
            RecLSalesLineDiscount.SETFILTER("Sales Type", '%1', RecLSalesLineDiscount."Sales Type"::Customer);
            RecLSalesLineDiscount.SETFILTER("Sales Code", "Sell-to Customer No.");
            RecLSalesLineDiscount.SETFILTER("Minimum Quantity", '<=%1', Quantity);
            RecLSalesLineDiscount.SETFILTER("BC6_Added Discount %", '<>%1', 0);
            IF RecLSalesLineDiscount.FIND('-') THEN
                REPEAT
                    BooLCalc := TRUE;
                    IF ((RecLSalesLineDiscount."Starting Date" <> 0D) AND (RecLSalesLineDiscount."Starting Date" >
                    recLSalesheader."Order Date")) THEN
                        BooLCalc := FALSE;
                    IF ((RecLSalesLineDiscount."Ending Date" <> 0D) AND (RecLSalesLineDiscount."Ending Date" <
                    recLSalesheader."Order Date")) THEN
                        BooLCalc := FALSE;
                    IF BooLCalc = TRUE THEN BEGIN
                        IF RecLSalesLineDiscount."BC6_Added Discount %" > DecLDiscountAdded THEN BEGIN
                            DecLDiscountAdded := RecLSalesLineDiscount."BC6_Added Discount %";
                            "BC6_Dispensation No." := RecLSalesLineDiscount."BC6_Dispensation No.";
                            "BC6_Additional Discount %" := RecLSalesLineDiscount."BC6_Added Discount %";
                        END;
                    END;
                UNTIL RecLSalesLineDiscount.NEXT = 0;

            IF DecLDiscountAdded <> 0 THEN BEGIN
                //"Line Discount %" := "Line Discount %" + ((1 - "Line Discount %"/100)* DecLDiscountAdded);
                "BC6_Dispensed Purchase Cost" := ("BC6_Purchase cost" * (1 - DecLDiscountAdded / 100));
            END;
        END;
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE
    end;

    procedure FctGDeletePurchLink()
    var
        PurchLine: Record "Purchase Line";
    begin
        TESTFIELD("Document Type", "Document Type"::Order);
        IF PurchLine.GET("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.") THEN BEGIN
            ERROR(TextG006);
        END ELSE BEGIN
            "BC6_Purch. Document Type" := 0;
            "BC6_Purch. Order No." := '';
            "BC6_Purch. Line No." := 0;
            MODIFY;
        END;
    end;

    procedure CalcIncreasePurchCost(var _IncrPurchCost: Decimal)
    var
        L_Item: Record Item;
    begin
        IF Type = Type::Item THEN
            IF (L_Item.GET("No.")) THEN
                //BC6 - MM 050319 >>
                IF L_Item."BC6_Cost Increase Coeff %" = 0 THEN
                    _IncrPurchCost := "BC6_Purchase cost"
                ELSE
                    //BC6 - MM 050319 <<
                    _IncrPurchCost := ROUND("BC6_Purchase cost" * (1 + (L_Item."BC6_Cost Increase Coeff %" / 100)), 0.01);
    end;

    procedure CalcIncreaseProfit(var _IncrProfit: Decimal; _IncrPurchCost: Decimal)
    var
        L_Item: Record Item;
    begin
        //BC6 - MM 050319 >>
        IF Type = Type::Item THEN
            IF (L_Item.GET("No.")) THEN
                IF L_Item."BC6_Cost Increase Coeff %" = 0 THEN
                    _IncrProfit := "Profit %"
                ELSE
                    //BC6 - MM 050319 <<
                    IF "BC6_Discount unit price" <> 0 THEN
                        _IncrProfit := ROUND(100 * (1 - (_IncrPurchCost / "BC6_Discount unit price")), 0.01)
                    ELSE
                        _IncrProfit := 0;
    end;

    procedure ValidateIncreasePurchCost(var _IncrPurchCost: Decimal)
    begin
        CalcDecreasePurchCost(_IncrPurchCost);
        VALIDATE("BC6_Purchase cost", _IncrPurchCost);
        CalcIncreasePurchCost(_IncrPurchCost);
    end;

    local procedure CalcDecreasePurchCost(var _IncrPurchCost: Decimal)
    var
        L_Item: Record Item;
    begin
        IF Type = Type::Item THEN BEGIN
            IF L_Item.GET("No.") THEN
                _IncrPurchCost := ROUND(_IncrPurchCost / (1 + (L_Item."BC6_Cost Increase Coeff %" / 100)), 0.01);
        END;
    end;

    procedure ValidateIncreaseProfit(var _IncrProfit: Decimal; var _IncrPurchCost: Decimal)
    var
        TargetedProfit: Decimal;
    begin
        CalcIncreasePurchCost(_IncrPurchCost);
        CalcDiscountIncreased(_IncrProfit, _IncrPurchCost);
        CalcDiscountUnitPriceIncreased;
        VALIDATE("Line Discount %");
    end;

    procedure CalcDiscountIncreased(IncreasedProfit: Decimal; IncreasedPurchaseCost: Decimal)
    var
        reclpurchline: Record "Purchase Line";
    begin
        IF IncreasedProfit <> 100 THEN
            IF (Type = Type::Item) AND (IncreasedPurchaseCost <= (getUnitpriceHT * (1 - IncreasedProfit / 100))) THEN
                "Line Discount %" := 100 * (1 - (IncreasedPurchaseCost / (getUnitpriceHT * (1 - IncreasedProfit / 100))))
            ELSE
                "Line Discount %" := 0;

        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        FctGCalcLineDiscountIncreased();
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE

        IF "Line Discount %" < 0 THEN BEGIN
            //"Line Discount %" :=0 ;
            MESSAGE(TextG004, IncreasedProfit, getUnitpriceHT);
        END;
        //UpdateAmounts;
    end;

    procedure CalcDiscountUnitPriceIncreased()
    begin
        GetSalesHeader;
        IF Type = Type::Item THEN BEGIN
            "BC6_Discount unit price" :=
              //ROUND(getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100), Currency."Amount Rounding Precision");
              getUnitpriceHT - (getUnitpriceHT * "Line Discount %" / 100);
        END;
    end;

    procedure FctGCalcLineDiscountIncreased()
    var
        RecLSalesLineDiscount: Record "Sales Line Discount";
        BooLCalc: Boolean;
        DecLDiscountAdded: Decimal;
        recLSalesheader: Record "Sales Header";
    begin
        //>>FEP_ADVE_200711_21_1-DEROGATOIRE
        IF "BC6_Discount unit price" <> 0 THEN BEGIN
            CLEAR(DecLDiscountAdded);
            IF "BC6_Standard Net Price" = 0 THEN
                "BC6_Standard Net Price" := "BC6_Discount unit price";
            IF recLSalesheader.GET("Document Type", "Document No.") THEN;
            RecLSalesLineDiscount.RESET;
            RecLSalesLineDiscount.SETFILTER(Type, '%1|%2', RecLSalesLineDiscount.Type::Item, RecLSalesLineDiscount.Type::"Item Disc. Group");
            RecLSalesLineDiscount.SETFILTER(Code, '%1|%2', "No.", "BC6_Item Disc. Group");
            RecLSalesLineDiscount.SETFILTER("Sales Type", '%1', RecLSalesLineDiscount."Sales Type"::Customer);
            RecLSalesLineDiscount.SETFILTER("Sales Code", "Sell-to Customer No.");
            RecLSalesLineDiscount.SETFILTER("Minimum Quantity", '<=%1', Quantity);
            RecLSalesLineDiscount.SETFILTER("BC6_Added Discount %", '<>%1', 0);
            IF RecLSalesLineDiscount.FIND('-') THEN
                REPEAT
                    BooLCalc := TRUE;
                    IF ((RecLSalesLineDiscount."Starting Date" <> 0D) AND (RecLSalesLineDiscount."Starting Date" >
                    recLSalesheader."Order Date")) THEN
                        BooLCalc := FALSE;
                    IF ((RecLSalesLineDiscount."Ending Date" <> 0D) AND (RecLSalesLineDiscount."Ending Date" <
                    recLSalesheader."Order Date")) THEN
                        BooLCalc := FALSE;
                    IF BooLCalc = TRUE THEN BEGIN
                        IF RecLSalesLineDiscount."BC6_Added Discount %" > DecLDiscountAdded THEN BEGIN
                            DecLDiscountAdded := RecLSalesLineDiscount."BC6_Added Discount %";
                            "BC6_Dispensation No." := RecLSalesLineDiscount."BC6_Dispensation No.";
                            "BC6_Additional Discount %" := RecLSalesLineDiscount."BC6_Added Discount %";
                        END;
                    END;
                UNTIL RecLSalesLineDiscount.NEXT = 0;

            IF DecLDiscountAdded <> 0 THEN BEGIN
                //"Line Discount %" := "Line Discount %" + ((1 - "Line Discount %"/100)* DecLDiscountAdded);
                "BC6_Dispensed Purchase Cost" := ("BC6_Purchase cost" * (1 - DecLDiscountAdded / 100));
            END;
        END;
        //<<FEP_ADVE_200711_21_1-DEROGATOIRE
    end;

    procedure UpdateReturnOrderTypeFromSalesHeader()
    var
        L_SalesHeader: Record "Sales Header";
    begin
        //>>BCSYS
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            IF L_SalesHeader.GET("Document Type", "Document No.") THEN;
            "BC6_Return Order Type" := L_SalesHeader."BC6_Return Order Type";
        END;
        //<<BCSYS
    end;

    procedure SetSkipPurchCostVerif(Skip: Boolean)
    begin
        SkipPurchCostVerif := Skip;
    end;

    procedure GetSkipPurchCostVerif(): Boolean
    begin
        exit(SkipPurchCostVerif);
    end;

    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        "--COR001--": TextConst;
        TextDate: Label '0D';
        "--NSC1.01--": Integer;
        GLSetup: Record "General Ledger Setup";
        TextG001: Label 'Quote Locked';
        textg002: Label 'You will lost link between Sales document No %1 line %2 \ and purchase document of type %3, No %4 ,  line %5 \ Are you sure?';
        TextG003: Label 'Document %1, No %2 line %3 not found';
        TextG004: Label 'Profit % %1 notpossible with %2 as Unit price (excluding VAT) ';
        BooGsubmittedtodeee: Boolean;
        RecGCustTemplate: Record "Customer Template";
        "--- TDL94.001---": Integer;
        RecGCustomer: Record Customer;
        TextG005: Label 'There is a Purchase Order existing for this Line. Do you want to continue ?';
        TextG006: Label 'Vous devez supprimer la ligne de commande d''achat pour cette ligne. ';
        RecGCompanyInfo: Record "Company Information";
        UpdatePurchCostErr: Label 'Unable to modify %1';
        UpdateProfitErr: Label '%1 cannot be less than %2 in %3 %4';
        "---BC6---": Integer;
        SkipPurchCostVerif: Boolean;
}
