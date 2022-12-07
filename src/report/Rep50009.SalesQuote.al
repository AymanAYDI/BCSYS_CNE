report 50009 "BC6_Sales Quote"
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

    Caption = 'Sales Quote', Comment = 'FRA="Devis vente"';
    PreviewMode = Normal;

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
            column(Sales_Header__Sales_Header___Prod__Version_No__; "Sales Header"."BC6_Prod. Version No.")
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
                            CurrReport.BREAK;
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
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount____VATAmount; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" - VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT_SalesLine__DEEE_HT_Amount_; TotalAmountInclVAT + SalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount; VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount_; SalesLine.Amount + SalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__DEEE_HT_Amount_; SalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount___DecGDEEEVatAmount_Control90; VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount____VATAmount___DecGDEEEVatAmount; SalesLine.Amount + SalesLine."BC6_DEEE HT Amount" + VATAmount + DecGDEEEVatAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__DEEE_HT_Amount__Control1000000172; SalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount__Control1000000174; SalesLine.Amount + SalesLine."BC6_DEEE HT Amount")
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
                        column(Sales_Line_DEEEHT_Amount; SalesLine."BC6_DEEE HT Amount")
                        {
                        }
                        column(Sales_Line_Inv_Disc_Amount; SalesLine."Inv. Discount Amount")
                        {
                        }
                        column(Sales_Line_Amount; SalesLine.Amount)
                        {
                        }
                        column(DecGDEEEVatAmount_Value; DecGDEEEVatAmount)
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
                            IF ((SalesLine."BC6_DEEE Category Code" <> '') AND (SalesLine.Quantity <> 0)
                            AND (SalesLine."BC6_Eco partner DEEE" <> '')) THEN
                                IF RecGItem.GET(SalesLine."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE";
                            //FG
                            //VATAmountLine."DEEE HT Amount"  :=SalesLine."DEEE HT Amount" ;
                            //VATAmountLine."DEEE VAT Amount" :=SalesLine."DEEE VAT Amount" ;
                            //VATAmountLine.InsertLine;

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";

                            //>>TDL:MICO 16/04/2007
                            IF BooGSubmittedToDEEE THEN
                                DecGDEEEVatAmount += SalesLine."BC6_DEEE VAT Amount"
                            ELSE
                                DecGDEEEVatAmount := 0;

                            //<<TDL:MICO 16/04/2007
                            DecGTTCTotalAmount += SalesLine."Amount Including VAT" + SalesLine."BC6_DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT RecGTempCalcul.GET('', SalesLine."BC6_DEEE Category Code", 0D)
                               THEN BEGIN
                                //création d'une ligne
                                RecGTempCalcul.INIT;
                                RecGTempCalcul."Eco Partner" := '';
                                RecGTempCalcul."DEEE Code" := SalesLine."BC6_DEEE Category Code";
                                RecGTempCalcul."Date beginning" := 0D;
                                RecGTempCalcul."HT Unit Tax (LCY)" := SalesLine."BC6_DEEE HT Amount";
                                RecGTempCalcul.INSERT;
                            END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            IF (BooGSubmittedToDEEE) AND (SalesLine."BC6_DEEE Category Code" <> '') AND (SalesLine.Quantity <> 0) AND
                               (SalesLine."BC6_Eco partner DEEE" <> '') THEN
                                BooGVisible1 := TRUE
                            ELSE
                                BooGVisible1 := FALSE;

                            vGTotal1 := VATAmount + DecGDEEEVatAmount;
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

                            //>>TDL:MICO 17/04/07
                            // DARI 17:04/07 SalesLine.SETFILTER(SalesLine.Type,'%1',SalesLine.Type::Item);
                            //<<TDL:MICO 17/04/07

                            SETRANGE(Number, 1, SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                            //>>FE005:DARI 21/02/2007
                            //CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");
                            CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine.Amount, SalesLine."Amount Including VAT",
                            SalesLine."Inv. Discount Amount", SalesLine."BC6_DEEE HT Amount");
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
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000079; VATAmountLine."Line Amount")
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000081; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083; VATAmountLine."Invoice Discount Amount")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control1000000085; VATAmountLine."VAT Base")
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000087; VATAmountLine."VAT Amount")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000059; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000089; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000090; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000091; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000092; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000094; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000095; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000096; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000097; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000098; VATAmountLine."VAT Amount")
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
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK;

                            IF VATAmountLine.COUNT < 2 THEN
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
                        column(VATAmountLine__VAT_Identifier__Control1000000119; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT____Control1000000121; VATAmountLine."VAT %")
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
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                               VATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
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
                                CurrReport.BREAK;
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
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                "Sales Header".CALCFIELDS("Sales Header"."No. of Archived Versions");
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
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
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                //>>MIGRATION NAV 2013
                RecG_User.RESET;
                RecG_User.SETRANGE("User Name", ID);
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

                //>>COMPTA_DEEE FG 01/03/07
                IF "Sales Header"."Bill-to Customer No." <> '' THEN BEGIN
                    RecGBillCustomer.RESET;
                    RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.");
                    BooGSubmittedToDEEE := RecGBillCustomer."BC6_Submitted to DEEE";
                END ELSE BEGIN
                    RecGCustomerTemplate.RESET;
                    IF RecGCustomerTemplate.GET("Sales Header"."Sell-to Customer Template Code") THEN BEGIN
                        BooGSubmittedToDEEE := RecGCustomerTemplate."BC6_Submitted to DEEE";
                    END ELSE BEGIN
                        BooGSubmittedToDEEE := FALSE;
                    END;
                END;
                //<<COMPTA_DEEE FG 01/03/07
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "To-do";
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

                //>>MIGRATION NAV 2013
                //>> 30/10/2009 SU-DADE cf appel I014941
                DecGDEEEVatAmount := 0;
                //<< 30/10/2009 SU-DADE cf appel I014941
                //<<MIGRATION NAV 2013
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
                    field(CodGRespCenter; CodGRespCenter)
                    {
                        Caption = 'Print Characteristics Agency:', Comment = 'FRA="Imprimer Caractéristiques Agence:"';
                        TableRelation = "Responsibility Center";
                    }
                    field(HideReference; HideReference)
                    {
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
            RespCenter.CALCFIELDS(BC6_Picture, "BC6_Alt Picture")
        ELSE
            CompanyInfo.CALCFIELDS(Picture, "BC6_Alt Picture");
        //<<MIGRATION NAV 2013
    end;

    var
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Quote %1', Comment = 'FRA="Ventes : Devis %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
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
        Text007: Label 'Do you want to create a follow-up to-do?', Comment = 'FRA="Voulez-vous créer une action de suivi ?"';
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
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
        TexG_User_Name: Text[30];
        Text068: Label '%1', Comment = 'FRA="%1"';
        TxtGTag: Text[50];
        RecGParamVente: Record "Sales & Receivables Setup";
        "-DEEE1.00-": Integer;
        RecGSalesInvLine: Record "Sales Invoice Line";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        RecGItemCtg: Record "BC6_Categories of item";
        BooGDEEEFind: Boolean;
        RecGTempCalcul: Record "BC6_DEEE Tariffs" temporary;
        DecGVATTotalAmount: Decimal;
        DecGTTCTotalAmount: Decimal;
        RecGItem: Record Item;
        DecGNumbeofUnitsDEEE: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record Customer;
        BooGSubmittedToDEEE: Boolean;
        RecGCustomerTemplate: Record "Customer Template";
        "-MICO-": Integer;
        DecGDEEEVatAmount: Decimal;
        RecGSalesHeader: Record "Sales Header";
        RecGCustomer: Record Customer;
        "--FEP-ADVE-200706_18_A--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
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
        N__client___CaptionLbl: Label 'N° client : ', Comment = 'FRA="N° client : "';
        Sales_Header__Sales_Header___Bill_to_Contact_CaptionLbl: Label 'WITH ATTENTION OF: ', Comment = 'FRA="A L''ATTENTION DE : "';
        FORMAT__Sales_Header___Order_Date__0_4_CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        Sales_Header__Sales_Header___Your_Reference_CaptionLbl: Label 'Y/REF: ', Comment = 'FRA="V/REF : "';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ', Comment = 'FRA="Interlocuteur : "';
        Sales_QuoteCaptionLbl: Label 'Sales Quote', Comment = 'FRA="Devis ventes"';
        version_No____CaptionLbl: Label 'version No. : ', Comment = 'FRA="N° version : "';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        Unit_Price_Incl__VATCaptionLbl: Label 'Unit Price Incl. VAT', Comment = 'FRA="P. U. Net TTC"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Réference"';
        AmountCaption_Control1000000000Lbl: Label 'Amount', Comment = 'FRA="Montant"';
        QuantityCaption_Control1000000011Lbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        Unit_Price_Excl__VATCaptionLbl: Label 'Unit Price Excl. VAT', Comment = 'FRA="P. U. Net HT"';
        DescriptionCaption_Control1000000018Lbl: Label 'Description', Comment = 'FRA="Désignation"';
        ReferenceCaption_Control1000000020Lbl: Label 'Reference', Comment = 'FRA="Réference"';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        Sales_Line___No___Control1000000140CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        Sales_Line___DEEE_Category_Code_CaptionLbl: Label 'Category :', Comment = 'FRA="Catégorie :"';
        PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method:', Comment = 'FRA="Mode de réglement :"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        PaymentMethod_Description___________PaymentTerms_Description_Control1000000012CaptionLbl: Label 'Payment Method:', Comment = 'FRA="Mode de réglement :"';
        AmountEco_ConributionCaption_Control1000000162Lbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000173Lbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmountLine__Line_Amount__Control1000000079CaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmountLine__Inv__Disc__Base_Amount__Control1000000081CaptionLbl: Label 'Inv. Disc. Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmountLine__Invoice_Discount_Amount__Control1000000083CaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        VATAmountLine__VAT_Base__Control1000000085CaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmountLine__VAT_Amount__Control1000000087CaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail TVA"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base__Control1000000091CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VATAmountLine__VAT_Base__Control1000000097CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VATAmountLine__VAT_Identifier__Control1000000119CaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATAmountLine__VAT____Control1000000121CaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VALVATBaseLCY_Control1000000123CaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VALVATAmountLCY_Control1000000125CaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VALVATBaseLCYCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCY_Control1000000114CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        VALVATBaseLCY_Control1000000117CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        RecG_User: Record User;
        BooGVisible1: Boolean;
        vGTotal1: Decimal;
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        HideReference: Boolean;


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

