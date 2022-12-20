report 50061 "BC6_Purchase Ret. Order - SAV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PurchaseReturnOrderSAV.rdl';
    Caption = 'Return Order', comment = 'FRA="Retour"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Return Order', comment = 'FRA="Retour achat"';
            column(No_PurchHdr; "No.")
            {
            }
            column(DiscPercentCaption; DiscPercentCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(VATIdentifierCaption1; VATIdentifierCaption1Lbl)
            {
            }
            column(VATPctCaption; VATPctCaptionLbl)
            {
            }
            column(VATBaseCaption2; VATBaseCaption2Lbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(TotalCaption1; TotalCaption1Lbl)
            {
            }
            column(CstSAVReturnOrder; CstSAVReturnOrder)
            {
            }
            column(CstCNEDetails; CstCNEDetails)
            {
            }
            column(SalesReturnOrder; G_ReturnOrderRelation."Sales Return Order")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                    {
                    }
                    column(AmtCaption; AmtCaptionLbl)
                    {
                    }
                    column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(VATDiscAmtCaption; VATDiscAmtCaptionLbl)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(ReturnOrderCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column("UserId"; PurchaseHeader.ID)
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
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocumentDate_PurchHdr; FORMAT(PurchaseHeader."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHdr; PurchaseHeader."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchHdr; PurchaseHeader."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(yourReference_PurchHdr; PurchaseHeader."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyfromVendNo_PurchHdr; PurchaseHeader."Buy-from Vendor Name")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(PricesIncVAT_PurchHdr; PurchaseHeader."Prices Including VAT")
                    {
                    }
                    column(PrsInclVATYesNo_PurchHdr; FORMAT(PurchaseHeader."Prices Including VAT"))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
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
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ReturnOrderNoCaption; ReturnOrderNoCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(BuyfromVendNo_PurchHdrCaption; BillToVendorNameCaption)
                    {
                    }
                    column(PricesIncVAT_PurchHdrCaption; PurchaseHeader.FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture)
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
                    column(SerialNoCaption; SerialNoCaptionLbl)
                    {
                    }
                    column(ReturnCommentCaption; ReturnCommentCaptionLbl)
                    {
                    }
                    column(CrMemoCaption; CrMemoCaptionLbl)
                    {
                    }
                    column(ShareCapital; ShareCapitalLbl)
                    {
                    }
                    column(TVANoCaption; TVANoCaptionLbl)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoFax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CstSocialReason; CstSocialReason)
                    {
                    }
                    column(CstInterlocutor; CstInterlocutor)
                    {
                    }
                    column(PrimaryContact_Vendor; G_Vendor."Primary Contact No.")
                    {
                    }
                    column(OurAccoutNo_Vendor; G_Vendor."Our Account No.")
                    {
                    }
                    column(CstSeat; CstSeat)
                    {
                    }
                    column(PurchOrderNoCaption; PurchOrderNoCaptionLbl)
                    {
                    }
                    column(PurchReturnNoCaption; PurchReturnNoCaptionLbl)
                    {
                    }
                    column(SalesReturnNoCaption; SalesReturnNoCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = PurchaseHeader;
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
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
                    dataitem(PurchaseLine; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = PurchaseHeader;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnAfterGetRecord()
                        begin

                            UserSetup.GET(PurchaseHeader.ID);
                        end;

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
                        column(LineAmt_PurchLine; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = PurchaseLine."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description_PurchLine; PurchaseLine.Description)
                        {
                        }
                        column(Description_PurchLineCaption; PurchaseLine.FIELDCAPTION(Description))
                        {
                        }
                        column(No_PurchLine; PurchaseLine."No.")
                        {
                        }
                        column(No_PurchLineCaption; PurchaseLine.FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_PurchLine; PurchaseLine.Quantity)
                        {
                        }
                        column(Quantity_PurchLineCaption; PurchaseLine.FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_PurchLine; PurchaseLine."Unit of Measure")
                        {
                        }
                        column(UnitofMeasure_PurchLineCaption; PurchaseLine.FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(DirectUnitCost_PurchLine; PurchaseLine."Direct Unit Cost")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_PurchLine; PurchaseLine."Line Discount %")
                        {
                        }
                        column(AllowInvDisc_PurchLine; PurchaseLine."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_PurchLine; PurchaseLine."VAT Identifier")
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; PurchaseLine.FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(AllInvDiscYesNo_PurchLine; FORMAT(PurchaseLine."Allow Invoice Disc."))
                        {
                        }
                        column(PurchLineInvDiscountAmt; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = PurchaseLine."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineLnAmtInvDiscAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmt; VATAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLnLnAmtInvDiscAmtVATAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmt; -VATDiscountAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_PurchHdr; PurchaseHeader."VAT Base Discount %")
                        {
                        }
                        column(VATBaseAmt; VATBaseAmount)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLineCaption; PurchaseLine.FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(ReturnComment_PurchaseLine; PurchaseLine."BC6_Return Comment")
                        {
                        }
                        column(SerialNo_Item; PurchaseLine."BC6_Series No.")
                        {
                        }
                        column(SolutionCode_PurchaseLine; PurchaseLine."BC6_Solution Code")
                        {
                        }
                        column(PurchOrderNo_PurchaseLine; PurchaseLine."BC6_Retrn. Sales OrderShpt" + G_PurchaseHeader."No.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(DimensionLoop2Number; Number)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT;
                            PurchaseLine := PurchLine;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                PurchaseLine."No." := '';

                            TypeInt := PurchaseLine.Type;
                            TotalSubTotal += PurchaseLine."Line Amount";
                            TotalInvoiceDiscountAmount -= PurchaseLine."Inv. Discount Amount";
                            TotalAmount += PurchaseLine.Amount;

                            IF (PurchLine.Type = PurchLine.Type::Item) AND (PurchLine."No." <> '') THEN
                                G_Item.GET(PurchLine."No.");
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0)
                            DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = PurchaseHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
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
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDisAmtCaption; InvDisAmtCaptionLbl)
                        {
                        }
                        column(VATBaseCaption1; VATBaseCaption1Lbl)
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
                        column(VALSpecLCYHdr; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                  VATAmountLine."VAT Base", PurchaseHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                  VATAmountLine."VAT Amount", PurchaseHeader."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (PurchaseHeader."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(PurchaseHeader."Posting Date", PurchaseHeader."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF PurchaseHeader."Buy-from Vendor No." = PurchaseHeader."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines(PurchaseHeader, PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, PurchaseHeader, PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, PurchaseHeader, PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(PurchaseHeader."Currency Code", PurchaseHeader."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch.Header-Printed", PurchaseHeader);
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
                L_PurchaseLine: Record "Purchase Line";
                L_SalesHeader: Record "Sales Header";
            begin
                //TODO CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language2.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields(PurchaseHeader);
                FormatDocumentFields(PurchaseHeader);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Buy-from Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, DATABASE::Contact, "Buy-from Contact No.", "Purchaser Code", '', "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '')
                    END;

                IF G_Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN;
                L_PurchaseLine.RESET;
                L_PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                L_PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                L_PurchaseLine.SETRANGE(Type, L_PurchaseLine.Type::Item);
                IF L_PurchaseLine.FINDFIRST THEN
                    IF L_SalesHeader.GET(L_SalesHeader."Document Type"::Order, L_PurchaseLine."BC6_Retrn. Sales OrderShpt") THEN //TODO: à Vérifier
                        IF G_PurchaseHeader.GET(G_PurchaseHeader."Document Type"::Order, L_SalesHeader."BC6_Purchase No. Order Lien") THEN;

                G_ReturnOrderRelation.RESET;
                G_ReturnOrderRelation.SETRANGE("Purchase Return Order", PurchaseHeader."No.");
                IF G_ReturnOrderRelation.FINDFIRST THEN;
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
            LogInteraction := SegManagement.FindInteractTmplCode(22) <> '';
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

        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        G_ReturnOrderRelation: Record "BC6_Return Order Relation";
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        G_Item: Record Item;
        Language: Record Language;
        G_PurchaseHeader: Record "Purchase Header";
        UserID: Record "Purchase Header";
        PurchLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        G_Vendor: Record Vendor;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        Language2: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        TypeInt: Integer;
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount', comment = 'FRA="Autoriser remise facture"';
        AmtCaptionLbl: Label 'Amount', comment = 'FRA="Montant"';
        BankAccNoCaptionLbl: Label 'Account No.', comment = 'FRA="N° compte"';
        BankNameCaptionLbl: Label 'Bank', comment = 'FRA="Banque"';
        BillToVendorNameCaption: Label 'Vendor', comment = 'FRA="Fournisseur"';
        CrMemoCaptionLbl: Label 'Cr. Memo or Exchange?', comment = 'FRA="Avoir ou échange?"';
        CstCNEDetails: Label 'Distributor of Electrical Equipment', comment = 'FRA="Distributeur matériel éléctrique"';
        CstInterlocutor: Label 'Interlocutor', comment = 'FRA="Code utilisateur"';
        CstSAVReturnOrder: Label 'SAV Return Order', comment = 'FRA="Retour SAV"';
        CstSeat: Label 'Seat :', comment = 'FRA="Siége :"';
        CstSocialReason: Label 'Social Reason', comment = 'FRA="Fournisseur"';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost', comment = 'FRA="Coût unitaire direct"';
        DiscPercentCaptionLbl: Label 'Discount %', comment = 'FRA="% remise"';
        DocumentDateCaptionLbl: Label 'Document Date', comment = 'FRA="Date document"';
        EmailCaptionLbl: Label 'Email', comment = 'FRA="E-mail"';
        FaxNoCaptionLbl: Label 'Fax No.', comment = 'FRA="Fax."';
        GiroNoCaptionLbl: Label 'Giro No.', comment = 'FRA="N° CCP"';
        HdrDimsCaptionLbl: Label 'Header Dimensions', comment = 'FRA="Analytique en-téte"';
        HomePageCaptionLbl: Label 'Home Page', comment = 'FRA="Page d''accueil"';
        InvDisAmtCaptionLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount', comment = 'FRA="Montant ligne"';
        LineDimsCaptionLbl: Label 'Line Dimensions', comment = 'FRA="Analytique ligne"';
        PhoneNoCaptionLbl: Label 'Phone No.', comment = 'FRA="Tel."';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        PurchOrderNoCaptionLbl: Label 'Purchase Order No.', comment = 'FRA="N° commande d''achat "';
        PurchReturnNoCaptionLbl: Label 'Purchase Return Order No.', comment = 'FRA="N° retour achat"';
        ReturnCommentCaptionLbl: Label 'BreakdownDescription', comment = 'FRA="Description panne"';
        ReturnOrderNoCaptionLbl: Label 'Return Order No. :', comment = 'FRA="N° retour vente :"';
        SalesReturnNoCaptionLbl: Label 'Sales Return Order No.', comment = 'FRA="N° retour vente"';
        SerialNoCaptionLbl: Label 'Serial No.', comment = 'FRA="N° de série"';
        ShareCapitalLbl: Label 'With the Share Capital of', comment = 'FRA="au capital social de"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', comment = 'FRA="Sous-total"';
        Text004: Label 'Return Order %1', Comment = '%1 = Document No.';
        Text005: Label 'Page %1';
        Text007: Label 'VAT Amount Specification in ', comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', comment = 'FRA="Taux de change : %1/%2"';
        TotalCaption1Lbl: Label 'Total', comment = 'FRA="Total"';
        TVANoCaptionLbl: Label 'TVA No :', comment = 'FRA="n° TVA:"';
        VATAmountCaptionLbl: Label 'VAT Amount', comment = 'FRA="Montant TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', comment = 'FRA="Détail montant TVA"';
        VATBaseCaption1Lbl: Label 'Total', comment = 'FRA="Total"';
        VATBaseCaption2Lbl: Label 'VAT Base', comment = 'FRA="Base TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', comment = 'FRA="Base TVA"';
        VATDiscAmtCaptionLbl: Label 'Payment Discount on VAT', comment = 'FRA="Escompte sur TVA"';
        VATIdentifierCaption1Lbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATPctCaptionLbl: Label 'VAT %', comment = 'FRA="% TVA"';
        VATPercentCaptionLbl: Label 'VAT %', comment = 'FRA="% TVA"';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.', comment = 'FRA="N° id. intracomm."';
        CopyText: Text[30];
        PurchaserText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        IF PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." THEN
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        WITH PurchaseHeader DO BEGIN
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetPurchaser(SalesPurchPerson, "Purchaser Code", PurchaserText);

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FIELDCAPTION("VAT Registration No."));
        END;
    end;
}

