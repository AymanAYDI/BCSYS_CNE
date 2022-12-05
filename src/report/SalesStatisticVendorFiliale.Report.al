report 50025 "Sales Statistic/Vendor Filiale"
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
    RDLCLayout = './SalesStatisticVendorFiliale.rdlc';

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
                RecGSalesInvLineTEMP.SETCURRENTKEY("Buy-from Vendor No.");
                RecGSalesInvLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecLSalesInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGSalesInvLineTEMP.FIND('-') THEN BEGIN
                    REPEAT
                        RecLSalesInvHeader.SETFILTER("No.", RecGSalesInvLineTEMP."Document No.");
                        IF RecLSalesInvHeader.FIND('-') THEN BEGIN
                            DecGMontant += RecGSalesInvLineTEMP.Quantity * RecGSalesInvLineTEMP."Purchase Cost";
                            DecGCAVente += RecGSalesInvLineTEMP.Amount;
                        END;
                    UNTIL RecGSalesInvLineTEMP.NEXT = 0;
                END;

                // Sales Credit Memo Line
                RecGSalesCrMemoLineTEMP.SETCURRENTKEY("Buy-from Vendor No.");
                RecGSalesCrMemoLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecLSalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGSalesCrMemoLineTEMP.FIND('-') THEN BEGIN
                    REPEAT
                        RecLSalesCrMemoHeader.SETFILTER("No.", RecGSalesCrMemoLineTEMP."Document No.");
                        //>>FEP-ADVE-200706_18_E.002
                        //IF RecLSalesCrMemoHeader.FIND('-') THEN
                        IF RecLSalesCrMemoHeader.FIND('-') THEN BEGIN
                            DecGMontant -= (RecGSalesCrMemoLineTEMP.Quantity * RecGSalesCrMemoLineTEMP."Purchase cost");
                            //<<FEP-ADVE-200706_18_E.002
                            DecGCAVente -= RecGSalesCrMemoLineTEMP.Amount;
                            //>>FEP-ADVE-200706_18_E.002
                        END;
                        //<<FEP-ADVE-200706_18_E.002
                    UNTIL RecGSalesCrMemoLineTEMP.NEXT = 0;
                END;


                // Purchase Line
                RecGPurchLineTEMP.SETCURRENTKEY("Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date");
                RecGPurchLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecGPurchLineTEMP.SETRANGE(Type, RecGPurchLineTEMP.Type::Item);
                RecGPurchLineTEMP.SETRANGE("Document Type", RecGPurchLineTEMP."Document Type"::Order);
                RecGPurchLineTEMP.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGPurchLineTEMP.FIND('-') THEN BEGIN
                    REPEAT
                        DecGCAAchatEnCmd := DecGCAAchatEnCmd + (RecGPurchLineTEMP.Quantity - RecGPurchLineTEMP."Quantity Invoiced")
                                            * RecGPurchLineTEMP."Direct Unit Cost"
                                            * (1 - RecGPurchLineTEMP."Line Discount %" / 100);
                    UNTIL RecGPurchLineTEMP.NEXT = 0;
                END;

                // Purchase Invoice Line
                RecGPurchInvLineTEMP.SETCURRENTKEY("Buy-from Vendor No.", RecGPurchInvLineTEMP.Type);
                RecGPurchInvLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecGPurchInvLineTEMP.SETRANGE(Type, RecGPurchInvLineTEMP.Type::Item);
                RecLPurchInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGPurchInvLineTEMP.FIND('-') THEN BEGIN
                    REPEAT
                        RecLPurchInvHeader.SETFILTER("No.", RecGPurchInvLineTEMP."Document No.");
                        IF RecLPurchInvHeader.FIND('-') THEN
                            DecGCAAchat += RecGPurchInvLineTEMP.Amount;
                    UNTIL RecGPurchInvLineTEMP.NEXT = 0;
                END;

                // Purchase Credit Memo Line
                RecGPurchCrMemoLineTEMP.SETCURRENTKEY("Buy-from Vendor No.", Type);
                RecGPurchCrMemoLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecGPurchCrMemoLineTEMP.SETRANGE(Type, RecGPurchCrMemoLineTEMP.Type::Item);
                RecLPurchCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGPurchCrMemoLineTEMP.FIND('-') THEN BEGIN
                    REPEAT
                        RecLPurchCrMemoHeader.SETFILTER("No.", RecGPurchCrMemoLineTEMP."Document No.");
                        IF RecLPurchCrMemoHeader.FIND('-') THEN
                            DecGCAAchat -= RecGPurchCrMemoLineTEMP.Amount;
                    UNTIL RecGPurchCrMemoLineTEMP.NEXT = 0;
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

        //>>CNEIC : le 07/2015
        Vendor.CHANGECOMPANY('CNE 2007');
        //<<CNEIC : le 07/2015
    end;

    trigger OnPreReport()
    begin
        //>>CNEIC : le 07/2015
        // Passage des lignes dans les fichier TEMP
        RecGSalesInvLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGSalesInvLine.FIND('-') THEN
            REPEAT
                RecGSalesInvLineTEMP := RecGSalesInvLine;
                IF RecGitem.GET(RecGSalesInvLineTEMP."No.") THEN BEGIN
                    RecGSalesInvLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGSalesInvLineTEMP.INSERT;
                END;
            UNTIL RecGSalesInvLine.NEXT <= 0;

        RecGSalesCrMemoLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGSalesCrMemoLine.FIND('-') THEN
            REPEAT
                RecGSalesCrMemoLineTEMP := RecGSalesCrMemoLine;
                IF RecGitem.GET(RecGSalesCrMemoLineTEMP."No.") THEN BEGIN
                    RecGSalesCrMemoLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGSalesCrMemoLineTEMP.INSERT;
                END;
            UNTIL RecGSalesCrMemoLine.NEXT <= 0;


        RecGPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchLine.FIND('-') THEN
            REPEAT
                RecGPurchLineTEMP := RecGPurchLine;
                IF RecGitem.GET(RecGPurchLineTEMP."No.") THEN BEGIN
                    RecGPurchLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchLineTEMP.INSERT;
                END;
            UNTIL RecGPurchLine.NEXT <= 0;

        RecGPurchInvLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchInvLine.FIND('-') THEN
            REPEAT
                RecGPurchInvLineTEMP := RecGPurchInvLine;
                IF RecGitem.GET(RecGPurchInvLineTEMP."No.") THEN BEGIN
                    RecGPurchInvLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchInvLineTEMP.INSERT;
                END;
            UNTIL RecGPurchInvLine.NEXT <= 0;

        RecGPurchCrMemoLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchCrMemoLine.FIND('-') THEN
            REPEAT
                RecGPurchCrMemoLineTEMP := RecGPurchCrMemoLine;
                IF RecGitem.GET(RecGPurchCrMemoLineTEMP."No.") THEN BEGIN
                    RecGPurchCrMemoLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchCrMemoLineTEMP.INSERT;
                END;
            UNTIL RecGPurchCrMemoLine.NEXT <= 0;
        //<<CNEIC : le 07/2015
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
        RecGSalesInvLine: Record "113";
        RecGSalesCrMemoLine: Record "115";
        RecGPurchInvLine: Record "123";
        RecGPurchCrMemoLine: Record "125";
        RecGPurchLine: Record "39";
        RecGSalesInvLineTEMP: Record "113" temporary;
        RecGSalesCrMemoLineTEMP: Record "115" temporary;
        RecGPurchInvLineTEMP: Record "123" temporary;
        RecGPurchCrMemoLineTEMP: Record "125" temporary;
        RecGPurchLineTEMP: Record "39" temporary;
        RecGitem: Record "27";
}

