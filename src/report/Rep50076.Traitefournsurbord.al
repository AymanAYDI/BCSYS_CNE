report 50076 "BC6_Traite fourn. sur bord"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/Traitefournisseursurbord.rdl';

    Caption = 'Bill WORMS', comment = 'FRA=""';

    dataset
    {
        dataitem(PaymentLine; "Payment Line")
        {
            DataItemTableView = SORTING("Due Date", "Document No.")
                                WHERE("Account Type" = FILTER(Vendor));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Payment lines', comment = 'FRA=""';
            column(CustAdr_1_; CustAdr[1])
            {
            }
            column(CustAdr_3_; CustAdr[3])
            {
            }
            column(CustAdr_4_; CustAdr[4])
            {
            }
            column(CustAdr_5_; CustAdr[5])
            {
            }
            column(CustAdr_6_; CustAdr[6])
            {
            }
            column(CustAdr_7_; CustAdr[7])
            {
            }
            column(Du____STRSUBSTNO___1__FORMAT_PaymtHeader__Document_Date__0_4__; 'Du ' + STRSUBSTNO(txtlbl1, FORMAT(PaymtHeader."Document Date", 0, 4)))
            {
            }
            column(STRSUBSTNO__Page__1__FORMAT_CurrReport_PAGENO__; STRSUBSTNO('Page %1', FORMAT(CurrReport.PAGENO())))
            {
            }
            column(CustAdr_2_; CustAdr[2])
            {
            }
            column(Payment_Line__Account_No__; "Account No.")
            {
            }
            column(STRSUBSTNO___1__FORMAT_TODAY_12_7__; STRSUBSTNO(txtlbl1, FORMAT(TODAY, 12, 7)))
            {
            }
            column(Text121; Text121)
            {
            }
            column(CodGVendorPurchaserCode; CodGVendorPurchaserCode)
            {
            }
            column(RecG_SalespersonPurchaser_Name; RecG_SalespersonPurchaser.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
            {
            }
            column(STRSUBSTNO_Text030_CompanyInfo_Address_CompanyInfo__Address_2__CompanyInfo__Post_Code__CompanyInfo_City_; STRSUBSTNO(Text030, CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo."Post Code", CompanyInfo.City))
            {
            }
            column(STRSUBSTNO_Text031_CompanyInfo__Phone_No_____CompanyInfo__Fax_No___; STRSUBSTNO(Text031, CompanyInfo."Phone No.", CompanyInfo."Fax No."))
            {
            }
            column(DataItem1000000064; STRSUBSTNO(Text032, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."Registration No.", CompanyInfo."APE Code"))
            {
            }
            column(TexGPaymentMethodDescription; TexGPaymentMethodDescription)
            {
            }
            column(CodGPaymentMethodCode; CodGPaymentMethodCode)
            {
            }
            column(Text120; Text120)
            {
            }
            column(Payment_Line__Document_No__; "Document No.")
            {
            }
            column(STRSUBSTNO_Text122__CodGPaymentTermsCode__TexGPaymentTermsDescription_FORMAT__Due_Date__12_7__; STRSUBSTNO(Text122, CodGPaymentTermsCode, TexGPaymentTermsDescription, FORMAT("Due Date", 12, 7)))
            {
            }
            column(Text123; Text123)
            {
            }
            column(Text124; Text124)
            {
            }
            column(STRSUBSTNO_Text126__Text123_; STRSUBSTNO(Text126, Text123))
            {
            }
            column(Text125; Text125)
            {
            }
            column(LETTRE_TRAITE_FOURNISSEURCaption; LETTRE_TRAITE_FOURNISSEURCaptionLbl)
            {
            }
            column(Follow_up_by_the_accounts_receivable____01_48_11_49_66LCaption; Follow_up_by_the_accounts_receivable____01_48_11_49_66LCaptionLbl)
            {
            }
            column(Votre_CodeCaption; Votre_CodeCaptionLbl)
            {
            }
            column("NuméroCaption"; NuméroCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
            {
            }
            column(Payment_Line_No_; "No.")
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Payment_Line_Applies_to_ID; "Applies-to ID")
            {
            }
            dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
            {
                CalcFields = Amount, "Remaining Amount";
                DataItemLink = "Applies-to ID" = FIELD("Applies-to ID"),
                               "Vendor No." = FIELD("Account No.");
                DataItemTableView = SORTING("Applies-to ID");
                column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_Type_; "Document Type")
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(DecG_VendorLedger_CreditAmount; DecG_VendorLedger_CreditAmount)
                {
                }
                column(DecG_VendorLedger_DebitAmount; DecG_VendorLedger_DebitAmount)
                {
                }
                column(Amount____Remaining_Amount_; Amount - "Remaining Amount")
                {
                }
                column(CodG_OrderNo; CodG_OrderNo)
                {
                }
                column(ReportAmount___NSCAmount; ReportAmount - NSCAmount)
                {
                    AutoCalcField = false;
                }
                column(Payment_Line___Due_Date_; PaymentLine."Due Date")
                {
                }
                column(Payment_Line___No__; PaymentLine."No.")
                {
                }
                column(NSCAmount; NSCAmount)
                {
                    AutoCalcField = false;
                }
                column(V1____Payment_Line__Amount; -1 * PaymentLine.Amount)
                {
                    AutoCalcField = false;
                }
                column(TypeCaption; TypeCaptionLbl)
                {
                }
                column(AMOUNT_FOR_CONTROLCaption; AMOUNT_FOR_CONTROLCaptionLbl)
                {
                }
                column(AMOUNT_FOR_CONTROLCaption_Control1000000130; AMOUNT_FOR_CONTROLCaption_Control1000000130Lbl)
                {
                }
                column(Posting_DateCaption; Posting_DateCaptionLbl)
                {
                }
                column(NumberCaption; NumberCaptionLbl)
                {
                }
                column(AMOUNT_FOR_CONTROLCaption_Control1000000040; AMOUNT_FOR_CONTROLCaption_Control1000000040Lbl)
                {
                }
                column("Montant_PayéCaption"; Montant_PayéCaptionLbl)
                {
                }
                column(Votre_Cmde__Caption; Votre_Cmde__CaptionLbl)
                {
                }
                column(Report___Caption; Report___CaptionLbl)
                {
                }
                column(A_payerCaption; A_payerCaptionLbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Applies_to_ID; "Applies-to ID")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Amount, "Remaining Amount");
                    NSCAmount := Amount * (-1);

                    CLEAR(CodG_OrderNo);
                    IF (VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Invoice) THEN BEGIN
                        RecGPurchInvHeader.RESET();
                        IF (RecGPurchInvHeader.GET(VendorLedgerEntry."Document No.")) THEN BEGIN
                            CodG_OrderNo := RecGPurchInvHeader."Order No.";
                        END;
                    END;

                    IF (VendorLedgerEntry."Remaining Amount" < 0) THEN BEGIN
                        DecG_VendorLedger_DebitAmount := -VendorLedgerEntry."Remaining Amount";
                        DecG_VendorLedger_CreditAmount := 0;
                    END ELSE BEGIN
                        DecG_VendorLedger_DebitAmount := 0;
                        DecG_VendorLedger_CreditAmount := VendorLedgerEntry."Remaining Amount";
                    END;

                    ReportAmount := Amount * (-1) + ReportAmount;
                end;

                trigger OnPreDataItem()
                begin
                    ReportAmount := 0;
                end;
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CountryName; CountryName)
                {
                }
                column(CompanyAddr_5_; CompanyAddr[5])
                {
                }
                column(CompanyAddr_7_; CompanyAddr[7])
                {
                }
                column(CompanyAddr_5__Control1000000168; CompanyAddr[5])
                {
                }
                column(CompanyAddr_4_; CompanyAddr[4])
                {
                }
                column(CompanyAddr_3_; CompanyAddr[3])
                {
                }
                column(CompanyAddr_1_; CompanyAddr[1])
                {
                }
                column(Payment_Line___Agency_Code_; PaymentLine."Agency Code")
                {
                }
                column(Payment_Line___Bank_Branch_No__; PaymentLine."Bank Branch No.")
                {
                }
                column(Payment_Line___Bank_Account_No__; PaymentLine."Bank Account No.")
                {
                }
                column(CONVERTSTR_FORMAT__Payment_Line___RIB_Key__2_______0__; CONVERTSTR(FORMAT(PaymentLine."RIB Key", 2), ' ', '0'))
                {
                }
                column(Payment_Line___Bank_Account_Name_; PaymentLine."Bank Account Name")
                {
                }
                column(Payment_Line___Drawee_Reference_; PaymentLine."Drawee Reference")
                {
                }
                column(Payment_Line___Bank_City_; PaymentLine."Bank City")
                {
                }
                column(Address; Address)
                {
                }
                column(Address2; Address2)
                {
                }
                column(Name; Name)
                {
                }
                column(FORMAT__1____Payment_Line__Amount_0___Precision_2___Standard_Format_0___; '****' + FORMAT(-1 * PaymentLine.Amount, 0, '<Precision,2:><Standard Format,0>'))
                {
                }
                column(AmountText; AmountText)
                {
                }
                column(Payment_Line___Account_No__; PaymentLine."Account No.")
                {
                }
                column(IssueDate; IssueDate)
                {
                }
                column(Payment_Line___Due_Date__Control1000000239; PaymentLine."Due Date")
                {
                }
                column(PostingDate; PostingDate)
                {
                }
                column(IssueCity; IssueCity)
                {
                }
                column(FORMAT__1__Payment_Line__Amount_0___Precision_2___Standard_Format_0___; '****' + FORMAT(-1 * PaymentLine.Amount, 0, '<Precision,2:><Standard Format,0>'))
                {
                }
                column(Payment_Line___Document_No__; PaymentLine."Document No.")
                {
                }
                column(CompanyAddr_2_; CompanyAddr[2])
                {
                }
                column(CodGPaymentMethodCode_Control1000000045; CodGPaymentMethodCode)
                {
                }
                column(PostCode; PostCode)
                {
                }
                column(City; City)
                {
                }
                column(TRAITE_A_DETACHERCaption; TRAITE_A_DETACHERCaptionLbl)
                {
                }
                column(of_SUBSCRIBERCaption; of_SUBSCRIBERCaptionLbl)
                {
                }
                column(below_to__Caption; below_to__CaptionLbl)
                {
                }
                column(whe_will__pay_the_indicated_sumCaption; whe_will__pay_the_indicated_sumCaptionLbl)
                {
                }
                column(noted_as_NO_CHARGESCaption; noted_as_NO_CHARGESCaptionLbl)
                {
                }
                column(Against_this_BILLCaption; Against_this_BILLCaptionLbl)
                {
                }
                column(Stamp_Allow_and_SignatureCaption; Stamp_Allow_and_SignatureCaptionLbl)
                {
                }
                column(DOMICILIATIONCaption; DOMICILIATIONCaptionLbl)
                {
                }
                column(Write_nothings_under_this_lineCaption; Write_nothings_under_this_lineCaptionLbl)
                {
                }
                column(SUBSCRIBER_REF_Caption; SUBSCRIBER_REF_CaptionLbl)
                {
                }
                column(L_C_R__onlyCaption; L_C_R__onlyCaptionLbl)
                {
                }
                column(DUE_DATECaption; DUE_DATECaptionLbl)
                {
                }
                column(NAME_andCaption; NAME_andCaptionLbl)
                {
                }
                column(ADDRESSCaption; ADDRESSCaptionLbl)
                {
                }
                column(RIBCaption; RIBCaptionLbl)
                {
                }
                column(ONCaption; ONCaptionLbl)
                {
                }
                column(CREATION_DATECaption; CREATION_DATECaptionLbl)
                {
                }
                column(n__compteCaption; n__compteCaptionLbl)
                {
                }
                column(SUBSCRIBER_S_R_I_B_Caption; SUBSCRIBER_S_R_I_B_CaptionLbl)
                {
                }
                column(ACCEPTANCE_or_ENDORSMENTCaption; ACCEPTANCE_or_ENDORSMENTCaptionLbl)
                {
                }
                column(AMOUNT_FOR_CONTROLCaption_Control1000000269; AMOUNT_FOR_CONTROLCaption_Control1000000269Lbl)
                {
                }
                column(guichetCaption; guichetCaptionLbl)
                {
                }
                column(Control1000000275Caption; Control1000000275CaptionLbl)
                {
                }
                column(Value_in_EURCaption; Value_in_EURCaptionLbl)
                {
                }
                column(etab_Caption; etab_CaptionLbl)
                {
                }
                column(TOCaption; TOCaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnPostDataItem()
                begin
                    CurrReport.PAGENO := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Currency: Record Currency;
                Cust: Record Customer;
                CustPaymentAddr: Record "Payment Address";
                FormatAddress: Codeunit "Format Address";
            begin

                CustPaymentAddr.INIT();

                PaymtHeader.GET("No.");
                PostingDate := PaymtHeader."Posting Date";

                Amount := -Amount;

                GLSetup.GET();
                IF IssueDate = 0D THEN
                    IssueDate := WORKDATE();

                IF CustPaymentAddr.GET(PaymentLine."Account Type", PaymentLine."Account No.", PaymentLine."Payment Address Code") THEN
                    PaymtManagt.PaymentAddr(CustAdr, CustPaymentAddr)
                ELSE BEGIN
                    IF Cust.GET(PaymentLine."Account No.") THEN;
                    FormatAddress.Customer(CustAdr, Cust);
                END;

                IF "Currency Code" = '' THEN
                    AmountText := Text001 + ' €'
                ELSE
                    AmountText := Text001 + ' ' + "Currency Code";

                FormatAddress.Company(CompanyAddr, CompanyInfo);

                IF Country.GET(CompanyInfo."Country/Region Code") THEN;

                RecG_Vendor.RESET();
                IF RecG_Vendor.GET(PaymentLine."Account No.") THEN BEGIN

                    RecG_PaymentTerms.RESET();
                    IF RecG_PaymentTerms.GET(RecG_Vendor."Payment Terms Code") THEN BEGIN
                        CodGPaymentTermsCode := RecG_PaymentTerms.Code;
                        TexGPaymentTermsDescription := RecG_PaymentTerms.Description;
                    END ELSE BEGIN
                        CodGPaymentTermsCode := '';
                        TexGPaymentTermsDescription := '';
                    END;

                    RecGPaymentMethod.RESET();
                    IF RecGPaymentMethod.GET(RecG_Vendor."Payment Method Code") THEN BEGIN
                        CodGPaymentMethodCode := RecGPaymentMethod.Code;
                        TexGPaymentMethodDescription := RecGPaymentMethod.Description;
                    END ELSE BEGIN
                        CodGPaymentMethodCode := '';
                        TexGPaymentMethodDescription := '';
                    END;

                    RecG_SalespersonPurchaser.RESET();
                    IF RecG_SalespersonPurchaser.GET(RecG_Vendor."Purchaser Code") THEN
                        CodGVendorPurchaserCode := RecG_SalespersonPurchaser.Code
                    ELSE
                        CLEAR(CodGVendorPurchaserCode);
                END;

                // Ajout partie Vendor, etc.
                Name := '';
                Address := '';
                Address2 := '';
                PostCode := '';
                City := '';
                CountryName := '';

                IF Vendor.GET("Account No.") THEN BEGIN
                    Name := Vendor.Name;
                    Address := Vendor.Address;
                    Address2 := Vendor."Address 2";
                    PostCode := Vendor."Post Code";
                    City := Vendor.City;

                    IF Vendor."Country/Region Code" = '' THEN
                        IF Country.GET(Vendor."Country/Region Code") THEN
                            CountryName := Country.Name;
                END;

                IF "Payment Address Code" <> '' THEN BEGIN
                    IF PaymentAddress.GET(PaymentAddress."Account Type"::Vendor, "Account No.", "Payment Address Code") THEN BEGIN
                        Name := PaymentAddress.Name;
                        Address := PaymentAddress.Address;
                        Address2 := PaymentAddress."Address 2";
                        PostCode := PaymentAddress."Post Code";
                        City := PaymentAddress.City;

                        IF PaymentAddress."Country/Region Code" = '' THEN
                            IF Country.GET(PaymentAddress."Country/Region Code") THEN
                                CountryName := Country.Name;
                    END;
                END
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.GET();

                FormatAddress.Company(CompanyAddr, CompanyInfo);
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
                    field(IssueDate; IssueDate)
                    {
                    }
                    field(IssueCity; IssueCity)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        //pour afficher les logos
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        PaymentAddress: Record "Payment Address";
        PaymtHeader: Record "Payment Header";
        PaymtLine: Record "Payment Line";
        RecGPaymentMethod: Record "Payment Method";
        RecG_PaymentTerms: Record "Payment Terms";
        RecGPurchInvHeader: Record "Purch. Inv. Header";
        RecGPurchaseHeader: Record "Purchase Header";
        "RecGSalesCr.MemoHeader": Record "Sales Cr.Memo Header";
        RecG_SalespersonPurchaser: Record "Salesperson/Purchaser";
        RecG_Vendor: Record Vendor;
        Vendor: Record Vendor;
        FormatAddress: Codeunit "Format Address";
        PaymtManagt: Codeunit "Payment Management";
        CodGPaymentMethodCode: Code[10];
        CodGPaymentTermsCode: Code[10];
        CodGVendorPurchaserCode: Code[10];
        AccountNo: Code[20];
        CodG_OrderNo: Code[20];
        IssueDate: Date;
        PostingDate: Date;
        DecG_VendorLedger_CreditAmount: Decimal;
        DecG_VendorLedger_DebitAmount: Decimal;
        NSCAmount: Decimal;
        PrintAmount: Decimal;
        ReportAmount: Decimal;
        "--NSC1.02--": Integer;
        A_payerCaptionLbl: Label 'A payer';
        ACCEPTANCE_or_ENDORSMENTCaptionLbl: Label 'ACCEPTANCE or ENDORSMENT', comment = 'FRA="ACCEPTATION ou AVAL"';
        ADDRESSCaptionLbl: Label 'ADDRESS', comment = 'FRA="ADDRESSE"';
        Against_this_BILLCaptionLbl: Label 'Against this BILL', comment = 'FRA="Contre cette LETTRE DE CHANGE"';
        AMOUNT_FOR_CONTROLCaption_Control1000000040Lbl: Label 'AMOUNT FOR CONTROL', comment = 'FRA="Débit"';
        AMOUNT_FOR_CONTROLCaption_Control1000000130Lbl: Label 'AMOUNT FOR CONTROL', comment = 'FRA="Crédit"';
        AMOUNT_FOR_CONTROLCaption_Control1000000269Lbl: Label 'AMOUNT FOR CONTROL', comment = 'FRA="MONTANT POUR CONTROLE"';
        AMOUNT_FOR_CONTROLCaptionLbl: Label 'AMOUNT FOR CONTROL', comment = 'FRA="Echéance"';
        below_to__CaptionLbl: Label 'below to :', comment = 'FRA="ci-dessous à :"';
        Control1000000275CaptionLbl: Label 'Label1000000275', comment = 'FRA=""';
        CREATION_DATECaptionLbl: Label 'CREATION DATE', comment = 'FRA="DATE DE CREATION"';
        DateCaptionLbl: Label 'Date';
        DOMICILIATIONCaptionLbl: Label 'DOMICILIATION', comment = 'FRA="DOMICILIATION"';
        DUE_DATECaptionLbl: Label 'DUE DATE', comment = 'FRA="ECHEANCE"';
        etab_CaptionLbl: Label 'etab.';
        Follow_up_by_the_accounts_receivable____01_48_11_49_66LCaptionLbl: Label 'Follow-up by the accounts receivable  : 01 48 11 49 66L', comment = 'FRA="Suivi par la comptabilité clients : 01 48 11 49 66"';
        guichetCaptionLbl: Label 'guichet';
        L_C_R__onlyCaptionLbl: Label 'L.C.R. only', comment = 'FRA="L.C.R. seulement"';
        LETTRE_TRAITE_FOURNISSEURCaptionLbl: Label 'LETTRE TRAITE FOURNISSEUR';
        "Montant_PayéCaptionLbl": Label 'Montant Payé';
        n__compteCaptionLbl: Label 'n° compte';
        NAME_andCaptionLbl: Label 'NAME and', comment = 'FRA="NOM et"';
        noted_as_NO_CHARGESCaptionLbl: Label 'noted as NO CHARGES', comment = 'FRA="=stipulée SANS FRAIS"';
        NumberCaptionLbl: Label 'Number', comment = 'FRA="Numéro"';
        "NuméroCaptionLbl": Label 'Numéro';
        of_SUBSCRIBERCaptionLbl: Label 'of SUBSCRIBER', comment = 'FRA="du SOUSCRIPTEUR"';
        ONCaptionLbl: Label 'ON', comment = 'FRA="LE"';
        Posting_DateCaptionLbl: Label 'Posting Date', comment = 'FRA="Date"';
        Report___CaptionLbl: Label 'Report...', comment = 'FRA="Report..."';
        RIBCaptionLbl: Label 'RIB';
        Stamp_Allow_and_SignatureCaptionLbl: Label 'Stamp Allow and Signature', comment = 'FRA="Droit de timbre et signature"';
        SUBSCRIBER_REF_CaptionLbl: Label 'SUBSCRIBER REF.', comment = 'FRA="REF. SOUSCRIPTEUR"';
        SUBSCRIBER_S_R_I_B_CaptionLbl: Label 'SUBSCRIBER''S R.I.B.', comment = 'FRA="R.I.B. du SOUSCRIPTEUR"';
        Text001: Label 'Amount', comment = 'FRA="Montant"';
        Text030: Label '%1 - %2 %3';
        Text031: Label 'Tel. :  %1 - Fax :  %2';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', comment = 'FRA="%1 AU CAPITAL DE %2  · %3  · SIRET %4 ·  APE %5"';
        Text033: Label 'Fax :  %1';
        Text120: Label 'Mode de règlement';
        Text121: Label 'Votre Interlocuteur Commercial :';
        Text122: Label 'Conditions commerciales %1 - %2 Au %3';
        Text123: Label 'Mesdames, Messieurs,';
        Text124: Label 'Nous vous remettons, ci-inclus une lettre de change en';
        Text125: Label 'règlement du relevé ci-dessous';
        Text126: Label 'Veuillez agréer, %1 nos sincères salutations.';
        TOCaptionLbl: Label 'TO', comment = 'FRA="A"';
        TRAITE_A_DETACHERCaptionLbl: Label 'TRAITE A DETACHER';
        TypeCaptionLbl: Label ' Type';
        txtlbl1: label '%1';

        Value_in_EURCaptionLbl: Label 'Value in EUR', comment = 'FRA="Valeur en EUR"';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>', comment = 'FRA="N° TVA Intracommunautaire :"';
        Votre_Cmde__CaptionLbl: Label 'Votre Cmde :';
        Votre_CodeCaptionLbl: Label 'Votre Code';
        whe_will__pay_the_indicated_sumCaptionLbl: Label 'whe will  pay the indicated sum', comment = 'FRA="nous paierons la somme indiquée"';
        Write_nothings_under_this_lineCaptionLbl: Label 'Write nothings under this line', comment = 'FRA="ne rien inscrire au dessous de cette ligne"';
        AmountText: Text[30];
        IssueCity: Text[30];
        PostCode: Text[30];
        TexGPaymentMethodDescription: Text[30];
        Address: Text[50];
        Address2: Text[50];
        City: Text[50];
        CompanyAddr: array[8] of Text[50];
        CountryName: Text[50];
        CustAdr: array[8] of Text[50];
        Name: Text[50];
        TexGPaymentTermsDescription: Text[50];
}

