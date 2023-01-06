report 50100 "BC6_Batch Post Sales Invoices" //297
{
    Caption = 'Batch Post Sales Invoices', Comment = 'FRA="TPL valider commandes vente"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "No.", Status;
            RequestFilterHeading = 'Sales Invoice';
            trigger OnAfterGetRecord()
            var
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            begin
                IF ApprovalsMgmt.IsSalesApprovalsWorkflowEnabled("Sales Header") OR (Status = Status::"Pending Approval") THEN
                    CurrReport.SKIP();

                IF CalcInvDisc THEN
                    CalculateInvoiceDiscount();

                BatchConfirmUpdateDeferralDate(BatchConfirm, ReplacePostingDate, PostingDateReq);

                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                CLEAR(SalesPost);
                AssemblyPost.SetPostingDate(ReplacePostingDate, PostingDateReq);

                IF SalesPost.RUN("Sales Header") THEN BEGIN
                    CounterOK := CounterOK + 1;
                    IF MARKEDONLY THEN
                        MARK(FALSE);
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                MESSAGE(Text002, CounterOK, CounterTotal);
            end;

            trigger OnPreDataItem()
            begin
                IF ReplacePostingDate AND (PostingDateReq = 0D) THEN
                    ERROR(Text000);

                CounterTotal := COUNT;
                Window.OPEN(Text001);

                //>>FE018
                IF BooGExcludeShipment THEN BEGIN
                    "Sales Header".SETFILTER("BC6_Combine Shipments by Order", '%1', FALSE);
                    "Sales Header".SETFILTER("Combine Shipments", '%1', FALSE);
                END;
                //<<FE018
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
                    field(PostingDate; PostingDateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Date', Comment = 'FRA="Date comptabilisation"';
                    }
                    field(ReplacePostingDate; ReplacePostingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Replace Posting Date', Comment = 'FRA="Remplacer date comptabilisation"';

                        trigger OnValidate()
                        begin
                            if ReplacePostingDate then
                                Message(Text003);
                        end;
                    }
                    field(ReplaceDocumentDate; ReplaceDocumentDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Replace Document Date', Comment = 'FRA="Remplacer date document"';
                        ToolTip = 'Specifies if the new document date will be applied.', Comment = 'FRA="Spécifie si la nouvelle date comptabilisation sera appliquée."';
                    }
                    field(CalcInvDisc; CalcInvDisc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Calc. Inv. Discount', Comment = 'FRA="Calculer remise facture"';
                        trigger OnValidate()
                        var
                            SalesReceivablesSetup: Record "Sales & Receivables Setup";
                        begin
                            SalesReceivablesSetup.Get();
                            SalesReceivablesSetup.TestField("Calc. Inv. Discount", false);
                        end;
                    }
                    Field(BooGExcludeShipment; BooGExcludeShipment)
                    {
                        Caption = 'Exclure BL à regrouper';
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

    var
        SalesLine: Record "Sales Line";
        AssemblyPost: Codeunit "Assembly-Post";
        SalesCalcDisc: Codeunit "Sales-Calc. Discount";
        SalesPost: Codeunit "Sales-Post";
        BooGExcludeShipment: Boolean;
        CalcInvDisc: Boolean;
        ReplaceDocumentDate: Boolean;
        ReplacePostingDate: Boolean;
        PostingDateReq: Date;
        Window: Dialog;
        Counter: Integer;
        CounterOK: Integer;
        CounterTotal: Integer;
        Text000: Label 'Enter the posting date.';
        Text001: Label 'Posting invoices   #1########## @2@@@@@@@@@@@@@';
        Text002: Label '%1 invoices out of a total of %2 have now been posted.';
        Text003: Label 'The exchange rate associated with the new posting date on the sales header will not apply to the sales lines.', Comment = 'FRA="Le taux de change associé à la nouvelle date de comptabilisation de l''en-tête vente ne s''appliquera pas aux lignes vente."';
        BatchConfirm: Option " ",Skip,Update;

    local procedure CalculateInvoiceDiscount()
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", "Sales Header"."Document Type");
        SalesLine.SETRANGE("Document No.", "Sales Header"."No.");
        IF SalesLine.FINDFIRST() THEN
            IF SalesCalcDisc.RUN(SalesLine) THEN BEGIN
                "Sales Header".GET("Sales Header"."Document Type", "Sales Header"."No.");
                COMMIT();
            END;
    end;

}

