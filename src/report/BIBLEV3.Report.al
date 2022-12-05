report 50058 "BIBLE V3"
{
    // //The Bible [FE020.V2] : Creation Report
    // //The Bible CASC [FE020.V2] 10/01/2007 : Modification report
    //                                          - Add Fields Discount Excluding VAT Unit Price
    //                                            Line Amount Excluding VAT
    //                                            Profit Amount
    //                                            % Profit
    // //The Bible CASC [FE020.V2] 17/01/2007 : Modify calculation of charge amount
    // //The Bible FLGR [FE020.V2] 20/02/2007 : Modify calculation of "total BL + commande" / montant frais from :
    //                                                DecGTotPeriod2Exp + DecGTotBLExpAmount - DecGTotOrderAmount
    //                                                to DecGTotBLExpAmount  +  DecGTotPeriod2Exp
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //TODOLIST DARI 07/03/2007 point 70 -- "Date filter" on "Sales Header".Posting Date =>  "Sales Header"."Shipment Date"
    // //TODOLIST DARI 08/03/2007 point 70 - Evolution from  "Sales Header"."Shipment Date" to "Sales Line"."Shipment Date"
    // 
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - add 'D' if derogation
    // 
    // //>>CNE5.00
    // TDL.84/CSC 02/12/2013 : NAV 2013 designing
    DefaultLayout = RDLC;
    RDLCLayout = './BIBLEV3.rdlc';


    dataset
    {
        dataitem(DataItem5444; Table2000000026)
        {
            DataItemTableView = SORTING (Number)
                                WHERE (Number = FILTER (1));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(BL_____FORMAT_DatGStartingDateShipment_______FORMAT_DatGEndingDateShipment_; 'BL : ' + FORMAT(DatGStartingDateShipment) + '..' + FORMAT(DatGEndingDateShipment))
            {
            }
            column(Commande_____FORMAT_DatGStartingDateOrder_______FORMAT_DatGEndingDateOrder_; 'Commande : ' + FORMAT(DatGStartingDateOrder) + '..' + FORMAT(DatGEndingDateOrder))
            {
            }
            column(Total_BL_et_Commande__; 'Total BL et Commande ')
            {
            }
            column(DecGTotPeriod2Amount___DecGTotOrderAmount; DecGTotPeriod2Amount + DecGTotOrderAmount)
            {
            }
            column(DecGTotPeriod2Profit___DecGTotOrderProfit; DecGTotPeriod2Profit + DecGTotOrderProfit)
            {
            }
            column(DecGTotMarge; DecGTotMarge)
            {
            }
            column(DecGTotBLExpAmount_____DecGTotPeriod2Exp; DecGTotBLExpAmount + DecGTotPeriod2Exp)
            {
            }
            column(Customer___Top_10_ListCaption; Customer___Top_10_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(Delivery_OrderCaption; Delivery_OrderCaptionLbl)
            {
            }
            column(DecGPourcProfitCaption; DecGPourcProfitCaptionLbl)
            {
            }
            column(DeGTotalAmountCaption; DeGTotalAmountCaptionLbl)
            {
            }
            column(DecGTotalProfitCaption; DecGTotalProfitCaptionLbl)
            {
            }
            column(DecGPourTotalProfitCaption; DecGPourTotalProfitCaptionLbl)
            {
            }
            column(DecGChargeAmountCaption; DecGChargeAmountCaptionLbl)
            {
            }
            column(Sales_Shipment_Line__No__Caption; "Sales Shipment Line".FIELDCAPTION("No."))
            {
            }
            column(Sales_Shipment_Line_DescriptionCaption; "Sales Shipment Line".FIELDCAPTION(Description))
            {
            }
            column(Sales_Shipment_Line__Qty__Shipped_Not_Invoiced_Caption; "Sales Shipment Line".FIELDCAPTION("Qty. Shipped Not Invoiced"))
            {
            }
            column(RecGSaleLine__Discount_unit_price_Caption; RecGSaleLine__Discount_unit_price_CaptionLbl)
            {
            }
            column(Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price_Caption; Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price_CaptionLbl)
            {
            }
            column(DataItem1100267009; Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price____RecGSaleLine__Purchase_cost__CaptionLbl)
            {
            }
            column(Sales_Shipment_Header__No__Caption; "Sales Shipment Header".FIELDCAPTION("No."))
            {
            }
            column(Total_BL___FORMAT_DatGStartingDateShipment_______FORMAT_DatGEndingDateShipment_; 'Total BL ' + FORMAT(DatGStartingDateShipment) + '..' + FORMAT(DatGEndingDateShipment))
            {
            }
            column(Total_BL___FORMAT_DatGStartingDateOrder_______FORMAT_DatGEndingDateOrder_; 'Total BL ' + FORMAT(DatGStartingDateOrder) + '..' + FORMAT(DatGEndingDateOrder))
            {
            }
            column(Sales_Line__Sales_Line___No__Caption; Sales_Line__Sales_Line___No__CaptionLbl)
            {
            }
            column(Sales_Line__Sales_Line__DescriptionCaption; Sales_Line__Sales_Line__DescriptionCaptionLbl)
            {
            }
            column(Sales_Line__Sales_Line___Outstanding_Quantity_Caption; Sales_Line__Sales_Line___Outstanding_Quantity_CaptionLbl)
            {
            }
            column(Sales_Line__Sales_Line___Discount_unit_price_Caption; Sales_Line__Sales_Line___Discount_unit_price_CaptionLbl)
            {
            }
            column(Sales_Line___Outstanding_Quantity_____Sales_Line___Discount_unit_price_Caption; Sales_Line___Outstanding_Quantity_____Sales_Line___Discount_unit_price_CaptionLbl)
            {
            }
            column(Sales_Line___Outstanding_Quantity______Sales_Line___Discount_unit_price_____Sales_Line___Purchase_cost__Caption; Sales_Line___Outstanding_Quantity______Sales_Line___Discount_unit_price_____Sales_Line___Purchase_cost__CaptionLbl)
            {
            }
            column(DecGOrderPourCaption; DecGOrderPourCaptionLbl)
            {
            }
            column(Sales_Header__Sales_Header___No__Caption; "Sales Header".FIELDCAPTION("No."))
            {
            }
            column(Sales_Header__Sales_Header___Posting_Date_Caption; "Sales Header".FIELDCAPTION("Posting Date"))
            {
            }
            column(Sales_Header__Sales_Header___Sell_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
            {
            }
            column(Sales_Header__Sales_Header___Bill_to_Name_Caption; "Sales Header".FIELDCAPTION("Bill-to Name"))
            {
            }
            column(DecGTotalOrderAmountCaption; DecGTotalOrderAmountCaptionLbl)
            {
            }
            column(DecGTotalOrderProfitCaption; DecGTotalOrderProfitCaptionLbl)
            {
            }
            column(DecGTotalOrderPourCaption; DecGTotalOrderPourCaptionLbl)
            {
            }
            column(DecGTotOrderexpAmountCaption; DecGTotOrderexpAmountCaptionLbl)
            {
            }
            column(OrderCaption; OrderCaptionLbl)
            {
            }
            dataitem(DataItem3595; Table110)
            {
                DataItemTableView = SORTING (Sell-to Customer No., External Document No.);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                column(Sales_Shipment_Header__No__; "No.")
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Shipment_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
                {
                }
                column(DeGTotalAmount; DeGTotalAmount)
                {
                }
                column(DecGTotalProfit; DecGTotalProfit)
                {
                }
                column(DecGPourTotalProfit; DecGPourTotalProfit)
                {
                }
                column(DecGChargeAmount; DecGChargeAmount)
                {
                }
                column(DecGTotBLAmount; DecGTotBLAmount)
                {
                }
                column(DecGTotBLProfit; DecGTotBLProfit)
                {
                }
                column(DecGTotBLPourcProf; DecGTotBLPourcProf)
                {
                }
                column(DecGTotExpAmount; DecGTotExpAmount)
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Sales_Shipment_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                column(Sales_Shipment_Header__Sell_to_Customer_Name_Caption; FIELDCAPTION("Sell-to Customer Name"))
                {
                }
                dataitem(DataItem2502; Table111)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    DataItemTableView = SORTING (Document No., Sell-to Customer No., No.)
                                        WHERE (Type = FILTER (Item),
                                              Quantity = FILTER (<> 0),
                                              Qty. Shipped Not Invoiced=FILTER(<>0));
                    column(Sales_Shipment_Line__No__;"No.")
                    {
                    }
                    column(Sales_Shipment_Line_Description;Description)
                    {
                    }
                    column(Sales_Shipment_Line__Qty__Shipped_Not_Invoiced_;"Qty. Shipped Not Invoiced")
                    {
                    }
                    column(RecGSaleLine__Discount_unit_price_;RecGSaleLine."Discount unit price")
                    {
                    }
                    column(Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price_;"Sales Shipment Line"."Qty. Shipped Not Invoiced" *  RecGSaleLine."Discount unit price")
                    {
                    }
                    column(Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price____RecGSaleLine__Purchase_cost__;"Sales Shipment Line"."Qty. Shipped Not Invoiced" * (RecGSaleLine."Discount unit price" - RecGSaleLine."Purchase cost"))
                    {
                    }
                    column(DecGPourcProfit;DecGPourcProfit)
                    {
                    }
                    column(TxtGDerogation;TxtGDerogation)
                    {
                    }
                    column(Sales_Shipment_Line_Document_No_;"Document No.")
                    {
                    }
                    column(Sales_Shipment_Line_Line_No_;"Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        RecLSaleHeader: Record "36";
                        decLLineAmount: Decimal;
                    begin
                        RecGSaleLine.RESET;
                        IF RecGSaleLine.GET(RecGSaleLine."Document Type" :: Order,
                                            "Sales Shipment Line"."Order No.","Sales Shipment Line"."Order Line No.") THEN;

                              IF RecGSaleLine."No."='BL175491' THEN
                              DeGTotalAmount := 0;

                        decLLineAmount := RecGSaleLine."Discount unit price" * "Sales Shipment Line"."Qty. Shipped Not Invoiced";
                        IF decLLineAmount <> 0 THEN
                          //DecGPourcProfit := "Sales Shipment Line"."Qty. Shipped Not Invoiced" *
                          //                   (RecGSaleLine."Discount unit price" - RecGSaleLine."Purchase cost") / decLLineAmount * 100

                          DecGPourcProfit := (RecGSaleLine."Discount unit price" - RecGSaleLine."Purchase cost") / RecGSaleLine."Discount unit price" *
                        100


                        ELSE
                          decLLineAmount := 0;


                        //>>FEP-ADVE-200711_21_A-DEROGATOIRE
                        IF "Sales Shipment Line"."Dispensation No." <> '' THEN
                           TxtGDerogation := 'D'
                        ELSE
                           CLEAR(TxtGDerogation);
                        //<<FEP-ADVE-200711_21_A-DEROGATOIRE
                    end;

                    trigger OnPreDataItem()
                    begin
                        DecGDiscountUnitPrice := 0;
                        DecGProfitAmount := 0;
                        DecGPourcProfit := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    RecLSalesLine: Record "37";
                    RecLSaleShipLine: Record "111";
                    RecLSalesHeader: Record "36";
                    RecLSaleShipLine2: Record "111";
                    RecLSalesLine2: Record "37";
                begin
                    IF NOT ("Sales Shipment Header"."Posting Date" IN [DatGStartingDateShipment..DatGEndingDateShipment]) THEN
                      CurrReport.SKIP ;

                    DeGTotalAmount := 0;
                    DecGTotalProfit := 0;
                    DecGPourTotalProfit := 0;
                    DecGAmount := 0;

                    RecLSaleShipLine.SETFILTER("Document No.","No.");
                    RecLSaleShipLine.SETRANGE(Type,RecLSalesLine.Type :: Item);
                    RecLSaleShipLine.SETFILTER(Quantity,'<>%1',0);
                    RecLSaleShipLine.SETFILTER("Qty. Shipped Not Invoiced",'<>%1',0);
                    IF RecLSaleShipLine.FINDFIRST THEN

                        IF RecLSaleShipLine."No."='BL175491' THEN
                          DeGTotalAmount := 0;

                    REPEAT
                      RecLSalesLine.RESET;
                      IF RecLSalesLine.GET(RecLSalesLine."Document Type" :: Order,RecLSaleShipLine."Order No.",
                                           RecLSaleShipLine."Order Line No.") THEN
                      BEGIN
                        DeGTotalAmount := DeGTotalAmount + RecLSalesLine."Discount unit price" * RecLSaleShipLine."Qty. Shipped Not Invoiced";
                        DecGTotalProfit := DecGTotalProfit + RecLSaleShipLine."Qty. Shipped Not Invoiced" *
                                                             (RecLSalesLine."Discount unit price" - RecLSalesLine."Purchase cost");
                      END;
                    UNTIL RecLSaleShipLine.NEXT = 0;

                    IF DeGTotalAmount <> 0 THEN
                      DecGPourTotalProfit := DecGTotalProfit / DeGTotalAmount * 100;


                    RecLSaleShipLine2.SETFILTER("Document No.","No.");
                    RecLSaleShipLine2.SETFILTER(Type,'<>%1',RecLSalesLine.Type :: Item);
                    RecLSaleShipLine2.SETFILTER(Quantity,'<>%1',0);
                    RecLSaleShipLine2.SETFILTER("Qty. Shipped Not Invoiced",'<>%1',0);
                    IF RecLSaleShipLine2.FINDFIRST THEN

                          IF RecLSaleShipLine2."No."='BL175491' THEN
                          DeGTotalAmount := 0;

                    REPEAT
                      RecLSalesLine2.RESET;
                      IF RecLSalesLine2.GET(RecLSalesLine2."Document Type" :: Order,RecLSaleShipLine2."Order No.",
                                            RecLSaleShipLine2."Order Line No.") THEN
                        //DecGAmount := DecGAmount + RecLSalesLine2."Discount unit price" * RecLSaleShipLine2."Qty. Shipped Not Invoiced";
                        DecGAmount := DecGAmount + RecLSalesLine2."Unit Price" * RecLSaleShipLine2."Qty. Shipped Not Invoiced" ;
                    UNTIL RecLSaleShipLine2.NEXT = 0;
                    //>>The Bible CASC [FE020.V2] 17/01/2007
                    //DecGChargeAmount := DecGAmount -  DeGTotalAmount;
                    DecGChargeAmount := DecGAmount ;
                    //<<The Bible CASC [FE020.V2] 17/01/2007

                    //Calculation of the delivery order footer Period1
                    DecGTotBLAmount := DecGTotBLAmount + DeGTotalAmount;
                    DecGTotBLProfit := DecGTotBLProfit + DecGTotalProfit;
                    IF DecGTotBLAmount <> 0 THEN
                      DecGTotBLPourcProf := DecGTotBLProfit / DecGTotBLAmount * 100;

                    DecGTotExpAmount := DecGTotExpAmount + DecGChargeAmount;
                end;

                trigger OnPreDataItem()
                begin
                    DecGTotBLAmount := 0;
                    DecGTotBLProfit := 0;
                    DecGTotBLPourcProf := 0;
                    DecGTotExpAmount := 0;
                end;
            }
            dataitem(SalesShipmentHeader2;Table110)
            {
                DataItemTableView = SORTING(Sell-to Customer No.,External Document No.);
                PrintOnlyIfDetail = true;
                column(SalesShipmentHeader2_No_;"No.")
                {
                }
                dataitem(SalesShipmentLine2;Table111)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    DataItemTableView = SORTING(Document No.,Sell-to Customer No.,No.)
                                        WHERE(Type=FILTER(Item),
                                              Quantity=FILTER(<>0),
                                              Qty. Shipped Not Invoiced=FILTER(<>0));
                }

                trigger OnAfterGetRecord()
                var
                    RecLSaleShipLine: Record "111";
                    RecLSalesLine: Record "37";
                    RecLSaleShipLine2: Record "111";
                    RecLSalesLine2: Record "37";
                    DecLExpAmount: Decimal;
                begin
                    IF NOT (SalesShipmentHeader2."Posting Date" IN [DatGStartingDateOrder..DatGEndingDateOrder]) THEN
                      CurrReport.SKIP ;

                    //Calculation of the delivery order footer Period2
                    RecLSaleShipLine.RESET;
                    RecLSaleShipLine.SETFILTER("Document No.","No.");
                    RecLSaleShipLine.SETRANGE(Type,RecLSalesLine.Type :: Item);
                    RecLSaleShipLine.SETFILTER(Quantity,'<>%1',0);
                    RecLSaleShipLine.SETFILTER("Qty. Shipped Not Invoiced",'<>%1',0);
                    IF RecLSaleShipLine.FINDFIRST THEN

                            IF RecLSaleShipLine."No."='BL175491' THEN
                          DeGTotalAmount := 0;

                    REPEAT
                      RecLSalesLine.RESET;
                      IF RecLSalesLine.GET(RecLSalesLine."Document Type" :: Order,RecLSaleShipLine."Order No.",
                                           RecLSaleShipLine."Order Line No.") THEN

                        DecGTotOrderAmount := DecGTotOrderAmount + RecLSalesLine."Discount unit price" * RecLSaleShipLine."Qty. Shipped Not Invoiced";
                        DecGTotOrderProfit := DecGTotOrderProfit + RecLSaleShipLine."Qty. Shipped Not Invoiced" *
                                                                   (RecLSalesLine."Discount unit price" - RecLSalesLine."Purchase cost");

                    UNTIL RecLSaleShipLine.NEXT = 0;

                    IF DecGTotOrderAmount <> 0 THEN
                      DecGTotOrderPourProfit := DecGTotOrderProfit / DecGTotOrderAmount * 100;

                    RecLSaleShipLine2.RESET;
                    RecLSaleShipLine2.SETFILTER("Document No.","No.");
                    RecLSaleShipLine2.SETFILTER(Type,'<>%1',RecLSalesLine2.Type :: Item);
                    RecLSaleShipLine2.SETFILTER(Quantity,'<>%1',0);
                    RecLSaleShipLine2.SETFILTER("Qty. Shipped Not Invoiced",'<>%1',0);
                    IF RecLSaleShipLine2.FINDFIRST THEN
                    REPEAT
                      RecLSalesLine2.RESET;
                      IF RecLSalesLine2.GET(RecLSalesLine2."Document Type" :: Order,RecLSaleShipLine2."Order No.",
                                            RecLSaleShipLine2."Order Line No.") THEN;
                        DecLExpAmount := DecLExpAmount + RecLSalesLine2."Unit Price" * RecLSaleShipLine2."Qty. Shipped Not Invoiced";
                    UNTIL RecLSaleShipLine2.NEXT = 0;

                    DecGTotBLExpAmount := DecGTotBLExpAmount + DecLExpAmount ;
                end;

                trigger OnPreDataItem()
                begin
                    DecGTotOrderAmount := 0;
                    DecGTotBLExpAmount := 0;
                end;
            }
            dataitem(DataItem6640;Table36)
            {
                DataItemTableView = SORTING(Sell-to Customer No.,External Document No.)
                                    WHERE(Document Type=FILTER(Order));
                PrintOnlyIfDetail = true;
                column(Sales_Header__Sales_Header___No__;"Sales Header"."No.")
                {
                }
                column(Sales_Header__Sales_Header___Posting_Date_;"Sales Header"."Posting Date")
                {
                }
                column(Sales_Header__Sales_Header___Sell_to_Customer_No__;"Sales Header"."Sell-to Customer No.")
                {
                }
                column(Sales_Header__Sales_Header___Bill_to_Name_;"Sales Header"."Bill-to Name")
                {
                }
                column(DecGTotalOrderAmount;DecGTotalOrderAmount)
                {
                }
                column(DecGTotalOrderProfit;DecGTotalOrderProfit)
                {
                }
                column(DecGTotalOrderPour;DecGTotalOrderPour)
                {
                }
                column(DecGTotOrderexpAmount;DecGTotOrderexpAmount)
                {
                }
                column(Total___FORMAT_IntGNbCde____commande_s____FORMAT_DatGStartingDateOrder_______FORMAT_DatGEndingDateOrder_;'Total '+FORMAT(IntGNbCde)+' commande(s) '+FORMAT(DatGStartingDateOrder)+'..'+FORMAT(DatGEndingDateOrder))
                {
                }
                column(DecGTotPeriod2Amount;DecGTotPeriod2Amount)
                {
                }
                column(DecGTotPeriod2Profit;DecGTotPeriod2Profit)
                {
                }
                column(DecGTotPeriod2Pourc;DecGTotPeriod2Pourc)
                {
                }
                column(DecGTotPeriod2Exp_;DecGTotPeriod2Exp )
                {
                }
                column(Sales_Header_Document_Type;"Document Type")
                {
                }
                column(DecGTotOrderAmount;DecGTotOrderAmount)
                {
                }
                column(DecGTotOrderProfit;DecGTotOrderProfit)
                {
                }
                column(DecGTotOrderPourProfit;DecGTotOrderPourProfit)
                {
                }
                column(DecGTotBLExpAmount_;DecGTotBLExpAmount )
                {
                }
                dataitem(DataItem2844;Table37)
                {
                    DataItemLink = Document Type=FIELD(Document Type),
                                   Document No.=FIELD(No.);
                    DataItemTableView = SORTING(Document Type,Document No.,Sell-to Customer No.,No.)
                                        WHERE(Quantity=FILTER(<>0),
                                              Type=FILTER(Item));
                    column(DecGOrderPour;DecGOrderPour)
                    {
                    }
                    column(Sales_Line___Outstanding_Quantity______Sales_Line___Discount_unit_price_____Sales_Line___Purchase_cost__;"Sales Line"."Outstanding Quantity" * ("Sales Line"."Discount unit price" - "Sales Line"."Purchase cost"))
                    {
                    }
                    column(Sales_Line___Outstanding_Quantity_____Sales_Line___Discount_unit_price_;"Sales Line"."Outstanding Quantity" * "Sales Line"."Discount unit price")
                    {
                    }
                    column(Sales_Line__Sales_Line___Discount_unit_price_;"Sales Line"."Discount unit price")
                    {
                    }
                    column(Sales_Line__Sales_Line___Outstanding_Quantity_;"Sales Line"."Outstanding Quantity")
                    {
                    }
                    column(Sales_Line__Sales_Line__Description;"Sales Line".Description)
                    {
                    }
                    column(Sales_Line__Sales_Line___No__;"Sales Line"."No.")
                    {
                    }
                    column(TxtGDerogation_Control1000000041;TxtGDerogation)
                    {
                    }
                    column(Sales_Line_Document_Type;"Document Type")
                    {
                    }
                    column(Sales_Line_Document_No_;"Document No.")
                    {
                    }
                    column(Sales_Line_Line_No_;"Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>> 29.03.2012 Begin
                        IF NOT SalesLineDateOk("Shipment Date","Purchase Receipt Date",RecGSaleLine."Invoiced Date (Expected)") THEN
                          CurrReport.SKIP;

                        IF ("Quantity Shipped" = Quantity) THEN
                          CurrReport.SKIP;

                        IF NOT BooGFlag THEN
                          BEGIN
                            IntGNbCde := IntGNbCde + 1 ;
                            BooGFlag := TRUE ;
                        END ;

                        //IF "Sales Line".Quantity * "Sales Line"."Discount unit price" <> 0 THEN
                        IF "Sales Line"."Outstanding Quantity" * "Sales Line"."Discount unit price" <> 0 THEN
                        DecGOrderPour := ("Sales Line"."Discount unit price" - "Sales Line"."Purchase cost") /
                                          "Sales Line"."Discount unit price" *100 ;


                        //>>FEP-ADVE-200711_21_A-DEROGATOIRE
                        IF "Sales Line"."Dispensation No." <> '' THEN
                           TxtGDerogation := 'D'
                        ELSE
                           CLEAR(TxtGDerogation);
                        //<<FEP-ADVE-200711_21_A-DEROGATOIRE
                    end;

                    trigger OnPostDataItem()
                    begin
                        DecGTotalOrderPour := DecGTotalOrderPour + DecGOrderPour;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    RecLSalesLine: Record "37";
                    RecLSalesLine2: Record "37";
                    IntLLine: Integer;
                    DecGAmount: Decimal;
                    BoolSalesLineFound: Boolean;
                begin
                    RecLSalesLine.SETRANGE("Document Type","Sales Header"."Document Type");
                    RecLSalesLine.SETFILTER("Document No.","Sales Header"."No.");
                    //RecLSalesLine.SETFILTER("Quantity Shipped",'%1',0);
                    
                     //>>TODOLIST DARI 07/03/2007 point 70 - Evolution
                    RecLSalesLine.SETFILTER("Outstanding Quantity",'<>%1',0);
                     //<<TODOLIST DARI 07/03/2007 point 70 - Evolution
                    RecLSalesLine.SETRANGE(Type,RecLSalesLine.Type :: Item);
                    //>> 29.03.2012 Begin
                    // RecLSalesLine.SETRANGE("Shipment Date", DatGStartingDateOrder, DatGEndingDateOrder);
                    BoolSalesLineFound := FALSE;
                    IF RecLSalesLine.FINDFIRST THEN
                       REPEAT
                         IF SalesLineDateOk(RecLSalesLine."Shipment Date",RecLSalesLine."Purchase Receipt Date", RecGSaleLine."Invoiced Date (Expected)") THEN
                           BoolSalesLineFound := TRUE;
                    UNTIL (RecLSalesLine.NEXT = 0) OR BoolSalesLineFound;
                    //>> End
                    
                      //<< TODOLIST DARI 07/03/2007 point 70 - Evolution
                    
                    /*
                      //>>TODOLIST DARI 07/03/2007 point 70 - Evolution
                    IF RecLSalesLine.FINDFIRST THEN
                      REPEAT
                        IF ("Sales Line"."Quantity Shipped" <> "Sales Line".Quantity) THEN
                          BoolSalesLineFound := TRUE;
                      UNTIL RecLSalesLine.NEXT = 0;
                    */
                      //>>TODOLIST DARI 07/03/2007 point 70 - Evolution
                    
                    //>>TODOLIST DARI 07/03/2007 point 70
                    //IF NOT (("Sales Header"."Posting Date" IN [DatGStartingDateOrder..DatGEndingDateOrder]) OR BoolSalesLineFound) THEN
                    //Evol IF NOT (("Sales Header"."Shipment Date" IN [DatGStartingDateOrder..DatGEndingDateOrder]) OR BoolSalesLineFound) THEN
                    
                    IF NOT BoolSalesLineFound THEN
                      CurrReport.SKIP ;
                    //<<TODOLIST DARI 07/03/2007 point 70
                     //<<TODOLIST DARI 07/03/2007 point 70 - Evolution
                    
                    BooGFlag := FALSE ;
                    
                    DecGTotalOrderAmount := 0;
                    DecGTotalOrderProfit := 0;
                    DecGTotalOrderPour := 0;
                    
                    /*
                    RecLSalesLine.SETRANGE("Document Type","Sales Header"."Document Type");
                    RecLSalesLine.SETFILTER("Document No.","Sales Header"."No.");
                    RecLSalesLine.SETFILTER("Quantity Shipped",'%1',0);
                    RecLSalesLine.SETRANGE(Type,RecLSalesLine.Type :: Item);
                    //>>FLGR
                    RecLSalesLine.SETRANGE("Shipment Date", DatGStartingDateOrder, DatGEndingDateOrder);
                    //<<FLGR
                    */
                    
                    IF RecLSalesLine.FINDFIRST THEN
                    REPEAT
                    //>>TODOLIST DARI 07/03/2007 point 70
                    // IF Qty Shipped = 0 => "Outstanding Quantity" = Quantity
                    // ELSE "Outstanding Quantity" is the GOOD FIELD to use.
                    //
                    //DecGTotalOrderAmount := DecGTotalOrderAmount + RecLSalesLine.Quantity * RecLSalesLine."Discount unit price";
                    //DecGTotalOrderProfit := DecGTotalOrderProfit + RecLSalesLine.Quantity * (RecLSalesLine."Discount unit price"
                    
                      //>> 29.03.2012 Begin
                      IF SalesLineDateOk(RecLSalesLine."Shipment Date",RecLSalesLine."Purchase Receipt Date",RecGSaleLine."Invoiced Date (Expected)") THEN
                        BEGIN
                          DecGTotalOrderAmount := DecGTotalOrderAmount + RecLSalesLine."Outstanding Quantity" * RecLSalesLine."Discount unit price";
                          DecGTotalOrderProfit :=
                            DecGTotalOrderProfit +
                              RecLSalesLine."Outstanding Quantity" * (RecLSalesLine."Discount unit price" - RecLSalesLine."Purchase cost");
                      END;
                    //<<TODOLIST DARI 07/03/2007 point 70
                    
                    UNTIL RecLSalesLine.NEXT= 0;
                    
                    IF DecGTotalOrderAmount <> 0 THEN
                      DecGTotalOrderPour := DecGTotalOrderProfit / DecGTotalOrderAmount * 100;
                    
                    
                    RecLSalesLine2.SETRANGE("Document Type","Sales Header"."Document Type");
                    RecLSalesLine2.SETFILTER("Document No.","Sales Header"."No.");
                    RecLSalesLine2.SETFILTER("Quantity Shipped",'%1',0);
                    RecLSalesLine2.SETFILTER(Type,'<>%1',RecLSalesLine.Type :: Item);
                    //>>FLGR
                    // RecLSalesLine2.SETRANGE("Shipment Date", DatGStartingDateOrder, DatGEndingDateOrder);
                    //<<FLGR
                    
                    IF RecLSalesLine2.FINDFIRST THEN
                    REPEAT
                      //>> 29.03.2012 Begin
                      IF SalesLineDateOk(RecLSalesLine2."Shipment Date",RecLSalesLine2."Purchase Receipt Date",RecGSaleLine."Invoiced Date (Expected)") THEN
                        DecGAmount := DecGAmount + RecLSalesLine2.Amount;
                    UNTIL RecLSalesLine2.NEXT= 0;
                    
                    //>>The Bible CASC [FE020.V2] 17/01/2007
                    //DecGTotOrderexpAmount := DecGAmount - DecGTotalOrderAmount;
                    DecGTotOrderexpAmount := DecGAmount; // - DecGTotalOrderAmount;
                    //<<The Bible CASC [FE020.V2] 17/01/2007
                    
                    //Calculate Total Order Period 2
                    DecGTotPeriod2Amount := DecGTotPeriod2Amount + DecGTotalOrderAmount;
                    DecGTotPeriod2Profit := DecGTotPeriod2Profit + DecGTotalOrderProfit;
                    DecGTotPeriod2Exp := DecGTotPeriod2Exp + DecGTotOrderexpAmount;
                    IF DecGTotPeriod2Amount <>0 THEN
                      DecGTotPeriod2Pourc := DecGTotPeriod2Profit / DecGTotPeriod2Amount * 100;

                end;

                trigger OnPreDataItem()
                begin
                    DecGTotalOrderPour := 0;
                    DecGTotPeriod2Profit := 0;
                    DecGTotPeriod2Amount := 0;
                    DecGTotOrderexpAmount := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Intervalles de dates")
                {
                    Caption = 'Intervalles de dates';
                    group(Livraisons)
                    {
                        field(DatGStartingDateShipment;DatGStartingDateShipment)
                        {
                            Caption = 'Date début';
                        }
                        field(DatGEndingDateShipment;DatGEndingDateShipment)
                        {
                            Caption = 'Date fin';
                        }
                    }
                    group(Commandes)
                    {
                        field(DatGStartingDateOrder;DatGStartingDateOrder)
                        {
                            Caption = 'Date début';
                        }
                        field(DatGEndingDateOrder;DatGEndingDateOrder)
                        {
                            Caption = 'Date fin';
                        }
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
        DatGStartingDateShipment := WORKDATE ;
        DatGEndingDateShipment   := WORKDATE ;
        DatGStartingDateOrder    := CALCDATE('-1M+FM+1J',WORKDATE) ;
        DatGEndingDateOrder      := CALCDATE('+FM',WORKDATE) ;

        IF (DatGStartingDateShipment=0D) OR (DatGEndingDateShipment=0D) OR (DatGStartingDateOrder=0D) OR (DatGEndingDateOrder=0D) THEN
          ERROR('Veuillez renseigner toutes les dates.') ;
    end;

    var
        RecGSaleHeader: Record "36";
        RecGSaleLine: Record "37";
        DatGStartingDateShipment: Date;
        DatGEndingDateShipment: Date;
        DatGStartingDateOrder: Date;
        DatGEndingDateOrder: Date;
        IntGNbCde: Integer;
        IntGOrderLine: Integer;
        IntGNbLine: Integer;
        BooGFlag: Boolean;
        DecGDiscountUnitPrice: Decimal;
        DecGProfitAmount: Decimal;
        DecGPourcProfit: Decimal;
        DecGChargeAmount: Decimal;
        DeGTotalAmount: Decimal;
        DecGTotalProfit: Decimal;
        DecGPourTotalProfit: Decimal;
        DecGAmount: Decimal;
        DecGTotBLAmount: Decimal;
        DecGTotBLProfit: Decimal;
        DecGTotBLPourcProf: Decimal;
        DecGTotBLExpAmount: Decimal;
        DecGTotPour: Decimal;
        DecGTotExpAmount: Decimal;
        DecGTotOrderAmount: Decimal;
        DecGTotOrderProfit: Decimal;
        DecGTotOrderPourProfit: Decimal;
        DecGTotOrderexpAmount: Decimal;
        DecGTotOrderAmount2: Decimal;
        DecGOrderPour: Decimal;
        DecGTotalOrderPour: Decimal;
        DecGTotalOrderAmount: Decimal;
        DecGTotalOrderProfit: Decimal;
        DecGTotOrdPour: Decimal;
        DecGTotalPurchCost: Decimal;
        "//--Total Order Period2--//": Integer;
        DecGTotPeriod2Amount: Decimal;
        DecGTotPeriod2Profit: Decimal;
        DecGTotPeriod2Pourc: Decimal;
        DecGTotPeriod2Exp: Decimal;
        DecTotBLOrderPourc: Decimal;
        DecGTotMarge: Decimal;
        "--FEP-ADVE-200711_21_A--": Integer;
        TxtGDerogation: Text[30];
        Customer___Top_10_ListCaptionLbl: Label 'Customer - Top 10 List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RecGSaleLine__Discount_unit_price_CaptionLbl: Label 'Discount Excluding VAT Unit Price';
        Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price_CaptionLbl: Label 'Line Amount Excluding VAT';
        Sales_Shipment_Line___Qty__Shipped_Not_Invoiced_____RecGSaleLine__Discount_unit_price____RecGSaleLine__Purchase_cost__CaptionLbl: Label 'Profil Amount';
        DecGPourcProfitCaptionLbl: Label '% Profit';
        DeGTotalAmountCaptionLbl: Label 'Item Total Amount';
        DecGTotalProfitCaptionLbl: Label 'Profit Amount';
        DecGPourTotalProfitCaptionLbl: Label '% Profit';
        DecGChargeAmountCaptionLbl: Label 'Expense Amount';
        Delivery_OrderCaptionLbl: Label 'Delivery Order';
        Sales_Line__Sales_Line___No__CaptionLbl: Label 'No.';
        Sales_Line__Sales_Line__DescriptionCaptionLbl: Label 'Description';
        Sales_Line__Sales_Line___Outstanding_Quantity_CaptionLbl: Label 'Quantity';
        Sales_Line__Sales_Line___Discount_unit_price_CaptionLbl: Label 'Discount Excluding VAT Unit Price';
        Sales_Line___Outstanding_Quantity_____Sales_Line___Discount_unit_price_CaptionLbl: Label 'Line Amount Excluding VAT';
        Sales_Line___Outstanding_Quantity______Sales_Line___Discount_unit_price_____Sales_Line___Purchase_cost__CaptionLbl: Label 'Profil Amount';
        DecGOrderPourCaptionLbl: Label '% Profit';
        DecGTotalOrderAmountCaptionLbl: Label 'Item Total Amount';
        DecGTotalOrderProfitCaptionLbl: Label 'Profit Amount';
        DecGTotalOrderPourCaptionLbl: Label '% Profit';
        DecGTotOrderexpAmountCaptionLbl: Label 'Expense Amount';
        OrderCaptionLbl: Label 'Order';

    [Scope('Internal')]
    procedure SalesLineDateOk(ShipmentDate: Date;ReceiptDate: Date;InvoicedDate: Date): Boolean
    begin
        //BC6>>
        IF InvoicedDate <> 0D THEN
           ShipmentDate := InvoicedDate;
        //BC6<<
        IF ReceiptDate <> 0D THEN
          EXIT(ReceiptDate IN [DatGStartingDateOrder..DatGEndingDateOrder]);
        EXIT(ShipmentDate IN [DatGStartingDateOrder..DatGEndingDateOrder]);
    end;
}

