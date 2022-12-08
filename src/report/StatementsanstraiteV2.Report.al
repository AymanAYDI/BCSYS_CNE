report 50042 "Statement sans traite V2"
{
    // //MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
    // //SOLDE        SL 14/09/06 NSC1.05         Visible=No sur le champ StartBalance dans CustLedgEntryHdr, Header(1)
    // //SOLDE        SL 18/09/06 NSC1.06         visible = No sur le champ CustBalance
    //                                            Ajout de la totalisation sur le montant ouvert
    //                                            Ajout de l'option 'Uniquement Facture ou Avoir'
    // //DESIGN       SD 27/09/06 NSC1.08         Modification emplacement des champs
    // 
    // TDL0109:JORE 04/12/2006 - Add management of existing line
    // 
    // //TRAITE FG 02/03/07 ajout dataitem Traite
    // 
    // //>> 04/01/12 SU-DADE cf APPEL TI078354
    // //   Design : add Customer.No on  Traite footer(2)
    // //<< 04/01/12 SU-DADE cf APPEL TI078354
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 26:06/2015: Ne pas imprimer informations 2nde société si vide
    DefaultLayout = RDLC;
    RDLCLayout = './StatementsanstraiteV2.rdlc';

    Caption = 'Statement';

    dataset
    {
        dataitem(DataItem6836; Table18)
        {
            DataItemTableView = SORTING(No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Print Statements", "Date Filter", "Currency Filter";
            column(Customer_No_; "No.")
            {
            }
            dataitem(DataItem5444; Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CompanyInfo_Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo__Alt_Picture_; CompanyInfo1."Alt Picture")
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
                column(STRSUBSTNO_Text066_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text066, CompanyInfo."Alt Phone No.", CompanyInfo."Alt Fax No.", CompanyInfo."Alt E-Mail"))
                {
                }
                column(DataItem1000000007; CompanyInfo."Alt Address" + ' ' + CompanyInfo."Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Alt Post Code", CompanyInfo."Alt City"))
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
                dataitem(CurrencyLoop; Table2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(CustLedgEntryHdr; Table2000000026)
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
                        dataitem(DtldCustLedgEntries; Table379)
                        {
                            DataItemTableView = SORTING(Customer No., Posting Date, Entry Type, Currency Code);
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
                    dataitem(CustLedgEntryFooter; Table2000000026)
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
                    dataitem(CustLedgEntry2; Table21)
                    {
                        DataItemLink = Customer No.=FIELD(No.);
                        DataItemLinkReference = Customer;
                        DataItemTableView = SORTING(Customer No., Open, Positive, Due Date);
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
                            CustLedgEntry: Record "21";
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

                            //SOLDE SL 18/09/06 NSC1.0
                            IF OnlySales THEN
                                SETFILTER("Document Type", '%1|%2', "Document Type"::Invoice, "Document Type"::"Credit Memo");
                            //Fin SOLDE SL 18/09/06 NSC1.0

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
                        //>>MIGRATION NAV 2013
                        IF NOT EntriesExists THEN
                            CurrReport.SKIP;
                        //<<MIGRATION NAV 2013
                    end;

                    trigger OnPreDataItem()
                    begin
                        Customer.COPYFILTER("Currency Filter", Currency2.Code);
                    end;
                }
                dataitem(AgingBandLoop; Table2000000026)
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

                    //>>TDL0109:JORE 04/12/2006
                    IF OnlySales THEN BEGIN
                        "Cust. Ledger Entry1".SETRANGE("Customer No.", Customer."No.");
                        "Cust. Ledger Entry1".SETRANGE("Posting Date", StartDate, EndDate);
                        "Cust. Ledger Entry1".SETFILTER("Document Type", '%1|%2',
                        "Cust. Ledger Entry1"."Document Type"::Invoice, "Cust. Ledger Entry1"."Document Type"::"Credit Memo");
                        IF NOT "Cust. Ledger Entry1".FIND('-') THEN
                            CurrReport.SKIP;
                    END;
                    //<<TDL0109:JORE 04/12/2006
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>TRAITE FG 02/03/07
                TraiteTotalRemainingAmount := 0;
                //<<TRAITE FG 02/03/07

                AgingBandBuf.DELETEALL;
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
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

                //CompanyInfo.GET;
                //FormatAddr.Company(CompanyAddr,CompanyInfo);

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
                        Caption = 'Show Overdue Entries';
                    }
                    field(IncludeAllCustomerswithLE; PrintAllHavingEntry)
                    {
                        Caption = 'Include All Customers with Ledger Entries';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            IF NOT PrintAllHavingEntry THEN
                                PrintAllHavingBal := TRUE;
                        end;
                    }
                    field(IncludeAllCustomerswithBalance; PrintAllHavingBal)
                    {
                        Caption = 'Include All Customers with a Balance';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            IF NOT PrintAllHavingBal THEN
                                PrintAllHavingEntry := TRUE;
                        end;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                    }
                    field(IncludeUnappliedEntries; PrintUnappliedEntries)
                    {
                        Caption = 'Include Unapplied Entries';
                    }
                    field(IncludeAgingBand; IncludeAgingBand)
                    {
                        Caption = 'Include Aging Band';
                    }
                    field(AgingBandPeriodLengt; PeriodLength)
                    {
                        Caption = 'Aging Band Period Length';
                    }
                    field(AgingBandby; DateChoice)
                    {
                        Caption = 'Aging Band by';
                        OptionCaption = 'Due Date,Posting Date';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(OnlySales; OnlySales)
                    {
                        Caption = 'Only Sales';
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
            //RequestOptionsPage.LogInteraction.ENABLED(LogInteraction);

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
        //>>MIGRATION NAV 2013
        LogInteractionEnable := TRUE;
        //MODIFICATION SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms

        CompanyInfo.GET;

        CompanyInfo1.GET;
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS("Alt Picture");
        //<<MIGRATION NAV 2013
    end;

    trigger OnPreReport()
    begin
        //InitRequestPageDataInternal;
    end;

    var
        Text000: Label 'Page %1';
        Text001: Label 'Entries %1';
        Text002: Label 'Overdue Entries %1';
        Text003: Label 'Statement ';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        Cust2: Record "18";
        Currency: Record "4";
        Currency2: Record "4" temporary;
        Language: Record "8";
        "Cust. Ledger Entry": Record "21";
        DtldCustLedgEntries2: Record "379";
        AgingBandBuf: Record "47" temporary;
        PrintAllHavingEntry: Boolean;
        PrintAllHavingBal: Boolean;
        PrintEntriesDue: Boolean;
        PrintUnappliedEntries: Boolean;
        PrintReversedEntries: Boolean;
        PrintLine: Boolean;
        LogInteraction: Boolean;
        EntriesExists: Boolean;
        StartDate: Date;
        EndDate: Date;
        "Due Date": Date;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        Description: Text[50];
        StartBalance: Decimal;
        CustBalance: Decimal;
        "Remaining Amount": Decimal;
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        CurrencyCode3: Code[10];
        Text005: Label 'Multicurrency Application';
        Text006: Label 'Payment Discount';
        Text007: Label 'Rounding';
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        DateChoice: Option "Due Date","Posting Date";
        AgingDate: array[5] of Date;
        Text008: Label 'You must specify the Aging Band Period Length.';
        AgingBandEndingDate: Date;
        Text010: Label 'You must specify Aging Band Ending Date.';
        Text011: Label 'Aged Summary by %1 (%2 by %3)';
        IncludeAgingBand: Boolean;
        Text012: Label 'Period Length is out of range.';
        AgingBandCurrencyCode: Code[10];
        Text013: Label 'Due Date,Posting Date';
        Text014: Label 'Application Writeoffs';
        Text100: Label 'From';
        Text101: Label 'to';
        Text102: Label 'Customer No.';
        Text103: Label 'Statement No.';
        Text104: Label 'of';
        Text105: Label 'Statement from';
        Text106: Label 'Print Date';
        "--NSC1.06--": Integer;
        TotalRemainingAmount: Decimal;
        OnlySales: Boolean;
        "Cust. Ledger Entry1": Record "21";
        Text066: Label 'TEL : %1 FAX : %2 / email : %3';
        Text067: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        "--Traite--": Integer;
        CstG1000000031: Label 'Amount';
        RecGCustomerBankAccount: Record "287";
        PostingDate: Date;
        AmountText: Text[30];
        CustAdr: array[8] of Text[50];
        CurrText_Gtxt: Text[30];
        IssueCity: Text[30];
        IssueDate: Date;
        DueDate: Date;
        RecGPaymentTerms: Record "3";
        TraiteTotalRemainingAmount: Decimal;
        Compta_DateCaptionLbl: Label 'Compta Date';
        Doc_TypeCaptionLbl: Label 'Doc Type';
        CustBalanceCaptionLbl: Label 'Balance';
        Payment_methodCaptionLbl: Label 'Payment method';
        CustBalance___AmountCaptionLbl: Label 'Continued';
        CustBalance___Amount_Control75CaptionLbl: Label 'Continued';
        Remaining_TotalCaptionLbl: Label 'Remaining Total';
        CustBalance_Control71CaptionLbl: Label 'Total';
        CustLedgEntry2__Remaining_Amount_CaptionLbl: Label 'Continued';
        CustLedgEntry2__Remaining_Amount__Control64CaptionLbl: Label 'Continued';
        CustLedgEntry2__Remaining_Amount__Control66CaptionLbl: Label 'Total';
        beforeCaptionLbl: Label '..before';
        ACCEPTANCE_or_ENDORSMENTCaptionLbl: Label 'ACCEPTANCE or ENDORSMENT';
        of_DRAWEECaptionLbl: Label 'of DRAWEE';
        Stamp_Allow_and_SignatureCaptionLbl: Label 'Stamp Allow and Signature';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        NAME_andCaptionLbl: Label 'NAME and';
        Value_in__CaptionLbl: Label 'Value in :';
        DRAWEE_R_I_B_CaptionLbl: Label 'DRAWEE R.I.B.';
        DOMICILIATIONCaptionLbl: Label 'DOMICILIATION';
        TOCaptionLbl: Label 'TO';
        ONCaptionLbl: Label 'ON';
        AMOUNT_FOR_CONTROLCaptionLbl: Label 'AMOUNT FOR CONTROL';
        CREATION_DATECaptionLbl: Label 'CREATION DATE';
        DUE_DATECaptionLbl: Label 'DUE DATE';
        DRAWEE_REF_CaptionLbl: Label 'DRAWEE REF.';
        below_for_order_of__CaptionLbl: Label 'below for order of :';
        please_pay_the_indicated_sumCaptionLbl: Label 'please pay the indicated sum';
        noted_as_NO_CHARGESCaptionLbl: Label 'noted as NO CHARGES';
        Against_this_BILLCaptionLbl: Label 'Against this BILL';
        BILLCaptionLbl: Label 'BILL';
        L_C_R__onlyCaptionLbl: Label 'L.C.R. only';
        Write_nothings_under_this_lineCaptionLbl: Label 'Write nothings under this line';
        etab_CaptionLbl: Label 'etab.';
        guichetCaptionLbl: Label 'guichet';
        n__compteCaptionLbl: Label 'n° compte';
        RIBCaptionLbl: Label 'RIB';
        TraiteTotalRemainingAmountCaptionLbl: Label 'Label1000000145';
        [InDataSet]
        LogInteractionEnable: Boolean;
        Total_CaptionLbl: Label 'Total';
        isInitialized: Boolean;
        [InDataSet]
        BooGAffiche: Boolean;
        CompanyInfo1: Record "79";

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
        I: Integer;
        GoOn: Boolean;
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

    [Scope('Internal')]
    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record "379"): Boolean
    var
        CustLedgEntry: Record "21";
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

    [Scope('Internal')]
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

    [Scope('Internal')]
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

