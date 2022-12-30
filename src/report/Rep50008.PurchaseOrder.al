report 50008 "BC6_Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PurchaseOrder.rdl';
    Caption = 'Purchase Order', Comment = 'FRA="Commande achat"';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {

            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(RespCenter_Picture; RespCenter.BC6_Picture)
            {
            }
            column(RespCenter__Alt_Picture_; RespCenter."BC6_Alt Picture")
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
            {
            }
            column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
            {
            }
            column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(BoolGRespCenter; BoolGRespCenter)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(Text010_________CompanyInfo__Fax_No__; Text010 + CompanyInfo."BC6_Purchaser E-Mail")
                {
                }
                column(TxtGNoProjet; TxtGNoProjet)
                {
                }
                column(TxtGLblProjet; TxtGLblProjet)
                {
                }
                column(TxtGDesignation; TxtGDesignation)
                {
                }
                column(Text011; Text011)
                {
                }
                column(Purchase_Header___Ship_to_Name_; "Purchase Header"."Ship-to Name")
                {
                }
                column(Purchase_Header___Ship_to_Address_; "Purchase Header"."Ship-to Address")
                {
                }
                column(Purchase_Header___Ship_to_Address_2_; "Purchase Header"."Ship-to Address 2")
                {
                }
                column(Purchase_Header___Ship_to_Post_Code_; "Purchase Header"."Ship-to Post Code")
                {
                }
                column(Purchase_Header___Ship_to_City_; "Purchase Header"."Ship-to City")
                {
                }
                column(Purchase_Header___Ship_to_Contact_; "Purchase Header"."Ship-to Contact")
                {
                }
                column(ReferenceCaption_Control1000000017; ReferenceCaption_Control1000000017Lbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Planned_Receipt_DateCaption; Planned_Receipt_DateCaptionLbl)
                {
                }
                column(ReferenceCaption_Control39; ReferenceCaption_Control39Lbl)
                {
                }
                column(DescriptionCaption_Control40; DescriptionCaption_Control40Lbl)
                {
                }
                column(Purchase_Line__QuantityCaption; "Purchase Line".FIELDCAPTION(Quantity))
                {
                }
                column(Unit_PriceCaption_Control43; Unit_PriceCaption_Control43Lbl)
                {
                }
                column(AmountCaption_Control45; AmountCaption_Control45Lbl)
                {
                }
                column("Date_de_réception_demandéeCaption"; Date_de_réception_demandéeCaptionLbl)
                {
                }
                column(DEEE_Contribution___Caption; DEEE_Contribution___CaptionLbl)
                {
                }
                column(Purchase_Line___No___Control1000000165Caption; Purchase_Line___No___Control1000000165CaptionLbl)
                {
                }
                column(Purchase_Line___DEEE_Category_Code_Caption; Purchase_Line___DEEE_Category_Code_CaptionLbl)
                {
                }
                column(TVACaption; TVACaptionLbl)
                {
                }
                column(Base_TVACaption; Base_TVACaptionLbl)
                {
                }
                column(Montant_TVACaption; Montant_TVACaptionLbl)
                {
                }
                column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                {
                }
                column(Montant_base_remise_factureCaption; Montant_base_remise_factureCaptionLbl)
                {
                }
                column(Montant_ligneCaption; Montant_ligneCaptionLbl)
                {
                }
                column(Montant_remise_factureCaption; Montant_remise_factureCaptionLbl)
                {
                }
                column(Identifiant_TVACaption; Identifiant_TVACaptionLbl)
                {
                }
                column(ReportCaption; ReportCaptionLbl)
                {
                }
                column(ReportCaption_Control1000000105; ReportCaption_Control1000000105Lbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(BooGVisibleVAT; BooGVisibleVAT)
                {
                }
                column(VATAmount; VATAmount)
                {
                }
                column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
                {
                }
                column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
                {
                }
                column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                dataitem("PageLoop"""; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(Text012__________Purchase_Header___No__; Text012 + ' ' + "Purchase Header"."No.")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr_1_; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr_2_; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr_3_; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_4_; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_5_; BuyFromAddr[5])
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(TEL_______recLBuyVendor__Phone_No__; 'TEL : ' + recLBuyVendor."Phone No.")
                    {
                    }
                    column(FAX______recLBuyVendor__Fax_No__; 'FAX : ' + recLBuyVendor."Fax No.")
                    {
                    }
                    column(TexG_User_Name; TexG_User_Name)
                    {
                    }
                    column(Purchase_Header___Your_Reference_; "Purchase Header"."Your Reference")
                    {
                    }
                    column(TxtGTag; TxtGTag)
                    {
                    }
                    column(STRSUBSTNO_Text066_TxtGPhone_TxtGFax_TxtGEmail_; STRSUBSTNO(Text066, TxtGPhone, TxtGFax, TxtGEmail))
                    {
                    }
                    column(CompanyAddr_2_______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO(txtlbl12, CompanyAddr[4], CompanyAddr[5]))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(DataItem1000000037; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(TxtGAltName; TxtGAltName)
                    {
                    }
                    column(TxtGHomePage; TxtGHomePage)
                    {
                    }
                    column(TxtGAltAdress______TxtGAltAdress2_____STRSUBSTNO___1__2__TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO(txtlbl12, TxtGAltPostCode, TxtGAltCity))
                    {
                    }
                    column(STRSUBSTNO_Text066_TxtGAltPhone_TxtGAltFax_TxtGAltEmail_; STRSUBSTNO(Text066, TxtGAltPhone, TxtGAltFax, TxtGAltEmail))
                    {
                    }
                    column(STRSUBSTNO_Text068_TxtGAltHomePage_; STRSUBSTNO(Text068, TxtGAltHomePage))
                    {
                    }
                    column(Purchase_OrderCaption; Purchase_OrderCaptionLbl)
                    {
                    }
                    column(Vendor_No___Caption; Vendor_No___CaptionLbl)
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_Caption; FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl)
                    {
                    }
                    column(Interlocutor___Caption; Interlocutor___CaptionLbl)
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(Purchase_Header_Location_Code; "Purchase Header"."Location Code")
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Description_Control63; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Discount_Direct_Unit_Cost_; "Purchase Line"."BC6_Discount Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Planned_Receipt_Date_; TempPurchLine."Planned Receipt Date")
                        {
                        }
                        column(Purchase_Line___DEEE_Category_Code_; "Purchase Line"."BC6_DEEE Category Code")
                        {
                        }
                        column(Purchase_Line__Quantity_Control1000000169; "Purchase Line".Quantity)
                        {
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                        }
                        column(Purchase_Line___DEEE_Amount__LCY__for_Stat_; "Purchase Line"."BC6_DEEE Amount (LCY) for Stat")
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(BooGIncVAT; BooGIncVAT)
                        {
                        }
                        column(Purchase_Line_Type; FORMAT("Purchase Line".Type, 0, 9))
                        {
                        }
                        column(BooGPostingDEEE; BooGPostingDEEE)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVATDEE; TotalAmountInclVATDEE)
                        {
                        }
                        column(TotalDEEEHTAmount; TotalDEEEHTAmount)
                        {
                        }
                        column(TotalAmtHTDEEE; TotalAmtHTDEEE)
                        {
                        }
                        column(TotalAmountVATDEE; TotalAmountVATDEE)
                        {
                        }
                        column(TotalAmountVATBase; TotalAmountVATBase)
                        {
                        }
                        column(TotalAmountInclVATDEE2; TotalAmountInclVATDEE2)
                        {
                        }
                        column(TotalAmountTTC; TotalAmountTTC)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            BooGIncVAT := "Purchase Header"."Prices Including VAT";

                            IF Number = 1 THEN
                                TempPurchLine.FIND('-')
                            ELSE
                                TempPurchLine.NEXT();
                            "Purchase Line" := TempPurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (TempPurchLine."VAT Calculation Type" = TempPurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempPurchLine."Line Amount" := 0;

                            IF (TempPurchLine.Type = TempPurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';

                            //<<FE005:DARI 20/02/2007
                            IF (("Purchase Line"."BC6_DEEE Category Code" <> '') AND ("Purchase Line".Quantity <> 0)
                            AND ("Purchase Line"."BC6_Eco partner DEEE" <> '')) THEN BEGIN

                                IF RecGItem.GET("Purchase Line"."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;

                                RecGDEEE.RESET();
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", TempPurchLine."BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Purchase Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;

                                //>>COMPTA_DEEE FG 01/03/07
                                DecGHTUnitTaxLCY := "Purchase Line"."BC6_DEEE Unit Price (LCY)";
                                //<<COMPTA_DEEE FG 01/03/07
                            END;
                            //FG

                            //>> MODIF HL 15/05/2012 SU-LALE cf appel TI099639
                            TempVATAmountLine."VAT %" := 0;
                            TempVATAmountLine."VAT Base" := 0;
                            TempVATAmountLine."Amount Including VAT" := 0;
                            TempVATAmountLine."Line Amount" := 0;
                            TempVATAmountLine."Inv. Disc. Base Amount" := 0;
                            TempVATAmountLine."Invoice Discount Amount" := 0;
                            //<< MODIF HL 15/05/2012 SU-LALE cf appel TI099639

                            TempVATAmountLine."BC6_DEEE HT Amount" := "Purchase Line"."BC6_DEEE HT Amount";
                            TempVATAmountLine."BC6_DEEE VAT Amount" := "Purchase Line"."BC6_DEEE VAT Amount";
                            TempVATAmountLine.InsertLine();

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";
                            DecGTTCTotalAmount += "Purchase Line"."Amount Including VAT" + "Purchase Line"."BC6_DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT TempRecGCalcul.GET('', "Purchase Line"."BC6_DEEE Category Code", 0D)
                               THEN BEGIN
                                //création d'une ligne
                                TempRecGCalcul.INIT();
                                TempRecGCalcul."Eco Partner" := '';
                                TempRecGCalcul."DEEE Code" := "Purchase Line"."BC6_DEEE Category Code";
                                TempRecGCalcul."Date beginning" := 0D;
                                TempRecGCalcul."HT Unit Tax (LCY)" := "Purchase Line"."BC6_DEEE HT Amount";
                                TempRecGCalcul.INSERT();
                            END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            //>>COMPTA_DEEE DARI 17/04/07
                            IF NOT RecGPayVendor."BC6_Posting DEEE" THEN BEGIN
                                TempPurchLine."BC6_DEEE HT Amount" := 0;
                                TempPurchLine."BC6_DEEE VAT Amount" := 0;
                            END;
                            //<<COMPTA_DEEE DARI 17/04/07

                            TotalAmountVATDEE += TempPurchLine."Amount Including VAT" - TempPurchLine.Amount + TempPurchLine."BC6_DEEE VAT Amount";
                            TotalAmtHTDEEE += TempPurchLine.Amount + TempPurchLine."BC6_DEEE HT Amount";
                            TotalDEEEHTAmount += TempPurchLine."BC6_DEEE HT Amount";
                            TotalAmountVATBase += VATBaseAmount;

                            TotalAmountInclVATDEE2 += TempPurchLine.Amount - TempPurchLine."Inv. Discount Amount";
                            TotalAmountTTC += -TempPurchLine."Inv. Discount Amount" +
                                                        TempPurchLine."Amount Including VAT" +
                                                        TempPurchLine."BC6_DEEE HT Amount" + TempPurchLine."BC6_DEEE VAT Amount";
                            //<<MIGRATION NAV 2013


                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGPayVendor."BC6_Posting DEEE" THEN BEGIN
                                BooGPostingDEEE := (("Purchase Line"."BC6_DEEE Category Code" <> '') AND
                                                        ("Purchase Line".Quantity <> 0) AND
                                                          ("Purchase Line"."BC6_Eco partner DEEE" <> ''));
                            END ELSE BEGIN
                                BooGPostingDEEE := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchLine.FIND('+');
                            WHILE MoreLines AND (TempPurchLine.Description = '') AND (TempPurchLine."Description 2" = '') AND
                                  (TempPurchLine."No." = '') AND (TempPurchLine.Quantity = 0) AND
                                  (TempPurchLine.Amount = 0) DO
                                MoreLines := TempPurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempPurchLine.SETRANGE("Line No.", 0, TempPurchLine."Line No.");
                            SETRANGE(Number, 1, TempPurchLine.COUNT);

                            //>>FE005:DARI 20/02/2007
                            //CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                            CurrReport.CREATETOTALS(TempPurchLine."Line Amount", TempPurchLine.Amount, TempPurchLine."Amount Including VAT",

                            //>>DARI 17/04/07
                            //PurchLine."Inv. Discount Amount", PurchLine."DEEE HT Amount");
                            TempPurchLine."Inv. Discount Amount", TempPurchLine."BC6_DEEE HT Amount", TempPurchLine."BC6_DEEE VAT Amount");
                            //>>DARI 17/04/07

                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 20/02/2007
                        end;
                    }
                    dataitem(DataItem5444; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1));
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Integer_Number; Number)
                        {
                        }
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000099; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000100; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000102; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000103; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000104; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000106; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000107; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000108; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000109; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000110; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000079; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000080; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000081; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000082; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
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
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              //FG
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount",
                              //VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                              TempVATAmountLine."BC6_DEEE HT Amount", TempVATAmountLine."BC6_DEEE VAT Amount");
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
                        column(VATAmountLine__VAT____Control1000000122; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control1000000123; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control1000000124; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000125; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000127; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000128; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Montant_TVACaption_Control1000000111; Montant_TVACaption_Control1000000111Lbl)
                        {
                        }
                        column(Base_TVACaption_Control1000000112; Base_TVACaption_Control1000000112Lbl)
                        {
                        }
                        column(TVACaption_Control1000000114; TVACaption_Control1000000114Lbl)
                        {
                        }
                        column(Identifiant_TVACaption_Control1000000115; Identifiant_TVACaption_Control1000000115Lbl)
                        {
                        }
                        column(ReportCaption_Control1000000117; ReportCaption_Control1000000117Lbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000125Caption; VALVATBaseLCY_Control1000000125CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000128Caption; VALVATBaseLCY_Control1000000128CaptionLbl)
                        {
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                               TempVATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                                 TempVATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT TempGLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0) THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF TempGLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(TempGLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem("DEEE Tariffs"; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; "DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000145; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; "DEEE Tariffs"."HT Unit Tax (LCY)")
                        {
                        }
                        column(DEEE_Contribution___Caption_Control1000000148; DEEE_Contribution___Caption_Control1000000148Lbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption; DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption; RecGItemCtg__Weight_Min_CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption; DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Maxi__Caption; RecGItemCtg__Weight_Min__Control1000000145CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196; DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196Lbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption_Control1000000197; RecGItemCtg__Weight_Min_Caption_Control1000000197Lbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198; DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198Lbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199; RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199Lbl)
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
                            RecLPurchaseLine: Record "Purchase Line";
                        begin
                            BooGDEEEFind := FALSE;
                            RecLPurchaseLine.RESET();
                            RecLPurchaseLine.SETRANGE("Document No.", "Purchase Header"."No.");
                            IF RecLPurchaseLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLPurchaseLine."BC6_DEEE Category Code" = "DEEE Tariffs"."DEEE Code") AND (RecLPurchaseLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLPurchaseLine.NEXT() = 0));

                            RecGDEEE.RESET();
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Purchase Header"."Posting Date");
                            IF RecGDEEE.FIND('+') THEN BEGIN
                                IF RecGDEEE."Date beginning" <> "DEEE Tariffs"."Date beginning" THEN
                                    BooGDEEEFind := FALSE;
                            END;

                            RecGItemCtg.RESET();
                            IF NOT RecGItemCtg.GET("DEEE Tariffs"."DEEE Code", "DEEE Tariffs"."Eco Partner") THEN
                                RecGItemCtg.INIT();

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.SKIP();
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLPurchaseLine: Record "Purchase Line";
                        begin
                            BooGDEEEFind := FALSE;
                            RecLPurchaseLine.RESET();

                            RecLPurchaseLine.SETFILTER(RecLPurchaseLine."Document No.", "Purchase Header"."No.");
                            RecLPurchaseLine.SETFILTER(RecLPurchaseLine."Document Type", '%1', RecLPurchaseLine."Document Type"::Order);
                            IF RecLPurchaseLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLPurchaseLine."BC6_DEEE Category Code" <> '') AND (RecLPurchaseLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLPurchaseLine.NEXT() = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK();

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGPayVendor."BC6_Posting DEEE" THEN
                                CurrReport.BREAK();
                            CurrReport.BREAK();
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaymentTerms_Description_Control1000000051; PaymentTerms.Description)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_PurchLine__DEEE_VAT_Amount_; VATAmount + TempPurchLine."BC6_DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT_PurchLine__DEEE_HT_Amount__PurchLine__DEEE_VAT_Amount_; TotalAmountInclVAT + TempPurchLine."BC6_DEEE HT Amount" + TempPurchLine."BC6_DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine_Amount__PurchLine__DEEE_HT_Amount_; TempPurchLine.Amount + TempPurchLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(PurchLine__DEEE_HT_Amount_; TempPurchLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(ShipmentMethod_Description_Control1000000159; ShipmentMethod.Description)
                        {
                        }
                        column(TotalInclVATText_Control1000000067; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control1000000068; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmount_PurchLine__DEEE_VAT_Amount__Control1000000069; VATAmount + TempPurchLine."BC6_DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DataItem1000000070; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount" + VATAmount + TempPurchLine."BC6_DEEE HT Amount" + TempPurchLine."BC6_DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control1000000071; TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control1000000072; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PaymentTerms_Description_Control1000000074; PaymentTerms.Description)
                        {
                        }
                        column(PurchLine__DEEE_HT_Amount__Control1000000174; TempPurchLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(PurchLine_Amount__PurchLine__DEEE_HT_Amount__Control1000000176; TempPurchLine.Amount + TempPurchLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(ShipmentMethod_Description_Control1000000202; ShipmentMethod.Description)
                        {
                        }
                        column(PaymentTerms_Description_Control1000000051Caption; PaymentTerms_Description_Control1000000051CaptionLbl)
                        {
                        }
                        column(ShipmentMethod_Description_Control1000000159Caption; ShipmentMethod_Description_Control1000000159CaptionLbl)
                        {
                        }
                        column(PaymentTerms_Description_Control1000000074Caption; PaymentTerms_Description_Control1000000074CaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption_Control1000000173; AmountEco_ConributionCaption_Control1000000173Lbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption_Control1000000175; Excl__VAT_Total_Incl_DEEECaption_Control1000000175Lbl)
                        {
                        }
                        column(ShipmentMethod_Description_Control1000000202Caption; ShipmentMethod_Description_Control1000000202CaptionLbl)
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
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(BooGVisibleTabTot1; BooGVisibleTabTot1)
                        {
                        }
                        column(BooGVisibleTabTot2; BooGVisibleTabTot2)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recLBuyVendor.SETFILTER("No.", "Purchase Header"."Buy-from Vendor No.");
                        IF recLBuyVendor.FINDFIRST() THEN;


                        //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
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
                        //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record Job;
                    begin

                        IF "Purchase Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Purchase Header"."BC6_Affair No.";
                            RecGJob.GET("Purchase Header"."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo := OutputNo + 1;
                        CopyText := Text003;
                    END;
                    CurrReport.PAGENO := 1;

                    BooGVisibleVAT := ((TempVATAmountLine.COUNT > 1) AND ("Purchase Line"."Amount Including VAT" <> "Purchase Line".Amount));
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    //>>MIGRATION NAV 2013
                    TotalAmountVATDEE := 0;
                    TotalAmtHTDEEE := 0;
                    TotalDEEEHTAmount := 0;
                    TotalAmountVATBase := 0;

                    TotalAmountInclVATDEE2 := 0;
                    TotalAmountTTC := 0;

                    BooGVisibleTabTot1 := ("Purchase Header"."Prices Including VAT" AND (VATAmount <> 0));
                    //>>20131024
                    //BooGVisibleTabTot2 := (NOT "Purchase Header"."Prices Including VAT" AND ( VATAmount <> 0)) ;
                    BooGVisibleTabTot2 := TRUE;
                    //<<20131024

                    //<<MIGRATION NAV 2013
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                //IF RespCenter.GET("Responsibility Center") THEN BEGIN
                IF RespCenter.GET(CodGRespCenter) THEN BEGIN
                    //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";

                    //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                    BoolGRespCenter := TRUE;
                    //END ELSE
                    //  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BoolGRespCenter := FALSE;
                END;
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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
                    TempGLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, TempGLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, TempGLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, TempGLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT()
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                RecG_User.RESET();
                RecG_User.SETRANGE("User Name", ID);
                IF RecG_User.FINDFIRST() THEN
                    TexG_User_Name := RecG_User."User Name"
                ELSE
                    TexG_User_Name := '';

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;

                //>>COMPTA_DEEE FG 01/03/07
                RecGPayVendor.RESET();
                RecGPayVendor.GET("Purchase Header"."Pay-to Vendor No.");
                //<<COMPTA_DEEE FG 01/03/07

                //>>MIGRATION NAV 2013
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN
                    RespCenter.CALCFIELDS(RespCenter.BC6_Picture, RespCenter."BC6_Alt Picture")
                ELSE
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture, CompanyInfo."BC6_Alt Picture");
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                //<<MIGRATION NAV 2013
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
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                        ;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        ;
                        Enabled = ArchiveDocumentEnable;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        ;
                        Enabled = LogInteractionEnable;
                    }
                    field(CodGRespCenter; CodGRespCenter)
                    {
                        Caption = 'Print Characteristics Agency:', Comment = 'FRA="Imprimer Caractéristiques Agence:"';
                        ;
                        TableRelation = "Responsibility Center";
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin

            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule();
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteractionEnable := LogInteraction;
            ArchiveDocumentEnable := ArchiveDocument;


            //RequestOptionsPage.ArchiveDocument.ENABLED(ArchiveDocument);
            //RequestOptionsPage.LogInteraction.ENABLED(LogInteraction);

            //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
            CLEAR(CodGRespCenter);
            //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TempGLSetup.GET();
        CompanyInfo.GET();

        //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
        CompanyInfo.CALCFIELDS(Picture, "BC6_Alt Picture");
        //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
    end;

    var
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        TempRecGCalcul: Record "BC6_DEEE Tariffs" temporary;
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        TempGLSetup: Record "General Ledger Setup";
        RecGItem: Record Item;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        TempPurchLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        RecGSalesInvLine: Record "Sales Invoice Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        RecG_User: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        RecGPayVendor: Record Vendor;
        recLBuyVendor: Record Vendor;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BooGDEEEFind: Boolean;
        [InDataSet]
        BooGIncVAT: Boolean;
        BooGPostingDEEE: Boolean;
        BooGVisibleTabTot1: Boolean;
        BooGVisibleTabTot2: Boolean;
        BooGVisibleVAT: Boolean;
        BoolGRespCenter: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        CodGDevise: Code[10];
        CodGRespCenter: Code[10];
        DecGHTUnitTaxLCY: Decimal;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGTTCTotalAmount: Decimal;
        DecGVATTotalAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmountInclVATDEE2: Decimal;
        TotalAmountTTC: Decimal;
        TotalAmountVATBase: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        "--CNE3.02--": Integer;
        "--FEP-ADVE-200706_18_A.--": Integer;
        "-DEEE1.00-": Integer;
        "-NSC-": Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AmountCaption_Control45Lbl: Label 'Amount', Comment = 'FRA="Montant"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        AmountEco_ConributionCaption_Control1000000173Lbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Base_TVACaption_Control1000000112Lbl: Label 'Base TVA', Comment = 'FRA="Base TVA"';
        Base_TVACaptionLbl: Label 'Base TVA', Comment = 'FRA="Base TVA"';
        "Date_de_réception_demandéeCaptionLbl": Label 'Date de réception demandée', Comment = 'FRA="Date de réception demandée"';
        DEEE_Contribution___Caption_Control1000000148Lbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196Lbl: Label 'Category', Comment = 'FRA="Catégorie"';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category', Comment = 'FRA="Catégorie"';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198Lbl: Label 'HT Unit Tax (LCY)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        DescriptionCaption_Control40Lbl: Label 'Description', Comment = 'FRA="Description"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000175Lbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        Identifiant_TVACaption_Control1000000115Lbl: Label 'Identifiant TVA', Comment = 'FRA="Identifiant TVA"';
        Identifiant_TVACaptionLbl: Label 'Identifiant TVA', Comment = 'FRA="Identifiant TVA"';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ', Comment = 'FRA="Interlocuteur : "';
        Montant_base_remise_factureCaptionLbl: Label 'Montant base remise facture', Comment = 'FRA="Montant base remise facture"';
        Montant_ligneCaptionLbl: Label 'Montant ligne', Comment = 'FRA="Montant ligne"';
        Montant_remise_factureCaptionLbl: Label 'Montant remise facture', Comment = 'FRA="Montant remise facture"';
        Montant_TVACaption_Control1000000111Lbl: Label 'Montant TVA', Comment = 'FRA="Montant TVA"';
        Montant_TVACaptionLbl: Label 'Montant TVA', Comment = 'FRA="Montant TVA"';
        PaymentTerms_Description_Control1000000051CaptionLbl: Label 'Payment Method', Comment = 'FRA="Mode de réglement"';
        PaymentTerms_Description_Control1000000074CaptionLbl: Label 'Payment Method', Comment = 'FRA="Mode de réglement"';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method', Comment = 'FRA="Mode de réglement"';
        Planned_Receipt_DateCaptionLbl: Label 'Planned Receipt Date', Comment = 'FRA="Date de réception demandée"';
        Purchase_Line___DEEE_Category_Code_CaptionLbl: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        Purchase_Line___No___Control1000000165CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        Purchase_OrderCaptionLbl: Label 'Purchase Order', Comment = 'FRA="Commande achat"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199Lbl: Label 'Weight Max', Comment = 'FRA="Poids Max"';
        RecGItemCtg__Weight_Min__Control1000000145CaptionLbl: Label 'Weight Max', Comment = 'FRA="Poids Max"';
        RecGItemCtg__Weight_Min_Caption_Control1000000197Lbl: Label 'Weight Min', Comment = 'FRA="Poids Min"';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min', Comment = 'FRA="Poids Min"';
        ReferenceCaption_Control39Lbl: Label 'Reference', Comment = 'FRA="Référence"';
        ReferenceCaption_Control1000000017Lbl: Label 'Reference', Comment = 'FRA="Référence"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        ReportCaption_Control1000000105Lbl: Label 'Report', Comment = 'FRA="Report"';
        ReportCaption_Control1000000117Lbl: Label 'Report', Comment = 'FRA="Report"';
        ReportCaptionLbl: Label 'Report', Comment = 'FRA="Report"';
        ShipmentMethod_Description_Control1000000159CaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShipmentMethod_Description_Control1000000202CaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total Order %1', Comment = 'FRA="Total commande %1"';
        Text002: Label 'Total Order %1 Incl. VAT', Comment = 'FRA="Total commande %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order %1', Comment = 'FRA="Commande %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total Order %1 Excl. VAT', Comment = 'FRA="Total commande %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise locale"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text010: Label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF EMAIL TO ', Comment = 'FRA="IMPERATIF : NOUS CONFIRMER CETTE COMMANDE PAR RETOUR D''EMAIL A "';
        Text011: Label 'DELIVERY ADDRESS', Comment = 'FRA="ADRESSE DE LIVRAISON"';
        Text012: Label 'No.', Comment = 'FRA="N°"';
        Text013: Label ' with capital of ', Comment = 'FRA=" au capital de "';
        Text014: Label ' -Registration ', Comment = 'FRA=" -SIRET "';
        Text015: Label ' -EP ', Comment = 'FRA=" -APE "';
        Text016: Label ' -VAT Registration ', Comment = 'FRA=" -N° TVA "';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text068: Label '%1', Comment = 'FRA="%1"';
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        TVACaption_Control1000000114Lbl: Label '% TVA', Comment = 'FRA="% TVA"';
        TVACaptionLbl: Label '% TVA', Comment = 'FRA="% TVA"';
        Unit_PriceCaption_Control43Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unitaire net HT"';
        Unit_PriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix Unitaire net HT"';
        VALVATBaseLCY_Control1000000125CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCY_Control1000000128CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail TVA"';
        Vendor_No___CaptionLbl: Label 'Vendor No :.', Comment = 'FRA="N° fournisseur :"';
        txtlbl12: label '%1 %2';
        TxtGAltFax: Text[20];
        TxtGAltPhone: Text[20];
        TxtGAltPostCode: Text[20];
        TxtGFax: Text[20];
        TxtGPhone: Text[20];
        CopyText: Text[30];
        PurchaserText: Text[30];
        ReferenceText: Text[30];
        TexG_User_Name: Text[30];
        TextGVendorFax: Text[30];
        TextGVendorTel: Text[30];
        TxtGAltCity: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        VATNoText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltName: Text[50];
        TxtGDesignation: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        TxtGTag: Text[70];
        OldDimText: Text[75];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[80];
        VALSpecLCYHeader: Text[80];
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

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;
}

