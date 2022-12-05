report 50017 "Sales Statistic/Vendor"
{
    // --------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // --------------------------------------------------------------------------
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_E.001:LY 15/02/2008 : Move code to standard indentation
    // FEP-ADVE-200706_18_E.002:LY 19/02/2008 : Calc. CA from Sales Credit Memo
    // 
    // --------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './SalesStatisticVendor.rdlc';

    Caption = 'Sales Statistic/Vendor';

    dataset
    {
        dataitem(DataItem3182; Table23)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(DatGDateDebut; DatGDateDebut)
            {
            }
            column(DatDateFin; DatDateFin)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(DecGCAVente; DecGCAVente)
            {
            }
            column(DecGMontantMarge; DecGMontantMarge)
            {
            }
            column(DecGPourcentMarge; DecGPourcentMarge)
            {
            }
            column(DecGCAAchat; DecGCAAchat)
            {
            }
            column(DecGMontant; DecGMontant)
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(DecGCAAchatEnCmd; DecGCAAchatEnCmd)
            {
            }
            column(DecGCAVente_Control1000000008; DecGCAVente)
            {
            }
            column(DecGMontant_Control1000000021; DecGMontant)
            {
            }
            column(DecGMontantMarge_Control1000000022; DecGMontantMarge)
            {
            }
            column(DecGPourcentMarge_Control1000000023; DecGPourcentMarge)
            {
            }
            column(DecGCAAchat_Control1000000024; DecGCAAchat)
            {
            }
            column(DecGCAAchatEnCmd_Control1000000028; DecGCAAchatEnCmd)
            {
            }
            column(Statistics_Sales_by_VendorCaption; Statistics_Sales_by_VendorCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Periode__FromCaption; Periode__FromCaptionLbl)
            {
            }
            column(AuCaption; AuCaptionLbl)
            {
            }
            column(Vendor__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Invoiced_Purchase_Turnover_Caption; Invoiced_Purchase_Turnover_CaptionLbl)
            {
            }
            column(margeCaption; margeCaptionLbl)
            {
            }
            column(Sale_TurnoverCaption; Sale_TurnoverCaptionLbl)
            {
            }
            column(Profit_AmountCaption; Profit_AmountCaptionLbl)
            {
            }
            column(Vendor_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Purchase_Amount_per_Costumer_OrderCaption; Purchase_Amount_per_Costumer_OrderCaptionLbl)
            {
            }
            column(Puchase_Turnover_in_Vendor_OrderCaption; Puchase_Turnover_in_Vendor_OrderCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                RecLSalesInvLine: Record "113";
                RecLSalesCrMemoLine: Record "115";
                RecLPurchInvLine: Record "123";
                RecLPurchCrMemoLine: Record "125";
                RecLPurchLine: Record "39";
                RecLSalesInvHeader: Record "112";
                RecLPurchInvHeader: Record "122";
                RecLSalesCrMemoHeader: Record "114";
                RecLPurchCrMemoHeader: Record "124";
            begin
                // Init Var
                DecGCAVente := 0;
                DecGMontant := 0;
                DecGMontantMarge := 0;
                DecGPourcentMarge := 0;
                DecGCAAchat := 0;
                DecGCAAchatEnCmd := 0;

                // Sales Invoice Line
                RecLSalesInvLine.SETCURRENTKEY("Buy-from Vendor No.");
                RecLSalesInvLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLSalesInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLSalesInvLine.FIND('-') THEN BEGIN
                    REPEAT
                        RecLSalesInvHeader.SETFILTER("No.", RecLSalesInvLine."Document No.");
                        IF RecLSalesInvHeader.FIND('-') THEN BEGIN
                            DecGMontant += RecLSalesInvLine.Quantity * RecLSalesInvLine."Purchase Cost";
                            DecGCAVente += RecLSalesInvLine.Amount;
                        END;
                    UNTIL RecLSalesInvLine.NEXT = 0;
                END;

                // Sales Credit Memo Line
                RecLSalesCrMemoLine.SETCURRENTKEY("Buy-from Vendor No.");
                RecLSalesCrMemoLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLSalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLSalesCrMemoLine.FIND('-') THEN BEGIN
                    REPEAT
                        RecLSalesCrMemoHeader.SETFILTER("No.", RecLSalesCrMemoLine."Document No.");
                        //>>FEP-ADVE-200706_18_E.002
                        //IF RecLSalesCrMemoHeader.FIND('-') THEN
                        IF RecLSalesCrMemoHeader.FIND('-') THEN BEGIN
                            DecGMontant -= (RecLSalesCrMemoLine.Quantity * RecLSalesCrMemoLine."Purchase cost");
                            //<<FEP-ADVE-200706_18_E.002
                            DecGCAVente -= RecLSalesCrMemoLine.Amount;
                            //>>FEP-ADVE-200706_18_E.002
                        END;
                        //<<FEP-ADVE-200706_18_E.002
                    UNTIL RecLSalesCrMemoLine.NEXT = 0;
                END;


                // Purchase Line
                RecLPurchLine.SETCURRENTKEY("Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date");
                RecLPurchLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                RecLPurchLine.SETRANGE("Document Type", RecLPurchLine."Document Type"::Order);
                RecLPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchLine.FIND('-') THEN BEGIN
                    REPEAT
                        DecGCAAchatEnCmd := DecGCAAchatEnCmd + (RecLPurchLine.Quantity - RecLPurchLine."Quantity Invoiced")
                                            * RecLPurchLine."Direct Unit Cost"
                                            * (1 - RecLPurchLine."Line Discount %" / 100);
                    UNTIL RecLPurchLine.NEXT = 0;
                END;

                // Purchase Invoice Line
                RecLPurchInvLine.SETCURRENTKEY("Buy-from Vendor No.", RecLPurchInvLine.Type);
                RecLPurchInvLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchInvLine.SETRANGE(Type, RecLPurchInvLine.Type::Item);
                RecLPurchInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchInvLine.FIND('-') THEN BEGIN
                    REPEAT
                        //BCSYS - MM - 05/11/18 >>
                        //RecLPurchInvHeader.SETFILTER("No.",RecLPurchInvLine."Document No.");
                        RecLPurchInvHeader.SETRANGE("No.", RecLPurchInvLine."Document No.");
                        //BCSYS - MM <<
                        IF RecLPurchInvHeader.FIND('-') THEN
                            DecGCAAchat += RecLPurchInvLine.Amount;
                    UNTIL RecLPurchInvLine.NEXT = 0;
                END;

                // Purchase Credit Memo Line
                RecLPurchCrMemoLine.SETCURRENTKEY("Buy-from Vendor No.", Type);
                RecLPurchCrMemoLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchCrMemoLine.SETRANGE(Type, RecLPurchCrMemoLine.Type::Item);
                RecLPurchCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchCrMemoLine.FIND('-') THEN BEGIN
                    REPEAT
                        RecLPurchCrMemoHeader.SETFILTER("No.", RecLPurchCrMemoLine."Document No.");
                        IF RecLPurchCrMemoHeader.FIND('-') THEN
                            DecGCAAchat -= RecLPurchCrMemoLine.Amount;
                    UNTIL RecLPurchCrMemoLine.NEXT = 0;
                END;

                DecGMontantMarge := DecGCAVente - DecGMontant;
                IF DecGCAVente <> 0 THEN
                    DecGPourcentMarge := (DecGMontantMarge / DecGCAVente) * 100;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(DecGCAVente, DecGMontant, DecGMontantMarge, DecGPourcentMarge, DecGCAAchat, DecGCAAchatEnCmd);
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
                    field(DatGDateDebut; DatGDateDebut)
                    {
                        Caption = 'Date début';
                    }
                    field(DatDateFin; DatDateFin)
                    {
                        Caption = 'Date fin';
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
        //EVALUATE(DatGDateDebut,'01/'+FORMAT(DATE2DMY(TODAY,2))+'/'+FORMAT(DATE2DMY(TODAY,3)));
        //DatDateFin := CALCDATE('1M-1J',DatGDateDebut);
        DatGDateDebut := CALCDATE('<-CM>', TODAY);
        DatDateFin := CALCDATE('<CM>', TODAY);
    end;

    var
        DatGDateDebut: Date;
        DatDateFin: Date;
        DecGCAVente: Decimal;
        DecGMontant: Decimal;
        DecGMontantMarge: Decimal;
        DecGPourcentMarge: Decimal;
        DecGCAAchat: Decimal;
        DecGCAAchatEnCmd: Decimal;
        Statistics_Sales_by_VendorCaptionLbl: Label 'Statistics Sales by Vendor';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Periode__FromCaptionLbl: Label 'Periode :From';
        AuCaptionLbl: Label 'Au';
        Invoiced_Purchase_Turnover_CaptionLbl: Label 'Invoiced Purchase Turnover ';
        margeCaptionLbl: Label '% Profit';
        Sale_TurnoverCaptionLbl: Label 'Sale Turnover';
        Profit_AmountCaptionLbl: Label 'Profit Amount';
        Purchase_Amount_per_Costumer_OrderCaptionLbl: Label 'Purchase Amount per Costumer Order';
        Puchase_Turnover_in_Vendor_OrderCaptionLbl: Label 'Puchase Turnover in Vendor Order';
        TotalCaptionLbl: Label 'Total';
}

