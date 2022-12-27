report 50018 "BC6_Sales Stat/Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesStatCustomer.rdl';

    Caption = 'Sales Stat/Customer', Comment = 'FRA="Stat vente/Client"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem(CustLedgEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Salesperson Code", "Customer No.", "Posting Date", "Document Type")
                                WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
            RequestFilterFields = "Customer No.", "Posting Date", "Salesperson Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column("USERID"; USERID)
            {
            }
            column(STRSUBSTNO_text001_DatGDebut_1__DatGFin_1__; STRSUBSTNO(text001, DatGDebut[1], DatGFin[1]))
            {
            }
            column(Cust__Ledger_Entry__Cust__Ledger_Entry___Salesperson_Code_; CustLedgEntry."Salesperson Code")
            {
            }
            column(TxtGSalesPerson; TxtGSalesPerson)
            {
            }
            column(DecGMontant_1_; DecGMontant[1])
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(DecGMarge_4_; DecGMarge[4])
            {
            }
            column(DecGMontant_4_; DecGMontant[4])
            {
            }
            column(DecGMarge_3_; DecGMarge[3])
            {
            }
            column(DecGMontant_3_; DecGMontant[3])
            {
            }
            column(DecGpourcent_1_; DecGpourcent[1])
            {
            }
            column(DecGMontant_2_; DecGMontant[2])
            {
            }
            column(DecGpourcent_3_; DecGpourcent[3])
            {
            }
            column(DecGpourcent_4_; DecGpourcent[4])
            {
            }
            column(DecGMontant_3__DecGMontant_4_; DecGMontant[3] - DecGMontant[4])
            {
            }
            column(DecGVar; DecGVar)
            {
            }
            column(TxtGClient; TxtGClient)
            {
            }
            column(DecGvarmarge; DecGvarmarge)
            {
            }
            column(DecGMarge_1_; DecGMarge[1])
            {
            }
            column(DecGPVarCA; DecGPVarCA)
            {
            }
            column(DecGMontant_3__DecGMontant_4__Control1000000017; DecGMontant[3] - DecGMontant[4])
            {
            }
            column(DecGPMargNCum; DecGPMargNCum)
            {
            }
            column(DecGMarge_4__Control1000000021; DecGMarge[4])
            {
            }
            column(DecGMontant_4__Control1000000022; DecGMontant[4])
            {
            }
            column(DecGPMargPer; DecGPMargPer)
            {
            }
            column(DecGMarge_3__Control1000000024; DecGMarge[3])
            {
            }
            column(DecGMontant_3__Control1000000025; DecGMontant[3])
            {
            }
            column(DecGMontant_2__Control1000000026; DecGMontant[2])
            {
            }
            column(DecGPMargCum; DecGPMargCum)
            {
            }
            column(DecGMarge_1__Control1000000028; DecGMarge[1])
            {
            }
            column(DecGMontant_1__Control1000000029; DecGMontant[1])
            {
            }
            column(DecGPVarMarge; DecGPVarMarge)
            {
            }
            column(Cust__Ledger_Entry__Cust__Ledger_Entry___Salesperson_Code__Control1000000000; CustLedgEntry."Salesperson Code")
            {
            }
            column(TxtGSalesPerson_Control1000000001; TxtGSalesPerson)
            {
            }
            column(DecGVar_Control1000000034; DecGVar)
            {
            }
            column(DecGMontant_3__DecGMontant_4__Control1000000035; DecGMontant[3] - DecGMontant[4])
            {
            }
            column(DecGpourcent_4__Control1000000036; DecGpourcent[4])
            {
            }
            column(DecGMarge_4__Control1000000037; DecGMarge[4])
            {
            }
            column(DecGMontant_4__Control1000000038; DecGMontant[4])
            {
            }
            column(DecGpourcent_1__Control1000000039; DecGpourcent[1])
            {
            }
            column(DecGMarge_3__Control1000000040; DecGMarge[3])
            {
            }
            column(DecGMontant_3__Control1000000042; DecGMontant[3])
            {
            }
            column(DecGMontant_2__Control1000000043; DecGMontant[2])
            {
            }
            column(DecGpourcent_3__Control1000000044; DecGpourcent[3])
            {
            }
            column(DecGMarge_1__Control1000000045; DecGMarge[1])
            {
            }
            column(DecGMontant_1__Control1000000046; DecGMontant[1])
            {
            }
            column(DecGvarmarge_Control1000000047; DecGvarmarge)
            {
            }
            column(Customer_codeCaption; Customer_codeCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column("Montant_marge_périodeCaption"; Montant_marge_périodeCaptionLbl)
            {
            }
            column("marge_périodeCaption"; marge_périodeCaptionLbl)
            {
            }
            column("Marge_cumuléeCaption"; Marge_cumuléeCaptionLbl)
            {
            }
            column("marge_cumuléeCaption_Control1000000085"; marge_cumuléeCaption_Control1000000085Lbl)
            {
            }
            column("Sales_périod_N_1Caption"; Sales_périod_N_1CaptionLbl)
            {
            }
            column(CA_periodeCaption; CA_periodeCaptionLbl)
            {
            }
            column("CA_CumuléCaption"; CA_CumuléCaptionLbl)
            {
            }
            column("CA_N_1_CumuléCaption"; CA_N_1_CumuléCaptionLbl)
            {
            }
            column("Marge_N_1_CumuléCaption"; Marge_N_1_CumuléCaptionLbl)
            {
            }
            column("marge_N_1_CumuléCaption_Control1000000091"; marge_N_1_CumuléCaption_Control1000000091Lbl)
            {
            }
            column(variation_margeCaption; variation_margeCaptionLbl)
            {
            }
            column(variation_CACaption; variation_CACaptionLbl)
            {
            }
            column(Variation_CACaption_Control1000000094; Variation_CACaption_Control1000000094Lbl)
            {
            }
            column(Sales_statisticsCaption; Sales_statisticsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendeurCaption; VendeurCaptionLbl)
            {
            }
            column(Total_VendeurCaption; Total_VendeurCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                TxtGClient := CustLedgEntry.getCustomerName(CustLedgEntry."Customer No.");
                IF RecGSalesperson.GET(CustLedgEntry."Salesperson Code") THEN
                    TxtGSalesPerson := RecGSalesperson.Name
                ELSE
                    CLEAR(TxtGSalesPerson);
                IF (CustLedgEntry."Salesperson Code" <> CodGSalesperson)
                  OR (CustLedgEntry."Customer No." <> CodGCodeclt) THEN BEGIN

                    RecGCustEntry.RESET();
                    RecGCustEntry.SETCURRENTKEY("Salesperson Code", "Customer No.", "Posting Date", "Document Type");
                    RecGCustEntry.SETFILTER("Customer No.", CustLedgEntry."Customer No.");
                    RecGCustEntry.SETFILTER("Salesperson Code", '%1', CustLedgEntry."Salesperson Code");
                    RecGCustEntry.SETFILTER("Document Type", '2|3');

                    FOR IntGI := 1 TO 4 DO BEGIN
                        DecGMontant[IntGI] := 0;
                        DecGMarge[IntGI] := 0;
                        DecGpourcent[IntGI] := 0;
                        RecGCustEntry.SETRANGE(RecGCustEntry."Posting Date", DatGDebut[IntGI], DatGFin[IntGI]);

                        IF RecGCustEntry.FINDSET() THEN BEGIN
                            RecGCustEntry.CALCSUMS(RecGCustEntry."Sales (LCY)");
                            DecGMontant[IntGI] := RecGCustEntry."Sales (LCY)";
                            RecGCustEntry.CALCSUMS(RecGCustEntry."Profit (LCY)");
                            DecGMarge[IntGI] := RecGCustEntry."Profit (LCY)";

                            IF DecGMontant[IntGI] = 0 THEN
                                DecGpourcent[IntGI] := 0
                            ELSE
                                DecGpourcent[IntGI] := (DecGMarge[IntGI] / DecGMontant[IntGI]) * 100;
                        END;
                    END;

                    IF DecGMontant[4] = 0 THEN
                        DecGVar := 0
                    ELSE
                        DecGVar := ((DecGMontant[3] - DecGMontant[4]) / DecGMontant[4]) * 100;

                    IF DecGMarge[4] = 0 THEN
                        DecGvarmarge := 0
                    ELSE
                        DecGvarmarge := ((DecGMarge[3] - DecGMarge[4]) / DecGMarge[4]) * 100;

                    CodGCodeclt := CustLedgEntry."Customer No.";
                    CodGSalesperson := CustLedgEntry."Salesperson Code";

                END
                ELSE
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Customer No.");
                CurrReport.CREATETOTALS(
                  DecGMontant[1], DecGMarge[1], DecGMontant[2], DecGMarge[2], DecGMontant[3], DecGMarge[3], DecGMontant[4], DecGMarge[4]);

                CodGSalesperson := '';

                CustLedgEntry.SETRANGE("Posting Date", DatGDebut[4], DatGFin[1]);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF (CustLedgEntry.GETFILTER("Posting Date") <> '') THEN BEGIN
            DatGDebut[1] := CustLedgEntry.GETRANGEMIN("Posting Date");
            DatGFin[1] := CustLedgEntry.GETRANGEMAX("Posting Date");
        END
        ELSE BEGIN
            DatGDebut[1] := CALCDATE('<-CM>', WORKDATE());
            DatGFin[1] := CALCDATE('<CM>', DatGDebut[1]);
        END;

        DatGDebut[2] := CALCDATE('<-1M>', DatGDebut[1]);
        DatGFin[2] := CALCDATE('<-1M>', DatGFin[1]);

        DatGDebut[3] := CALCDATE('<-CY>', DatGDebut[1]);
        DatGFin[3] := DatGFin[1];

        DatGDebut[4] := CALCDATE('<-1Y>', DatGDebut[3]);
        DatGFin[4] := CALCDATE('<-1Y>', DatGFin[1]);
    end;

    var
        RecGCustEntry: Record "Cust. Ledger Entry";
        RecGSalesperson: Record "Salesperson/Purchaser";
        CodGSalesperson: Code[10];
        CodGCodeclt: Code[20];
        DatGDebut: array[4] of Date;
        DatGFin: array[4] of Date;
        DecGMarge: array[4] of Decimal;
        DecGMontant: array[4] of Decimal;
        DecGPMargCum: Decimal;
        DecGPMargNCum: Decimal;
        DecGPMargPer: Decimal;
        DecGpourcent: array[4] of Decimal;
        DecGPVarCA: Decimal;
        DecGPVarMarge: Decimal;
        DecGVar: Decimal;
        DecGvarmarge: Decimal;
        IntGI: Integer;
        LastFieldNo: Integer;
        "CA_CumuléCaptionLbl": Label 'CA Cumulé';
        "CA_N_1_CumuléCaptionLbl": Label 'CA N-1 Cumulé';
        CA_periodeCaptionLbl: Label 'CA periode';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_codeCaptionLbl: Label 'Customer code', comment = 'FRA="Code Client"';
        Customer_NameCaptionLbl: Label 'Customer Name', comment = 'FRA="Nom du client"';
        "marge_cumuléeCaption_Control1000000085Lbl": Label '% marge cumulée';
        "Marge_cumuléeCaptionLbl": Label 'Marge cumulée';
        "marge_N_1_CumuléCaption_Control1000000091Lbl": Label '% marge N-1 Cumulé';
        "Marge_N_1_CumuléCaptionLbl": Label 'Marge N-1 Cumulé';
        "marge_périodeCaptionLbl": Label '% marge période';
        "Montant_marge_périodeCaptionLbl": Label 'Montant marge période';
        "Sales_périod_N_1CaptionLbl": Label 'Sales périod N-1';
        Sales_statisticsCaptionLbl: Label 'Sales statistics', comment = 'FRA="Statistiques ventes"';
        text001: Label 'Période :%1 au %2';
        Total_VendeurCaptionLbl: Label 'Total Vendeur';
        TotalCaptionLbl: Label 'Total';
        Variation_CACaption_Control1000000094Lbl: Label 'Variation CA';
        variation_CACaptionLbl: Label '% variation CA';
        variation_margeCaptionLbl: Label '% variation marge';
        VendeurCaptionLbl: Label ' Vendeur';
        TxtGClient: Text[50];
        TxtGSalesPerson: Text[50];
}

