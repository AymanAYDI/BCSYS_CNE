report 50004 "BC6_Combine Shipments"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Combine Shipments', Comment = 'FRA="Regrouper les B.L."';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(SalesOrderHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order), "Combine Shipments" = CONST(true));
            RequestFilterFields = "Sell-to Customer No.", "Bill-to Customer No.";
            RequestFilterHeading = 'Sales Order';
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "Order No." = FIELD("No.");
                DataItemTableView = SORTING("Order No.");
                RequestFilterFields = "Posting Date";
                RequestFilterHeading = 'Posted Sales Shipment';
                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.");

                    trigger OnAfterGetRecord()
                    begin
                        if Type = Type::" " then
                            if (not CopyTextLines) or ("Attached to Line No." <> 0) then
                                CurrReport.Skip();

                        if "Authorized for Credit Card" then
                            CurrReport.Skip();

                        if ("Qty. Shipped Not Invoiced" <> 0) or (Type = Type::" ") then begin
                            if ("Bill-to Customer No." <> Cust."No.") and
                               ("Sell-to Customer No." <> '')
                            then
                                Cust.Get("Bill-to Customer No.");
                            if not (Cust.Blocked in [Cust.Blocked::All, Cust.Blocked::Invoice]) then begin
                                if ShouldFinalizeSalesInvHeader(SalesOrderHeader, SalesHeader, "Sales Shipment Line") OR BooGNewOrderHdr then begin
                                    if SalesHeader."No." <> '' then
                                        FinalizeSalesInvHeader();
                                    InsertSalesInvHeader();
                                    //>>FE018
                                    BooGNewOrderHdr := FALSE;
                                    //<<FE018
                                    SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                                    SalesLine."Document Type" := SalesHeader."Document Type";
                                    SalesLine."Document No." := SalesHeader."No.";
                                end;
                                SalesShptLine := "Sales Shipment Line";
                                HasAmount := HasAmount or ("Qty. Shipped Not Invoiced" <> 0);
                                SalesShptLine.InsertInvLineFromShptLine(SalesLine);
                            end else
                                NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                        end;
                    end;

                    trigger OnPostDataItem()
                    var
                        SalesShipmentLine: Record "Sales Shipment Line";
                        SalesLineInvoice: Record "Sales Line";
                        SalesGetShpt: Codeunit "Sales-Get Shipment";
                    begin
                        SalesShipmentLine.SetRange("Document No.", "Document No.");
                        SalesShipmentLine.SetRange(Type, Type::"Charge (Item)");
                        if SalesShipmentLine.FindSet() then
                            repeat
                                SalesLineInvoice.SetRange("Document Type", SalesLineInvoice."Document Type"::Invoice);
                                SalesLineInvoice.SetRange("Document No.", SalesHeader."No.");
                                SalesLineInvoice.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
                                if SalesLineInvoice.FindFirst() then
                                    SalesGetShpt.GetItemChargeAssgnt(SalesShipmentLine, SalesLineInvoice."Qty. to Invoice");
                            until SalesShipmentLine.Next() = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    DueDate: Date;
                    PmtDiscDate: Date;
                    PmtDiscPct: Decimal;
                begin
                    Window.Update(3, "No.");

                    if IsCompletlyInvoiced() then
                        CurrReport.Skip();

                    if OnlyStdPmtTerms then begin
                        Cust.Get("Bill-to Customer No.");
                        PmtTerms.Get(Cust."Payment Terms Code");
                        if PmtTerms.Code = "Payment Terms Code" then begin
                            DueDate := CalcDate(PmtTerms."Due Date Calculation", "Document Date");
                            PmtDiscDate := CalcDate(PmtTerms."Discount Date Calculation", "Document Date");
                            PmtDiscPct := PmtTerms."Discount %";
                            if (DueDate <> "Due Date") or
                               (PmtDiscDate <> "Pmt. Discount Date") or
                               (PmtDiscPct <> "Payment Discount %")
                            then begin
                                NoOfskippedShiment := NoOfskippedShiment + 1;
                                CurrReport.Skip();
                            end;
                        end else begin
                            NoOfskippedShiment := NoOfskippedShiment + 1;
                            CurrReport.Skip();
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                Window.Update(1, "Bill-to Customer No.");
                Window.Update(2, "No.");
                //>>FE018
                BooGNewOrderHdr := FALSE;
                IF ("BC6_Combine Shipments by Order" OR booGlastinvoicemethod) THEN
                    BooGNewOrderHdr := TRUE;
                //booGlastinvoicemethod := "Combine Shipments by Order";
                //<<FE018
            end;

            trigger OnPostDataItem()
            begin
                CurrReport.Language := ReportLanguage;
                Window.Close();
                ShowResult();
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentKey("Sell-to Customer No.", "Bill-to Customer No.", "Currency Code", "EU 3-Party Trade", "Dimension Set ID");

                if PostingDateReq = 0D then
                    Error(Text000);
                if DocDateReq = 0D then
                    Error(Text001);

                Window.Open(
                  Text002 +
                  Text003 +
                  Text004 +
                  Text005);

                ReportLanguage := CurrReport.Language();
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
                    field(DocDateReq; DocDateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document Date', Comment = 'FRA="Date document"';
                    }
                    field(CalcInvDisc; CalcInvDisc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Calc. Inv. Discount', Comment = 'FRA="Calculer remise facture"';
                        trigger OnValidate()
                        begin
                            SalesSetup.Get();
                            SalesSetup.TestField("Calc. Inv. Discount", false);
                        end;
                    }
                    field(PostInv; PostInv)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Invoices', Comment = 'FRA="Validation des factures"';
                    }
                    field(OnlyStdPmtTerms; OnlyStdPmtTerms)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Only Std. Payment Terms', Comment = 'FRA="Conditions paiement standard uniquement"';
                    }
                    field(CopyTextLines; CopyTextLines)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Copy Text Lines', Comment = 'FRA="Copier lignes texte"';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
            if DocDateReq = 0D then
                DocDateReq := WorkDate();
            SalesSetup.Get();
            CalcInvDisc := SalesSetup."Calc. Inv. Discount";
        end;
    }
    var
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        PmtTerms: Record "Payment Terms";
        Language: Codeunit Language;
        SalesCalcDisc: Codeunit "Sales-Calc. Discount";
        SalesPost: Codeunit "Sales-Post";
        Window: Dialog;
        HasAmount: Boolean;
        HideDialog: Boolean;
        NoOfSalesInvErrors: Integer;
        NoOfSalesInv: Integer;
        NoOfskippedShiment: Integer;
        ReportLanguage: Integer;

        Text000: Label 'Enter the posting date.', Comment = 'FRA="Entrez une date comptabilisation."';
        Text001: Label 'Enter the document date.', Comment = 'FRA="Entrez la date du document."';
        Text002: Label 'Combining shipments...\\', Comment = 'FRA="Regroupement des B.L...\\"';
        Text003: Label 'Customer No.    #1##########\', Comment = 'FRA="N° client       #1##########\"';
        Text004: Label 'Order No.       #2##########\', Comment = 'FRA="N° commande     #2##########\"';
        Text005: Label 'Shipment No.    #3##########', Comment = 'FRA="N° livraison    #3##########"';
        Text007: Label 'Not all the invoices were posted. A total of %1 invoices were not posted.', Comment = 'FRA="Toutes les factures n''ont pas été validées (%1 non validée(s))."';
        Text008: Label 'There is nothing to combine.', Comment = 'FRA="Il n''y a rien à regrouper."';
        Text010: Label 'The shipments are now combined and the number of invoices created is %1.', Comment = 'FRA="Les expéditions sont maintenant regroupées, et le nombre de factures créées est de %1."';
        Text011: Label 'The shipments are now combined, and the number of invoices created is %1.\%2 Shipments with nonstandard payment terms have not been combined.', Comment = 'FRA="Les expéditions sont maintenant regroupées, et le nombre de factures créées est de %1.\%2 expéditions avec des conditions de paiement non standard n''ont pas été combinées."';
        NotAllInvoicesCreatedMsg: Label 'Not all the invoices were created. A total of %1 invoices were not created.', Comment = 'FRA="Les factures n''ont pas toutes été créées. Au total, %1 factures n''ont pas été créées."';
        ExtDocReq: Code[20];
        booGlastinvoicemethod: Boolean;
        BooGNewOrderHdr: Boolean;

    protected var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShptLine: Record "Sales Shipment Line";
        PostingDateReq: Date;
        DocDateReq: Date;
        CalcInvDisc: Boolean;
        PostInv: Boolean;
        OnlyStdPmtTerms: Boolean;
        CopyTextLines: Boolean;

    local procedure FinalizeSalesInvHeader()
    var
        HasError: Boolean;
        ShouldPostInv: Boolean;
    begin
        HasError := false;
        if HasError then
            NoOfSalesInvErrors += 1;

        with SalesHeader do begin
            if (not HasAmount) or HasError then begin
                Delete(true);
                exit;
            end;
            if CalcInvDisc then
                SalesCalcDisc.Run(SalesLine);
            Find();
            Commit();
            Clear(SalesCalcDisc);
            Clear(SalesPost);
            NoOfSalesInv := NoOfSalesInv + 1;
            ShouldPostInv := PostInv;
            if ShouldPostInv then begin
                Clear(SalesPost);
                if not SalesPost.Run(SalesHeader) then
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
            end;
        end;
    end;

    local procedure InsertSalesInvHeader()
    begin
        GLSetup.Get();
        Clear(SalesHeader);
        with SalesHeader do begin
            Init();
            "Document Type" := "Document Type"::Invoice;
            "No." := '';
            Insert(true);
            ValidateCustomerNo(SalesHeader, SalesOrderHeader);
            Validate("Posting Date", PostingDateReq);
            Validate("Document Date", DocDateReq);
            //RegroupementBL NSC1.01 SBH [018]
            VALIDATE("External Document No.", ExtDocReq);
            //Fin RegroupementBL NSC1.01 SBH [018]
            //>> TDL 24/04/07
            //>>TDL96:MICO 09/05/2007
            //>>BC6 - MM 07/01/19
            VALIDATE("Your Reference", SalesOrderHeader."Your Reference");
            //<<BC6 - MM 07/01/19
            //<<TDL96:MICO 09/05/2007
            //<< TDL 24/04/07
            Validate("Currency Code", SalesOrderHeader."Currency Code");
            Validate("EU 3-Party Trade", SalesOrderHeader."EU 3-Party Trade");
            if GLSetup."Journal Templ. Name Mandatory" then
                Validate("Journal Templ. Name", SalesOrderHeader."Journal Templ. Name");
            "Salesperson Code" := SalesOrderHeader."Salesperson Code";
            "Shortcut Dimension 1 Code" := SalesOrderHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := SalesOrderHeader."Shortcut Dimension 2 Code";
            "Dimension Set ID" := SalesOrderHeader."Dimension Set ID";
            Modify();
            Commit();
            HasAmount := false;
        end;
    end;

    procedure InitializeRequest(NewPostingDate: Date; NewDocDate: Date; NewCalcInvDisc: Boolean; NewPostInv: Boolean; NewOnlyStdPmtTerms: Boolean; NewCopyTextLines: Boolean)
    begin
        PostingDateReq := NewPostingDate;
        DocDateReq := NewDocDate;
        CalcInvDisc := NewCalcInvDisc;
        PostInv := NewPostInv;
        OnlyStdPmtTerms := NewOnlyStdPmtTerms;
        CopyTextLines := NewCopyTextLines;
    end;

    local procedure ValidateCustomerNo(var ToSalesHeader: Record "Sales Header"; FromSalesOrderHeader: Record "Sales Header")
    begin
        ToSalesHeader.Validate("Sell-to Customer No.", FromSalesOrderHeader."Sell-to Customer No.");
        ToSalesHeader.Validate("Bill-to Customer No.", FromSalesOrderHeader."Bill-to Customer No.");
    end;

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    local procedure ShowResult()
    begin
        if SalesHeader."No." <> '' then begin // Not the first time
            FinalizeSalesInvHeader();
            if (NoOfSalesInvErrors = 0) and not HideDialog then begin
                if NoOfskippedShiment > 0 then
                    Message(Text011, NoOfSalesInv, NoOfskippedShiment)
                else
                    Message(Text010, NoOfSalesInv);
            end else
                if not HideDialog then
                    if PostInv then
                        Message(Text007, NoOfSalesInvErrors)
                    else
                        Message(NotAllInvoicesCreatedMsg, NoOfSalesInvErrors)
        end else
            if not HideDialog then
                Message(Text008);
    end;

    local procedure ShouldFinalizeSalesInvHeader(SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header"; SalesShipmentLine: Record "Sales Shipment Line") Finalize: Boolean
    begin
        Finalize :=
          (SalesOrderHeader."Sell-to Customer No." <> SalesHeader."Sell-to Customer No.") or
          (SalesOrderHeader."Bill-to Customer No." <> SalesHeader."Bill-to Customer No.") or
          (SalesOrderHeader."Currency Code" <> SalesHeader."Currency Code") or
          (SalesOrderHeader."EU 3-Party Trade" <> SalesHeader."EU 3-Party Trade") or
          (SalesOrderHeader."Dimension Set ID" <> SalesHeader."Dimension Set ID") or
          (SalesOrderHeader."Journal Templ. Name" <> SalesHeader."Journal Templ. Name");
        exit(Finalize);
    end;

}
