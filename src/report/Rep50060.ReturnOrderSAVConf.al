report 50060 "BC6_Return Order SAV Conf."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/ReturnOrderSAVConfirmation.rdl';
    Caption = 'Return Order Confirmation', comment = 'FRA="Confirmation de retour"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Return Order', comment = 'FRA="Retour vente"';
            column(DocType_SalesHdr; "Document Type")
            {
            }
            column(No_SalesHdr; "No.")
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(CstAfterSalesRequest; CstAfterSalesRequest)
            {
            }
            column(CstSocialReason; CstSocialReason)
            {
            }
            column(CstInterlocutor; CstInterlocutor)
            {
            }
            column(CstCNEDetails; CstCNEDetails)
            {
            }
            column(AccountNo_Vendor; G_Vendor."Our Account No.")
            {
            }
            column(PrimaryContactNo_Vendor; G_Vendor."Primary Contact No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    column(ReportTitleCopyText; STRSUBSTNO(Text004, CopyText))
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
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(UnitPriceCaption; UnitPriceCaptionLbl)
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(SalesLineInvDiscAmtCaptn; SalesLineInvDiscAmtCaptnLbl)
                    {
                    }
                    column(TotalExclVATText; TotalExclVATText)
                    {
                    }
                    column(VATAmount; VATAmount)
                    {
                        AutoFormatExpression = SalesHeader."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                    {
                    }
                    column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(SalesLineLineDiscCaption; SalesLineLineDiscCaptionLbl)
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
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(SalesPurchPersonEmail; SalesPurchPerson."E-Mail")
                    {
                    }
                    column(SalesPurchPersonCode; SalesPurchPerson.Code)
                    {
                    }
                    column("UserId"; SalesHeader.BC6_ID)
                    {
                    }
                    column(UserIDEmail; UserSetup."E-Mail")
                    {
                    }
                    column(CompanyInfoFax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfoAddress; CompanyInfo.Address)
                    {
                    }
                    column(CompanyInfoAddress2; CompanyInfo."Ship-to Address 2")
                    {
                    }
                    column(CompanyInfoPostCode; CompanyInfo."Post Code")
                    {
                    }
                    column(CompanyInfoCounty; CompanyInfo.City)
                    {
                    }
                    column(SelltoCustNo_SalesHdr; SalesHeader."Sell-to Customer Name")
                    {
                    }
                    column(DocDate_SalesHdr; FORMAT(SalesHeader."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHdr; SalesHeader."VAT Registration No.")
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
                    column(YourReference_SalesHdr; SalesHeader."Your Reference")
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
                    column(PricesInclVAT_SalesHdr; SalesHeader."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHdr; FORMAT(SalesHeader."Prices Including VAT"))
                    {
                    }
                    column(BilllltoCustNo_SalesHdr; SalesHeader."Bill-to Customer No.")
                    {
                    }
                    column(PhNoCaption; PhNoCaptionLbl)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(AccNoCaption; AccNoCaptionLbl)
                    {
                    }
                    column(ReturnOrderNoCaption; ReturnOrderNoCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHdrCaption; SalesHeader.FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHdrCaption; SalesHeader.FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(SelltoCustNo_SalesHdrCaption; SalesHeader.FIELDCAPTION("Sell-to Customer No."))
                    {
                    }
                    column(SerialNoCaption; SerialNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(ReturnCommentCaption; ReturnCommentCaptionLbl)
                    {
                    }
                    column(CrMemoCaption; CrMemoCaptionLbl)
                    {
                    }
                    column(CompanyInfoLegal; CompanyInfo."Legal Form")
                    {
                    }
                    column(CompanyInfoStockCapital; CompanyInfo."Stock Capital")
                    {
                    }
                    column(CompanyInfoTradeReg; CompanyInfo."Trade Register")
                    {
                    }
                    column(CompanyInfoRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(ShareCapital; ShareCapitalLbl)
                    {
                    }
                    column(TVANoCaption; TVANoCaptionLbl)
                    {
                    }
                    column(CstSeat; CstSeat)
                    {
                    }
                    column(CustomerCaption; CustomerCaptionLbl)
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
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
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
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
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
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TypeInt; TypeInt)
                        {
                        }
                        column(SalesLineNo; SalesLineNo)
                        {
                        }
                        column(SalesLineLineNo; SalesLineLineNo)
                        {
                        }
                        column(SalesLineLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine; SalesLine.Description)
                        {
                        }
                        column(DocNo_SalesLine; SalesLine."Document No.")
                        {
                        }
                        column(No2_SalesLine; SalesLine."No.")
                        {
                        }
                        column(Qty_SalesLine; SalesLine.Quantity)
                        {
                        }
                        column(UOM_SalesLine; SalesLine."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; SalesLine."Unit Price")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesLine; SalesLine."Line Discount %")
                        {
                        }
                        column(AllowInvDisc_SalesLine; SalesLine."Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(VATIdentifier_SalesLine; SalesLine."VAT Identifier")
                        {
                        }
                        column(AllowInvDiscYesNo_SalesLine; FORMAT(SalesLine."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLineInvDiscAmt; -SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtAfterLineDisc; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclVATAmount; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDiscount_SalesHdr; SalesHeader."VAT Base Discount %")
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount2; VATAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
                        {
                        }
                        column(Desc_SalesLineCaption; SalesLine.FIELDCAPTION(Description))
                        {
                        }
                        column(No2_SalesLineCaption; SalesLine.FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesLineCaption; SalesLine.FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption; SalesLine.FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; SalesLine.FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(ReturnComment_SalesLine; SalesLine."BC6_Return Comment")
                        {
                        }
                        column(SolutionCode_SalesLine; SalesLine."BC6_Solution Code")
                        {
                        }
                        column(PurchOrderNo_SalesLine; SalesLine."BC6_ReturnOrderShpt SalesOrder" + G_PurchaseHeader."No.")
                        {
                        }
                        column(SeriesNo_SalesLine; SalesLine."BC6_Series No.")
                        {
                        }
                        column(SerialNo_Item; G_Item."Serial Nos.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }
                            column(DimensionLoop2Number; Number)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
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
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", SalesLine."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            SalesLine := SalesLine;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN BEGIN
                                SalesLineNo := SalesLine."No.";
                                SalesLine."No." := '';
                            END;

                            TypeInt := SalesLine.Type;
                            SalesLineLineNo := SalesLine."Line No.";

                            IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."No." <> '') THEN BEGIN
                                G_Item.GET(SalesLine."No.");


                                IF L_PurchaseHeader.GET(L_PurchaseHeader."Document Type"::Order, SalesLine."BC6_Purchase No. Order Lien") THEN
                                    G_Vendor.GET(L_PurchaseHeader."Buy-from Vendor No.");
                            END;
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
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
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCaptn; VATAmtSpecificationCaptnLbl)
                        {
                        }
                        column(VATAmtLineVATIdentifrCptn; VATAmtLineVATIdentifrCptnLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
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
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  VATAmountLine."VAT Base", SalesHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  VATAmountLine."VAT Amount", SalesHeader."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (SalesHeader."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(SalesHeader."Posting Date", SalesHeader."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines(SalesHeader, SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, SalesHeader, SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(SalesHeader."Currency Code", SalesHeader."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Sales-Printed", SalesHeader);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                L_SalesHeader: Record "Sales Header";
                L_SalesLine: Record "Sales Line";
            begin
                //TODOCurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language2.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields(SalesHeader);
                FormatDocumentFields(SalesHeader);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              18, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              18, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", "Opportunity No.");
                    END;

                L_SalesLine.RESET;
                L_SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                L_SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                L_SalesLine.SETRANGE(Type, L_SalesLine.Type::Item);
                IF L_SalesLine.FINDFIRST THEN BEGIN
                    IF L_SalesHeader.GET(L_SalesHeader."Document Type"::Order, L_SalesLine."BC6_ReturnOrderShpt SalesOrder") THEN
                        IF G_PurchaseHeader.GET(G_PurchaseHeader."Document Type"::Order, L_SalesHeader."BC6_Purchase No. Order Lien") THEN
                            IF G_Vendor.GET(L_PurchaseHeader."Buy-from Vendor No.") THEN;
                END;

                UserSetup.GET(SalesHeader.ID);
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
                        Caption = 'No. of Copies', comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', comment = 'FRA="Afficher info. internes"';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        G_Item: Record Item;
        Language: Record Language;
        G_PurchaseHeader: Record "Purchase Header";
        L_PurchaseHeader: Record "Purchase Header";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        UserId: Record "Sales Header";
        SalesLine: Record "Sales Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesPurchPersonEmail: Record "Salesperson/Purchaser";
        UserIDEmail: Record "User Setup";
        UserSetup: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        G_Vendor: Record Vendor;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        Language2: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        SalesLineNo: Code[20];
        TotalAmountInclVAT: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        SalesLineLineNo: Integer;
        TypeInt: Integer;
        AccNoCaptionLbl: Label 'Account No.', comment = 'FRA="N° compte"';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount', comment = 'FRA="Autoriser remise facture"';
        AmountCaptionLbl: Label 'Amount', comment = 'FRA="Montant"';
        BankNameCaptionLbl: Label 'Bank', comment = 'FRA="Banque"';
        CrMemoCaptionLbl: Label 'Cr. Memo or Exchange?', comment = 'FRA="Avoir ou échange?"';
        CstAfterSalesRequest: Label 'After Sales Service Request', comment = 'FRA="Demande de prise en charge SAV"';
        CstCNEDetails: Label 'Distributor of Electrical Equipment', comment = 'FRA="Distributeur matériel éléctrique"';
        CstInterlocutor: Label 'User Code', comment = 'FRA="Code utilisateur"';
        CstSeat: Label 'Seat :', comment = 'FRA="Siége :"';
        CstSocialReason: Label 'Vendor', comment = 'FRA="Fournisseur"';
        CustomerCaptionLbl: Label 'Customer :', comment = 'FRA="Client"';
        DocDateCaptionLbl: Label 'Document Date', comment = 'FRA="Date document"';
        EmailCaptionLbl: Label 'Email', comment = 'FRA="E-mail"';
        FaxNoCaptionLbl: Label 'Fax No.', comment = 'FRA="Fax."';
        GiroNoCaptionLbl: Label 'Giro No.', comment = 'FRA="N° CCP"';
        HdrDimCaptionLbl: Label 'Header Dimensions', comment = 'FRA="Analytique en-tête"';
        HomePageCaptionLbl: Label 'Home Page', comment = 'FRA="Page d''accueil"';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Inv. Disc. Base Amount', comment = 'FRA="Montant base remise facture"';
        LineAmtCaptionLbl: Label 'Line Amount', comment = 'FRA="Montant ligne"';
        LineDimensionsCaptionLbl: Label 'Line Dimensions', comment = 'FRA="Analytique ligne"';
        OrderNoCaptionLbl: Label 'Order No.', comment = 'FRA="n° commande"';
        PhNoCaptionLbl: Label 'Phone No.', comment = 'FRA="Tel."';
        ReturnCommentCaptionLbl: Label 'BreakdownDescription', comment = 'FRA="Description panne"';
        ReturnOrderNoCaptionLbl: Label 'Return Order No. :', comment = 'FRA="N° retour vente :"';
        SalesLineInvDiscAmtCaptnLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        SalesLineLineDiscCaptionLbl: Label 'Discount %', comment = 'FRA="% remise"';
        SerialNoCaptionLbl: Label 'Serial No.', comment = 'FRA="n° de série"';
        ShareCapitalLbl: Label 'With the Share Capital of', comment = 'FRA="au capital social de"';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address', comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', comment = 'FRA="Sous-total"';
        Text004: Label 'Return Order Confirmation %1';
        Text005: Label 'Page %1';
        Text007: Label 'VAT Amount Specification in ', comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', comment = 'FRA="Taux de change : %1/%2"';
        TotalCaptionLbl: Label 'Total', comment = 'FRA="Total"';
        TVANoCaptionLbl: Label 'TVA No :', comment = 'FRA="n° TVA:"';
        UnitPriceCaptionLbl: Label 'Unit Price', comment = 'FRA="Prix unitaire"';
        VATAmountCaptionLbl: Label 'VAT Amount', comment = 'FRA="Montant TVA"';
        VATAmtLineVATIdentifrCptnLbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATAmtSpecificationCaptnLbl: Label 'VAT Amount Specification', comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', comment = 'FRA="Base TVA"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', comment = 'FRA="Escompte sur TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATPercentageCaptionLbl: Label 'VAT %', comment = 'FRA="% TVA"';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.', comment = 'FRA="N° id. intracomm."';
        CopyText: Text[30];
        SalesPersonText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(18) <> '';
    end;

    procedure InitializeRequest(ShowInternalInfoFrom: Boolean; LogInteractionFrom: Boolean)
    begin
        InitLogInteraction;
        ShowInternalInfo := ShowInternalInfoFrom;
        LogInteraction := LogInteractionFrom;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        WITH SalesHeader DO BEGIN
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FIELDCAPTION("VAT Registration No."));
        END;
    end;
}

