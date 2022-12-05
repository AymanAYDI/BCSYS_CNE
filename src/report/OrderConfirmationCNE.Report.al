report 50032 "Order Confirmation CNE"
{
    // //ETATS_COMMERCIAUX BRRI 14.12.2006 NSC1.00 [Doc_commerciaux] Création de l'état à partir de l'état 205 - Confirmation de commande
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
    // 
    //                                                               Calcul du Prix Net car dans la ligne, il n'y a que le prix brut
    //                                                               (avant remise)
    // 
    //                                                               Adresse à imprimer = adresse de commande et
    //                                                               non pas adresse de Facturation
    //                                                               Modification des reports en fonction du Client Worms
    // 
    // //>>NSC1.01
    // 
    // FE005.001:SEBC 05/01/2007 : - PDF Mail Management
    //                             - Add tag to use PDF Mail
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
    // 
    // //TDL86:MICO LE 26/03/07 :
    //     - Suppression de la colonne "TVA"
    //     - Agrandissement de la colonne "Désignation"
    //     - Décalage des autres colonnes.
    // 
    // //TDL:MICO 18/04/2007
    //   - Ajout de code pour ajouter la TVA DEEE à la TVA et au total final.
    // 
    // //TDL:MICO 18/04/2007
    //   - Ajout code pour que le tableau récapitulatif DEEE ne s'affiche plus conformément à la demande
    //     du client.
    // 
    // //DESIGN DARI 19/01/2007 NSC1.03
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //COMPTA_DEEE FG 01/03/07
    // 
    // // anomalie 8 pages : DARI 17/04/07
    // //TDL 11/05/07 DARI : Design
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestion des apples d'offres clients
    //        - Add field salesheader."Affaire No"
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change design
    // 
    // //>>CNE3.03
    // FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010 - RESPONSABILITY CENTER MANAGEMENT
    //                                            - Add Option "Print Characteristics Agency" In Request Form
    // 
    // 
    // //>>MODIF HL
    // TI110958 DO.GEPO 03/07/2012 : modif design
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 26:06/2015: Ne pas imprimer informations 2nde société si vide
    // 
    // ------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './OrderConfirmationCNE.rdlc';

    Caption = 'Order Confirmation CNE';
    ShowPrintStatus = false;

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
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
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                    }
                    column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(TmpNamereport; TmpNamereport)
                    {
                    }
                    column(DateLiv; DateLiv)
                    {
                    }
                    column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
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
                    column(RespCenter_Picture; RespCenter.Picture)
                    {
                    }
                    column(RespCenter__Alt_Picture_; RespCenter."Alt Picture")
                    {
                    }
                    column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
                    {
                    }
                    column(STRSUBSTNO_Text066_TxtGPhone_TxtGFax_TxtGEmail_; STRSUBSTNO(Text066, TxtGPhone, TxtGFax, TxtGEmail))
                    {
                    }
                    column(CompanyAddr_2______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO('%1 %2', CompanyAddr[4], CompanyAddr[5]))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(DataItem1000000054; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(TxtGHomePage; TxtGHomePage)
                    {
                    }
                    column(TxtGAltName; TxtGAltName)
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
                    column(Shipment_departementCaption; Shipment_departementCaptionLbl)
                    {
                    }
                    column(Sales_Header___Your_Reference_Caption; Sales_Header___Your_Reference_CaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(Customer_No_Caption; Customer_No_CaptionLbl)
                    {
                    }
                    column(Delivery_DateCaption; Delivery_DateCaptionLbl)
                    {
                    }
                    column(V_DocumentCaption; V_DocumentCaptionLbl)
                    {
                    }
                    column(InterlocutorCaption; InterlocutorCaptionLbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(HideReference; HideReference)
                    {
                    }
                    dataitem(TraitementTexteClient; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number);
                        column(TraitementTexteClient_Number; Number)
                        {
                        }
                        dataitem(TexteClient; Table2000000026)
                        {
                            DataItemTableView = SORTING (Number);
                            column(StandardSalesLine_Description; StandardSalesLine.Description)
                            {
                            }
                            column(TexteClient_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
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
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", "Sales Header"."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(DataItem2844; Table37)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

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
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                            // BREAK nécessaire - sinon pb ...
                            //CurrReport.BREAK;
                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                              MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SETRANGE("Line No.",0,"Line No.");

                            CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount");
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Type_SalesLine;FORMAT("Sales Line".Type))
                        {
                        }
                        column(No_SalesLine;"Sales Line"."Line No.")
                        {
                        }
                        column(SalesLine__Line_Amount_;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Description;"Sales Line".Description)
                        {
                        }
                        column(FORMAT__Sales_Line___Discount_unit_price___0___precision_2_4__standard_format_1___;FORMAT("Sales Line"."Discount unit price" ,0,'<precision,2:4><standard format,1>'))
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Quantity;"Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___No__;"Sales Line"."No.")
                        {
                        }
                        column(Sales_Line___Qty__per_Unit_of_Measure_;"Sales Line"."Qty. per Unit of Measure")
                        {
                        }
                        column(Sales_Line__Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY;"Sales Line".Quantity*DecGNumbeofUnitsDEEE*DecGHTUnitTaxLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___DEEE_Category_Code_;"Sales Line"."DEEE Category Code")
                        {
                        }
                        column(DecGHTUnitTaxLCY;DecGHTUnitTaxLCY)
                        {
                        }
                        column(DecGNumbeofUnitsDEEE;DecGNumbeofUnitsDEEE)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(STRSUBSTNO___1__2__templibelledouanier_item__Tariff_No___;STRSUBSTNO('%1 %2',templibelledouanier,item."Tariff No."))
                        {
                        }
                        column(CrossrefNo;CrossrefNo)
                        {
                        }
                        column(SalesLine__Line_Amount__Control1000000050;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_;-SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__Control1000000132;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_SalesLine__DEEE_HT_Amount_;VATAmount+SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_;SalesLine."Line Amount"-SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NetaPayer__SalesLine__DEEE_HT_Amount_;NetaPayer+ SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__DEEE_HT_Amount_;SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount_;SalesLine.Amount +SalesLine."DEEE HT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(MontantCaption;MontantCaptionLbl)
                        {
                        }
                        column(Prix_unitaire_HTCaption;Prix_unitaire_HTCaptionLbl)
                        {
                        }
                        column(QuantityCaption;QuantityCaptionLbl)
                        {
                        }
                        column(Sales_Line__Description_Control1000000120Caption;"Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(ItemCaption;ItemCaptionLbl)
                        {
                        }
                        column(Sales_Unit_of_MeasureCaption;Sales_Unit_of_MeasureCaptionLbl)
                        {
                        }
                        column(ContinuedCaption;ContinuedCaptionLbl)
                        {
                        }
                        column(DEEE_Contribution___Caption;DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Line___No___Control1000000219Caption;Sales_Line___No___Control1000000219CaptionLbl)
                        {
                        }
                        column(Category_Caption;Category_CaptionLbl)
                        {
                        }
                        column(Nb_Un__DEEECaption;Nb_Un__DEEECaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption;SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(BooGDescVisible;BooGDescVisible)
                        {
                        }
                        column(BooGDescVisible2;BooGDescVisible2)
                        {
                        }
                        column(BooGDescVisible3;BooGDescVisible3)
                        {
                        }
                        column(BooGDescVisible4;BooGDescVisible4)
                        {
                        }
                        column(NNCSalesLineLineAmt;NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt;NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(RoundLoop_Number;Number)
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

                            //Debut affichage des references externes
                            ItemCrossReference.RESET;
                            ItemCrossReference.SETRANGE("Item No.", SalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Customer);
                            ItemCrossReference.SETRANGE("Cross-Reference Type No.","Sales Header"."Sell-to Customer No.");
                            CrossrefNo := '';
                            IF ItemCrossReference.FIND('-') THEN
                              CrossrefNo := ItemCrossReference."Cross-Reference No.";
                            //Fin affichage des references externes

                            //Début recuperation du code barre (gencod)
                            ItemCrossReference.RESET;
                            ItemCrossReference.SETRANGE("Item No.",SalesLine."No.");
                            ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            ItemCrossReference.SETRANGE("Discontinue Bar Code",FALSE);
                            TempGencod := '';
                            IF ItemCrossReference.FIND('-') THEN
                              TempGencod := ItemCrossReference."Cross-Reference No.";
                            //Fin recuperation du code barre (gencod)

                            //Debut recuperation du code nomenclature douanière
                            item."Tariff No." := '';
                            IF "Sales Header"."Sell-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                              IF SalesLine.Type = SalesLine.Type::Item THEN
                                IF item.GET(SalesLine."No.") THEN;;
                            END;
                            //Fin recuperation du code nomenclature douanière

                            //<<FE005:DARI 20/02/2007
                            IF (( SalesLine."DEEE Category Code" <> '') AND ( SalesLine.Quantity <> 0)
                            AND ( SalesLine."Eco partner DEEE" <> '')) THEN BEGIN
                              IF RecGItem. GET( SalesLine."No.") THEN
                                DecGNumbeofUnitsDEEE := RecGItem."Number of Units DEEE"
                              ELSE DecGNumbeofUnitsDEEE:=0;

                              RecGDEEE.RESET;
                              RecGDEEE.SETFILTER(RecGDEEE."DEEE Code",SalesLine."DEEE Category Code");
                              RecGDEEE.SETFILTER(RecGDEEE."Date beginning",'<=%1',"Sales Header"."Posting Date");
                              IF RecGDEEE.FIND('+') THEN
                                DecGHTUnitTaxLCY:=RecGDEEE."HT Unit Tax (LCY)"
                              ELSE DecGHTUnitTaxLCY:=0;
                            END;

                            //FG
                            //>> Anomalie 8 pages 17/04/07
                            //VATAmountLine."DEEE HT Amount"  :=SalesLine."DEEE HT Amount" ;
                            //VATAmountLine."DEEE VAT Amount" :=SalesLine."DEEE VAT Amount" ;
                            //VATAmountLine.InsertLine;
                            //<< anomalie 8 pages : 17/04/07

                            //MICO DEEE1.00
                            //DecGVATTotalAmount += VATAmountLine."VAT Amount" + VATAmountLine."DEEE VAT Amount";
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
                            Asterisque:=COPYSTR(SalesLine.Description,1,1);
                            BooGDescVisible := (SalesLine.Type = 0) AND (Asterisque<>'*');

                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."Submitted to DEEE" THEN
                            BEGIN
                              BooGDescVisible2 := ("Sales Line"."DEEE Category Code" <> '') AND ("Sales Line".Quantity <> 0) AND ("Sales Line"."Eco partner DEEE" <> '');
                            END
                            ELSE
                            BEGIN
                              BooGDescVisible2 := FALSE;
                            END ;
                            //<<COMPTA_DEEE FG 01/03/07


                            IF (CrossrefNo = '') AND (item."Tariff No." ='') THEN
                              BooGDescVisible3 := FALSE
                            ELSE
                              BooGDescVisible3 := TRUE;

                            templibelledouanier := '';
                            IF item."Tariff No." <>'' THEN
                              templibelledouanier := item.FIELDCAPTION("Tariff No.");

                            BooGDescVisible4 := SalesLine."Inv. Discount Amount" > 0;
                            NNCSalesLineLineAmt += SalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            TotalAmount += SalesLine."Line Amount";
                            TotalDEEEHTAmount += SalesLine."DEEE HT Amount";
                            TotalAmtHTDEEE += SalesLine."Line Amount" + SalesLine."DEEE HT Amount";
                            TotalAmountVATDEE += SalesLine."Amount Including VAT" - SalesLine."Line Amount" + SalesLine."DEEE VAT Amount";
                            TotalAmountInclVATDEE += SalesLine."Amount Including VAT" + SalesLine."DEEE HT Amount" + SalesLine."DEEE VAT Amount";


                            //<<MIGRATION NAV 2013
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND  (SalesLine."Description 2"= '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                              MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");
                            SETRANGE(Number,1,SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");

                            //>>FE005:DARI 21/02/2007
                            //CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine.Amount,SalesLine."Amount Including VAT",
                            SalesLine."Inv. Discount Amount", SalesLine."DEEE HT Amount",SalesLine."DEEE VAT Amount");
                            //MICO DEEE1.00

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                            //<<FE005:DARI 21/02/2007
                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption;InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption;VATIdentifierCaptionLbl)
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
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
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
                        column(VATAmtLineVATPercentage2;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier2;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date","Sales Header"."Currency Code",
                                  VATAmountLine."VAT Base","Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date","Sales Header"."Currency Code",
                                  VATAmountLine."VAT Amount","Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text007 + Text008
                            ELSE
                              VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date","Sales Header"."Currency Code",1);
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
                        column(RecGItemCtg__Weight_Min__Control1000000244;RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__;"DEEE Tariffs"."HT Unit Tax (LCY)")
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
                        column(RecGItemCtg__Weight_Min__Control1000000244Caption;RecGItemCtg__Weight_Min__Control1000000244CaptionLbl)
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
                            RecLSalesLine: Record "37";
                        begin
                            BooGDEEEFind:=FALSE;
                            RecLSalesLine.RESET;
                            RecLSalesLine.SETRANGE("Document No.","Sales Header"."No.");
                            RecLSalesLine.SETFILTER(RecLSalesLine."Document Type",'%1',RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                              REPEAT
                                BooGDEEEFind:=((RecLSalesLine."DEEE Category Code"="DEEE Tariffs"."DEEE Code") AND (RecLSalesLine.Quantity<>0));
                              UNTIL ((BooGDEEEFind=TRUE) OR (RecLSalesLine.NEXT = 0));

                            RecGDEEE.RESET;
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code","DEEE Tariffs"."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning",'<=%1',"Sales Header"."Posting Date");
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
                            RecLSalesLine: Record "37";
                        begin
                            BooGDEEEFind:=FALSE;
                            RecLSalesLine.RESET;

                            RecLSalesLine.SETFILTER(RecLSalesLine."Document No.","Sales Header"."No.");
                            RecLSalesLine.SETFILTER(RecLSalesLine."Document Type",'%1',RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                              REPEAT
                                BooGDEEEFind:= ((RecLSalesLine."DEEE Category Code"<>'') AND (RecLSalesLine.Quantity<>0));
                              UNTIL ((BooGDEEEFind=TRUE) OR (RecLSalesLine.NEXT = 0));

                            IF  BooGDEEEFind=FALSE THEN
                               CurrReport.BREAK;

                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."Submitted to DEEE" THEN
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
                        column(TotalAmount;TotalAmount)
                        {
                        }
                        column(TotalDEEEHTAmount;TotalDEEEHTAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                        }
                        column(TotalAmtHTDEEE;TotalAmtHTDEEE)
                        {
                        }
                        column(TotalAmountVATDEE;TotalAmountVATDEE)
                        {
                        }
                        column(TotalAmountInclVATDEE;TotalAmountInclVATDEE)
                        {
                        }
                        column(TotalAmtInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT;TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(DOWN_PAYMENTCaption;DOWN_PAYMENTCaptionLbl)
                        {
                        }
                        column(TOTAL_incl__VATCaption;TOTAL_incl__VATCaptionLbl)
                        {
                        }
                        column(Terms_of_PaymentCaption;Terms_of_PaymentCaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption;AmountEco_ConributionCaptionLbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption;Excl__VAT_Total_Incl_DEEECaptionLbl)
                        {
                        }
                        column(SIGNATURE__Caption;SIGNATURE__CaptionLbl)
                        {
                        }
                        column(SEAL__Caption;SEAL__CaptionLbl)
                        {
                        }
                        column(DATE__Caption;DATE__CaptionLbl)
                        {
                        }
                        column(Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_Caption;Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_CaptionLbl)
                        {
                        }
                        column(Sales_Header___Advance_Payment_;"Sales Header"."Advance Payment")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PaymentTerms_Description;PaymentTerms.Description)
                        {
                        }
                        column(CodeGCurrency;CodeGCurrency)
                        {
                        }
                        column(Total_Due_Caption;Total_Due_CaptionLbl)
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
                        Client: Record "18";
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



                        //Recherche des libellés text selon langue
                        IF CurrReport.PAGENO = 1 THEN BEGIN
                          LangueLig10 := Langue+''+'10';
                          LangueLig20 := Langue+''+'20';
                          LangueLig30 := Langue+''+'30';
                          IF TablesDiverses.GET(ListeTable,LangueLig10) THEN
                            Text10 := TablesDiverses.Description
                          ELSE
                            Text10 :='';
                          IF TablesDiverses.GET(ListeTable,LangueLig20) THEN
                            Text20 := TablesDiverses.Description
                          ELSE
                            Text20 :='';
                          IF TablesDiverses.GET(ListeTable,LangueLig30) THEN
                            Text30 := TablesDiverses.Description
                          ELSE
                            Text30 :='';
                        END;
                        //Recherche des libellés text selon langue

                        IF Client.GET("Sales Header"."Sell-to Customer No.") THEN
                         IF Client."Print Statements" =TRUE THEN
                          surReleve := 'sur relevé :'
                         ELSE  surReleve := ':'
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");

                    //>>TDL:MICO 17/04/2007
                    //TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT + VATAmountLine.GetTotalAmountDEEEInclVAT;
                    //<<TDL:MICO 17/04/2007

                    IF Number > 1 THEN
                    BEGIN
                      CopyText := Text003;
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    //>>MIGRATION NAV 2013
                    TotalAmount := 0;
                    TotalDEEEHTAmount := 0;
                    TotalAmtHTDEEE := 0;
                    TotalAmountVATDEE := 0;
                    TotalAmountInclVATDEE := 0;
                    //<<MIGRATION NAV 2013
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                      SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    //Récupération du Nbre de copie dans la table diverses TYPECDE
                    //Suppr
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    //CopyText := '';
                    //SETRANGE(Nombre,1,NoOfLoops);

                    //Remplacé  par
                    //**IF TableDiv.GET('TYPECDE',"Sales Header"."Type commande") THEN
                      //**NoOfLoops := TableDiv.Nombre1
                    //**ELSE
                      NoOfLoops := 0;

                    //Si Nbre de Copies est renseigner, on écrase le Nbre de copies du type de commande.
                    IF NoOfCopies <> 0 THEN
                      NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops >0 THEN
                      SETRANGE(Number,1,NoOfLoops)
                    ELSE
                    SETRANGE(Number,0,0);

                    OutputNo := 1;
                    //>>MIGRATION NAV 2013
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                    //<<MIGRATION NAV 2013
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");


                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 15/01/2010
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
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 15/01/2010

                //Debut pour avoir les infos société
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                  Pays:= Country.Name;
                //Fin Debut pour avoir les infos société

                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END;

                //Date livraison
                DateLiv := "Sales Header"."Promised Delivery Date";
                IF "Sales Header"."Promised Delivery Date" = 0D THEN
                   DateLiv := "Sales Header"."Requested Delivery Date";

                //Lecture Mode transport
                ModeTransport:='';
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN
                   ModeTransport:=ShippingAgent.Name;

                //Lecture des mode de règlement (Payment Methode)
                ModeDePayment:= '';
                IF PaymentMethod.GET("Sales Header"."Payment Method Code") THEN
                  ModeDePayment := PaymentMethod.Description;

                //Debut recherche des libellés text selon langue
                LangueLig01 := Language.Code+''+'01';
                ListeTable := 'CONCDE';
                IF TablesDiverses.GET(ListeTable,LangueLig01) THEN BEGIN
                  TmpNamereport := TablesDiverses.Description +''+ "Sales Header"."No.";
                  Langue := Language.Code;
                END ELSE BEGIN
                  Langue := 'FRA';
                  LangueLig01 := Langue+''+'01';
                  IF TablesDiverses.GET(ListeTable,LangueLig01) THEN BEGIN
                    TmpNamereport := TablesDiverses.Description+ ''+ "Sales Header"."No.";
                  END ELSE
                    TmpNamereport := Text004 + ' ' + "Sales Header"."No.";
                END;

                LangueLig40 := Langue+''+'40';
                LangueLig50 := Langue+''+'50';

                IF TablesDiverses.GET(ListeTable,LangueLig40) THEN
                  Text40 := TablesDiverses.Description
                ELSE
                  Text40 :='';
                IF TablesDiverses.GET(ListeTable,LangueLig50) THEN
                  Text50 := TablesDiverses.Description
                ELSE
                  Text50 :='';
                //Fin recherche des libellés text selon langue

                IF "Salesperson Code" = '' THEN BEGIN
                  CLEAR(SalesPurchPerson);
                  SalesPersonText := '';
                END ELSE BEGIN
                  SalesPurchPerson.GET("Salesperson Code");
                //  SalesPersonText := Text000;
                  SalesPersonText:='';
                  SalesPersonText:= Text100 +' ' + SalesPurchPerson.Name;
                  IF SalesPurchPerson."Phone No." <>'' THEN
                  SalesPersonText:= SalesPersonText +' ' +'   '+''+ Text101 +' ' + SalesPurchPerson."Phone No.";
                  IF SalesPurchPerson."E-Mail" <>'' THEN
                  SalesPersonText:= SalesPersonText +' ' +'   '+' '+ SalesPurchPerson.FIELDCAPTION("E-Mail") +' ' + SalesPurchPerson."E-Mail";
                END;

                //Libellé de fin d'AR
                AText200:=Text200;

                IF "VAT Registration No." = '' THEN
                  VATNoText := ''
                ELSE
                  VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                  CodeGCurrency := GLSetup."LCY Code";
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                  CodeGCurrency := "Currency Code";
                END;

                //Adresse à imprimer = adresse de commande et non pas adresse de Facturation
                FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                //FormatAddr.SalesHeaderSellTo(CustAddr,"Sales Header");
                //Fin

                //>>MIGRATION NAV 2013
                RecG_User.RESET ;
                RecG_User.SETRANGE("User Name",ID);
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

                FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                  IF ShipToAddr[i] <> CustAddr[i] THEN
                    ShowShippingAddr := TRUE;

                //Ajout tel et fax fournisseur
                IF customer.GET("Sell-to Customer No.") THEN;
                Tel:=customer."Phone No.";
                Fax:=customer."Fax No.";
                //Fin ajout tel et fax fournisseur


                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);

                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        3,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No."
                        ,"Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                    ELSE
                      SegManagement.LogDocument(
                        3,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                  END;
                END;

                //>>COMPTA_DEEE FG 01/03/07
                RecGBillCustomer.RESET ;
                RecGBillCustomer.GET("Sales Header"."Bill-to Customer No.") ;
                //<<COMPTA_DEEE FG 01/03/07
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
                        Visible = false;
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Visible = false;
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
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
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
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation No.';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        VATAmountLine: Record "290" temporary;
        SalesLine: Record "37" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        ShippingAgent: Record "291";
        SalesCountPrinted: Codeunit "313";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
        DateLiv: Date;
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        SalesPersonText: Text[200];
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
        Text008: Label 'Local Currency';
        CompteurDeLigne: Integer;
        PaymentMethod: Record "289";
        ModeDePayment: Text[30];
        VotreRef: Text[200];
        PrixNet: Decimal;
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        TmpNamereport: Text[100];
        Text016: Label 'INVOICE DEPARTMENT';
        Text030: Label '%1 - %2 - %3 %4';
        Text031: Label 'Tel. :  %1 ';
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        TablesDiverses: Record "50001";
        Langue: Text[10];
        ListeTable: Text[10];
        Text000: Label 'Salesperson';
        customer: Record "18";
        TempGencod: Text[30];
        ItemCrossReference: Record "5717";
        CrossrefNo: Text[20];
        item: Record "27";
        templibelledouanier: Text[30];
        Text100: Label 'Salesperson : ';
        Text101: Label 'Phone :';
        Text200: Label 'If you agree on conditions, please return this order acknowledgement duly signed and stamped';
        AText200: Text[200];
        AText201: Text[200];
        AText202: Text[200];
        AText203: Text[200];
        Fax: Text[30];
        Tel: Text[30];
        Asterisque: Text[1];
        StandardCustomerSalesCode: Record "172";
        StandardSalesLine: Record "171";
        FlagText: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        Country: Record "9";
        Pays: Text[30];
        Text033: Label 'Fax :  %1';
        ModeTransport: Text[50];
        NetaPayer: Decimal;
        surReleve: Text[30];
        Text300: Label 'Order No.';
        CodeGCurrency: Code[10];
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        Text007: Label 'VAT Amount Specification in ';
        CurrExchRate: Record "330";
        CalculatedExchRate: Decimal;
        Text009: Label 'Exchange rate: %1/%2';
        TexG_User_Name: Text[30];
        "-FE005.001:SEBC-": Integer;
        CduGPDFMailMgt: Codeunit "50000";
        CduGFotoWinMgt: Codeunit "50001";
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
        DecGHTUnitTaxLCY: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record "18";
        "--FEP-ADVE-200706_18_A--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label 'Affair No.';
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
        Shipment_departementCaptionLbl: Label 'Shipment departement';
        Sales_Header___Your_Reference_CaptionLbl: Label 'Your Reference :';
        DateCaptionLbl: Label 'Date';
        Customer_No_CaptionLbl: Label 'Customer No.';
        Delivery_DateCaptionLbl: Label 'Delivery requested';
        V_DocumentCaptionLbl: Label 'V/Document';
        InterlocutorCaptionLbl: Label 'Interlocutor';
        MontantCaptionLbl: Label 'Montant';
        Prix_unitaire_HTCaptionLbl: Label 'Prix unitaire HT';
        QuantityCaptionLbl: Label 'Quantity';
        ItemCaptionLbl: Label 'Item';
        Sales_Unit_of_MeasureCaptionLbl: Label 'Sales Unit of Measure';
        ContinuedCaptionLbl: Label 'Continued';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Sales_Line___No___Control1000000219CaptionLbl: Label 'Item : ';
        Category_CaptionLbl: Label 'Category ';
        Nb_Un__DEEECaptionLbl: Label 'Nb Un. DEEE';
        SubtotalCaptionLbl: Label 'Subtotal';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        DOWN_PAYMENTCaptionLbl: Label 'DOWN PAYMENT';
        TOTAL_incl__VATCaptionLbl: Label 'TOTAL incl. VAT';
        Terms_of_PaymentCaptionLbl: Label 'Terms of Payment';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE';
        SIGNATURE__CaptionLbl: Label 'SIGNATURE :';
        SEAL__CaptionLbl: Label 'SEAL :';
        DATE__CaptionLbl: Label 'DATE :';
        Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_CaptionLbl: Label 'Without your agreement by return, we regard these elements as accepted from your part.';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)';
        RecGItemCtg__Weight_Min__Control1000000244CaptionLbl: Label 'Weight Max';
        PaymentTerms_Description_Control1000000188CaptionLbl: Label 'Payment Method:';
        Total_Due_CaptionLbl: Label 'Total Due ';
        "- MIGNAV2013 -": Integer;
        RecG_User: Record "2000000120";
        OutputNo: Integer;
        BooGDescVisible: Boolean;
        BooGDescVisible2: Boolean;
        BooGDescVisible3: Boolean;
        BooGDescVisible4: Boolean;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmount: Decimal;
        TotalAmountVAT: Decimal;
        VATPercentageCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        TotalCaptionLbl: Label 'Total';
        HideReference: Boolean;

    [Scope('Internal')]
    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15.02.2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."RTE Fax Tag"  + TxtLTag + '@cne.fax';
    end;

    [Scope('Internal')]
    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        //>>FE005 MICO LE 15,02,2007
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."PDF Mail Tag" + TxtLTag;
    end;
}

