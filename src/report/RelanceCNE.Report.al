report 50037 "Relance  CNE"
{
    // //MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
    // //TEXTE_DEBUT  SL 14/09/06 NSC1.05         Ajout du Header Issued Reminder Line pour imprimer le texte début avant les colonnes
    // //TEXTE_DEBUT  SL 18/09/06 NSC1.06         Ajout du dataitem IssuedReminderLineTexte pour imprimer le texte début avant les colonnes
    // //DESIGN       SD 27/09/06 NSC1.08        Modification emplacement des champs
    // //DESIGN       SD 12/10/06 NSC1.12         Maquettage
    // 
    // //>> 03/01/2012 SU-DADE cf appel TI078267
    // //   IssuedReminderLineTexte - OnPreDataItem()
    // //<< 03/01/2012 SU-DADE cf appel TI078267
    // 
    // //>>CNE5.00
    // TDL.85/CSC 02/12/2013 : NAV 2013 designing
    //                         Add C/AL in IssuedReminderLineTexte - OnAfterGetRecord()
    //                                     IssuedReminderLine2 - OnAfterGetRecord()
    DefaultLayout = RDLC;
    RDLCLayout = './RelanceCNE.rdlc';

    Caption = 'Reminder CNE';

    dataset
    {
        dataitem(DataItem5612; Table297)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';
            column(Issued_Reminder_Header_No_; "No.")
            {
            }
            column(STRSUBSTNO___1__le__2__CompanyInfo_City_FORMAT__Issued_Reminder_Header___Document_Date___; STRSUBSTNO('%1, le %2', CompanyInfo.City, FORMAT("Issued Reminder Header"."Document Date")))
            {
            }
            column(STRSUBSTNO__Relance_n_____1___Issued_Reminder_Header___No___; STRSUBSTNO('Relance n° : %1', "Issued Reminder Header"."No."))
            {
            }
            column(STRSUBSTNO__N__client____1___Issued_Reminder_Header___Customer_No___; STRSUBSTNO('N° client : %1', "Issued Reminder Header"."Customer No."))
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
            column(STRSUBSTNO___1_le__2___Issued_Reminder_Header__FIELDCAPTION__Due_Date____Issued_Reminder_Header___Due_Date__; STRSUBSTNO('%1 le %2', "Issued Reminder Header".FIELDCAPTION("Due Date"), "Issued Reminder Header"."Due Date"))
            {
            }
            column(Issued_Reminder_Header___Reminder_Level_; "Issued Reminder Header"."Reminder Level")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(SalesPersonText; SalesPersonText)
            {
            }
            column(CompanyInfo__Alt_Picture_; CompanyInfo."Alt Picture")
            {
            }
            column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Alt Phone No.", CompanyInfo."Alt Fax No.", CompanyInfo."Alt E-Mail"))
            {
            }
            column(DataItem1100267026; CompanyInfo."Alt Address" + ' ' + CompanyInfo."Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Alt Post Code", CompanyInfo."Alt City"))
            {
            }
            column(CompanyInfo__Alt_Name_; CompanyInfo."Alt Name")
            {
            }
            column(STRSUBSTNO_Text066_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
            {
            }
            column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DataItem1100267021; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
            {
            }
            column(Lettre_de_RappelCaption; Lettre_de_RappelCaptionLbl)
            {
            }
            column(Reminder_levelCaption; Reminder_levelCaptionLbl)
            {
            }
            column(HdrDimsCaption; TxtGHdrDimsCaption)
            {
            }
            column(Document_DateCaption; Document_DateCaptionLbl)
            {
            }
            column(Issued_Reminder_Line__Document_No__Caption; "Issued Reminder Line".FIELDCAPTION("Document No."))
            {
            }
            column(Issued_Reminder_Line__Due_Date_Caption; Issued_Reminder_Line__Due_Date_CaptionLbl)
            {
            }
            column(Issued_Reminder_Line__Remaining_Amount__Control40Caption; "Issued Reminder Line".FIELDCAPTION("Remaining Amount"))
            {
            }
            column(Issued_Reminder_Line__Original_Amount_Caption; "Issued Reminder Line".FIELDCAPTION("Original Amount"))
            {
            }
            column(Type_documentCaption; Type_documentCaptionLbl)
            {
            }
            column(Issued_Reminder_Line__Remaining_Amount_Caption; Issued_Reminder_Line__Remaining_Amount_CaptionLbl)
            {
            }
            column(Issued_Reminder_Line__Remaining_Amount__Control42Caption; Issued_Reminder_Line__Remaining_Amount__Control42CaptionLbl)
            {
            }
            column(ReminderInterestAmountCaption; ReminderInterestAmountCaptionLbl)
            {
            }
            column(Issued_Reminder_Line__VAT_Amount_Caption; "Issued Reminder Line".FIELDCAPTION("VAT Amount"))
            {
            }
            column(VATAmountLine__VAT_Amount__Control71Caption; VATAmountLine__VAT_Amount__Control71CaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base__Control72Caption; VATAmountLine__VAT_Base__Control72CaptionLbl)
            {
            }
            column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
            {
            }
            column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base__Control80Caption; VATAmountLine__VAT_Base__Control80CaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base__Control83Caption; VATAmountLine__VAT_Base__Control83CaptionLbl)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(DimensionLoop1; Table2000000026)
            {
                DataItemLinkReference = "Issued Reminder Header";
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(Integer_Number; Number)
                {
                }
                column(DimText; DimText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT DimSetEntry.FINDSET THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF NOT Continue THEN
                            CurrReport.BREAK;

                    CLEAR(DimText);
                    Continue := FALSE;
                    REPEAT
                        OldDimText := DimText;
                        IF DimText = '' THEN
                            DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                        ELSE
                            DimText :=
                              STRSUBSTNO(
                                '%1; %2 - %3', DimText,
                                DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                        IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                            DimText := OldDimText;
                            Continue := TRUE;
                            EXIT;
                        END;
                    UNTIL DimSetEntry.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT ShowInternalInfo THEN
                        CurrReport.BREAK;
                end;
            }
            dataitem(IssuedReminderLineTexte; Table298)
            {
                DataItemLink = Reminder No.=FIELD(No.);
                DataItemLinkReference = "Issued Reminder Header";
                DataItemTableView = SORTING(Reminder No., Line No.);
                column(IssuedReminderLineTexte_Description; Description)
                {
                }
                column(IssuedReminderLineTexte_Reminder_No_; "Reminder No.")
                {
                }
                column(IssuedReminderLineTexte_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //>>MIGRATION NAV 2013
                    BooGIRTxtBody3 := (Type = Type::" ");
                    BooGIRLineBody1 := ("Line No." > StartLineNo) AND (Type = Type::"Customer Ledger Entry");

                    BooGIRLineBody2 := ("Line No." > StartLineNo) AND
                      ((Type <> Type::"Customer Ledger Entry") AND (ShowInternalInfo));

                    BooGIRLineBody2 := ("Line No." > StartLineNo) AND
                      ((Type <> Type::"Customer Ledger Entry") AND (NOT ShowInternalInfo));
                    //<<MIGRATION NAV 2013

                    //>>TDL.84
                    IF Description = '' THEN
                        Description := ' ';
                    //<<TDL.84
                end;

                trigger OnPreDataItem()
                begin

                    IF FIND('-') THEN BEGIN
                        StartLineNo := 0;
                        REPEAT
                            Continue := Type = Type::" ";
                            IF Continue AND (Description <> '') THEN
                                StartLineNo := "Line No.";
                        UNTIL (NEXT = 0) OR NOT Continue;
                    END;
                    IF FIND('+') THEN BEGIN
                        EndLineNo := "Line No." + 1;
                        REPEAT
                            Continue := Type = Type::" ";
                            IF Continue AND (Description <> '') THEN
                                EndLineNo := "Line No.";
                        UNTIL (NEXT(-1) = 0) OR NOT Continue;
                    END;
                    //>> 03/01/2012 SU-DADE cf appel TI078267
                    //   OLD CODE
                    //SETFILTER("Line No.",'<%1',StartLineNo);
                    //   NEW CODE
                    SETFILTER("Line No.", '<=%1', StartLineNo);
                    //<< 03/01/2012 SU-DADE cf appel TI078267
                end;
            }
            dataitem(DataItem8784; Table298)
            {
                DataItemLink = Reminder No.=FIELD(No.);
                DataItemLinkReference = "Issued Reminder Header";
                DataItemTableView = SORTING(Reminder No., Line No.);
                column(Issued_Reminder_Line__Remaining_Amount_; "Remaining Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(STRSUBSTNO__du__1__FORMAT__Document_Date___; STRSUBSTNO('du %1', FORMAT("Document Date")))
                {
                }
                column(Issued_Reminder_Line__Document_No__; "Document No.")
                {
                }
                column(Issued_Reminder_Line__Due_Date_; FORMAT("Due Date"))
                {
                }
                column(Issued_Reminder_Line__Remaining_Amount__Control40; "Remaining Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Issued_Reminder_Line__Original_Amount_; "Original Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(STRSUBSTNO___1_n____Document_Type__; STRSUBSTNO('%1 n°', "Document Type"))
                {
                }
                column(Issued_Reminder_Line_Description; Description)
                {
                }
                column(Issued_Reminder_Line__Remaining_Amount__Control38; "Remaining Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Issued_Reminder_Line__No__; "No.")
                {
                }
                column(Issued_Reminder_Line__Remaining_Amount__Control95; "Remaining Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Issued_Reminder_Line_Description_Control96; Description)
                {
                }
                column(Issued_Reminder_Line__Remaining_Amount__Control42; "Remaining Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(ReminderInterestAmount; ReminderInterestAmount)
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Remaining_Amount____ReminderInterestAmount; "Remaining Amount" + ReminderInterestAmount)
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Remaining_Amount____ReminderInterestAmount____VAT_Amount_; "Remaining Amount" + ReminderInterestAmount + "VAT Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Issued_Reminder_Line__VAT_Amount_; "VAT Amount")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(Issued_Reminder_Line_Reminder_No_; "Reminder No.")
                {
                }
                column(Issued_Reminder_Line_Line_No_; "Line No.")
                {
                }
                column(BooGIRLineBody1_; BooGIRLineBody1)
                {
                }
                column(BooGIRLineBody2_; BooGIRLineBody2)
                {
                }
                column(BooGIRLineBody3_; BooGIRLineBody3)
                {
                }
                column(BooGIRLineFouter1_; BooGIRLineFouter1)
                {
                }
                column(BooGIRLineFouter2_; BooGIRLineFouter2)
                {
                }
                column(BooGIRLineFouter3_; BooGIRLineFouter3)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATAmountLine.INIT;
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."VAT Amount" := "VAT Amount";
                    VATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                    VATAmountLine.InsertLine;

                    CASE Type OF
                        Type::"G/L Account":
                            "Remaining Amount" := Amount;
                        Type::"Customer Ledger Entry":
                            ReminderInterestAmount := Amount;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DELETEALL;
                    SETFILTER("Line No.", '<%1', EndLineNo);
                    CurrReport.CREATETOTALS("Remaining Amount", "VAT Amount", ReminderInterestAmount);
                    //>>MIGRATION NAV 2013
                    BooGIRLineFouter1 := ReminderInterestAmount <> 0;
                    BooGIRLineFouter2 := TRUE;
                    BooGIRLineFouter3 := "VAT Amount" <> 0;
                    //<<MIGRATION NAV 2013
                end;
            }
            dataitem(IssuedReminderLine2; Table298)
            {
                DataItemLink = Reminder No.=FIELD(No.);
                DataItemLinkReference = "Issued Reminder Header";
                DataItemTableView = SORTING(Reminder No., Line No.);
                column(IssuedReminderLine2_Description; Description)
                {
                }
                column(IssuedReminderLine2_Reminder_No_; "Reminder No.")
                {
                }
                column(IssuedReminderLine2_Line_No_; "Line No.")
                {
                }
                column(IssuedReminderLine_Type; Type)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>TDL.84
                    IF Description = '' THEN
                        Description := ' ';
                    //<<TDL.84
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Line No.", '>=%1', EndLineNo);
                end;
            }
            dataitem(VATCounter; Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(VATAmtLineAmtIncludVAT; VATAmountLine."Amount Including VAT")
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(VALVATAmount; VALVATAmount)
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(VALVATBase; VALVATBase)
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(VALVATBaseVALVATAmt; VALVATBase + VALVATAmount)
                {
                    AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                    AutoFormatType = 1;
                }
                column(VATAmtLineVAT; VATAmountLine."VAT %")
                {
                }
                column(AmountIncVATCaption; AmountIncVATCaptionLbl)
                {
                }
                column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                {
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATAmountLine.GetLine(Number);
                    VALVATBase += VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100);
                    VALVATAmount += VATAmountLine."Amount Including VAT" - VALVATBase;
                end;

                trigger OnPreDataItem()
                begin
                    IF VATAmountLine.GetTotalVATAmount = 0 THEN
                        CurrReport.BREAK;

                    SETRANGE(Number, 1, VATAmountLine.COUNT);

                    VALVATBase := 0;
                    VALVATAmount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddrCodeunit.IssuedReminder(CustAddr, "Issued Reminder Header");
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text000, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text000, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text001, "Currency Code");
                END;
                CurrReport.PAGENO := 1;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF LogInteraction THEN
                        SegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted;
                END;
                // PRM ajout des coordonnees du commercial
                IF Cust.GET("Customer No.") THEN
                    IF Cust."Salesperson Code" = '' THEN BEGIN
                        CLEAR(SalesPurchPerson);
                        SalesPersonText := '';
                    END ELSE BEGIN
                        SalesPurchPerson.GET(Cust."Salesperson Code");
                        //  SalesPersonText := Text000;
                        SalesPersonText := '';
                        SalesPersonText := Text100 + ' ' + SalesPurchPerson.Name;
                        IF SalesPurchPerson."Phone No." <> '' THEN
                            SalesPersonText := SalesPersonText + ' ' + '   ' + '' + Text101 + ' ' + SalesPurchPerson."Phone No.";
                        IF SalesPurchPerson."E-Mail" <> '' THEN
                            SalesPersonText := SalesPersonText + ' ' + '   ' + ' ' + SalesPurchPerson.FIELDCAPTION("E-Mail") + ' ' + SalesPurchPerson."E-Mail";
                    END;
                // PRM ajout des coordonnees du commercial
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                FormatAddrCodeunit.Company(CompanyAddr, CompanyInfo);
                // PRM
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;

                //>>MIGRATION NAV 2013
                //MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
                CompanyInfo.CALCFIELDS(Picture, "Alt Picture");
                //FIN MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
                //<<MIGRATION NAV 2013
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
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteractionEnable := LogInteraction;
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
        Text000: Label 'Total %1';
        Text001: Label 'Total %1 Incl. VAT';
        Text002: Label 'Page %1';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        VATAmountLine: Record "290" temporary;
        Language: Record "8";
        FormatAddrCodeunit: Codeunit "365";
        SegManagement: Codeunit "5051";
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        ReminderInterestAmount: Decimal;
        StartLineNo: Integer;
        EndLineNo: Integer;
        Continue: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        Text030: Label '%1 - %2 %3';
        Text031: Label 'Tel. :  %1 - Fax :  %2';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        Text033: Label 'Fax :  %1';
        Pays: Text[30];
        Country: Record "9";
        SalesPersonText: Text[200];
        SalesPurchPerson: Record "13";
        Cust: Record "18";
        Text100: Label 'Salesperson : ';
        Text101: Label 'Phone :';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        Lettre_de_RappelCaptionLbl: Label 'Lettre de Rappel';
        Reminder_levelCaptionLbl: Label 'Reminder level';
        Document_DateCaptionLbl: Label 'Document Date';
        Issued_Reminder_Line__Due_Date_CaptionLbl: Label 'Due Date';
        Type_documentCaptionLbl: Label 'Type document';
        Issued_Reminder_Line__Remaining_Amount_CaptionLbl: Label 'Continued';
        Issued_Reminder_Line__Remaining_Amount__Control42CaptionLbl: Label 'Continued';
        ReminderInterestAmountCaptionLbl: Label 'Interest Amount';
        VATAmountLine__Amount_Including_VAT__Control70CaptionLbl: Label 'Amount Including VAT';
        VATAmountLine__VAT_Amount__Control71CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control72CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control80CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control83CaptionLbl: Label 'Total';
        [InDataSet]
        LogInteractionEnable: Boolean;
        TxtGHdrDimsCaption: Label 'Header Dimensions';
        BooGIRTxtBody3: Boolean;
        BooGIRLineFouter1: Boolean;
        BooGIRLineFouter2: Boolean;
        BooGIRLineFouter3: Boolean;
        BooGIRLineBody1: Boolean;
        BooGIRLineBody2: Boolean;
        BooGIRLineBody3: Boolean;
        DimSetEntry: Record "480";
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATPercentCaptionLbl: Label 'VAT %';
        AmountIncVATCaptionLbl: Label 'Amount Including VAT';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption1Lbl: Label 'Continued';
        TotalCaptionLbl: Label 'Total';
}

