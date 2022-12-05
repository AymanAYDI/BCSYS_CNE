report 50018 "Sales Stat/Customer"
{
    // --------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // --------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_D:MA 11/11/2007 : statistique de vente par client
    //                                      - Report created
    // 
    // //>>CNE1.02
    // FEP-ADVE-200706_18_D:MA 10/12/2007 : statistique de vente par client
    //                                      -  ajout calcul  %variation marge
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_D.002:LY 17/01/2008 :
    //                                    - Moove code to standard indentation
    // 
    // FEP-ADVE-200706_18_D.003:LY 19/02/2008 :
    //                                    - remose salesPerson dataitem and refound code
    // 
    // FEP-ADVE-200706_18_D.004:LY 21/03/2008 :
    //                                    - Change 1st Group by Customer by Salesperson
    // 
    // //>> 21/01/2014 SU-DADE cf appel TI204250
    // //   enlarge TxtGClient 30=> 50
    // //<< 21/01/2014 SU-DADE cf appel TI204250
    // 
    // --------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './SalesStatCustomer.rdlc';

    Caption = 'Sales Stat/Customer';

    dataset
    {
        dataitem(DataItem8503; Table21)
        {
            DataItemTableView = SORTING (Salesperson Code, Customer No., Posting Date, Document Type)
                                WHERE (Document Type=FILTER(Invoice|Credit Memo));
            RequestFilterFields = "Customer No.","Posting Date","Salesperson Code";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(USERID;USERID)
            {
            }
            column(STRSUBSTNO_text001_DatGDebut_1__DatGFin_1__;STRSUBSTNO(text001,DatGDebut[1],DatGFin[1]))
            {
            }
            column(Cust__Ledger_Entry__Cust__Ledger_Entry___Salesperson_Code_;"Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(TxtGSalesPerson;TxtGSalesPerson)
            {
            }
            column(DecGMontant_1_;DecGMontant[1])
            {
            }
            column(Cust__Ledger_Entry__Customer_No__;"Customer No.")
            {
            }
            column(DecGMarge_4_;DecGMarge[4])
            {
            }
            column(DecGMontant_4_;DecGMontant[4])
            {
            }
            column(DecGMarge_3_;DecGMarge[3])
            {
            }
            column(DecGMontant_3_;DecGMontant[3])
            {
            }
            column(DecGpourcent_1_;DecGpourcent[1])
            {
            }
            column(DecGMontant_2_;DecGMontant[2])
            {
            }
            column(DecGpourcent_3_;DecGpourcent[3])
            {
            }
            column(DecGpourcent_4_;DecGpourcent[4])
            {
            }
            column(DecGMontant_3__DecGMontant_4_;DecGMontant[3]-DecGMontant[4])
            {
            }
            column(DecGVar;DecGVar)
            {
            }
            column(TxtGClient;TxtGClient)
            {
            }
            column(DecGvarmarge;DecGvarmarge)
            {
            }
            column(DecGMarge_1_;DecGMarge[1])
            {
            }
            column(DecGPVarCA;DecGPVarCA)
            {
            }
            column(DecGMontant_3__DecGMontant_4__Control1000000017;DecGMontant[3]-DecGMontant[4])
            {
            }
            column(DecGPMargNCum;DecGPMargNCum)
            {
            }
            column(DecGMarge_4__Control1000000021;DecGMarge[4])
            {
            }
            column(DecGMontant_4__Control1000000022;DecGMontant[4])
            {
            }
            column(DecGPMargPer;DecGPMargPer)
            {
            }
            column(DecGMarge_3__Control1000000024;DecGMarge[3])
            {
            }
            column(DecGMontant_3__Control1000000025;DecGMontant[3])
            {
            }
            column(DecGMontant_2__Control1000000026;DecGMontant[2])
            {
            }
            column(DecGPMargCum;DecGPMargCum)
            {
            }
            column(DecGMarge_1__Control1000000028;DecGMarge[1])
            {
            }
            column(DecGMontant_1__Control1000000029;DecGMontant[1])
            {
            }
            column(DecGPVarMarge;DecGPVarMarge)
            {
            }
            column(Cust__Ledger_Entry__Cust__Ledger_Entry___Salesperson_Code__Control1000000000;"Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(TxtGSalesPerson_Control1000000001;TxtGSalesPerson)
            {
            }
            column(DecGVar_Control1000000034;DecGVar)
            {
            }
            column(DecGMontant_3__DecGMontant_4__Control1000000035;DecGMontant[3]-DecGMontant[4])
            {
            }
            column(DecGpourcent_4__Control1000000036;DecGpourcent[4])
            {
            }
            column(DecGMarge_4__Control1000000037;DecGMarge[4])
            {
            }
            column(DecGMontant_4__Control1000000038;DecGMontant[4])
            {
            }
            column(DecGpourcent_1__Control1000000039;DecGpourcent[1])
            {
            }
            column(DecGMarge_3__Control1000000040;DecGMarge[3])
            {
            }
            column(DecGMontant_3__Control1000000042;DecGMontant[3])
            {
            }
            column(DecGMontant_2__Control1000000043;DecGMontant[2])
            {
            }
            column(DecGpourcent_3__Control1000000044;DecGpourcent[3])
            {
            }
            column(DecGMarge_1__Control1000000045;DecGMarge[1])
            {
            }
            column(DecGMontant_1__Control1000000046;DecGMontant[1])
            {
            }
            column(DecGvarmarge_Control1000000047;DecGvarmarge)
            {
            }
            column(Customer_codeCaption;Customer_codeCaptionLbl)
            {
            }
            column(Customer_NameCaption;Customer_NameCaptionLbl)
            {
            }
            column("Montant_marge_périodeCaption";Montant_marge_périodeCaptionLbl)
            {
            }
            column("marge_périodeCaption";marge_périodeCaptionLbl)
            {
            }
            column("Marge_cumuléeCaption";Marge_cumuléeCaptionLbl)
            {
            }
            column("marge_cumuléeCaption_Control1000000085";marge_cumuléeCaption_Control1000000085Lbl)
            {
            }
            column("Sales_périod_N_1Caption";Sales_périod_N_1CaptionLbl)
            {
            }
            column(CA_periodeCaption;CA_periodeCaptionLbl)
            {
            }
            column("CA_CumuléCaption";CA_CumuléCaptionLbl)
            {
            }
            column("CA_N_1_CumuléCaption";CA_N_1_CumuléCaptionLbl)
            {
            }
            column("Marge_N_1_CumuléCaption";Marge_N_1_CumuléCaptionLbl)
            {
            }
            column("marge_N_1_CumuléCaption_Control1000000091";marge_N_1_CumuléCaption_Control1000000091Lbl)
            {
            }
            column(variation_margeCaption;variation_margeCaptionLbl)
            {
            }
            column(variation_CACaption;variation_CACaptionLbl)
            {
            }
            column(Variation_CACaption_Control1000000094;Variation_CACaption_Control1000000094Lbl)
            {
            }
            column(Sales_statisticsCaption;Sales_statisticsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendeurCaption;VendeurCaptionLbl)
            {
            }
            column(Total_VendeurCaption;Total_VendeurCaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_;"Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                TxtGClient := "Cust. Ledger Entry".getCustomerName("Cust. Ledger Entry"."Customer No.");
                //>>MIGRATION NAV 2013
                  IF RecGSalesperson.GET("Cust. Ledger Entry"."Salesperson Code") THEN
                    TxtGSalesPerson := RecGSalesperson.Name
                  ELSE
                    CLEAR(TxtGSalesPerson);
                //<<MIGRATION NAV 2013

                //>>FEP-ADVE-200706_18_D
                //IF ("Cust. Ledger Entry"."Customer No." <> CodGCodeclt) THEN
                IF ("Cust. Ledger Entry"."Salesperson Code" <> CodGSalesperson)
                  OR ("Cust. Ledger Entry"."Customer No." <> CodGCodeclt) THEN
                //OR (CodGSalesperson ='') THEN
                //<<FEP-ADVE-200706_18_D

                BEGIN

                  RecGCustEntry.RESET;
                  RecGCustEntry.SETCURRENTKEY ("Salesperson Code","Customer No.","Posting Date","Document Type");
                  RecGCustEntry.SETFILTER("Customer No.","Cust. Ledger Entry"."Customer No.");
                  RecGCustEntry.SETFILTER("Salesperson Code",'%1',"Cust. Ledger Entry"."Salesperson Code");
                  RecGCustEntry.SETFILTER("Document Type",'2|3');

                  FOR IntGI := 1 TO 4 DO
                  BEGIN
                    DecGMontant[IntGI] := 0;
                    DecGMarge[IntGI]   := 0;
                    DecGpourcent[IntGI] := 0 ;
                    RecGCustEntry.SETRANGE(RecGCustEntry."Posting Date",DatGDebut[IntGI],DatGFin[IntGI]) ;

                    IF RecGCustEntry.FINDSET THEN
                    BEGIN
                      RecGCustEntry.CALCSUMS(RecGCustEntry."Sales (LCY)");
                      DecGMontant[IntGI] := RecGCustEntry."Sales (LCY)";
                      RecGCustEntry.CALCSUMS(RecGCustEntry."Profit (LCY)");
                      DecGMarge[IntGI] := RecGCustEntry."Profit (LCY)";

                      IF DecGMontant[IntGI] = 0  THEN
                        DecGpourcent[IntGI] := 0
                      ELSE
                        DecGpourcent[IntGI] := (DecGMarge[IntGI] / DecGMontant[IntGI]) * 100;
                    END;
                  END;

                  IF DecGMontant[4] = 0  THEN
                    DecGVar := 0
                  ELSE
                    DecGVar := ((DecGMontant[3] - DecGMontant[4]) / DecGMontant[4]) * 100;

                  //>>CNE1.02
                  IF DecGMarge[4] = 0  THEN
                    DecGvarmarge := 0
                  ELSE
                    DecGvarmarge := ((DecGMarge[3] - DecGMarge[4]) / DecGMarge[4]) * 100;

                  //>>FEP-ADVE-200706_18_D
                  CodGCodeclt:= "Cust. Ledger Entry"."Customer No.";
                  CodGSalesperson := "Cust. Ledger Entry"."Salesperson Code";
                  //<<FEP-ADVE-200706_18_D

                END
                  //<<CNE1.02
                ELSE
                  CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Customer No.");
                CurrReport.CREATETOTALS(
                  DecGMontant[1],DecGMarge[1], DecGMontant[2],DecGMarge[2], DecGMontant[3],DecGMarge[3], DecGMontant[4],DecGMarge[4]);

                //>>FEP-ADVE-200706_18_D
                //CodGCodeclt := '';
                CodGSalesperson := '';
                //<<FEP-ADVE-200706_18_D

                "Cust. Ledger Entry".SETRANGE("Posting Date",DatGDebut[4],DatGFin[1]);
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
        IF ("Cust. Ledger Entry".GETFILTER("Posting Date") <>'') THEN
        BEGIN
          DatGDebut[1]:=  "Cust. Ledger Entry".GETRANGEMIN("Posting Date");
          DatGFin[1]:=  "Cust. Ledger Entry".GETRANGEMAX("Posting Date");
        END
        ELSE
        BEGIN
          DatGDebut[1]:=CALCDATE('<-CM>',WORKDATE) ;
          DatGFin[1]:=CALCDATE('<CM>',DatGDebut[1]) ;
        END;

        DatGDebut[2]:= CALCDATE('<-1M>',DatGDebut[1]) ;
        DatGFin[2]:= CALCDATE('<-1M>',DatGFin[1]);

        DatGDebut[3]:=CALCDATE('<-CY>',DatGDebut[1]);
        DatGFin[3]:=DatGFin[1];

        DatGDebut[4]:= CALCDATE('<-1Y>',DatGDebut[3]);
        DatGFin[4]:=CALCDATE('<-1Y>',DatGFin[1]);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        "--fe--": Integer;
        RecGSalesperson: Record "13";
        RecGCustEntry: Record "21";
        DecGVar: Decimal;
        DecGpourcent: array [4] of Decimal;
        DecGvarmarge: Decimal;
        DecGMontant: array [4] of Decimal;
        DecGMarge: array [4] of Decimal;
        Dec: Decimal;
        DecGpourcent2: array [4] of Decimal;
        DecGPMargPer: Decimal;
        DecGPMargCum: Decimal;
        DecGPMargNCum: Decimal;
        DecGPVarCA: Decimal;
        DecGPVarMarge: Decimal;
        DecGVarCA: Decimal;
        DatGDebut: array [4] of Date;
        DatGFin: array [4] of Date;
        DatGdat: Date;
        IntGI: Integer;
        text001: Label 'Période :%1 au %2';
        CodGCodeclt: Code[20];
        CodGSalesperson: Code[10];
        TxtGSalesPerson: Text[50];
        TxtGClient: Text[50];
        Customer_codeCaptionLbl: Label 'Customer code';
        Customer_NameCaptionLbl: Label 'Customer Name';
        "Montant_marge_périodeCaptionLbl": Label 'Montant marge période';
        "marge_périodeCaptionLbl": Label '% marge période';
        "Marge_cumuléeCaptionLbl": Label 'Marge cumulée';
        "marge_cumuléeCaption_Control1000000085Lbl": Label '% marge cumulée';
        "Sales_périod_N_1CaptionLbl": Label 'Sales périod N-1';
        CA_periodeCaptionLbl: Label 'CA periode';
        "CA_CumuléCaptionLbl": Label 'CA Cumulé';
        "CA_N_1_CumuléCaptionLbl": Label 'CA N-1 Cumulé';
        "Marge_N_1_CumuléCaptionLbl": Label 'Marge N-1 Cumulé';
        "marge_N_1_CumuléCaption_Control1000000091Lbl": Label '% marge N-1 Cumulé';
        variation_margeCaptionLbl: Label '% variation marge';
        variation_CACaptionLbl: Label '% variation CA';
        Variation_CACaption_Control1000000094Lbl: Label 'Variation CA';
        Sales_statisticsCaptionLbl: Label 'Sales statistics';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        VendeurCaptionLbl: Label ' Vendeur';
        Total_VendeurCaptionLbl: Label 'Total Vendeur';
        TotalCaptionLbl: Label 'Total';
}

