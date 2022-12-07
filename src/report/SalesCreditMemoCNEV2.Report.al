report 50041 "Sales - Credit Memo CNE V2"
{
    // //ETATS_COMMERCIAUX DARI 14.12.2006 NSC1.00 [Doc_commerciaux] Création de l'état à partir de l'état 50010 - Facture CNE
    // 
    //                                                              Papier à en-tête : suppresssion de l'entête et du pied de page.
    //                                                              Taux de TVA :
    //                                                              Si 1 taux de TVA   = 1 ligne de TVA ( .COUNT = 1)  ET
    //                                                                 TTC=HT = TVA non payée
    //                                                              OU TTC <> HT = TVA dûe
    //                                                              ------------------------
    //                                                              Idem pour N taux de TVA
    // 
    //                                                              -----------------------------------------------------------
    //                                                               Ajout des sections Rounloop, body 5 et Roudloop body 6
    //                                                               pour imprimer le trait de bas de tableau et forcer le saut de page
    // 
    //                                                               Lecture des mode de règlement (Payment Method)
    //                                                               Ajout du N° de Document externe dans le libellé de "Votre reference"
    //                                                               Ajout de concaténation du N° de document externe
    //                                                               avec le "Your reference"
    // 
    //                                                               Récupération du Nbre de copie dans la table diverses TYPECDE
    // 
    //                                                               Raz du Nbre de Copies forcé
    //                                                               Dans le OnAcivate de la zone du RequestForm
    //                                                               Calcul du Prix Net car dans la ligne, il n'y a que le prix brut
    //                                                               (avant remise)
    // 
    //                                                               Adresse à imprimer = adresse de commande et
    //                                                               non pas adresse de Facturation
    //                                                               Modification des reports en fonction du Client Worms
    // 
    // //DESIGN DARI 19/01/2007 NSC1.03
    // 
    // //FE005 MICO 14/02/2207 :
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
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //COMPTA_DEEE FG 01/03/07
    // 
    // //TDL DESIGN:DARI LE 12/04/07
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestin des apples d'offres clients
    //         - Add field "Affaire No"
    // ------------------------------------------------------------------------
    // 
    // +-------------------------------------------+
    // |  BCSYS - www.bcsys.fr                     |
    // +-------------------------------------------+
    // //BCSYS 29032021 add Picture, Footer, CGV
    //   > Update 25022022 comment CGV
    // +-------------------------------------------+
    DefaultLayout = RDLC;
    RDLCLayout = './SalesCreditMemoCNEV2.rdlc';

    Caption = 'Sales - Credit Memo';
    Permissions = TableData 7190 = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem8098; Table114)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(VATAmtLineVATCptn; VATAmtLineVATCptnLbl)
            {
            }
            column(VATAmtLineVATBaseCptn; VATAmtLineVATBaseCptnLbl)
            {
            }
            column(VATAmtLineVATAmtCptn; VATAmtLineVATAmtCptnLbl)
            {
            }
            column(VATAmtLineVATIdentifierCptn; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalCptn; TotalCptnLbl)
            {
            }
            column(SalesCrMemoLineDiscCaption; SalesCrMemoLineDiscCaptionLbl)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
            {
            }
            column(FooterCompAddr1; FooterCompAddr[1])
            {
            }
            column(FooterCompAddr2; FooterCompAddr[2])
            {
            }
            column(FooterCompAddr3; FooterCompAddr[3])
            {
            }
            column(FooterCompAddr4; FooterCompAddr[4])
            {
            }
            column(FooterCompAddr5; FooterCompAddr[5])
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
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
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(FORMAT__Sales_Cr_Memo_Header___Posting_Date__0_4_; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(CompanyInfo_City_____le__; CompanyInfo.City + ' le ')
                    {
                    }
                    column(STRSUBSTNO__Page__1__FORMAT_CurrReport_PAGENO__; STRSUBSTNO('Page %1', FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(TexG_User_Name; TexG_User_Name)
                    {
                    }
                    column(TxtGTag; TxtGTag)
                    {
                    }
                    column(TxtGDesignation; TxtGDesignation)
                    {
                    }
                    column(TxtGNoProjet; TxtGNoProjet)
                    {
                    }
                    column(TxtGLblProjet; TxtGLblProjet)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Due_Date_; "Sales Cr.Memo Header"."Due Date")
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__Caption; "Sales Cr.Memo Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Cr_Memo_No_Caption; Cr_Memo_No_CaptionLbl)
                    {
                    }
                    column(InterlocutorCaption; InterlocutorCaptionLbl)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Due_Date_Caption; "Sales Cr.Memo Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(VATBaseDiscPrc_SalesCrMemoLine; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DataItem3364; Table115)
                    {
                        DataItemLink = Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING (Document No., Line No.);
                        column(Sales_Cr_Memo_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 0;
                        }
                        column(Sales_Cr_Memo_Line_Description; Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__No__; "No.")
                        {
                        }
                        column(FORMAT_Quantity_0___precision_0_2__standard_format_1____; FORMAT(Quantity, 0, '<precision,0:2><standard format,1>'))
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Cr_Memo_Line__Qty__per_Unit_of_Measure_; "Qty. per Unit of Measure")
                        {
                        }
                        column(FORMAT__Line_Amount__0___precision_2_2__standard_format_1____; FORMAT("Line Amount", 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            DecimalPlaces = 0 : 2;
                        }
                        column(FORMAT___Discount_unit_price____0___precision_0_5__standard_format_1____; FORMAT("Discount unit price", 0, '<precision,0:5><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Cr_Memo_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGNumbeofUnitsDEEE; DecGNumbeofUnitsDEEE)
                        {
                        }
                        column(Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY; Quantity * DecGNumbeofUnitsDEEE * DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Cr_Memo_Line__DEEE_Category_Code_; "DEEE Category Code")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control1000000111; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 0;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control1000000005; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Amount; Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column("RéférenceCaption"; RéférenceCaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description_Control65Caption; FIELDCAPTION(Description))
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
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
                        column(Sales_Cr_Memo_Line__No___Control1000000128Caption; Sales_Cr_Memo_Line__No___Control1000000128CaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line__DEEE_Category_Code_Caption; Sales_Cr_Memo_Line__DEEE_Category_Code_CaptionLbl)
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
                        column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                        }
                        column(BooGVisible; BooGVisible)
                        {
                        }
                        column(BooGTotalVisible; BooGTotalVisible)
                        {
                        }
                        column(BooGVATVisible; BooGVATVisible)
                        {
                        }
                        column(BooGTotalVisible2; BooGTotalVisible2)
                        {
                        }
                        column(Loi_N_92_1442_du_31_12_1992_Caption; Loi_N_92_1442_du_31_12_1992__Escompte_applicale_en_cas_de_paiement_anticipé___0_3___par_mois__Retard_de_paiement___pénalités_Lbl)
                        {
                        }
                        column("L_acheteur_déclare_avoir_pris_connaissance_des_conditions_de_ventes_Caption"; L_acheteur_déclare_avoir_pris_connaissance_des_conditions_de_ventes_stipulées_au_verso_du_présent_feuillet_et_notamment_de_laLbl)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
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

                            //FG
                            IntGCpt := IntGCpt + 1;

                            IF IntGCpt = IntGNbLigFac THEN
                                BooGAfficheTrait := TRUE
                            ELSE
                                BooGAfficheTrait := FALSE;

                            //<<FE005:DARI 20/02/2007
                            IF (("Sales Cr.Memo Line"."DEEE Category Code" <> '') AND ("Sales Cr.Memo Line".Quantity <> 0)
                            AND ("Sales Cr.Memo Line"."Eco partner DEEE" <> '')) THEN BEGIN
                                IF RecGItem.GET("Sales Cr.Memo Line"."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;
                                RecGDEEE.RESET;
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Cr.Memo Header"."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;
                            END;

                            //FG
                            VATAmountLine."DEEE HT Amount" := "Sales Cr.Memo Line"."DEEE HT Amount";
                            VATAmountLine."DEEE VAT Amount" := "Sales Cr.Memo Line"."DEEE VAT Amount";
                            VATAmountLine.InsertLine;

                            //MICO DEEE1.00
                            DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";
                            DecGTTCTotalAmount += "Sales Cr.Memo Line"."Amount Including VAT" + "Sales Cr.Memo Line"."DEEE TTC Amount";

                            //MICO : Création dynamique du tableau récapitulatif
                            IF NOT RecGTempCalcul.GET('', "Sales Cr.Memo Line"."DEEE Category Code", 0D)
                               THEN BEGIN
                                //création d'une ligne
                                RecGTempCalcul.INIT;
                                RecGTempCalcul."Eco Partner" := '';
                                RecGTempCalcul."DEEE Code" := "Sales Cr.Memo Line"."DEEE Category Code";
                                RecGTempCalcul."Date beginning" := 0D;
                                RecGTempCalcul."HT Unit Tax (LCY)" := "Sales Cr.Memo Line"."DEEE HT Amount";
                                RecGTempCalcul.INSERT;
                            END;
                            //>>FE005:DARI 20/02/2007

                            //>>MIGRATION NAV 2013
                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;
                            NNC_TotalAmountInclVat += "Amount Including VAT";

                            TotalDEEEHTAmount += "DEEE HT Amount";
                            TotalAmtHTDEEE += Amount + "DEEE HT Amount";
                            TotalAmountVATDEE += "Amount Including VAT" - Amount + "DEEE VAT Amount";
                            TotalAmountInclVATDEE += "Amount Including VAT" + "DEEE HT Amount" + "DEEE VAT Amount";
                            TotalAmount += Amount;


                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."Submitted to DEEE" THEN BEGIN
                                BooGVisible := ("DEEE Category Code" <> '') AND (Quantity <> 0) AND ("Eco partner DEEE" <> '');
                            END ELSE BEGIN
                                BooGVisible := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07

                            BooGTotalVisible := "Sales Cr.Memo Header"."Prices Including VAT" AND ("Amount Including VAT" <> Amount);
                            BooGVATVisible := (VATAmountLine.COUNT > 1) AND ("Amount Including VAT" <> Amount);
                            BooGTotalVisible2 := (VATAmountLine.COUNT > 1) OR ((VATAmountLine.COUNT = 1) AND ("Amount Including VAT" = Amount));

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
                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "DEEE HT Amount", "DEEE VAT Amount");
                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 22/02/2007



                            //FG
                            IntGNbLigFac := "Sales Cr.Memo Line".COUNT;
                            IntGCpt := 0;
                        end;
                    }
                    dataitem(VATCounter; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLine.GetTotalVATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(DataItem6784; Table50007)
                    {
                        DataItemTableView = SORTING (Eco Partner, DEEE Code, Date beginning);
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; "DEEE Tariffs"."HT Unit Tax (LCY)")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000125; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; "DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__Caption; DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl)
                        {
                        }
                        column(RecGItemCtg__Weight_Min_Caption; RecGItemCtg__Weight_Min_CaptionLbl)
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_Caption; DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl)
                        {
                        }
                        column(Control1000000104Caption; Control1000000104CaptionLbl)
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
                            RecLCrMemoLine: Record "115";
                        begin
                            //>>FE005 DARI 21/02/2007
                            BooGDEEEFind := FALSE;
                            RecLCrMemoLine.RESET;
                            RecLCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                            IF RecLCrMemoLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLCrMemoLine."DEEE Category Code" = "DEEE Tariffs"."DEEE Code") AND (RecLCrMemoLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLCrMemoLine.NEXT = 0));

                            RecGDEEE.RESET;
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", "DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Cr.Memo Header"."Posting Date");
                            IF RecGDEEE.FIND('+') THEN BEGIN
                                IF RecGDEEE."Date beginning" <> "DEEE Tariffs"."Date beginning" THEN
                                    BooGDEEEFind := FALSE;
                            END;

                            RecGItemCtg.RESET;
                            IF NOT RecGItemCtg.GET("DEEE Tariffs"."DEEE Code", "DEEE Tariffs"."Eco Partner") THEN
                                RecGItemCtg.INIT;

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.SKIP;
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLCrMemoLine: Record "115";
                        begin
                            //>>FE005 DARI
                            BooGDEEEFind := FALSE;
                            RecLCrMemoLine.RESET;

                            RecLCrMemoLine.SETFILTER(RecLCrMemoLine."Document No.", "Sales Cr.Memo Header"."No.");
                            //RecLCrMemoLine.SETFILTER(RecLCrMemoLine."Document Type",'%1',RecLCrMemoLine."Document Type"::Order);
                            IF RecLCrMemoLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLCrMemoLine."DEEE Category Code" <> '') AND (RecLCrMemoLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLCrMemoLine.NEXT = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK;
                            //<<DARI

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."Submitted to DEEE" THEN
                                CurrReport.BREAK;
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(VATCounterLCY; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number);
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
                        column(VATAmtLineVATPercent; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Cr.Memo Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text008 + Text009
                            ELSE
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                        column(TotalAmount; FORMAT(TotalAmount, 0, '<precision,2:2><standard format,1>'))
                        {
                        }
                        column(TotalDEEEHTAmount; FORMAT(TotalDEEEHTAmount, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
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
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; FORMAT(TotalAmountVAT, 0, '<precision,2:2><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                    }
                    dataitem(Total2; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));

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
                        IF "Sales Cr.Memo Header"."Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Sales Cr.Memo Header"."Affair No.";
                            RecGJob.GET("Sales Cr.Memo Header"."Affair No.");
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
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalLineAmount := 0;

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
                        SalesCreMemoCountPrinted.RUN("Sales Cr.Memo Header");
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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                //BCSYS 25022022
                FormatReportFooterAddress.FormatAddrFooter(FooterCompAddr, CompanyInfo);

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
                    TotalExclVATText := STRSUBSTNO(Text007, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text007, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
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

                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
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
                RecGBillCustomer.GET("Sales Cr.Memo Header"."Bill-to Customer No.");
                //<<COMPTA_DEEE FG 01/03/07
            end;
        }
    }

    requestpage
    {
        Caption = 'Inlude Shipment No.';

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(IncludeShptNo; IncludeShptNo)
                    {
                        Caption = 'Inlude Shipment No.';
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
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
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

        /*CASE SalesSetup."Logo Position on Documents" OF
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
        END;*/

        //BCSYS 290321
        CompanyInfo.CALCFIELDS(Picture, "Alt Picture");

    end;

    trigger OnPostReport()
    begin
        //BCSYS 290321 - 25022022
        //IF NOT CurrReport.PREVIEW THEN
        //  REPORT.RUN(50043,FALSE,FALSE,"Sales Cr.Memo Header");
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        VATBaseAmount: Decimal;
        SalesCrMemoLine: Record "115";
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        SalesSetup: Record "311";
        Cust: Record "18";
        VATAmount: Decimal;
        VATAmountLine: Record "290" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        CurrExchRate: Record "330";
        SalesCreMemoCountPrinted: Codeunit "316";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        SalesShipmentBuffer: Record "7190" temporary;
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
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '(Applies to %1 %2)';
        Text004: Label 'COPY';
        Text005: Label 'Sales - Credit Memo %1';
        Text006: Label 'Page %1';
        Text007: Label 'Total %1 Excl. VAT';
        Text008: Label 'VAT Amount Specification in ';
        Text009: Label 'Local Currency';
        Text010: Label 'Exchange rate: %1/%2';
        Text011: Label 'Sales - Prepmt. Credit Memo %1';
        Text10800: Label 'ShipmentNo';
        ShipmentInvoiced: Record "10825";
        NoShipmentNumLoop: Integer;
        NoShipmentDatas: array[3] of Text[20];
        NoShipmentText: Text[30];
        IncludeShptNo: Boolean;
        IntGNbLigFac: Integer;
        IntGCpt: Integer;
        BooGAfficheTrait: Boolean;
        TexG_User_Name: Text[30];
        TxtGTag: Text[50];
        RecGParamVente: Record "311";
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
        RecGCrMemoLine: Record "115";
        TotalAmountInclVAT: Decimal;
        DecGHTUnitTaxLCY: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record "18";
        "--FEP-ADVE-200706_18_A.--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label 'Affair No. : ';
        Cr_Memo_No_CaptionLbl: Label 'Cr.Memo No.';
        InterlocutorCaptionLbl: Label 'Interlocutor';
        "L_acheteur_déclare_avoir_pris_connaissance_des_conditions_de_ventes_stipulées_au_verso_du_présent_feuillet__et_notamment_de_lLbl": Label 'L''acheteur déclare avoir pris connaissance des conditions de ventes stipulées au verso du présent feuillet  et notamment de la clause de réserve de propriété et les accepter.';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        "RéférenceCaptionLbl": Label 'Référence';
        QuantityCaptionLbl: Label 'Quantity';
        UnitCaptionLbl: Label 'Unit';
        AmountCaptionLbl: Label 'Amount';
        w__Tax_Net__U___P___CaptionLbl: Label 'w. Tax Net  U . P.  ';
        ContinuedCaptionLbl: Label 'Continued';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Sales_Cr_Memo_Line__No___Control1000000128CaptionLbl: Label 'Item : ';
        Sales_Cr_Memo_Line__DEEE_Category_Code_CaptionLbl: Label ' -   Category :';
        SubtotalCaptionLbl: Label 'Subtotal';
        Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: Label 'Payment Discount on VAT';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Line_Amount__Control140CaptionLbl: Label 'Line Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control1000000021CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control1000000022CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Max';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category';
        Control1000000104CaptionLbl: Label 'Label1000000104';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution';
        Base__CaptionLbl: Label 'Base :';
        "Loi_N_92_1442_du_31_12_1992__Escompte_applicale_en_cas_de_paiement_anticipé___0_3___par_mois__Retard_de_paiement___pénalités_Lbl": Label 'Loi N°92-1442 du 31/12/1992. Escompte applicale en cas de paiement anticipé = 0.3 % par mois. Retard de paiement : pénalités de 1 % par mois.';
        PaymentTerms_Description_Control1000000177CaptionLbl: Label 'Payment Terms';
        "L_acheteur_déclare_avoir_pris_connaissance_des_conditions_de_ventes_stipulées_au_verso_du_présent_feuillet_et_notamment_de_laLbl": Label 'L''acheteur déclare avoir pris connaissance des conditions de ventes stipulées au verso du présent feuillet et notamment de la clause de réserve de propriété et les accepter.';
        "- MIGNAV2013 -": Integer;
        RecG_User: Record "2000000120";
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        VATAmtLineInvDiscBaseAmtCptnLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCptnLbl: Label 'Line Amount';
        VATAmtLineInvoiceDiscAmtCptnLbl: Label 'Invoice Discount Amount';
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalLineAmount: Decimal;
        BooGVisible: Boolean;
        VATAmtLineVATCptnLbl: Label 'VAT %';
        VATAmtLineVATBaseCptnLbl: Label 'VAT Base';
        VATAmtLineVATAmtCptnLbl: Label 'VAT Amount';
        VATAmtLineVATIdentifierCptnLbl: Label 'VAT Identifier';
        TotalCptnLbl: Label 'Total';
        SalesCrMemoLineDiscCaptionLbl: Label 'Discount %';
        BooGTotalVisible: Boolean;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmount: Decimal;
        TotalAmountVAT: Decimal;
        BooGVATVisible: Boolean;
        BooGTotalVisible2: Boolean;
        FormatReportFooterAddress: Codeunit "50014";
        FooterCompAddr: array[5] of Text[400];

    [Scope('Internal')]
    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;

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
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."PDF Mail Tag" + TxtLTag;
    end;
}
