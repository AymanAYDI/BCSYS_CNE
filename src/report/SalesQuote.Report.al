report 50009 "Sales Quote"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // ------------------------------------------------------------------------
    // 
    // //Creation commercial States CASC 13/12/06 NCS1.01 [FE001V1] Creation Report
    // //DESIGN                DARI 19/12/2007 NSC1.02
    // 
    // //FE005 MICO 12/02/2007 :
    //   Ajout des triggers :
    //   - DefineTagFax(TxtLTag : Text[50])
    //   - DefineTagMail(TxtLTag : Text[50])
    // 
    //   Ajout du champ : TxtGTag en en-tête du report
    //       + bouton : Envoyer/Imprimer
    //       pour permettre au user le choix d'envoi du document :
    //                    - Imprimante
    //                    - Mail
    //                    - Fax
    // //TDL:MICO 17/04/2007 :
    //   - Ajout de code pour que la TVA prenne en compte la TVA DEEE.
    // 
    // //TDL:MICO 18/04/2007
    //   - Ajout code pour que le tableau récapitulatif DEEE ne s'affiche plus conformément à la demande
    //     du client.
    // 
    // //FE005 DARI 20/02/2007 NSC1.03 -DEEE1.00
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //COMPTA_DEEE FG 01/03/07
    // // DARI 17/04/07 : Error of Output : comment a SETFILTER
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestin des apples d'offres clients
    //         - Add field "Affaire No"
    // 
    // FEP-ADVE-200706_18_A.002:GR 07/03/2008 : Gestin des apples d'offres clients
    //         - Delete te space caused by printing "Affaire No"
    //         - Add new section : PageLoop, Header (2), PageLoop, Header (3)
    // 
    // //>>10/03/2009 SU-GEPO cf appel I011127
    //     MODIFY section ( delete doc externe and Unit Sales)
    // 
    // 
    // //>> 30/10/2009 SU-DADE cf appel I014941
    // //   Sales Header, Header (1) - OnPreSection()
    // //<< 30/10/2009 SU-DADE cf appel I014941
    // 
    // //>>CNE3.03
    // FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010 - RESPONSABILITY CENTER MANAGEMENT
    //                                            - Add Option "Print Characteristics Agency" In Request Form
    // 
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 26:06/2015: Ne pas imprimer informations 2nde société si vide
    // 
    // //>>MODIF HL
    // TI370352 DO.GEPO 25/04/2017 : comment createTodo
    // 
    // ------------------------------------------------------------------------
    // 
    // ------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './SalesQuote.rdlc';

    Caption = 'Sales Quote';
    PreviewMode = Normal;

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(RespCenter_Picture; RespCenter.Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
            {
            }
            column(RespCenter__Alt_Picture_; RespCenter."Alt Picture")
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
            column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
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
            column(Sales_Header__Sales_Header___Prod__Version_No__; "Sales Header"."Prod. Version No.")
            {
            }
            column(TxtGAltAdress______TxtGAltAdress2_____STRSUBSTNO___1__2__TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO('%1 %2', TxtGAltPostCode, TxtGAltCity))
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
            column(CompanyAddr_2______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO('%1 %2', CompanyAddr[4], CompanyAddr[5]))
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
            column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
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
            column(VATAmountLine_VATAmountText_Control51; VATAmountLine.VATAmountText)
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
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                column(VATAmount_Value; VATAmount)
                {
                }
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
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
                    dataitem(DataItem2844; Table37)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Sales_Line___No__;"Sales Line"."No.")
                        {
                        }
                        column(Sales_Line__Description;"Sales Line".Description)
                        {
                        }
                        column(Sales_Line___No___Control62;"Sales Line"."No.")
                        {
                        }
                        column(Sales_Line__Description_Control63;"Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Quantity;"Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___Line_Amount_;"Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ROUND__Sales_Line___Discount_unit_price__;ROUND("Sales Line"."Discount unit price"))
                        {
                            DecimalPlaces = 2:0;
                        }
                        column(Sales_Line___No___Control1000000140;"Sales Line"."No.")
                        {
                        }
                        column(Sales_Line___DEEE_Category_Code_;"Sales Line"."DEEE Category Code")
                        {
                        }
                        column(ROUND__Sales_Line___DEEE_Unit_Price__;ROUND("Sales Line"."DEEE Unit Price"))
                        {
                            DecimalPlaces = 2:0;
                        }
                        column(Sales_Line__Quantity_Control1000000195;"Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___DEEE_HT_Amount_;"Sales Line"."DEEE HT Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount____VATAmount;SalesLine."Line Amount"-SalesLine."Inv. Discount Amount" - VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT_SalesLine__DEEE_HT_Amount_;TotalAmountInclVAT+SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount;VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount_;SalesLine.Amount +SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__DEEE_HT_Amount_;SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_;SalesLine."Line Amount"-SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount_Control90;VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount____VATAmount___DecGDEEEVatAmount;SalesLine.Amount +SalesLine."DEEE HT Amount" + VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__DEEE_HT_Amount__Control1000000172;SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount__Control1000000174;SalesLine.Amount +SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(AmountCaption_Control1000000000;AmountCaption_Control1000000000Lbl)
                        {
                        }
                        column(QuantityCaption_Control1000000011;QuantityCaption_Control1000000011Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1000000018;DescriptionCaption_Control1000000018Lbl)
                        {
                        }
                        column(ReferenceCaption_Control1000000020;ReferenceCaption_Control1000000020Lbl)
                        {
                        }
                        column(DEEE_Contribution___Caption;DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Line___No___Control1000000140Caption;Sales_Line___No___Control1000000140CaptionLbl)
                        {
                        }
                        column(Sales_Line___DEEE_Category_Code_Caption;Sales_Line___DEEE_Category_Code_CaptionLbl)
                        {
                        }
                        column(RoundLoop_Number;Number)
                        {
                        }
                        column(Format_Sales_Line_Type;FORMAT("Sales Line".Type,0,9))
                        {
                        }
                        column(Visible1;BooGVisible1)
                        {
                        }
                        column(TotalAmountInclVAT_value;TotalAmountInclVAT)
                        {
                        }
                        column(Sales_Line_DEEEHT_Amount;SalesLine."DEEE HT Amount")
                        {
                        }
                        column(Sales_Line_Inv_Disc_Amount;SalesLine."Inv. Discount Amount")
                        {
                        }
                        column(Sales_Line_Amount;SalesLine.Amount)
                        {
                        }
                        column(DecGDEEEVatAmount_Value;DecGDEEEVatAmount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                              SalesLine.FIND('-')
                            ELSE
                              SalesLine.NEXT;
                            "Sales Line" := SalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Sales Line"."No." := '';

                            //<<FE005:DARI 20/02/2007
                            //>>TDL:MICO 13/04/07
                            // DARI 17/04/07 //SalesLine.SETFILTER(SalesLine.Type,'%1',SalesLine.Type::Item);
                            //<<TDL:MICO 13/04/07
                            IF (( SalesLine."DEEE Category Code" <> '') AND ( SalesLine.Quantity <> 0)
                            AND ( SalesLine."Eco partner DEEE" <> '')) THEN
                              IF RecGItem. GET( SalesLine."No.") THEN
                                DecGNumbeofUnitsDEEE := RecGItem."Number of Units DEEE";
                            //FG
                            //VATAmountLine."DEEE HT Amount"  :=SalesLine."DEEE HT Amount" ;
                            //VATAmountLine."DEEE VAT Amount" :=SalesLine."DEEE VAT Amount" ;
                            //VATAmountLine.InsertLine;

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";

                            //>>TDL:MICO 16/04/2007
                            IF BooGSubmittedToDEEE THEN
                              DecGDEEEVatAmount += SalesLine."DEEE VAT Amount"
                            ELSE
                              DecGDEEEVatAmount := 0;

                            //<<TDL:MICO 16/04/2007
                            DecGTTCTotalAmount += SalesLine."Amount Including VAT" + SalesLine."DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT RecGTempCalcul.GET('',SalesLine."DEEE Category Code",0D)
                               THEN BEGIN
                                    //création d'une ligne
                                    RecGTempCalcul.INIT ;
                                    RecGTempCalcul."Eco Partner":='' ;
                                    RecGTempCalcul."DEEE Code":=SalesLine."DEEE Category Code" ;
                                    RecGTempCalcul."Date beginning":=0D ;
                                    RecGTempCalcul."HT Unit Tax (LCY)":=SalesLine."DEEE HT Amount" ;
                                    RecGTempCalcul.INSERT ;
                                    END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            IF (BooGSubmittedToDEEE) AND (SalesLine."DEEE Category Code" <> '') AND (SalesLine.Quantity <> 0) AND
                               (SalesLine."Eco partner DEEE" <> '') THEN
                              BooGVisible1 :=TRUE
                            ELSE
                              BooGVisible1 := FALSE ;

                            vGTotal1 := VATAmount + DecGDEEEVatAmount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2"= '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                              MoreLines :=SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");
                            
                            //>>TDL:MICO 17/04/07
                            // DARI 17:04/07 SalesLine.SETFILTER(SalesLine.Type,'%1',SalesLine.Type::Item);
                            //<<TDL:MICO 17/04/07
                            
                            SETRANGE(Number,1,SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");
                            //>>FE005:DARI 21/02/2007
                            //CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine.Amount,SalesLine."Amount Including VAT",
                            SalesLine."Inv. Discount Amount", SalesLine."DEEE HT Amount");
                            //MICO DEEE1.00
                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 21/02/2007
                            
                            /*
                            //>>MIGRATION NAV 2013
                            IF (BooGSubmittedToDEEE) AND (SalesLine."DEEE Category Code" <> '') AND (SalesLine.Quantity <> 0) AND
                               (SalesLine."Eco partner DEEE" <> '') THEN
                              BooGVisible1 :=TRUE
                            ELSE
                              BooGVisible1 := FALSE ;
                            */
                            
                            CLEAR(vGTotal1);
                            //vGTotal1 := VATAmount + DecGDEEEVatAmount;
                            
                            //<<MIGRATION NAV 2013

                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__Line_Amount_;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT___;VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000079;VATAmountLine."Line Amount")
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000081;VATAmountLine."Inv. Disc. Base Amount")
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083;VATAmountLine."Invoice Discount Amount")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000085;VATAmountLine."VAT Base")
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000087;VATAmountLine."VAT Amount")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000059;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000089;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000090;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000091;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000092;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000094;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000095;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000096;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000097;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000098;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_Caption;VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT___Caption;VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000079Caption;VATAmountLine__Line_Amount__Control1000000079CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000081Caption;VATAmountLine__Inv__Disc__Base_Amount__Control1000000081CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083Caption;VATAmountLine__Invoice_Discount_Amount__Control1000000083CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000085Caption;VATAmountLine__VAT_Base__Control1000000085CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000087Caption;VATAmountLine__VAT_Amount__Control1000000087CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption;VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption;VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000091Caption;VATAmountLine__VAT_Base__Control1000000091CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000097Caption;VATAmountLine__VAT_Base__Control1000000097CaptionLbl)
                        {
                        }
                        column(VATCounter_Number;Number)
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

                            IF VATAmountLine.COUNT <2 THEN
                              CurrReport.BREAK;
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier__Control1000000119;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT____Control1000000121;VATAmountLine."VAT %")
                        {
                        }
                        column(VALVATBaseLCY_Control1000000123;VALVATBaseLCY)
                        {
                        }
                        column(VALVATAmountLCY_Control1000000125;VALVATAmountLCY)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000114;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000115;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000117;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000118;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier__Control1000000119Caption;VATAmountLine__VAT_Identifier__Control1000000119CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control1000000121Caption;VATAmountLine__VAT____Control1000000121CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000123Caption;VALVATBaseLCY_Control1000000123CaptionLbl)
                        {
                        }
                        column(VALVATAmountLCY_Control1000000125Caption;VALVATAmountLCY_Control1000000125CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption;VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000114Caption;VALVATBaseLCY_Control1000000114CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000117Caption;VALVATBaseLCY_Control1000000117CaptionLbl)
                        {
                        }
                        column(VATCounterLCY_Number;Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date","Sales Header"."Currency Code",
                                               VATAmountLine."VAT Base","Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date","Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount","Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code"  = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text008 + Text009
                            ELSE
                              VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date","Sales Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text010,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(vGTotal1_Value;vGTotal1)
                        {
                        }
                        column(Text015;Text015)
                        {
                        }
                        column(Text016;Text016)
                        {
                        }
                        column(Total_Number;Number)
                        {
                        }
                    }
                    dataitem(Total2;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                              CurrReport.BREAK;
                        end;
                    }

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record "167";
                    begin
                        IF "Sales Header"."Affair No." <> '' THEN BEGIN
                          TxtGLblProjet := Text070;
                          TxtGNoProjet := "Sales Header"."Affair No.";
                          RecGJob.GET("Sales Header"."Affair No.");
                          TxtGDesignation :=RecGJob.Description;
                        END ELSE BEGIN
                          TxtGLblProjet := '';
                          TxtGNoProjet := '';
                          TxtGDesignation :='';
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                    BEGIN
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
                    SETRANGE(Number,1,NoOfLoops);

                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                "Sales Header".CALCFIELDS("Sales Header"."No. of Archived Versions");
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END;
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010

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
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;
                FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");

                IF "Payment Terms Code" = '' THEN
                  PaymentTerms.INIT
                ELSE
                  PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                  PaymentMethod.INIT
                ELSE
                  PaymentMethod.GET("Payment Method Code");

                //>>MIGRATION NAV 2013
                RecG_User.RESET ;
                RecG_User.SETRANGE("User Name",ID);
                IF RecG_User.FINDFIRST THEN
                  TexG_User_Name := RecG_User."Full Name"
                ELSE
                  TexG_User_Name := '';
                //<<MIGRATION NAV 2013

                IF "Shipment Method Code" = '' THEN
                  ShipmentMethod.INIT
                ELSE
                  ShipmentMethod.GET("Shipment Method Code");
                IF Country.GET("Sales Header"."Sell-to Country/Region Code") THEN
                  "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                  IF (ShipToAddr[i] <> CustAddr[i]) AND (ShipToAddr[i] <> '') AND (ShipToAddr[i] <> "Sell-to Country") THEN
                    ShowShippingAddr := TRUE;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);

                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        1,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                    ELSE
                      SegManagement.LogDocument(
                        1,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                  END;
                END;
                "Sales Header".MARK(TRUE);

                //>>COMPTA_DEEE FG 01/03/07
                IF "Sales Header"."Bill-to Customer No." <> '' THEN BEGIN
                  RecGBillCustomer.RESET ;
                  RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.") ;
                  BooGSubmittedToDEEE := RecGBillCustomer."Submitted to DEEE";
                END ELSE BEGIN
                  RecGCustomerTemplate.RESET ;
                  IF RecGCustomerTemplate.GET("Sales Header"."Sell-to Customer Template Code") THEN BEGIN
                    BooGSubmittedToDEEE := RecGCustomerTemplate."Submitted to DEEE";
                  END ELSE BEGIN
                    BooGSubmittedToDEEE := FALSE ;
                  END ;
                END;
                //<<COMPTA_DEEE FG 01/03/07
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "5080";
            begin
                "Sales Header".MARKEDONLY := TRUE;
                COMMIT;
                //>>TI370352
                /*
                IF "Sales Header".FIND('-') AND ToDo.WRITEPERMISSION THEN
                  IF NOT CurrReport.PREVIEW AND (NoOfRecords = 1) THEN
                   IF CONFIRM(Text007) THEN
                    "Sales Header".CreateTodo;
                */
                //<<TI370352

            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;

                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN BEGIN
                  TxtGPhone    := RespCenter."Phone No.";
                  TxtGFax      := RespCenter."Fax No.";
                  TxtGEmail    := RespCenter."E-Mail";
                  TxtGHomePage := RespCenter."Home Page";
                  TxtGAltName     := RespCenter."Alt Name";
                  TxtGAltAdress   := RespCenter."Alt Address";
                  TxtGAltAdress2  := RespCenter."Alt Address 2";
                  TxtGAltPostCode := RespCenter."Alt Post Code";
                  TxtGAltCity     := RespCenter."Alt City";
                  TxtGAltPhone    := RespCenter."Alt Phone No.";
                  TxtGAltFax      := RespCenter."Alt Fax No.";
                  TxtGAltEmail    := RespCenter."Alt E-Mail";
                  TxtGAltHomePage := RespCenter."Alt Home Page";
                END ELSE BEGIN
                  TxtGPhone    := CompanyInfo."Phone No.";
                  TxtGFax      := CompanyInfo."Fax No.";
                  TxtGEmail    := CompanyInfo."E-Mail";
                  TxtGHomePage := CompanyInfo."Home Page";
                  TxtGAltName     := CompanyInfo."Alt Name";
                  TxtGAltAdress   := CompanyInfo."Alt Address";
                  TxtGAltAdress2  := CompanyInfo."Alt Address 2";
                  TxtGAltPostCode := CompanyInfo."Alt Post Code";
                  TxtGAltCity     := CompanyInfo."Alt City";
                  TxtGAltPhone    := CompanyInfo."Alt Phone No.";
                  TxtGAltFax      := CompanyInfo."Alt Fax No.";
                  TxtGAltEmail    := CompanyInfo."Alt E-Mail";
                  TxtGAltHomePage := CompanyInfo."Alt Home Page";
                END;
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010

                //>>MIGRATION NAV 2013
                //>> 30/10/2009 SU-DADE cf appel I014941
                DecGDEEEVatAmount:=0;
                //<< 30/10/2009 SU-DADE cf appel I014941
                //<<MIGRATION NAV 2013
            end;
        }
    }

    requestpage
    {
        Caption = 'No. of Copies';

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(CodGRespCenter;CodGRespCenter)
                    {
                        Caption = 'Print Characteristics Agency:';
                        TableRelation = "Responsibility Center";
                    }
                    field(HideReference;HideReference)
                    {
                        Caption = 'Hide Reference';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //>>MIGRATION NAV 2013
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';
            LogInteractionEnable := LogInteraction;
            //RequestOptionsPage.ArchiveDocument.ENABLED(ArchiveDocument);
            //RequestOptionsPage.LogInteraction.ENABLED(LogInteraction);

            //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
            CLEAR(CodGRespCenter);
            //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
            //<<MIGRATION NAV 2013
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
        
        //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 16/12/2009
        /*
        CASE SalesSetup."Logo Position on Documents" OF
          SalesSetup."Logo Position on Documents"::"No Logo":;
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
        */
        //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 16/12/2009

    end;

    trigger OnPreReport()
    begin

        //>>MIGRATION NAV 2013
        IF RespCenter.GET(CodGRespCenter) THEN
          BoolGRespCenter := TRUE
        ELSE
          BoolGRespCenter := FALSE;

        IF BoolGRespCenter THEN
          RespCenter.CALCFIELDS(Picture,"Alt Picture")
        ELSE
          CompanyInfo.CALCFIELDS(Picture,"Alt Picture");
        //<<MIGRATION NAV 2013
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Quote %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        PaymentMethod: Record "289";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        SalesSetup: Record "311";
        VATAmountLine: Record "290" temporary;
        SalesLine: Record "37" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        Country: Record "9";
        CurrExchRate: Record "330";
        SalesCountPrinted: Codeunit "313";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
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
        Text007: Label 'Do you want to create a follow-up to-do?';
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text008: Label 'VAT Amount Specification in ';
        Text009: Label 'Local Currency';
        Text010: Label 'Exchange rate: %1/%2';
        Text011: Label 'Following your request, we are please to communicate bellow ours  best offers price';
        Text012: Label 'For all further information, do not hesitate to contact us';
        Text013: Label 'No. ';
        Text014: Label 'duplicate';
        Text015: Label 'Thank you to return us this signed quote: GOOD FOR AGREEMENT.';
        Text016: Label ' with capital of ';
        Text018: Label ' -EP ';
        Text019: Label ' -VAT Registration ';
        Text020: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        TexG_User_Name: Text[30];
        Text068: Label '%1';
        TxtGTag: Text[50];
        RecGParamVente: Record "311";
        "-DEEE1.00-": Integer;
        RecGSalesInvLine: Record "113";
        RecGDEEE: Record "50007";
        RecGItemCtg: Record "50006";
        BooGDEEEFind: Boolean;
        RecGTempCalcul: Record "50007" temporary;
        DecGVATTotalAmount: Decimal;
        DecGTTCTotalAmount: Decimal;
        RecGItem: Record "27";
        DecGNumbeofUnitsDEEE: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record "18";
        BooGSubmittedToDEEE: Boolean;
        RecGCustomerTemplate: Record "5105";
        "-MICO-": Integer;
        DecGDEEEVatAmount: Decimal;
        RecGSalesHeader: Record "36";
        RecGCustomer: Record "18";
        "--FEP-ADVE-200706_18_A--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label 'Affair No. : ';
        "--CNE3.02--": Integer;
        BoolGRespCenter: Boolean;
        TxtGPhone: Text[20];
        TxtGFax: Text[20];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[80];
        TxtGAltName: Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltPostCode: Text[20];
        TxtGAltCity: Text[30];
        TxtGAltPhone: Text[20];
        TxtGAltFax: Text[20];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        CodGRespCenter: Code[10];
        N__client___CaptionLbl: Label 'N° client : ';
        Sales_Header__Sales_Header___Bill_to_Contact_CaptionLbl: Label 'WITH ATTENTION OF: ';
        FORMAT__Sales_Header___Order_Date__0_4_CaptionLbl: Label 'Date :';
        Sales_Header__Sales_Header___Your_Reference_CaptionLbl: Label 'Y/REF: ';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ';
        Sales_QuoteCaptionLbl: Label 'Sales Quote';
        version_No____CaptionLbl: Label 'version No. : ';
        AmountCaptionLbl: Label 'Amount';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_Price_Incl__VATCaptionLbl: Label 'Unit Price Incl. VAT';
        DescriptionCaptionLbl: Label 'Description';
        ReferenceCaptionLbl: Label 'Reference';
        AmountCaption_Control1000000000Lbl: Label 'Amount';
        QuantityCaption_Control1000000011Lbl: Label 'Quantity';
        Unit_Price_Excl__VATCaptionLbl: Label 'Unit Price Excl. VAT';
        DescriptionCaption_Control1000000018Lbl: Label 'Description';
        ReferenceCaption_Control1000000020Lbl: Label 'Reference';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Sales_Line___No___Control1000000140CaptionLbl: Label 'Item : ';
        Sales_Line___DEEE_Category_Code_CaptionLbl: Label 'Category :';
        PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method:';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution';
        PaymentMethod_Description___________PaymentTerms_Description_Control1000000012CaptionLbl: Label 'Payment Method:';
        AmountEco_ConributionCaption_Control1000000162Lbl: Label 'AmountEco-Conribution';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000173Lbl: Label 'Excl. VAT Total Incl.DEEE';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__Line_Amount__Control1000000079CaptionLbl: Label 'Line Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control1000000081CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control1000000083CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__VAT_Base__Control1000000085CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Amount__Control1000000087CaptionLbl: Label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control1000000091CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control1000000097CaptionLbl: Label 'Total';
        VATAmountLine__VAT_Identifier__Control1000000119CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT____Control1000000121CaptionLbl: Label 'VAT %';
        VALVATBaseLCY_Control1000000123CaptionLbl: Label 'VAT Base';
        VALVATAmountLCY_Control1000000125CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control1000000114CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control1000000117CaptionLbl: Label 'Total';
        RecG_User: Record "2000000120";
        BooGVisible1: Boolean;
        vGTotal1: Decimal;
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        HideReference: Boolean;

    [Scope('Internal')]
    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    [Scope('Internal')]
    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15,02,2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."PDF Mail Tag" + TxtLTag;
    end;
}

