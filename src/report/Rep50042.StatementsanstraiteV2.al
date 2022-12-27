report 50042 "BC6_Statement sans traite V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/StatementsanstraiteV2.rdl';

    Caption = 'Statement', Comment = 'FRA="Relevé client CNE"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Print Statements", "Date Filter", "Currency Filter";
            column(Customer_No_; "No.")
            {
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CompanyInfo_Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo__Alt_Picture_; CompanyInfo1."BC6_Alt Picture")
                {
                }
                column(STRSUBSTNO_Text000_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text000, FORMAT(CurrReport.PAGENO)))
                {
                }
                column(STRSUBSTNO_1_2_3_4_Text105_StartDate_Text101_EndDate_; STRSUBSTNO('%1 %2 %3 %4', Text105, StartDate, Text101, EndDate))
                {
                }
                column(STRSUBSTNO___1__2__Text103_Customer__Last_Statement_No___; STRSUBSTNO('%1 %2', Text103, Customer."Last Statement No."))
                {
                }
                column(STRSUBSTNO___1__2__Text102_Customer__No___; STRSUBSTNO('%1 %2', Text102, Customer."No."))
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
                column(STRSUBSTNO___1__2__Text106_FORMAT_TODAY_0_4__; STRSUBSTNO('%1 %2', Text106, FORMAT(TODAY, 0, '<Day,2>/<Month,2>/<Year4>')))
                {
                }
                column(Customer__Payment_Method_Code_; Customer."Payment Method Code")
                {
                }
                column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                {
                }
                column(DataItem1000000007; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                {
                }
                column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
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
                column(DataItem1000000012; STRSUBSTNO(Text067, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                {
                }
                column(Compta_DateCaption; Compta_DateCaptionLbl)
                {
                }
                column(DtldCustLedgEntries__Document_No__Caption; DtldCustLedgEntries.FIELDCAPTION("Document No."))
                {
                }
                column(Doc_TypeCaption; Doc_TypeCaptionLbl)
                {
                }
                column(CustLedgEntry2__Due_Date_Caption; CustLedgEntry2.FIELDCAPTION("Due Date"))
                {
                }
                column(CustLedgEntry2__Remaining_Amount__Control61Caption; CustLedgEntry2.FIELDCAPTION("Remaining Amount"))
                {
                }
                column(CustBalanceCaption; CustBalanceCaptionLbl)
                {
                }
                column(CustLedgEntry2__Original_Amount_Caption; CustLedgEntry2.FIELDCAPTION("Original Amount"))
                {
                }
                column(Payment_methodCaption; Payment_methodCaptionLbl)
                {
                }
                column(Integer_Number; Number)
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
                        column(CustLedgEntryHdr_Number; Number)
                        {
                        }
                        dataitem(DtldCustLedgEntries; "Detailed Cust. Ledg. Entry")
                        {
                            DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Currency Code");
                            column(CustBalance___Amount; CustBalance - Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(DtldCustLedgEntries__Posting_Date_; "Posting Date")
                            {
                            }
                            column(DtldCustLedgEntries__Document_No__; "Document No.")
                            {
                            }
                            column(DtldCustLedgEntries_DtldCustLedgEntries__Document_Type_; DtldCustLedgEntries."Document Type")
                            {
                            }
                            column(Due_Date_; "Due Date")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DtldCustLedgEntries__Currency_Code_; "Currency Code")
                            {
                            }
                            column(DtldCustLedgEntries_Amount; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Remaining_Amount_; "Remaining Amount")
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance; CustBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance___Amount_Control75; CustBalance - Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(TotalRemainingAmount; TotalRemainingAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance___AmountCaption; CustBalance___AmountCaptionLbl)
                            {
                            }
                            column(CustBalance___Amount_Control75Caption; CustBalance___Amount_Control75CaptionLbl)
                            {
                            }
                            column(Remaining_TotalCaption; Remaining_TotalCaptionLbl)
                            {
                            }
                            column(DtldCustLedgEntries_Entry_No_; "Entry No.")
                            {
                            }
                            column(Currency2Code; Currency2.Code)
                            {
                            }
                            column(BooGAffiche; BooGAffiche)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin

                                IF SkipReversedUnapplied(DtldCustLedgEntries) THEN
                                    CurrReport.SKIP;
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
                                            DtldCustLedgEntries2.SETFILTER("Currency Code", '<>%1', DtldCustLedgEntries."Currency Code");
                                            IF DtldCustLedgEntries2.FIND('-') THEN BEGIN
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

                                //>>TRAITE FG 02/03/07
                                TraiteTotalRemainingAmount := TotalRemainingAmount;
                                //<<TRAITE FG 02/03/07


                                //>>MIGRATION NAV 2013
                                BooGAffiche := (PrintLine OR ("Entry Type" <> "Entry Type"::Application));
                                //<<MIGRATION NAV 2013
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Customer No.", Customer."No.");
                                SETRANGE("Posting Date", StartDate, EndDate);
                                SETRANGE("Currency Code", Currency2.Code);


                                IF OnlySales THEN
                                    SETFILTER("Document Type", '%1|%2', "Document Type"::Invoice, "Document Type"::"Credit Memo");

                                IF Currency2.Code = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                END ELSE
                                    CurrencyCode3 := Currency2.Code;

                                TotalRemainingAmount := 0;
                            end;
                        }
                    }
                    dataitem(CustLedgEntryFooter; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(CustBalance_Control71; CustBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CustBalance_Control71Caption; CustBalance_Control71CaptionLbl)
                        {
                        }
                        column(CustLedgEntryFooter_Number; Number)
                        {
                        }
                        column(EntriesExistsl_CustLedgEntryFooterCaption; EntriesExists)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                    }
                    dataitem(CustLedgEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemLinkReference = Customer;
                        DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");
                        column(STRSUBSTNO_Text002_Currency2_Code_; STRSUBSTNO(Text002, Currency2.Code))
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount_; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CustLedgEntry2__Posting_Date_; "Posting Date")
                        {
                        }
                        column(CustLedgEntry2__Document_No__; "Document No.")
                        {
                        }
                        column(CustLedgEntry2_Description; Description)
                        {
                        }
                        column(CustLedgEntry2__Due_Date_; "Due Date")
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount__Control61; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CustLedgEntry2__Original_Amount_; "Original Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                        }
                        column(CustLedgEntry2__Currency_Code_; "Currency Code")
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount__Control64; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CustLedgEntry2__Remaining_Amount__Control66; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3_Control73; CurrencyCode3)
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount_Caption; CustLedgEntry2__Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount__Control64Caption; CustLedgEntry2__Remaining_Amount__Control64CaptionLbl)
                        {
                        }
                        column(CustLedgEntry2__Remaining_Amount__Control66Caption; CustLedgEntry2__Remaining_Amount__Control66CaptionLbl)
                        {
                        }
                        column(CustLedgEntry2_Entry_No_; "Entry No.")
                        {
                        }
                        column(CustLedgEntry2_Customer_No_; "Customer No.")
                        {
                        }
                        column(Currency2Code_CustLedgEntry2; Currency2.Code)
                        {
                        }
                        column(PrintEntriesDue; PrintEntriesDue)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            CustLedgEntry: Record 21;
                        begin
                            IF IncludeAgingBand THEN
                                IF ("Posting Date" > EndDate) AND ("Due Date" >= EndDate) THEN
                                    CurrReport.SKIP;
                            CustLedgEntry := CustLedgEntry2;
                            CustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                            CustLedgEntry.CALCFIELDS("Remaining Amount");
                            "Remaining Amount" := CustLedgEntry."Remaining Amount";
                            IF CustLedgEntry."Remaining Amount" = 0 THEN
                                CurrReport.SKIP;

                            IF IncludeAgingBand AND ("Posting Date" <= EndDate) THEN
                                UpdateBuffer(Currency2.Code, GetDate("Posting Date", "Due Date"), "Remaining Amount");
                            IF ("Due Date" >= EndDate) OR ("Remaining Amount" < 0) THEN
                                CurrReport.SKIP;
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
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            Currency2.FIND('-')
                        ELSE
                            IF Currency2.NEXT = 0 THEN
                                CurrReport.BREAK;

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
                        EntriesExists := "Cust. Ledger Entry".FIND('-');
                        IF NOT EntriesExists THEN
                            CurrReport.SKIP;
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
                    column(AgingDate_1_1; AgingDate[1] + 1)
                    {
                    }
                    column(AgingDate_2_; AgingDate[2])
                    {
                    }
                    column(AgingDate_2_1; AgingDate[2] + 1)
                    {
                    }
                    column(AgingDate_3_; AgingDate[3])
                    {
                    }
                    column(AgingDate_3_1; AgingDate[3] + 1)
                    {
                    }
                    column(AgingDate_4_; AgingDate[4])
                    {
                    }
                    column(AgingBandEndingDate; STRSUBSTNO(Text011, AgingBandEndingDate, PeriodLength, SELECTSTR(DateChoice + 1, Text013)))
                    {
                    }
                    column(AgingDate_4_1; AgingDate[4] + 1)
                    {
                    }
                    column(AgingDate_5_; AgingDate[5])
                    {
                    }
                    column(AgingBandBuf__Column_1_Amt__; AgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_2_Amt__; AgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_3_Amt__; AgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_4_Amt__; AgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_5_Amt__; AgingBandBuf."Column 5 Amt.")
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
                    column(AgingBandLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT AgingBandBuf.FIND('-') THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF AgingBandBuf.NEXT = 0 THEN
                                CurrReport.BREAK;
                        AgingBandCurrencyCode := AgingBandBuf."Currency Code";
                        IF AgingBandCurrencyCode = '' THEN
                            AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT IncludeAgingBand THEN
                            CurrReport.BREAK;
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
                            CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TraiteTotalRemainingAmount := 0;

                AgingBandBuf.DELETEALL;
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
                        UNTIL (Currency2.NEXT = 0) OR PrintLine;
                END;
                IF (NOT PrintLine) AND PrintAllHavingEntry THEN BEGIN
                    "Cust. Ledger Entry".RESET;
                    "Cust. Ledger Entry".SETCURRENTKEY("Customer No.", "Posting Date");
                    "Cust. Ledger Entry".SETRANGE("Customer No.", Customer."No.");
                    "Cust. Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
                    Customer.COPYFILTER("Currency Filter", "Cust. Ledger Entry"."Currency Code");
                    PrintLine := "Cust. Ledger Entry".FIND('-');
                END;
                IF NOT PrintLine THEN
                    CurrReport.SKIP;


                FormatAddr.Customer(CustAddr, Customer);
                CurrReport.PAGENO := 1;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    Customer.LOCKTABLE;
                    Customer.FIND;
                    Customer."Last Statement No." := Customer."Last Statement No." + 1;
                    Customer.MODIFY;
                    COMMIT;
                END ELSE
                    Customer."Last Statement No." := Customer."Last Statement No." + 1;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          7, FORMAT(Customer."Last Statement No."), 0, 0, DATABASE::Customer, "No.", "Salesperson Code", '',
                          Text003 + FORMAT(Customer."Last Statement No."), '');
            end;

            trigger OnPreDataItem()
            begin
                StartDate := GETRANGEMIN("Date Filter");
                EndDate := GETRANGEMAX("Date Filter");
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;

                Currency2.Code := '';
                Currency2.INSERT;
                COPYFILTER("Currency Filter", Currency.Code);
                IF Currency.FIND('-') THEN
                    REPEAT
                        Currency2 := Currency;
                        Currency2.INSERT;
                    UNTIL Currency.NEXT = 0;
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
                        OptionCaption = 'Due Date,Posting Date';
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

            IF (NOT PrintAllHavingEntry) AND (NOT PrintAllHavingBal) THEN
                PrintAllHavingBal := TRUE;

            LogInteraction := SegManagement.FindInteractTmplCode(7) <> '';

            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M+CM>');
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        LogInteractionEnable := TRUE;

        CompanyInfo.GET;

        CompanyInfo1.GET;
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS("BC6_Alt Picture");
    end;

    var
        RecGPaymentTerms: Record 3;
        Currency: Record 4;
        Currency2: Record 4 temporary;
        Language: Record 8;
        Cust2: Record 18;
        "Cust. Ledger Entry": Record 21;
        "Cust. Ledger Entry1": Record 21;
        AgingBandBuf: Record 47 temporary;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        GLSetup: Record 98;
        RecGCustomerBankAccount: Record 287;
        DtldCustLedgEntries2: Record 379;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        [InDataSet]
        BooGAffiche: Boolean;
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
        DueDate: Date;
        "Due Date": Date;
        EndDate: Date;
        IssueDate: Date;
        PostingDate: Date;
        StartDate: Date;
        CustBalance: Decimal;
        "Remaining Amount": Decimal;
        StartBalance: Decimal;
        TotalRemainingAmount: Decimal;
        TraiteTotalRemainingAmount: Decimal;
        "--NSC1.06--": Integer;
        "--Traite--": Integer;
        ACCEPTANCE_or_ENDORSMENTCaptionLbl: Label 'ACCEPTANCE or ENDORSMENT', Comment = 'FRA="ACCEPTATION ou AVAL"';
        ADDRESSCaptionLbl: Label 'ADDRESS', Comment = 'FRA="ADRESSE"';
        Against_this_BILLCaptionLbl: Label 'Against this BILL', Comment = 'FRA="Contre cette LETTRE DE CHANGE"';
        AMOUNT_FOR_CONTROLCaptionLbl: Label 'AMOUNT FOR CONTROL', Comment = 'FRA="MONTANT POUR CONTROLE"';
        beforeCaptionLbl: Label '..before', Comment = 'FRA="..avant"';
        below_for_order_of__CaptionLbl: Label 'below for order of :', Comment = 'FRA="ci-dessous à l''ordre de :"';
        BILLCaptionLbl: Label 'BILL', Comment = 'FRA="L.C.R."';
        Compta_DateCaptionLbl: Label 'Compta Date', Comment = 'FRA="Date comptable"';
        CREATION_DATECaptionLbl: Label 'CREATION DATE', Comment = 'FRA="DATE DE CREATION"';
        CstG1000000031: Label 'Amount', Comment = 'FRA="Montant"';
        CustBalance___Amount_Control75CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        CustBalance___AmountCaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        CustBalance_Control71CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        CustBalanceCaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        CustLedgEntry2__Remaining_Amount__Control64CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        CustLedgEntry2__Remaining_Amount__Control66CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        CustLedgEntry2__Remaining_Amount_CaptionLbl: Label 'Continued', Comment = 'FRA="Report"';
        Doc_TypeCaptionLbl: Label 'Doc Type', Comment = 'FRA="Type doc"';
        DOMICILIATIONCaptionLbl: Label 'DOMICILIATION', Comment = 'FRA="DOMICILIATION"';
        DRAWEE_R_I_B_CaptionLbl: Label 'DRAWEE R.I.B.', Comment = 'FRA="R.I.B. DU TIRE"';
        DRAWEE_REF_CaptionLbl: Label 'DRAWEE REF.', Comment = 'FRA="REF. TIRE"';
        DUE_DATECaptionLbl: Label 'DUE DATE', Comment = 'FRA="ECHEANCE"';
        etab_CaptionLbl: Label 'etab.', Comment = 'FRA="etab."';
        guichetCaptionLbl: Label 'guichet', Comment = 'FRA="guichet"';
        L_C_R__onlyCaptionLbl: Label 'L.C.R. only', Comment = 'FRA="L.C.R. seulement"';
        n__compteCaptionLbl: Label 'n° compte';
        NAME_andCaptionLbl: Label 'NAME and', Comment = 'FRA="NOM et"';
        noted_as_NO_CHARGESCaptionLbl: Label 'noted as NO CHARGES', Comment = 'FRA="stipulée SANS FRAIS"';
        of_DRAWEECaptionLbl: Label 'of DRAWEE', Comment = 'FRA="du TIRE"';
        ONCaptionLbl: Label 'ON', Comment = 'FRA="LE"';
        Payment_methodCaptionLbl: Label 'Payment method', Comment = 'FRA="Mode règlement"';
        please_pay_the_indicated_sumCaptionLbl: Label 'please pay the indicated sum', Comment = 'FRA="veuillez payer la somme indiquée"';
        Remaining_TotalCaptionLbl: Label 'Remaining Total', Comment = 'FRA="Total à payer"';
        RIBCaptionLbl: Label 'RIB', Comment = 'FRA="RIB"';
        Stamp_Allow_and_SignatureCaptionLbl: Label 'Stamp Allow and Signature', Comment = 'FRA="Droit de timbre et signature"';
        Text000: Label 'Page %1', Comment = 'FRA="Page %1"';
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
        Text066: Label 'TEL : %1 FAX : %2 / email : %3', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text100: Label 'From', Comment = 'FRA="Du "';
        Text101: Label 'to', Comment = 'FRA="au"';
        Text102: Label 'Customer No.', Comment = 'FRA="N° Client"';
        Text103: Label 'Statement No.', Comment = 'FRA="N° relevé"';
        Text104: Label 'of', Comment = 'FRA="du"';
        Text105: Label 'Statement from', Comment = 'FRA="Relevé Client du"';
        Text106: Label 'Print Date', Comment = 'FRA="Date d''édition "';
        TOCaptionLbl: Label 'TO', Comment = 'FRA="A"';
        Total_CaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        TraiteTotalRemainingAmountCaptionLbl: Label 'Label1000000145';
        Value_in__CaptionLbl: Label 'Value in :', Comment = 'FRA="Valeur en :"';
        Write_nothings_under_this_lineCaptionLbl: Label 'Write nothings under this line', Comment = 'FRA="ne rien inscrire au dessous de cette ligne"';
        DateChoice: Option "Due Date","Posting Date";
        AmountText: Text[30];
        CurrText_Gtxt: Text[30];
        IssueCity: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        CustAdr: array[8] of Text[50];
        Description: Text[50];

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
        IF DateChoice = DateChoice::"Posting Date" THEN
            EXIT(PostingDate)
        ELSE
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
        AgingBandBuf.INIT;
        AgingBandBuf."Currency Code" := CurrencyCode;
        IF NOT AgingBandBuf.FIND THEN
            AgingBandBuf.INSERT;
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
        AgingBandBuf.MODIFY;
    end;


    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record 379): Boolean
    var
        CustLedgEntry: Record 21;
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
        InitRequestPageDataInternal;

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

