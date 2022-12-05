report 50015 "Prices Request"
{
    // //Report Purchase Order CASC 13/12/2006 NSC1.01 : Creation du report
    // //DESIGN DARI 19/01/2007 NSC1.03
    // 
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
    // //TDL89:MICO LE 28/03/07 :
    //           - Ajout code dans AfterGetRecord pour renseigner le nom de l'utilisateur en en-tête
    //             en fonction du ID.
    // 
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // //TDL DESIGN:DARI LE 12/04/07
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : Gestin des apples d'offres clients
    //         - Add field "Affaire No"
    // 
    // 
    // //>>CNE3.03
    // FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010 - RESPONSABILITY CENTER MANAGEMENT
    //                                            - Add Option "Print Characteristics Agency" In Request Form
    // 
    // ------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './PricesRequest.rdlc';

    Caption = 'Prices Request';

    dataset
    {
        dataitem(DataItem4458; Table38)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(Text012_Purchase_Header___No__; Text012 + ' ' + "Purchase Header"."No.")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_; FORMAT("Purchase Header"."Document Date", 0, 4))
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
                    column(recLBuyVendor__Phone_No__; recLBuyVendor."Phone No.")
                    {
                    }
                    column(recLBuyVendor__Fax_No__; recLBuyVendor."Fax No.")
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
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
                    column(Text066_TxtGPhone_TxtGFax_TxtGEmail_; STRSUBSTNO(Text066, TxtGPhone, TxtGFax, TxtGEmail))
                    {
                    }
                    column(CompanyAddr_2_3_4_5; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO('%1 %2', CompanyAddr[4], CompanyAddr[5]))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(TxtGHomePage; TxtGHomePage)
                    {
                    }
                    column(TxtGAltName; TxtGAltName)
                    {
                    }
                    column(TxtGAltAdress__Adress2_TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO('%1 %2', TxtGAltPostCode, TxtGAltCity))
                    {
                    }
                    column(Text066_TxtGAltPhone_TxtGAltFax_TxtGAltEmail_; STRSUBSTNO(Text066, TxtGAltPhone, TxtGAltFax, TxtGAltEmail))
                    {
                    }
                    column(Text068_TxtGAltHomePage_; STRSUBSTNO(Text068, TxtGAltHomePage))
                    {
                    }
                    column(Prices_RequestCaption; Prices_RequestCaptionLbl)
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__Caption; Purchase_Header___Buy_from_Vendor_No__CaptionLbl)
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl; FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl)
                    {
                    }
                    column(Interlocutor___Caption; Interlocutor___CaptionLbl)
                    {
                    }
                    column(TEL___Caption; TEL___CaptionLbl)
                    {
                    }
                    column(FAX___Caption; FAX___CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Page_Caption; CstGTxt01)
                    {
                    }
                    column(OutputNo_Val; OutputNo)
                    {
                    }
                    column(Purchase_Header_Location_Code; "Purchase Header"."Location Code")
                    {
                    }
                    column(Purchase_Line_LineNo; "Purchase Line"."Line No.")
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column("DésignationCaption"; DésignationCaptionLbl)
                    {
                    }
                    column(QuantityCaption; QuantityCaptionLbl)
                    {
                    }
                    column(Purchase_Line___Unit_of_Measure_Caption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                    {
                    }
                    column(TimeCaption; TimeCaptionLbl)
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
                    column(Text010; Text010)
                    {
                    }
                    column(Text011; Text011)
                    {
                    }
                    column(PurchaseLine_Type; PurchLine.Type)
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
                        column(Purchase_Line__Description;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No__;"Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Quantity;"Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_;"Purchase Line"."Unit of Measure")
                        {
                        }
                        column(PurchLine__Expected_Receipt_Date_;PurchLine."Expected Receipt Date")
                        {
                        }
                        column(Purchase_Line__Description_Control;"Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No___Control;"Purchase Line"."No.")
                        {
                        }
                        column(RoundLoop_Number;Number)
                        {
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
                            //>>NSC1.03:DARI 18/01/2007
                            
                            CurrReport.BREAK;
                            /*
                            IF VATAmount = 0 THEN
                              CurrReport.BREAK;
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                            */
                            //<<NSC1.03:DARI 18/01/2007

                        end;
                    }
                    dataitem(VATCounterLCY;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);

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
                            //>>NSC1.03:DARI 18/01/2007
                            
                             CurrReport.BREAK;
                            /*
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
                            */
                            //<<NSC1.03:DARI 18/01/2007

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
                            //>>NSC1.03:DARI 18/01/2007

                             CurrReport.BREAK;

                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                              CurrReport.BREAK;

                            //<<NSC1.03:DARI 18/01/2007
                        end;
                    }
                    dataitem(Total3;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));

                        trigger OnPreDataItem()
                        begin
                            //>>NSC1.03:DARI 18/01/2007

                            CurrReport.BREAK;

                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                              CurrReport.BREAK;
                            //<<NSC1.03:DARI 18/01/2007
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>>MIGRATION NAV 2013
                        recLBuyVendor.SETFILTER("No.","Purchase Header"."Buy-from Vendor No.")  ;
                        IF recLBuyVendor.FINDFIRST THEN ;
                        //<<MIGRATION NAV 2013
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
                          TxtGLblProjet := '';
                          TxtGNoProjet := '';
                          TxtGDesignation :='';
                        END;

                        //>>MIGRATION NAV 2013
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
                        //<<MIGRATION NAV 2013
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

                    IF Number > 1 THEN
                      CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    //>>MIGRATION NAV 2013
                    OutputNo := OutputNo + 1;
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

                    //>>MIGRATION NAV 2013
                    OutputNo := 0;
                    //<<MIGRATION NAV 2013
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                
                CompanyInfo.GET;
                
                
                //>>MIGRATIONNAV2013
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                IF BoolGRespCenter THEN
                  RespCenter.CALCFIELDS(RespCenter.Picture,RespCenter."Alt Picture")
                ELSE
                  CompanyInfo.CALCFIELDS(CompanyInfo.Picture,CompanyInfo."Alt Picture");
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                //<<MIGRATIONNAV2013
                
                
                
                //>>FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                //CompanyInfo.CALCFIELDS(Picture, "Alt Picture");
                //<<FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 29/01/2010
                
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
                
                /*
                //<<NSC1.02:DARI 18/01/2007
                DocDim1.SETRANGE("Table ID",DATABASE::"Purchase Header");
                DocDim1.SETRANGE("Document Type","Purchase Header"."Document Type");
                DocDim1.SETRANGE("Document No.","Purchase Header"."No.");
                //>>NSC1.02:DARI 18/01/2007
                */
                
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
                //>>NSC1.02:DARI 18/01/2007
                /*
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
                */
                //<<NSC1.02:DARI 18/01/2007
                
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
                //>>TDL89:MICO LE 28/03/07
                RecGUser.SETRANGE("User Name",ID);
                IF RecGUser.FIND('-') THEN
                  TexG_User_Name := RecGUser."User Name";
                //<<TDL89:MICO LE 28/03/07

            end;

            trigger OnPreDataItem()
            begin
                //CompanyInfo.CALCFIELDS(Picture);
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
                    field(NoofCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInformation;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := PurchSetup."Archive Quotes and Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;

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
        Text010: Label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF FAX TO ';
        Text011: Label 'DELIVERY ADDRESS';
        CodGDevise: Code[10];
        Text012: Label 'No.';
        Text013: Label ' with capital of ';
        Text014: Label ' -Registration ';
        Text015: Label ' -EP ';
        Text016: Label ' -VAT Registration ';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        TexG_User_Name: Text[30];
        "-NSC-": Integer;
        RecGParamVente: Record "311";
        TxtGTag: Text[50];
        "-TDL MICO-": Integer;
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
        Prices_RequestCaptionLbl: Label 'Prices Request';
        Purchase_Header___Buy_from_Vendor_No__CaptionLbl: Label 'Vendor No.';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: Label 'Date :';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ';
        TEL___CaptionLbl: Label 'TEL : ';
        FAX___CaptionLbl: Label 'FAX : ';
        ReferenceCaptionLbl: Label 'Reference';
        "DésignationCaptionLbl": Label 'Désignation';
        QuantityCaptionLbl: Label 'Quantity';
        TimeCaptionLbl: Label 'Time';
        CstGTxt01: Label 'Page';
        OutputNo: Integer;
        RecGUser: Record "2000000120";
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PurchSetup: Record "312";

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
    procedure InitializeRequest(NewNoOfCopies: Integer;NewShowInternalInfo: Boolean;NewArchiveDocument: Boolean;NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

