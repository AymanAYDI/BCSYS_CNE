report 50078 "BC6_Purchase - Receipt CNE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PurchaseReceiptCNE.rdl';

    Caption = 'Purchase - Receipt', comment = 'FRA="Achats : Bon de réception"';

    dataset
    {
        dataitem(PurchRcptHeader; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Receipt', comment = 'FRA="Posted Purchase Receipt"';
            column(No_PurchRcptHeader; "No.")
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DescCaption; DescCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(PaytoVenNoCaption; PaytoVenNoCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(PurchRcptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(CurrentReportPageNo; STRSUBSTNO(Text003, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchRcptHeader; FORMAT(PurchRcptHeader."Document Date", 0, 4))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; PurchRcptHeader."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchRcptHeader; PurchRcptHeader."Your Reference")
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(AccNoCaption; AccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(PostedInvtPutawayHeader__No__; PostedInvtPutawayHeader."No.")
                    {
                    }
                    column(DefaultReceiptBinBarTxt; DefaultReceiptBinBarTxt)
                    {
                    }
                    column(DefaultReceiptBinCode; DefaultReceiptBinCode)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(Purch__Rcpt__Header___No__Caption; Purch__Rcpt__Header___No__CaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___Order_No__Caption; PurchRcptHeader.FIELDCAPTION("Order No."))
                    {
                    }
                    column(PostedInvtPutawayHeader__No__Caption; PostedInvtPutawayHeader__No__CaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___Order_No__; PurchRcptHeader."Order No.")
                    {
                    }
                    column(FORMAT__Purch__Rcpt__Header___Posting_Date__0_4_; FORMAT(PurchRcptHeader."Posting Date", 0, 4))
                    {
                    }
                    column(PostedInvtPutawayHeaderOk; PostedInvtPutawayHeaderOk)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = PurchRcptHeader;
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(PurchRcptLine; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = PurchRcptHeader;
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(Type_PurchRcptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(Desc_PurchRcptLine; Description)
                        {
                            IncludeCaption = false;
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                            IncludeCaption = false;
                        }
                        column(UOM_PurchRcptLine; "Unit of Measure")
                        {
                            IncludeCaption = false;
                        }
                        column(No_PurchRcptLine; "No.")
                        {
                        }
                        column(DocNo_PurchRcptLine; "Document No.")
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
                        {
                            IncludeCaption = false;
                        }
                        column(No_PurchRcptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(EAN13_CodeCaption; EAN13_CodeCaptionLbl)
                        {
                        }
                        column(EAN13Txt; EAN13Txt)
                        {
                        }
                        column(EAN13BarTxt; EAN13BarTxt)
                        {
                        }
                        column("Code_empl__par_défautCaption"; Code_empl__par_défautCaptionLbl)
                        {
                        }
                        column("Code_empl__récept_Caption"; Code_empl__récept_CaptionLbl)
                        {
                        }
                        column(Code_empl__exp_Caption; Code_empl__exp_CaptionLbl)
                        {
                        }
                        column(N__ligneCaption; N__ligneCaptionLbl)
                        {
                        }
                        column(N__commande_venteCaption; N__commande_venteCaptionLbl)
                        {
                        }
                        column(CommentaireCaption; CommentaireCaptionLbl)
                        {
                        }
                        dataitem("PostedInvtPut-awayLine"; "Posted Invt. Put-away Line")
                        {
                            DataItemTableView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
                            column(PostedInvtPut_awayLine__Source_No__2_; "BC6_Source No. 2")
                            {
                            }
                            column(PostedInvtPut_awayLine__Bin_Code_; "Bin Code")
                            {
                            }
                            column(PostedInvtPut_awayLine__Qty___Base__; "Qty. (Base)")
                            {
                            }
                            column(PostedInvtPut_awayLine__Source_Line_No__2_; "BC6_Source Line No. 2")
                            {
                            }
                            column(PostedInvtPut_awayLine__Source_Bin_Code_; "BC6_Source Bin Code")
                            {
                            }
                            column(DefaultBinCode; DefaultBinCode)
                            {
                            }
                            column(PostedInvtPut_awayLine__Warehouse_Comment_; "BC6_Warehouse Comment")
                            {
                            }
                            column(PostedInvtPut_awayLine_No_; "No.")
                            {
                            }
                            column(PostedInvtPut_awayLine_Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                DefaultBinCode := '';
                                CLEAR(WMSManagement);
                                IF ("Location Code" <> '') AND ("Item No." <> '') THEN BEGIN
                                    IF Location.GET("Location Code") THEN
                                        IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                                            WMSManagement.GetDefaultBin("Item No.", "Variant Code", "Location Code", DefaultBinCode);
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT PostedInvtPutawayHeaderOk THEN
                                    CurrReport.BREAK;

                                SETRANGE("Source Type", 39);
                                SETRANGE("Source Subtype", 1);
                                SETRANGE("Source No.", PurchRcptLine."Order No.");
                                SETRANGE("Source Line No.", PurchRcptLine."Order Line No.");
                                SETRANGE("Source Subline No.", 0);
                                SETRANGE("Source Document", "Source Document"::"Purchase Order");
                                SETRANGE("No.", PostedInvtPutawayHeader."No.");
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (NOT ShowCorrectionLines) AND Correction THEN
                                CurrReport.SKIP;

                            IF PurchRcptLine.Type = PurchRcptLine.Type::" " THEN
                                CurrReport.SKIP;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");

                            EAN13Bar := '';
                            EAN13Txt := '';
                            EAN13BarTxt := '';
                            CASE Type OF
                                Type::Item:
                                    BEGIN
                                        IF (Quantity <> 0) THEN BEGIN
                                            IF NOT CurrReport.PREVIEW THEN BEGIN
                                                CLEAR(DistInt);
                                                FctMngt.CreateItemEAN13Code("No.", FALSE);
                                            END;
                                            CLEAR(DistInt);
                                            EAN13Bar := COPYSTR(FctMngt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
                                            IF EAN13Bar <> '' THEN BEGIN
                                                CLEAR(ConvertAutoIDEAN13);
                                                EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                                            END;
                                            AttachedLineNo := "Line No.";
                                        END
                                        ELSE
                                            CurrReport.SKIP;
                                    END;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            AttachedLineNo := 0;
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(BuyfromVenNo_PurchRcptHeader; PurchRcptHeader."Buy-from Vendor No.")
                        {
                        }
                        column(BuyfromVenNo_PurchRcptHeaderCaption; PurchRcptHeader.FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF PurchRcptHeader."Buy-from Vendor No." = PurchRcptHeader."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaytoVenNo_PurchRcptHeader; PurchRcptHeader."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(PaytoAddrCaption; PaytoAddrCaptionLbl)
                        {
                        }
                        column(PaytoVenNo_PurchRcptHeaderCaption; PurchRcptHeader.FIELDCAPTION("Pay-to Vendor No."))
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
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
                        RcptCountPrinted.RUN(PurchRcptHeader);
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;

                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //TODO CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language2.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

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
                FormatAddr.PurchRcptShipTo(ShipToAddr, PurchRcptHeader);

                FormatAddr.PurchRcptPayTo(VendAddr, PurchRcptHeader);

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');


                PostedInvtPutawayHeader.RESET;
                PostedInvtPutawayHeader.SETRANGE("Source No.", PurchRcptHeader."No.");
                PostedInvtPutawayHeaderOk := PostedInvtPutawayHeader.FINDFIRST;

                CLEAR(DefaultReceiptBinCode);
                CLEAR(DefaultReceiptBinBarTxt);
                CLEAR(Location);
                IF ("Location Code" <> '') THEN BEGIN
                    IF Location.GET("Location Code") THEN
                        IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                            DefaultReceiptBinCode := Location."Receipt Bin Code";
                END;
                IF DefaultReceiptBinCode <> '' THEN
                    DefaultReceiptBinBarTxt := GetBarCode(DefaultReceiptBinCode);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
                    field(ShowCorrectionLines; ShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines';
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
            LogInteraction := SegManagement.FindInteractTmplCode(15) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        Location: Record Location;
        PostedInvtPutawayHeader: Record "Posted Invt. Put-away Header";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ConvertAutoIDEAN13: Codeunit "BC6_Barcode Mngt AutoID";
        ConvertBarCode: Codeunit "BC6_Barcode Mngt AutoID";
        FctMngt: Codeunit "BC6_Functions Mgt";
        DistInt: Codeunit "Dist. Integration";
        FormatAddr: Codeunit "Format Address";
        Language2: Codeunit Language;
        RcptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        SegManagement: Codeunit SegManagement;
        WMSManagement: Codeunit "WMS Management";
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        PostedInvtPutawayHeaderOk: Boolean;
        ShowCorrectionLines: Boolean;
        ShowInternalInfo: Boolean;
        DefaultBinCode: Code[20];
        DefaultReceiptBinCode: Code[20];
        AttachedLineNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AccNoCaptionLbl: Label 'Account No.', comment = 'FRA="No compte"';
        BankNameCaptionLbl: Label 'Bank', comment = 'FRA="Banque"';
        Code_empl__exp_CaptionLbl: Label 'Code empl. exp.';
        "Code_empl__par_défautCaptionLbl": Label 'Code empl. par défaut';
        "Code_empl__récept_CaptionLbl": Label 'Code empl. récept.';
        CommentaireCaptionLbl: Label 'Commentaire';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.', comment = 'FRA="télécopie"';
        DescCaptionLbl: Label 'Description', comment = 'FRA="Désignation"';
        DocDateCaptionLbl: Label 'Document Date', comment = 'FRA="Date document"';
        EAN13_CodeCaptionLbl: Label 'EAN13 Code', comment = 'FRA="Code EAN13"';
        EmailCaptionLbl: Label 'E-Mail';
        GiroNoCaptionLbl: Label 'Giro No.', comment = 'FRA="No CCP"';
        HeaderDimCaptionLbl: Label 'Header Dimensions', comment = 'FRA="Analytique en-téte"';
        HomePageCaptionLbl: Label 'Home Page', comment = 'FRA="Page d''accueil"';
        LineDimCaptionLbl: Label 'Line Dimensions', comment = 'FRA="Analytique ligne"';
        N__commande_venteCaptionLbl: Label 'N° commande vente';
        N__ligneCaptionLbl: Label 'N° ligne';
        PageCaptionLbl: Label 'Page';
        Pay_to_AddressCaptionLbl: Label 'Pay-to Address', comment = 'FRA="Addresse"';
        PaytoAddrCaptionLbl: Label 'Pay-to Address', comment = 'FRA="Adresse"';
        PaytoVenNoCaptionLbl: Label 'Pay-to Vendor No.', comment = 'FRA="No fournisseur … payer"';
        PhoneNoCaptionLbl: Label 'Phone No.', comment = 'FRA="n° téléphone"';
        PostedInvtPutawayHeader__No__CaptionLbl: Label 'Invt. Put-Away No.', comment = 'FRA="No rangement stock"';
        Purch__Rcpt__Header___No__CaptionLbl: Label 'Shipment No.', comment = 'FRA="No livraison"';
        QtyCaptionLbl: Label 'Quantity', comment = 'FRA="Quantité"';
        ShipmentNoCaptionLbl: Label 'Shipment No.', comment = 'FRA="No expédition"';
        Text000: Label 'Purchaser', comment = 'FRA="Acheteur"';
        Text001: Label 'COPY', comment = 'FRA="COPIE"';
        Text002: Label 'Purchase - Receipt %1', comment = 'FRA="Achats : Réception %1"';
        Text003: Label 'Page %1', comment = 'FRA="Page %1"';
        UOMCaptionLbl: Label 'Unit Of Measure', comment = 'FRA="Unité"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', comment = 'FRA="No identif. intracomm."';
        EAN13Bar: Text[13];
        EAN13Txt: Text[13];
        CopyText: Text[30];
        PurchaserText: Text[30];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        DefaultReceiptBinBarTxt: Text[120];
        DimText: Text[120];
        EAN13BarTxt: Text[120];


    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
    end;


    procedure GetBarCode(piBinCode: Code[20]): Text[120]
    begin
        CLEAR(ConvertBarCode);
        EXIT(ConvertBarCode.EncodeBarcode39(piBinCode));
    end;
}

