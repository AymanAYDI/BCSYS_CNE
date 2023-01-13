report 50015 "BC6_Prices Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/PricesRequest.rdl';
    Caption = 'Prices Request', Comment = 'FRA="Demande de prix"';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order', Comment = 'FRA="Commande achat"';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    column(RespCenter_Picture; RespCenter.BC6_Picture)
                    {
                    }
                    column(RespCenter__Alt_Picture_; RespCenter."BC6_Alt Picture")
                    {
                    }
                    column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
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
                    column(PurchaseLine_Type; TempPurchLine.Type)
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(PurchLine__Expected_Receipt_Date_; TempPurchLine."Expected Receipt Date")
                        {
                        }
                        column(Purchase_Line__Description_Control; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No___Control; "Purchase Line"."No.")
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempPurchLine.FIND('-')
                            ELSE
                                TempPurchLine.NEXT;
                            "Purchase Line" := TempPurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (TempPurchLine."VAT Calculation Type" = TempPurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempPurchLine."Line Amount" := 0;

                            IF (TempPurchLine.Type = TempPurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchLine.FIND('+');
                            WHILE MoreLines AND (TempPurchLine.Description = '') AND (TempPurchLine."Description 2" = '') AND
                                  (TempPurchLine."No." = '') AND (TempPurchLine.Quantity = 0) AND
                                  (TempPurchLine.Amount = 0) DO
                                MoreLines := TempPurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            TempPurchLine.SETRANGE("Line No.", 0, TempPurchLine."Line No.");
                            SETRANGE(Number, 1, TempPurchLine.COUNT);
                            CurrReport.CREATETOTALS(TempPurchLine."Line Amount", TempPurchLine."Inv. Discount Amount");
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

                            CurrReport.BREAK;

                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                               TempVATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                                 TempVATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin

                            CurrReport.BREAK;

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

                            CurrReport.BREAK;

                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;

                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin

                            CurrReport.BREAK;

                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recLBuyVendor.SETFILTER("No.", "Purchase Header"."Buy-from Vendor No.");
                        IF recLBuyVendor.FINDFIRST THEN;
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record Job;
                    begin
                        IF "Purchase Header"."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := "Purchase Header"."BC6_Affair No.";
                            RecGJob.GET("Purchase Header"."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        END ELSE BEGIN
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        END;

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
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL;
                    TempVATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    OutputNo := OutputNo + 1;
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
                    SETRANGE(Number, 1, NoOfLoops);

                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET;


                IF BoolGRespCenter THEN
                    RespCenter.CALCFIELDS(RespCenter.BC6_Picture, RespCenter."BC6_Alt Picture")
                ELSE
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture, CompanyInfo."BC6_Alt Picture");




                IF RespCenter.GET(CodGRespCenter) THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";

                    BoolGRespCenter := TRUE;
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BoolGRespCenter := FALSE;
                END;

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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
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
                RecGUser.SETRANGE("User Name", ID);
                IF RecGUser.FIND('-') THEN
                    TexG_User_Name := RecGUser."User Name";

            end;

            trigger OnPreDataItem()
            begin
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
                    field(NoofCopiesF; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteractionF; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(CodGRespCenterF; CodGRespCenter)
                    {
                        Caption = 'Print Characteristics Agency:', Comment = 'FRA="Imprimer Caractéristiques Agence:"';
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
            ArchiveDocument := (PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Always) and PurchSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;

            CLEAR(CodGRespCenter);
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
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        TempPurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        RecGUser: Record User;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        recLBuyVendor: Record Vendor;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BoolGRespCenter: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        CodGDevise: Code[10];
        CodGRespCenter: Code[10];
        TotalAmountInclVAT: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CstGTxt01: Label 'Page', Comment = 'FRA="Page"';
        "DésignationCaptionLbl": Label 'Désignation', Comment = 'FRA="Désignation"';
        FAX___CaptionLbl: Label 'FAX : ', Comment = 'FRA="FAX : "';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: Label 'Date :', Comment = 'FRA="Date :"';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ', Comment = 'FRA="Interlocuteur : "';
        Prices_RequestCaptionLbl: Label 'Prices Request', Comment = 'FRA="Demande de prix"';
        Purchase_Header___Buy_from_Vendor_No__CaptionLbl: Label 'Vendor No.', Comment = 'FRA="N° fournisseur"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        TEL___CaptionLbl: Label 'TEL : ', Comment = 'FRA="TEL : "';
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total Order %1', Comment = 'FRA="Total commande %1"';
        Text002: Label 'Total Order %1 Incl. VAT', Comment = 'FRA="Total commande %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order %1', Comment = 'FRA="Commande %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total Order %1 Excl. VAT', Comment = 'FRA="Total commande %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise locale"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        Text010: Label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF FAX TO ', Comment = 'FRA="Nous vous prions de bien vouloir nous communiquer par retour, vos meilleurs prix et délais concernant le matériel suivant, d''avance merci."';
        Text011: Label 'DELIVERY ADDRESS', Comment = 'FRA="ADRESSE DE LIVRAISON"';
        Text012: Label 'No.', Comment = 'FRA="N°"';
        Text013: Label ' with capital of ', Comment = 'FRA=" au capital de "';
        Text014: Label ' -Registration ', Comment = 'FRA=" -SIRET "';
        Text015: Label ' -EP ', Comment = 'FRA=" -APE "';
        Text016: Label ' -VAT Registration ', Comment = 'FRA=" -N° TVA"';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text068: Label '%1';
        Text070: Label 'Affair No. : ', Comment = 'FRA="Affaire n° :"';
        TimeCaptionLbl: Label 'Time', Comment = 'FRA="Délai "';
        TxtGAltFax: Text[20];
        TxtGAltPhone: Text[20];
        TxtGAltPostCode: Text[20];
        TxtGFax: Text[20];
        TxtGPhone: Text[20];
        CopyText: Text[30];
        PurchaserText: Text[30];
        ReferenceText: Text[30];
        TexG_User_Name: Text[30];
        TextGVendorFax: Text[30];
        TextGVendorTel: Text[30];
        TxtGAltCity: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        VATNoText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltName: Text[50];
        TxtGDesignation: Text[50];
        TxtGTag: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[80];
        VALSpecLCYHeader: Text[80];
        DimText: Text[120];

    procedure DefineTagFax(TxtLTag: Text[50])
    begin
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."BC6_RTE Fax Tag" + TxtLTag + '@cne.fax';
    end;

    procedure DefineTagMail(TxtLTag: Text[50])
    begin
        RecGParamVente.GET;
        TxtGTag := RecGParamVente."BC6_PDF Mail Tag" + TxtLTag;
    end;


    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

