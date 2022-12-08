report 50096 "Order - Vendor NAVIDIIGEST"
{
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Doc_commerciaux] Création de l'état à partir de l'état 405 - Cde achat
    DefaultLayout = RDLC;
    RDLCLayout = './OrderVendorNAVIDIIGEST.rdlc';

    Caption = 'Order NAVIDIIGEST';

    dataset
    {
        dataitem(DataItem4458; Table38)
        {
            DataItemTableView = SORTING(Document Type, No.)
                                WHERE(Document Type=CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
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
            dataitem(CopyLoop; Table2000000026)
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
                column(Purchase_Line__DescriptionCaption; "Purchase Line".FIELDCAPTION(Description))
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
                column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(Text50; Text50)
                {
                }
                column(StandardPurchaseLine_Description; StandardPurchaseLine.Description)
                {
                }
                dataitem(PageLoop; Table2000000026)
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
                    column(STRSUBSTNO___1__2__CompanyInfo__Home_Page__CompanyInfo__E_Mail__; STRSUBSTNO('%1 %2', CompanyInfo."Home Page", CompanyInfo."E-Mail"))
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
                    column(STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
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
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
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
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DocDim1.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Value Code")
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
                            UNTIL (DocDim1.NEXT = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(TraitementTexteFournisseur; Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(TraitementTexteFournisseur_Number; Number)
                        {
                        }
                        dataitem(TexteFournisseur; Table2000000026)
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
                                        StandardPurchaseLine.NEXT;
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT Edition THEN CurrReport.BREAK;
                                StandardPurchaseLine.RESET;
                                StandardPurchaseLine.SETRANGE(StandardPurchaseLine."Standard Purchase Code", StandardVendorPurchaseCode.Code);
                                Edition2 := TRUE;
                                IF StandardPurchaseLine.COUNT <> 0 THEN
                                    TexteFournisseur.SETRANGE(Number, 1, StandardPurchaseLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT Edition THEN CurrReport.BREAK;
                            IF Number = 1 THEN
                                StandardVendorPurchaseCode.FIND('-')
                            ELSE
                                StandardVendorPurchaseCode.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin
                            StandardVendorPurchaseCode.RESET;
                            StandardVendorPurchaseCode.SETRANGE(StandardVendorPurchaseCode.TextautoReport, TRUE);
                            StandardVendorPurchaseCode.SETRANGE(StandardVendorPurchaseCode."Vendor No.", "Purchase Header"."Buy-from Vendor No.");
                            Edition := TRUE;
                            IF StandardVendorPurchaseCode.COUNT <> 0 THEN
                                TraitementTexteFournisseur.SETRANGE(Number, 1, StandardVendorPurchaseCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
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
                        column(PurchLine__Line_Amount_;PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Description_Control1000000172;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___Line_Amount_;"Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___Planned_Receipt_Date_;"Purchase Line"."Planned Receipt Date")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_;"Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Unit_of_Measure_Code_;"Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Quantity;"Purchase Line".Quantity)
                        {
                        }
                        column(COPYSTR__Purchase_Line__Description_1_28_;COPYSTR("Purchase Line".Description,1,28))
                        {
                        }
                        column(Purchase_Line___No__;"Purchase Line"."No.")
                        {
                        }
                        column(CrossrefNo;CrossrefNo)
                        {
                        }
                        column(COPYSTR__Purchase_Line__Description_29_22_;COPYSTR("Purchase Line".Description,29,22))
                        {
                        }
                        column(Purchase_Line___Units_per_Parcel_;"Purchase Line"."Units per Parcel")
                        {
                        }
                        column(Purchase_Line__Quantity_Control1000000064;"Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line__Description_Control1000000066;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No___Control1000000076;"Purchase Line"."No.")
                        {
                        }
                        column(CrossrefNo_Control1000000080;CrossrefNo)
                        {
                        }
                        column(PurchLine__Line_Amount__Control1000000069;PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_;PurchLine."Line Amount"-PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount;PurchLine."Line Amount"-PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption;ContinuedCaptionLbl)
                        {
                        }
                        column(NextCaption;NextCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control1000000070;ContinuedCaption_Control1000000070Lbl)
                        {
                        }
                        column(To_be_continuedCaption;To_be_continuedCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number;Number)
                        {
                        }
                        column(BooGVisibleBody1;BooGVisibleBody1)
                        {
                        }
                        column(BooGVisibleBody2;BooGVisibleBody2)
                        {
                        }
                        column(BooGVisibleBody3;BooGVisibleBody3)
                        {
                        }
                        column(BooGVisibleBody4;BooGVisibleBody4)
                        {
                        }
                        column(BooGVisibleBody5;BooGVisibleBody5)
                        {
                        }
                        column(Purchase_Line_Inv_Discount_Amount;"Purchase Line"."Inv. Discount Amount")
                        {
                        }
                        dataitem(DimensionLoop2;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT DocDim2.FIND('-') THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2',DocDim2."Dimension Code",DocDim2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DocDim2."Dimension Code",DocDim2."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL (DocDim2.NEXT = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                  CurrReport.BREAK;
                                //A migrer
                                /*
                                DocDim2.SETRANGE("Table ID",DATABASE::"Purchase Line");
                                DocDim2.SETRANGE("Document Type","Purchase Line"."Document Type");
                                DocDim2.SETRANGE("Document No.","Purchase Line"."Document No.");
                                DocDim2.SETRANGE("Line No.","Purchase Line"."Line No.");
                                */

                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
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

                            //Debut affichage de la reference fournisseur
                            CrossrefNo := '';
                            IF ItemVendor.GET("Purchase Line"."Buy-from Vendor No.","Purchase Line"."No.","Purchase Line"."Variant Code") THEN
                              CrossrefNo := ItemVendor."Vendor Item No.";
                            IF CrossrefNo = '' THEN
                              CrossrefNo := "Purchase Line"."Cross-Reference No.";
                            //Fin affichage de la reference fournisseur

                            //Debut recuperation du code nomenclature douanière
                            TempNomenclaturedouaniere := '';
                            item.RESET;
                            IF "Purchase Header"."Buy-from Country/Region Code" <> CompanyInfo."Country/Region Code" THEN BEGIN
                              IF "Purchase Line".Type = "Purchase Line".Type::Item THEN
                                IF item.GET("Purchase Line"."No.") THEN
                                  TempNomenclaturedouaniere := item."Tariff No.";;
                            END;
                            //Fin recuperation du code nomenclature douanière

                            //>>MIGRATION NAV 2013

                            Asterisque:=COPYSTR(PurchLine.Description,1,1);

                            BooGVisibleBody1 := ((PurchLine.Type = 0) AND (ShowAmount=TRUE)AND (Asterisque<>'*'));
                            BooGVisibleBody2 := ((PurchLine.Type = 0) AND (ShowAmount=FALSE)AND (Asterisque<>'*'));

                            BooGVisibleBody3 := (PurchLine.Type > 0) AND (ShowAmount=TRUE);

                            //Calcul du Prix Net car dans la ligne, il n'y a que le prix brut (avant remise)
                            IF ("Purchase Line"."Line Amount" <> 0)  AND ("Purchase Line".Quantity <> 0) THEN
                              PrixNet := "Purchase Line"."Line Amount" / "Purchase Line".Quantity
                            ELSE
                              PrixNet :=0;
                            //Fin

                            BooGVisibleBody4 := (PurchLine.Type > 0) AND (ShowAmount=TRUE)
                                                 AND (COPYSTR("Purchase Line".Description,29,22)<>'');
                            BooGVisibleBody5 := (PurchLine.Type > 0) AND (ShowAmount=FALSE);

                            //<<MIGRATION NAV 2013
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
                            CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);

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
                    dataitem(Total;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
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

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                              CurrReport.BREAK;
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        //Debut recherche des libellés text selon langue
                        IF CurrReport.PAGENO = 1 THEN BEGIN
                          FlagText10 :=FALSE;
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
                          IF (Text10 <>'') OR (Text20 <> '') OR (Text30 <>'') THEN
                            FlagText10 :=FALSE;
                        END;
                        //Fin recherche des libellés text selon langue
                    end;
                }

                trigger OnAfterGetRecord()
                begin
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
                    //>>MIGRATION NAV 2013
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                      NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;
                    //<<MIGRATION NAV 2013
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                
                CompanyInfo.GET;
                IF country.GET(CompanyInfo."Country/Region Code") THEN
                  pays:= country.Name;
                
                
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                //A migrer
                /*
                DocDim1.SETRANGE("Table ID",DATABASE::"Purchase Header");
                DocDim1.SETRANGE("Document Type","Purchase Header"."Document Type");
                DocDim1.SETRANGE("Document No.","Purchase Header"."No.");
                */
                
                //Lecture des mode de règlement (Payment Methode)
                ModeDePayment:= '';
                IF PaymentMethod.GET("Purchase Header"."Payment Method Code") THEN
                  ModeDePayment := PaymentMethod.Description;
                
                //Recherche des libellés text selon langue
                LangueLig01 := Language.Code+''+'01';
                ListeTable := 'CDEFOU';
                IF TablesDiverses.GET(ListeTable,LangueLig01) THEN BEGIN
                  TmpNamereport := TablesDiverses.Description +''+"Purchase Header"."No.";
                  Langue := Language.Code;
                END ELSE BEGIN
                  Langue := 'FRA';
                  LangueLig01 := Langue+''+'01';
                  IF TablesDiverses.GET(ListeTable,LangueLig01) THEN BEGIN
                    TmpNamereport := TablesDiverses.Description +''+"Purchase Header"."No.";
                  END ELSE
                    TmpNamereport := Text300 + ' ' + "Purchase Header"."No.";
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
                FlagText40:=FALSE;
                
                IF (Text40<>'') OR (Text50<>'') THEN
                  FlagText40:=TRUE;
                Text200:=Text200T;
                Text201:=Text201T;
                Text202:=Text202T;
                Text203:=Text203T;
                Text204:=Text204T;
                //Fin recherche des libellés text selon langue
                
                IF "Purchaser Code" = '' THEN BEGIN
                  SalesPurchPerson.INIT;
                  PurchaserText := '';
                END ELSE BEGIN
                  SalesPurchPerson.GET("Purchaser Code");
                //  PurchaserText := Text000
                  PurchaserText:='';
                  PurchaserText:= Text000 +'     ' + SalesPurchPerson.Name;
                  IF SalesPurchPerson."Phone No." <>'' THEN
                  PurchaserText:= PurchaserText +' ' +'   '+''+ Text101 +' ' + SalesPurchPerson."Phone No.";
                  IF SalesPurchPerson."E-Mail" <>'' THEN
                  PurchaserText:= PurchaserText +' ' +'   '+' '+ SalesPurchPerson.FIELDCAPTION("E-Mail") +' ' + SalesPurchPerson."E-Mail";
                
                END;
                
                //Ajout du N° de Document externe dans le libellé de "Votre reference"
                IF ("Your Reference" = '') AND ("Vendor Invoice No." = '' ) THEN
                  //ReferenceText := ''
                  VotreRef := ''
                ELSE
                  BEGIN
                    //ReferenceText := FIELDCAPTION("Your Reference");
                    //ReferenceText := 'Votre Référence :';
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
                Tel:=Vendor."Phone No.";
                Fax:=Vendor."Fax No.";
                //Fin ajout tel et fax fournisseur
                
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
                
                //Lecture Mode transport
                ModeTransport:='';
                IF ShippingAgent.GET("Purchase Header"."Shipment Method Code") THEN
                   ModeTransport:=ShippingAgent.Name;
                //FIN

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
                        Enabled = BooGEnableArchiveDocument;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = BooGEnableLogInteraction;
                    }
                    field(ShowAmount;ShowAmount)
                    {
                        Caption = 'Show Amount';
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
            LogInteraction  := SegManagement.FindInteractTmplCode(13) <> '';

            BooGEnableLogInteraction  := LogInteraction;
            BooGEnableArchiveDocument := ArchiveDocument;

            //<<MIGRATION NAV 2013
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        ShowAmount:=TRUE;

        //CompanyInfo.GET;

        //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
        //CompanyInfo.CALCFIELDS(Picture);
        //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010


         CompanyInfo1.GET;
         CompanyInfo1.CALCFIELDS(Picture);
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        VATAmountLine: Record "290" temporary;
        PurchLine: Record "39" temporary;
        DocDim1: Record "480";
        DocDim2: Record "480";
        RespCenter: Record "5714";
        Language: Record "8";
        ItemVendor: Record "99";
        PurchCountPrinted: Codeunit "317";
        FormatAddr: Codeunit "365";
        PurchPost: Codeunit "90";
        ArchiveManagement: Codeunit "5063";
        SegManagement: Codeunit "5051";
        country: Record "9";
        pays: Text[30];
        VendAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        BuyFromAddr: array [8] of Text[50];
        PurchaserText: Text[200];
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
        ModeDePayment: Text[30];
        VotreRef: Text[200];
        Text016: Label 'INVOICE DEPARTMENT';
        Text030: Label '%1 - %2 - %3 %4';
        Text031: Label 'Tel. :  %1 - Fax :  %2';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        PrixNet: Decimal;
        Text60: Text[30];
        Text50: Text[200];
        TmpNamereport: Text[500];
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        TablesDiverses: Record "50001";
        Langue: Text[10];
        ListeTable: Text[10];
        ItemCrossReference: Record "5717";
        CrossrefNo: Text[20];
        Vendor: Record "23";
        item: Record "27";
        templibelledouanier: Text[30];
        ShowAmount: Boolean;
        TempNomenclaturedouaniere: Text[50];
        PaymentMethod: Record "289";
        Text033: Label 'Fax : %1';
        Text101: Label 'Phone :';
        Text200T: Label '* legende des unités : un = unités ; ct = cent ; m = mille ; ml = mètre ; kg = kilo';
        Text201T: Label 'Sans ACCUSE DE RECEPTION de votre part sous huitaine, nous considèrerons que les conditions de cette commande sont ';
        Text202T: Label 'acceptées.';
        Text203T: Label 'L''acceptation de cette commande annule toute clause d''attribution de juridiction éventuellement présente dans vos conditions de';
        Text204T: Label ' vente. En cas de litige, seul sera compétent le Tribunal de Commerce de Provins.';
        Text200: Text[200];
        Text201: Text[200];
        Text202: Text[200];
        Text203: Text[200];
        Text204: Text[200];
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Fax: Text[30];
        Tel: Text[30];
        FlagText10: Boolean;
        FlagText40: Boolean;
        StandardVendorPurchaseCode: Record "175";
        StandardPurchaseLine: Record "174";
        FlagText: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        TempDesc: Text[60];
        Asterisque: Text[1];
        ModeTransport: Text[30];
        ShippingAgent: Record "291";
        Text300: Label 'Vendor Order No.';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>';
        Shipment_departementCaptionLbl: Label 'Shipment departement';
        ETA_at_DisportCaptionLbl: Label 'ETA at Disport';
        DateCaptionLbl: Label 'Date';
        Vendor_NumberCaptionLbl: Label 'Vendor Number';
        PaymentCaptionLbl: Label 'Payment';
        ReferenceCaptionLbl: Label 'Reference';
        Terms_conditionCaptionLbl: Label 'Terms condition';
        ContactCaptionLbl: Label 'Contact';
        Phone_CaptionLbl: Label 'Phone ';
        FaxCaptionLbl: Label 'Fax';
        "Mode_ExpéditionCaptionLbl": Label 'Mode Expédition';
        AmountCaptionLbl: Label 'Amount';
        Purchase_Line___Planned_Receipt_Date_CaptionLbl: Label 'Requested date';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Purch__Unit_of_MeasureCaptionLbl: Label 'Purch. Unit of Measure';
        QuantityCaptionLbl: Label 'Quantity';
        ItemCaptionLbl: Label 'Item';
        Purchaser_referenceCaptionLbl: Label 'Purchaser reference';
        Pcs___BoxCaptionLbl: Label 'Pcs / Box';
        QuantityCaption_Control1000000025Lbl: Label 'Quantity';
        COPYSTR__Purchase_Line__Description_1_28_CaptionLbl: Label 'Label1000000035';
        ItemCaption_Control1000000036Lbl: Label 'Item';
        Purchaser_referenceCaption_Control1000000041Lbl: Label 'Purchaser reference';
        ContinuedCaptionLbl: Label 'Continued';
        NextCaptionLbl: Label 'Next';
        ContinuedCaption_Control1000000070Lbl: Label 'Continued';
        To_be_continuedCaptionLbl: Label 'To be continued';
        "-MIGNAV2013-": Integer;
        OutputNo: Decimal;
        BooGVisibleBody1: Boolean;
        BooGVisibleBody2: Boolean;
        BooGVisibleBody3: Boolean;
        BooGVisibleBody4: Boolean;
        BooGVisibleBody5: Boolean;
        [InDataSet]
        BooGEnableArchiveDocument: Boolean;
        [InDataSet]
        BooGEnableLogInteraction: Boolean;
        CompanyInfo1: Record "79";
}

