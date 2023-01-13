report 50013 "BC6_Sales - Credit Memo CNE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/SalesCreditMemoCNE.rdl';

    Caption = 'Sales - Credit Memo', Comment = 'FRA="Ventes : Avoir"';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice', Comment = 'FRA="Facture vente enregistrée"';
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(VATAmtLineVATCptn; VATAmtLineVATCptnLbl)
            {
            }
            column(VATAmtLineVATBaseCptn; VATAmtLineVATBaseCptnLbl)
            {
            }
            column(VATAmtLineVATAmtCptn; VATAmtLineVATAmtCptnLbl)
            {
            }
            column(VATAmtLineVATIdentifierCptn; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalCptn; TotalCptnLbl)
            {
            }
            column(SalesCrMemoLineDiscCaption; SalesCrMemoLineDiscCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(FORMAT__Sales_Cr_Memo_Header___Posting_Date__0_4_; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 4))
                    {
                    }
                    column(CompanyInfo_City_____le__; CompanyInfo.City + ' le ')
                    {
                    }
                    column(STRSUBSTNO__Page__1__FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text006, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(TexG_User_Name; TexG_User_Name)
                    {
                    }
                    column(TxtGTag; TxtGTag)
                    {
                    }
                    column(TxtGDesignation; TxtGDesignation)
                    {
                    }
                    column(TxtGNoProjet; TxtGNoProjet)
                    {
                    }
                    column(TxtGLblProjet; TxtGLblProjet)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Due_Date_; "Sales Cr.Memo Header"."Due Date")
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__Caption; "Sales Cr.Memo Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Cr_Memo_No_Caption; Cr_Memo_No_CaptionLbl)
                    {
                    }
                    column(InterlocutorCaption; InterlocutorCaptionLbl)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Due_Date_Caption; "Sales Cr.Memo Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(VATBaseDiscPrc_SalesCrMemoLine; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Sales_Cr_Memo_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 0;
                        }
                        column(Sales_Cr_Memo_Line_Description; Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__No__; "No.")
                        {
                        }
                        column(FORMAT_Quantity_0___precision_0_2__standard_format_1____; FORMAT(Quantity, 0, '<precision,0:2><standard format,1>'))
                        {

                        }
                        column(Sales_Cr_Memo_Line__Qty__per_Unit_of_Measure_; "Qty. per Unit of Measure")
                        {
                        }
                        column(FORMAT__Line_Amount__0___precision_2_2__standard_format_1____; FORMAT("Line Amount", 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                        }
                        column(FORMAT___Discount_unit_price____0___precision_0_5__standard_format_1____; FORMAT("BC6_Discount unit price", 0, '<precision,0:5><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                        }
                        column(Sales_Cr_Memo_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGNumbeofUnitsDEEE; DecGNumbeofUnitsDEEE)
                        {
                        }
                        column(Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY; Quantity * DecGNumbeofUnitsDEEE * DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Cr_Memo_Line__DEEE_Category_Code_; "BC6_DEEE Category Code")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control1000000111; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 0;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control1000000005; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Amount; Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column("RéférenceCaption"; RéférenceCaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description_Control65Caption; FIELDCAPTION(Description))
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(w__Tax_Net__U___P___Caption; w__Tax_Net__U___P___CaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(DEEE_Contribution___Caption; DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line__No___Control1000000128Caption; Sales_Cr_Memo_Line__No___Control1000000128CaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line__DEEE_Category_Code_Caption; Sales_Cr_Memo_Line__DEEE_Category_Code_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__Caption; Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                        }
                        column(BooGVisible; BooGVisible)
                        {
                        }
                        column(BooGTotalVisible; BooGTotalVisible)
                        {
                        }
                        column(BooGVATVisible; BooGVATVisible)
                        {
                        }
                        column(BooGTotalVisible2; BooGTotalVisible2)
                        {
                        }
                        column(Loi_N_92_1442_du_31_12_1992_Caption; Loi)
                        {
                        }
                        column("L_acheteur_déclare_avoir_pris_connaissance_des_conditions_de_ventes_Caption"; Acheteur)
                        {
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
                        {
                        }
                        column(Base__Caption; Base__CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine.InsertLine();

                            //FG
                            IntGCpt := IntGCpt + 1;

                            IF IntGCpt = IntGNbLigFac THEN
                                BooGAfficheTrait := TRUE
                            ELSE
                                BooGAfficheTrait := FALSE;

                            //<<FE005:DARI 20/02/2007
                            IF (("Sales Cr.Memo Line"."BC6_DEEE Category Code" <> '') AND ("Sales Cr.Memo Line".Quantity <> 0)
                            AND ("Sales Cr.Memo Line"."BC6_Eco partner DEEE" <> '')) THEN BEGIN
                                IF RecGItem.GET("Sales Cr.Memo Line"."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;
                                RecGDEEE.RESET();
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Cr.Memo Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;
                            END;

                            //FG
                            TempVATAmountLine."BC6_DEEE HT Amount" := "Sales Cr.Memo Line"."BC6_DEEE HT Amount";
                            TempVATAmountLine."BC6_DEEE VAT Amount" := "Sales Cr.Memo Line"."BC6_DEEE VAT Amount";
                            TempVATAmountLine.InsertLine();

                            //MICO DEEE1.00
                            DecGVATTotalAmount += TempVATAmountLine."VAT Amount" + TempVATAmountLine."BC6_DEEE VAT Amount";
                            DecGTTCTotalAmount += "Sales Cr.Memo Line"."Amount Including VAT" + "Sales Cr.Memo Line"."BC6_DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT TempRecGCalcul.GET('', "Sales Cr.Memo Line"."BC6_DEEE Category Code", 0D)
                               THEN BEGIN
                                //création d'une ligne
                                TempRecGCalcul.INIT();
                                TempRecGCalcul."Eco Partner" := '';
                                TempRecGCalcul."DEEE Code" := "Sales Cr.Memo Line"."BC6_DEEE Category Code";
                                TempRecGCalcul."Date beginning" := 0D;
                                TempRecGCalcul."HT Unit Tax (LCY)" := "Sales Cr.Memo Line"."BC6_DEEE HT Amount";
                                TempRecGCalcul.INSERT();
                            END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;
                            NNC_TotalAmountInclVat += "Amount Including VAT";

                            TotalDEEEHTAmount += "BC6_DEEE HT Amount";
                            TotalAmtHTDEEE += Amount + "BC6_DEEE HT Amount";
                            TotalAmountVATDEE += "Amount Including VAT" - Amount + "BC6_DEEE VAT Amount";
                            TotalAmountInclVATDEE += "Amount Including VAT" + "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";
                            TotalAmount += Amount;


                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGVisible := ("BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND ("BC6_Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGVisible := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07

                            BooGTotalVisible := "Sales Cr.Memo Header"."Prices Including VAT" AND ("Amount Including VAT" <> Amount);
                            BooGVATVisible := (TempVATAmountLine.COUNT > 1) AND ("Amount Including VAT" <> Amount);
                            BooGTotalVisible2 := (TempVATAmountLine.COUNT > 1) OR ((TempVATAmountLine.COUNT = 1) AND ("Amount Including VAT" = Amount));

                            //<<MIGRATION NAV 2013
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempVATAmountLine.DELETEALL();
                            TempSalesShipmentBuffer.RESET();
                            TempSalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            //>>FE005:DARI 22/02/2007
                            //CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount");
                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 22/02/2007



                            //FG
                            IntGNbLigFac := "Sales Cr.Memo Line".COUNT;
                            IntGCpt := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF TempVATAmountLine.GetTotalVATAmount() = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem("BC6_DEEE Tariffs"; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; "BC6_DEEE Tariffs"."HT Unit Tax (LCY)")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000125; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; "BC6_DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption; DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption; RecGItemCtg__Weight_Min_CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption; DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl)
                        {
                        }
                        column(Control1000000104Caption; Control1000000104CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs_Eco_Partner; "Eco Partner")
                        {
                        }
                        column(DEEE_Tariffs_Date_beginning; "Date beginning")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            RecLCrMemoLine: Record "Sales Cr.Memo Line";
                        begin
                            //>>FE005 DARI 21/02/2007
                            BooGDEEEFind := FALSE;
                            RecLCrMemoLine.RESET();
                            RecLCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                            IF RecLCrMemoLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLCrMemoLine."BC6_DEEE Category Code" = "BC6_DEEE Tariffs"."DEEE Code") AND (RecLCrMemoLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLCrMemoLine.NEXT() = 0));

                            RecGDEEE.RESET();
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Cr.Memo Header"."Posting Date");
                            IF RecGDEEE.FIND('+') THEN BEGIN
                                IF RecGDEEE."Date beginning" <> "BC6_DEEE Tariffs"."Date beginning" THEN
                                    BooGDEEEFind := FALSE;
                            END;

                            RecGItemCtg.RESET();
                            IF NOT RecGItemCtg.GET("BC6_DEEE Tariffs"."DEEE Code", "BC6_DEEE Tariffs"."Eco Partner") THEN
                                RecGItemCtg.INIT();

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.SKIP();
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLCrMemoLine: Record "Sales Cr.Memo Line";
                        begin
                            //>>FE005 DARI
                            BooGDEEEFind := FALSE;
                            RecLCrMemoLine.RESET();

                            RecLCrMemoLine.SETFILTER(RecLCrMemoLine."Document No.", "Sales Cr.Memo Header"."No.");
                            //RecLCrMemoLine.SETFILTER(RecLCrMemoLine."Document Type",'%1',RecLCrMemoLine."Document Type"::Order);
                            IF RecLCrMemoLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLCrMemoLine."BC6_DEEE Category Code" <> '') AND (RecLCrMemoLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLCrMemoLine.NEXT() = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK();
                            //<<DARI

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK();
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercent; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(TempVATAmountLine."VAT Base" / "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY := ROUND(TempVATAmountLine."VAT Amount" / "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Cr.Memo Header"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text008 + Text009
                            ELSE
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(TotalAmount; FORMAT(TotalAmount, 0, '<precision,2:2><standard format,1>'))
                        {
                        }
                        column(TotalDEEEHTAmount; FORMAT(TotalDEEEHTAmount, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        }
                        column(TotalAmtHTDEEE; FORMAT(TotalAmtHTDEEE, 0, '<precision,2:2><standard format,1>'))
                        {
                        }
                        column(TotalAmountVATDEE; FORMAT(TotalAmountVATDEE, 0, '<precision,2:2><standard format,1>'))
                        {
                        }
                        column(TotalAmountInclVATDEE; FORMAT(TotalAmountInclVATDEE, 0, '<precision,2:2><standard format,1>'))
                        {
                        }
                        column(TotalAmtInclVAT; FORMAT(TotalAmountInclVAT, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; FORMAT(TotalAmountVAT, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record Job;
                    begin
                        IF "Sales Cr.Memo Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Sales Cr.Memo Header"."BC6_Affair No.";
                            RecGJob.GET("Sales Cr.Memo Header"."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    //>>MIGRATION NAV 2013
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalLineAmount := 0;

                    TotalAmount := 0;
                    TotalAmountInclVAT := 0;
                    TotalDEEEHTAmount := 0;
                    TotalAmtHTDEEE := 0;
                    TotalAmountVATDEE := 0;
                    TotalAmountInclVATDEE := 0;

                    //<<MIGRATION NAV 2013
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCreMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text007, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text007, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                Cust.GET("Bill-to Customer No.");

                //>>MIGRATION NAV 2013
                RecG_User.RESET();
                RecG_User.SETRANGE("User Name", "User ID");
                IF RecG_User.FINDFIRST() THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';
                //<<MIGRATION NAV 2013

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;

                //>>COMPTA_DEEE FG 01/03/07
                RecGBillCustomer.RESET();
                RecGBillCustomer.GET("Sales Cr.Memo Header"."Bill-to Customer No.");
                //<<COMPTA_DEEE FG 01/03/07
            end;
        }
    }

    requestpage
    {
        Caption = 'Inlude Shipment No.', Comment = 'FRA="Inclure expéditions"';

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                    field(IncludeShptNo; IncludeShptNo)
                    {
                        Caption = 'Inlude Shipment No.', Comment = 'FRA="Inclure expéditions"';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();
    end;

    var
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        TempRecGCalcul: Record "BC6_DEEE Tariffs" temporary;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        RecGBillCustomer: Record Customer;
        GLSetup: Record "General Ledger Setup";
        RecGItem: Record Item;
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        RecGCrMemoLine: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        RecGSalesInvLine: Record "Sales Invoice Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        ShipmentInvoiced: Record "Shipment Invoiced";
        ShipmentMethod: Record "Shipment Method";
        RecG_User: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SalesCreMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        SegManagement: Codeunit SegManagement;
        BooGAfficheTrait: Boolean;
        BooGDEEEFind: Boolean;
        BooGTotalVisible: Boolean;
        BooGTotalVisible2: Boolean;
        BooGVATVisible: Boolean;
        BooGVisible: Boolean;
        Continue: Boolean;
        IncludeShptNo: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        PostedShipmentDate: Date;
        CalculatedExchRate: Decimal;
        DecGHTUnitTaxLCY: Decimal;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGTTCTotalAmount: Decimal;
        DecGVATTotalAmount: Decimal;
        NNC_TotalAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        "--FEP-ADVE-200706_18_A.--": Integer;
        "--FG--": Integer;
        "-DEEE1.00-": Integer;
        "- MIGNAV2013 -": Integer;
        FirstValueEntryNo: Integer;
        i: Integer;
        IntGCpt: Integer;
        IntGNbLigFac: Integer;
        NextEntryNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NoShipmentNumLoop: Integer;
        OutputNo: Integer;
        "Acheteur": Label 'L''acheteur déclare avoir pris connaissance des conditions de ventes stipulées au verso du présent feuillet et notamment de la clause de réserve de propriété et les accepter.';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="MT Net HT"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Base__CaptionLbl: Label 'Base :', Comment = 'FRA="Base :"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        Control1000000104CaptionLbl: Label 'Label1000000104', Comment = 'FRA="Label1000000104"';
        Cr_Memo_No_CaptionLbl: Label 'Cr.Memo No.', Comment = 'FRA="Avoir N°"';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category', Comment = 'FRA="Catégorie"';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        InterlocutorCaptionLbl: Label 'Interlocutor', Comment = 'FRA="Interlocuteur"';
        Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', Comment = 'FRA="Montant remise facture"';
        Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        "Loi": Label 'Loi N°92-1442 du 31/12/1992. Escompte applicale en cas de paiement anticipé = 0.3 % par mois. Retard de paiement : pénalités de 1 % par mois.';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité "';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Max', Comment = 'FRA="Poids Max"';
        "RéférenceCaptionLbl": Label 'Référence', Comment = 'FRA="Référence"';
        Sales_Cr_Memo_Line__DEEE_Category_Code_CaptionLbl: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        Sales_Cr_Memo_Line__No___Control1000000128CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        SalesCrMemoLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label '(Applies to %1 %2)', Comment = 'FRA="(Doc. lettrage %1 %2)"';
        Text004: Label 'COPY', Comment = 'FRA="COPIE"';
        Text005: Label 'Sales - Credit Memo %1', Comment = 'FRA="Ventes : Avoir %1"';
        Text006: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text007: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text008: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text009: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text010: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text011: Label 'Sales - Prepmt. Credit Memo %1', Comment = 'FRA="Ventes - Avoir acompte %1"';
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        Text10800: Label 'ShipmentNo', Comment = 'FRA="NoExpédition"';
        TotalCptnLbl: Label 'Total', Comment = 'FRA="Total"';
        UnitCaptionLbl: Label 'Unit', Comment = 'FRA="UV"';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail TVA"';
        VATAmountLine__Inv__Disc__Base_Amount__Control1000000021CaptionLbl: Label 'Inv. Disc. Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmountLine__Invoice_Discount_Amount__Control1000000022CaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        VATAmountLine__Line_Amount__Control140CaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmtLineInvDiscBaseAmtCptnLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmtLineInvoiceDiscAmtCptnLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        VATAmtLineLineAmtCptnLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmtLineVATAmtCptnLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtLineVATBaseCptnLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtLineVATCptnLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmtLineVATIdentifierCptnLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        w__Tax_Net__U___P___CaptionLbl: Label 'w. Tax Net  U . P.  ', Comment = 'FRA="P. U. Net HT"';
        NoShipmentDatas: array[3] of Text[20];
        CopyText: Text[30];
        NoShipmentText: Text[30];
        OrderNoText: Text[30];
        ReferenceText: Text[30];
        SalesPersonText: Text[30];
        TexG_User_Name: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        TxtGDesignation: Text[50];
        TxtGTag: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        VALSpecLCYHeader: Text[80];
        DimText: Text[120];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;


    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;


    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;
}

