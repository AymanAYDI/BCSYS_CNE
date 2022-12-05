report 50008 "Purchase Order"
{
    // //Report Purchase Order CASC 13/12/2006 NSC1.01 : Creation du report
    // //FE002.2 SEBC 09/01/2007 : - Add freight port test when print header
    //                               -> Canceled
    // //DESIGN DARI 19/01/2007 NSC1.03
    // //FE005 DARI 20/02/2007 NSC1.03 -DEEE1.00
    // //FE005 MICO 21/02/2207 :
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
    // 
    // //TDL87 MICO LE 26/03/07 :
    //     - Modification de l'option PlaceInBottom dans le trigger RoundLoop,Footer(9) afin d'afficher
    //       le montant des lignes d'achat en ba sde page.
    // 
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //COMPTA_DEEE FG 01/03/07
    // //DEEE_TVA 17/04/07 DARI
    // //TodoList point 102 10/05/07 DARI : Design
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestin des apples d'offres clients
    //         - Add field "Affaire No"
    // FEP-ADVE-200706_18_A.002:GR 07/03/2008 : Gestin des apples d'offres clients
    //         - Delete te space caused by printing "Affaire No"
    //         - Add new section PageLoop, Header (2)
    // ------------------------------------------------------------------------
    // //DESIGN SEDU 07/02/2008
    //         - Agrandissement colonne ref article
    // 
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change design
    // 
    // //>>CNE3.03
    // FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010 - RESPONSABILITY CENTER MANAGEMENT
    //                                            - Add Option "Print Characteristics Agency" In Request Form
    // 
    // //>> MODIF HL 15/05/2012 SU-LALE cf appel TI099639
    //                          Modif C/AL Code dans trigger RoundLoop - OnAfterGetRecord()
    // 
    // //>>20131024
    // - Affichage constant du tableau des totaux en pied de page
    // 
    // //>>MODIF HL
    // TI259537  DO.GEPO 19/01/2015 : modify layout ( create function setdec and getdec )
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseOrder.rdlc';

    Caption = 'Purchase Order';

    dataset
    {
        dataitem(DataItem4458; Table38)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
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
            column(RespCenter_Picture; RespCenter.Picture)
            {
            }
            column(RespCenter__Alt_Picture_; RespCenter."Alt Picture")
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
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
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                column(Text010_________CompanyInfo__Fax_No__; Text010 + CompanyInfo."Purchaser E-Mail")
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
                column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                dataitem("PageLoop"""; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
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
                    column(CompanyAddr_2_______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO('%1 %2', CompanyAddr[4], CompanyAddr[5]))
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
                    column(TxtGAltAdress______TxtGAltAdress2_____STRSUBSTNO___1__2__TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO('%1 %2', TxtGAltPostCode, TxtGAltCity))
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
                    dataitem(DataItem6547; Table39)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Purchase_Line___No__;"Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Description;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Description_Control63;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Quantity;"Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Discount_Direct_Unit_Cost_;"Purchase Line"."Discount Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Line_Amount_;"Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Planned_Receipt_Date_;PurchLine."Planned Receipt Date")
                        {
                        }
                        column(Purchase_Line___DEEE_Category_Code_;"Purchase Line"."DEEE Category Code")
                        {
                        }
                        column(Purchase_Line__Quantity_Control1000000169;"Purchase Line".Quantity)
                        {
                        }
                        column(DecGHTUnitTaxLCY;DecGHTUnitTaxLCY)
                        {
                        }
                        column(Purchase_Line___DEEE_Amount__LCY__for_Stat_;"Purchase Line"."DEEE Amount (LCY) for Stat")
                        {
                        }
                        column(RoundLoop_Number;Number)
                        {
                        }
                        column(BooGIncVAT;BooGIncVAT)
                        {
                        }
                        column(Purchase_Line_Type;FORMAT("Purchase Line".Type,0,9))
                        {
                        }
                        column(BooGPostingDEEE;BooGPostingDEEE)
                        {
                        }
                        column(TotalAmtInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVATDEE;TotalAmountInclVATDEE)
                        {
                        }
                        column(TotalDEEEHTAmount;TotalDEEEHTAmount)
                        {
                        }
                        column(TotalAmtHTDEEE;TotalAmtHTDEEE)
                        {
                        }
                        column(TotalAmountVATDEE;TotalAmountVATDEE)
                        {
                        }
                        column(TotalAmountVATBase;TotalAmountVATBase)
                        {
                        }
                        column(TotalAmountInclVATDEE2;TotalAmountInclVATDEE2)
                        {
                        }
                        column(TotalAmountTTC;TotalAmountTTC)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            BooGIncVAT:= "Purchase Header"."Prices Including VAT";

                            IF Number = 1 THEN
                              PurchLine.FIND('-')
                            ELSE
                              PurchLine.NEXT;
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Purchase Line"."No." := '';

                            //<<FE005:DARI 20/02/2007
                            IF (( "Purchase Line"."DEEE Category Code" <> '') AND ( "Purchase Line".Quantity <> 0)
                            AND ( "Purchase Line"."Eco partner DEEE" <> '')) THEN BEGIN

                              IF RecGItem. GET( "Purchase Line"."No.") THEN
                                DecGNumbeofUnitsDEEE := RecGItem."Number of Units DEEE"
                              ELSE DecGNumbeofUnitsDEEE:=0;

                              RecGDEEE.RESET;
                              RecGDEEE.SETFILTER(RecGDEEE."DEEE Code",PurchLine."DEEE Category Code");
                              RecGDEEE.SETFILTER(RecGDEEE."Date beginning",'<=%1',"Purchase Header"."Posting Date");
                              IF RecGDEEE.FIND('+') THEN
                                DecGHTUnitTaxLCY:=RecGDEEE."HT Unit Tax (LCY)"
                              ELSE DecGHTUnitTaxLCY:=0;

                              //>>COMPTA_DEEE FG 01/03/07
                              DecGHTUnitTaxLCY := "Purchase Line"."DEEE Unit Price (LCY)" ;
                              //<<COMPTA_DEEE FG 01/03/07
                            END;
                            //FG

                            //>> MODIF HL 15/05/2012 SU-LALE cf appel TI099639
                            VATAmountLine."VAT %" := 0;
                            VATAmountLine."VAT Base" := 0;
                            VATAmountLine."Amount Including VAT" := 0;
                            VATAmountLine."Line Amount" := 0;
                            VATAmountLine."Inv. Disc. Base Amount" := 0;
                            VATAmountLine."Invoice Discount Amount" := 0;
                            //<< MODIF HL 15/05/2012 SU-LALE cf appel TI099639

                            VATAmountLine."DEEE HT Amount"  :="Purchase Line"."DEEE HT Amount" ;
                            VATAmountLine."DEEE VAT Amount" :="Purchase Line"."DEEE VAT Amount" ;
                            VATAmountLine.InsertLine;

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";
                            DecGTTCTotalAmount += "Purchase Line"."Amount Including VAT" + "Purchase Line"."DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT RecGTempCalcul.GET('',"Purchase Line"."DEEE Category Code",0D)
                               THEN BEGIN
                                    //création d'une ligne
                                    RecGTempCalcul.INIT ;
                                    RecGTempCalcul."Eco Partner":='' ;
                                    RecGTempCalcul."DEEE Code":="Purchase Line"."DEEE Category Code" ;
                                    RecGTempCalcul."Date beginning":=0D ;
                                    RecGTempCalcul."HT Unit Tax (LCY)":="Purchase Line"."DEEE HT Amount" ;
                                    RecGTempCalcul.INSERT ;
                                    END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            //>>COMPTA_DEEE DARI 17/04/07
                            IF NOT RecGPayVendor."Posting DEEE" THEN BEGIN
                             PurchLine."DEEE HT Amount"  := 0 ;
                             PurchLine."DEEE VAT Amount":= 0 ;
                            END ;
                            //<<COMPTA_DEEE DARI 17/04/07

                            TotalAmountVATDEE     += PurchLine."Amount Including VAT" - PurchLine.Amount + PurchLine."DEEE VAT Amount";
                            TotalAmtHTDEEE        += PurchLine.Amount + PurchLine."DEEE HT Amount";
                            TotalDEEEHTAmount     += PurchLine."DEEE HT Amount";
                            TotalAmountVATBase    += VATBaseAmount;

                            TotalAmountInclVATDEE2 +=  PurchLine.Amount-PurchLine."Inv. Discount Amount";
                            TotalAmountTTC         +=  - PurchLine."Inv. Discount Amount" +
                                                        PurchLine."Amount Including VAT" +
                                                        PurchLine."DEEE HT Amount" + PurchLine."DEEE VAT Amount";
                            //<<MIGRATION NAV 2013


                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGPayVendor."Posting DEEE" THEN BEGIN
                              BooGPostingDEEE:= (("Purchase Line"."DEEE Category Code" <> '') AND
                                                      ("Purchase Line".Quantity <> 0) AND
                                                        ("Purchase Line"."Eco partner DEEE" <> ''));
                            END ELSE BEGIN
                              BooGPostingDEEE:= FALSE ;
                            END ;
                            //<<COMPTA_DEEE FG 01/03/07
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2"= '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                              MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.",0,PurchLine."Line No.");
                            SETRANGE(Number,1,PurchLine.COUNT);

                            //>>FE005:DARI 20/02/2007
                            //CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                            CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine.Amount,PurchLine."Amount Including VAT",

                            //>>DARI 17/04/07
                            //PurchLine."Inv. Discount Amount", PurchLine."DEEE HT Amount");
                            PurchLine."Inv. Discount Amount", PurchLine."DEEE HT Amount",PurchLine."DEEE VAT Amount");
                            //>>DARI 17/04/07

                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 20/02/2007
                        end;
                    }
                    dataitem(DataItem5444;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1));
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_;PurchLine."Line Amount"-PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Integer_Number;Number)
                        {
                        }
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000099;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000100;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control1000000102;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000103;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000104;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000106;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000107;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000108;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000109;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000110;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control1000000079;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control1000000080;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control1000000081;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control1000000082;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control1000000083;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
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
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              //FG
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount",
                              //VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                              VATAmountLine."DEEE HT Amount",VATAmountLine."DEEE VAT Amount") ;
                        end;
                    }
                    dataitem(VATCounterLCY;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control1000000122;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control1000000123;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control1000000124;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000125;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control1000000127;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control1000000128;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Montant_TVACaption_Control1000000111;Montant_TVACaption_Control1000000111Lbl)
                        {
                        }
                        column(Base_TVACaption_Control1000000112;Base_TVACaption_Control1000000112Lbl)
                        {
                        }
                        column(TVACaption_Control1000000114;TVACaption_Control1000000114Lbl)
                        {
                        }
                        column(Identifiant_TVACaption_Control1000000115;Identifiant_TVACaption_Control1000000115Lbl)
                        {
                        }
                        column(ReportCaption_Control1000000117;ReportCaption_Control1000000117Lbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000125Caption;VALVATBaseLCY_Control1000000125CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control1000000128Caption;VALVATBaseLCY_Control1000000128CaptionLbl)
                        {
                        }
                        column(VATCounterLCY_Number;Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Purchase Header"."Posting Date","Purchase Header"."Currency Code",
                                               VATAmountLine."VAT Base","Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Purchase Header"."Posting Date","Purchase Header"."Currency Code",
                                                 VATAmountLine."VAT Amount","Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code"  = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text007 + Text008
                            ELSE
                              VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date","Purchase Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text009,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(DataItem6784;Table50007)
                    {
                        DataItemTableView = SORTING(Eco Partner,DEEE Code,Date beginning);
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_;"DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_;RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000145;RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__;"DEEE Tariffs"."HT Unit Tax (LCY)")
                        {
                        }
                        column(DEEE_Contribution___Caption_Control1000000148;DEEE_Contribution___Caption_Control1000000148Lbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption;DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption;RecGItemCtg__Weight_Min_CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption;DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Maxi__Caption;RecGItemCtg__Weight_Min__Control1000000145CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196;DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196Lbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption_Control1000000197;RecGItemCtg__Weight_Min_Caption_Control1000000197Lbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198;DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198Lbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199;RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199Lbl)
                        {
                        }
                        column(DEEE_Tariffs_Eco_Partner;"Eco Partner")
                        {
                        }
                        column(DEEE_Tariffs_Date_beginning;"Date beginning")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            RecLPurchaseLine: Record "39";
                        begin
                            BooGDEEEFind:=FALSE;
                            RecLPurchaseLine.RESET;
                            RecLPurchaseLine.SETRANGE("Document No.","Purchase Header"."No.");
                            IF RecLPurchaseLine.FIND('-') THEN
                              REPEAT
                                BooGDEEEFind:=((RecLPurchaseLine."DEEE Category Code"="DEEE Tariffs"."DEEE Code") AND (RecLPurchaseLine.Quantity<>0));
                              UNTIL ((BooGDEEEFind=TRUE) OR (RecLPurchaseLine.NEXT = 0));

                            RecGDEEE.RESET;
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code","DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning",'<=%1',"Purchase Header"."Posting Date");
                            IF RecGDEEE.FIND('+') THEN
                              BEGIN
                                IF RecGDEEE."Date beginning"<>"DEEE Tariffs"."Date beginning" THEN
                                  BooGDEEEFind:=FALSE;
                              END;

                            RecGItemCtg.RESET ;
                            IF NOT RecGItemCtg.GET("DEEE Tariffs"."DEEE Code","DEEE Tariffs"."Eco Partner") THEN
                              RecGItemCtg.INIT ;

                            IF  BooGDEEEFind=FALSE THEN
                               CurrReport.SKIP;
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLPurchaseLine: Record "39";
                        begin
                            BooGDEEEFind:=FALSE;
                            RecLPurchaseLine.RESET;

                            RecLPurchaseLine.SETFILTER(RecLPurchaseLine."Document No.","Purchase Header"."No.");
                            RecLPurchaseLine.SETFILTER(RecLPurchaseLine."Document Type",'%1',RecLPurchaseLine."Document Type"::Order);
                            IF RecLPurchaseLine.FIND('-') THEN
                              REPEAT
                                BooGDEEEFind:= ((RecLPurchaseLine."DEEE Category Code"<>'') AND (RecLPurchaseLine.Quantity<>0));
                              UNTIL ((BooGDEEEFind=TRUE) OR (RecLPurchaseLine.NEXT = 0));

                            IF  BooGDEEEFind=FALSE THEN
                               CurrReport.BREAK;

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGPayVendor."Posting DEEE" THEN
                              CurrReport.BREAK ;
                              CurrReport.BREAK ;
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                              CurrReport.BREAK ;
                        end;
                    }
                    dataitem(Total;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(PaymentTerms_Description_Control1000000051;PaymentTerms.Description)
                        {
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_PurchLine__DEEE_VAT_Amount_;VATAmount+PurchLine."DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT_PurchLine__DEEE_HT_Amount__PurchLine__DEEE_VAT_Amount_;TotalAmountInclVAT+PurchLine."DEEE HT Amount"+PurchLine."DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine_Amount__PurchLine__DEEE_HT_Amount_;PurchLine.Amount +PurchLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(PurchLine__DEEE_HT_Amount_;PurchLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(ShipmentMethod_Description_Control1000000159;ShipmentMethod.Description)
                        {
                        }
                        column(TotalInclVATText_Control1000000067;TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control1000000068;VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount_PurchLine__DEEE_VAT_Amount__Control1000000069;VATAmount+PurchLine."DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DataItem1000000070;PurchLine."Line Amount"-PurchLine."Inv. Discount Amount" + VATAmount+PurchLine."DEEE HT Amount"+PurchLine."DEEE VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control1000000071;TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control1000000072;PurchLine."Line Amount"-PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PaymentTerms_Description_Control1000000074;PaymentTerms.Description)
                        {
                        }
                        column(PurchLine__DEEE_HT_Amount__Control1000000174;PurchLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(PurchLine_Amount__PurchLine__DEEE_HT_Amount__Control1000000176;PurchLine.Amount +PurchLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(ShipmentMethod_Description_Control1000000202;ShipmentMethod.Description)
                        {
                        }
                        column(PaymentTerms_Description_Control1000000051Caption;PaymentTerms_Description_Control1000000051CaptionLbl)
                        {
                        }
                        column(ShipmentMethod_Description_Control1000000159Caption;ShipmentMethod_Description_Control1000000159CaptionLbl)
                        {
                        }
                        column(PaymentTerms_Description_Control1000000074Caption;PaymentTerms_Description_Control1000000074CaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption_Control1000000173;AmountEco_ConributionCaption_Control1000000173Lbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption_Control1000000175;Excl__VAT_Total_Incl_DEEECaption_Control1000000175Lbl)
                        {
                        }
                        column(ShipmentMethod_Description_Control1000000202Caption;ShipmentMethod_Description_Control1000000202CaptionLbl)
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
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                              CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(BooGVisibleTabTot1;BooGVisibleTabTot1)
                        {
                        }
                        column(BooGVisibleTabTot2;BooGVisibleTabTot2)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                              CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recLBuyVendor.SETFILTER("No.","Purchase Header"."Buy-from Vendor No.")  ;
                        IF recLBuyVendor.FINDFIRST THEN ;


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
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record "167";
                    begin

                        IF "Purchase Header"."Affair No." <> '' THEN BEGIN
                          TxtGLblProjet := Text070;
                          TxtGNoProjet := "Purchase Header"."Affair No.";
                          RecGJob.GET("Purchase Header"."Affair No.");
                          TxtGDesignation :=RecGJob.Description;
                        END ELSE BEGIN
                          TxtGNoProjet := '';
                          TxtGDesignation :='';
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

                    BooGVisibleVAT := ( (  VATAmountLine.COUNT > 1 )  AND ("Purchase Line"."Amount Including VAT" <> "Purchase Line".Amount ));
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header",PurchLine,0);
                    PurchLine.CalcVATAmountLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    PurchLine.UpdateVATOnLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code","Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    //>>MIGRATION NAV 2013
                    TotalAmountVATDEE     := 0;
                    TotalAmtHTDEEE        := 0;
                    TotalDEEEHTAmount     := 0;
                    TotalAmountVATBase    := 0;

                    TotalAmountInclVATDEE2 := 0;
                    TotalAmountTTC         := 0;

                    BooGVisibleTabTot1 := ( "Purchase Header"."Prices Including VAT" AND ( VATAmount <> 0)) ;
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
                    SETRANGE(Number,1,NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                //IF RespCenter.GET("Responsibility Center") THEN BEGIN
                IF RespCenter.GET(CodGRespCenter) THEN BEGIN
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";

                  //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                  BoolGRespCenter := TRUE;
                  //END ELSE
                  //  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END ELSE BEGIN
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                  BoolGRespCenter := FALSE;
                END;
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010

                IF "Purchaser Code" = '' THEN BEGIN
                  SalesPurchPerson.INIT;
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
                  GLSetup.TESTFIELD("LCY Code");
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr,"Purchase Header");
                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                  FormatAddr.PurchHeaderPayTo(VendAddr,"Purchase Header");
                IF "Payment Terms Code" = '' THEN
                  PaymentTerms.INIT
                ELSE
                  PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                  PaymentMethod.INIT
                ELSE
                  PaymentMethod.GET("Payment Method Code");

                RecG_User.RESET ;
                RecG_User.SETRANGE("User Name",ID);
                IF RecG_User.FINDFIRST THEN
                  TexG_User_Name := RecG_User."User Name"
                ELSE
                  TexG_User_Name := '';

                IF "Shipment Method Code" = '' THEN
                  ShipmentMethod.INIT
                ELSE
                  ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr,"Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);

                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",DATABASE::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                  END;
                END;

                //>>COMPTA_DEEE FG 01/03/07
                RecGPayVendor.RESET ;
                RecGPayVendor.GET("Purchase Header"."Pay-to Vendor No.") ;
                //<<COMPTA_DEEE FG 01/03/07

                //>>MIGRATION NAV 2013
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN
                  RespCenter.CALCFIELDS(RespCenter.Picture,RespCenter."Alt Picture")
                ELSE
                  CompanyInfo.CALCFIELDS(CompanyInfo.Picture,CompanyInfo."Alt Picture");
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
                        Enabled = ArchiveDocumentEnable;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(CodGRespCenter;CodGRespCenter)
                    {
                        Caption = 'Print Characteristics Agency:';
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

            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteractionEnable  := LogInteraction;
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
        GLSetup.GET;
        CompanyInfo.GET;

        //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
        CompanyInfo.CALCFIELDS(Picture, "Alt Picture");
        //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total Order %1';
        Text002: Label 'Total Order %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total Order %1 Excl. VAT';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        PaymentMethod: Record "289";
        SalesPurchPerson: Record "13";
        VATAmountLine: Record "290" temporary;
        PurchLine: Record "39" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        CurrExchRate: Record "330";
        recLBuyVendor: Record "23";
        PurchCountPrinted: Codeunit "317";
        FormatAddr: Codeunit "365";
        PurchPost: Codeunit "90";
        ArchiveManagement: Codeunit "5063";
        SegManagement: Codeunit "5051";
        VendAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        BuyFromAddr: array [8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
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
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        TextGVendorTel: Text[30];
        TextGVendorFax: Text[30];
        Text010: Label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF EMAIL TO ';
        Text011: Label 'DELIVERY ADDRESS';
        CodGDevise: Code[10];
        Text012: Label 'No.';
        Text013: Label ' with capital of ';
        Text014: Label ' -Registration ';
        Text015: Label ' -EP ';
        Text016: Label ' -VAT Registration ';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        TexG_User_Name: Text[30];
        "-DEEE1.00-": Integer;
        RecGSalesInvLine: Record "113";
        BooGDEEEFind: Boolean;
        RecGDEEE: Record "50007";
        RecGItemCtg: Record "50006";
        RecGTempCalcul: Record "50007" temporary;
        DecGVATTotalAmount: Decimal;
        DecGTTCTotalAmount: Decimal;
        RecGItem: Record "27";
        DecGNumbeofUnitsDEEE: Decimal;
        "-NSC-": Integer;
        TxtGTag: Text[70];
        RecGParamVente: Record "311";
        DecGHTUnitTaxLCY: Decimal;
        RecGPayVendor: Record "23";
        "--FEP-ADVE-200706_18_A.--": Integer;
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
        Text068: Label '%1';
        CodGRespCenter: Code[10];
        Purchase_OrderCaptionLbl: Label 'Purchase Order';
        Vendor_No___CaptionLbl: Label 'Vendor No :.';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: Label 'Date :';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ';
        ReferenceCaptionLbl: Label 'Reference';
        ReferenceCaption_Control1000000017Lbl: Label 'Reference';
        DescriptionCaptionLbl: Label 'Description';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        QuantityCaptionLbl: Label 'Quantity';
        AmountCaptionLbl: Label 'Amount';
        Planned_Receipt_DateCaptionLbl: Label 'Planned Receipt Date';
        ReferenceCaption_Control39Lbl: Label 'Reference';
        DescriptionCaption_Control40Lbl: Label 'Description';
        Unit_PriceCaption_Control43Lbl: Label 'Unit Price';
        AmountCaption_Control45Lbl: Label 'Amount';
        "Date_de_réception_demandéeCaptionLbl": Label 'Date de réception demandée';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Purchase_Line___No___Control1000000165CaptionLbl: Label 'Item : ';
        Purchase_Line___DEEE_Category_Code_CaptionLbl: Label ' -   Category :';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method';
        TVACaptionLbl: Label '% TVA';
        Base_TVACaptionLbl: Label 'Base TVA';
        Montant_TVACaptionLbl: Label 'Montant TVA';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        Montant_base_remise_factureCaptionLbl: Label 'Montant base remise facture';
        Montant_ligneCaptionLbl: Label 'Montant ligne';
        Montant_remise_factureCaptionLbl: Label 'Montant remise facture';
        Identifiant_TVACaptionLbl: Label 'Identifiant TVA';
        ReportCaptionLbl: Label 'Report';
        ReportCaption_Control1000000105Lbl: Label 'Report';
        TotalCaptionLbl: Label 'Total';
        Montant_TVACaption_Control1000000111Lbl: Label 'Montant TVA';
        Base_TVACaption_Control1000000112Lbl: Label 'Base TVA';
        TVACaption_Control1000000114Lbl: Label '% TVA';
        Identifiant_TVACaption_Control1000000115Lbl: Label 'Identifiant TVA';
        ReportCaption_Control1000000117Lbl: Label 'Report';
        VALVATBaseLCY_Control1000000125CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control1000000128CaptionLbl: Label 'Total';
        DEEE_Contribution___Caption_Control1000000148Lbl: Label 'DEEE Contribution : ';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)';
        RecGItemCtg__Weight_Min__Control1000000145CaptionLbl: Label 'Weight Max';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption_Control1000000196Lbl: Label 'Category';
        RecGItemCtg__Weight_Min_Caption_Control1000000197Lbl: Label 'Weight Min';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption_Control1000000198Lbl: Label 'HT Unit Tax (LCY)';
        RecGItemCtg__Weight_Min__Control1000000145Caption_Control1000000199Lbl: Label 'Weight Max';
        PaymentTerms_Description_Control1000000051CaptionLbl: Label 'Payment Method';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution';
        ShipmentMethod_Description_Control1000000159CaptionLbl: Label 'Shipment Method';
        PaymentTerms_Description_Control1000000074CaptionLbl: Label 'Payment Method';
        AmountEco_ConributionCaption_Control1000000173Lbl: Label 'AmountEco-Conribution';
        Excl__VAT_Total_Incl_DEEECaption_Control1000000175Lbl: Label 'Excl. VAT Total Incl.DEEE';
        ShipmentMethod_Description_Control1000000202CaptionLbl: Label 'Shipment Method';
        OutputNo: Integer;
        [InDataSet]
        BooGIncVAT: Boolean;
        BooGPostingDEEE: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BooGVisibleVAT: Boolean;
        TotalAmount: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmountVATBase: Decimal;
        TotalAmountInclVATDEE2: Decimal;
        TotalAmountTTC: Decimal;
        BooGVisibleTabTot1: Boolean;
        BooGVisibleTabTot2: Boolean;
        RecG_User: Record "2000000120";
        TotalAmountInclVATDEE: Decimal;

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

    [Scope('Internal')]
    procedure InitializeRequest(NewNoOfCopies: Integer;NewShowInternalInfo: Boolean;NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;
}

