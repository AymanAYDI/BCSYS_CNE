report 50015 "BC6_Prices Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/PricesRequest.rdl';
    Caption = 'Prices Request';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {

            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
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
                    column(Text012_Purchase_Header___No__; Text012 + ' ' + PurchaseHeader."No.")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; PurchaseHeader."Buy-from Vendor No.")
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_; FORMAT(PurchaseHeader."Document Date", 0, 4))
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
                    column(RespCenter_Picture; RespCenter."BC6_Picture")
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
                    column(Purchase_Header_Location_Code; PurchaseHeader."Location Code")
                    {
                    }
                    column(Purchase_Line_LineNo; PurchaseLine."Line No.")
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
                    column(Purchase_Line___Unit_of_Measure_Caption; PurchaseLine.FIELDCAPTION("Unit of Measure"))
                    {
                    }
                    column(TimeCaption; TimeCaptionLbl)
                    {
                    }
                    column(Purchase_Header___Ship_to_Name_; PurchaseHeader."Ship-to Name")
                    {
                    }
                    column(Purchase_Header___Ship_to_Address_; PurchaseHeader."Ship-to Address")
                    {
                    }
                    column(Purchase_Header___Ship_to_Address_2_; PurchaseHeader."Ship-to Address 2")
                    {
                    }
                    column(Purchase_Header___Ship_to_Post_Code_; PurchaseHeader."Ship-to Post Code")
                    {
                    }
                    column(Purchase_Header___Ship_to_City_; PurchaseHeader."Ship-to City")
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
                    dataitem(PurchaseLine; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                      "Document No." = FIELD("No.");
                        DataItemLinkReference = PurchaseHeader;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Purchase_Line__Description; PurchaseLine.Description)
                        {
                        }
                        column(Purchase_Line___No__; PurchaseLine."No.")
                        {
                        }
                        column(Purchase_Line__Quantity; PurchaseLine.Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_; PurchaseLine."Unit of Measure")
                        {
                        }
                        column(PurchLine__Expected_Receipt_Date_; PurchLine."Expected Receipt Date")
                        {
                        }
                        column(Purchase_Line__Description_Control; PurchaseLine.Description)
                        {
                        }
                        column(Purchase_Line___No___Control; PurchaseLine."No.")
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT;
                            PurchaseLine := PurchLine;

                            IF NOT PurchaseHeader."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                PurchaseLine."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                               VATAmountLine."VAT Base", PurchaseHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                                 VATAmountLine."VAT Amount", PurchaseHeader."Currency Factor"));
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

                            IF PurchaseHeader."Buy-from Vendor No." = PurchaseHeader."Pay-to Vendor No." THEN
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

                            IF (PurchaseHeader."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recLBuyVendor.SETFILTER("No.", PurchaseHeader."Buy-from Vendor No.");
                        IF recLBuyVendor.FINDFIRST THEN;
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record Job;
                    begin
                        IF PurchaseHeader."BC6_Affair No." <> '' THEN BEGIN
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := PurchaseHeader."BC6_Affair No.";
                            RecGJob.GET(PurchaseHeader."BC6_Affair No.");
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
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines(PurchaseHeader, PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, PurchaseHeader, PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, PurchaseHeader, PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(PurchaseHeader."Currency Code", PurchaseHeader."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    OutputNo := OutputNo + 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN(PurchaseHeader);
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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET;
                IF BoolGRespCenter THEN
                    RespCenter.CALCFIELDS(RespCenter."BC6_Picture", RespCenter."BC6_Alt Picture")
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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
                IF (PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
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

                FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument(PurchaseHeader, LogInteraction);

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
                    field(NoofCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(CodGRespCenter; CodGRespCenter)
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
            //TODO ArchiveDocument := PurchSetup."Archive Quotes and Orders";
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
        Language: Codeunit Language;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        RecGParamVente: Record "Sales & Receivables Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        RecGUser: Record User;
        VATAmountLine: Record "VAT Amount Line" temporary;
        recLBuyVendor: Record Vendor;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
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
        "-NSC-": Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CstGTxt01: Label 'Page';
        "DésignationCaptionLbl": Label 'Désignation';
        FAX___CaptionLbl: Label 'FAX : ';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: Label 'Date :', comment = 'FRA="Date :"';
        Interlocutor___CaptionLbl: Label 'Interlocutor : ', comment = 'FRA="Interlocuteur : "';
        Prices_RequestCaptionLbl: Label 'Prices Request', comment = 'FRA="Demande de prix"';
        Purchase_Header___Buy_from_Vendor_No__CaptionLbl: Label 'Vendor No.', comment = 'FRA="N° fournisseur"';
        QuantityCaptionLbl: Label 'Quantity', comment = 'FRA="Quantité"';
        ReferenceCaptionLbl: Label 'Reference', comment = 'FRA="Reference"';
        TEL___CaptionLbl: Label 'TEL : ';
        Text000: Label 'Purchaser', comment = 'FRA="Acheteur"';
        Text001: Label 'Total Order %1', comment = 'FRA="Total commande %1"';
        Text002: Label 'Total Order %1 Incl. VAT', comment = 'FRA="Total commande %1 TTC"';
        Text003: Label 'COPY', comment = 'FRA="COPIE"';
        Text004: Label 'Order %1', comment = 'FRA="Commande %1"';
        Text005: Label 'Page %1', comment = 'FRA="Page %1"';
        Text006: Label 'Total Order %1 Excl. VAT', comment = 'FRA="Total commande %1 HT"';
        Text007: Label 'VAT Amount Specification in ', comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', comment = 'FRA="Devise locale"';
        Text009: Label 'Exchange rate: %1/%2', comment = 'FRA="Taux de change : %1/%2"';
        Text010: Label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF FAX TO ', comment = 'FRA="IMPERATIF : NOUS CONFIRMER CETTE COMMANDE PAR RETOUR D''EMAIL A ""';
        Text011: Label 'DELIVERY ADDRESS', comment = 'FRA="ADRESSE DE LIVRAISON"';
        Text012: Label 'No.', comment = 'FRA="N°"';
        Text013: Label ' with capital of ', comment = 'FRA="au capital de"';
        Text014: Label ' -Registration ', comment = 'FRA="-SIRET"';
        Text015: Label ' -EP ';
        Text016: Label ' -VAT Registration ', comment = 'FRA="-N° TVA "';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', comment = 'FRA="%1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - n°TVA : %5"';
        Text068: Label '%1';
        Text070: Label 'Affair No. : ', comment = 'FRA="Affaire n° :"';
        TimeCaptionLbl: Label 'Time', comment = 'FRA="Délai "';
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

