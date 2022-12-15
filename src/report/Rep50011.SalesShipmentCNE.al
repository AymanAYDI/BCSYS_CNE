report 50011 "BC6_Sales - Shipment CNE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesShipmentCNE.rdlc';

    Caption = 'Sales - Shipment', Comment = 'FRA="Ventes : Expédition"';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment', Comment = 'FRA="Expédition vente enregistrée"';
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
            {
            }
            column(No_SalesShptHeader; "No.")
            {
            }
            column(Prices_Including_VAT; "Prices Including VAT")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000021; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
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
                    column(CompanyInfo__Alt_Home_Page_; CompanyInfo."BC6_Alt Home Page")
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
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
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
                        column(Sales_Shipment_Line__Sales_Shipment_Line___Ordered_Quantity_; "Sales Shipment Line"."BC6_Ordered Quantity")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Shipment_Line__Sales_Shipment_Line___Outstanding_Quantity_; "Sales Shipment Line"."BC6_Outstanding Quantity")
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
                            IF NOT (Cust."BC6_Shipt Print All Order Line") THEN BEGIN
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
                                ("Sales Shipment Line"."BC6_Purch. Document Type", "Sales Shipment Line"."Order No.", "Sales Shipment Line"."Order Line No.") THEN
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
                                IF ((RecGItem."BC6_DEEE Category Code" <> '') AND (Quantity <> 0)
                                AND (RecGItem."BC6_Eco partner DEEE" <> '')) THEN BEGIN
                                    CodGDEEECategoryCode := RecGItem."BC6_DEEE Category Code";
                                    DecGNumbeofUnitsDEEE := 0;
                                    //FG
                                    //DecGTotTVADEEE:=0;
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE";
                                    RecGDEEE.RESET;
                                    RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", RecGItem."BC6_DEEE Category Code");
                                    //>>TDL:MICO 13/04/07
                                    RecGDEEE.SETFILTER(RecGDEEE."Eco Partner", RecGItem."BC6_Eco partner DEEE");
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
                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN BEGIN
                                BooGVisible := (RecGItem."BC6_DEEE Category Code" <> '') AND (Quantity <> 0) AND (RecGItem."BC6_Eco partner DEEE" <> '')
                            END ELSE BEGIN
                                BooGVisible := FALSE;
                            END;
                            //<<COMPTA_DEEE FG 01/03/07

                        end;

                        trigger OnPostDataItem()
                        var
                            RecLSaleShipmentHeader: Record "Sales Shipment Header";
                            RecLSaleShipmentLine: Record "Sales Shipment Line";
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
                    dataitem("DEEE Tariffs"; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");
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
                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK;
                            //<<COMPTA_DEEE FG 01/03/07

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
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
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

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
                        RecGJob: Record Job;
                    begin
                        //<<CNE1.01
                        GTxtShowAmounts := '';
                        //>>CNE1.01

                        //<<CNE1.00
                        IF "Sales Shipment Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text071;
                            TxtGNoProjet := "Sales Shipment Header"."BC6_Affair No.";
                            RecGJob.GET("Sales Shipment Header"."BC6_Affair No.");
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
                    SalesPost: Codeunit "Sales-Post";
                    SaleShipmentLine: Record "Sales Shipment Line";
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
                RecG_User.SETRANGE("User Name", BC6_ID);
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
                                ShowAmounts := NOT (Cust."BC6_Not Valued Shipment");
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
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines', Comment = 'FRA="Afficher lignes correction"';
                    }
                    field(ShowAmountType; ShowAmountType)
                    {
                        Caption = 'Valoriser le BL', Comment = 'FRA="Valoriser le BL"';
                        OptionCaption = 'Yes,No,Customer setting', Comment = 'FRA="Oui,Non,Paramètre client"';
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
                    CompanyInfo.CALCFIELDS("BC6_Alt Picture");
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                    CompanyInfo1.CALCFIELDS("BC6_Alt Picture");
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                    CompanyInfo2.CALCFIELDS("BC6_Alt Picture");
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
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'COPY', Comment = 'FRA="COPIE"';
        Text002: Label 'Sales - Shipment %1', Comment = 'FRA="Ventes : Expédition %1"';
        Text003: Label 'Page %1', Comment = 'FRA="Page %1"';
        GLSetup: Record "General Ledger Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Language: Codeunit Language;
        SaleLine: Record "Sales Line";
        ShipmentMethod: Record "Shipment Method";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        RespCenter: Record "Responsibility Center";
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
        FormatAddr: Codeunit "Format Address";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        Text004: Label 'Order %1 of %2', Comment = 'FRA="Commande %1 du %2"';
        DecGNetPriceHT: Decimal;
        DecGLineAmount: Decimal;
        DecGUnitPriceNet: Decimal;
        DecGTotAmountHT: Decimal;
        DecGTotAmountTTC: Decimal;
        DecGTotTVA: Decimal;
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        VALExchRate: Text[50];
        CurrExchRate: Record "Currency Exchange Rate";
        TexG_User_Name2: Text[30];
        TexG_User_Name: Text[30];
        "-- NSC 1.04 : ShowAmounts": Integer;
        ShowAmounts: Boolean;
        DecGNetPrice: Decimal;
        Text069: Label 'BL non chiffré', Comment = 'FRA="BL non chiffré"';
        GTxtShowAmounts: Text[30];
        TxtGTag: Text[50];
        RecGParamVente: Record "Sales & Receivables Setup";
        "-DEEE1.00-": Integer;
        RecGSalesInvLine: Record "Sales Invoice Line";
        BooGDEEEFind: Boolean;
        RecGDEEE: Record "BC6_DEEE Tariffs";
        RecGItemCtg: Record "BC6_Categories of item";
        RecGTempCalcul: Record "BC6_DEEE Tariffs" temporary;
        DecGVATTotalAmount: Decimal;
        DecGTTCTotalAmount: Decimal;
        RecGItem: Record Item;
        DecGNumbeofUnitsDEEE: Decimal;
        CodGDEEECategoryCode: Code[10];
        DecGHTUnitTaxLCY: Decimal;
        DecGTotDEEE: Decimal;
        "--FG--": Integer;
        RecGBillCustomer: Record Customer;
        "-MICO-": Integer;
        DecGTotTVADEEE: Decimal;
        DecGTVADEEE: Decimal;
        "--NSC2.0": Integer;
        TexGExternalDocument: Text[30];
        "--FEP-ADVE-200706_18_A.--": Integer;
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        TxtGDesignation: Text[50];
        Text070: Label '';
        Text071: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        ShowAmountType: Option Yes,No,Customer;
        Cust: Record Customer;
        Sales_Shipment_Header___Sell_to_Customer_No__CaptionLbl: Label 'Customer No.', Comment = 'FRA="N° client"';
        N_______Sales_Shipment_Header___No__CaptionLbl: Label 'Delivery Order', Comment = 'FRA="Bon de livraison"';
        InterlocutorCaptionLbl: Label 'Interlocutor', Comment = 'FRA="Interlocuteur"';
        InterlocutorCaption_Control1100267000Lbl: Label 'Interlocutor', Comment = 'FRA="Préparateur"';
        Address_Delivery_CaptionLbl: Label 'Address Delivery:', Comment = 'FRA="Adresse de livraison :"';
        STRSUBSTNO_Text004__Sales_Shipment_Header___Order_No____Sales_Shipment_Header___Order_Date__CaptionLbl: Label 'Ours Reference:', Comment = 'FRA="Notre référence : "';
        Incl__VAT_Line_AmountCaptionLbl: Label 'Incl. VAT Line Amount', Comment = 'FRA="Montant ligne TTC"';
        Ord__QtyCaptionLbl: Label 'Ord. Qty', Comment = 'FRA="Qté cdée"';
        Net_Price_Incl__VATCaptionLbl: Label 'Net Price Incl. VAT', Comment = 'FRA="Prix Net TTC"';
        QtyCaptionLbl: Label 'Qty', Comment = 'FRA="Qté livrée"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        Incl__VAT_Line_AmountCaption_Control1000000088Lbl: Label 'Incl. VAT Line Amount', Comment = 'FRA="Montant ligne HT"';
        Qty_To_shipCaptionLbl: Label 'Qty To ship', Comment = 'FRA="Qté restante"';
        Net_Price_Excl__VATCaptionLbl: Label 'Net Price Excl. VAT', Comment = 'FRA="Prix Net HT"';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        Sales_Shipment_Line__No___Control1000000086CaptionLbl: Label 'Item : ', Comment = 'FRA="Art. : "';
        CodGDEEECategoryCodeCaptionLbl: Label ' -   Category :', Comment = 'FRA=" -   Catégorie :"';
        DEEE_Contribution___Caption_Control1000000121Lbl: Label 'DEEE Contribution : ', Comment = 'FRA="Contribution DEEE : "';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category', Comment = 'FRA="Catégorie"';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min', Comment = 'FRA="Poids Min"';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)', Comment = 'FRA="Coût Unitaire HT (DS)"';
        RecGItemCtg__Weight_Min__Control1000000172CaptionLbl: Label 'Weight Max', Comment = 'FRA="Poids Max"';
        PaymentMethod_Description___________PaymentTerms_DescriptionCaptionLbl: Label 'Payment Method:', Comment = 'FRA="Mode de réglement :"';
        Total_Net_HTCaptionLbl: Label 'Total Net HT', Comment = 'FRA="Total Net HT"';
        DecGTotTVA_DecGTotTVADEEECaptionLbl: Label 'VAT', Comment = 'FRA="TVA"';
        ROUND_DecGTotAmountTTC_DecGTotDEEE_DecGTotTVADEEE_0_01_____CaptionLbl: Label 'Incl. VAT Net Total', Comment = 'FRA="Total Net TTC"';
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', Comment = 'FRA="Total Eco-Contribution HT"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', Comment = 'FRA="Total HT DEEE comprise"';
        [InDataSet]
        LogInteractionEnable: Boolean;
        OutputNo: Integer;
        BooGVisible: Boolean;
        RecG_User: Record User;
        ItemLineNo: Integer;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        //>>FE005 DARI 23/02/07  - Output Error corrected
        //CurrReport.SHOWOUTPUT("Sales Invoice Line"."Eco partner DEEE" <> '');
        //<<FE005 DARI 23/02/07
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

