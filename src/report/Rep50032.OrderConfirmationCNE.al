report 50032 "BC6_Order Confirmation CNE"
{
    Caption = 'Order Confirmation CNE', comment = 'FRA="Confirmation de Cde CNE"';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/OrderConfirmationCNE.rdl';
    ShowPrintStatus = false;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order', Comment = 'FRA="Commande vente"';
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(PricesInclVAT_SalesHeader; SalesHeader."Prices Including VAT")
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
                    column(Sales_Header___Your_Reference_; SalesHeader."Your Reference")
                    {
                    }
                    column(Sales_Header___Document_Date_; SalesHeader."Document Date")
                    {
                    }
                    column(Sales_Header___Sell_to_Customer_No__; SalesHeader."Sell-to Customer No.")
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(TmpNamereport; TmpNamereport)
                    {
                    }
                    column(DateLiv; DateLiv)
                    {
                    }
                    column(Sales_Header___External_Document_No__; SalesHeader."External Document No.")
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
                    column(RespCenter_Picture; RespCenter."BC6_Picture")
                    {
                    }
                    column(RespCenter__Alt_Picture_; RespCenter."BC6_Alt Picture")
                    {
                    }
                    column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
                    {
                    }
                    column(STRSUBSTNO_Text066_TxtGPhone_TxtGFax_TxtGEmail_; STRSUBSTNO(Text066, TxtGPhone, TxtGFax, TxtGEmail))
                    {
                    }
                    column(CompanyAddr_2______CompanyAddr_3______STRSUBSTNO___1__2__CompanyAddr_4__CompanyAddr_5__; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO(txtlbl12, CompanyAddr[4], CompanyAddr[5]))
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
                    column(TxtGAltAdress______TxtGAltAdress2_____STRSUBSTNO___1__2__TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO(txtlbl12, TxtGAltPostCode, TxtGAltCity))
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
                    dataitem(TraitementTexteClient; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TraitementTexteClient_Number; Number)
                        {
                        }
                        dataitem(TexteClient; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(StandardSalesLine_Description; StandardSalesLine.Description)
                            {
                            }
                            column(TexteClient_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Edition2 THEN
                                    IF Number = 1 THEN
                                        StandardSalesLine.FIND('-')
                                    ELSE
                                        StandardSalesLine.NEXT();
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT Edition THEN CurrReport.BREAK();
                                StandardSalesLine.RESET();
                                StandardSalesLine.SETRANGE(StandardSalesLine."Standard Sales Code", StandardCustomerSalesCode.Code);
                                Edition2 := TRUE;
                                IF StandardSalesLine.COUNT <> 0 THEN
                                    TexteClient.SETRANGE(Number, 1, StandardSalesLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT Edition THEN CurrReport.BREAK();
                            IF Number = 1 THEN
                                StandardCustomerSalesCode.FIND('-')
                            ELSE
                                StandardCustomerSalesCode.NEXT();
                        end;

                        trigger OnPreDataItem()
                        begin
                            StandardCustomerSalesCode.RESET();
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.BC6_TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", SalesHeader."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = SalesHeader;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnAfterGetRecord()
                        begin

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine.InsertLine();
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                            TempVATAmountLine.DELETEALL();
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Type_SalesLine; FORMAT(TempSalesLine.Type))
                        {
                        }
                        column(No_SalesLine; TempSalesLine."Line No.")
                        {
                        }
                        column(SalesLine__Line_Amount_; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Description; TempSalesLine.Description)
                        {
                        }
                        column(FORMAT__Sales_Line___Discount_unit_price___0___precision_2_4__standard_format_1___; FORMAT(TempSalesLine."BC6_Discount unit price", 0, '<precision,2:4><standard format,1>'))
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Quantity; TempSalesLine.Quantity)
                        {
                        }
                        column(Sales_Line___No__; TempSalesLine."No.")
                        {
                        }
                        column(Sales_Line___Qty__per_Unit_of_Measure_; TempSalesLine."Qty. per Unit of Measure")
                        {
                        }
                        column(Sales_Line__Quantity_DecGNumbeofUnitsDEEE_DecGHTUnitTaxLCY; TempSalesLine.Quantity * DecGNumbeofUnitsDEEE * DecGHTUnitTaxLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___DEEE_Category_Code_; TempSalesLine."BC6_DEEE Category Code")
                        {
                        }
                        column(DecGHTUnitTaxLCY; DecGHTUnitTaxLCY)
                        {
                        }
                        column(DecGNumbeofUnitsDEEE; DecGNumbeofUnitsDEEE)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(STRSUBSTNO___1__2__templibelledouanier_item__Tariff_No___; STRSUBSTNO(txtlbl12, templibelledouanier, item."Tariff No."))
                        {
                        }
                        column(CrossrefNo; CrossrefNo)
                        {
                        }
                        column(SalesLine__Line_Amount__Control1000000050; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_; -TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__Control1000000132; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_SalesLine__DEEE_HT_Amount_; VATAmount + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NetaPayer__SalesLine__DEEE_HT_Amount_; NetaPayer + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__DEEE_HT_Amount_; TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                        }
                        column(SalesLine_Amount__SalesLine__DEEE_HT_Amount_; TempSalesLine.Amount + TempSalesLine."BC6_DEEE HT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                        }
                        column(MontantCaption; MontantCaptionLbl)
                        {
                        }
                        column(Prix_unitaire_HTCaption; Prix_unitaire_HTCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(Sales_Line__Description_Control1000000120Caption; TempSalesLine.FIELDCAPTION(Description))
                        {
                        }
                        column(ItemCaption; ItemCaptionLbl)
                        {
                        }
                        column(Sales_Unit_of_MeasureCaption; Sales_Unit_of_MeasureCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(DEEE_Contribution___Caption; DEEE_Contribution___CaptionLbl)
                        {
                        }
                        column(Sales_Line___No___Control1000000219Caption; Sales_Line___No___Control1000000219CaptionLbl)
                        {
                        }
                        column(Category_Caption; Category_CaptionLbl)
                        {
                        }
                        column(Nb_Un__DEEECaption; Nb_Un__DEEECaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(BooGDescVisible; BooGDescVisible)
                        {
                        }
                        column(BooGDescVisible2; BooGDescVisible2)
                        {
                        }
                        column(BooGDescVisible3; BooGDescVisible3)
                        {
                        }
                        column(BooGDescVisible4; BooGDescVisible4)
                        {
                        }
                        column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT();
                            "Sales Line" := TempSalesLine;

                            IF NOT SalesHeader."Prices Including VAT" AND
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempSalesLine."Line Amount" := 0;

                            IF (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line"."No." := '';

                            //Debut affichage des references externes
                            ItemReference.RESET();
                            ItemReference.SETRANGE("Item No.", TempSalesLine."No.");
                            ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::Customer);
                            ItemReference.SETRANGE("Reference Type No.", SalesHeader."Sell-to Customer No.");
                            CrossrefNo := '';
                            IF ItemReference.FIND('-') THEN
                                CrossrefNo := ItemReference."Reference No.";

                            ItemReference.RESET();
                            ItemReference.SETRANGE("Item No.", TempSalesLine."No.");
                            ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
                            ItemReference.SETRANGE("Discontinue Bar Code", FALSE);
                            TempGencod := '';
                            IF ItemReference.FIND('-') THEN
                                TempGencod := ItemReference."Reference No.";
                            item."Tariff No." := '';
                            IF SalesHeader."Sell-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                                IF TempSalesLine.Type = TempSalesLine.Type::Item THEN
                                    IF item.GET(TempSalesLine."No.") THEN;
                                ;
                            END;

                            IF ((TempSalesLine."BC6_DEEE Category Code" <> '') AND (TempSalesLine.Quantity <> 0)
                            AND (TempSalesLine."BC6_Eco partner DEEE" <> '')) THEN BEGIN
                                IF RecGItem.GET(TempSalesLine."No.") THEN
                                    DecGNumbeofUnitsDEEE := RecGItem."BC6_Number of Units DEEE"
                                ELSE
                                    DecGNumbeofUnitsDEEE := 0;

                                RecGDEEE.RESET();
                                RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", TempSalesLine."BC6_DEEE Category Code");
                                RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', SalesHeader."Posting Date");
                                IF RecGDEEE.FIND('+') THEN
                                    DecGHTUnitTaxLCY := RecGDEEE."HT Unit Tax (LCY)"
                                ELSE
                                    DecGHTUnitTaxLCY := 0;
                            END;

                            DecGTTCTotalAmount += TempSalesLine."Amount Including VAT" + TempSalesLine."BC6_DEEE TTC Amount";

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
                            Asterisque := COPYSTR(TempSalesLine.Description, 1, 1);
                            BooGDescVisible := (TempSalesLine.Type.AsInteger() = 0) AND (Asterisque <> '*');

                            IF RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                BooGDescVisible2 := ("Sales Line"."BC6_DEEE Category Code" <> '') AND ("Sales Line".Quantity <> 0) AND ("Sales Line"."BC6_Eco partner DEEE" <> '')
                            ELSE
                                BooGDescVisible2 := FALSE;

                            IF (CrossrefNo = '') AND (item."Tariff No." = '') THEN
                                BooGDescVisible3 := FALSE
                            ELSE
                                BooGDescVisible3 := TRUE;

                            templibelledouanier := '';
                            IF item."Tariff No." <> '' THEN
                                templibelledouanier := item.FIELDCAPTION("Tariff No.");

                            BooGDescVisible4 := TempSalesLine."Inv. Discount Amount" > 0;
                            NNCSalesLineLineAmt += TempSalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += TempSalesLine."Inv. Discount Amount";

                            TotalAmount += TempSalesLine."Line Amount";
                            TotalDEEEHTAmount += TempSalesLine."BC6_DEEE HT Amount";
                            TotalAmtHTDEEE += TempSalesLine."Line Amount" + TempSalesLine."BC6_DEEE HT Amount";
                            TotalAmountVATDEE += TempSalesLine."Amount Including VAT" - TempSalesLine."Line Amount" + TempSalesLine."BC6_DEEE VAT Amount";
                            TotalAmountInclVATDEE += TempSalesLine."Amount Including VAT" + TempSalesLine."BC6_DEEE HT Amount" + TempSalesLine."BC6_DEEE VAT Amount";
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
                            TempSalesLine."Inv. Discount Amount", TempSalesLine."BC6_DEEE HT Amount", TempSalesLine."BC6_DEEE VAT Amount");

                            DecGVATTotalAmount := 0;
                            DecGTTCTotalAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
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
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
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
                        column(VATAmtLineVATPercentage2; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  TempVATAmountLine."VAT Base", SalesHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  SalesHeader."Posting Date", SalesHeader."Currency Code",
                                  TempVATAmountLine."VAT Amount", SalesHeader."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (SalesHeader."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(SalesHeader."Posting Date", SalesHeader."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(DEEETariffs; "BC6_DEEE Tariffs")
                    {
                        DataItemTableView = SORTING("Eco Partner", "DEEE Code", "Date beginning");
                        column(DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_; DEEETariffs."DEEE Code")
                        {
                        }
                        column(RecGItemCtg__Weight_Min_; RecGItemCtg."Weight Min")
                        {
                        }
                        column(RecGItemCtg__Weight_Min__Control1000000244; RecGItemCtg."Weight Min")
                        {
                        }
                        column(DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__; DEEETariffs."HT Unit Tax (LCY)")
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
                        column(RecGItemCtg__Weight_Min__Control1000000244Caption; RecGItemCtg__Weight_Min__Control1000000244CaptionLbl)
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
                            RecLSalesLine: Record "Sales Line";
                        begin
                            BooGDEEEFind := FALSE;
                            RecLSalesLine.RESET();
                            RecLSalesLine.SETRANGE("Document No.", SalesHeader."No.");
                            RecLSalesLine.SETFILTER(RecLSalesLine."Document Type", '%1', RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLSalesLine."BC6_DEEE Category Code" = DEEETariffs."DEEE Code") AND (RecLSalesLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLSalesLine.NEXT() = 0));

                            RecGDEEE.RESET();
                            RecGDEEE.SETFILTER(RecGDEEE."DEEE Code", DEEETariffs."DEEE Code");
                            RecGDEEE.SETFILTER(RecGDEEE."Date beginning", '<=%1', SalesHeader."Posting Date");
                            IF RecGDEEE.FIND('+') THEN
                                IF RecGDEEE."Date beginning" <> DEEETariffs."Date beginning" THEN
                                    BooGDEEEFind := FALSE;

                            RecGItemCtg.RESET();
                            IF NOT RecGItemCtg.GET(DEEETariffs."DEEE Code", DEEETariffs."Eco Partner") THEN
                                RecGItemCtg.INIT();

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.SKIP();
                        end;

                        trigger OnPreDataItem()
                        var
                            RecLSalesLine: Record "Sales Line";
                        begin
                            BooGDEEEFind := FALSE;
                            RecLSalesLine.RESET();

                            RecLSalesLine.SETFILTER(RecLSalesLine."Document No.", SalesHeader."No.");
                            RecLSalesLine.SETFILTER(RecLSalesLine."Document Type", '%1', RecLSalesLine."Document Type"::Order);
                            IF RecLSalesLine.FIND('-') THEN
                                REPEAT
                                    BooGDEEEFind := ((RecLSalesLine."BC6_DEEE Category Code" <> '') AND (RecLSalesLine.Quantity <> 0));
                                UNTIL ((BooGDEEEFind = TRUE) OR (RecLSalesLine.NEXT() = 0));

                            IF BooGDEEEFind = FALSE THEN
                                CurrReport.BREAK();

                            IF NOT RecGBillCustomer."BC6_Submitted to DEEE" THEN
                                CurrReport.BREAK();

                            //Ne pas afficher tableau récap DEEE SEDU 02/03/2007
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(TotalAmount; TotalAmount)
                        {
                        }
                        column(TotalDEEEHTAmount; TotalDEEEHTAmount)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                        }
                        column(TotalAmtHTDEEE; TotalAmtHTDEEE)
                        {
                        }
                        column(TotalAmountVATDEE; TotalAmountVATDEE)
                        {
                        }
                        column(TotalAmountInclVATDEE; TotalAmountInclVATDEE)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
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
                        column(DOWN_PAYMENTCaption; DOWN_PAYMENTCaptionLbl)
                        {
                        }
                        column(TOTAL_incl__VATCaption; TOTAL_incl__VATCaptionLbl)
                        {
                        }
                        column(Terms_of_PaymentCaption; Terms_of_PaymentCaptionLbl)
                        {
                        }
                        column(AmountEco_ConributionCaption; AmountEco_ConributionCaptionLbl)
                        {
                        }
                        column(Excl__VAT_Total_Incl_DEEECaption; Excl__VAT_Total_Incl_DEEECaptionLbl)
                        {
                        }
                        column(SIGNATURE__Caption; SIGNATURE__CaptionLbl)
                        {
                        }
                        column(SEAL__Caption; SEAL__CaptionLbl)
                        {
                        }
                        column(DATE__Caption; DATE__CaptionLbl)
                        {
                        }
                        column(Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_Caption; Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_CaptionLbl)
                        {
                        }
                        column(Sales_Header___Advance_Payment_; SalesHeader."BC6_Advance Payment")
                        {
                            AutoFormatExpression = SalesHeader."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(CodeGCurrency; CodeGCurrency)
                        {
                        }
                        column(Total_Due_Caption; Total_Due_CaptionLbl)
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
                        Client: Record Customer;
                        RecGJob: Record Job;
                    begin
                        IF SalesHeader."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := SalesHeader."BC6_Affair No.";
                            RecGJob.GET(SalesHeader."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;

                        //Recherche des libellés text selon langue
                        IF CurrReport.PAGENO() = 1 THEN BEGIN
                            LangueLig10 := Langue + '' + '10';
                            LangueLig20 := Langue + '' + '20';
                            LangueLig30 := Langue + '' + '30';
                            IF TablesDiverses.GET(ListeTable, LangueLig10) THEN
                                Text10 := TablesDiverses.Description
                            ELSE
                                Text10 := '';
                            IF TablesDiverses.GET(ListeTable, LangueLig20) THEN
                                Text20 := TablesDiverses.Description
                            ELSE
                                Text20 := '';
                            IF TablesDiverses.GET(ListeTable, LangueLig30) THEN
                                Text30 := TablesDiverses.Description
                            ELSE
                                Text30 := '';
                        END;
                        //Recherche des libellés text selon langue

                        IF Client.GET(SalesHeader."Sell-to Customer No.") THEN
                            IF Client."Print Statements" = TRUE THEN
                                surReleve := 'sur relevé :'
                            ELSE
                                surReleve := ':'
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    TempVATAmountLine.DELETEALL();
                    SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, SalesHeader, TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, SalesHeader, TempSalesLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount(SalesHeader."Currency Code", SalesHeader."Prices Including VAT");

                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT() + TempVATAmountLine.GetTotalAmountDEEEInclVAT();

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalAmount := 0;
                    TotalDEEEHTAmount := 0;
                    TotalAmtHTDEEE := 0;
                    TotalAmountVATDEE := 0;
                    TotalAmountInclVATDEE := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN(SalesHeader);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 0;

                    //Si Nbre de Copies est renseigner, on écrase le Nbre de copies du type de commande.
                    IF NoOfCopies <> 0 THEN
                        NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops > 0 THEN
                        SETRANGE(Number, 1, NoOfLoops)
                    ELSE
                        SETRANGE(Number, 0, 0);

                    OutputNo := 1;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language2.GetLanguageIdOrDefault("Language Code");
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

                //Debut pour avoir les infos société
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;
                //Fin Debut pour avoir les infos société

                IF BoolGRespCenter THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                //Date livraison
                DateLiv := SalesHeader."Promised Delivery Date";
                IF SalesHeader."Promised Delivery Date" = 0D THEN
                    DateLiv := SalesHeader."Requested Delivery Date";

                //Lecture Mode transport
                ModeTransport := '';
                IF ShippingAgent.GET(SalesHeader."Shipping Agent Code") THEN
                    ModeTransport := ShippingAgent.Name;

                //Lecture des mode de règlement (Payment Methode)
                ModeDePayment := '';
                IF PaymentMethod.GET(SalesHeader."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;

                //Debut recherche des libellés text selon langue
                LangueLig01 := Language.Code + '' + '01';
                ListeTable := 'CONCDE';
                IF TablesDiverses.GET(ListeTable, LangueLig01) THEN BEGIN
                    TmpNamereport := TablesDiverses.Description + '' + SalesHeader."No.";
                    Langue := Language.Code;
                END ELSE BEGIN
                    Langue := 'FRA';
                    LangueLig01 := Langue + '' + '01';
                    IF TablesDiverses.GET(ListeTable, LangueLig01) THEN
                        TmpNamereport := TablesDiverses.Description + '' + SalesHeader."No."
                    ELSE
                        TmpNamereport := Text004 + ' ' + SalesHeader."No.";
                END;

                LangueLig40 := Langue + '' + '40';
                LangueLig50 := Langue + '' + '50';

                IF TablesDiverses.GET(ListeTable, LangueLig40) THEN
                    Text40 := TablesDiverses.Description
                ELSE
                    Text40 := '';
                IF TablesDiverses.GET(ListeTable, LangueLig50) THEN
                    Text50 := TablesDiverses.Description
                ELSE
                    Text50 := '';
                //Fin recherche des libellés text selon langue

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    //  SalesPersonText := Text000;
                    SalesPersonText := '';
                    SalesPersonText := Text100 + ' ' + SalesPurchPerson.Name;
                    IF SalesPurchPerson."Phone No." <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + '' + Text101 + ' ' + SalesPurchPerson."Phone No.";
                    IF SalesPurchPerson."E-Mail" <> '' THEN
                        SalesPersonText := SalesPersonText + ' ' + '   ' + ' ' + SalesPurchPerson.FIELDCAPTION("E-Mail") + ' ' + SalesPurchPerson."E-Mail";
                END;

                //Libellé de fin d'AR
                AText200 := Text200;

                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                    CodeGCurrency := GLSetup."LCY Code";
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    CodeGCurrency := "Currency Code";
                END;

                //Adresse à imprimer = adresse de commande et non pas adresse de Facturation
                FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);

                RecG_User.RESET();
                RecG_User.SETRANGE("User Name", BC6_ID);
                IF RecG_User.FINDFIRST() THEN
                    TexG_User_Name := RecG_User."Full Name"
                ELSE
                    TexG_User_Name := '';

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                //Ajout tel et fax fournisseur
                IF customer.GET("Sell-to Customer No.") THEN;
                Tel := customer."Phone No.";
                Fax := customer."Fax No.";
                //Fin ajout tel et fax fournisseur

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument(SalesHeader, LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;

                RecGBillCustomer.RESET();
                RecGBillCustomer.GET(SalesHeader."Bill-to Customer No.");
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
                    field(NoOfCopiesF; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfoF; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        Visible = false;
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        Visible = false;

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
                        Visible = false;
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
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
    end;

    trigger OnPreReport()
    begin
        IF RespCenter.GET(CodGRespCenter) THEN
            BoolGRespCenter := TRUE
        ELSE
            BoolGRespCenter := FALSE;

        IF BoolGRespCenter THEN
            RespCenter.CALCFIELDS("BC6_Picture", "BC6_Alt Picture")
        ELSE
            CompanyInfo.CALCFIELDS(Picture, "BC6_Alt Picture");
    end;

    var
        RecGItemCtg: Record "BC6_Categories of item";
        RecGDEEE: Record "BC6_DEEE Tariffs";
        TempRecGCalcul: Record "BC6_DEEE Tariffs" temporary;
        TablesDiverses: Record "BC6_Various Tables";
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        customer: Record Customer;
        RecGBillCustomer: Record Customer;
        GLSetup: Record "General Ledger Setup";
        item: Record Item;
        RecGItem: Record Item;
        ItemReference: Record "Item Reference";
        Language: Record Language;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        RecGSalesInvLine: Record "Sales Invoice Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
        StandardSalesLine: Record "Standard Sales Line";
        RecG_User: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language2: Codeunit Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        BooGDEEEFind: Boolean;
        BooGDescVisible: Boolean;
        BooGDescVisible2: Boolean;
        BooGDescVisible3: Boolean;
        BooGDescVisible4: Boolean;
        BoolGRespCenter: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        FlagText: Boolean;
        HideReference: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        CodeGCurrency: Code[10];
        CodGRespCenter: Code[10];
        DateLiv: Date;
        DecGHTUnitTaxLCY: Decimal;
        DecGNumbeofUnitsDEEE: Decimal;
        DecGTTCTotalAmount: Decimal;
        DecGVATTotalAmount: Decimal;
        NetaPayer: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        NNCSalesLineLineAmt: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountInclVATDEE: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmountVATDEE: Decimal;
        TotalAmtHTDEEE: Decimal;
        TotalDEEEHTAmount: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        i: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AmountEco_ConributionCaptionLbl: Label 'AmountEco-Conribution', comment = 'FRA="Total Eco-Contribution HT"';
        Category_CaptionLbl: Label 'Category ', comment = 'FRA="Catégorie"';
        ContinuedCaptionLbl: Label 'Continued', comment = 'FRA="Report"';
        Customer_No_CaptionLbl: Label 'Customer No.', comment = 'FRA="N° Client"';
        DATE__CaptionLbl: Label 'DATE :';
        DateCaptionLbl: Label 'Date';
        DEEE_Contribution___CaptionLbl: Label 'DEEE Contribution : ', comment = 'FRA="Contribution DEEE :"';
        DEEE_Tariffs__DEEE_Tariffs___DEEE_Code_CaptionLbl: Label 'Category', comment = 'FRA="- Catégorie"';
        DEEE_Tariffs__DEEE_Tariffs___HT_Unit_Tax__LCY__CaptionLbl: Label 'HT Unit Tax (LCY)', comment = 'FRA="Coût Unitaire HT (DS)"';
        Delivery_DateCaptionLbl: Label 'Delivery requested', comment = 'FRA="Livraison demandée le"';
        DOWN_PAYMENTCaptionLbl: Label 'DOWN PAYMENT', comment = 'FRA="ACOMPTE"';
        Excl__VAT_Total_Incl_DEEECaptionLbl: Label 'Excl. VAT Total Incl.DEEE', comment = 'FRA="Total HT DEEE comprise"';
        InterlocutorCaptionLbl: Label 'Interlocutor', comment = 'FRA="Interlocuteur"';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', comment = 'FRA="Montant remise facture"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', comment = 'FRA="Montant base remise facture"';
        ItemCaptionLbl: Label 'Item', comment = 'FRA="Art. :"';
        LineAmtCaptionLbl: Label 'Line Amount', comment = 'FRA="Montant ligne"';
        MontantCaptionLbl: Label 'Montant';
        Nb_Un__DEEECaptionLbl: Label 'Nb Un. DEEE', comment = 'FRA="Nb Un. DEEE"';
        PaymentTerms_Description_Control1000000188CaptionLbl: Label 'Payment Method:', comment = 'FRA="Mode de réglement :"';
        Prix_unitaire_HTCaptionLbl: Label 'Prix unitaire HT';
        QuantityCaptionLbl: Label 'Quantity', comment = 'FRA="Quantité"';
        RecGItemCtg__Weight_Min__Control1000000244CaptionLbl: Label 'Weight Max', comment = 'FRA="Poids Max"';
        RecGItemCtg__Weight_Min_CaptionLbl: Label 'Weight Min', comment = 'FRA="Poids Min"';
        Sales_Header___Your_Reference_CaptionLbl: Label 'Your Reference :', comment = 'FRA="Votre Référence :"';
        Sales_Line___No___Control1000000219CaptionLbl: Label 'Item : ', comment = 'FRA="Art. : "';
        Sales_Unit_of_MeasureCaptionLbl: Label 'Sales Unit of Measure', comment = 'FRA="Unité vente"';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', comment = 'FRA="Montant remise facture"';
        SEAL__CaptionLbl: Label 'SEAL :', comment = 'FRA="CACHET:"';
        Shipment_departementCaptionLbl: Label 'Shipment departement', comment = 'FRA="Adresse de livraison"';
        SIGNATURE__CaptionLbl: Label 'SIGNATURE :', comment = 'FRA="SIGNATURE"';
        SubtotalCaptionLbl: Label 'Subtotal', comment = 'FRA="Sous-total"';
        Terms_of_PaymentCaptionLbl: Label 'Terms of Payment', comment = 'FRA="Méthode réglement"';
        Text000: Label 'Salesperson', comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT', comment = 'FRA="Total %1 HT"';
        Text003: Label 'COPY', comment = 'FRA="COPIE"';
        Text004: Label 'Order Confirmation No.', comment = 'FRA="Confirmation de commande N°"';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', comment = 'FRA="Devise locale"';
        Text009: Label 'Exchange rate: %1/%2', comment = 'FRA="Taux de change : %1/%2"';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text068: Label '%1';
        Text070: Label 'Affair No.', comment = 'FRA="Affaire n°"';
        Text100: Label 'Salesperson : ';
        Text101: Label 'Phone :', comment = 'FRA="Tel:"';
        Text200: Label 'If you agree on conditions, please return this order acknowledgement duly signed and stamped', comment = 'FRA="Cette commande est soumise à nos conditions générales de vente dont vous avez pris connaissance."';
        Total_Due_CaptionLbl: Label 'Total Due ', comment = 'FRA="Net à Payer"';
        TOTAL_incl__VATCaptionLbl: Label 'TOTAL incl. VAT', comment = 'FRA="TOTAL TTC"';
        TotalCaptionLbl: Label 'Total';
        txtlbl12: label '%1 %2';
        V_DocumentCaptionLbl: Label 'V/Document';
        VATAmtCaptionLbl: Label 'VAT Amount', comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', comment = 'FRA="Détail montant TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', comment = 'FRA="Base TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', comment = 'FRA="Identifiant TVA"';
        VATPercentageCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';

        Without_your_agreement_by_return__we_regard_these_elements_as_accepted_from_your_part_CaptionLbl: Label 'Without your agreement by return, we regard these elements as accepted from your part.', Comment = 'FRA="Sans votre accord par retour, nous considérons ces éléments comme acceptés de votre part."';
        Asterisque: Text[1];
        Langue: Text[10];
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        ListeTable: Text[10];
        CrossrefNo: Text[20];
        TxtGAltFax: Text[20];
        TxtGAltPhone: Text[20];
        TxtGAltPostCode: Text[20];
        TxtGFax: Text[20];
        TxtGPhone: Text[20];
        CopyText: Text[30];
        Fax: Text[30];
        ModeDePayment: Text[30];
        Pays: Text[30];
        surReleve: Text[30];
        Tel: Text[30];
        TempGencod: Text[30];
        templibelledouanier: Text[30];
        TexG_User_Name: Text[30];
        TxtGAltCity: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        VATNoText: Text[30];
        ModeTransport: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltName: Text[50];
        TxtGDesignation: Text[50];
        TxtGTag: Text[50];
        VALExchRate: Text[50];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[80];
        VALSpecLCYHeader: Text[80];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        TmpNamereport: Text[100];
        AText200: Text[200];
        SalesPersonText: Text[200];
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        VotreRef: Text[200];

    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        RecGParamVente.GET();
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;
}
