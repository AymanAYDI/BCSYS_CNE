tableextension 50041 "BC6_PurchaseLine" extends "Purchase Line"
{
    fields
    {
        // modify("No.")
        // {
        //     TableRelation = IF (Type = CONST(" ")) "Standard Text"
        //     ELSE
        //     IF (Type = CONST(G/L Account),
        //                              System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
        //                                                                                   Account Type=CONST(Posting),
        //                                                                                   Blocked=CONST(No))
        //                                                                                   ELSE IF (Type=CONST(G/L Account),
        //                                                                                            System-Created Entry=CONST(Yes)) "G/L Account"
        //                                                                                            ELSE IF (Type=CONST(Item)) Item
        //                                                                                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
        //                                                                                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

        //     //Unsupported feature: Property Insertion (ValidateTableRelation) on ""No."(Field 6)".

        //     CaptionClass = GetCaptionClass(FIELDNO("No."));
        // }
        // modify("Posting Group")
        // {
        //     TableRelation = IF (Type=CONST(Item)) "Inventory Posting Group"
        //                     ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
        // }

        // //Unsupported feature: Property Insertion (AccessByPermission) on ""Expected Receipt Date"(Field 10)".

        // modify(Description)
        // {
        //     Caption = 'Description';
        //     TableRelation = IF (Type=CONST(G/L Account),
        //                         System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
        //                                                                              Account Type=CONST(Posting),
        //                                                                              Blocked=CONST(No))
        //                                                                              ELSE IF (Type=CONST(G/L Account),
        //                                                                                       System-Created Entry=CONST(Yes)) "G/L Account"
        //                                                                                       ELSE IF (Type=CONST(Item)) Item
        //                                                                                       ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
        //                                                                                       ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

        //     //Unsupported feature: Property Insertion (ValidateTableRelation) on "Description(Field 11)".

        // }
        // modify("Description 2")
        // {
        //     Caption = 'Description 2';
        // }


        // modify("Shortcut Dimension 1 Code")
        // {
        //     TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1),
        //                                                   Blocked=CONST(No));
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2),
        //                                                   Blocked=CONST(No));
        // }

        // //Unsupported feature: Property Insertion (AccessByPermission) on ""Quantity Received"(Field 60)".

        // modify("Sales Order Line No.")
        // {
        //     TableRelation = IF (Drop Shipment=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
        //                                                                                  Document No.=FIELD(Sales Order No.));
        // }

        // //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        // modify("Attached to Line No.")
        // {
        //     TableRelation = "Purchase Line"."Line No." WHERE (Document Type=FIELD(Document Type),
        //                                                       Document No.=FIELD(Document No.));
        // }

        // modify("Blanket Order Line No.")
        // {
        //     TableRelation = "Purchase Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
        //                                                       Document No.=FIELD(Blanket Order No.));

        //     //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Line No."(Field 98)".

        // }
        // modify("Job Line Type")
        // {
        //     OptionCaption = ' ,Budget,Billable,Both Budget and Billable';

        //     //Unsupported feature: Property Modification (OptionString) on ""Job Line Type"(Field 1002)".


        //     //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Type"(Field 1002)".

        // }

        // modify("Bin Code")
        // {
        //     TableRelation = IF (Document Type=FILTER(Order|Invoice),
        //                         Quantity=FILTER(<0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
        //                                                                              Item No.=FIELD(No.),
        //                                                                              Variant Code=FIELD(Variant Code))
        //                                                                              ELSE IF (Document Type=FILTER(Return Order|Credit Memo),
        //                                                                                       Quantity=FILTER(>=0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
        //                                                                                                                                             Item No.=FIELD(No.),
        //                                                                                                                                             Variant Code=FIELD(Variant Code))
        //                                                                                                                                             ELSE Bin.Code WHERE (Location Code=FIELD(Location Code));
        // }
        // modify("Unit of Measure Code")
        // {
        //     TableRelation = IF (Type=CONST(Item),
        //                         No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
        //                         ELSE "Unit of Measure";
        // }

        // modify("Special Order Sales Line No.")
        // {
        //     TableRelation = IF (Special Order=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
        //                                                                                  Document No.=FIELD(Special Order Sales No.));

        //     //Unsupported feature: Property Insertion (AccessByPermission) on ""Special Order Sales Line No."(Field 5715)".

        // }

        // modify("Return Reason Code")
        // {
        //     TableRelation = IF (Document Type=FILTER(Return Order),
        //                         Return Order Type=FILTER(Location)) "Return Reason" WHERE (Type=FILTER(Location))
        //                         ELSE IF (Document Type=FILTER(Return Order),
        //                                  Return Order Type=FILTER(SAV)) "Return Reason" WHERE (Type=FILTER(SAV));
        // }
        // modify("Operation No.")
        // {
        //     TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
        //                                                                       Prod. Order No.=FIELD(Prod. Order No.),
        //                                                                       Routing No.=FIELD(Routing No.));
        // }
        // modify("Prod. Order Line No.")
        // {
        //     TableRelation = "Prod. Order Line"."Line No." WHERE (Status=FILTER(Released..),
        //                                                          Prod. Order No.=FIELD(Prod. Order No.));
        // }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                CalcDiscountDirectUnitCost;
                Modify();
            end;
        }
        modify("Expected Receipt Date")
        {
            trigger OnAfterValidate()
            var
                RecLSalesLine: Record "Sales Line";
            begin
                IF "Expected Receipt Date" <> 0D THEN BEGIN
                    RecLSalesLine.RESET;
                    RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
                    RecLSalesLine.SETRANGE("BC6_Purch. Document Type", "Document Type");
                    RecLSalesLine.SETRANGE("BC6_Purch. Order No.", "Document No.");
                    RecLSalesLine.SETRANGE("BC6_Purch. Line No.", "Line No.");
                    IF RecLSalesLine.FIND('-') THEN
                        REPEAT
                            RecLSalesLine.VALIDATE("BC6_Purchase Receipt Date", "Expected Receipt Date");
                            RecLSalesLine."BC6_Promised Purchase Receipt Date" := (PurchHeader."Expected Receipt Date" <> 0D);
                            RecLSalesLine.MODIFY;
                        UNTIL RecLSalesLine.NEXT = 0;

                END;
            end;
        }
        modify(Quantity)
        {
            VALIDATE("BC6_DEEE HT Amount",0) ;
            "BC6_DEEE VAT Amount" := 0;
            "BC6_DEEE TTC Amount" := 0;
            "BC6_DEEE Amount (LCY) for Stat":=0;

            RecGVendor.GET("Buy-from Vendor No.");
            IF RecGVendor."Posting DEEE" THEN BEGIN
                                                                  VALIDATE("DEEE HT Amount","DEEE Unit Price" * "Quantity (Base)") ;
            "DEEE VAT Amount" := ROUND("DEEE HT Amount" * "VAT %"/ 100,Currency."Amount Rounding Precision");
            "DEEE TTC Amount" := "DEEE HT Amount" + "DEEE VAT Amount" ;
            "DEEE Amount (LCY) for Stat":="Quantity (Base)"*"DEEE Unit Price (LCY)" ;
                                                                END;
        }


        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;

            trigger OnLookup()
            var
                reclSalesHeader: Record "Sales Header";
            begin
                //>>MIG2013
                reclSalesHeader.SETFILTER("Document Type", '%1', reclSalesHeader."Document Type"::Order);
                reclSalesHeader.SETFILTER("No.", "BC6_Sales No.");
                PAGE.RUNMODAL(PAGE::"Sales Order", reclSalesHeader);
                //<<MIG2013
            end;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(50002; "BC6_Sales Document Type"; Enum "BC6_Sales Document Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(50003; "BC6_Document Date flow"; Date)
        {
            Caption = 'Document Date';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Document Date" WHERE("No." = FIELD("Document No.")));
        }
        field(50004; "BC6_Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
        }
        field(50025; "BC6_Sales Order Qty (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Sales Line"."Quantity (Base)" WHERE("BC6_Purch. Document Type" = FIELD("Document Type"),
                                                                    "BC6_Purch. Order No." = FIELD("Document No."),
                                                                    "BC6_Purch. Line No." = FIELD("Line No.")));
            Caption = 'Sales Assigned Qty (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(50060; "BC6_Sales No. Order Lien"; Code[20])
        {
            Caption = 'Sales No. Order Lien';
            Description = 'CNEIC';
        }
        field(50061; "BC6_Sales No. Line Lien"; Integer)
        {
            Caption = 'Sales No. Line Lien';
            Description = 'CNEIC';
        }
        field(50120; "BC6_Return Order Type"; Enum "BC6_Return Order Type")
        {
            Caption = 'Return Order Type';
        }
        field(50121; "BC6_Solution Code"; Code[10])
        {
            Caption = 'Solution Code';
            TableRelation = IF ("Document Type" = FILTER("Return Order"),
                                "BC6_Return Order Type" = FILTER(Location)) "BC6_Return Solution" WHERE(Type = FILTER(Location))
            ELSE
            IF ("Document Type" = FILTER("Return Order"),
                                         "BC6_Return Order Type" = FILTER(SAV)) "BC6_Return Solution" WHERE(Type = FILTER(SAV));
        }
        field(50122; "BC6_Return Comment"; Text[50])
        {
            Caption = 'Return Comment';
        }
        field(50123; "BC6_Return Order-Shpt Sales Order"; Code[20])
        {
            Caption = 'Return-Sales Order';
        }
        field(50124; "BC6_Series No."; Text[250])
        {
            Caption = 'N° de série';
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            TableRelation = "BC6_Categories of item".Category;

            trigger OnValidate()
            begin
                CalculateDEEE('');
            end;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price';

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
                GetPurchHeader;
                RecLCurrency.InitRoundingPrecision;
                IF PurchHeader."Currency Code" <> '' THEN
                    "BC6_DEEE Unit Price (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
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
            Caption = 'DEEE HT Amount';
            Editable = false;

            trigger OnValidate()
            var
                RecLCurrency: Record Currency;
            begin
                //>>DEEE1.00  : calculate DEEE amount (LCY)
                GetPurchHeader;
                RecLCurrency.InitRoundingPrecision;
                IF PurchHeader."Currency Code" <> '' THEN
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          GetDate, "Currency Code",
                          "BC6_DEEE HT Amount", PurchHeader."Currency Factor"),
                        RecLCurrency."Amount Rounding Precision")
                ELSE
                    "BC6_DEEE HT Amount (LCY)" :=
                      ROUND("BC6_DEEE HT Amount", RecLCurrency."Amount Rounding Precision");

                //<<DEEE1.00  : calculate DEEE amount (LCY)
            end;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)';
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            TableRelation = Vendor;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Description = 'DEEE1.00';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Type,No.,Variant Code,Drop Shipment,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Location Code,Expected Receipt Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Pay-to Vendor No.,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Blanket Order No.,Blanket Order Line No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Type,Prod. Order No.,Prod. Order Line No.,Routing No.,Operation No."(Key)".

        // key(Key1; "Document Type", Type, "No.")
        // {
        //     SumIndexFields = "Outstanding Qty. (Base)";
        // }
        // key(Key2; "No.")
        // {
        // }
        // key(Key3; "Buy-from Vendor No.")
        // {
        // }
        // key(Key4; "Document Type", "Buy-from Vendor No.", "No.")
        // {
        // }
        // key(Key5; "Document Type", "No.")
        // {
        // }
        // key(Key6; "Document Date", "Document Type", "No.")
        // {
        // }
        // key(Key7; "Buy-from Vendor No.", Type, "Document Type")
        // {
        // }
        // key(Key8; "Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date")
        // {
        // }
        // key(Key9; "Sales Document Type", "Sales Line No.", "Sales No.")
        // {
        // }
        // key(Key10; Type, "No.")
        // {
        // }
    }


    ///////////////////////////////////////////////////////////////////
    procedure "---NSC1.01---"()
    begin
    end;

    procedure CalcDiscountDirectUnitCost()
    var
        RecLSalesLine: Record "Sales Line";
    begin
        IF (Type = Type::Item) THEN BEGIN
            GetPurchHeader;
            "BC6_Discount Direct Unit Cost" :=
              ROUND("Direct Unit Cost" - ("Direct Unit Cost" * "Line Discount %" / 100), Currency."Amount Rounding Precision");

            IF PurchHeader."Prices Including VAT" THEN BEGIN
                "BC6_Discount Direct Unit Cost" := "BC6_Discount Direct Unit Cost" / (1 + "VAT %" / 100);
            END;
            //BCSYS 200618 remis le IF commenté
            IF ("BC6_Sales No." <> '') AND ("BC6_Sales Line No." <> 0) THEN BEGIN
                RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
                RecLSalesLine.SETFILTER("BC6_Purch. Document Type", '%1', "Document Type");
                RecLSalesLine.SETFILTER("BC6_Purch. Order No.", "Document No.");
                RecLSalesLine.SETFILTER("BC6_Purch. Line No.", '%1', "Line No.");
                IF RecLSalesLine.FIND('-') THEN BEGIN
                    REPEAT
                        //        RecLSalesLine.VALIDATE("Profit %", 0);
                        //>>PDW : le 03/08/2015 : Même si la commande est lancée.
                        RecLSalesLine.SuspendStatusCheck(TRUE);
                        //<<PDW : le 03/08/2015
                        RecLSalesLine.VALIDATE("BC6_Purchase cost", "BC6_Discount Direct Unit Cost");
                        RecLSalesLine.MODIFY;
                    UNTIL RecLSalesLine.NEXT = 0;
                END;
            END;
        END;
    end;

    procedure ChooseSalesLineOrderToAffect()
    var
        RecLSalesLine: Record "Sales Line";
        FrmLLinkPurchSales: Page "Link purch. order - sale order";
    begin
        IF (Type = Type::Item) AND
           ("No." <> '') AND
           (Quantity <> 0) AND
           // ("Sales No."='') AND
           // ("Sales Line No."=0) AND
           ("BC6_Discount Direct Unit Cost" <> 0) THEN BEGIN
            RecLSalesLine.RESET;
            RecLSalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
            RecLSalesLine.FILTERGROUP(2);
            RecLSalesLine.SETRANGE(RecLSalesLine."Document Type", RecLSalesLine."Document Type"::Order);
            RecLSalesLine.SETRANGE(RecLSalesLine.Type, RecLSalesLine.Type::Item);
            RecLSalesLine.SETRANGE(RecLSalesLine."No.", "No.");
            RecLSalesLine.SETRANGE(RecLSalesLine."Location Code", "Location Code");
            RecLSalesLine.SETRANGE(RecLSalesLine."BC6_Purch. Order No.", '');
            RecLSalesLine.SETRANGE(RecLSalesLine."BC6_Purch. Line No.", 0);
            RecLSalesLine.SETFILTER(RecLSalesLine.Quantity, '<>%1', 0);
            //>> 05.01.2012
            RecGSalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
            // RecLSalesLine.SETRANGE(RecLSalesLine."Quantity Shipped",0) ;
            RecLSalesLine.FILTERGROUP(0);
            IF RecLSalesLine.FIND('-') THEN BEGIN
                FrmLLinkPurchSales.SETTABLEVIEW(RecLSalesLine);
                FrmLLinkPurchSales.LOOKUPMODE := TRUE;
                IF FrmLLinkPurchSales.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    RecLSalesLine.SETRANGE(RecLSalesLine."BC6_Affect purchase order", TRUE);
                    IF RecLSalesLine.FIND('-') THEN BEGIN
                        REPEAT
                            RecLSalesLine.VALIDATE("BC6_Purch. Document Type", RecLSalesLine."BC6_Purch. Document Type"::Order);
                            RecLSalesLine.VALIDATE("BC6_Purch. Order No.", "Document No.");
                            RecLSalesLine.VALIDATE("BC6_Purch. Line No.", "Line No.");
                            RecLSalesLine.VALIDATE("BC6_Purchase cost", "BC6_Discount Direct Unit Cost");
                            RecLSalesLine.VALIDATE("BC6_Order purchase affected", TRUE);
                            RecLSalesLine.MODIFY;

                            RecLSalesLine.MARK(TRUE);
                        UNTIL RecLSalesLine.NEXT = 0;

                        RecLSalesLine.MARKEDONLY(TRUE);
                        RecLSalesLine.MODIFYALL(RecLSalesLine."BC6_Affect purchase order", FALSE);

                        MESSAGE('Affectation terminée.');
                    END;
                END;
            END
            //>>CASC Affect Sale Order
            ELSE
                MESSAGE(TextG001);
            //<<CASC Affect Sale Order
        END
        //>>CASC Affect Sale Order
        ELSE
            MESSAGE(TextG001);
        //<< CASC Affect Sale Order
    end;

    procedure "---DEEE1.00---"()
    begin
    end;

    procedure CalculateDEEE(CodPNewReasonCode: Code[10])
    var
        RecLVendor: Record Vendor;
        RecLReasonCode: Record "Reason Code";
        RecLDEEETariffs: Record "BC6_DEEE Tariffs";
        RecLPurchSetup: Record "Purchases & Payables Setup";
        RecLItem: Record Item;
        IntLGenerate: Integer;
    begin
        //>>DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
        RecLPurchSetup.GET;
        GetPurchHeader;
        RecLVendor.GET(PurchHeader."Buy-from Vendor No.");

        IF CodPNewReasonCode <> ''
           THEN
            PurchHeader."Reason Code" := CodPNewReasonCode;

        IF NOT RecLReasonCode.GET(PurchHeader."Reason Code")
           THEN
            RecLReasonCode."BC6_Disable DEEE" := FALSE;

        IntLGenerate := 0;

        //assign value 2-> posting + Stat
        //assign value 1-> just for Stat
        //assign value 0-> nothing to do

        IF RecLPurchSetup."BC6_DEEE Management" THEN BEGIN
            RecLItem.GET("No.");
            IF RecLItem."BC6_DEEE Category Code" = '' THEN
                IntLGenerate := 0
            ELSE BEGIN
                IF ((PurchHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (RecLVendor."BC6_Posting DEEE") THEN
                    IntLGenerate := 2;
                IF ((PurchHeader."Reason Code" = '') OR (NOT RecLReasonCode."BC6_Disable DEEE")) AND (NOT RecLVendor."BC6_Posting DEEE") THEN
                    //>>TDL94.001
                    IntLGenerate := 0;
                //IntLGenerate:=1;
                //<<TDL94.001
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

        //found the last tariff with the posting date (just one eco partner)
        RecLDEEETariffs.RESET;
        RecLDEEETariffs.SETRANGE("DEEE Code", "BC6_DEEE Category Code");
        RecLDEEETariffs.SETRANGE("Eco Partner", RecLItem."BC6_Eco partner DEEE");
        RecLDEEETariffs.SETFILTER("Date beginning", '<=%1', PurchHeader."Posting Date");
        IF NOT RecLDEEETariffs.FIND('+') THEN BEGIN
            ERROR('Paramétrage incorrect pour les filtres %1', RecLDEEETariffs.GETFILTERS); //textconstant
        END;

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
            //"Eco partner DEEE":='' ;
        END;

        VALIDATE("BC6_DEEE HT Amount", "BC6_DEEE Unit Price" * "Quantity (Base)");
        "BC6_DEEE VAT Amount" := ROUND("BC6_DEEE HT Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
        "BC6_DEEE TTC Amount" := "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
        "BC6_DEEE Amount (LCY) for Stat" := "Quantity (Base)" * "BC6_DEEE Unit Price (LCY)";


        //<<DEEE1.00 : Calculate DEEE amount from Tariff by Eco partner
    end;

    procedure UpdateReturnOrderTypeFromSalesHeader()
    var
        L_PurchaseHeader: Record "Purchase Header";
    begin
        //>>BCSYS
        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            IF L_PurchaseHeader.GET("Document Type", "Document No.") THEN;
            "BC6_Return Order Type" := L_PurchaseHeader."Return Order Type";
        END;
        //<<BCSYS
    end;

    var
        PurchHeader: Record "Purchase Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        "--COR001--": TextConst;
        TextDate: Label '0D';
        textg002: Label 'You will lost link between purchase document No %1 line %2 \ and sale document of type %3, No %4 ,  line %5 \ Are you sure?';
        "-NSC1.01-": Integer;
        RecGSalesLine: Record "Sales Line";
        Tectg003: Label 'Do you want to create a Purchase Price ? ';
        RecGPurchPrice: Record "Purchase Price";
        TextG001: Label 'There is nothing to affect';
        RecGPurchsetup: Record "Purchases & Payables Setup";
        RecGVendor: Record Vendor;
}

