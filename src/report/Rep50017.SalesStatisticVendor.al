report 50017 "BC6_Sales Statistic/Vendor"
{
    ApplicationArea = all;
    Caption = 'Sales Statistic/Vendor', Comment = 'FRA="Statistique vente/fournisseur"';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesStatisticVendor.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
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
            column(DatGDateDebut; DatGDateDebut)
            {
            }
            column(DatDateFinF; DatDateFin)
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
                RecLPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
                RecLPurchCrMemoLine: Record "Purch. Cr. Memo Line";
                RecLPurchInvHeader: Record "Purch. Inv. Header";
                RecLPurchInvLine: Record "Purch. Inv. Line";
                RecLPurchLine: Record "Purchase Line";
                RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                RecLSalesCrMemoLine: Record "Sales Cr.Memo Line";
                RecLSalesInvHeader: Record "Sales Invoice Header";
                RecLSalesInvLine: Record "Sales Invoice Line";
            begin
                // Init Var
                DecGCAVente := 0;
                DecGMontant := 0;
                DecGMontantMarge := 0;
                DecGPourcentMarge := 0;
                DecGCAAchat := 0;
                DecGCAAchatEnCmd := 0;

                // Sales Invoice Line
                RecLSalesInvLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                RecLSalesInvLine.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLSalesInvLine.FindSet() THEN
                    REPEAT
                        RecLSalesInvHeader.SETFILTER("No.", RecLSalesInvLine."Document No.");
                        IF RecLSalesInvHeader.FindFirst() THEN BEGIN
                            DecGMontant += RecLSalesInvLine.Quantity * RecLSalesInvLine."BC6_Purchase Cost";
                            DecGCAVente += RecLSalesInvLine.Amount;
                        END;
                    UNTIL RecLSalesInvLine.NEXT() = 0;

                // Sales Credit Memo Line
                RecLSalesCrMemoLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                RecLSalesCrMemoLine.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLSalesCrMemoLine.FindSet() THEN
                    REPEAT
                        RecLSalesCrMemoHeader.SETFILTER("No.", RecLSalesCrMemoLine."Document No.");
                        IF RecLSalesCrMemoHeader.FindFirst() THEN BEGIN
                            DecGMontant -= (RecLSalesCrMemoLine.Quantity * RecLSalesCrMemoLine."BC6_Purchase cost");
                            DecGCAVente -= RecLSalesCrMemoLine.Amount;
                        END;
                    UNTIL RecLSalesCrMemoLine.NEXT() = 0;

                // Purchase Line
                RecLPurchLine.SETCURRENTKEY("Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date");
                RecLPurchLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                RecLPurchLine.SETRANGE("Document Type", RecLPurchLine."Document Type"::Order);
                RecLPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchLine.Find() THEN
                    REPEAT
                        DecGCAAchatEnCmd := DecGCAAchatEnCmd + (RecLPurchLine.Quantity - RecLPurchLine."Quantity Invoiced")
                                            * RecLPurchLine."Direct Unit Cost"
                                            * (1 - RecLPurchLine."Line Discount %" / 100);
                    UNTIL RecLPurchLine.NEXT() = 0;

                // Purchase Invoice Line
                RecLPurchInvLine.SETCURRENTKEY("Buy-from Vendor No.", RecLPurchInvLine.Type);
                RecLPurchInvLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchInvLine.SETRANGE(Type, RecLPurchInvLine.Type::Item);
                RecLPurchInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchInvLine.Find() THEN
                    REPEAT
                        RecLPurchInvHeader.SETRANGE("No.", RecLPurchInvLine."Document No.");
                        IF RecLPurchInvHeader.FindFirst() THEN
                            DecGCAAchat += RecLPurchInvLine.Amount;
                    UNTIL RecLPurchInvLine.NEXT() = 0;

                // Purchase Credit Memo Line
                RecLPurchCrMemoLine.SETCURRENTKEY("Buy-from Vendor No.", Type);
                RecLPurchCrMemoLine.SETRANGE("Buy-from Vendor No.", "No.");
                RecLPurchCrMemoLine.SETRANGE(Type, RecLPurchCrMemoLine.Type::Item);
                RecLPurchCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecLPurchCrMemoLine.Find() THEN
                    REPEAT
                        RecLPurchCrMemoHeader.SETFILTER("No.", RecLPurchCrMemoLine."Document No.");
                        IF RecLPurchCrMemoHeader.FindFirst() THEN
                            DecGCAAchat -= RecLPurchCrMemoLine.Amount;
                    UNTIL RecLPurchCrMemoLine.NEXT() = 0;

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
                    field(DatGDateDebutF; DatGDateDebut)
                    {
                        ApplicationArea = All;
                        Caption = 'Date début';
                    }
                    field(DatDateFinF; DatDateFin)
                    {
                        ApplicationArea = All;
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
        DatGDateDebut := CALCDATE('<-CM>', TODAY);
        DatDateFin := CALCDATE('<CM>', TODAY);
    end;

    var
        DatDateFin: Date;
        DatGDateDebut: Date;
        DecGCAAchat: Decimal;
        DecGCAAchatEnCmd: Decimal;
        DecGCAVente: Decimal;
        DecGMontant: Decimal;
        DecGMontantMarge: Decimal;
        DecGPourcentMarge: Decimal;
        AuCaptionLbl: Label 'Au';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Invoiced_Purchase_Turnover_CaptionLbl: Label 'Invoiced Purchase Turnover ', comment = 'FRA="CA Achat Facturé"';
        margeCaptionLbl: Label '% Profit', comment = 'FRA="% de marge sur vente"';
        Periode__FromCaptionLbl: Label 'Periode :From', comment = 'FRA="Période : Du"';
        Profit_AmountCaptionLbl: Label 'Profit Amount', comment = 'FRA="Montant Marge"';
        Puchase_Turnover_in_Vendor_OrderCaptionLbl: Label 'Puchase Turnover in Vendor Order', comment = 'FRA="CA achat en cde fournisseur"';
        Purchase_Amount_per_Costumer_OrderCaptionLbl: Label 'Purchase Amount per Costumer Order', comment = 'FRA="Montant Achat sur cde client"';
        Sale_TurnoverCaptionLbl: Label 'Sale Turnover', comment = 'FRA="CA Vente"';
        Statistics_Sales_by_VendorCaptionLbl: Label 'Statistics Sales by Vendor', comment = 'FRA="Statistiques ventes par fournisseur"';
        TotalCaptionLbl: Label 'Total', comment = 'FRA="Total"';
}
