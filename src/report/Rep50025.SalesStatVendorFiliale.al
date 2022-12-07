report 50025 "BC6_Sales Stat/Vendor Filiale"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesStatisticVendorFiliale.rdlc';

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
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("USERID"; USERID)
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
                RecGSalesInvLineTEMP.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                RecGSalesInvLineTEMP.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesInvHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGSalesInvLineTEMP.FindSet() THEN BEGIN
                    REPEAT
                        RecLSalesInvHeader.SETFILTER("No.", RecGSalesInvLineTEMP."Document No.");
                        IF RecLSalesInvHeader.FindSet() THEN BEGIN
                            DecGMontant += RecGSalesInvLineTEMP.Quantity * RecGSalesInvLineTEMP."BC6_Purchase Cost";
                            DecGCAVente += RecGSalesInvLineTEMP.Amount;
                        END;
                    UNTIL RecGSalesInvLineTEMP.NEXT = 0;
                END;

                // Sales Credit Memo Line
                RecGSalesCrMemoLineTEMP.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                RecGSalesCrMemoLineTEMP.SETRANGE("BC6_Buy-from Vendor No.", "No.");
                RecLSalesCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGSalesCrMemoLineTEMP.FindSet() THEN BEGIN
                    REPEAT
                        RecLSalesCrMemoHeader.SETFILTER("No.", RecGSalesCrMemoLineTEMP."Document No.");
                        IF RecLSalesCrMemoHeader.FIND('-') THEN BEGIN
                            DecGMontant -= (RecGSalesCrMemoLineTEMP.Quantity * RecGSalesCrMemoLineTEMP."BC6_Purchase cost");
                            DecGCAVente -= RecGSalesCrMemoLineTEMP.Amount;
                        END;
                    UNTIL RecGSalesCrMemoLineTEMP.NEXT = 0;
                END;


                // Purchase Line
                RecGPurchLineTEMP.SETCURRENTKEY("Buy-from Vendor No.", Type, "Document Type", "Planned Receipt Date");
                RecGPurchLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecGPurchLineTEMP.SETRANGE(Type, RecGPurchLineTEMP.Type::Item);
                RecGPurchLineTEMP.SETRANGE("Document Type", RecGPurchLineTEMP."Document Type"::Order);
                RecGPurchLineTEMP.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGPurchLineTEMP.FindSet() THEN BEGIN
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
                IF RecGPurchInvLineTEMP.FindSet() THEN BEGIN
                    REPEAT
                        RecLPurchInvHeader.SETFILTER("No.", RecGPurchInvLineTEMP."Document No.");
                        IF RecLPurchInvHeader.FindSet() THEN
                            DecGCAAchat += RecGPurchInvLineTEMP.Amount;
                    UNTIL RecGPurchInvLineTEMP.NEXT = 0;
                END;

                // Purchase Credit Memo Line
                RecGPurchCrMemoLineTEMP.SETCURRENTKEY("Buy-from Vendor No.", Type);
                RecGPurchCrMemoLineTEMP.SETRANGE("Buy-from Vendor No.", "No.");
                RecGPurchCrMemoLineTEMP.SETRANGE(Type, RecGPurchCrMemoLineTEMP.Type::Item);
                RecLPurchCrMemoHeader.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
                IF RecGPurchCrMemoLineTEMP.FindSet() THEN BEGIN
                    REPEAT
                        RecLPurchCrMemoHeader.SETFILTER("No.", RecGPurchCrMemoLineTEMP."Document No.");
                        IF RecLPurchCrMemoHeader.FindSet() THEN
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
        DatGDateDebut := CALCDATE('<-CM>', TODAY);
        DatDateFin := CALCDATE('<CM>', TODAY);

        Vendor.CHANGECOMPANY('CNE 2007');
    end;

    trigger OnPreReport()
    begin
        RecGSalesInvLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGSalesInvLine.FIND('-') THEN
            REPEAT
                RecGSalesInvLineTEMP := RecGSalesInvLine;
                IF RecGitem.GET(RecGSalesInvLineTEMP."No.") THEN BEGIN
                    RecGSalesInvLineTEMP."BC6_Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGSalesInvLineTEMP.INSERT;
                END;
            UNTIL RecGSalesInvLine.NEXT <= 0;

        RecGSalesCrMemoLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGSalesCrMemoLine.FindSet() THEN
            REPEAT
                RecGSalesCrMemoLineTEMP := RecGSalesCrMemoLine;
                IF RecGitem.GET(RecGSalesCrMemoLineTEMP."No.") THEN BEGIN
                    RecGSalesCrMemoLineTEMP."BC6_Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGSalesCrMemoLineTEMP.INSERT;
                END;
            UNTIL RecGSalesCrMemoLine.NEXT <= 0;


        RecGPurchLine.SETFILTER("Planned Receipt Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchLine.FindSet() THEN
            REPEAT
                RecGPurchLineTEMP := RecGPurchLine;
                IF RecGitem.GET(RecGPurchLineTEMP."No.") THEN BEGIN
                    RecGPurchLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchLineTEMP.INSERT;
                END;
            UNTIL RecGPurchLine.NEXT <= 0;

        RecGPurchInvLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchInvLine.FindSet() THEN
            REPEAT
                RecGPurchInvLineTEMP := RecGPurchInvLine;
                IF RecGitem.GET(RecGPurchInvLineTEMP."No.") THEN BEGIN
                    RecGPurchInvLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchInvLineTEMP.INSERT;
                END;
            UNTIL RecGPurchInvLine.NEXT <= 0;

        RecGPurchCrMemoLine.SETFILTER("Posting Date", '%1..%2', DatGDateDebut, DatDateFin);
        IF RecGPurchCrMemoLine.FindSet() THEN
            REPEAT
                RecGPurchCrMemoLineTEMP := RecGPurchCrMemoLine;
                IF RecGitem.GET(RecGPurchCrMemoLineTEMP."No.") THEN BEGIN
                    RecGPurchCrMemoLineTEMP."Buy-from Vendor No." := RecGitem."Vendor No.";
                    RecGPurchCrMemoLineTEMP.INSERT;
                END;
            UNTIL RecGPurchCrMemoLine.NEXT <= 0;
    end;

    var
        RecGitem: Record Item;
        RecGPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        RecGPurchCrMemoLineTEMP: Record "Purch. Cr. Memo Line" temporary;
        RecGPurchInvLine: Record "Purch. Inv. Line";
        RecGPurchInvLineTEMP: Record "Purch. Inv. Line" temporary;
        RecGPurchLine: Record "Purchase Line";
        RecGPurchLineTEMP: Record "Purchase Line" temporary;
        RecGSalesCrMemoLine: Record "Sales Cr.Memo Line";
        RecGSalesCrMemoLineTEMP: Record "Sales Cr.Memo Line" temporary;
        RecGSalesInvLine: Record "Sales Invoice Line";
        RecGSalesInvLineTEMP: Record "Sales Invoice Line" temporary;
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
        margeCaptionLbl: Label '% Profit', comment = 'FRA=""';
        Periode__FromCaptionLbl: Label 'Periode :From', comment = 'FRA="Période : Du"';
        Profit_AmountCaptionLbl: Label 'Profit Amount', comment = 'FRA="Montant Marge"';
        Puchase_Turnover_in_Vendor_OrderCaptionLbl: Label 'Puchase Turnover in Vendor Order', comment = 'FRA="CA achat en cde fournisseur"';
        Purchase_Amount_per_Costumer_OrderCaptionLbl: Label 'Purchase Amount per Costumer Order', comment = 'FRA="Montant Achat sur cde client"';
        Sale_TurnoverCaptionLbl: Label 'Sale Turnover', comment = 'FRA="CA Vente"';
        Statistics_Sales_by_VendorCaptionLbl: Label 'Statistics Sales by Vendor', comment = 'FRA="Statistiques ventes par fournisseur"';
        TotalCaptionLbl: Label 'Total';
}

