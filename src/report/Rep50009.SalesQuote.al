report 50009 "BC6_Sales Quote"
{
    Caption = 'Sales Quote', Comment = 'FRA="Devis vente"';
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './src/Report/RDL/SalesQuote.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote', Comment = 'FRA="Devis"';
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(RespCenter_Picture; RespCenter.BC6_Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
            {
            }
            column(RespCenter__Alt_Picture_; RespCenter."BC6_Alt Picture")
            {
            }
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
            column(Sales_Header__Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(Sales_Header__Sales_Header___Bill_to_Contact_; "Sales Header"."Sell-to Contact")
            {
            }
            column(FORMAT__Sales_Header___Order_Date__0_4_; FORMAT("Sales Header"."Order Date", 0, 4))
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
            {
            }
            column(Sales_Header__Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
            {
            }
            column(TexG_User_Name; TexG_User_Name)
            {
            }
            column(TxtGTag; TxtGTag)
            {
            }
            column(Text013__________Sales_Header___No__; Text013 + ' ' + "Sales Header"."No.")
            {
            }
            column(Sales_Header__Sales_Header___Prod__Version_No__; "Sales Header"."BC6_Prod. Version No.")
            {
            }
            column(TxtGAltAdress______TxtGAltAdress2_____STRSUBSTNO___1__2__TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO(txtlbl12, TxtGAltPostCode, TxtGAltCity))
            {
            }
            column(TxtGAltName; TxtGAltName)
            {
            }
            column(STRSUBSTNO_Text066_TxtGPhone_TxtGFax_TxtGEmail_; STRSUBSTNO(Text066, TxtGPhone, TxtGFax, TxtGEmail))
            {
            }
            column(STRSUBSTNO_Text066_TxtGAltPhone_TxtGAltFax_TxtGAltEmail_; STRSUBSTNO(Text066, TxtGAltPhone, TxtGAltFax, TxtGAltEmail))
            {
            }
            column(CompanyAddr_2______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO(txtlbl12, CompanyAddr[4], CompanyAddr[5]))
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(DataItem1000000076; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
            {
            }
            column(STRSUBSTNO_Text068_TxtGHomePage_; STRSUBSTNO(Text068, TxtGHomePage))
            {
            }
            column(STRSUBSTNO_Text068_TxtGAltHomePage_; STRSUBSTNO(Text068, TxtGAltHomePage))
            {
            }
            column(N__client___Caption; N__client___CaptionLbl)
            {
            }
            column(Sales_Header__Sales_Header___Bill_to_Contact_Caption; Sales_Header__Sales_Header___Bill_to_Contact_CaptionLbl)
            {
            }
            column(FORMAT__Sales_Header___Order_Date__0_4_Caption; FORMAT__Sales_Header___Order_Date__0_4_CaptionLbl)
            {
            }
            column(Sales_Header__Sales_Header___Your_Reference_Caption; Sales_Header__Sales_Header___Your_Reference_CaptionLbl)
            {
            }
            column(Interlocutor___Caption; Interlocutor___CaptionLbl)
            {
            }
            column(Sales_QuoteCaption; Sales_QuoteCaptionLbl)
            {
            }
            column(version_No____Caption; version_No____CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(ReferenceCaption; ReferenceCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Unit_Price_Incl__VATCaption; Unit_Price_Incl__VATCaptionLbl)
            {
            }
            column(Unit_Price_Excl__VATCaption; Unit_Price_Excl__VATCaptionLbl)
            {
            }
            column(Sales_Header_Prices_Incl_VAT; "Prices Including VAT")
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            column(TotalExclVATText_Control77; TotalExclVATText)
            {
            }
            column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
            {
            }
            column(AmountEco_ConributionCaption_Control1000000162; AmountEco_ConributionCaption_Control1000000162Lbl)
            {
            }
            column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
            {
            }
            column(Excl__VAT_Total_Incl_DEEECaption_Control1000000173; Excl__VAT_Total_Incl_DEEECaption_Control1000000173Lbl)
            {
            }
            column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
            {
            }
            column(VATAmountLine_VATAmountText_Control51; TempVATAmountLine.VATAmountText())
            {
            }
            column(TotalExclVATText; TotalExclVATText)
            {
            }
            column(TotalInclVATText_Control76; TotalInclVATText)
            {
            }
            column(PaymentMethod_Description___________PaymentTerms_DescriptionCaption; PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl)
            {
            }
            column(PaymentMethod_Description___________PaymentTerms_Description_Control1000000012Caption; PaymentMethod_Description___________PaymentTerms_Description_Control1000000012CaptionLbl)
            {
            }
            column(PaymentMethod_Description___________PaymentTerms_Description; PaymentMethod.Description + '  ' + PaymentTerms.Description)
            {
            }
            column(PaymentMethod_Description___________PaymentTerms_Description_Control1000000012; PaymentMethod.Description + '  ' + PaymentTerms.Description)
            {
            }
            column(HideReference; HideReference)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(VATAmount_Value; VATAmount)
                {
                }
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TxtGLblProjet; TxtGLblProjet)
                    {
                    }
                    column(TxtGNoProjet; TxtGNoProjet)
                    {
                    }
                    column(TxtGDesignation; TxtGDesignation)
                    {
                    }
                    column(Text011; Text011)
                    {
                    }
                    column(Text012; Text012)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Sales_Line___No__; "Sales Line"."No.")
                        {
                        }
                        column(Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line___No___Control62; "Sales Line"."No.")
                        {
                        }
                        column(Sales_Line__Description_Control63; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___Line_Amount_; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ROUND__Sales_Line___Discount_unit_price__; ROUND("Sales Line"."BC6_Discount unit price"))
                        {
                            DecimalPlaces = 2 : 0;
                        }
                        column(Sales_Line___No___Control1000000140; "Sales Line"."No.")
                        {
                        }
                        column(Sales_Line___DEEE_Category_Code_; "Sales Line"."BC6_DEEE Category Code")
                        {
                        }
                        column(ROUND__Sales_Line___DEEE_Unit_Price__; ROUND("Sales Line"."BC6_DEEE Unit Price"))
                        {
                            DecimalPlaces = 2 : 0;
                        }
                        column(Sales_Line__Quantity_Control1000000195; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___DEEE_HT_Amount_; "Sales Line"."BC6_DEEE HT Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount____VATAmount; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount" - VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT_SalesLine__DEEE_HT_Amount_; TotalAmountInclVAT + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount; VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount_; TempSalesLine.Amount + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__DEEE_HT_Amount_; TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount_Control90; VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount____VATAmount___DecGDEEEVatAmount; TempSalesLine.Amount + TempSalesLine."BC6_DEEE HT Amount" + VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__DEEE_HT_Amount__Control1000000172; TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount__Control1000000174; TempSalesLine.Amount + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(AmountCaption_Control1000000000; AmountCaption_Control1000000000Lbl)
                        {
                        }
                        column(QuantityCaption_Control1000000011; QuantityCaption_Control1000000011Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1000000018; DescriptionCaption_Control1000000018Lbl)
                        {
                        }
                        column(ReferenceCaption_Control1000000020; ReferenceCaption_Control1000000020Lbl)
                        {
                        }
                        column(DEEE_Contribution___Caption; DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Line___No___Control1000000140Caption; Sales_Line___No___Control1000000140CaptionLbl)
                        {
                        }
                        column(Sales_Line___DEEE_Category_Code_Caption; Sales_Line___DEEE_Category_Code_CaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(Format_Sales_Line_Type; FORMAT("Sales Line".Type, 0, 9))
                        {
                        }
                        column(Visible1; BooGVisible1)
                        {
                        }
                        column(TotalAmountInclVAT_value; TotalAmountInclVAT)
                        {
                        }
                        column(Sales_Line_DEEEHT_Amount; TempSalesLine."BC6_DEEE HT Amount")
                        {
                        }
                        column(Sales_Line_Inv_Disc_Amount; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(Sales_Line_Amount; TempSalesLine.Amount)
                        {
                        }
                        column(DecGDEEEVatAmount_Value; DecGDEEEVatAmount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT();
                            "Sales Line" := TempSalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempSalesLine."Line Amount" := 0;

                            IF (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line"."No." := '';

                            IF ((TempSalesLine."BC6_DEEE Category Code" <> '') AND (TempSalesLine.Quantity <> 0)
                            AND (TempSalesLine."BC6_Eco partner DEEE" <> '')) THEN
                                IF RecGItem.GET(TempSalesLine."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE";
                            IF BooGSubmittedToDEEE THEN
                                DecGDEEEVatAmount += TempSalesLine."BC6_DEEE VAT Amount"
                            ELSE
                                DecGDEEEVatAmount := 0;

                            DecGTTCTotalAmount += TempSalesLine."Amount Including VAT" + TempSalesLine."BC6_DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT TempRecGCalcul.GET('', TempSalesLine."BC6_DEEE Category Code", 0D)
                               THEN BEGIN
                                //création d'une ligne
                                TempRecGCalcul.INIT();
                                TempRecGCalcul."Eco Partner" := '';
                                TempRecGCalcul."DEEE Code" := TempSalesLine."BC6_DEEE Category Code";
                                TempRecGCalcul."Date beginning" := 0D;
                                TempRecGCalcul."HT Unit Tax (LCY)" := TempSalesLine."BC6_DEEE HT Amount";
                                TempRecGCalcul.INSERT();
                            END;
                            IF (BooGSubmittedToDEEE) AND (TempSalesLine."BC6_DEEE Category Code" <> '') AND (TempSalesLine.Quantity <> 0) AND
                               (TempSalesLine."BC6_Eco partner DEEE" <> '') THEN
                                BooGVisible1 := TRUE
                            ELSE
                                BooGVisible1 := FALSE;

                            vGTotal1 := VATAmount + DecGDEEEVatAmount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
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
                            CurrReport.CREATETOTALS(TempSalesLine."Line Amount", TempSalesLine.Amount, TempSalesLine."Amount Including VAT",
                            TempSalesLine."Inv. Discount Amount", TempSalesLine."BC6_DEEE HT Amount");
                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;

                            CLEAR(vGTotal1);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000079; TempVATAmountLine."Line Amount")
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000081; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083; TempVATAmountLine."Invoice Discount Amount")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000085; TempVATAmountLine."VAT Base")
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000087; TempVATAmountLine."VAT Amount")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000059; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000089; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000090; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000091; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000092; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000094; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000095; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000096; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000097; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000098; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000079Caption; VATAmountLine__Line_Amount__Control1000000079CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000081Caption; VATAmountLine__Inv__Disc__Base_Amount__Control1000000081CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083Caption; VATAmountLine__Invoice_Discount_Amount__Control1000000083CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000085Caption; VATAmountLine__VAT_Base__Control1000000085CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000087Caption; VATAmountLine__VAT_Amount__Control1000000087CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000091Caption; VATAmountLine__VAT_Base__Control1000000091CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000097Caption; VATAmountLine__VAT_Base__Control1000000097CaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();

                            IF TempVATAmountLine.COUNT < 2 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
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
                        column(VATAmountLine__VAT_Identifier__Control1000000119; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT____Control1000000121; TempVATAmountLine."VAT %")
                        {
                        }
                        column(VALVATBaseLCY_Control1000000123; VALVATBaseLCY)
                        {
                        }
                        column(VALVATAmountLCY_Control1000000125; VALVATAmountLCY)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000114; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000115; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000117; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000118; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier__Control1000000119Caption; VATAmountLine__VAT_Identifier__Control1000000119CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control1000000121Caption; VATAmountLine__VAT____Control1000000121CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000123Caption; VALVATBaseLCY_Control1000000123CaptionLbl)
                        {
                        }
                        column(VALVATAmountLCY_Control1000000125Caption; VALVATAmountLCY_Control1000000125CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000114Caption; VALVATBaseLCY_Control1000000114CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000117Caption; VALVATBaseLCY_Control1000000117CaptionLbl)
                        {
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                               TempVATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                                 TempVATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0) THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text008 + Text009
                            ELSE
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text010, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(vGTotal1_Value; vGTotal1)
                        {
                        }
                        column(Text015; Text015)
                        {
                        }
                        column(Text016; Text016)
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
                        IF "Sales Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Sales Header"."BC6_Affair No.";
                            RecGJob.GET("Sales Header"."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    TempSalesLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN("Sales Header");
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
                "Sell-to Country": Text[50];
            begin
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");
                "Sales Header".CALCFIELDS("Sales Header"."No. of Archived Versions");
                IF BoolGRespCenter THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

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
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT()
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                RecG_User.RESET();
                RecG_User.SETRANGE("User Name", BC6_ID);
                IF RecG_User.FINDFIRST() THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");
                IF Country.GET("Sales Header"."Sell-to Country/Region Code") THEN
                    "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF (ShipToAddr[i] <> CustAddr[i]) AND (ShipToAddr[i] <> '') AND (ShipToAddr[i] <> "Sell-to Country") THEN
                        ShowShippingAddr := TRUE;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;
                "Sales Header".MARK(TRUE);

                IF "Sales Header"."Bill-to Customer No." <> '' THEN BEGIN
                    RecGBillCustomer.RESET();
                    RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.");
                    BooGSubmittedToDEEE := RecGBillCustomer."BC6_Submitted to DEEE";
                END ELSE BEGIN
                    RecGCustomerTemplate.RESET();
                    IF RecGCustomerTemplate.GET("Sales Header"."Sell-to Customer Templ. Code") THEN
                        BooGSubmittedToDEEE := RecGCustomerTemplate."BC6_Submitted to DEEE"
                    ELSE
                        BooGSubmittedToDEEE := FALSE;
                END;
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;

                IF BoolGRespCenter THEN BEGIN
                    TxtGPhone := RespCenter."Phone No.";
                    TxtGFax := RespCenter."Fax No.";
                    TxtGEmail := RespCenter."E-Mail";
                    TxtGHomePage := RespCenter."Home Page";
                    TxtGAltName := RespCenter."BC6_Alt Name";
                    TxtGAltAdress := RespCenter."BC6_Alt Address";
                    TxtGAltAdress2 := RespCenter."BC6_Alt Address 2";
                    TxtGAltPostCode := RespCenter."BC6_Alt Post Code";
                    TxtGAltCity := RespCenter."BC6_Alt City";
                    TxtGAltPhone := RespCenter."BC6_Alt Phone No.";
                    TxtGAltFax := RespCenter."BC6_Alt Fax No.";
                    TxtGAltEmail := RespCenter."BC6_Alt E-Mail";
                    TxtGAltHomePage := RespCenter."BC6_Alt Home Page";
                END ELSE BEGIN
                    TxtGPhone := CompanyInfo."Phone No.";
                    TxtGFax := CompanyInfo."Fax No.";
                    TxtGEmail := CompanyInfo."E-Mail";
                    TxtGHomePage := CompanyInfo."Home Page";
                    TxtGAltName := CompanyInfo."BC6_Alt Name";
                    TxtGAltAdress := CompanyInfo."BC6_Alt Address";
                    TxtGAltAdress2 := CompanyInfo."BC6_Alt Address 2";
                    TxtGAltPostCode := CompanyInfo."BC6_Alt Post Code";
                    TxtGAltCity := CompanyInfo."BC6_Alt City";
                    TxtGAltPhone := CompanyInfo."BC6_Alt Phone No.";
                    TxtGAltFax := CompanyInfo."BC6_Alt Fax No.";
                    TxtGAltEmail := CompanyInfo."BC6_Alt E-Mail";
                    TxtGAltHomePage := CompanyInfo."BC6_Alt Home Page";
                END;
                DecGDEEEVatAmount := 0;
            end;
        }
    }

    requestpage
    {
        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(NoOfCopiesF; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfoF; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteractionF; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(CodGRespCenterF; CodGRespCenter)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Characteristics Agency:', Comment = 'FRA="Imprimer Caractéristiques Agence:"';
                        TableRelation = "Responsibility Center";
                    }
                    field(HideReferenceF; HideReference)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Reference', Comment = 'FRA="Masquer références"';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule();
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';
            LogInteractionEnable := LogInteraction;

            CLEAR(CodGRespCenter);
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
    end;

    trigger OnPreReport()
    begin

        IF RespCenter.GET(CodGRespCenter) THEN
            BoolGRespCenter := TRUE
        ELSE
            BoolGRespCenter := FALSE;

        IF BoolGRespCenter THEN
            RespCenter.CALCFIELDS(BC6_Picture, "BC6_Alt Picture")
        ELSE
            CompanyInfo.CALCFIELDS(Picture, "BC6_Alt Picture");
    end;

    var
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        TempRecGCalcul: Record "BC6_DEEE Tariffs" temporary;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        RecGBillCustomer: Record Customer;
        RecGCustomer: Record Customer;
        RecGCustomerTemplate: Record "Customer Template";
        GLSetup: Record "General Ledger Setup";
        RecGItem: Record Item;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        RecGSalesHeader: Record "Sales Header";
        RecGSalesInvLine: Record "Sales Invoice Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        RecG_User: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BooGDEEEFind: Boolean;
        BooGSubmittedToDEEE: Boolean;
        BooGVisible1: Boolean;
        BoolGRespCenter: Boolean;
        Continue: Boolean;
        HideReference: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        CodGRespCenter: Code[10];
        DecGDEEEVatAmount: Decimal;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGTTCTotalAmount: Decimal;
        DecGVATTotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        vGTotal1: Decimal;
        "--CNE3.02--": Integer;
        "-DEEE1.00-": Integer;
        "--FEP-ADVE-200706_18_A--": Integer;
        "--FG--": Integer;
        i: Integer;
        "-MICO-": Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NoOfRecords: Integer;
        OutputNo: Integer;
        AmountCaption_Control1000000000Lbl: Label 'Amount', Comment = 'FRA="Montant"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        AmountEco_ConributionCaption_Control1000000162Lbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        DescriptionCaption_Control1000000018Lbl: Label 'Description', Comment = 'FRA="Désignation"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000173Lbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        FORMAT__Sales_Header___Order_Date__0_4_CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ', Comment = 'FRA="Interlocuteur : "';
        N__client___CaptionLbl: Label 'N° client : ', Comment = 'FRA="N° client : "';
        PaymentMethod_Description___________PaymentTerms_Description_Control1000000012CaptionLbl: Label 'Payment Method:', Comment = 'FRA="Mode de réglement :"';
        PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method:', Comment = 'FRA="Mode de réglement :"';
        QuantityCaption_Control1000000011Lbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ReferenceCaption_Control1000000020Lbl: Label 'Reference', Comment = 'FRA="Réference"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Réference"';
        Sales_Header__Sales_Header___Bill_to_Contact_CaptionLbl: Label 'WITH ATTENTION OF: ', Comment = 'FRA="A L''ATTENTION DE : "';
        Sales_Header__Sales_Header___Your_Reference_CaptionLbl: Label 'Y/REF: ', Comment = 'FRA="V/REF : "';
        Sales_Line___DEEE_Category_Code_CaptionLbl: Label 'Category :', Comment = 'FRA="Catégorie :"';
        Sales_Line___No___Control1000000140CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        Sales_QuoteCaptionLbl: Label 'Sales Quote', Comment = 'FRA="Devis ventes"';
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Quote %1', Comment = 'FRA="Ventes : Devis %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'Do you want to create a follow-up to-do?', Comment = 'FRA="Voulez-vous créer une action de suivi ?"';
        Text008: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text009: Label 'Local Currency', Comment = 'FRA="Devise locale"';
        Text010: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text011: Label 'Following your request, we are please to communicate bellow ours  best offers price', Comment = 'FRA="Suite à votre demande, nous avons le plaisir de vous communiquer ci dessous notre meilleure offre de prix."';
        Text012: Label 'For all further information, do not hesitate to contact us', Comment = 'FRA="Pour tous renseignements complémentaires, n''hésitez pas à nous contacter."';
        Text013: Label 'No. ', Comment = 'FRA="N° "';
        Text014: Label 'duplicate', Comment = 'FRA="duplicata"';
        Text015: Label 'Thank you to return us this signed quote: GOOD FOR AGREEMENT.', Comment = 'FRA="Merci de nous renvoyer ce devis signé : BON POUR ACCORD."';
        Text016: Label ' with capital of ', Comment = 'FRA="Validité de cette offre : 1 mois."';
        Text018: Label ' -EP ', Comment = 'FRA=" -APE "';
        Text019: Label ' -VAT Registration ', Comment = 'FRA=" -N° TVA "';
        Text020: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 AU CAPITAL DE %2  · %3  · SIRET %4 ·  APE %5 · TVA %6"';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text068: Label '%1', Comment = 'FRA="%1"';
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        txtlbl12: label '%1 %2';
        Unit_Price_Excl__VATCaptionLbl: Label 'Unit Price Excl. VAT', Comment = 'FRA="P. U. Net HT"';
        Unit_Price_Incl__VATCaptionLbl: Label 'Unit Price Incl. VAT', Comment = 'FRA="P. U. Net TTC"';
        VALVATAmountLCY_Control1000000125CaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VALVATBaseLCY_Control1000000114CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCY_Control1000000117CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VALVATBaseLCY_Control1000000123CaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VALVATBaseLCYCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail TVA"';
        VATAmountLine__Inv__Disc__Base_Amount__Control1000000081CaptionLbl: Label 'Inv. Disc. Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmountLine__Invoice_Discount_Amount__Control1000000083CaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        VATAmountLine__Line_Amount__Control1000000079CaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmountLine__VAT____Control1000000121CaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmountLine__VAT_Amount__Control1000000087CaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmountLine__VAT_Base__Control1000000085CaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmountLine__VAT_Base__Control1000000091CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base__Control1000000097CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Identifier__Control1000000119CaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        version_No____CaptionLbl: Label 'version No. : ', Comment = 'FRA="N° version : "';
        TxtGAltFax: Text[20];
        TxtGAltPhone: Text[20];
        TxtGAltPostCode: Text[20];
        TxtGFax: Text[20];
        TxtGPhone: Text[20];
        CopyText: Text[30];
        ReferenceText: Text[30];
        SalesPersonText: Text[30];
        TexG_User_Name: Text[30];
        TxtGAltCity: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        VATNoText: Text[30];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltName: Text[50];
        TxtGDesignation: Text[50];
        TxtGTag: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[80];
        VALSpecLCYHeader: Text[80];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        DimText: Text[120];

    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15,02,2007
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;
}
