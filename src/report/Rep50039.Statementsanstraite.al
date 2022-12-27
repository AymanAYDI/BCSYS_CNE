report 50039 "BC6_Statement sans traite"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/Statementsanstraite.rdl';

    Caption = 'Statement', Comment = 'FRA="Relevé client"';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Print Statements", "Date Filter", "Currency Filter";
            column(CompanyInfo_Picture_; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Alt_Picture_; CompanyInfo."BC6_Alt Picture")
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(No_Cust; Customer."No.")
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(VATRegNo_CompanyInfo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo_CompanyInfo; CompanyInfo."Giro No.")
                {
                }
                column(BankName_CompanyInfo; CompanyInfo."Bank Name")
                {
                }
                column(BankAccNo_CompanyInfo; CompanyInfo."Bank Account No.")
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
                {
                }
                column(DataItem1100267007; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                {
                }
                column(STRSUBSTNO_Text066_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                {
                }
                column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                {
                }
                column(DataItem1100267011; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                {
                }
                column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
                {
                }
                column(No1_Cust; Customer."No.")
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(StartDate; FORMAT(StartDate))
                {
                }
                column(EndDate; FORMAT(EndDate))
                {
                }
                column(LastStatmntNo_Cust; FORMAT(Customer."Last Statement No."))
                {

                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(StatementCaption; StatementCaptionLbl)
                {
                }
                column(PhoneNo_CompanyInfoCaption; PhoneNo_CompanyInfoCaptionLbl)
                {
                }
                column(VATRegNo_CompanyInfoCaption; VATRegNo_CompanyInfoCaptionLbl)
                {
                }
                column(GiroNo_CompanyInfoCaption; GiroNo_CompanyInfoCaptionLbl)
                {
                }
                column(BankName_CompanyInfoCaption; BankName_CompanyInfoCaptionLbl)
                {
                }
                column(BankAccNo_CompanyInfoCaption; BankAccNo_CompanyInfoCaptionLbl)
                {
                }
                column(No1_CustCaption; No1_CustCaptionLbl)
                {
                }
                column(StartDateCaption; StartDateCaptionLbl)
                {
                }
                column(EndDateCaption; EndDateCaptionLbl)
                {
                }
                column(LastStatmntNo_CustCaption; LastStatmntNo_CustCaptionLbl)
                {
                }
                column(PostDate_DtldCustLedgEntriesCaption; PostDate_DtldCustLedgEntriesCaptionLbl)
                {
                }
                column(DocNo_DtldCustLedgEntriesCaption; DtldCustLedgEntries.FIELDCAPTION("Document No."))
                {
                }
                column(Desc_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION(Description))
                {
                }
                column(DueDate_CustLedgEntry2Caption; DueDate_CustLedgEntry2CaptionLbl)
                {
                }
                column(RemainAmtCustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Remaining Amount"))
                {
                }
                column(CustBalanceCaption; CustBalanceCaptionLbl)
                {
                }
                column(OriginalAmt_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Original Amount"))
                {
                }
                column(CompanyInfoHomepageCaption; CompanyInfoHomepageCaptionLbl)
                {
                }
                column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
                {
                }
                column(DocDateCaption; DocDateCaptionLbl)
                {
                }
                column(CstTxtModeReg_; CstTxtModeReg)
                {
                }
                column(Customer_PaymentMethodCode_; Customer."Payment Method Code")
                {
                }
                column(STRSUBSTNO_1_2_3_4Text105_Start_Date_Text101_EndDate; STRSUBSTNO('%1 %2 %3 %4', Text105, StartDate, Text101, EndDate))
                {
                }
                column(STRSUBSTNO_2_Text102_Customer_No; STRSUBSTNO('%1 %2', Text102, Customer."No."))
                {
                }
                column(STRSUBSTNO_1_2_Text103_Customer_LastStatementNo; STRSUBSTNO('%1 %2', Text103, Customer."Last Statement No."))
                {
                }
                column(STRSUBSTNO_1_2_Text106_FORMAT_TODAY_4_0; STRSUBSTNO('%1 %2', Text106, FORMAT(TODAY, 0, 4)))
                {
                }
                column(Text068_; Text068)
                {
                }
                column(DocTypeCaption_; Text069)
                {
                }
                dataitem(CurrencyLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(CustLedgEntryHdr; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Currency2Code_CustLedgEntryHdr; STRSUBSTNO(Text001, Currency2.Code))
                        {
                        }
                        column(StartBalance; StartBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdr; CustBalance)
                        {
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(DtldCustLedgEntryType; FORMAT(DtldCustLedgEntries."Entry Type", 0, 2))
                        {
                        }
                        column(EntriesExists; EntriesExists)
                        {
                        }
                        dataitem(DtldCustLedgEntries; 379)
                        {
                            DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                            column(PostDate_DtldCustLedgEntries; FORMAT("Posting Date"))
                            {
                            }
                            column(DocNo_DtldCustLedgEntries; "Document No.")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DueDate_DtldCustLedgEntries; FORMAT("Due Date"))
                            {
                            }
                            column(CurrCode_DtldCustLedgEntries; "Currency Code")
                            {
                            }
                            column(Amt_DtldCustLedgEntries; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(RemainAmt_DtldCustLedgEntries; "Remaining Amount")
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance; CustBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Currency2Code; Currency2.Code)
                            {
                            }
                            column(DocumentType_; "Document Type")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin

                                IF SkipReversedUnapplied(DtldCustLedgEntries) THEN
                                    CurrReport.SKIP();
                                "Remaining Amount" := 0;
                                PrintLine := TRUE;
                                CASE "Entry Type" OF
                                    "Entry Type"::"Initial Entry":
                                        BEGIN
                                            "Cust. Ledger Entry".GET("Cust. Ledger Entry No.");
                                            Description := "Cust. Ledger Entry".Description;
                                            "Due Date" := "Cust. Ledger Entry"."Due Date";
                                            "Cust. Ledger Entry".SETRANGE("Date Filter", 0D, EndDate);
                                            "Cust. Ledger Entry".CALCFIELDS("Remaining Amount");
                                            "Remaining Amount" := "Cust. Ledger Entry"."Remaining Amount";
                                            "Cust. Ledger Entry".SETRANGE("Date Filter");
                                        END;
                                    "Entry Type"::Application:
                                        BEGIN
                                            DtldCustLedgEntries2.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                                            DtldCustLedgEntries2.SETRANGE("Customer No.", "Customer No.");
                                            DtldCustLedgEntries2.SETRANGE("Posting Date", "Posting Date");
                                            DtldCustLedgEntries2.SETRANGE("Entry Type", "Entry Type"::Application);
                                            DtldCustLedgEntries2.SETRANGE("Transaction No.", "Transaction No.");
                                            DtldCustLedgEntries2.SETFILTER("Currency Code", '<>%1', "Currency Code");
                                            IF DtldCustLedgEntries2.FINDFIRST() THEN BEGIN
                                                Description := Text005;
                                                "Due Date" := 0D;
                                            END ELSE
                                                PrintLine := FALSE;
                                        END;
                                    "Entry Type"::"Payment Discount",
                                    "Entry Type"::"Payment Discount (VAT Excl.)",
                                    "Entry Type"::"Payment Discount (VAT Adjustment)",
                                    "Entry Type"::"Payment Discount Tolerance",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := Text006;
                                            "Due Date" := 0D;
                                        END;
                                    "Entry Type"::"Payment Tolerance",
                                    "Entry Type"::"Payment Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := Text014;
                                            "Due Date" := 0D;
                                        END;
                                    "Entry Type"::"Appln. Rounding",
                                    "Entry Type"::"Correction of Remaining Amount":
                                        BEGIN
                                            Description := Text007;
                                            "Due Date" := 0D;
                                        END;
                                END;

                                IF PrintLine THEN
                                    CustBalance := CustBalance + Amount;
                                //SOLDE SL 18/09/06 NSC1.06
                                TotalRemainingAmount := TotalRemainingAmount + "Remaining Amount";
                                //Fin SOLDE SL 18/09/06 NSC1.06
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Customer No.", Customer."No.");
                                SETRANGE("Posting Date", StartDate, EndDate);
                                SETRANGE("Currency Code", Currency2.Code);

                                //SOLDE SL 18/09/06 NSC1.0
                                IF OnlySales THEN
                                    SETFILTER("Document Type", '%1|%2', "Document Type"::Invoice, "Document Type"::"Credit Memo");
                                //Fin SOLDE SL 18/09/06 NSC1.0

                                IF Currency2.Code = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                END ELSE
                                    CurrencyCode3 := Currency2.Code;


                                //SOLDE SL 18/09/06 NSC1.06
                                TotalRemainingAmount := 0;
                                //Fin SOLDE SL 18/09/06 NSC1.06
                            end;
                        }
                    }
                    dataitem(CustLedgEntryFooter; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(CurrencyCode3_CustLedgEntryFooter; CurrencyCode3)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdrFooter; CustBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(EntriesExistsl_CustLedgEntryFooterCaption; EntriesExists)
                        {
                        }
                        column(TotalRemainingAmount_; TotalRemainingAmount)
                        {
                        }
                    }
                    dataitem(CustLedgEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemLinkReference = Customer;
                        DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");
                        column(OverDueEntries; STRSUBSTNO(Text002, Currency2.Code))
                        {
                        }
                        column(RemainAmt_CustLedgEntry2; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PostDate_CustLedgEntry2; FORMAT("Posting Date"))
                        {
                        }
                        column(DocNo_CustLedgEntry2; "Document No.")
                        {
                        }
                        column(Desc_CustLedgEntry2; Description)
                        {
                        }
                        column(DueDate_CustLedgEntry2; FORMAT("Due Date"))
                        {
                        }
                        column(OriginalAmt_CustLedgEntry2; "Original Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                        }
                        column(CurrCode_CustLedgEntry2; "Currency Code")
                        {
                        }
                        column(PrintEntriesDue; PrintEntriesDue)
                        {
                        }
                        column(Currency2Code_CustLedgEntry2; Currency2.Code)
                        {
                        }
                        column(CurrencyCode3_CustLedgEntry2; CurrencyCode3)
                        {
                        }
                        column(CustNo_CustLedgEntry2; "Customer No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            CustLedgEntry: Record "Cust. Ledger Entry";
                        begin
                            IF IncludeAgingBand THEN
                                IF ("Posting Date" > EndDate) AND ("Due Date" >= EndDate) THEN
                                    CurrReport.SKIP();
                            CustLedgEntry := CustLedgEntry2;
                            CustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                            CustLedgEntry.CALCFIELDS("Remaining Amount");
                            "Remaining Amount" := CustLedgEntry."Remaining Amount";
                            IF CustLedgEntry."Remaining Amount" = 0 THEN
                                CurrReport.SKIP();

                            IF IncludeAgingBand AND ("Posting Date" <= EndDate) THEN
                                UpdateBuffer(Currency2.Code, GetDate("Posting Date", "Due Date"), "Remaining Amount");

                            IF ("Due Date" >= EndDate) OR ("Remaining Amount" < 0) THEN
                                CurrReport.SKIP();
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS("Remaining Amount");
                            IF NOT IncludeAgingBand THEN BEGIN
                                SETRANGE("Due Date", 0D, EndDate - 1);
                                SETRANGE(Positive, TRUE);
                            END;
                            SETRANGE("Currency Code", Currency2.Code);

                            IF OnlySales THEN
                                SETFILTER("Document Type", '%1|%2', "Document Type"::Invoice, "Document Type"::"Credit Memo");

                            IF (NOT PrintEntriesDue) AND (NOT IncludeAgingBand) THEN
                                CurrReport.BREAK();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            Currency2.FIND('-')
                        ELSE
                            IF Currency2.NEXT() = 0 THEN
                                CurrReport.BREAK();

                        Cust2 := Customer;
                        Cust2.SETRANGE("Date Filter", 0D, StartDate - 1);
                        Cust2.SETRANGE("Currency Filter", Currency2.Code);
                        Cust2.CALCFIELDS("Net Change");
                        StartBalance := Cust2."Net Change";
                        CustBalance := Cust2."Net Change";
                        "Cust. Ledger Entry".SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                        "Cust. Ledger Entry".SETRANGE("Customer No.", Customer."No.");
                        "Cust. Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
                        "Cust. Ledger Entry".SETRANGE("Currency Code", Currency2.Code);
                        EntriesExists := "Cust. Ledger Entry".FINDFIRST();
                        IF NOT EntriesExists THEN
                            CurrReport.SKIP();
                    end;

                    trigger OnPreDataItem()
                    begin
                        Customer.COPYFILTER("Currency Filter", Currency2.Code);
                    end;
                }
                dataitem(AgingBandLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(AgingDate1; FORMAT(AgingDate[1] + 1))
                    {
                    }
                    column(AgingDate2; FORMAT(AgingDate[2]))
                    {
                    }
                    column(AgingDate21; FORMAT(AgingDate[2] + 1))
                    {
                    }
                    column(AgingDate3; FORMAT(AgingDate[3]))
                    {
                    }
                    column(AgingDate31; FORMAT(AgingDate[3] + 1))
                    {
                    }
                    column(AgingDate4; FORMAT(AgingDate[4]))
                    {
                    }
                    column(AgingBandEndingDate; STRSUBSTNO(Text011, AgingBandEndingDate, PeriodLength, SELECTSTR(DateChoice + 1, Text013)))
                    {
                    }
                    column(AgingDate41; FORMAT(AgingDate[4] + 1))
                    {
                    }
                    column(AgingDate5; FORMAT(AgingDate[5]))
                    {
                    }
                    column(AgingBandBufCol1Amt; AgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol2Amt; AgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol3Amt; AgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol4Amt; AgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol5Amt; AgingBandBuf."Column 5 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandCurrencyCode; AgingBandCurrencyCode)
                    {
                    }
                    column(beforeCaption; beforeCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT AgingBandBuf.FIND('-') THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF AgingBandBuf.NEXT() = 0 THEN
                                CurrReport.BREAK();
                        AgingBandCurrencyCode := AgingBandBuf."Currency Code";
                        IF AgingBandCurrencyCode = '' THEN
                            AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT IncludeAgingBand THEN
                            CurrReport.BREAK();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF OnlySales THEN BEGIN
                        "Cust. Ledger Entry1".SETRANGE("Customer No.", Customer."No.");
                        "Cust. Ledger Entry1".SETRANGE("Posting Date", StartDate, EndDate);
                        "Cust. Ledger Entry1".SETFILTER("Document Type", '%1|%2',
                        "Cust. Ledger Entry1"."Document Type"::Invoice, "Cust. Ledger Entry1"."Document Type"::"Credit Memo");
                        IF NOT "Cust. Ledger Entry1".FIND('-') THEN
                            CurrReport.SKIP();
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Language: Codeunit Language;
            begin
                AgingBandBuf.DELETEALL();
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");
                PrintLine := FALSE;
                Cust2 := Customer;
                COPYFILTER("Currency Filter", Currency2.Code);
                IF PrintAllHavingBal THEN BEGIN
                    IF Currency2.FIND('-') THEN
                        REPEAT
                            Cust2.SETRANGE("Date Filter", 0D, EndDate);
                            Cust2.SETRANGE("Currency Filter", Currency2.Code);
                            Cust2.CALCFIELDS("Net Change");
                            PrintLine := Cust2."Net Change" <> 0;
                        UNTIL (Currency2.NEXT() = 0) OR PrintLine;
                END;
                IF (NOT PrintLine) AND PrintAllHavingEntry THEN BEGIN
                    "Cust. Ledger Entry".RESET();
                    "Cust. Ledger Entry".SETCURRENTKEY("Customer No.", "Posting Date");
                    "Cust. Ledger Entry".SETRANGE("Customer No.", "No.");
                    "Cust. Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
                    COPYFILTER("Currency Filter", "Cust. Ledger Entry"."Currency Code");
                    PrintLine := "Cust. Ledger Entry".FINDFIRST();
                END;
                IF NOT PrintLine THEN
                    CurrReport.SKIP();

                FormatAddr.Customer(CustAddr, Customer);
                CurrReport.PAGENO := 1;

                IF NOT CurrReport.PREVIEW THEN BEGIN

                    LOCKTABLE();
                    FIND();
                    "Last Statement No." := "Last Statement No." + 1;
                    MODIFY();
                    COMMIT();

                END ELSE
                    "Last Statement No." := "Last Statement No." + 1;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          7, FORMAT("Last Statement No."), 0, 0, DATABASE::Customer, "No.", "Salesperson Code", '',
                          Text003 + FORMAT("Last Statement No."), '');
            end;

            trigger OnPreDataItem()
            begin
                StartDate := GETRANGEMIN("Date Filter");
                EndDate := GETRANGEMAX("Date Filter");
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates();
                Currency2.Code := '';
                Currency2.INSERT();
                COPYFILTER("Currency Filter", Currency.Code);
                IF Currency.FIND('-') THEN
                    REPEAT
                        Currency2 := Currency;
                        Currency2.INSERT();
                    UNTIL Currency.NEXT() = 0;
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
                    field(ShowOverdueEntries; PrintEntriesDue)
                    {
                        Caption = 'Show Overdue Entries', Comment = 'FRA="Afficher écritures échues"';
                    }
                    field(IncludeAllCustomerswithLE; PrintAllHavingEntry)
                    {
                        Caption = 'Include All Customers with Ledger Entries', Comment = 'FRA="Inclure tous les clients mouvementés."';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            IF NOT PrintAllHavingEntry THEN
                                PrintAllHavingBal := TRUE;
                        end;
                    }
                    field(IncludeAllCustomerswithBalance; PrintAllHavingBal)
                    {
                        Caption = 'Include All Customers with a Balance', Comment = 'FRA="Inclure tous les clients ayant un solde."';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            IF NOT PrintAllHavingBal THEN
                                PrintAllHavingEntry := TRUE;
                        end;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries', Comment = 'FRA="Inclure écritures contrepassées"';
                    }
                    field(IncludeUnappliedEntries; PrintUnappliedEntries)
                    {
                        Caption = 'Include Unapplied Entries', Comment = 'FRA="Inclure écritures non lettrées"';
                    }
                    field(IncludeAgingBand; IncludeAgingBand)
                    {
                        Caption = 'Include Aging Band', Comment = 'FRA="Inclure cumul date"';
                    }
                    field(AgingBandPeriodLengt; PeriodLength)
                    {
                        Caption = 'Aging Band Period Length', Comment = 'FRA="Base période cumul date"';
                    }
                    field(AgingBandby; DateChoice)
                    {
                        Caption = 'Aging Band by', Comment = 'FRA="Cumul par"';
                        OptionCaption = 'Due Date,Posting Date', Comment = 'FRA="Date d''échéance,Date comptabilisation"';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                    field(OnlySales; OnlySales)
                    {
                        Caption = 'Only Sales', Comment = 'FRA="Uniquement Facture et Avoir"';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            InitRequestPageDataInternal();
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();

        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        CompanyInfo.CALCFIELDS("BC6_Alt Picture");
    end;


    var
        AgingBandBuf: Record "Aging Band Buffer" temporary;
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        Currency2: Record Currency temporary;
        "Cust. Ledger Entry": Record "Cust. Ledger Entry";
        "Cust. Ledger Entry1": Record "Cust. Ledger Entry";
        Cust2: Record Customer;
        DtldCustLedgEntries2: Record "Detailed Cust. Ledg. Entry";
        GLSetup: Record "General Ledger Setup";
        Language: Record Language;
        SalesSetup: Record "Sales & Receivables Setup";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        EntriesExists: Boolean;
        IncludeAgingBand: Boolean;
        isInitialized: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        OnlySales: Boolean;
        PrintAllHavingBal: Boolean;
        PrintAllHavingEntry: Boolean;
        PrintEntriesDue: Boolean;
        PrintLine: Boolean;
        PrintReversedEntries: Boolean;
        PrintUnappliedEntries: Boolean;
        AgingBandCurrencyCode: Code[10];
        CurrencyCode3: Code[10];
        AgingBandEndingDate: Date;
        AgingDate: array[5] of Date;
        "Due Date": Date;
        EndDate: Date;
        StartDate: Date;
        CustBalance: Decimal;
        "Remaining Amount": Decimal;
        StartBalance: Decimal;
        TotalRemainingAmount: Decimal;
        "--NSC1.06--": Integer;
        BankAccNo_CompanyInfoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        BankName_CompanyInfoCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        beforeCaptionLbl: Label '..before', Comment = 'FRA="..avant"';
        CompanyInfoEmailCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        CompanyInfoHomepageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        CstTxtModeReg: Label 'Payment method', Comment = 'FRA="Mode règlement"';
        CustBalanceCaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        DocDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        DueDate_CustLedgEntry2CaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        EndDateCaptionLbl: Label 'Ending Date', Comment = 'FRA="Date fin"';
        GiroNo_CompanyInfoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        LastStatmntNo_CustCaptionLbl: Label 'Statement No.', Comment = 'FRA="N° relevé"';
        No1_CustCaptionLbl: Label 'Customer No.', Comment = 'FRA="N° client"';
        PhoneNo_CompanyInfoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        PostDate_DtldCustLedgEntriesCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabe"';
        StartDateCaptionLbl: Label 'Starting Date', Comment = 'FRA="Date début"';
        StatementCaptionLbl: Label 'Statement', Comment = 'FRA="Relevé"';
        Text001: Label 'Entries %1', Comment = 'FRA="Ecritures %1"';
        Text002: Label 'Overdue Entries %1', Comment = 'FRA="Ecritures échues %1"';
        Text003: Label 'Statement ', Comment = 'FRA="Relevé client "';
        Text005: Label 'Multicurrency Application', Comment = 'FRA="Application multidevise"';
        Text006: Label 'Payment Discount', Comment = 'FRA="Escompte"';
        Text007: Label 'Rounding', Comment = 'FRA="Arrondi"';
        Text008: Label 'You must specify the Aging Band Period Length.', Comment = 'FRA="Vous devez spécifier une base période pour le(s) cumul(s) date."';
        Text010: Label 'You must specify Aging Band Ending Date.', Comment = 'FRA="Vous devez spécifier une date de fin pour le cumul date."';
        Text011: Label 'Aged Summary by %1 (%2 by %3)', Comment = 'FRA="Cumul en date du %1 (%2 par %3)"';
        Text012: Label 'Period Length is out of range.', Comment = 'FRA="La période ne correspond pas à l''intervalle défini."';
        Text013: Label 'Due Date,Posting Date', Comment = 'FRA="Date d''échéance,Date comptabilisation"';
        Text014: Label 'Application Writeoffs', Comment = 'FRA="Ecarts de lettrage"';
        Text036: Label '-%1', Comment = '-%1';
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text068: Label 'Remaining Total', Comment = 'FRA="Total à payer"';
        Text069: Label 'Doc Type', Comment = 'FRA="Type doc"';
        Text100: Label 'From', Comment = 'FRA="Du "';
        Text101: Label 'to', Comment = 'FRA="au"';
        Text102: Label 'Customer No.', Comment = 'FRA="N° Client"';
        Text103: Label 'Statement No.', Comment = 'FRA="N° relevé"';
        Text104: Label 'of', Comment = 'FRA="du"';
        Text105: Label 'Statement from', Comment = 'FRA="Relevé Client du"';
        Text106: Label 'Print Date', Comment = 'FRA="Date d''édition "';
        Total_CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        VATRegNo_CompanyInfoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        DateChoice: Option "Due Date","Posting Date";
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        Description: Text[50];

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
        IF DateChoice = DateChoice::"Posting Date" THEN
            EXIT(PostingDate);
        EXIT(DueDate);
    end;

    local procedure CalcAgingBandDates()
    begin
        IF NOT IncludeAgingBand THEN
            EXIT;
        IF AgingBandEndingDate = 0D THEN
            ERROR(Text010);
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(Text008);
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        IF AgingDate[2] <= AgingDate[1] THEN
            ERROR(Text012);
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal)
    var
        GoOn: Boolean;
        I: Integer;
    begin
        AgingBandBuf.INIT();
        AgingBandBuf."Currency Code" := CurrencyCode;
        IF NOT AgingBandBuf.FIND() THEN
            AgingBandBuf.INSERT();
        I := 1;
        GoOn := TRUE;
        WHILE (I <= 5) AND GoOn DO BEGIN
            IF Date <= AgingDate[I] THEN
                IF I = 1 THEN BEGIN
                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 2 THEN BEGIN
                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 3 THEN BEGIN
                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 4 THEN BEGIN
                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 5 THEN BEGIN
                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := FALSE;
                END;
            I := I + 1;
        END;
        AgingBandBuf.MODIFY();
    end;


    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record "Detailed Cust. Ledg. Entry"): Boolean
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        IF PrintReversedEntries AND PrintUnappliedEntries THEN
            EXIT(FALSE);
        IF NOT PrintUnappliedEntries THEN
            IF DtldCustLedgEntries.Unapplied THEN
                EXIT(TRUE);
        IF NOT PrintReversedEntries THEN BEGIN
            CustLedgEntry.GET(DtldCustLedgEntries."Cust. Ledger Entry No.");
            IF CustLedgEntry.Reversed THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;


    procedure InitializeRequest(NewPrintEntriesDue: Boolean; NewPrintAllHavingEntry: Boolean; NewPrintAllHavingBal: Boolean; NewPrintReversedEntries: Boolean; NewPrintUnappliedEntries: Boolean; NewIncludeAgingBand: Boolean; NewPeriodLength: Text[30]; NewDateChoice: Option; NewLogInteraction: Boolean)
    begin
        InitRequestPageDataInternal();

        PrintEntriesDue := NewPrintEntriesDue;
        PrintAllHavingEntry := NewPrintAllHavingEntry;
        PrintAllHavingBal := NewPrintAllHavingBal;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        IncludeAgingBand := NewIncludeAgingBand;
        EVALUATE(PeriodLength, NewPeriodLength);
        DateChoice := NewDateChoice;
        LogInteraction := NewLogInteraction;
    end;


    procedure InitRequestPageDataInternal()
    begin
        IF isInitialized THEN
            EXIT;

        isInitialized := TRUE;

        IF (NOT PrintAllHavingEntry) AND (NOT PrintAllHavingBal) THEN
            PrintAllHavingBal := TRUE;

        LogInteraction := SegManagement.FindInteractTmplCode(7) <> '';
        LogInteractionEnable := LogInteraction;

        IF FORMAT(PeriodLength) = '' THEN
            EVALUATE(PeriodLength, '<1M+CM>');
    end;
}

