report 50011 "Sales - Shipment CNE"
{
    // //Creation commercials States CASC 15/12/06 NCS1.01 [FE001V1] : Creation Report
    // //DESIGN DARI 19/01/2007 NSC1.03
    // //DESIGN DARI 29/01/2007 NSC1.04   - Add option : showing Amounts or not showing Amounts
    // //DEfault Value  FLGR 07/02/2007 set default value : change Request form option "Save Values" from yes to NO
    //                                                change ShowAmounts default value to False
    // //TODOLIST POINT 58 FLGR 08/02/2007 : print line with 0 as qty
    // 
    // //FE005 MICO 14/02/2007 :
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
    // //TDL:MICO 13/04/07
    //   - Ajout de code pour ajouter à la TVA, la TVA DEEE.
    // 
    // //TDL: TVA_DEEE DARI 17/04/07 : TVA on DEEE = 0 when the Billed Customer is not submitted to DEEE.
    // 
    // //TDL point 97  - NSC 2.0  DARI 09/05/07 : Add External Document
    // //TDL point 101 - NSC 2.0  DARI 10/05/07 : Design : Modify Rounding of Vat Incl. Total
    // 
    // //>>NSC2.02
    // TDL97.001:ARHA 24/05/2007 : Add External Reference in Sales Shipment Lines
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestin des apples d'offres clients
    //         - Add field "Affaire No"
    // 
    // //>>CNE1.01
    // FE-OLD:MA 03/12/2007 :
    //         -  add GTxtShowAmounts:='' in PageLoop-OnPreDataItem
    // 
    // FEP-ADVE-200706_18_A.002:GR 07/03/2008 : Gestin des apples d'offres clients
    //         - Delete te space caused by printing "Affaire No"
    //         - Add new section : PageLoop, Header (2)
    // 
    // 
    // //>>MODIF HL
    // I007227.001 DO 09/07/2008 : - Modif control Bon de livraison <Control1000000004>
    //                             //>> PageLoop header(1)
    // 
    // //>> MODIF HL 10/10/2012 SU-DADE cf appel TI125406
    // //   Sales Shipment Header - OnAfterGetRecord()
    // //<< MODIF HL 10/10/2012 SU-DADE cf appel TI125406
    // 
    // //TDL.EC04  CNE6.01 Shipment Printed Only shipped Qty
    //                     Skip Line not shipped
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 26:06/2015: Ne pas imprimer informations 2nde société si vide
    // 
    // ------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './SalesShipmentCNE.rdlc';

    Caption = 'Sales - Shipment';

    dataset
    {
        dataitem(DataItem3595; Table110)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
            {
            }
            column(No_SalesShptHeader; "No.")
            {
            }
            column(Prices_Including_VAT; "Prices Including VAT")
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
                    column(N_______Sales_Shipment_Header___No__; 'N° ' + "Sales Shipment Header"."No.")
                    {
                    }
                    column(N_______Sales_Shipment_Header___No__Caption; N_______Sales_Shipment_Header___No__CaptionLbl)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(TexGExternalDocument; TexGExternalDocument)
                    {
                    }
                    column(Sales_Shipment_Header___Your_Reference_; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(Sales_Shipment_Header___External_Document_No__; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(TexG_User_Name; TexG_User_Name)
                    {
                    }
                    column(TxtGTag; TxtGTag)
                    {
                    }
                    column(TexG_User_Name2; TexG_User_Name2)
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
                    column(GTxbShowAmounts; GTxtShowAmounts)
                    {
                    }
                    column(Sales_Shipment_Header___Sell_to_Customer_No__; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(STRSUBSTNO_Text003_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text003, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(FORMAT__Sales_Shipment_Header___Posting_Date__0_4_; FORMAT("Sales Shipment Header"."Posting Date", 0, 4))
                    {
                    }
                    column(STRSUBSTNO_Text004__Sales_Shipment_Header___Order_No____Sales_Shipment_Header___Order_Date__; STRSUBSTNO(Text004, "Sales Shipment Header"."Order No.", "Sales Shipment Header"."Order Date"))
                    {
                    }
                    column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Alt Phone No.", CompanyInfo."Alt Fax No.", CompanyInfo."Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000021; CompanyInfo."Alt Address" + ' ' + CompanyInfo."Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Alt Post Code", CompanyInfo."Alt City"))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."Alt Name")
                    {
                    }
                    column(STRSUBSTNO_Text066_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                    {
                    }
                    column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(DataItem1000000039; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfo__Alt_Home_Page_; CompanyInfo."Alt Home Page")
                    {
                    }
                    column(Sales_Shipment_Header___Sell_to_Customer_No__Caption; Sales_Shipment_Header___Sell_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(InterlocutorCaption; InterlocutorCaptionLbl)
                    {
                    }
                    column(InterlocutorCaption_Control1100267000; InterlocutorCaption_Control1100267000Lbl)
                    {
                    }
                    column(Address_Delivery_Caption; Address_Delivery_CaptionLbl)
                    {
                    }
                    column(STRSUBSTNO_Text004__Sales_Shipment_Header___Order_No____Sales_Shipment_Header___Order_Date__Caption; STRSUBSTNO_Text004__Sales_Shipment_Header___Order_No____Sales_Shipment_Header___Order_Date__CaptionLbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DataItem2502; Table111)
                    {
                        DataItemLink = Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING (Document No., Line No.);
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(Sales_Shipment_Line_Description; Description)
                        {
                        }
                        column(Sales_Shipment_Line__Sales_Shipment_Line__Quantity; "Sales Shipment Line".Quantity)
                        {
                        }
                        column(Sales_Shipment_Line__No__; "No.")
                        {
                        }
                        column(DecGNetPrice; DecGNetPrice)
                        {
                            DecimalPlaces = 0 : 4;
                        }
                        column(DecGLineAmount; DecGLineAmount)
                        {
                        }
                        column(Sales_Shipment_Line__Sales_Shipment_Line___Ordered_Quantity_; "Sales Shipment Line"."Ordered Quantity")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Shipment_Line__Sales_Shipment_Line___Outstanding_Quantity_; "Sales Shipment Line"."Outstanding Quantity")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Shipment_Line__Cross_Reference_No__; "Cross-Reference No.")
                        {
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                            DecimalPlaces = 0 : 4;
                        }
                        column(Sales_Shipment_Line__Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY; "Sales Shipment Line".Quantity * DecGNumbeofUnitsDEEE * DecGHTUnitTaxLCY)
                        {
                        }
                        column(CodGDEEECategoryCode; CodGDEEECategoryCode)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DecGNetPrice_Control1000000182; DecGNetPrice)
                        {
                            DecimalPlaces = 0 : 4;
                        }
                        column(Incl__VAT_Line_AmountCaption; Incl__VAT_Line_AmountCaptionLbl)
                        {
                        }
                        column(Qty_To_shipCaption; Qty_To_shipCaptionLbl)
                        {
                        }
                        column(Ord__QtyCaption; Ord__QtyCaptionLbl)
                        {
                        }
                        column(Net_Price_Incl__VATCaption; Net_Price_Incl__VATCaptionLbl)
                        {
                        }
                        column(QtyCaption; QtyCaptionLbl)
                        {
                        }
                        column(ReferenceCaption; ReferenceCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Incl__VAT_Line_AmountCaption_Control1000000088; Incl__VAT_Line_AmountCaption_Control1000000088Lbl)
                        {
                        }
                        column(Net_Price_Excl__VATCaption; Net_Price_Excl__VATCaptionLbl)
                        {
                        }
                        column(Sales_Shipment_Line__Cross_Reference_No__Caption; FIELDCAPTION("Cross-Reference No."))
                        {
                        }
                        column(DEEE_Contribution___Caption; DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Shipment_Line__No___Control1000000086Caption; Sales_Shipment_Line__No___Control1000000086CaptionLbl)
                        {
                        }
                        column(CodGDEEECategoryCodeCaption; CodGDEEECategoryCodeCaptionLbl)
                        {
                        }
                        column(Sales_Shipment_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Shipment_Line_Line_No_; "Line No.")
                        {
                        }
                        column(BooGVisible; BooGVisible)
                        {
                        }
                        column(ShowAmounts; ShowAmounts)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //"Sales Shipment Line".CALCFIELDS("Ordered Quantity","Delivered Quantity");
                            //>>TODOLIST POINT 58 FLGR 08/02/2007
                            /*
                            IF ("Sales Shipment Line".Type = "Sales Shipment Line".Type :: Item) AND ("Sales Shipment Line".Quantity = 0) THEN
                              CurrReport.SKIP;
                            */
                            //<<TODOLIST POINT 58 FLGR 08/02/2007
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP;

                            // CNE6.01
                            IF NOT (Cust."Shipt Print All Order Line") THEN BEGIN
                                CASE Type OF
                                    Type::Item:
                                        BEGIN
                                            IF (Quantity = 0) THEN BEGIN
                                                ItemLineNo := "Line No.";
                                                CurrReport.SKIP
                                            END ELSE
                                                ItemLineNo := 0;
                                        END;
                                    Type::" ":
                                        BEGIN
                                            IF ("Attached to Line No." <> 0) AND ("Attached to Line No." = ItemLineNo) THEN
                                                CurrReport.SKIP;
                                        END;
                                END;
                            END;

                            SaleLine.RESET;
                            IF SaleLine.GET
                                ("Sales Shipment Line"."Purch. Document Type", "Sales Shipment Line"."Order No.", "Sales Shipment Line"."Order Line No.") THEN
                                ;

                            //>>NSC1.04:DARI 29/01/2007
                            /*//Calculate Net Unit Price and Line Amount
                              DecGNetPriceHT := "Sales Shipment Line"."Unit Price" -
                                                ("Sales Shipment Line"."Unit Price" * "Sales Shipment Line"."Line Discount %" / 100);
                              DecGLineAmount :=DecGNetPriceHT * "Sales Shipment Line".Quantity;
                             */

                            IF (ShowAmounts = TRUE) THEN BEGIN
                                //Calculate Net Unit Price and Line Amount
                                DecGNetPriceHT := "Sales Shipment Line"."Unit Price" -
                                                  ("Sales Shipment Line"."Unit Price" * "Sales Shipment Line"."Line Discount %" / 100);
                                DecGLineAmount := DecGNetPriceHT * "Sales Shipment Line".Quantity;
                                DecGNetPrice :=
                                "Sales Shipment Line"."Unit Price" - ("Sales Shipment Line"."Unit Price" * "Sales Shipment Line"."Line Discount %" / 100)
                            END
                            ELSE BEGIN
                                DecGLineAmount := 0;
                                DecGNetPrice := 0;
                            END;
                            //<<NSC1.04:DARI 29/01/2007

                            //<<FE005:DARI 22/02/2007
                            RecGItem.INIT;
                            IF RecGItem.GET("No.") THEN
                                IF ((RecGItem."DEEE Category Code" <> '') AND (Quantity <> 0)
                                AND (RecGItem."Eco partner DEEE" <> '')) THEN BEGIN
                                    CodGDEEECategoryCode := RecGItem."DEEE Category Code";
                                    DecGNumbeofUnitsDEEE := 0;
                                    //FG
                                    //DecGTotTVADEEE:=0;
                                    DecGNumbeofUnitsDEEE := RecGItem."Number of Units DEEE";
                                    RecGDEEE.RESET;
                                    RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", RecGItem."DEEE Category Code");
                                    //>>TDL:MICO 13/04/07
                                    RecGDEEE.SETFILTER(RecGDEEE."Eco Partner", RecGItem."Eco partner DEEE");
                                    //<<TDL:MICO 13/04/07
                                    RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', "Sales Shipment Header"."Posting Date");
                                    DecGHTUnitTaxLCY := 0;
                                    DecGTVADEEE := 0;
                                    IF RecGDEEE.FIND('+') THEN BEGIN
                                        //>>TDL:MICO 13/04/07
                                        DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)";
                                        DecGTotDEEE := DecGTotDEEE + DecGHTUnitTaxLCY * DecGNumbeofUnitsDEEE * Quantity;
                                        DecGTVADEEE := (DecGHTUnitTaxLCY * DecGNumbeofUnitsDEEE * Quantity) * 19.6 / 100;
                                        DecGTotTVADEEE := DecGTotTVADEEE + DecGTVADEEE;
                                        //<<TDL:MICO 13/04/07
                                    END
                                    ELSE
                                        DecGHTUnitTaxLCY := 0;

                                    //>>COMPTA_DEEE FG 01/03/07
                                    IF NOT ShowAmounts THEN
                                        DecGHTUnitTaxLCY := 0;
                                    //<<COMPTA_DEEE FG 01/03/07
                                END;

                            /*
                             // Création dynamique du tableau récapitulatif
                            IF NOT RecGTempCalcul.GET('',"Purchase Line"."DEEE Category Code",0D)
                               THEN BEGIN
                                    //création d'une ligne
                                    RecGTempCalcul.INIT ;
                                    RecGTempCalcul."Eco Partner":='' ;
                                    RecGTempCalcul."DEEE Code":="Purchase Line"."DEEE Category Code" ;
                                    RecGTempCalcul."Date beginning":=0D ;
                                    RecGTempCalcul."HT Unit Tax (LCY)":="Purchase Line"."DEEE HT Amount" ;
                                    RecGTempCalcul.INSERT ;
                                    END
                            */
                            //>>FE005:DARI 20/02/2007


                            //>>FE005:DARI 22/02/2007

                            //>>COMPTA_DEEE FG 01/03/07
                            IF RecGBillCustomer."Submitted to DEEE" THEN BEGIN
                                BooGVisible := (RecGItem."DEEE Category Code" <> '') AND (Quantity <> 0) AND (RecGItem."Eco partner DEEE" <> '')
                            END ELSE BEGIN
                                BooGVisible := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07

                        end;

                        trigger OnPostDataItem()
                        var
                            RecLSaleShipmentHeader: Record "110";
                            RecLSaleShipmentLine: Record "111";
                            DecLUnitPriceNet: Decimal;
                        begin
                            //>>MIGRATION NAV 2013
                            RecLSaleShipmentLine.RESET;
                            RecLSaleShipmentLine.SETFILTER("Document No.", "Document No.");
                            IF RecLSaleShipmentLine.FINDFIRST THEN BEGIN
                                RecLSaleShipmentHeader.SETFILTER("No.", RecLSaleShipmentLine."Document No.");
                                IF RecLSaleShipmentHeader.FINDFIRST THEN BEGIN
                                    IF NOT RecLSaleShipmentHeader."Prices Including VAT" THEN BEGIN
                                        REPEAT
                                            DecGTotAmountHT := DecGTotAmountHT +
                                                               RecLSaleShipmentLine."Unit Price"
                                                               * (1 - RecLSaleShipmentLine."Line Discount %" / 100)
                                                               * RecLSaleShipmentLine.Quantity;
                                            IF RecLSaleShipmentLine.Quantity <> 0 THEN
                                                DecGTotTVA := DecGTotTVA
                                                              + RecLSaleShipmentLine."Unit Price"
                                                              * (1 - RecLSaleShipmentLine."Line Discount %" / 100)
                                                              * RecLSaleShipmentLine."VAT %" / 100
                                                              * RecLSaleShipmentLine.Quantity;
                                        UNTIL RecLSaleShipmentLine.NEXT = 0;
                                        DecGTotAmountTTC := DecGTotAmountHT + DecGTotTVA;
                                    END
                                    ELSE BEGIN
                                        REPEAT
                                            DecGTotAmountHT := DecGTotAmountHT +
                                                               RecLSaleShipmentLine."Unit Price"
                                                               / (1 + RecLSaleShipmentLine."VAT %" / 100)
                                                               * (1 - RecLSaleShipmentLine."Line Discount %" / 100)
                                                               * RecLSaleShipmentLine.Quantity;
                                            /*        DecGTotAmountTTC := DecGTotAmountTTC +
                                                                        RecLSaleShipmentLine."Unit Price"
                                                                        * (1 - RecLSaleShipmentLine."Line Discount %" / 100)
                                                                        * RecLSaleShipmentLine.Quantity;
                                            */
                                            IF RecLSaleShipmentLine.Quantity <> 0 THEN
                                                DecGTotTVA := DecGTotTVA +
                                                              RecLSaleShipmentLine."Unit Price" / (1 + RecLSaleShipmentLine."VAT %" / 100)
                                                              * (1 - RecLSaleShipmentLine."Line Discount %" / 100)
                                                              * RecLSaleShipmentLine.Quantity
                                                              * (RecLSaleShipmentLine."VAT %" / 100);
                                        UNTIL RecLSaleShipmentLine.NEXT = 0;
                                        DecGTotAmountTTC := DecGTotTVA + DecGTotAmountHT;
                                    END;
                                END;
                            END;
                            //<<MIGRATION NAV 2013

                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            //>>TODOLIST POINT 58 FLGR 08/02/2007
                            //WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                            WHILE MoreLines AND (Description = '') AND ("No." = '') DO
                                //>>TODOLIST POINT 58 FLGR 08/02/2007
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");

                            //<<FE005:DARI 23/02/2007
                            DecGTotDEEE := 0;
                            //<<FE005:DARI 23/02/2007

                            //>>MIGRATION NAV 2013
                            DecGTotAmountTTC := 0;
                            DecGTotAmountHT := 0;
                            DecGTotTVA := 0;
                            //<<MIGRATION NAV 2013
                        end;
                    }
                    dataitem("DEEE Tariffs"; Table50007)
                    {
                        DataItemTableView = SORTING (Eco Partner, DEEE Code, Date beginning);
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; "DEEE Tariffs"."DEEE Code")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000172; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; "DEEE Tariffs"."HT Unit Tax (LCY)")
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
                        column(DEEE_Tariffs_Eco_Partner; "Eco Partner")
                        {
                        }
                        column(DEEE_Tariffs_Date_beginning; "Date beginning")
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            //>>COMPTA_DEEE FG 01/03/07
                            IF NOT RecGBillCustomer."Submitted to DEEE" THEN
                                CurrReport.BREAK;
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(PaymentMethod_Description___________PaymentTerms_Description; PaymentMethod.Description + '  ' + PaymentTerms.Description)
                        {
                        }
                        column(DecGTotAmountHT; ROUND(DecGTotAmountHT, 0.01))
                        {
                        }
                        column(DecGTotTVA_DecGTotTVADEEE; ROUND(DecGTotTVA + DecGTotTVADEEE, 0.01))
                        {
                            AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ROUND_DecGTotAmountTTC_DecGTotDEEE_DecGTotTVADEEE_0_01_____; ROUND(DecGTotAmountTTC + DecGTotDEEE + DecGTotTVADEEE, 0.01, '<'))
                        {
                        }
                        column(DecGTotDEEE; ROUND(DecGTotDEEE, 0.01))
                        {
                        }
                        column(DecGTotAmountHT_DecGTotDEEE; ROUND(DecGTotAmountHT + DecGTotDEEE, 0.01))
                        {
                        }
                        column(PaymentMethod_Description___________PaymentTerms_DescriptionCaption; PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(Total_Net_HTCaption; Total_Net_HTCaptionLbl)
                        {
                        }
                        column(DecGTotTVA_DecGTotTVADEEECaption; DecGTotTVA_DecGTotTVADEEECaptionLbl)
                        {
                        }
                        column(ROUND_DecGTotAmountTTC_DecGTotDEEE_DecGTotTVADEEE_0_01_____Caption; ROUND_DecGTotAmountTTC_DecGTotDEEE_DecGTotTVADEEE_0_01_____CaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                    }
                    dataitem(Total2; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCustAddr THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>>TDL:MICO 16/04/2007
                        DecGTotTVADEEE := 0;
                        //<<TDL:MICO 16/04/2007
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record "167";
                    begin
                        //<<CNE1.01
                        GTxtShowAmounts := '';
                        //>>CNE1.01

                        //<<CNE1.00
                        IF "Sales Shipment Header"."Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text071;
                            TxtGNoProjet := "Sales Shipment Header"."Affair No.";
                            RecGJob.GET("Sales Shipment Header"."Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;
                        //>>CNE1.00
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                    SaleShipmentLine: Record "111";
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                //RecG_User.RESET ;

                //>> 10/10/2012 SU-DADE cf appel TI125406

                // OLD CODE
                /*
                IF RecG_User.GET ( "User ID")
                THEN
                  TexG_User_Name := RecG_User.Name
                ELSE
                  TexG_User_Name := '';
                */
                // NEW CODE

                //>>MIGRATION NAV 2013
                RecG_User.RESET;
                RecG_User.SETRANGE("User Name", ID);
                IF RecG_User.FINDFIRST THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';

                RecG_User.RESET;
                RecG_User.SETRANGE("User Name", "User ID");
                IF RecG_User.FINDFIRST THEN
                    TexG_User_Name2 := RecG_User."Full Name"
                ELSE
                    TexG_User_Name2 := '';
                //<<MIGRATION NAV 2013

                //<< 10/10/2012 SU-DADE cf appel TI125406

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");


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
                //<<NSC 2.0 09/05/07
                IF "External Document No." = '' THEN
                    TexGExternalDocument := ''
                ELSE
                    TexGExternalDocument := FIELDCAPTION("External Document No.");
                //>>NSC 2.0 09/05/07

                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");

                FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR i := 1 TO ARRAYLEN(CustAddr) DO
                    IF CustAddr[i] <> ShipToAddr[i] THEN
                        ShowCustAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                //>>COMPTA_DEEE FG 01/03/07
                RecGBillCustomer.RESET;
                RecGBillCustomer.GET("Sales Shipment Header"."Bill-to Customer No.");
                //<<COMPTA_DEEE FG 01/03/07

                //>> 28.03.2012 Show Amount
                CASE ShowAmountType OF
                    ShowAmountType::Yes:
                        ShowAmounts := TRUE;
                    ShowAmountType::No:
                        ShowAmounts := FALSE;
                    ShowAmountType::Customer:
                        BEGIN
                            CLEAR(Cust);
                            IF Cust.GET("Sell-to Customer No.") THEN
                                ShowAmounts := NOT (Cust."Not Valued Shipment");
                        END
                    ELSE
                        ShowAmounts := TRUE;
                END;

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
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines';
                    }
                    field(ShowAmountType; ShowAmountType)
                    {
                        Caption = 'Valoriser le BL';
                        OptionCaption = 'Oui,Non,Paramètre client';
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
        CompanyInfo.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo.CALCFIELDS(Picture);
                    CompanyInfo.CALCFIELDS("Alt Picture");
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                    CompanyInfo1.CALCFIELDS("Alt Picture");
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                    CompanyInfo2.CALCFIELDS("Alt Picture");
                END;
        END;

        //>>DEfault Value  FLGR 07/02/2007
        //>>NSC1.04:DARI 29/01/2007
        // ShowAmounts := TRUE;
        ShowAmountType := 2;
        //<<NSC1.04:DARI 29/01/2007
        //<<DEfault Value  FLGR 07/02/2007
        //
        NoOfCopies := 1;
        //
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        //>>NSC1.04:DARI 29/01/2007
        IF (ShowAmounts = TRUE) THEN
            GTxtShowAmounts := Text070
        ELSE
            GTxtShowAmounts := Text069;
        //<<NSC1.04:DARI 29/01/2007
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'COPY';
        Text002: Label 'Sales - Shipment %1';
        Text003: Label 'Page %1';
        GLSetup: Record "98";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        SalesSetup: Record "311";
        Language: Record "8";
        SaleLine: Record "37";
        ShipmentMethod: Record "10";
        PaymentMethod: Record "289";
        PaymentTerms: Record "3";
        ShptCountPrinted: Codeunit "314";
        SegManagement: Codeunit "5051";
        RespCenter: Record "5714";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[30];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        i: Integer;
        FormatAddr: Codeunit "365";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        Text004: Label 'Order %1 of %2';
        DecGNetPriceHT: Decimal;
        DecGLineAmount: Decimal;
        DecGUnitPriceNet: Decimal;
        DecGTotAmountHT: Decimal;
        DecGTotAmountTTC: Decimal;
        DecGTotTVA: Decimal;
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        VALExchRate: Text[50];
        CurrExchRate: Record "330";
        TexG_User_Name2: Text[30];
        TexG_User_Name: Text[30];
        "-- NSC 1.04 : ShowAmounts": Integer;
        ShowAmounts: Boolean;
        DecGNetPrice: Decimal;
        Text069: Label 'BL non chiffré';
        GTxtShowAmounts: Text[30];
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
        CodGDEEECategoryCode: Code[10];
        DecGHTUnitTaxLCY: Decimal;
        DecGTotDEEE: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record "18";
        "-MICO-": Integer;
        DecGTotTVADEEE: Decimal;
        DecGTVADEEE: Decimal;
        "--NSC2.0": Integer;
        TexGExternalDocument: Text[30];
        "--FEP-ADVE-200706_18_A.--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: ;
        Text071: Label 'Affair No. : ';
        ShowAmountType: Option Yes,No,Customer;
        Cust: Record "18";
        Sales_Shipment_Header___Sell_to_Customer_No__CaptionLbl: Label 'Customer No.';
        N_______Sales_Shipment_Header___No__CaptionLbl: Label 'Delivery Order';
        InterlocutorCaptionLbl: Label 'Interlocutor';
        InterlocutorCaption_Control1100267000Lbl: Label 'Interlocutor';
        Address_Delivery_CaptionLbl: Label 'Address Delivery:';
        STRSUBSTNO_Text004__Sales_Shipment_Header___Order_No____Sales_Shipment_Header___Order_Date__CaptionLbl: Label 'Ours Reference:';
        Incl__VAT_Line_AmountCaptionLbl: Label 'Incl. VAT Line Amount';
        Ord__QtyCaptionLbl: Label 'Ord. Qty';
        Net_Price_Incl__VATCaptionLbl: Label 'Net Price Incl. VAT';
        QtyCaptionLbl: Label 'Qty';
        ReferenceCaptionLbl: Label 'Reference';
        DescriptionCaptionLbl: Label 'Description';
        Incl__VAT_Line_AmountCaption_Control1000000088Lbl: Label 'Incl. VAT Line Amount';
        Qty_To_shipCaptionLbl: Label 'Qty To ship';
        Net_Price_Excl__VATCaptionLbl: Label 'Net Price Excl. VAT';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ';
        Sales_Shipment_Line__No___Control1000000086CaptionLbl: Label 'Item : ';
        CodGDEEECategoryCodeCaptionLbl: Label ' -   Category :';
        DEEE_Contribution___Caption_Control1000000121Lbl: Label 'DEEE Contribution : ';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)';
        RecGItemCtg__Weight_Min__Control1000000172CaptionLbl: Label 'Weight Max';
        PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method:';
        Total_Net_HTCaptionLbl: Label 'Total Net HT';
        DecGTotTVA_DecGTotTVADEEECaptionLbl: Label 'VAT';
        ROUND_DecGTotAmountTTC_DecGTotDEEE_DecGTotTVADEEE_0_01_____CaptionLbl: Label 'Incl. VAT Net Total';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE';
        [InDataSet]
        LogInteractionEnable: Boolean;
        OutputNo: Integer;
        BooGVisible: Boolean;
        RecG_User: Record "2000000120";
        ItemLineNo: Integer;

    [Scope('Internal')]
    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    [Scope('Internal')]
    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 DARI 23/02/07  - Output Error corrected
        //CurrReport.SHOWOUTPUT("Sales Invoice Line"."Eco partner DEEE" <> '');
        //<<FE005 DARI 23/02/07
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

