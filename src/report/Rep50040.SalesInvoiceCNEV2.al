report 50040 "BC6_Sales - Invoice CNE V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesInvoiceCNEV2.rdl';

    Caption = 'Sales - Invoice', Comment = 'FRA="Ventes : Facture"';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice', Comment = 'FRA="Facture vente enregistrée"';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(BooGTotalVisible; BooGTotalVisible)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
            {
            }
            column(FooterCompAddr1; FooterCompAddr[1])
            {
            }
            column(FooterCompAddr2; FooterCompAddr[2])
            {
            }
            column(FooterCompAddr3; FooterCompAddr[3])
            {
            }
            column(FooterCompAddr4; FooterCompAddr[4])
            {
            }
            column(FooterCompAddr5; FooterCompAddr[5])
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
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(TexG_User_Name; TexG_User_Name)
                    {
                    }
                    column(TxtGTag; TxtGTag)
                    {
                    }
                    column(Sales_Invoice_Header___Your_Reference_; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(COPYSTR__Sales_Invoice_Header___Shipment_Invoiced__1_80_; COPYSTR("Sales Invoice Header"."BC6_Shipment Invoiced", 1, 80))
                    {
                    }
                    column(COPYSTR__Sales_Invoice_Header___Shipment_Invoiced__81_80_; COPYSTR("Sales Invoice Header"."BC6_Shipment Invoiced", 81, 80))
                    {
                    }
                    column(COPYSTR__Sales_Invoice_Header___Shipment_Invoiced__161_87_; COPYSTR("Sales Invoice Header"."BC6_Shipment Invoiced", 161, 87))
                    {
                    }
                    column(TxtGLblProjet; TxtGLblProjet)
                    {
                    }
                    column(TxtGNoProjet; TxtGNoProjet)
                    {
                    }
                    column(TxtGDesignation; TxtGDesignation)
                    {
                    }
                    column(FORMAT__Sales_Invoice_Header___Posting_Date__0_4_; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(CompanyInfo_City_____le__; CompanyInfo.City + ' le ')
                    {
                    }
                    column(STRSUBSTNO__Page__1__FORMAT_CurrReport_PAGENO__; STRSUBSTNO('Page %1', FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__Caption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__Caption; "Sales Invoice Header".FIELDCAPTION("External Document No."))
                    {
                    }
                    column(InterlocutorCaption; InterlocutorCaptionLbl)
                    {
                    }
                    column(No_Shipment_InvoicedCaption; No_Shipment_InvoicedCaptionLbl)
                    {
                    }
                    column(Your_referenceCaption; Your_referenceCaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_Caption; "Sales Invoice Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Sales_Invoice_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 0;
                        }
                        column(Sales_Invoice_Line_Description; Description)
                        {
                        }
                        column(Sales_Invoice_Line__No__; "No.")
                        {
                        }
                        column(FORMAT_Quantity_0___precision_0_2__standard_format_1____; FORMAT(Quantity, 0, '<precision,0:2><standard format,1>'))
                        {

                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Qty__per_Unit_of_Measure_; "Sales Invoice Line"."Qty. per Unit of Measure")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(FORMAT__Line_Amount__0___precision_2_2__standard_format_1____; FORMAT("Line Amount", 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();

                        }
                        column(FORMAT___Discount_Unit_Price____0___precision_0_2__standard_format_1____; FORMAT("BC6_Discount Unit Price", 0, '<precision,0:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();

                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY; Quantity * DecGNumbeofUnitsDEEE * DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                        }
                        column(Sales_Invoice_Line__DEEE_Category_Code_; "BC6_DEEE Category Code")
                        {
                        }
                        column(DecGNumbeofUnitsDEEE; DecGNumbeofUnitsDEEE)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control1000000111; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 0;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control1000000005; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Sales_Invoice_Line_Amount; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Description_Control65Caption; FIELDCAPTION(Description))
                        {
                        }
                        column("RéférenceCaption"; RéférenceCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(S_UCaption; S_UCaptionLbl)
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
                        column(Sales_Invoice_Line__No___Control1000000148Caption; Sales_Invoice_Line__No___Control1000000148CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__DEEE_Category_Code_Caption; Sales_Invoice_Line__DEEE_Category_Code_CaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control85; ContinuedCaption_Control85Lbl)
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
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(BooGVisibleDesc; BooGVisibleDesc)
                        {
                        }
                        column(BooGVisibleDesc2; BooGVisibleDesc2)
                        {
                        }
                        column(BooGVisibleDesc3; BooGVisibleDesc3)
                        {
                        }
                        column(Type_SalesInvLine; "Sales Invoice Line".Type)
                        {
                        }
                        column(VATAmtText; TVA_AmountCaptionLbl)
                        {
                        }
                        column(AmtIncVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Loi_N_92_1442_du_31_12_1992; "Loi_N_92_1442_du_31_12_1992__Escompte_applicale_paiement_anticipé____Lbl")
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(GAcompte; GAcompte)
                        {
                        }
                        column(GtextAcompte; GtextAcompte)
                        {
                        }
                        column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
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
                            IF IncludeShptNo THEN BEGIN
                                ShipmentInvoiced.RESET();
                                ShipmentInvoiced.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SETRANGE("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            END;
                            IntGCpt := IntGCpt + 1;

                            IF IntGCpt = IntGNbLigFac THEN
                                BooGAfficheTrait := TRUE
                            ELSE
                                BooGAfficheTrait := FALSE;

                            IF (("BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND ("BC6_Eco partner DEEE" <> '')) THEN BEGIN
                                IF RecGItem.GET("No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;

                                RecGDEEE.RESET();
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Invoice Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;
                            END;

                            TempVATAmountLine."VAT %" := 0;
                            TempVATAmountLine."VAT Base" := 0;
                            TempVATAmountLine."Amount Including VAT" := 0;
                            TempVATAmountLine."Line Amount" := 0;
                            TempVATAmountLine."Inv. Disc. Base Amount" := 0;
                            TempVATAmountLine."Invoice Discount Amount" := 0;
                            TempVATAmountLine."BC6_DEEE HT Amount" := "BC6_DEEE HT Amount";
                            TempVATAmountLine."BC6_DEEE VAT Amount" := "BC6_DEEE VAT Amount";
                            TempVATAmountLine.InsertLine();
                            DecGTTCTotalAmount += "Amount Including VAT" + "BC6_DEEE TTC Amount";
                            TotalAmount += Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalDEEEHTAmount += "BC6_DEEE HT Amount";
                            TotalAmtHTDEEE += Amount + "BC6_DEEE HT Amount";
                            TotalAmountVATDEE += "Amount Including VAT" - Amount + "BC6_DEEE VAT Amount";
                            TotalAmountInclVATDEE += "Amount Including VAT" + "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";

                            TexGTest := ' ';
                            IF STRLEN(Description) > 2 THEN
                                TexGTest := COPYSTR(Description, 3, 1);

                            BooGVisibleDesc := (Type.AsInteger() = 0) AND (1 = STRPOS(Description, 'BL')) AND (TexGTest IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);
                            BooGVisibleDesc2 := (Type.AsInteger() = 0) AND ((1 <> STRPOS(Description, 'BL')) OR NOT (TexGTest IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']));
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGVisibleDesc3 := ("BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND ("BC6_Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGVisibleDesc3 := FALSE;
                            END;
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
                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "BC6_DEEE HT Amount", "BC6_DEEE VAT Amount");
                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;

                            IntGNbLigFac := "Sales Invoice Line".COUNT;
                            IntGCpt := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption1; InvDiscAmtCaption1Lbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(VATAmountLineCOUNT; TempVATAmountLine.COUNT)
                        {
                        }
                        column(VATAmountText2; TempVATAmountLine.VATAmountText())
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(TempVATAmountLine."VAT Base" / "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY := ROUND(TempVATAmountLine."VAT Amount" / "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Invoice Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem("BC6_DEEE Tariffs"; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; "BC6_DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; "BC6_DEEE Tariffs"."HT Unit Tax (LCY)")
                        {
                        }
                        column("Coût_Unitaire_HT__DS_Caption"; Coût_Unitaire_HT__DS_CaptionLbl)
                        {
                        }
                        column(Poids_MaxiCaption; Poids_MaxiCaptionLbl)
                        {
                        }
                        column(Poids_MiniCaption; Poids_MiniCaptionLbl)
                        {
                        }
                        column("CatégorieCaption"; CatégorieCaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs_Eco_Partner; "Eco Partner")
                        {
                        }
                        column(DEEE_Tariffs_Date_beginning; "Date beginning")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            BooGDEEEFind := FALSE;
                            RecGSalesInvLine.RESET();
                            RecGSalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF RecGSalesInvLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecGSalesInvLine."BC6_DEEE Category Code" = "BC6_DEEE Tariffs"."DEEE Code") AND (RecGSalesInvLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecGSalesInvLine.NEXT() = 0));

                            RecGDEEE.RESET();
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Invoice Header"."Posting Date");
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
                        begin
                            BooGDEEEFind := FALSE;
                            RecGSalesInvLine.RESET();
                            RecGSalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF RecGSalesInvLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecGSalesInvLine."BC6_DEEE Category Code" <> '') AND (RecGSalesInvLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecGSalesInvLine.NEXT() = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK();

                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK();
                            CurrReport.BREAK();
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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; FORMAT(TotalAmountVAT, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TVA_AmountCaption; TVA_AmountCaptionLbl)
                        {
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(Total_Number; Number)
                        {
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
                        IF "Sales Invoice Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Sales Invoice Header"."BC6_Affair No.";
                            RecGJob.GET("Sales Invoice Header"."BC6_Affair No.");
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

                    TotalAmount := 0;
                    TotalAmountInclVAT := 0;
                    TotalDEEEHTAmount := 0;
                    TotalAmtHTDEEE := 0;
                    TotalAmountVATDEE := 0;
                    TotalAmountInclVATDEE := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
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
                rrrrrrrrrrrr := FORMAT("Sales Invoice Header"."BC6_Shipment Invoiced");
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                FormatReportFooterAddress.FormatAddrFooter(FooterCompAddr, CompanyInfo);

                GtextAcompte := '';
                GAcompte := 0;

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");

                GCde.SETRANGE("No.", "Order No.");
                IF GCde.FIND('-') THEN BEGIN
                    GtextAcompte := 'Acompte :';
                    GAcompte := GCde."BC6_Advance Payment";
                END ELSE BEGIN
                    GCdeArch.SETRANGE("No.", "Order No.");
                    IF GCdeArch.FIND('+') THEN BEGIN
                        GtextAcompte := 'Acompte :';
                        GAcompte := GCdeArch."BC6_Advance Payment";
                    END;
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
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                Cust.GET("Bill-to Customer No.");

                RecG_User.RESET();
                RecG_User.SETRANGE("User Name", "User ID");
                IF RecG_User.FINDFIRST() THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
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

                RecGBillCustomer.RESET();
                RecGBillCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                BooGTotalVisible := "Prices Including VAT";
            end;

            trigger OnPreDataItem()
            begin
                BooGDEEEFind := FALSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
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
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();
        LogInteractionEnable := TRUE;

        CompanyInfo.CALCFIELDS(Picture, "BC6_Alt Picture");

    end;


    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();

        LogInteractionEnable := LogInteraction;
    end;

    var
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
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
        GCde: Record "Sales Header";
        GCdeArch: Record "Sales Header Archive";
        RecGSalesInvLine: Record "Sales Invoice Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        ShipmentInvoiced: Record "Shipment Invoiced";
        ShipmentMethod: Record "Shipment Method";
        RecG_User: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatReportFooterAddress: Codeunit "BC6_Format Report Footer Add";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        SegManagement: Codeunit SegManagement;
        BooGAfficheTrait: Boolean;
        BooGDEEEFind: Boolean;
        BooGTotalVisible: Boolean;
        BooGVisibleDesc: Boolean;
        BooGVisibleDesc2: Boolean;
        BooGVisibleDesc3: Boolean;
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
        GAcompte: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        "--FEP-ADVE-200706_18_A--": Integer;
        "-- TDL 100--": Integer;
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
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="MT Net HT"';
        AmountEco_ConributionCaption_Control1000000214Lbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Base__CaptionLbl: Label 'Base :';
        "CatégorieCaption_Control1000000127Lbl": Label 'Catégorie';
        "CatégorieCaptionLbl": Label 'Catégorie';
        ContinuedCaption_Control85Lbl: Label 'Continued', Comment = 'FRA="Report"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        "Coût_Unitaire_HT__DS_Caption_Control1000000121Lbl": Label 'Coût Unitaire HT (DS)';
        "Coût_Unitaire_HT__DS_CaptionLbl": Label 'Coût Unitaire HT (DS)';
        DEEE_Contribution___Caption_Control1000000117Lbl: Label 'DEEE Contribution : ';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000216Lbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        InterlocutorCaptionLbl: Label 'Interlocutor', Comment = 'FRA="Interlocuteur"';
        Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', Comment = 'FRA="Montant remise facture"';
        InvDiscAmtCaption1Lbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="Facture N°"';
        Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        "Loi_N_92_1442_du_31_12_1992__Escompte_applicale_paiement_anticipé____Lbl": Label 'Loi N°92-1442 du 31/12/1992. Aucun escompte ne sera accordé pour paiement anticipé. Retard de paiement : pénalités de 1 % par mois. Indemnité forfaitaire pour frais de recouvrement en cas de paiement à une date ultérieure à celle figurant  sur la facture : 40€. Si les frais de recouvrement sont supérieurs à ce montant forfaitaire, une indemnisation complémentaire sera due, sur présentation des justificatifs. L''acheteur déclare avoir pris connaissance des conditions de ventes stipulées au verso du présent feuillet, et notamment de la clause de réserve de propriété et les accepter.';
        No_Shipment_InvoicedCaptionLbl: Label ' No Shipment Invoiced', Comment = 'FRA=" N° BL facturé"';
        PaymentTerms_Description_Control1000000210CaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        Poids_MaxiCaption_Control1000000123Lbl: Label 'Poids Maxi';
        Poids_MaxiCaptionLbl: Label 'Poids Maxi';
        Poids_MiniCaption_Control1000000125Lbl: Label 'Poids Mini';
        Poids_MiniCaptionLbl: Label 'Poids Mini';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité "';
        "RéférenceCaptionLbl": Label 'Référence';
        S_UCaptionLbl: Label 'S U', Comment = 'FRA="U V"';
        Sales_Invoice_Line__DEEE_Category_Code_CaptionLbl: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        Sales_Invoice_Line__No___Control1000000148CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Invoice %1', Comment = 'FRA="Ventes : Facture %1"';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise locale"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        Text10800: Label 'ShipmentNo', Comment = 'FRA="NoExpédition"';
        TotalCaptionLbl: Label 'Total';
        TVA_AmountCaptionLbl: Label 'TVA Amount', Comment = 'FRA="Montant TVA "';
        VALVATBaseLCY_Control175CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCYCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base__Control112CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA "';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATIdentCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        w__Tax_Net__U___P___CaptionLbl: Label 'w. Tax Net  U . P.  ', Comment = 'FRA="P. U. Net HT"';
        Your_referenceCaptionLbl: Label 'Your reference', Comment = 'FRA="Votre référence"';
        TexGTest: Text[1];
        NoShipmentDatas: array[3] of Text[20];
        CopyText: Text[30];
        GtextAcompte: Text[30];
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
        rrrrrrrrrrrr: Text[250];
        FooterCompAddr: array[5] of Text[400];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;


    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;
}

