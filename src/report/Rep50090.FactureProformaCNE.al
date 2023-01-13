report 50090 "BC6_Facture Proforma CNE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/FactureProformaCNE.rdl';

    Caption = 'Order Confirmation', comment = 'FRA="Facture Proforma (idem conf. de cde)"';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
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
            column(LineAmtCaption; LineAmtCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(TmpNamereport_; TmpNamereport)
            {
            }
            column(CstGTxt001_; CstGTxt001)
            {
            }
            column(CstGTxt002_; CstGTxt002)
            {
            }
            column(CstGTxt003_; CstGTxt003)
            {
            }
            column(CstGTxt004_; CstGTxt004)
            {
            }
            column(CstGTxt005_; CstGTxt005)
            {
            }
            column(CstGTxt006_; CstGTxt006)
            {
            }
            column(CstGTxt007_; CstGTxt007)
            {
            }
            column(CstGTxt008_; CstGTxt008)
            {
            }
            column(CstGTxt009_; CstGTxt009)
            {
            }
            column(CstGTxt010_; CstGTxt010)
            {
            }
            column(CstGTxt011_; CstGTxt011)
            {
            }
            column(CstGTxt012_; CstGTxt012)
            {
            }
            column(CstGTxt013_; CstGTxt013)
            {
            }
            column(CstGTxt014_; CstGTxt014)
            {
            }
            column(CstGTxt015_; CstGTxt015)
            {
            }
            column(CstGTxt016_; CstGTxt016)
            {
            }
            column(CstGTxt017_; CstGTxt017)
            {
            }
            column(CstGTxt018_; CstGTxt018)
            {
            }
            column(CstGTxt019_; CstGTxt019)
            {
            }
            column(CstGTxt020_; CstGTxt020)
            {
            }
            column(CstGTxt021_; CstGTxt021)
            {
            }
            column(CstGTxt022_; CstGTxt022)
            {
            }
            column(CstGTxt023_; CstGTxt023)
            {
            }
            column(CstGTxt024_; CstGTxt024)
            {
            }
            column(CstGTxt025_; CstGTxt025)
            {
            }
            column(CstGTxt026_; CstGTxt026)
            {
            }
            column(Tel_; Tel)
            {
            }
            column(Fax_; Fax)
            {
            }
            column(Document_Date_; "Document Date")
            {
            }
            column(BilltoCustomer_No_; "Bill-to Customer No.")
            {
            }
            column(Your_Reference_; "Your Reference")
            {
            }
            column(PrincipalContact_; PrincipalContact)
            {
            }
            column(PrincContactName_; PrincContactName)
            {
            }
            column(surReleve_; surReleve)
            {
            }
            column(CondDePayment_; CondDePayment)
            {
            }
            column(ModeTransport_; ModeTransport)
            {
            }
            column(SalesPersonText_; SalesPersonText)
            {
            }
            column(Sales_Header_Advance_Payment_; SalesHeader."BC6_Advance Payment")
            {
            }
            column(Currency_; Currency)
            {
            }
            column(Representant_caption; CstG001)
            {
            }
            column(Designation_caption; CstG002)
            {
            }
            column(DateReglement_Caption; CstG003)
            {
            }
            column(ConditionReglement_Caption; CstG004)
            {
            }
            column(DansLeCas_Label; CstG005)
            {
            }
            column(LeVendeurDeReserv_Label; CstG006)
            {
            }
            column(RetardDePaiement_Label; CstG007)
            {
            }
            column(Sales_Header_Due_Date_; "Due Date")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = false;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = false;
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo_AltPicture; CompanyInfo."BC6_Alt Picture")
                    {
                    }
                    column(OrderConfirmCopyCaption; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhNo; CompanyInfo."Phone No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader; SalesHeader."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT(SalesHeader."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; SalesHeader."VAT Registration No.")
                    {
                    }
                    column(ShptDate_SalesHeader; FORMAT(SalesHeader."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(SalesOrderReference_SalesHeader; SalesHeader."Your Reference")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesInclVAT_SalesHeader; SalesHeader."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PmntTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHeader; FORMAT(SalesHeader."Prices Including VAT"))
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankCaption; BankCaptionLbl)
                    {
                    }
                    column(AccountNoCaption; AccountNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; SalesHeader.FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; SalesHeader.FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(Company_Addr; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO(txtlbl12, CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(Company_Tel; STRSUBSTNO(Text066, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                    {
                    }
                    column(CompanyInfo_HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfo_Alt_Name; CompanyInfo."BC6_Alt Name")
                    {
                    }
                    column(Company_Alt_Addr; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO(txtlbl12, CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                    {
                    }
                    column(Company_Alt_Tel; STRSUBSTNO(Text066, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                    {
                    }
                    column(CompanyInfo_Alt_HomePage; CompanyInfo."BC6_Alt Home Page")
                    {
                    }
                    column(footer; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = SalesHeader;
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(txtlbl12, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(SalesLine2; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = SalesHeader;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineAmt; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine; TempSalesLine.Description)
                        {
                        }
                        column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(NNCTotalLCY; NNCTotalLCY)
                        {
                        }
                        column(NNCTotalExclVAT; NNCTotalExclVAT)
                        {
                        }
                        column(NNCVATAmt; NNCVATAmt)
                        {
                        }
                        column(NNCTotalInclVAT; NNCTotalInclVAT)
                        {
                        }
                        column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2; NNCTotalInclVAT2)
                        {
                        }
                        column(NNCVATAmt2; NNCVATAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2; NNCTotalExclVAT2)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; SalesHeader."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(No2_SalesLine; TempSalesLine."No.")
                        {
                        }
                        column(Qty_SalesLine; TempSalesLine.Quantity)
                        {
                        }
                        column(UOM_SalesLine; TempSalesLine."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; TempSalesLine."Unit Price")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(LineDisc_SalesLine; TempSalesLine."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; TempSalesLine."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; TempSalesLine."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; FORMAT(TempSalesLine.Type))
                        {
                        }
                        column(No_SalesLine; TempSalesLine."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine; FORMAT(TempSalesLine."Allow Invoice Disc."))
                        {
                        }
                        column(Qty_per_Unit_of_Measure_; TempSalesLine."Qty. per Unit of Measure")
                        {
                        }
                        column(Qty_per_Unit_of_Measure_Caption; TempSalesLine.FIELDCAPTION("Qty. per Unit of Measure"))
                        {
                        }
                        column(SalesLine_DEEE_Category_Code; TempSalesLine."BC6_DEEE Category Code")
                        {
                        }
                        column(SalesLine_DEEE_Category_Code_Caption; TempSalesLine.FIELDCAPTION("BC6_DEEE Category Code"))
                        {
                        }
                        column(Item_Number_of_Units_DEEE_; item."BC6_Number of Units DEEE")
                        {
                        }
                        column(SalesLine_Quantity_; TempSalesLine.Quantity)
                        {
                        }
                        column(SalesLine_DEEE_Unit_Price_LCY_; TempSalesLine."BC6_DEEE Unit Price (LCY)")
                        {
                        }
                        column(PaysArtTex_; PaysArtTex)
                        {
                        }
                        column(Templibelledouanier_TempNomenclaturedouaniere_; STRSUBSTNO(txtlbl12, templibelledouanier, TempNomenclaturedouaniere))
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                            IncludeCaption = false;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; TempSalesLine."Line Amount" - TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText3; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; TempSalesLine."Line Amount" - TempVATAmountLine."Invoice Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; VATDiscountAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesLineCaption; TempSalesLine.FIELDCAPTION(Description))
                        {
                        }
                        column(No2_SalesLineCaption; TempSalesLine.FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesLineCaption; TempSalesLine.FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption; TempSalesLine.FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; TempSalesLine.FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(SalesLine_Type_; TempSalesLine.Type)
                        {
                        }
                        column(BooGRoundLoopB3; BooGRoundLoopB3)
                        {
                        }
                        column(BooGRoundLoopB4; BooGRoundLoopB4)
                        {
                        }
                        column(BooGRoundLoopB5; BooGRoundLoopB5)
                        {
                        }
                        column(BooGRoundLoopB6; BooGRoundLoopB6)
                        {
                        }
                        column(TempPourcent_; TempPourcent)
                        {
                        }
                        column(Sales_Line_Disc_Unit_Price; TempSalesLine."BC6_Discount unit price")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(txtlbl12, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                CurrReport.BREAK();

                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", SalesLine2."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT();
                            SalesLine2 := TempSalesLine;
                            TempRecGDEEETariffs.RESET();
                            TempRecGDEEETariffs.SETFILTER("Eco Partner", TempSalesLine."BC6_Eco partner DEEE");
                            TempRecGDEEETariffs.SETFILTER("DEEE Code", TempSalesLine."BC6_DEEE Category Code");
                            IF NOT TempRecGDEEETariffs.FIND('-') THEN BEGIN
                                RecGDEEE.RESET();
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", TempSalesLine."BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER("Eco Partner", TempSalesLine."BC6_Eco partner DEEE");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', SalesHeader."Posting Date");
                                IF RecGDEEE.FIND('+') THEN BEGIN
                                    TempRecGDEEETariffs.INIT();
                                    TempRecGDEEETariffs."Eco Partner" := RecGDEEE."Eco Partner";
                                    TempRecGDEEETariffs."DEEE Code" := RecGDEEE."DEEE Code";
                                    TempRecGDEEETariffs."Date beginning" := RecGDEEE."Date beginning";
                                    TempRecGDEEETariffs.INSERT();
                                END;
                            END;

                            IF DisplayAssemblyInformation THEN
                                AsmInfoExistsForLine := TempSalesLine.AsmToOrderExists(AsmHeader);

                            IF NOT SalesHeader."Prices Including VAT" AND
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempSalesLine."Line Amount" := 0;
                            ItemCrossReference.RESET();
                            ItemCrossReference.SETRANGE("Item No.", TempSalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
                            ItemCrossReference.SETRANGE("Cross-Reference Type No.", SalesHeader."Sell-to Customer No.");
                            CrossrefNo := '';
                            IF ItemCrossReference.FIND('-') THEN
                                CrossrefNo := ItemCrossReference."Cross-Reference No.";
                            ItemCrossReference.RESET();
                            ItemCrossReference.SETRANGE("Item No.", TempSalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Discontinue Bar Code", FALSE);
                            TempGencod := '';
                            IF ItemCrossReference.FIND('-') THEN
                                TempGencod := ItemCrossReference."Cross-Reference No.";

                            Countrylibelle := '';

                            item."Tariff No." := '';


                            item.RESET();
                            IF item.GET(TempSalesLine."No.") AND (TempSalesLine.Type = TempSalesLine.Type::Item) THEN BEGIN
                                IF SalesHeader."Sell-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                                    TempNomenclaturedouaniere := item."Tariff No.";
                                    IF Country.GET(item."Country/Region of Origin Code") THEN
                                        Countrylibelle := Country.Name;
                                END;
                            END;

                            NNCSalesLineLineAmt += TempSalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += TempSalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount;
                            NNCTotalExclVAT2 := VATBaseAmount;
                            Asterisque := COPYSTR(TempSalesLine.Description, 1, 1);
                            BooGRoundLoopB3 := (TempSalesLine.Type.AsInteger() = 0) AND (Asterisque <> '*');
                            IF TempSalesLine.Type.AsInteger() = 0 THEN
                                CompteurDeLigne := CompteurDeLigne + 1;
                            //FIN


                            IF TempSalesLine.Type.AsInteger() > 0 THEN
                                CompteurDeLigne := CompteurDeLigne + 1;

                            IF (TempSalesLine."Line Amount" <> 0) AND (TempSalesLine.Quantity <> 0) THEN
                                PrixNet := TempSalesLine."Line Amount" / TempSalesLine.Quantity
                            ELSE
                                PrixNet := 0;
                            //Fin

                            BooGRoundLoopB4 := (TempSalesLine.Type.AsInteger() > 0);
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGRoundLoopB5 := (TempSalesLine."BC6_DEEE Category Code" <> '') AND
                                                          (TempSalesLine.Quantity <> 0) AND
                                                            (TempSalesLine."BC6_Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGRoundLoopB5 := FALSE;
                            END;



                            IF (CrossrefNo = '') AND (item."Tariff No." = '') THEN
                                BooGRoundLoopB6 := FALSE
                            ELSE
                                BooGRoundLoopB6 := TRUE;
                            templibelledouanier := '';
                            IF item."Tariff No." <> '' THEN
                                templibelledouanier := item.FIELDCAPTION("Tariff No.");

                            IF PaysArt.GET(item."Country/Region of Origin Code") THEN
                                PaysArtTex := PaysArt.Name
                            ELSE
                                PaysArtTex := '';

                            IF TempSalesLine."Inv. Discount Amount" <> 0 THEN
                                TempPourcent := TempSalesLine."Inv. Discount Amount" / TempSalesLine."Line Amount" * 100
                            ELSE
                                TempPourcent := 0;
                        end;

                        trigger OnPostDataItem()
                        begin

                            TempSalesLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempRecGDEEETariffs.RESET();
                            TempRecGDEEETariffs.DELETEALL();

                            MoreLines := TempSalesLine.FIND('+');
                            WHILE MoreLines AND (TempSalesLine.Description = '') AND (TempSalesLine."Description 2" = '') AND
                                  (TempSalesLine."No." = '') AND (TempSalesLine.Quantity = 0) AND
                                  (TempSalesLine.Amount = 0)
                            DO
                                MoreLines := TempSalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempSalesLine.SETRANGE("Line No.", 0, TempSalesLine."Line No.");
                            SETRANGE(Number, 1, TempSalesLine.COUNT);
                            CurrReport.CREATETOTALS(TempSalesLine."Line Amount", TempSalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(TraitementTexteClient; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        dataitem(TexteClient; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(BooGTexteClientB1; BooGTexteClientB1)
                            {
                            }
                            column(StandardSalesLine_Description_; StandardSalesLine.Description)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                BooGTexteClientB1 := Edition;
                                IF Edition2 THEN BEGIN
                                    IF Number = 1 THEN
                                        StandardSalesLine.FIND('-')
                                    ELSE BEGIN
                                        StandardSalesLine.NEXT();
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin

                                IF NOT Edition THEN CurrReport.BREAK();
                                StandardSalesLine.RESET();
                                StandardSalesLine.SETRANGE(StandardSalesLine."Standard Sales Code", StandardCustomerSalesCode.Code);
                                Edition2 := TRUE;
                                IF StandardSalesLine.COUNT <> 0 THEN
                                    TexteClient.SETRANGE(Number, 1, StandardSalesLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK();
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineType; AsmLine.Type)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent() + AsmLine."No.")
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent() + AsmLine.Description)
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineUOMText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    AsmLine.FINDSET()
                                ELSE
                                    AsmLine.NEXT();
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK();
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK();
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin

                            IF NOT Edition THEN CurrReport.BREAK();
                            IF Number = 1 THEN
                                StandardCustomerSalesCode.FIND('-')
                            ELSE
                                StandardCustomerSalesCode.NEXT();
                        end;

                        trigger OnPreDataItem()
                        begin

                            StandardCustomerSalesCode.RESET();
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."BC6_TextautoReport", TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", SalesHeader."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(TmpVATBase1_; TmpVATBase[1])
                        {
                        }
                        column(TmpVATBase2_; TmpVATBase[2])
                        {
                        }
                        column(TmpVATBase3_; TmpVATBase[3])
                        {
                        }
                        column(TmpVATRate1_; TmpVATRate[1])
                        {
                        }
                        column(TmpVATRate2_; TmpVATRate[2])
                        {
                        }
                        column(TmpVATRate3_; TmpVATRate[3])
                        {
                        }
                        column(TmpVATAmount1_; TmpVATAmount[1])
                        {
                        }
                        column(TmpVATAmount2_; TmpVATAmount[2])
                        {
                        }
                        column(TmpVATAmount3_; TmpVATAmount[3])
                        {
                        }
                        column(NetaPayer_; NetaPayer)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            NetaPayer := TotalAmountInclVAT - SalesHeader."BC6_Advance Payment";

                            TempVATAmountLine.GetLine(Number);

                            TmpVATBase[Number] := TempVATAmountLine."VAT Base" + TempVATAmountLine."BC6_DEEE HT Amount";
                            TmpVATRate[Number] := TempVATAmountLine."VAT %";
                            TmpVATAmount[Number] := TempVATAmountLine."VAT Amount" + TempVATAmountLine."BC6_DEEE VAT Amount";
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            TmpVATBase[1] := 0;
                            TmpVATRate[1] := 0;
                            TmpVATAmount[1] := 0;
                            TmpVATBase[2] := 0;
                            TmpVATRate[2] := 0;
                            TmpVATAmount[2] := 0;
                            TmpVATBase[3] := 0;
                            TmpVATRate[3] := 0;
                            TmpVATAmount[3] := 0;


                            IF TempVATAmountLine.COUNT > 3 THEN BEGIN
                                ERROR(STRSUBSTNO(Text020, TempVATAmountLine.COUNT));
                                CurrReport.QUIT();
                            END;
                            CurrReport.CREATETOTALS(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage2; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  TempVATAmountLine."VAT Base", SalesHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  TempVATAmountLine."VAT Amount", SalesHeader."Currency Factor"));
                            MESSAGE(FORMAT(TempVATAmountLine.COUNT));
                        end;

                        trigger OnPreDataItem()
                        begin

                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (SalesHeader."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(SalesHeader."Posting Date", SalesHeader."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(DEEE_Tariffs; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");

                        trigger OnAfterGetRecord()
                        begin

                            IF NOT TempRecGDEEETariffs.GET("Eco Partner", "DEEE Code", "Date beginning") THEN
                                CurrReport.SKIP();

                            RecGItemCtg.RESET();
                            IF NOT RecGItemCtg.GET(DEEE_Tariffs."DEEE Code", DEEE_Tariffs."Eco Partner") THEN
                                RecGItemCtg.INIT();
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLSalesLine: Record "Sales Line";
                        begin

                            BooGDEEEFind := FALSE;
                            RecLSalesLine.RESET();

                            RecLSalesLine.SETFILTER("Document No.", SalesHeader."No.");
                            RecLSalesLine.SETFILTER("Document Type", '%1', RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLSalesLine."BC6_DEEE Category Code" <> '') AND (RecLSalesLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLSalesLine.NEXT() = 0));

                            IF NOT BooGDEEEFind THEN
                                CurrReport.BREAK();

                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesHeader; SalesHeader."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr8_; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1_; ShipToAddr[1])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; SalesHeader.FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; TempPrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; TempPrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; TempPrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount; TempPrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt; TempPrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoopNumber; Number)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(GLAccountNoCaption; GLAccountNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText3; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT TempPrepmtDimSetEntry.FIND('-') THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText :=
                                          STRSUBSTNO(txtlbl12, TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL TempPrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempPrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF TempPrepmtInvBuf.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF ShowInternalInfo THEN
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, TempPrepmtInvBuf."Dimension Set ID");

                            IF SalesHeader."Prices Including VAT" THEN
                                PrepmtLineAmount := TempPrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := TempPrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              TempPrepmtInvBuf.Amount, TempPrepmtInvBuf."Amount Incl. VAT",
                              TempPrepmtVATAmountLine."Line Amount", TempPrepmtVATAmountLine."VAT Base",
                              TempPrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc; TempPrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; TempPrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATCounterNumber; Number)
                        {
                        }
                        column(PrepaymentVATAmtSpecCap; PrepaymentVATAmtSpecCapLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempPrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempPrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(PrepmtTotal; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PrepmtPmtTermsDesc; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtPmtTermsDescCaption; PrepmtPmtTermsDescCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT TempPrepmtInvBuf.FIND('-') THEN
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Client.GET(SalesHeader."Sell-to Customer No.") THEN
                            IF Client."Print Statements" = TRUE THEN BEGIN
                                surReleve := 'sur relevé :';
                                IF Client."Language Code" = 'ENU' THEN surReleve := 'Statement';
                            END
                            ELSE
                                surReleve := ':'
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtSalesLine: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    TempSalesLineDisc: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    CLEAR(TempSalesLineDisc);
                    TempVATAmountLine.DELETEALL();
                    TempSalesLineDisc.DELETEALL();
                    SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
                    CalcVATAmountLines(0, SalesHeader, TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, SalesHeader, TempSalesLine, TempVATAmountLine);



                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount(SalesHeader."Currency Code", SalesHeader."Prices Including VAT");

                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT() + TempVATAmountLine.GetTotalAmountDEEEInclVAT();

                    TempPrepmtInvBuf.DELETEALL();
                    SalesPostPrepmt.GetSalesLines(SalesHeader, 0, TempPrepmtSalesLine);

                    IF NOT TempPrepmtSalesLine.ISEMPTY THEN BEGIN
                        SalesPostPrepmt.GetSalesLinesToDeduct(SalesHeader, TempSalesLine);
                        IF NOT TempSalesLine.ISEMPTY THEN
                            SalesPostPrepmt.CalcVATAmountLines(SalesHeader, TempSalesLine, TempPrepmtVATAmountLineDeduct, 1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines(SalesHeader, TempPrepmtSalesLine, TempPrepmtVATAmountLine, 0);
                    IF TempPrepmtVATAmountLine.FINDSET() THEN
                        REPEAT
                            TempPrepmtVATAmountLineDeduct := TempPrepmtVATAmountLine;
                            IF TempPrepmtVATAmountLineDeduct.FIND() THEN BEGIN
                                TempPrepmtVATAmountLine."VAT Base" := TempPrepmtVATAmountLine."VAT Base" - TempPrepmtVATAmountLineDeduct."VAT Base";
                                TempPrepmtVATAmountLine."VAT Amount" := TempPrepmtVATAmountLine."VAT Amount" - TempPrepmtVATAmountLineDeduct."VAT Amount";
                                TempPrepmtVATAmountLine."Amount Including VAT" := TempPrepmtVATAmountLine."Amount Including VAT" -
                                  TempPrepmtVATAmountLineDeduct."Amount Including VAT";
                                TempPrepmtVATAmountLine."Line Amount" := TempPrepmtVATAmountLine."Line Amount" - TempPrepmtVATAmountLineDeduct."Line Amount";
                                TempPrepmtVATAmountLine."Inv. Disc. Base Amount" := TempPrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  TempPrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                TempPrepmtVATAmountLine."Invoice Discount Amount" := TempPrepmtVATAmountLine."Invoice Discount Amount" -
                                  TempPrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                TempPrepmtVATAmountLine."Calculated VAT Amount" := TempPrepmtVATAmountLine."Calculated VAT Amount" -
                                  TempPrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                TempPrepmtVATAmountLine.MODIFY();
                            END;
                        UNTIL TempPrepmtVATAmountLine.NEXT() = 0;

                    SalesPostPrepmt.UpdateVATOnLines(SalesHeader, TempPrepmtSalesLine, TempPrepmtVATAmountLine, 0);
                    SalesPostPrepmt.BuildInvLineBuffer(SalesHeader, TempPrepmtSalesLine, 0, TempPrepmtInvBuf);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;

                end;

                trigger OnPostDataItem()
                begin
                    IF Print THEN
                        SalesCountPrinted.RUN(SalesHeader);
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    NoOfLoops := 0;

                    IF NoOfCopies <> 0 THEN
                        NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops > 0 THEN
                        SETRANGE(Number, 1, NoOfLoops)
                    ELSE
                        SETRANGE(Number, 0, 0);


                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET();
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language2.GetLanguageIdOrDefault("Language Code");


                CompanyInfo.CALCFIELDS(CompanyInfo."BC6_Alt Picture");
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                TmpNamereport := Text200 + ' ' + SalesHeader."No.";
                ModeDePayment := '';
                IF PaymentMethod.GET(SalesHeader."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := '';
                    SalesPersonText := Text100 + ' ' + SalesPurchPerson.Name;
                    IF SalesPurchPerson."Phone No." <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + '' + Text101 + ' ' + SalesPurchPerson."Phone No.";
                    IF SalesPurchPerson."E-Mail" <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + ' ' + SalesPurchPerson.FIELDCAPTION("E-Mail") + ' ' + SalesPurchPerson."E-Mail";


                END;
                IF ("Your Reference" = '') AND ("External Document No." = '') THEN BEGIN
                    VotreRef := '';
                END
                ELSE BEGIN
                    VotreRef := "External Document No." + '  ' + "Your Reference";
                END;
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                    Currency := GLSetup."LCY Code";

                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    Currency := "Currency Code";

                END;
                FormatAddr.SalesHeaderSellTo(CustAddr, SalesHeader);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT()
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT()
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                        SegManagement.LogDocument(
                          3, "No.", "Doc. No. Occurrence",
                          "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                          , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                    ELSE
                        SegManagement.LogDocument(
                          3, "No.", "Doc. No. Occurrence",
                          "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                END;
                IF Customer.GET("Sell-to Customer No.") THEN;
                Tel := Customer."Phone No.";
                Fax := Customer."Fax No.";

                CondDePayment := '';
                IF PaymentTerms.GET(SalesHeader."Payment Terms Code") THEN
                    CondDePayment := PaymentTerms.Description;
                ModeTransport := '';
                IF ShippingAgent.GET(SalesHeader."Shipping Agent Code") THEN
                    ModeTransport := ShippingAgent.Name;

                RecGBillCustomer.RESET();
                RecGBillCustomer.GET(SalesHeader."Bill-to Customer No.");

                IF SalesHeader."Bill-to Customer No." <> '' THEN BEGIN
                    RecGBillCustomer.RESET();
                    RecGBillCustomer.GET(SalesHeader."Bill-to Customer No.");
                    BooGSubmittedToDEEE := RecGBillCustomer."BC6_Submitted to DEEE";
                END ELSE BEGIN
                    RecGCustomerTemplate.RESET();
                    IF RecGCustomerTemplate.GET(SalesHeader."Sell-to Customer Templ. Code") THEN BEGIN
                        BooGSubmittedToDEEE := RecGCustomerTemplate."BC6_Submitted to DEEE";
                    END ELSE BEGIN
                        BooGSubmittedToDEEE := FALSE;
                    END;
                END;

            end;

            trigger OnPreDataItem()
            begin
                Print := Print OR NOT CurrReport.PREVIEW;
                AsmInfoExistsForLine := FALSE;
                CompteurDeLigne := 31;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ApplicationArea = All;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components', Comment = 'FRA="Afficher composants d''assemblage"';
                        ApplicationArea = All;
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
            ArchiveDocument := SalesSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

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
        CompanyInfo.CALCFIELDS(CompanyInfo."BC6_Alt Picture");
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

    end;

    var
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        TempRecGDEEETariffs: Record "BC6_DEEE Tariffs" temporary;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        Country: Record "Country/Region";
        PaysArt: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        Client: Record Customer;
        Customer: Record Customer;
        RecGBillCustomer: Record Customer;
        RecGCustomerTemplate: Record "Customer Template";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        item: Record Item;
        RecGItem: Record Item;
        ItemCrossReference: Record "Item Cross Reference";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        TempPrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
        StandardSalesLine: Record "Standard Sales Line";
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit "ArchiveManagement";
        DimMgt: Codeunit "DimensionManagement";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit "Language";
        Language2: Codeunit Language;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        SalesCountPrinted: Codeunit "Sales-Printed";
        SegManagement: Codeunit "SegManagement";
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        AsmInfoExistsForLine: Boolean;
        BooGDEEEFind: Boolean;
        BooGRoundLoopB3: Boolean;
        BooGRoundLoopB4: Boolean;
        BooGRoundLoopB5: Boolean;
        BooGRoundLoopB6: Boolean;
        BooGSubmittedToDEEE: Boolean;
        BooGTexteClientB1: Boolean;
        Continue: Boolean;
        DisplayAssemblyInformation: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        FlagText: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        Print: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        PrincipalContact: Code[10];
        DecGHTUnitTaxLCY: Decimal;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGVatDEEE: Decimal;
        NetaPayer: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCTotalLCY: Decimal;
        NNCVATAmt: Decimal;
        NNCVATAmt2: Decimal;
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrixNet: Decimal;
        TempPourcent: Decimal;
        TmpVATAmount: array[3] of Decimal;
        TmpVATBase: array[3] of Decimal;
        TmpVATRate: array[3] of Decimal;
        TotalAmountInclVAT: Decimal;
        TotalVATBase: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        "--NSC1.03--": Integer;
        "--NSC1.05--": Integer;
        "-MICO-": Integer;
        "-MIGNAV2013-": Integer;
        CompteurDeLigne: Integer;
        i: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AccountNoCaptionLbl: Label 'Account No.', comment = 'FRA="n° compte"';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount', comment = 'FRA="Autoriser remise facture"';
        AmountCaptionLbl: Label 'Amount', comment = 'FRA="Montant"';
        BankCaptionLbl: Label 'Bank', comment = 'FRA="Banque"';
        CstG001: Label 'Representant', comment = 'FRA="Représentant"';
        CstG002: Label 'Unit Sale', comment = 'FRA="Unité vente"';
        CstG003: Label 'REGLEMENT DATE', comment = 'FRA="DATE DE REGLEMENT"';
        CstG004: Label 'REGLEMENT CONDITION', comment = 'FRA="CONDITIONS DE REGLEMENT"';
        CstG005: Label 'Is the total amount is not payed at the due date', comment = 'FRA="Dans le cas où le paiement intégral n''interviendrait pas à la date prévue par les parties,"';
        CstG006: Label 'We will get back the delivered items', comment = 'FRA="le vendeur se réserve le droit de reprendre le matériel livré."';
        CstG007: Label 'Late payment : 1,5 legal rate', comment = 'FRA="Retard de paiement : pénalités de 1% par mois."';
        CstGTxt001: Label 'Shipment departement', comment = 'FRA="Adresse de livraison"';
        CstGTxt002: Label 'Invoice departement', comment = 'FRA="Adresse de facturation"';
        CstGTxt003: Label 'VAT No.', comment = 'FRA="N° TVA :"';
        CstGTxt004: Label 'Invoice Number', comment = 'FRA="n° de Facture"';
        CstGTxt005: Label 'Date';
        CstGTxt006: Label 'Customer Number', comment = 'FRA="Code Client"';
        CstGTxt007: Label 'Phone ', comment = 'FRA="Tel  :"';
        CstGTxt008: Label 'Fax ';
        CstGTxt009: Label 'Reference : ', comment = 'FRA="Référence"';
        CstGTxt010: Label 'Principal Contact', comment = 'FRA="Interlocuteur principal"';
        CstGTxt011: Label 'Payment', comment = 'FRA="Condition de réglement"';
        CstGTxt012: Label 'Shipment Mode', comment = 'FRA="Mode Expédition"';
        CstGTxt013: Label 'Payment', comment = 'FRA="Représentant"';
        CstGTxt014: Label ' Item', comment = 'FRA="Référence"';
        CstGTxt015: Label 'DEEE Contribution : ', comment = 'FRA="Contribution DEEE : "';
        CstGTxt016: Label 'Item', comment = 'FRA="Art. "';
        CstGTxt017: Label ' -   Category :', comment = 'FRA=" -   Catégorie :"';
        CstGTxt018: Label 'Origin', comment = 'FRA="Origine"';
        CstGTxt019: Label 'TOTAL', comment = 'FRA="TOTAL"';
        CstGTxt020: Label 'Discount', comment = 'FRA="Remise"';
        CstGTxt021: Label 'BASE', comment = 'FRA="BASE HT"';
        CstGTxt022: Label 'RATE', comment = 'FRA="TVA %"';
        CstGTxt023: Label 'VAT', comment = 'FRA="Montant TVA"';
        CstGTxt024: Label 'Total Incl VAT', comment = 'FRA="TTC"';
        CstGTxt025: Label 'DOWN PAYMENT', comment = 'FRA="ACOMPTE"';
        CstGTxt026: Label 'NET TO BE PAID', comment = 'FRA="NET A PAYER"';
        DescriptionCaptionLbl: Label 'Description', comment = 'FRA="Désignation"';
        DiscountPercentCaptionLbl: Label 'Discount %', comment = 'FRA="% remise"';
        DocumentDateCaptionLbl: Label 'Document Date', comment = 'FRA="Date document"';
        EmailCaptionLbl: Label 'E-Mail';
        GiroNoCaptionLbl: Label 'Giro No.', comment = 'FRA="n° CCP"';
        GLAccountNoCaptionLbl: Label 'G/L Account No.', comment = 'FRA="n° compte général"';
        HeaderDimCaptionLbl: Label 'Header Dimensions', comment = 'FRA="Analytique en-tête"';
        HomePageCaptionLbl: Label 'Home Page', comment = 'FRA="Page d''accueil"';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', comment = 'FRA="Montant base remise facture"';
        LineAmtCaptionLbl: Label 'Line Amount', comment = 'FRA="Montant ligne"';
        LineDimCaptionLbl: Label 'Line Dimensions', comment = 'FRA="Analytique ligne"';
        OrderNoCaptionLbl: Label 'Order No.', comment = 'FRA="n° commande"';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT', comment = 'FRA="Escompte sur TVA"';
        PaymentTermsCaptionLbl: Label 'Payment Terms', comment = 'FRA="Conditions de paiement"';
        PhoneNoCaptionLbl: Label 'Phone No.', comment = 'FRA="n° téléphone"';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification', comment = 'FRA="Spécification acompte"';
        PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification', comment = 'FRA="Spécification montant TVA acompte"';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms', comment = 'FRA="Conditions paiement acompte"';
        ShipmentDateCaptionLbl: Label 'Shipment Date', comment = 'FRA="Date d''expédition"';
        ShipmentMethodCaptionLbl: Label 'Shipment Method', comment = 'FRA="Conditions de livraison"';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address', comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', comment = 'FRA="Sous-total"';
        Text000: Label 'Salesperson', comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', comment = 'FRA="COPIE"';
        Text004: Label 'Order Confirmation %1', comment = 'FRA="Confirmation de commande %1"';
        Text005: Label 'Page %1', comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', comment = 'FRA="Taux de change : %1/%2"';
        Text020: Label 'You have more than 3 VAT (%1) in this order You cannot continue ', comment = 'FRA="Il y a plus de 3 TVA (%1) dans cette commande. Le traitement est impossible"';
        Text030: Label '%1 - %2 - %3 %4';
        Text031: Label 'Tel. :  %1 ';
        Text033: Label 'Fax :  %1';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - n°TVA : %5"';
        Text100: Label 'Salesperson : ', comment = 'FRA="Représentant"';
        Text101: Label 'Phone :', comment = 'FRA="Tel: "';
        Text200: Label 'Proforma Invoice No. ', comment = 'FRA="Facture Proforma n°"';
        TotalCaptionLbl: Label 'Total', comment = 'FRA="Total"';
        UnitPriceCaptionLbl: Label 'Unit Price', comment = 'FRA="Prix unitaire"';
        VATAmtCaptionLbl: Label 'VAT Amount', comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', comment = 'FRA="Base TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATPercentageCaptionLbl: Label 'VAT %', comment = 'FRA="% TVA"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', comment = 'FRA="n° identif. intracomm."';
        txtlbl12: label '%1 %2';
        Asterisque: Text[1];
        Currency: Text[10];
        CrossrefNo: Text[20];
        CopyText: Text[30];
        Fax: Text[30];
        ModeDePayment: Text[30];
        Pays: Text[30];
        PaysArtTex: Text[30];
        Tel: Text[30];
        TempGencod: Text[30];
        templibelledouanier: Text[30];
        TempNomenclaturedouaniere: Text[30];
        CompanyAddr: array[8] of Text[50];
        CondDePayment: Text[50];
        Countrylibelle: Text[50];
        CustAddr: array[8] of Text[50];
        PrincContactName: Text[50];
        ShipToAddr: array[8] of Text[50];
        surReleve: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        ModeTransport: Text[80];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        TmpNamereport: Text[100];
        DimText: Text[120];
        VotreRef: Text[200];
        SalesPersonText: Text[250];

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    procedure CalcVATAmountLines(QtyType: Option General,Invoicing,Shipping; var SalesHeader: Record "Sales Header"; var _SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        Currency: Record Currency;
        RoundingLineInserted: Boolean;
        AmtToHandle: Decimal;
        QtyToHandle: Decimal;
        TotalVATAmount: Decimal;
    begin
        Currency.Initialize(SalesHeader."Currency Code");

        VATAmountLine.DELETEALL();

        _SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        _SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF _SalesLine.FINDSET() THEN
            REPEAT
                IF NOT EmptyAmountLine(_SalesLine, QtyType) THEN BEGIN
                    IF (_SalesLine.Type = _SalesLine.Type::"G/L Account") AND NOT _SalesLine."Prepayment Line" THEN
                        RoundingLineInserted := (_SalesLine."No." = _SalesLine.GetCPGInvRoundAcc(SalesHeader)) OR RoundingLineInserted;
                    IF _SalesLine."VAT Calculation Type" IN
                       [_SalesLine."VAT Calculation Type"::"Reverse Charge VAT", _SalesLine."VAT Calculation Type"::"Sales Tax"]
                    THEN
                        _SalesLine."VAT %" := 0;
                    IF NOT VATAmountLine.GET(
                         _SalesLine."VAT Identifier", _SalesLine."VAT Calculation Type", _SalesLine."Tax Group Code", FALSE, _SalesLine."Line Amount" >= 0)
                    THEN
                        VATAmountLine.InsertNewLine(
                          _SalesLine."VAT Identifier", _SalesLine."VAT Calculation Type", _SalesLine."Tax Group Code", FALSE, _SalesLine."VAT %", _SalesLine."Line Amount" >= 0, FALSE);

                    CASE QtyType OF
                        QtyType::General:
                            BEGIN
                                VATAmountLine.Quantity += _SalesLine."Quantity (Base)";

                                VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + _SalesLine."BC6_DEEE HT Amount";
                                VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + ROUND(_SalesLine."BC6_DEEE VAT Amount"
                                      , Currency."Amount Rounding Precision");
                                VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + ROUND(_SalesLine."BC6_DEEE TTC Amount"
                                      , Currency."Amount Rounding Precision");
                                VATAmountLine."BC6_DEEE Amount (LCY) for Stat" := VATAmountLine."BC6_DEEE Amount (LCY) for Stat" +
                                _SalesLine."BC6_DEEE Amount (LCY) for Stat"; //ooo


                                VATAmountLine.SumLine(
                                  _SalesLine."Line Amount", _SalesLine."Inv. Discount Amount", _SalesLine."VAT Difference", _SalesLine."Allow Invoice Disc.", _SalesLine."Prepayment Line");
                            END;
                        QtyType::Invoicing:
                            BEGIN
                                CASE TRUE OF
                                    (_SalesLine."Document Type" IN [_SalesLine."Document Type"::Order, _SalesLine."Document Type"::Invoice]) AND
                                  (NOT SalesHeader.Ship) AND SalesHeader.Invoice AND (NOT _SalesLine."Prepayment Line"):
                                        IF _SalesLine."Shipment No." = '' THEN BEGIN
                                            QtyToHandle := GetAbsMin(_SalesLine."Qty. to Invoice", _SalesLine."Qty. Shipped Not Invoiced");
                                            VATAmountLine.Quantity += GetAbsMin(_SalesLine."Qty. to Invoice (Base)", _SalesLine."Qty. Shipped Not Invd. (Base)");
                                        END ELSE BEGIN
                                            QtyToHandle := _SalesLine."Qty. to Invoice";
                                            VATAmountLine.Quantity += _SalesLine."Qty. to Invoice (Base)";
                                        END;
                                    (_SalesLine."Document Type" IN [_SalesLine."Document Type"::"Return Order", _SalesLine."Document Type"::"Credit Memo"]) AND
                                  (NOT SalesHeader.Receive) AND SalesHeader.Invoice:
                                        IF _SalesLine."Return Receipt No." = '' THEN BEGIN
                                            QtyToHandle := GetAbsMin(_SalesLine."Qty. to Invoice", _SalesLine."Return Qty. Rcd. Not Invd.");
                                            VATAmountLine.Quantity += GetAbsMin(_SalesLine."Qty. to Invoice (Base)", _SalesLine."Ret. Qty. Rcd. Not Invd.(Base)");
                                        END ELSE BEGIN
                                            QtyToHandle := _SalesLine."Qty. to Invoice";
                                            VATAmountLine.Quantity += _SalesLine."Qty. to Invoice (Base)";
                                        END;
                                    ELSE BEGIN
                                        QtyToHandle := _SalesLine."Qty. to Invoice";
                                        VATAmountLine.Quantity += _SalesLine."Qty. to Invoice (Base)";
                                    END;
                                END;
                                AmtToHandle := _SalesLine.GetLineAmountToHandle(QtyToHandle);
                                IF SalesHeader."Invoice Discount Calculation" <> SalesHeader."Invoice Discount Calculation"::Amount THEN
                                    VATAmountLine.SumLine(
                                      AmtToHandle, ROUND(_SalesLine."Inv. Discount Amount" * QtyToHandle / _SalesLine.Quantity, Currency."Amount Rounding Precision"),
                                      _SalesLine."VAT Difference", _SalesLine."Allow Invoice Disc.", _SalesLine."Prepayment Line")
                                ELSE
                                    VATAmountLine.SumLine(
                                      AmtToHandle, _SalesLine."Inv. Disc. Amount to Invoice", _SalesLine."VAT Difference", _SalesLine."Allow Invoice Disc.", _SalesLine."Prepayment Line");
                            END;
                        QtyType::Shipping:
                            BEGIN
                                IF _SalesLine."Document Type" IN
                                   [_SalesLine."Document Type"::"Return Order", _SalesLine."Document Type"::"Credit Memo"]
                                THEN BEGIN
                                    QtyToHandle := _SalesLine."Return Qty. to Receive";
                                    VATAmountLine.Quantity += _SalesLine."Return Qty. to Receive (Base)";
                                END ELSE BEGIN
                                    QtyToHandle := _SalesLine."Qty. to Ship";
                                    VATAmountLine.Quantity += _SalesLine."Qty. to Ship (Base)";
                                END;
                                AmtToHandle := _SalesLine.GetLineAmountToHandle(QtyToHandle);
                                VATAmountLine.SumLine(
                                  AmtToHandle, ROUND(_SalesLine."Inv. Discount Amount" * QtyToHandle / _SalesLine.Quantity, Currency."Amount Rounding Precision"),
                                  _SalesLine."VAT Difference", _SalesLine."Allow Invoice Disc.", _SalesLine."Prepayment Line");
                            END;
                    END;
                    TotalVATAmount += _SalesLine."Amount Including VAT" - _SalesLine.Amount;
                END;
            UNTIL _SalesLine.NEXT() = 0;

        VATAmountLine.UpdateLines(
          TotalVATAmount, Currency, SalesHeader."Currency Factor", SalesHeader."Prices Including VAT",
          SalesHeader."VAT Base Discount %", SalesHeader."Tax Area Code", SalesHeader."Tax Liable", SalesHeader."Posting Date");

        IF RoundingLineInserted AND (TotalVATAmount <> 0) THEN
            IF VATAmountLine.GET(TempSalesLine."VAT Identifier", TempSalesLine."VAT Calculation Type",
                 TempSalesLine."Tax Group Code", FALSE, TempSalesLine."Line Amount" >= 0)
            THEN BEGIN
                VATAmountLine."VAT Amount" += TotalVATAmount;
                VATAmountLine."Amount Including VAT" += TotalVATAmount;
                VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
                VATAmountLine.MODIFY();
            END;
    end;

    local procedure EmptyAmountLine(_SalesLine: Record "Sales Line"; QtyType: Option General,Invoicing,Shipping): Boolean
    begin
        IF _SalesLine.Type = _SalesLine.Type::" " THEN
            EXIT(TRUE);
        IF _SalesLine.Quantity = 0 THEN
            EXIT(TRUE);
        IF QtyType = QtyType::Invoicing THEN
            IF _SalesLine."Qty. to Invoice" = 0 THEN
                EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure GetAbsMin(QtyToHandle: Decimal; QtyHandled: Decimal): Decimal
    begin
        IF ABS(QtyHandled) < ABS(QtyToHandle) THEN
            EXIT(QtyHandled);

        EXIT(QtyToHandle);
    end;
}

