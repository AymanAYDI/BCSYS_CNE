report 50005 "BC6_Batch Post Sales Orders" //296
{
    Caption = 'Batch Post Sales Orders', Comment = 'FRA="TPL valider commandes vente"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", Status;
            RequestFilterHeading = 'Sales Order';

            trigger OnPreDataItem()
            var
                SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.";
            begin
                SalesBatchPostMgt.SetParameter("Batch Posting Parameter Type"::Print, PrintDocG);
                SalesBatchPostMgt.RunBatch("Sales Header", ReplacePostingDateG, PostingDateReq, ReplaceDocumentDateG, CalcInvDiscG, ShipReq, InvReq);
                //>>FE018
                IF BooGExcludeShipmentG THEN BEGIN
                    "Sales Header".SETFILTER("BC6_Combine Shipments by Order", '%1', FALSE);
                    "Sales Header".SETFILTER("Combine Shipments", '%1', FALSE);
                END;
                //<<FE018
                CurrReport.Break();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Ship; ShipReq)
                    {
                        ApplicationArea = All;
                        Caption = 'Ship', Comment = 'FRA="Expédier"';
                    }
                    field(Invoice; InvReq)
                    {
                        ApplicationArea = All;
                        Caption = 'Invoice', Comment = 'FRA="Facture"';
                    }
                    field(PostingDate; PostingDateReq)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date', Comment = 'FRA="Date comptabilisation"';
                    }
                    field(ReplacePostingDate; ReplacePostingDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'Replace Posting Date', Comment = 'FRA="Remplacer date comptabilisation"';

                        trigger OnValidate()
                        begin
                            if ReplacePostingDateG then
                                Message(Text003);
                        end;
                    }
                    field(ReplaceDocumentDate; ReplaceDocumentDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'Replace Document Date', Comment = 'FRA="Remplacer date document"';
                    }
                    field(CalcInvDisc; CalcInvDiscG)
                    {
                        ApplicationArea = All;
                        Caption = 'Calc. Inv. Discount', Comment = 'FRA="Calculer remise facture"';
                        trigger OnValidate()
                        var
                            SalesReceivablesSetup: Record "Sales & Receivables Setup";
                        begin
                            SalesReceivablesSetup.Get();
                            SalesReceivablesSetup.TestField("Calc. Inv. Discount", false);
                        end;
                    }
                    field(PrintDoc; PrintDocG)
                    {
                        ApplicationArea = All;
                        Caption = 'Print', Comment = 'FRA="Imprimer"';
                        Visible = PrintDocVisible;
                        trigger OnValidate()
                        var
                            SalesReceivablesSetup: Record "Sales & Receivables Setup";
                        begin
                            if PrintDocG then begin
                                SalesReceivablesSetup.Get();
                                if SalesReceivablesSetup."Post with Job Queue" then
                                    SalesReceivablesSetup.TestField("Post & Print with Job Queue");
                            end;
                        end;
                    }
                    field(BooGExcludeShipment; BooGExcludeShipmentG)
                    {
                        ApplicationArea = all;
                        Caption = 'Exclure BL à regrouper';
                    }
                }
            }
        }

        trigger OnOpenPage()
        var
            SalesReceivablesSetup: Record "Sales & Receivables Setup";
            ClientTypeManagement: Codeunit "Client Type Management";
        begin
            if ClientTypeManagement.GetCurrentClientType() <> ClientType::Background then begin
                SalesReceivablesSetup.Get();
                CalcInvDiscG := SalesReceivablesSetup."Calc. Inv. Discount";
                ReplacePostingDateG := false;
                ReplaceDocumentDateG := false;
                PrintDocG := false;
                PrintDocVisible := SalesReceivablesSetup."Post & Print with Job Queue";
            end;
        end;
    }

    var
        BooGExcludeShipmentG: Boolean;
        PrintDocG: Boolean;
        [InDataSet]
        PrintDocVisible: Boolean;
        Text003: Label 'The exchange rate associated with the new posting date on the sales header will not apply to the sales lines.', Comment = 'FRA="Le taux de change associé à la nouvelle date de comptabilisation de l''en-tête vente ne s''appliquera pas aux lignes vente."';

    protected var
        CalcInvDiscG: Boolean;
        InvReq: Boolean;
        ReplaceDocumentDateG: Boolean;
        ReplacePostingDateG: Boolean;
        ShipReq: Boolean;
        PostingDateReq: Date;

    procedure InitializeRequest(ShipParam: Boolean; InvoiceParam: Boolean; PostingDateParam: Date; ReplacePostingDateParam: Boolean; ReplaceDocumentDateParam: Boolean; CalcInvDiscParam: Boolean)
    begin
        ShipReq := ShipParam;
        InvReq := InvoiceParam;
        PostingDateReq := PostingDateParam;
        ReplacePostingDateG := ReplacePostingDateParam;
        ReplaceDocumentDateG := ReplaceDocumentDateParam;
        CalcInvDiscG := CalcInvDiscParam;
    end;
}
