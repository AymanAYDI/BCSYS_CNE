report 50078 "Purchase - Receipt CNE"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // ------------------------------------------------------------------------
    // 
    // //>>MODIF HL
    // TI255335 DO.GEPO 15/12/2014 : modify Purch Rcpt Line - OnAfterGetRecord
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseReceiptCNE.rdlc';

    Caption = 'Purchase - Receipt';

    dataset
    {
        dataitem(DataItem2822; Table120)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Receipt';
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
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
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
                    column(DocDate_PurchRcptHeader; FORMAT("Purch. Rcpt. Header"."Document Date", 0, 4))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
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
                    column(Purch__Rcpt__Header___Order_No__Caption; "Purch. Rcpt. Header".FIELDCAPTION("Order No."))
                    {
                    }
                    column(PostedInvtPutawayHeader__No__Caption; PostedInvtPutawayHeader__No__CaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___Order_No__; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(FORMAT__Purch__Rcpt__Header___Posting_Date__0_4_; FORMAT("Purch. Rcpt. Header"."Posting Date", 0, 4))
                    {
                    }
                    column(PostedInvtPutawayHeaderOk; PostedInvtPutawayHeaderOk)
                    {
                    }
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
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
                    dataitem(DataItem3042; Table121)
                    {
                        DataItemLink = Document No.=FIELD(No.);
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING (Document No., Line No.);
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
                        dataitem("PostedInvtPut-awayLine"; Table7341)
                        {
                            DataItemTableView = SORTING (Source Type, Source Subtype, Source No., Source Line No., Source Subline No.);
                            column(PostedInvtPut_awayLine__Source_No__2_; "Source No. 2")
                            {
                            }
                            column(PostedInvtPut_awayLine__Bin_Code_; "Bin Code")
                            {
                            }
                            column(PostedInvtPut_awayLine__Qty___Base__; "Qty. (Base)")
                            {
                            }
                            column(PostedInvtPut_awayLine__Source_Line_No__2_; "Source Line No. 2")
                            {
                            }
                            column(PostedInvtPut_awayLine__Source_Bin_Code_; "Source Bin Code")
                            {
                            }
                            column(DefaultBinCode; DefaultBinCode)
                            {
                            }
                            column(PostedInvtPut_awayLine__Warehouse_Comment_; "Warehouse Comment")
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
                                SETRANGE("Source No.", "Purch. Rcpt. Line"."Order No.");
                                SETRANGE("Source Line No.", "Purch. Rcpt. Line"."Order Line No.");
                                SETRANGE("Source Subline No.", 0);
                                SETRANGE("Source Document", "Source Document"::"Purchase Order");
                                SETRANGE("No.", PostedInvtPutawayHeader."No.");
                                // MESSAGE('%1',GETFILTERS);
                            end;
                        }
                        dataitem(DimensionLoop2; Table2000000026)
                        {
                            DataItemTableView = SORTING (Number)
                                                WHERE (Number = FILTER (1 ..));
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

                            //>>TI255335
                            IF "Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::" " THEN
                                CurrReport.SKIP;
                            //<<TI255335

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");

                            //>>MIGRATION NAV 2013
                            EAN13Bar := '';
                            EAN13Txt := '';
                            EAN13BarTxt := '';
                            CASE Type OF
                                Type::Item:
                                    BEGIN
                                        IF (Quantity <> 0) THEN BEGIN
                                            IF NOT CurrReport.PREVIEW THEN BEGIN
                                                CLEAR(DistInt);
                                                DistInt.CreateItemEAN13Code("No.", FALSE);
                                            END;
                                            CLEAR(DistInt);
                                            EAN13Bar := COPYSTR(DistInt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
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
                            //<<MIGRATION NAV 2013
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            //>>MIGRATION NAV 2013
                            AttachedLineNo := 0;
                            //<<MIGRATION NAV 2013
                        end;
                    }
                    dataitem(Total; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                        column(BuyfromVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(BuyfromVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Rcpt. Header"."Buy-from Vendor No." = "Purch. Rcpt. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total2; Table2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                        column(PaytoVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Pay-to Vendor No.")
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
                        column(PaytoVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Pay-to Vendor No."))
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
                        RcptCountPrinted.RUN("Purch. Rcpt. Header");
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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

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
                FormatAddr.PurchRcptShipTo(ShipToAddr, "Purch. Rcpt. Header");

                FormatAddr.PurchRcptPayTo(VendAddr, "Purch. Rcpt. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');

                //>>MIGRATION NAV 2013

                PostedInvtPutawayHeader.RESET;
                PostedInvtPutawayHeader.SETRANGE("Source No.", "Purch. Rcpt. Header"."No.");
                PostedInvtPutawayHeaderOk := PostedInvtPutawayHeader.FINDFIRST;

                //>> 19/03/2012 PROD PT16
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
                //<<MIGRATION NAV 2013
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
        Text000: Label 'Purchaser';
        Text001: Label 'COPY';
        Text002: Label 'Purchase - Receipt %1';
        Text003: Label 'Page %1';
        CompanyInfo: Record "79";
        SalesPurchPerson: Record "13";
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        Language: Record "8";
        RespCenter: Record "5714";
        RcptCountPrinted: Codeunit "318";
        SegManagement: Codeunit "5051";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        FormatAddr: Codeunit "365";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        HomePageCaptionLbl: Label 'Home Page';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        AccNoCaptionLbl: Label 'Account No.';
        ShipmentNoCaptionLbl: Label 'Shipment No.';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaytoAddrCaptionLbl: Label 'Pay-to Address';
        DocDateCaptionLbl: Label 'Document Date';
        PageCaptionLbl: Label 'Page';
        DescCaptionLbl: Label 'Description';
        QtyCaptionLbl: Label 'Quantity';
        UOMCaptionLbl: Label 'Unit Of Measure';
        PaytoVenNoCaptionLbl: Label 'Pay-to Vendor No.';
        EmailCaptionLbl: Label 'E-Mail';
        "- MIGNAV2013 -": Integer;
        PostedInvtPutawayHeader: Record "7340";
        PostedInvtPutawayHeaderOk: Boolean;
        Location: Record "14";
        DefaultBinCode: Code[20];
        WMSManagement: Codeunit "7302";
        DistInt: Codeunit "5702";
        ConvertAutoIDEAN13: Codeunit "50099";
        EAN13Txt: Text[13];
        EAN13Bar: Text[13];
        EAN13BarTxt: Text[120];
        AttachedLineNo: Integer;
        DefaultReceiptBinCode: Code[20];
        ConvertBarCode: Codeunit "50099";
        DefaultReceiptBinBarTxt: Text[120];
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        Purch__Rcpt__Header___No__CaptionLbl: Label 'Shipment No.';
        PostedInvtPutawayHeader__No__CaptionLbl: Label 'Invt. Put-Away No.';
        EAN13_CodeCaptionLbl: Label 'EAN13 Code';
        "Code_empl__par_défautCaptionLbl": Label 'Code empl. par défaut';
        "Code_empl__récept_CaptionLbl": Label 'Code empl. récept.';
        Code_empl__exp_CaptionLbl: Label 'Code empl. exp.';
        N__ligneCaptionLbl: Label 'N° ligne';
        N__commande_venteCaptionLbl: Label 'N° commande vente';
        CommentaireCaptionLbl: Label 'Commentaire';
        Pay_to_AddressCaptionLbl: Label 'Pay-to Address';

    [Scope('Internal')]
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
    end;

    [Scope('Internal')]
    procedure "--- MIGNAV2013 ---"()
    begin
    end;

    [Scope('Internal')]
    procedure GetBarCode(piBinCode: Code[20]): Text[120]
    begin
        CLEAR(ConvertBarCode);
        EXIT(ConvertBarCode.EncodeBarcode39(piBinCode));
    end;
}

