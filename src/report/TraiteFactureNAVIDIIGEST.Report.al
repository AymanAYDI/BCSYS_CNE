report 50035 "Traite/Facture NAVIDIIGEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TraiteFactureNAVIDIIGEST.rdlc';
    Caption = 'Bill';

    dataset
    {
        dataitem(DataItem5581; Table112)
        {
            RequestFilterFields = "No.", "Bill-to Customer No.", "Payment Method Code", "Due Date";
            RequestFilterHeading = 'Factures';
            column(CustAdr_6_; CustAdr[6])
            {
            }
            column(CustAdr_7_; CustAdr[7])
            {
            }
            column(CustAdr_5_; CustAdr[5])
            {
            }
            column(CustAdr_4_; CustAdr[4])
            {
            }
            column(CustAdr_2_; CustAdr[2])
            {
            }
            column(CustAdr_3_; CustAdr[3])
            {
            }
            column(CustAdr_1_; CustAdr[1])
            {
            }
            column(CustBankAcc_Grc__Agency_Code_; CustBankAcc_Grc."Agency Code")
            {
            }
            column(CustBankAcc_Grc__Bank_Branch_No__; CustBankAcc_Grc."Bank Branch No.")
            {
            }
            column(CustBankAcc_Grc__Bank_Account_No__; CustBankAcc_Grc."Bank Account No.")
            {
            }
            column(CONVERTSTR_FORMAT_CustBankAcc_Grc__RIB_Key__2_______0__; CONVERTSTR(FORMAT(CustBankAcc_Grc."RIB Key", 2), ' ', '0'))
            {
            }
            column(CustBankAcc_Grc_Name; CustBankAcc_Grc.Name)
            {
            }
            column(FORMAT__Amount_Including_VAT__0___Precision_2___Standard_Format_0___; '****' + FORMAT("Amount Including VAT", 0, '<Precision,2:><Standard Format,0>'))
            {
            }
            column(FORMAT__Amount_Including_VAT__0___Precision_2___Standard_Format_0____Control1000000097; '****' + FORMAT("Amount Including VAT", 0, '<Precision,2:><Standard Format,0>'))
            {
            }
            column(IssueCity; IssueCity)
            {
            }
            column(IssueDate; IssueDate)
            {
            }
            column(Sales_Invoice_Header__Due_Date_; "Due Date")
            {
            }
            column(CustBankAcc_Grc_City; CustBankAcc_Grc.City)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(AmountText; AmountText)
            {
            }
            column(CurrText_Gtxt; CurrText_Gtxt)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo__Post_Code_; CompanyInfo."Post Code")
            {
            }
            column(Sales_Invoice_Header__Amount_Including_VAT_; "Amount Including VAT")
            {
            }
            column(ACCEPTANCE_or_ENDORSMENTCaption; ACCEPTANCE_or_ENDORSMENTCaptionLbl)
            {
            }
            column(of_DRAWEECaption; of_DRAWEECaptionLbl)
            {
            }
            column(Stamp_Allow_and_SignatureCaption; Stamp_Allow_and_SignatureCaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(NAME_andCaption; NAME_andCaptionLbl)
            {
            }
            column(Value_in__Caption; Value_in__CaptionLbl)
            {
            }
            column(DRAWEE_R_I_B_Caption; DRAWEE_R_I_B_CaptionLbl)
            {
            }
            column(DOMICILIATIONCaption; DOMICILIATIONCaptionLbl)
            {
            }
            column(TOCaption; TOCaptionLbl)
            {
            }
            column(ONCaption; ONCaptionLbl)
            {
            }
            column(AMOUNT_FOR_CONTROLCaption; AMOUNT_FOR_CONTROLCaptionLbl)
            {
            }
            column(CREATION_DATECaption; CREATION_DATECaptionLbl)
            {
            }
            column(DUE_DATECaption; DUE_DATECaptionLbl)
            {
            }
            column(DRAWEE_REF_Caption; DRAWEE_REF_CaptionLbl)
            {
            }
            column(below_for_order_of__Caption; below_for_order_of__CaptionLbl)
            {
            }
            column(please_pay_the_indicated_sumCaption; please_pay_the_indicated_sumCaptionLbl)
            {
            }
            column(noted_as_NO_CHARGESCaption; noted_as_NO_CHARGESCaptionLbl)
            {
            }
            column(Against_this_BILLCaption; Against_this_BILLCaptionLbl)
            {
            }
            column(BILLCaption; BILLCaptionLbl)
            {
            }
            column(L_C_R__onlyCaption; L_C_R__onlyCaptionLbl)
            {
            }
            column(Write_nothings_under_this_lineCaption; Write_nothings_under_this_lineCaptionLbl)
            {
            }
            column(etab_Caption; etab_CaptionLbl)
            {
            }
            column(guichetCaption; guichetCaptionLbl)
            {
            }
            column(n__compteCaption; n__compteCaptionLbl)
            {
            }
            column(RIBCaption; RIBCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                FormatAddress: Codeunit "365";
            begin
                CustBankAcc_Grc.INIT;
                IF Cust.GET("Sales Invoice Header"."Bill-to Customer No.") THEN
                    IF Cust."Preferred Bank Account Code" <> '' THEN
                        CustBankAcc_Grc.GET("Sales Invoice Header"."Bill-to Customer No.", Cust."Preferred Bank Account Code");

                PostingDate := "Posting Date";

                IF "Currency Code" = '' THEN
                    AmountText := Text001 + ' €'
                ELSE
                    AmountText := Text001 + ' ' + "Currency Code";

                FormatAddress.SalesInvBillTo(CustAdr, "Sales Invoice Header");

                IF "Currency Code" = '' THEN
                    CurrText_Gtxt := GenLedgSetup_Grc."LCY Code"
                ELSE
                    CurrText_Gtxt := "Currency Code";

                CALCFIELDS(Amount);
            end;

            trigger OnPreDataItem()
            begin
                GenLedgSetup_Grc.GET();
                CompanyInfo.CALCFIELDS(Picture);
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
                        Caption = 'Issue date';
                    }
                    field(IssueCity; IssueCity)
                    {
                        Caption = 'Issue city';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            CompanyInfo.GET;
            IssueCity := CompanyInfo.City;
            IssueDate := WORKDATE;
        end;
    }

    labels
    {
    }

    var
        GenLedgSetup_Grc: Record "98";
        CustBankAcc_Grc: Record "287";
        CompanyInfo: Record "79";
        Cust: Record "18";
        GLSetup: Record "98";
        CustAdr: array[8] of Text[50];
        IssueCity: Text[30];
        IssueDate: Date;
        PrintAmount: Decimal;
        AccountNo: Code[20];
        GroupGLDate: Date;
        PaymtLine: Record "10866";
        PaymtHeader: Record "10865";
        PostingDate: Date;
        PaymtManagt: Codeunit "10860";
        Text001: Label 'Amount';
        AmountText: Text[30];
        CurrText_Gtxt: Text[30];
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
}

