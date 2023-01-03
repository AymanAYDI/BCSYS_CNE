report 50015 "BC6_Prices Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/PricesRequest.rdl';
    Caption = 'Prices Request', Comment = 'FRA="Demande de prix"';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {

            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Quote));
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
                DataItemTableView = sorting(Number);

                dataitem(PageLoop; Integer)
                {

                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
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
                    column(CompanyAddr_2_3_4_5; CompanyAddr[2] + ' ' + CompanyAddr[3] + ' ' + STRSUBSTNO(txtlbl12, CompanyAddr[4], CompanyAddr[5]))
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
                    column(TxtGAltAdress__Adress2_TxtGAltPostCode_TxtGAltCity_; TxtGAltAdress + ' ' + TxtGAltAdress2 + ' ' + STRSUBSTNO(txtlbl12, TxtGAltPostCode, TxtGAltCity))
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
                    column(PurchaseLine_Type; TempPurchLine.Type)
                    {
                    }
                    dataitem(PurchaseLine; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"),
                                      "Document No." = field("No.");
                        DataItemLinkReference = PurchaseHeader;
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);
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
                        column(PurchLine__Expected_Receipt_Date_; TempPurchLine."Expected Receipt Date")
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
                            if Number = 1 then
                                TempPurchLine.FIND('-')
                            else
                                TempPurchLine.NEXT();
                            PurchaseLine := TempPurchLine;

                            if not PurchaseHeader."Prices Including VAT" and
                               (TempPurchLine."VAT Calculation Type" = TempPurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempPurchLine."Line Amount" := 0;

                            if (TempPurchLine.Type = TempPurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                PurchaseLine."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchLine.DELETEALL();
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                               TempVATAmountLine."VAT Base", PurchaseHeader."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 PurchaseHeader."Posting Date", PurchaseHeader."Currency Code",
                                                 TempVATAmountLine."VAT Amount", PurchaseHeader."Currency Factor"));
                        end;

                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));

                        trigger OnPreDataItem()
                        begin

                            CurrReport.BREAK();

                            if PurchaseHeader."Buy-from Vendor No." = PurchaseHeader."Pay-to Vendor No." then
                                CurrReport.BREAK();

                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));

                        trigger OnPreDataItem()
                        begin

                            CurrReport.BREAK();

                            if (PurchaseHeader."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recLBuyVendor.SETFILTER("No.", PurchaseHeader."Buy-from Vendor No.");
                        if recLBuyVendor.FINDFIRST() then;
                    end;

                    trigger OnPreDataItem()
                    var
                        RecGJob: Record Job;
                    begin
                        if PurchaseHeader."BC6_Affair No." <> '' then begin
                            TxtGLblProjet := Text070;
                            TxtGNoProjet := PurchaseHeader."BC6_Affair No.";
                            RecGJob.GET(PurchaseHeader."BC6_Affair No.");
                            TxtGDesignation := RecGJob.Description;
                        end else begin
                            TxtGLblProjet := '';
                            TxtGNoProjet := '';
                            TxtGDesignation := '';
                        end;

                        if BoolGRespCenter then begin
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
                        end else begin
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
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines(PurchaseHeader, TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, PurchaseHeader, TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, PurchaseHeader, TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount(PurchaseHeader."Currency Code", PurchaseHeader."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    OutputNo := OutputNo + 1;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW then
                        PurchCountPrinted.RUN(PurchaseHeader);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesF) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);

                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET();
                IF BoolGRespCenter THEN
                    RespCenter.CALCFIELDS(RespCenter."BC6_Picture", RespCenter."BC6_Alt Picture")
                ELSE
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture, CompanyInfo."BC6_Alt Picture");
                IF RespCenter.GET(CodGRespCenterF) THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";

                    BoolGRespCenter := TRUE;
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BoolGRespCenter := FALSE;
                END;

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
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
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT()
                ELSE
                    PaymentMethod.GET("Payment Method Code");

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocumentF THEN
                        ArchiveManagement.StorePurchDocument(PurchaseHeader, LogInteractionF);

                    IF LogInteractionF THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;
                RecGUser.SETRANGE("User Name", BC6_ID);
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
                    field(NoofCopies; NoOfCopiesF)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocument; ArchiveDocumentF)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocumentF then
                                LogInteractionF := false;
                        end;
                    }
                    field(LogInteraction; LogInteractionF)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteractionF then
                                ArchiveDocumentF := ArchiveDocumentEnable;
                        end;
                    }
                    field(CodGRespCenter; CodGRespCenterF)
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
            ArchiveDocumentF := PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Always;
            LogInteractionF := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteractionF;

            CLEAR(CodGRespCenterF);
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
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
        ArchiveDocumentF: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BoolGRespCenter: Boolean;
        LogInteractionF: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ShowInternalInfo: Boolean;
        CodGRespCenterF: Code[10];
        TotalAmountInclVAT: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopiesF: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CstGTxt01: label 'Page';
        "DésignationCaptionLbl": label 'Désignation';
        FAX___CaptionLbl: label 'FAX : ';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: label 'Date :', comment = 'FRA="Date :"';
        Interlocutor___CaptionLbl: label 'Interlocutor : ', comment = 'FRA="Interlocuteur : "';
        Prices_RequestCaptionLbl: label 'Prices Request', comment = 'FRA="Demande de prix"';
        Purchase_Header___Buy_from_Vendor_No__CaptionLbl: label 'Vendor No.', comment = 'FRA="N° fournisseur"';
        QuantityCaptionLbl: label 'Quantity', comment = 'FRA="Quantité"';
        ReferenceCaptionLbl: label 'Reference', comment = 'FRA="Reference"';
        TEL___CaptionLbl: label 'TEL : ';
        Text000: label 'Purchaser', comment = 'FRA="Acheteur"';
        Text003: label 'COPY', comment = 'FRA="COPIE"';
        Text005: label 'Page %1', comment = 'FRA="Page %1"';
        Text010: label 'IMPERTIVE : US TO CONFIRM THIS ORDER BY RETURN OF FAX TO ', comment = 'FRA="IMPERATIF : NOUS CONFIRMER CETTE COMMANDE PAR RETOUR D''EMAIL A "';
        Text011: label 'DELIVERY ADDRESS', comment = 'FRA="ADRESSE DE LIVRAISON"';
        Text012: label 'No.', comment = 'FRA="N°"';
        Text066: label 'TEL : %1 FAX : %2 / email : %3', comment = 'FRA="%1 FAX : %2 / email : %3"';
        Text067: label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - n°TVA : %5"';
        Text068: label '%1';
        Text070: label 'Affair No. : ', comment = 'FRA="Affaire n° :"';
        TimeCaptionLbl: label 'Time', comment = 'FRA="Délai "';
        txtlbl12: label '%1 %2';

        TxtGAltFax: Text[20];
        TxtGAltPhone: Text[20];
        TxtGAltPostCode: Text[20];
        TxtGFax: Text[30];
        TxtGPhone: Text[30];
        CopyText: Text[30];
        PurchaserText: Text[30];
        ReferenceText: Text[35];
        TexG_User_Name: Text[50];
        TxtGAltCity: Text[30];
        TxtGLblProjet: Text[30];
        TxtGNoProjet: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TxtGAltAdress: Text[50];
        TxtGAltAdress2: Text[50];
        TxtGAltName: Text[50];
        TxtGDesignation: Text[100];
        TxtGTag: Text;
        VendAddr: array[8] of Text[50];
        TxtGAltEmail: Text[80];
        TxtGAltHomePage: Text[80];
        TxtGEmail: Text[80];
        TxtGHomePage: Text[90];

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

