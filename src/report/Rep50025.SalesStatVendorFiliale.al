report 50025 "BC6_Sales Stat/Vendor Filiale"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesStatisticVendorFiliale.rdl';

    Caption = 'Sales Statistic/Vendor', comment = 'FRA="Statistique vente/fournisseur"';

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
            column(DatGDateDebut; GDateDebut)
            {
            }
            column(DatDateFin; DateFin)
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
                TempRecGSalesInvLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                TempRecGSalesInvLine.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesInvHeader.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
                IF TempRecGSalesInvLine.FindSet() THEN BEGIN
                    REPEAT
                        RecLSalesInvHeader.SETFILTER("No.", TempRecGSalesInvLine."Document No.");
                        IF RecLSalesInvHeader.FindSet() THEN BEGIN
                            DecGMontant += TempRecGSalesInvLine.Quantity * TempRecGSalesInvLine."BC6_Purchase Cost";
                            DecGCAVente += TempRecGSalesInvLine.Amount;
                        END;
                    UNTIL TempRecGSalesInvLine.NEXT() = 0;
                END;

                // Sales Credit Memo Line
                TempRecGSalesCrMemoLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                TempRecGSalesCrMemoLine.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
                IF TempRecGSalesCrMemoLine.FindSet() THEN BEGIN
                    REPEAT
                        RecLSalesCrMemoHeader.SETFILTER("No.", TempRecGSalesCrMemoLine."Document No.");
                        IF RecLSalesCrMemoHeader.FIND('-') THEN BEGIN
                            DecGMontant -= (TempRecGSalesCrMemoLine.Quantity * TempRecGSalesCrMemoLine."BC6_Purchase cost");
                            DecGCAVente -= TempRecGSalesCrMemoLine.Amount;
                        END;
                    UNTIL TempRecGSalesCrMemoLine.NEXT() = 0;
                END;


                // Purchase Line
                TempRecGPurchLine.SETCURRENTKEY("Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date");
                TempRecGPurchLine.SETRANGE("Buy-from Vendor No.", "No.");
                TempRecGPurchLine.SETRANGE(Type, TempRecGPurchLine.Type::Item);
                TempRecGPurchLine.SETRANGE("Document Type", TempRecGPurchLine."Document Type"::Order);
                TempRecGPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', GDateDebut, DateFin);
                IF TempRecGPurchLine.FindSet() THEN BEGIN
                    REPEAT
                        DecGCAAchatEnCmd := DecGCAAchatEnCmd + (TempRecGPurchLine.Quantity - TempRecGPurchLine."Quantity Invoiced")
                                            * TempRecGPurchLine."Direct Unit Cost"
                                            * (1 - TempRecGPurchLine."Line Discount %" / 100);
                    UNTIL TempRecGPurchLine.NEXT() = 0;
                END;

                // Purchase Invoice Line
                TempRecGPurchInvLine.SETCURRENTKEY("Buy-from Vendor No.", TempRecGPurchInvLine.Type);
                TempRecGPurchInvLine.SETRANGE("Buy-from Vendor No.", "No.");
                TempRecGPurchInvLine.SETRANGE(Type, TempRecGPurchInvLine.Type::Item);
                RecLPurchInvHeader.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
                IF TempRecGPurchInvLine.FindSet() THEN BEGIN
                    REPEAT
                        RecLPurchInvHeader.SETFILTER("No.", TempRecGPurchInvLine."Document No.");
                        IF RecLPurchInvHeader.FindSet() THEN
                            DecGCAAchat += TempRecGPurchInvLine.Amount;
                    UNTIL TempRecGPurchInvLine.NEXT() = 0;
                END;

                // Purchase Credit Memo Line
                TempRecGPurchCrMemoLine.SETCURRENTKEY("Buy-from Vendor No.", Type);
                TempRecGPurchCrMemoLine.SETRANGE("Buy-from Vendor No.", "No.");
                TempRecGPurchCrMemoLine.SETRANGE(Type, TempRecGPurchCrMemoLine.Type::Item);
                RecLPurchCrMemoHeader.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
                IF TempRecGPurchCrMemoLine.FindSet() THEN BEGIN
                    REPEAT
                        RecLPurchCrMemoHeader.SETFILTER("No.", TempRecGPurchCrMemoLine."Document No.");
                        IF RecLPurchCrMemoHeader.FindSet() THEN
                            DecGCAAchat -= TempRecGPurchCrMemoLine.Amount;
                    UNTIL TempRecGPurchCrMemoLine.NEXT() = 0;
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
                    field(DatGDateDebut; GDateDebut)
                    {
                        Caption = 'Date début';
                    }
                    field(DatDateFin; DateFin)
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
        GDateDebut := CALCDATE('<-CM>', TODAY);
        DateFin := CALCDATE('<CM>', TODAY);

        Vendor.CHANGECOMPANY('CNE 2007');
    end;

    trigger OnPreReport()
    begin
        RecGSalesInvLine.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
        IF RecGSalesInvLine.FIND('-') THEN
            REPEAT
                TempRecGSalesInvLine := RecGSalesInvLine;
                IF RecGitem.GET(TempRecGSalesInvLine."No.") THEN BEGIN
                    TempRecGSalesInvLine."BC6_Buy-from Vendor No." := RecGitem."Vendor No.";
                    TempRecGSalesInvLine.INSERT();
                END;
            UNTIL RecGSalesInvLine.NEXT() <= 0;

        RecGSalesCrMemoLine.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
        IF RecGSalesCrMemoLine.FindSet() THEN
            REPEAT
                TempRecGSalesCrMemoLine := RecGSalesCrMemoLine;
                IF RecGitem.GET(TempRecGSalesCrMemoLine."No.") THEN BEGIN
                    TempRecGSalesCrMemoLine."BC6_Buy-from Vendor No." := RecGitem."Vendor No.";
                    TempRecGSalesCrMemoLine.INSERT();
                END;
            UNTIL RecGSalesCrMemoLine.NEXT() <= 0;


        RecGPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', GDateDebut, DateFin);
        IF RecGPurchLine.FindSet() THEN
            REPEAT
                TempRecGPurchLine := RecGPurchLine;
                IF RecGitem.GET(TempRecGPurchLine."No.") THEN BEGIN
                    TempRecGPurchLine."Buy-from Vendor No." := RecGitem."Vendor No.";
                    TempRecGPurchLine.INSERT();
                END;
            UNTIL RecGPurchLine.NEXT() <= 0;

        RecGPurchInvLine.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
        IF RecGPurchInvLine.FindSet() THEN
            REPEAT
                TempRecGPurchInvLine := RecGPurchInvLine;
                IF RecGitem.GET(TempRecGPurchInvLine."No.") THEN BEGIN
                    TempRecGPurchInvLine."Buy-from Vendor No." := RecGitem."Vendor No.";
                    TempRecGPurchInvLine.INSERT();
                END;
            UNTIL RecGPurchInvLine.NEXT() <= 0;

        RecGPurchCrMemoLine.SETFILTER("Posting Date", '%1..%2', GDateDebut, DateFin);
        IF RecGPurchCrMemoLine.FindSet() THEN
            REPEAT
                TempRecGPurchCrMemoLine := RecGPurchCrMemoLine;
                IF RecGitem.GET(TempRecGPurchCrMemoLine."No.") THEN BEGIN
                    TempRecGPurchCrMemoLine."Buy-from Vendor No." := RecGitem."Vendor No.";
                    TempRecGPurchCrMemoLine.INSERT();
                END;
            UNTIL RecGPurchCrMemoLine.NEXT() <= 0;
    end;

    var
        RecGitem: Record Item;
        RecGPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        TempRecGPurchCrMemoLine: Record "Purch. Cr. Memo Line" temporary;
        RecGPurchInvLine: Record "Purch. Inv. Line";
        TempRecGPurchInvLine: Record "Purch. Inv. Line" temporary;
        RecGPurchLine: Record "Purchase Line";
        TempRecGPurchLine: Record "Purchase Line" temporary;
        RecGSalesCrMemoLine: Record "Sales Cr.Memo Line";
        TempRecGSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        RecGSalesInvLine: Record "Sales Invoice Line";
        TempRecGSalesInvLine: Record "Sales Invoice Line" temporary;
        DateFin: Date;
        GDateDebut: Date;
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
        TotalCaptionLbl: Label 'Total';
}

