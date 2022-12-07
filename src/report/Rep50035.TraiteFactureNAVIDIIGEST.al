report 50035 "BC6_Traite/Facture NAVIDIIGEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TraiteFactureNAVIDIIGEST.rdlc';
    Caption = 'Bill';

    dataset
    {
        dataitem(SalesInvHeader; "Sales Invoice Header")
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
                FormatAddress: Codeunit "Format Address";
            begin
                CustBankAcc_Grc.INIT();
                IF Cust.GET(SalesInvHeader."Bill-to Customer No.") THEN
                    IF Cust."Preferred Bank Account Code" <> '' THEN
                        CustBankAcc_Grc.GET(SalesInvHeader."Bill-to Customer No.", Cust."Preferred Bank Account Code");

                PostingDate := "Posting Date";

                IF "Currency Code" = '' THEN
                    AmountText := Text001 + ' €'
                ELSE
                    AmountText := Text001 + ' ' + "Currency Code";

                FormatAddress.SalesInvBillTo(CustAdr, SalesInvHeader);

                IF "Currency Code" = '' THEN
                    CurrText_Gtxt := GenLedgSetup_Grc."LCY Code"
                ELSE
                    CurrText_Gtxt := "Currency Code";

                CALCFIELDS(Amount);
            end;

            trigger OnPreDataItem()
            begin
                GenLedgSetup_Grc.GET();
                CompanyInfo.CALCFIELDS("Picture");
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

            CompanyInfo.GET();
            IssueCity := CompanyInfo.City;
            IssueDate := WORKDATE();
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        CustBankAcc_Grc: Record "Customer Bank Account";
        GenLedgSetup_Grc: Record "General Ledger Setup";
        PaymtLine: Record "Payment Line";
        IssueDate: Date;
        PostingDate: Date;
        ACCEPTANCE_or_ENDORSMENTCaptionLbl: Label 'ACCEPTANCE or ENDORSMENT', comment = 'FRA="ACCEPTATION ou AVAL"';
        ADDRESSCaptionLbl: Label 'ADDRESS', comment = 'FRA="ADRESSE"';
        Against_this_BILLCaptionLbl: Label 'Against this BILL', comment = 'FRA="Contre cette LETTRE DE CHANGE"';
        AMOUNT_FOR_CONTROLCaptionLbl: Label 'AMOUNT FOR CONTROL', comment = 'FRA="MONTANT POUR CONTROLE"';
        below_for_order_of__CaptionLbl: Label 'below for order of :', comment = 'FRA="ci-dessous à l''ordre de :"';
        BILLCaptionLbl: Label 'BILL', comment = 'FRA="L.C.R."';
        CREATION_DATECaptionLbl: Label 'CREATION DATE', comment = 'FRA="DATE DE CREATION"';
        DOMICILIATIONCaptionLbl: Label 'DOMICILIATION', comment = 'FRA="DOMICILIATION"';
        DRAWEE_R_I_B_CaptionLbl: Label 'DRAWEE R.I.B.', comment = 'FRA="R.I.B. DU TIRE"';
        DRAWEE_REF_CaptionLbl: Label 'DRAWEE REF.', comment = 'FRA="REF. TIRE"';
        DUE_DATECaptionLbl: Label 'DUE DATE', comment = 'FRA="ECHEANCE"';
        etab_CaptionLbl: Label 'etab.', comment = 'FRA="etab."';
        guichetCaptionLbl: Label 'guichet';
        L_C_R__onlyCaptionLbl: Label 'L.C.R. only', comment = 'FRA="L.C.R. seulement"';
        n__compteCaptionLbl: Label 'n° compte';
        NAME_andCaptionLbl: Label 'NAME and', comment = 'FRA=""';
        noted_as_NO_CHARGESCaptionLbl: Label 'noted as NO CHARGES', comment = 'FRA="stipulée SANS FRAIS"';
        of_DRAWEECaptionLbl: Label 'of DRAWEE', comment = 'FRA="du TIRE"';
        ONCaptionLbl: Label 'ON', comment = 'FRA="LE"';
        please_pay_the_indicated_sumCaptionLbl: Label 'please pay the indicated sum', comment = 'FRA="veuillez payer la somme indiquée"';
        RIBCaptionLbl: Label 'RIB';
        Stamp_Allow_and_SignatureCaptionLbl: Label 'Stamp Allow and Signature', comment = 'FRA="Droit de timbre et signature"';
        Text001: Label 'Amount', comment = 'FRA="Montant"';
        TOCaptionLbl: Label 'TO', comment = 'FRA="A"';
        Value_in__CaptionLbl: Label 'Value in :', comment = 'FRA="Valeur en :"';
        Write_nothings_under_this_lineCaptionLbl: Label 'Write nothings under this line', comment = 'FRA="ne rien inscrire au dessous de cette ligne"';
        AmountText: Text[30];
        CurrText_Gtxt: Text[30];
        IssueCity: Text[30];
        CustAdr: array[8] of Text[50];
}

