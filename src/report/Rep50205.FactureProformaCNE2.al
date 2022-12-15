report 50205 "BC6_Facture Proforma CNE 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/FactureProformaCNE2.rdl';
    Caption = 'Order Confirmation', Comment = 'FRA="Facture Proforma (idem conf. de cde)"';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
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
            column(Sales_Header_Advance_Payment_; "Sales Header"."BC6_Advance Payment")
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShptDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
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
                    column(SalesOrderReference_SalesHeader; "Sales Header"."Your Reference")
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
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT")
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
                    column(PricesInclVATYesNo_SalesHeader; FORMAT("Sales Header"."Prices Including VAT"))
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
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
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
                    column(Company_Addr; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
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
                    column(Company_Alt_Addr; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
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
                        DataItemLinkReference = "Sales Header";
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
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
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
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //DESIGN DARI 19/01/2007 NSC1.03
                            //IF NOT ShowInternalInfo THEN
                            CurrReport.BREAK;
                            //Fin DESIGN DARI 19/01/2007 NSC1.03
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine; "Sales Line".Description)
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
                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(No2_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Qty_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(UOM_SalesLine; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(LineDisc_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; FORMAT("Sales Line".Type))
                        {
                        }
                        column(No_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(Qty_per_Unit_of_Measure_; "Sales Line"."Qty. per Unit of Measure")
                        {
                        }
                        column(Qty_per_Unit_of_Measure_Caption; "Sales Line".FIELDCAPTION("Qty. per Unit of Measure"))
                        {
                        }
                        column(SalesLine_DEEE_Category_Code; SalesLine."BC6_DEEE Category Code")
                        {
                        }
                        column(SalesLine_DEEE_Category_Code_Caption; SalesLine.FIELDCAPTION("BC6_DEEE Category Code"))
                        {
                        }
                        column(Item_Number_of_Units_DEEE_; item."BC6_Number of Units DEEE")
                        {
                        }
                        column(SalesLine_Quantity_; SalesLine.Quantity)
                        {
                        }
                        column(SalesLine_DEEE_Unit_Price_LCY_; SalesLine."BC6_DEEE Unit Price (LCY)")
                        {
                        }
                        column(PaysArtTex_; PaysArtTex)
                        {
                        }
                        column(Templibelledouanier_TempNomenclaturedouaniere_; STRSUBSTNO('%1 %2', templibelledouanier, TempNomenclaturedouaniere))
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                            IncludeCaption = false;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText3; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
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
                        column(Desc_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(No2_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesLineCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption; "Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; "Sales Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(SalesLine_Type_; SalesLine.Type)
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
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
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
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                //DESIGN DARI 19/01/2007 NSC1.03
                                CurrReport.BREAK;
                                //Fin DESIGN DARI 19/01/2007 NSC1.03

                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            //>>MIGRATION NAV 2013
                            "Sales Line" := SalesLine;
                            //<<MIGRATION NAV 2013
                            //>>MICO
                            RecGDEEETariffs.RESET;
                            RecGDEEETariffs.SETFILTER("Eco Partner", SalesLine."BC6_Eco partner DEEE");
                            RecGDEEETariffs.SETFILTER("DEEE Code", SalesLine."BC6_DEEE Category Code");
                            IF NOT RecGDEEETariffs.FIND('-') THEN BEGIN
                                RecGDEEE.RESET;
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", SalesLine."BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER("Eco Partner", SalesLine."BC6_Eco partner DEEE");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN BEGIN
                                    RecGDEEETariffs.INIT;
                                    RecGDEEETariffs."Eco Partner" := RecGDEEE."Eco Partner";
                                    RecGDEEETariffs."DEEE Code" := RecGDEEE."DEEE Code";
                                    RecGDEEETariffs."Date beginning" := RecGDEEE."Date beginning";
                                    RecGDEEETariffs.INSERT;
                                END;
                            END;
                            //<<MICO

                            IF DisplayAssemblyInformation THEN
                                AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                SalesLine."Line Amount" := 0;
                            //>>MIGRATION NAV 2013
                            //F (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                            //"Sales Line"."No." := '';
                            //<<MIGRATION NAV 2013
                            //                           PRM debut affichage des references externes      //
                            ItemCrossReference.RESET;
                            ItemCrossReference.SETRANGE("Item No.", SalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
                            ItemCrossReference.SETRANGE("Cross-Reference Type No.", "Sales Header"."Sell-to Customer No.");
                            CrossrefNo := '';
                            IF ItemCrossReference.FIND('-') THEN
                                CrossrefNo := ItemCrossReference."Cross-Reference No.";
                            //                           PRM fin affichage des references externes      //
                            //                  PRM Début recuperation du code barre (gencod)
                            ItemCrossReference.RESET;
                            ItemCrossReference.SETRANGE("Item No.", SalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Discontinue Bar Code", FALSE);
                            TempGencod := '';
                            IF ItemCrossReference.FIND('-') THEN
                                TempGencod := ItemCrossReference."Cross-Reference No.";
                            //                  PRM Fin recuperation du code barre (gencod)
                            //                  PRM debut recuperation du code nomenclature douaniére

                            //PAYS_ORIGINE SL 14/09/06 NSC1.05 Ajout du libellé Pays Origine sur BL Export
                            Countrylibelle := '';
                            //Fin PAYS_ORIGINE SL 14/09/06 NSC1.05 Ajout du libellé Pays Origine sur BL Export

                            //DESIGN SL 04/10/06 NSC1.10  Afficher la nomenclature douaniére une seule fois par article
                            item."Tariff No." := '';
                            //Fin DESIGN SL 04/10/06 NSC1.10  Afficher la nomenclature douaniére une seule fois par article


                            item.RESET;
                            IF item.GET(SalesLine."No.") AND (SalesLine.Type = SalesLine.Type::Item) THEN BEGIN
                                IF "Sales Header"."Sell-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                                    TempNomenclaturedouaniere := item."Tariff No.";
                                    //PAYS_ORIGINE SL 14/09/06 NSC1.05 Ajout du libellé Pays Origine sur BL Export
                                    IF Country.GET(item."Country/Region of Origin Code") THEN
                                        Countrylibelle := Country.Name;
                                    //Fin PAYS_ORIGINE SL 14/09/06 NSC1.05 Ajout du libellé Pays Origine sur BL Export
                                END;
                            END;
                            //                  PRM fin recuperation du code nomenclature douaniére

                            NNCSalesLineLineAmt += SalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount;
                            NNCTotalExclVAT2 := VATBaseAmount;
                            //>>MIGRATION NAV 2013
                            Asterisque := COPYSTR(SalesLine.Description, 1, 1);
                            BooGRoundLoopB3 := (SalesLine.Type = 0) AND (Asterisque <> '*');
                            //TECSO 08/12/03 CST : Compteur de ligne
                            IF SalesLine.Type = 0 THEN
                                CompteurDeLigne := CompteurDeLigne + 1;
                            //FIN

                            ///

                            //TECSO 08/12/03 CST : Compteur de ligne
                            IF SalesLine.Type > 0 THEN
                                CompteurDeLigne := CompteurDeLigne + 1;
                            //FIN

                            //TECSO 15/12/03 CST: Calcul du Prix Net car dans la ligne, il n'y a que le prix brut (avant remise)
                            IF (SalesLine."Line Amount" <> 0) AND (SalesLine.Quantity <> 0) THEN
                                PrixNet := SalesLine."Line Amount" / SalesLine.Quantity
                            ELSE
                                PrixNet := 0;
                            //Fin

                            BooGRoundLoopB4 := (SalesLine.Type > 0);
                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGRoundLoopB5 := (SalesLine."BC6_DEEE Category Code" <> '') AND
                                                          (SalesLine.Quantity <> 0) AND
                                                            (SalesLine."BC6_Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGRoundLoopB5 := FALSE;
                            END;


                            //<<COMPTA_DEEE FG 01/03/07
                            ///

                            IF (CrossrefNo = '') AND (item."Tariff No." = '') THEN
                                BooGRoundLoopB6 := FALSE
                            ELSE
                                BooGRoundLoopB6 := TRUE;
                            templibelledouanier := '';
                            IF item."Tariff No." <> '' THEN
                                templibelledouanier := item.FIELDCAPTION("Tariff No.");

                            //PAYSART SM 30/08/06 NSC1.03 []
                            IF PaysArt.GET(item."Country/Region of Origin Code") THEN
                                PaysArtTex := PaysArt.Name
                            ELSE
                                PaysArtTex := '';
                            //FIN PAYSART SM 30/08/06 NSC1.03 []

                            //<<MIGRATION NAV 2013
                            //>>MIGRATION NAV 2013
                            IF SalesLine."Inv. Discount Amount" <> 0 THEN
                                TempPourcent := SalesLine."Inv. Discount Amount" / SalesLine."Line Amount" * 100
                            ELSE
                                TempPourcent := 0;
                            //NetaPayer:=TotalAmountInclVAT-"Sales Header"."Advance Payment";

                            //<<MIGRATION NAV 2013
                        end;

                        trigger OnPostDataItem()
                        begin

                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //MICO
                            RecGDEEETariffs.RESET;
                            RecGDEEETariffs.DELETEALL;

                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                                MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
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
                                        StandardSalesLine.NEXT;
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin

                                IF NOT Edition THEN CurrReport.BREAK;
                                StandardSalesLine.RESET;
                                StandardSalesLine.SETRANGE(StandardSalesLine."Standard Sales Code", StandardCustomerSalesCode.Code);
                                Edition2 := TRUE;
                                IF StandardSalesLine.COUNT <> 0 THEN
                                    TexteClient.SETRANGE(Number, 1, StandardSalesLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK;
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineType; AsmLine.Type)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
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
                                    AsmLine.FINDSET
                                ELSE
                                    AsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin

                            IF NOT Edition THEN CurrReport.BREAK;
                            IF Number = 1 THEN
                                StandardCustomerSalesCode.FIND('-')
                            ELSE
                                StandardCustomerSalesCode.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin

                            StandardCustomerSalesCode.RESET;
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.BC6_TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", "Sales Header"."Sell-to Customer No.");
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
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
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
                            //<<MIGRATION NAV 2013
                            NetaPayer := TotalAmountInclVAT - "Sales Header"."BC6_Advance Payment";
                            //<<MIGRATION NAV 2013

                            VATAmountLine.GetLine(Number);

                            //                           PRM debut stockage de 3 lignes de TVA maxi
                            //>>TDL:MICO 19/04/2007
                            //TmpVATBase[Number] :=VATAmountLine."VAT Base"

                            TmpVATBase[Number] := VATAmountLine."VAT Base" + VATAmountLine."BC6_DEEE HT Amount";
                            //<<TDL:MICO 19/04/2007
                            TmpVATRate[Number] := VATAmountLine."VAT %";
                            //>>TDL:MICO 17/04/2007
                            //TmpVATAmount[Number] :=VATAmountLine."VAT Amount";
                            TmpVATAmount[Number] := VATAmountLine."VAT Amount" + VATAmountLine."BC6_DEEE VAT Amount";
                            //<<TDL:MICO 17/04/2007
                            //                                  PRM fin TVA
                        end;

                        trigger OnPreDataItem()
                        begin
                            //<<MIGRATION NAV 2013

                            //IF VATAmount = 0 THEN
                            //  CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            //                           PRM debut stockage de 3 lignes de TVA maxi
                            TmpVATBase[1] := 0;
                            TmpVATRate[1] := 0;
                            TmpVATAmount[1] := 0;
                            TmpVATBase[2] := 0;
                            TmpVATRate[2] := 0;
                            TmpVATAmount[2] := 0;
                            TmpVATBase[3] := 0;
                            TmpVATRate[3] := 0;
                            TmpVATAmount[3] := 0;

                            //                                  PRM fin TVA

                            IF VATAmountLine.COUNT > 3 THEN BEGIN
                                ERROR(STRSUBSTNO(Text020, VATAmountLine.COUNT));
                                CurrReport.QUIT;
                            END;
                            //                                  PRM fin TVA
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
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
                        column(VATAmtLineVATPercentage2; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  VATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                            MESSAGE(FORMAT(VATAmountLine.COUNT));
                        end;

                        trigger OnPreDataItem()
                        begin

                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem("BC6_DEEE Tariffs"; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");

                        trigger OnAfterGetRecord()
                        begin

                            IF NOT RecGDEEETariffs.GET("Eco Partner", "DEEE Code", "Date beginning") THEN
                                CurrReport.SKIP;

                            RecGItemCtg.RESET;
                            IF NOT RecGItemCtg.GET("BC6_DEEE Tariffs"."DEEE Code", "BC6_DEEE Tariffs"."Eco Partner") THEN
                                RecGItemCtg.INIT;
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLSalesLine: Record "Sales Line";
                        begin

                            BooGDEEEFind := FALSE;
                            RecLSalesLine.RESET;

                            RecLSalesLine.SETFILTER("Document No.", "Sales Header"."No.");
                            RecLSalesLine.SETFILTER("Document Type", '%1', RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLSalesLine."BC6_DEEE Category Code" <> '') AND (RecLSalesLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLSalesLine.NEXT = 0));

                            IF NOT BooGDEEEFind THEN
                                CurrReport.BREAK;

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK;
                            //<<COMPTA_DEEE FG 01/03/07
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
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
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2; VATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
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
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText :=
                                          STRSUBSTNO('%1 %2', TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code")
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
                                UNTIL TempPrepmtDimSetEntry.NEXT = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF PrepmtInvBuf.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF ShowInternalInfo THEN
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, PrepmtInvBuf."Dimension Set ID");

                            IF "Sales Header"."Prices Including VAT" THEN
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; PrepmtVATAmountLine."VAT Identifier")
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
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.COUNT);
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
                            IF NOT PrepmtInvBuf.FIND('-') THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //SM
                        IF Client.GET("Sales Header"."Sell-to Customer No.") THEN
                            IF Client."Print Statements" = TRUE THEN BEGIN
                                surReleve := 'sur relevé :';
                                IF Client."Language Code" = 'ENU' THEN surReleve := 'Statement';
                            END
                            ELSE
                                surReleve := ':'
                        //FIN Sm
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                    TempSalesLineDisc: Record "Sales Line" temporary;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    CLEAR(TempSalesLineDisc);
                    VATAmountLine.DELETEALL;
                    //>>MIGRATION NAV 2013
                    //SalesLine.DELETEALL;
                    //<<MIGRATION NAV 2013
                    TempSalesLineDisc.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);

                    //SalesPost.GetSalesLines("Sales Header",TempSalesLineDisc,1);


                    /*TempSalesLineDisc.CalcVATAmountLines(1,"Sales Header",TempSalesLineDisc,VATAmountLine);
                    TempSalesLineDisc.UpdateVATOnLines(1,"Sales Header",TempSalesLineDisc,VATAmountLine);
                    SalesLine."Inv. Discount Amount" := VATAmountLine."Invoice Discount Amount";*/
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");

                    //>>TDL:MICO 17/04/2007
                    //TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT + VATAmountLine.GetTotalAmountDEEEInclVAT;
                    //<<TDL:MICO 17/04/2007

                    PrepmtInvBuf.DELETEALL;
                    SalesPostPrepmt.GetSalesLines("Sales Header", 0, PrepmtSalesLine);

                    IF NOT PrepmtSalesLine.ISEMPTY THEN BEGIN
                        SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header", TempSalesLine);
                        IF NOT TempSalesLine.ISEMPTY THEN
                            SalesPostPrepmt.CalcVATAmountLines("Sales Header", TempSalesLine, PrepmtVATAmountLineDeduct, 1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    IF PrepmtVATAmountLine.FINDSET THEN
                        REPEAT
                            PrepmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            IF PrepmtVATAmountLineDeduct.FIND THEN BEGIN
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrepmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrepmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrepmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrepmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.MODIFY;
                            END;
                        UNTIL PrepmtVATAmountLine.NEXT = 0;

                    SalesPostPrepmt.UpdateVATOnLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    SalesPostPrepmt.BuildInvLineBuffer("Sales Header", PrepmtSalesLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

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
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    //>>MIGRATION NAV 2013
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    //CopyText := '';
                    //SETRANGE(Number,1,NoOfLoops);
                    //<<MIGRATION NAV 2013
                    OutputNo := 1;
                    //TECSO 10/12/03 CST : Récupération du Nbre de copie dans la table diverses TYPECDE
                    // CST Suppr
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    //CopyText := '';
                    //SETRANGE(Nombre,1,NoOfLoops);

                    //CST Remplacé  par
                    //**IF TableDiv.GET('TYPECDE',"Sales Header"."Type commande") THEN
                    //**NoOfLoops := TableDiv.Nombre1
                    //**ELSE
                    NoOfLoops := 0;

                    //CST Si Nbre de Copies est renseigner, on écrase le Nbre de copies du type de commande.
                    IF NoOfCopies <> 0 THEN
                        NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops > 0 THEN
                        SETRANGE(Number, 1, NoOfLoops)
                    ELSE
                        SETRANGE(Number, 0, 0);


                    //FIN
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                //PRM debut pour avoir les infos société
                //MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
                CompanyInfo.CALCFIELDS(CompanyInfo."BC6_Alt Picture");
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                //FIN MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms

                // PRM
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;
                //PRM fin

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                //NATURE_COMMANDE SL 14/09/06 NSC1.05  Ajout de l'interlocuteur principal basé sur axe analytique 1
                //>>MIGRATION NAV 2013
                //Adaptation
                //PrincipalContact := '';
                //IF DocDimension.GET(DATABASE::"Sales Header","Document Type","No.",0,GLSetup."Global Dimension 1 Code") THEN BEGIN
                //PrincipalContact := DocDimension."Dimension Value Code";
                //IF DimensionValue.GET(DocDimension."Dimension Code",DocDimension."Dimension Value Code") THEN
                //PrincContactName := DimensionValue.Name;
                //END;
                //<<MIGRATION NAV 2013
                //Fin NATURE_COMMANDE SL 14/09/06 NSC1.05  Ajout de l'interlocuteur principal basé sur axe analytique 1


                // PRM chargement du titre
                TmpNamereport := Text200 + ' ' + "Sales Header"."No.";
                //TECSO 08/12/03 CST : Lecture des mode de réglement (Payment Methode)
                ModeDePayment := '';
                IF PaymentMethod.GET("Sales Header"."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;
                //FIN

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    //>>MIGRATION NAV 2013
                    //SalesPersonText := Text000;
                    SalesPersonText := '';
                    SalesPersonText := Text100 + ' ' + SalesPurchPerson.Name;
                    IF SalesPurchPerson."Phone No." <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + '' + Text101 + ' ' + SalesPurchPerson."Phone No.";
                    IF SalesPurchPerson."E-Mail" <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + ' ' + SalesPurchPerson.FIELDCAPTION("E-Mail") + ' ' + SalesPurchPerson."E-Mail";
                    //<<MIGRATION NAV 2013


                END;
                //>>MIGRATION NAV 2013
                /*
                IF "Your Reference" = '' THEN
                  ReferenceText := ''
                ELSE
                  ReferenceText := FIELDCAPTION("Your Reference");
                */
                //TECSO 09/12/03 CST : Ajout du Nø de Document externe dans le libellé de "Votre reference"
                IF ("Your Reference" = '') AND ("External Document No." = '') THEN BEGIN
                    //ReferenceText := '';
                    VotreRef := '';
                END
                ELSE BEGIN
                    VotreRef := "External Document No." + '  ' + "Your Reference";
                END;
                //<<MIGRATION NAV 2013
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                    //PRM debut devise
                    Currency := GLSetup."LCY Code";
                    //PRM Fin devise

                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    //PRM debut devise
                    Currency := "Currency Code";
                    //PRM Fin devise

                END;
                //TECSO 06/01/2004 CST : Adresse à imprimer = adresse de commande et non pas adresse de Facturation
                //FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");
                //Fin

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;
                //>>TDL0114:JORE 04/12/2006 - Remove archive management
                /*
                IF Print THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);
                */
                //<<TDL0114:JORE 04/12/2006 - Remove archive management

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
                //END;
                //                                           PRM
                IF Customer.GET("Sell-to Customer No.") THEN;
                // PRM ajout tel et fax fournisseur
                Tel := Customer."Phone No.";
                Fax := Customer."Fax No.";
                // PRM ajout tel et fax fournisseur

                //CONDPAYMENT SM 30/08/06 : Lecture des conditions de réglement (Payment Term)
                CondDePayment := '';
                IF PaymentTerms.GET("Sales Header"."Payment Terms Code") THEN
                    CondDePayment := PaymentTerms.Description;
                //MODETRANS SM 30/08/06 Lecture Mode transport
                ModeTransport := '';
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN
                    ModeTransport := ShippingAgent.Name;

                //>>TDL96:MICO 19/04/2007
                //>>COMPTA_DEEE FG 01/03/07
                RecGBillCustomer.RESET;
                RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.");
                //<<COMPTA_DEEE FG 01/03/07

                IF "Sales Header"."Bill-to Customer No." <> '' THEN BEGIN
                    RecGBillCustomer.RESET;
                    RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.");
                    BooGSubmittedToDEEE := RecGBillCustomer."BC6_Submitted to DEEE";
                END ELSE BEGIN
                    RecGCustomerTemplate.RESET;
                    IF RecGCustomerTemplate.GET("Sales Header"."Sell-to Customer Templ. Code") THEN BEGIN
                        BooGSubmittedToDEEE := RecGCustomerTemplate."BC6_Submitted to DEEE";
                    END ELSE BEGIN
                        BooGSubmittedToDEEE := FALSE;
                    END;
                END;
                //<<TDL96:MICO 19/04/2007

            end;

            trigger OnPreDataItem()
            begin
                Print := Print OR NOT CurrReport.PREVIEW;
                AsmInfoExistsForLine := FALSE;
                //>>MIGRATION NAV 2013
                CompteurDeLigne := 31;
                //<<MIGRATION NAV 2013
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
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

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

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components', Comment = 'FRA="Afficher composants d''assemblage"';
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
        GLSetup.GET;
        //>>MIGRATION NAV 2013
        /*
        SalesSetup.GET;
        
        CASE SalesSetup."Logo Position on Documents" OF
          SalesSetup."Logo Position on Documents"::"No Logo":
            ;
          SalesSetup."Logo Position on Documents"::Left:
            BEGIN
              CompanyInfo3.GET;
              CompanyInfo3.CALCFIELDS(Picture);
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
        */
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo."BC6_Alt Picture");
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        //<<MIGRATION NAV 2013

    end;

    var
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order Confirmation %1', Comment = 'FRA="Confirmation de commande %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[250];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        Print: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        GiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        BankCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        AccountNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        ShipmentDateCaptionLbl: Label 'Shipment Date', Comment = 'FRA="Date d''expédition"';
        OrderNoCaptionLbl: Label 'Order No.', Comment = 'FRA="N° commande"';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        EmailCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        HeaderDimCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        DiscountPercentCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LineDimCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        GLAccountNoCaptionLbl: Label 'G/L Account No.', Comment = 'FRA="N° compte général"';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification', Comment = 'FRA="Spécification acompte"';
        PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification', Comment = 'FRA="Spécification montant TVA acompte"';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms', Comment = 'FRA="Conditions paiement acompte"';
        PhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        VATPercentageCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        UnitPriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        PaymentTermsCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        ShipmentMethodCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';
        "-MIGNAV2013-": Integer;
        BooGRoundLoopB3: Boolean;
        BooGRoundLoopB4: Boolean;
        BooGRoundLoopB5: Boolean;
        BooGRoundLoopB6: Boolean;
        BooGTexteClientB1: Boolean;
        CompteurDeLigne: Integer;
        PaymentMethod: Record "Payment Method";
        ModeDePayment: Text[30];
        VotreRef: Text[200];
        PrixNet: Decimal;
        item: Record Item;
        ItemCrossReference: Record "Item Cross Reference";
        TmpVATBase: array[3] of Decimal;
        TmpVATRate: array[3] of Decimal;
        TmpVATAmount: array[3] of Decimal;
        TotalVATBase: Decimal;
        Currency: Text[10];
        Customer: Record Customer;
        TempGencod: Text[30];
        CrossrefNo: Text[20];
        TempPourcent: Decimal;
        templibelledouanier: Text[30];
        TmpNamereport: Text[100];
        Fax: Text[30];
        Tel: Text[30];
        Asterisque: Text[1];
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
        StandardSalesLine: Record "Standard Sales Line";
        FlagText: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        Pays: Text[30];
        Country: Record "Country/Region";
        NetaPayer: Decimal;
        "--NSC1.03--": Integer;
        CondDePayment: Text[50];
        ShippingAgent: Record "Shipping Agent";
        ModeTransport: Text[80];
        surReleve: Text[50];
        Client: Record Customer;
        PaysArt: Record "Country/Region";
        PaysArtTex: Text[30];
        "--NSC1.05--": Integer;
        PrincipalContact: Code[10];
        Countrylibelle: Text[50];
        TempNomenclaturedouaniere: Text[30];
        "--NSC1.06--": Integer;
        DimensionValue: Record "Dimension Value";
        PrincContactName: Text[50];
        "--FG--": Integer;
        RecGBillCustomer: Record Customer;
        BooGDEEEFind: Boolean;
        RecGDEEE: Record "BC6_DEEE Tariffs";
        RecGItemCtg: Record "BC6_Categories of item";
        DecGNumbeofUnitsDEEE: Decimal;
        DecGHTUnitTaxLCY: Decimal;
        RecGDEEETariffs: Record "BC6_DEEE Tariffs" temporary;
        "-MICO-": Integer;
        DecGVatDEEE: Decimal;
        BooGSubmittedToDEEE: Boolean;
        RecGCustomerTemplate: Record "Customer Template";
        RecGItem: Record Item;
        Text020: Label 'You have more than 3 VAT (%1) in this order You cannot continue ', Comment = 'FRA="Il y a plus de 3 TVA (%1) dans cette commande. Le traitement est impossible "';
        Text030: Label '%1 - %2 - %3 %4';
        Text031: Label 'Tel. :  %1 ';
        Text100: Label 'Salesperson : ', Comment = 'FRA="Représentant"';
        Text101: Label 'Phone :', Comment = 'FRA="Tel :"';
        Text200: Label 'Proforma Invoice No. ', Comment = 'FRA="Facture Proforma N°"';
        Text033: Label 'Fax :  %1';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        CstGTxt001: Label 'Shipment departement', Comment = 'FRA="Adresse de livraison"';
        CstGTxt002: Label 'Invoice departement', Comment = 'FRA="Adresse de facturation"';
        CstGTxt003: Label 'VAT No.', Comment = 'FRA="N° TVA :"';
        CstGTxt004: Label 'Invoice Number', Comment = 'FRA="N° de Facture"';
        CstGTxt005: Label 'Date';
        CstGTxt006: Label 'Customer Number', Comment = 'FRA="Code Client"';
        CstGTxt007: Label 'Phone ', Comment = 'FRA="Tel  :"';
        CstGTxt008: Label 'Fax ', Comment = 'FRA="Fax  :"';
        CstGTxt009: Label 'Reference : ', Comment = 'FRA="Référence :"';
        CstGTxt010: Label 'Principal Contact', Comment = 'FRA="Interlocuteur principal"';
        CstGTxt011: Label 'Payment', Comment = 'FRA="Condition de règlement "';
        CstGTxt012: Label 'Shipment Mode', Comment = 'FRA="Mode Expédition"';
        CstGTxt013: Label 'Payment', Comment = 'FRA="Représentant"';
        CstGTxt014: Label ' Item', Comment = 'FRA="Référence"';
        CstGTxt015: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        CstGTxt016: Label 'Item', Comment = 'FRA="Art. :"';
        CstGTxt017: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        CstGTxt018: Label 'Origin', Comment = 'FRA="Origine"';
        CstGTxt019: Label 'TOTAL';
        CstGTxt020: Label 'Discount', Comment = 'FRA="Remise"';
        CstGTxt021: Label 'BASE', Comment = 'FRA="BASE HT"';
        CstGTxt022: Label 'RATE', Comment = 'FRA="TVA %"';
        CstGTxt023: Label 'VAT', Comment = 'FRA="Montant TVA"';
        CstGTxt024: Label 'Total Incl VAT', Comment = 'FRA="TTC"';
        CstGTxt025: Label 'DOWN PAYMENT', Comment = 'FRA="ACOMPTE"';
        CstGTxt026: Label 'NET TO BE PAID', Comment = 'FRA="NET A PAYER"';
        CstG001: Label 'Representant', Comment = 'FRA="Représentant"';
        CstG002: Label 'Unit Sale', Comment = 'FRA="Unité vente"';
        CstG003: Label 'REGLEMENT DATE', Comment = 'FRA="DATE DE REGLEMENT"';
        CstG004: Label 'REGLEMENT CONDITION', Comment = 'FRA="CONDITIONS DE REGLEMENT"';
        CstG005: Label 'Is the total amount is not payed at the due date', Comment = 'FRA="Dans le cas où le paiement intégral n''interviendrait pas à la date prévue par les parties,"';
        CstG006: Label 'We will get back the delivered items', Comment = 'FRA="Le vendeur de réserve le droit de reprendre la chose livrée et de résoudre le contrat."';
        CstG007: Label 'Late payment : 1,5 legal rate', Comment = 'FRA="Retard de paiement : pénalité 1,5 x taux légal."';

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
}

