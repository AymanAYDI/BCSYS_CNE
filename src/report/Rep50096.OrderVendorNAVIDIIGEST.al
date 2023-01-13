report 50096 "BC6_Order - Vendor NAVIDIIGEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/OrderVendorNAVIDIIGEST.rdl';

    Caption = 'Order NAVIDIIGEST', Comment = 'FRA="Commande fournisseur NAVIDIIGEST"';
    UsageCategory = None;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order', Comment = 'FRA="Commande achat"';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(ShowAmount; ShowAmount)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(Text30; Text30)
                {
                }
                column(Text20; Text20)
                {
                }
                column(Text10; Text10)
                {
                }
                column(DataItem1100267022; STRSUBSTNO(Text032, CompanyInfo.Name, CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."Registration No.", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                {
                }
                column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                {
                }
                column(Shipment_departementCaption; Shipment_departementCaptionLbl)
                {
                }
                column(ETA_at_DisportCaption; ETA_at_DisportCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(Vendor_NumberCaption; Vendor_NumberCaptionLbl)
                {
                }
                column(PaymentCaption; PaymentCaptionLbl)
                {
                }
                column(ReferenceCaption; ReferenceCaptionLbl)
                {
                }
                column(Terms_conditionCaption; Terms_conditionCaptionLbl)
                {
                }
                column(ContactCaption; ContactCaptionLbl)
                {
                }
                column(Phone_Caption; Phone_CaptionLbl)
                {
                }
                column(FaxCaption; FaxCaptionLbl)
                {
                }
                column("Mode_ExpéditionCaption"; Mode_ExpéditionCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Purchase_Line___Planned_Receipt_Date_Caption; Purchase_Line___Planned_Receipt_Date_CaptionLbl)
                {
                }
                column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                {
                }
                column(Purch__Unit_of_MeasureCaption; Purch__Unit_of_MeasureCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(Purchase_Line__DescriptionCaption; TempPurchaseLine.FIELDCAPTION(Description))
                {
                }
                column(ItemCaption; ItemCaptionLbl)
                {
                }
                column(Purchaser_referenceCaption; Purchaser_referenceCaptionLbl)
                {
                }
                column(Pcs___BoxCaption; Pcs___BoxCaptionLbl)
                {
                }
                column(QuantityCaption_Control1000000025; QuantityCaption_Control1000000025Lbl)
                {
                }
                column(COPYSTR__Purchase_Line__Description_1_28_Caption; COPYSTR__Purchase_Line__Description_1_28_CaptionLbl)
                {
                }
                column(ItemCaption_Control1000000036; ItemCaption_Control1000000036Lbl)
                {
                }
                column(Purchaser_referenceCaption_Control1000000041; Purchaser_referenceCaption_Control1000000041Lbl)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                {
                }
                column(Text50; Text50)
                {
                }
                column(StandardPurchaseLine_Description; StandardPurchaseLine.Description)
                {
                }
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(Purchase_Header___VAT_Registration_No__; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(BuyFromAddr_5_; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr_4_; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_3_; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_1_; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr_6_; BuyFromAddr[6])
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Purchase_Header___Requested_Receipt_Date_; "Purchase Header"."Requested Receipt Date")
                    {
                    }
                    column(Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
                    {
                    }
                    column(Purchase_Header___Pay_to_Contact_; "Purchase Header"."Pay-to Contact")
                    {
                    }
                    column(VotreRef; VotreRef)
                    {
                    }
                    column(ModeDePayment; ModeDePayment)
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(Tel; Tel)
                    {
                    }
                    column(Fax; Fax)
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(STRSUBSTNO___1__2__CompanyInfo__Home_Page__CompanyInfo__E_Mail__; STRSUBSTNO(txtlbl12, CompanyInfo."Home Page", CompanyInfo."E-Mail"))
                    {
                    }
                    column(STRSUBSTNO_Text033_CompanyInfo__Fax_No___; STRSUBSTNO(Text033, CompanyInfo."Fax No."))
                    {
                    }
                    column(STRSUBSTNO_Text031_CompanyInfo__Phone_No___; STRSUBSTNO(Text031, CompanyInfo."Phone No."))
                    {
                    }
                    column(pays; pays)
                    {
                    }
                    column(STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; STRSUBSTNO(txtlbl12, CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
                    {
                    }
                    column(BuyFromAddr_2_; BuyFromAddr[2])
                    {
                    }
                    column(ModeTransport; ModeTransport)
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(TmpNamereport; TmpNamereport)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DocDim1.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      txtlbl12, DocDim1."Dimension Code", DocDim1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DocDim1."Dimension Code", DocDim1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DocDim1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(TraitementTexteFournisseur; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(TraitementTexteFournisseur_Number; Number)
                        {
                        }
                        dataitem(TexteFournisseur; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(TexteFournisseur_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Edition2 THEN BEGIN
                                    IF Number = 1 THEN
                                        StandardPurchaseLine.FIND('-')
                                    ELSE BEGIN
                                        StandardPurchaseLine.NEXT();
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT Edition THEN CurrReport.BREAK();
                                StandardPurchaseLine.RESET();
                                StandardPurchaseLine.SETRANGE(StandardPurchaseLine."Standard Purchase Code", StandardVendorPurchaseCode.Code);
                                Edition2 := TRUE;
                                IF StandardPurchaseLine.COUNT <> 0 THEN
                                    TexteFournisseur.SETRANGE(Number, 1, StandardPurchaseLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT Edition THEN CurrReport.BREAK();
                            IF Number = 1 THEN
                                StandardVendorPurchaseCode.FIND('-')
                            ELSE
                                StandardVendorPurchaseCode.NEXT();
                        end;

                        trigger OnPreDataItem()
                        begin
                            StandardVendorPurchaseCode.RESET();
                            StandardVendorPurchaseCode.SETRANGE(StandardVendorPurchaseCode.BC6_TextautoReport, TRUE);
                            StandardVendorPurchaseCode.SETRANGE(StandardVendorPurchaseCode."Vendor No.", "Purchase Header"."Buy-from Vendor No.");
                            Edition := TRUE;
                            IF StandardVendorPurchaseCode.COUNT <> 0 THEN
                                TraitementTexteFournisseur.SETRANGE(Number, 1, StandardVendorPurchaseCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(DataItem6547; 39)
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
                        column(PurchLine__Line_Amount_; TempPurchaseLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description; TempPurchaseLine.Description)
                        {
                        }
                        column(Purchase_Line__Description_Control1000000172; TempPurchaseLine.Description)
                        {
                        }
                        column(Purchase_Line___Line_Amount_; TempPurchaseLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___Planned_Receipt_Date_; TempPurchaseLine."Planned Receipt Date")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_; TempPurchaseLine."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Unit_of_Measure_Code_; TempPurchaseLine."Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Quantity; TempPurchaseLine.Quantity)
                        {
                        }
                        column(COPYSTR__Purchase_Line__Description_1_28_; COPYSTR(TempPurchaseLine.Description, 1, 28))
                        {
                        }
                        column(Purchase_Line___No__; TempPurchaseLine."No.")
                        {
                        }
                        column(CrossrefNo; CrossrefNo)
                        {
                        }
                        column(COPYSTR__Purchase_Line__Description_29_22_; COPYSTR(TempPurchaseLine.Description, 29, 22))
                        {
                        }
                        column(Purchase_Line___Units_per_Parcel_; TempPurchaseLine."Units per Parcel")
                        {
                        }
                        column(Purchase_Line__Quantity_Control1000000064; TempPurchaseLine.Quantity)
                        {
                        }
                        column(Purchase_Line__Description_Control1000000066; TempPurchaseLine.Description)
                        {
                        }
                        column(Purchase_Line___No___Control1000000076; TempPurchaseLine."No.")
                        {
                        }
                        column(CrossrefNo_Control1000000080; CrossrefNo)
                        {
                        }
                        column(PurchLine__Line_Amount__Control1000000069; TempPurchaseLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; TempPurchaseLine."Line Amount" - TempPurchaseLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount; TempPurchaseLine."Line Amount" - TempPurchaseLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(NextCaption; NextCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control1000000070; ContinuedCaption_Control1000000070Lbl)
                        {
                        }
                        column(To_be_continuedCaption; To_be_continuedCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(BooGVisibleBody1; BooGVisibleBody1)
                        {
                        }
                        column(BooGVisibleBody2; BooGVisibleBody2)
                        {
                        }
                        column(BooGVisibleBody3; BooGVisibleBody3)
                        {
                        }
                        column(BooGVisibleBody4; BooGVisibleBody4)
                        {
                        }
                        column(BooGVisibleBody5; BooGVisibleBody5)
                        {
                        }
                        column(Purchase_Line_Inv_Discount_Amount; TempPurchaseLine."Inv. Discount Amount")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DocDim2.FIND('-') THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          txtlbl12, DocDim2."Dimension Code", DocDim2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DocDim2."Dimension Code", DocDim2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DocDim2.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempPurchaseLine.FIND('-')
                            ELSE
                                TempPurchaseLine.NEXT();
                            TempPurchaseLine := TempPurchaseLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (TempPurchaseLine."VAT Calculation Type" = TempPurchaseLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempPurchaseLine."Line Amount" := 0;

                            IF (TempPurchaseLine.Type = TempPurchaseLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                TempPurchaseLine."No." := '';

                            CrossrefNo := '';
                            IF ItemVendor.GET(TempPurchaseLine."Buy-from Vendor No.", TempPurchaseLine."No.", TempPurchaseLine."Variant Code") THEN
                                CrossrefNo := ItemVendor."Vendor Item No.";
                            IF CrossrefNo = '' THEN
                                CrossrefNo := TempPurchaseLine."Item Reference No.";
                            TempNomenclaturedouaniere := '';
                            item.RESET();
                            IF "Purchase Header"."Buy-from Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                                IF TempPurchaseLine.Type = TempPurchaseLine.Type::Item THEN
                                    IF item.GET(TempPurchaseLine."No.") THEN
                                        TempNomenclaturedouaniere := item."Tariff No.";
                                ;
                            END;

                            Asterisque := COPYSTR(TempPurchaseLine.Description, 1, 1);

                            BooGVisibleBody1 := ((TempPurchaseLine.Type.AsInteger() = 0) AND (ShowAmount = TRUE) AND (Asterisque <> '*'));
                            BooGVisibleBody2 := ((TempPurchaseLine.Type.AsInteger() = 0) AND (ShowAmount = FALSE) AND (Asterisque <> '*'));

                            BooGVisibleBody3 := (TempPurchaseLine.Type.AsInteger() > 0) AND (ShowAmount = TRUE);

                            IF (TempPurchaseLine."Line Amount" <> 0) AND (TempPurchaseLine.Quantity <> 0) THEN
                                PrixNet := TempPurchaseLine."Line Amount" / TempPurchaseLine.Quantity
                            ELSE
                                PrixNet := 0;

                            BooGVisibleBody4 := (TempPurchaseLine.Type.AsInteger() > 0) AND (ShowAmount = TRUE)
                                                 AND (COPYSTR(TempPurchaseLine.Description, 29, 22) <> '');
                            BooGVisibleBody5 := (TempPurchaseLine.Type.AsInteger() > 0) AND (ShowAmount = FALSE);

                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchaseLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchaseLine.FIND('+');
                            WHILE MoreLines AND (TempPurchaseLine.Description = '') AND (TempPurchaseLine."Description 2" = '') AND
                                  (TempPurchaseLine."No." = '') AND (TempPurchaseLine.Quantity = 0) AND
                                  (TempPurchaseLine.Amount = 0) DO
                                MoreLines := TempPurchaseLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempPurchaseLine.SETRANGE("Line No.", 0, TempPurchaseLine."Line No.");
                            SETRANGE(Number, 1, TempPurchaseLine.COUNT);
                            CurrReport.CREATETOTALS(TempPurchaseLine."Line Amount", TempPurchaseLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

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
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
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

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        IF CurrReport.PAGENO() = 1 THEN BEGIN
                            FlagText10 := FALSE;
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
                            IF (Text10 <> '') OR (Text20 <> '') OR (Text30 <> '') THEN
                                FlagText10 := FALSE;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TempPurchaseLine);
                    CLEAR(PurchPost);
                    TempPurchaseLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchaseLine, 0);
                    TempPurchaseLine.CalcVATAmountLines(0, "Purchase Header", TempPurchaseLine, TempVATAmountLine);
                    TempPurchaseLine.UpdateVATOnLines(0, "Purchase Header", TempPurchaseLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := LanguageC.GetLanguageId("Language Code");

                CompanyInfo.GET();
                IF country.GET(CompanyInfo."Country/Region Code") THEN
                    pays := country.Name;


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                ModeDePayment := '';
                IF PaymentMethod.GET("Purchase Header"."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;

                //Recherche des libellés text selon langue
                LangueLig01 := Language.Code + '' + '01';
                ListeTable := 'CDEFOU';
                IF TablesDiverses.GET(ListeTable, LangueLig01) THEN BEGIN
                    TmpNamereport := TablesDiverses.Description + '' + "Purchase Header"."No.";
                    Langue := Language.Code;
                END ELSE BEGIN
                    Langue := 'FRA';
                    LangueLig01 := Langue + '' + '01';
                    IF TablesDiverses.GET(ListeTable, LangueLig01) THEN BEGIN
                        TmpNamereport := TablesDiverses.Description + '' + "Purchase Header"."No.";
                    END ELSE
                        TmpNamereport := Text300 + ' ' + "Purchase Header"."No.";
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
                FlagText40 := FALSE;

                IF (Text40 <> '') OR (Text50 <> '') THEN
                    FlagText40 := TRUE;
                Text200 := Text200T;
                Text201 := Text201T;
                Text202 := Text202T;
                Text203 := Text203T;
                Text204 := Text204T;

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := '';
                    PurchaserText := Text000 + '     ' + SalesPurchPerson.Name;
                    IF SalesPurchPerson."Phone No." <> '' THEN
                        PurchaserText := PurchaserText + ' ' + '   ' + '' + Text101 + ' ' + SalesPurchPerson."Phone No.";
                    IF SalesPurchPerson."E-Mail" <> '' THEN
                        PurchaserText := PurchaserText + ' ' + '   ' + ' ' + SalesPurchPerson.FIELDCAPTION("E-Mail") + ' ' + SalesPurchPerson."E-Mail";

                END;

                //Ajout du N° de Document externe dans le libellé de "Votre reference"
                IF ("Your Reference" = '') AND ("Vendor Invoice No." = '') THEN
                    VotreRef := ''
                ELSE BEGIN
                    //Ajout de concaténation du N° de document externe avec le "Your reference"
                    VotreRef := "Vendor Invoice No." + '  ' + "Your Reference";
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");

                //Ajout tel et fax fournisseur
                IF Vendor.GET("Buy-from Vendor No.") THEN;
                Tel := Vendor."Phone No.";
                Fax := Vendor."Fax No.";
                //Fin ajout tel et fax fournisseur

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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
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

                ModeTransport := '';
                IF ShippingAgent.GET("Purchase Header"."Shipment Method Code") THEN
                    ModeTransport := ShippingAgent.Name;

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
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        Enabled = BooGEnableArchiveDocument;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = BooGEnableLogInteraction;
                    }
                    field(ShowAmount; ShowAmount)
                    {
                        Caption = 'Show Amount', Comment = 'FRA="Afficher Montants"';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule();
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            BooGEnableLogInteraction := LogInteraction;
            BooGEnableArchiveDocument := ArchiveDocument;

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        ShowAmount := TRUE;


        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS(Picture);
    end;

    var
        TablesDiverses: Record "BC6_Various Tables";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        country: Record "Country/Region";
        DocDim1: Record "Dimension Set Entry";
        DocDim2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        item: Record Item;
        ItemReference: Record "Item Reference";
        ItemVendor: Record "Item Vendor";
        Language: Record Language;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        TempPurchaseLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        StandardPurchaseLine: Record "Standard Purchase Line";
        StandardVendorPurchaseCode: Record "Standard Vendor Purchase Code";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Vendor: Record Vendor;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        LanguageC: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        BooGEnableArchiveDocument: Boolean;
        [InDataSet]
        BooGEnableLogInteraction: Boolean;
        BooGVisibleBody1: Boolean;
        BooGVisibleBody2: Boolean;
        BooGVisibleBody3: Boolean;
        BooGVisibleBody4: Boolean;
        BooGVisibleBody5: Boolean;
        Continue: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        FlagText: Boolean;
        FlagText10: Boolean;
        FlagText40: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowAmount: Boolean;
        ShowInternalInfo: Boolean;
        OutputNo: Decimal;
        PrixNet: Decimal;
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        "-MIGNAV2013-": Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant HT"';
        ContactCaptionLbl: Label 'Contact', Comment = 'FRA="Contact"';
        ContinuedCaption_Control1000000070Lbl: Label 'Continued', Comment = 'FRA="Report"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        COPYSTR__Purchase_Line__Description_1_28_CaptionLbl: Label 'Label1000000035';
        DateCaptionLbl: Label 'Date';
        ETA_at_DisportCaptionLbl: Label 'ETA at Disport', Comment = 'FRA="Date Réception"';
        FaxCaptionLbl: Label 'Fax';
        ItemCaption_Control1000000036Lbl: Label 'Item', Comment = 'FRA="Référence"';
        ItemCaptionLbl: Label 'Item', Comment = 'FRA="Référence"';
        "Mode_ExpéditionCaptionLbl": Label 'Mode Expédition';
        NextCaptionLbl: Label 'Next', Comment = 'FRA="Suite"';
        PaymentCaptionLbl: Label 'Payment', Comment = 'FRA="Mode de règlement"';
        Pcs___BoxCaptionLbl: Label 'Pcs / Box', Comment = 'FRA="Pcs / carton"';
        Phone_CaptionLbl: Label 'Phone ', Comment = 'FRA="Tel  :"';
        Purch__Unit_of_MeasureCaptionLbl: Label 'Purch. Unit of Measure', Comment = 'FRA="Unité d''achat"';
        Purchase_Line___Planned_Receipt_Date_CaptionLbl: Label 'Requested date', Comment = 'FRA="Date Recpt souhaitée"';
        Purchaser_referenceCaption_Control1000000041Lbl: Label 'Purchaser reference', Comment = 'FRA="Référence Fournisseur"';
        Purchaser_referenceCaptionLbl: Label 'Purchaser reference', Comment = 'FRA="Référence Fournisseur"';
        QuantityCaption_Control1000000025Lbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        Shipment_departementCaptionLbl: Label 'Shipment departement', Comment = 'FRA="Adresse de livraison"';
        Terms_conditionCaptionLbl: Label 'Terms condition', Comment = 'FRA="Mode de règlement"';
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order %1', Comment = 'FRA="Commande %1"';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text016: Label 'INVOICE DEPARTMENT', Comment = 'FRA="SERVICE FACTURATION"';
        Text030: Label '%1 - %2 - %3 %4', Comment = 'FRA="%1 - %2 - %3"';
        Text031: Label 'Tel. :  %1 - Fax :  %2';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 AU CAPITAL DE %2  · %3  · SIRET %4 ·  APE %5 · TVA %6"';
        Text033: Label 'Fax : %1', Comment = 'FRA="Fax : %1"';
        Text101: Label 'Phone :', Comment = 'FRA="Tel :"';
        Text200T: Label '* legende des unités : un = unités ; ct = cent ; m = mille ; ml = mètre ; kg = kilo';
        Text201T: Label 'Sans ACCUSE DE RECEPTION de votre part sous huitaine, nous considèrerons que les conditions de cette commande sont ';
        Text202T: Label 'acceptées.';
        Text203T: Label 'L''acceptation de cette commande annule toute clause d''attribution de juridiction éventuellement présente dans vos conditions de';
        Text204T: Label ' vente. En cas de litige, seul sera compétent le Tribunal de Commerce de Provins.';
        Text300: Label 'Vendor Order No.', Comment = 'FRA="Commande fournisseur N°"';
        To_be_continuedCaptionLbl: Label 'To be continued', Comment = 'FRA="A Suivre"';
        Unit_PriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire HT"';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>', Comment = 'FRA="N° TVA :"';
        Vendor_NumberCaptionLbl: Label 'Vendor Number', Comment = 'FRA="Code Fournisseur"';
        txtlbl12: label '%1 %2';
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
        CopyText: Text[30];
        Fax: Text[30];
        ModeDePayment: Text[30];
        ModeTransport: Text[30];
        pays: Text[30];
        ReferenceText: Text[30];
        Tel: Text[30];
        templibelledouanier: Text[30];
        Text60: Text[30];
        VATNoText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TempNomenclaturedouaniere: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VendAddr: array[8] of Text[50];
        TempDesc: Text[60];
        OldDimText: Text[75];
        DimText: Text[120];
        PurchaserText: Text[200];
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        Text200: Text[200];
        Text201: Text[200];
        Text202: Text[200];
        Text203: Text[200];
        Text204: Text[200];
        VotreRef: Text[200];
        TmpNamereport: Text[500];
}

