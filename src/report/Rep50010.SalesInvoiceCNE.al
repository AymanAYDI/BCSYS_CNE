report 50010 "BC6_Sales - Invoice CNE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvoiceCNE.rdlc';

    Caption = 'Sales - Invoice', Comment = 'FRA="Ventes : Facture"';
    Permissions = TableData "Sales Shipment Buffer" = rimd;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice', Comment = 'FRA="Facture vente enregistrée"';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(BooGTotalVisible; BooGTotalVisible)
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
                    column(FORMAT__Sales_Invoice_Header___Posting_Date__0_4_; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(CompanyInfo_City_____le__; CompanyInfo.City + ' le ')
                    {
                    }
                    column(STRSUBSTNO__Page__1__FORMAT_CurrReport_PAGENO__; STRSUBSTNO('Page %1', FORMAT(CurrReport.PAGENO)))
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
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;

                        }
                        column(FORMAT___Discount_Unit_Price____0___precision_0_2__standard_format_1____; FORMAT("BC6_Discount Unit Price", 0, '<precision,0:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;

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
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 0;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Loi_N_92_1442_du_31_12_1992; Loi)
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

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;
                            // FR0001.begin
                            IF IncludeShptNo THEN BEGIN
                                ShipmentInvoiced.RESET;
                                ShipmentInvoiced.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SETRANGE("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            END;
                            // FR0001.end

                            //FG
                            IntGCpt := IntGCpt + 1;

                            IF IntGCpt = IntGNbLigFac THEN
                                BooGAfficheTrait := TRUE
                            ELSE
                                BooGAfficheTrait := FALSE;

                            //<<FE005:DARI 22/02/2007
                            IF (("BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND ("BC6_Eco partner DEEE" <> '')) THEN BEGIN
                                IF RecGItem.GET("No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;

                                RecGDEEE.RESET;
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Invoice Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;
                            END;

                            //FG
                            //pamo
                            VATAmountLine."VAT %" := 0;
                            VATAmountLine."VAT Base" := 0;
                            VATAmountLine."Amount Including VAT" := 0;
                            VATAmountLine."Line Amount" := 0;
                            VATAmountLine."Inv. Disc. Base Amount" := 0;
                            VATAmountLine."Invoice Discount Amount" := 0;
                            //pamo
                            VATAmountLine."BC6_DEEE HT Amount" := "BC6_DEEE HT Amount";
                            VATAmountLine."BC6_DEEE VAT Amount" := "BC6_DEEE VAT Amount";
                            VATAmountLine.InsertLine;

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";
                            DecGTTCTotalAmount += "Amount Including VAT" + "BC6_DEEE TTC Amount";
                            //>>FE005:DARI 22/02/2007

                            //>>MIGRATION NAV 2013
                            TotalAmount += Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalDEEEHTAmount += "BC6_DEEE HT Amount";
                            TotalAmtHTDEEE += Amount + "BC6_DEEE HT Amount";
                            TotalAmountVATDEE += "Amount Including VAT" - Amount + "BC6_DEEE VAT Amount";
                            TotalAmountInclVATDEE += "Amount Including VAT" + "BC6_DEEE HT Amount" + "BC6_DEEE VAT Amount";

                            //>>TDL DARI 23/04/07
                            TexGTest := ' ';
                            IF STRLEN(Description) > 2 THEN
                                TexGTest := COPYSTR(Description, 3, 1);

                            BooGVisibleDesc := (Type = 0) AND (1 = STRPOS(Description, 'BL')) AND (TexGTest IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);
                            //<<TDL DARI 23/04/07

                            //>>TDL DARI 23/04/07
                            BooGVisibleDesc2 := (Type = 0) AND ((1 <> STRPOS(Description, 'BL')) OR NOT (TexGTest IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']));
                            //>>TDL DARI 23/04/07


                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGVisibleDesc3 := ("BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND ("BC6_Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGVisibleDesc3 := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07

                            //<<MIGRATION NAV 2013
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");

                            //>>FE005:DARI 22/02/2007
                            //CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount");
                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "BC6_DEEE HT Amount", "BC6_DEEE VAT Amount");
                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 20/02/2007


                            //FG
                            IntGNbLigFac := "Sales Invoice Line".COUNT;
                            IntGCpt := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
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
                        column(VATAmountLineCOUNT; VATAmountLine.COUNT)
                        {
                        }
                        column(VATAmountText2; VATAmountLine.VATAmountText)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
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
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Invoice Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
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
                            RecGSalesInvLine.RESET;
                            RecGSalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF RecGSalesInvLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecGSalesInvLine."BC6_DEEE Category Code" = "BC6_DEEE Tariffs"."DEEE Code") AND (RecGSalesInvLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecGSalesInvLine.NEXT = 0));

                            RecGDEEE.RESET;
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "BC6_DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Invoice Header"."Posting Date");
                            IF RecGDEEE.FIND('+') THEN BEGIN
                                IF RecGDEEE."Date beginning" <> "BC6_DEEE Tariffs"."Date beginning" THEN
                                    BooGDEEEFind := FALSE;
                            END;

                            RecGItemCtg.RESET;
                            IF NOT RecGItemCtg.GET("BC6_DEEE Tariffs"."DEEE Code", "BC6_DEEE Tariffs"."Eco Partner") THEN
                                RecGItemCtg.INIT;

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.SKIP;
                        end;

                        trigger OnPreDataItem()
                        begin
                            BooGDEEEFind := FALSE;
                            RecGSalesInvLine.RESET;
                            RecGSalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            IF RecGSalesInvLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecGSalesInvLine."BC6_DEEE Category Code" <> '') AND (RecGSalesInvLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecGSalesInvLine.NEXT = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK;

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK;
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK;
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
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
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
                                CurrReport.BREAK;
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

                    //>>MIGRATION NAV 2013
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
                //message ( 'longueur : ' + format(strlen ("Sales Invoice Header"."Shipment Invoiced")));

                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;


                //>> 10/10/2012 SU-DADE cf Appal TI125440
                GtextAcompte := '';
                GAcompte := 0;
                //<< 10/10/2012 SU-DADE cf Appal TI125440

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");

                //>> 10/10/2012 SU-DADE cf Appal TI125440
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
                //<< 10/10/2012 SU-DADE cf Appal TI125440

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
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

                //>>MIGRATION NAV 2013
                RecG_User.RESET;
                RecG_User.SETRANGE("User Name", "User ID");
                IF RecG_User.FINDFIRST THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';
                //<<MIGRATION NAV 2013

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
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

                //>>COMPTA_DEEE FG 01/03/07
                RecGBillCustomer.RESET;
                RecGBillCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                //<<COMPTA_DEEE FG 01/03/07

                //>>MIGRATION NAV 2013
                BooGTotalVisible := "Prices Including VAT";
                //<<MIGRATION NAV 2013
            end;

            trigger OnPreDataItem()
            begin
                //DEEE
                BooGDEEEFind := FALSE;
                //FIN DEEE
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
                    Caption = 'Options', Comment = 'FRA=""';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA=""';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA=""';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA=""';
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
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        LogInteractionEnable := TRUE;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        LogInteractionEnable := LogInteraction;
    end;

    var
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Invoice %1', Comment = 'FRA="Ventes : Facture %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise locale"';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        CalculatedExchRate: Decimal;
        Text10800: Label 'ShipmentNo', Comment = 'FRA="NoExpédition"';
        ShipmentInvoiced: Record "Shipment Invoiced";
        NoShipmentNumLoop: Integer;
        NoShipmentDatas: array[3] of Text[20];
        NoShipmentText: Text[30];
        IncludeShptNo: Boolean;
        IntGNbLigFac: Integer;
        IntGCpt: Integer;
        BooGAfficheTrait: Boolean;
        TexG_User_Name: Text[30];
        "-DEEE1.00-": Integer;
        RecGSalesInvLine: Record "Sales Invoice Line";
        BooGDEEEFind: Boolean;
        RecGDEEE: Record "BC6_DEEE Tariffs";
        RecGItemCtg: Record "BC6_Categories of item";
        TxtGTag: Text[50];
        RecGParamVente: Record "Sales & Receivables Setup";
        RecGItem: Record Item;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGVATTotalAmount: Decimal;
        DecGTTCTotalAmount: Decimal;
        DecGHTUnitTaxLCY: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record Customer;
        rrrrrrrrrrrr: Text[250];
        "-- TDL 100--": Integer;
        TexGTest: Text[1];
        "--FEP-ADVE-200706_18_A--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        GtextAcompte: Text[30];
        GAcompte: Decimal;
        GCde: Record "Sales Header";
        GCdeArch: Record "Sales Header Archive";
        Invoice_No_CaptionLbl: Label 'Invoice No.', Comment = 'FRA="Facture N°"';
        InterlocutorCaptionLbl: Label 'Interlocutor', Comment = 'FRA="Interlocuteur"';
        No_Shipment_InvoicedCaptionLbl: Label ' No Shipment Invoiced', Comment = 'FRA=" N° BL facturé"';
        Your_referenceCaptionLbl: Label 'Your reference', Comment = 'FRA="Votre référence"';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        "RéférenceCaptionLbl": Label 'Référence', Comment = 'FRA="Référence"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité "';
        S_UCaptionLbl: Label 'S U', Comment = 'FRA="U V"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="MT Net HT"';
        w__Tax_Net__U___P___CaptionLbl: Label 'w. Tax Net  U . P.  ', Comment = 'FRA="P. U. Net HT"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        Sales_Invoice_Line__No___Control1000000148CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        Sales_Invoice_Line__DEEE_Category_Code_CaptionLbl: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        ContinuedCaption_Control85Lbl: Label 'Continued', Comment = 'FRA="Report"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', Comment = 'FRA="Montant remise facture"';
        Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base__Control112CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCYCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCY_Control175CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        "Coût_Unitaire_HT__DS_CaptionLbl": Label 'Coût Unitaire HT (DS)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        Poids_MaxiCaptionLbl: Label 'Poids Maxi', Comment = 'FRA="Poids Maxi"';
        Poids_MiniCaptionLbl: Label 'Poids Mini', Comment = 'FRA="Poids Mini"';
        "CatégorieCaptionLbl": Label 'Catégorie', Comment = 'FRA="Catégorie"';
        DEEE_Contribution___Caption_Control1000000117Lbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        "Coût_Unitaire_HT__DS_Caption_Control1000000121Lbl": Label 'Coût Unitaire HT (DS)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        Poids_MaxiCaption_Control1000000123Lbl: Label 'Poids Maxi', Comment = 'FRA="Poids Maxi"';
        Poids_MiniCaption_Control1000000125Lbl: Label 'Poids Mini', Comment = 'FRA="Poids Mini"';
        "CatégorieCaption_Control1000000127Lbl": Label 'Catégorie', Comment = 'FRA="Catégorie"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        TVA_AmountCaptionLbl: Label 'TVA Amount', Comment = 'FRA="Montant TVA "';
        Base__CaptionLbl: Label 'Base :', Comment = 'FRA="Base :"';
        PaymentTerms_Description_Control1000000210CaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        Loi: Label 'Loi N°92-1442 du 31/12/1992. Aucun escompte ne sera accordé pour paiement anticipé. Retard de paiement : pénalités de 1 % par mois. Indemnité forfaitaire pour frais de recouvrement en cas de paiement à une date ultérieure à celle figurant  sur la facture : 40€. Si les frais de recouvrement sont supérieurs à ce montant forfaitaire, une indemnisation complémentaire sera due, sur présentation des justificatifs. L''acheteur déclare avoir pris connaissance des conditions de ventes stipulées au verso du présent feuillet, et notamment de la clause de réserve de propriété et les accepter.';
        AmountEco_ConributionCaption_Control1000000214Lbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000216Lbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        "- MIGNAV2013 -": Integer;
        BooGVisibleDesc: Boolean;
        BooGVisibleDesc2: Boolean;
        RecG_User: Record User;
        VATPercentCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATIdentCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        InvDiscAmtCaption1Lbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmountInclVATDEE: Decimal;
        BooGTotalVisible: Boolean;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        BooGVisibleDesc3: Boolean;


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15,02,2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;
}
