
codeunit 50203 "BC6_PagesEvents"
{
    //Page95
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Subform", 'OnBeforeUpdateTypeText', '', true, true)]
    local procedure P95_OnBeforeUpdateTypeText(var SalesLine: Record "Sales Line")
    begin
        //     IncrProfit := 0;
        //    IncrPurchCost := 0;
    end;
    //Page 232
    // [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnAfterOnOpenPage', '', true, true)]
    // local procedure P232_OnAfterOnOpenPage(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingCustLedgEntry: Record "Cust. Ledger Entry")
    // var
    //     Cust: record customer;
    //     CalcType: Enum "Customer Apply Calculation Type";

    // begin
    //     //TODO: Cust.get(Cust."No.");
    //     // if CalcType = CalcType::Direct then begin
    //     //     IF NOT Cust.GET("Customer No.") AND NOT Cust.GET("Pay-to Customer No.") THEN ERROR(TextGestTierPayeur001);
    //     // end;
    //     // nd;
    //
    // 

    //Page 5703
    [EventSubscriber(ObjectType::Page, Page::"Location Card", 'OnAfterUpdateEnabled', '', false, false)]
    local procedure P5703_OnAfterUpdateEnabled(Location: Record Location)
    var
        ReceiptBinCodeEnable: boolean;
        ShipmentBinCodeEnable: Boolean;
    begin
        ReceiptBinCodeEnable := (Location."Bin Mandatory" AND Location."Require Receive") OR Location."Directed Put-away and Pick";
        ShipmentBinCodeEnable := (Location."Bin Mandatory" AND Location."Require Shipment") OR Location."Directed Put-away and Pick";
    end;
    //Page 6630
    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order", 'OnBeforeStatisticsAction', '', false, false)]
    local procedure P6630_OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    var
        DocPrint: Codeunit "Document-Print";
        "Sales Return Order": Page "Sales Return Order";
        STR3: Label 'Print Document', comment = 'FRA="Imprimer le document"';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
    begin
        IF SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::Location THEN
            CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                1:
                    DocPrint.PrintSalesHeader(SalesHeader);
                2:
                    "Sales Return Order".EnvoiMail();
            END
        ELSE
            CASE STRMENU(STR3 + ',' + STR4) OF
                1:
                    BEGIN
                        SalesHeader.TESTFIELD(Status, Status::Released);
                        SalesHeader.RESET();
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesHeader.SETRANGE("No.", SalesHeader."No.");
                        REPORT.RUNMODAL(50060, TRUE, FALSE, SalesHeader);
                    END;
                2:
                    BEGIN
                        SalesHeader.TESTFIELD(Status, Status::Released);
                        "Sales Return Order".EnvoiMail;
                    END;
            end;
    end;
    //PAGE 161
    [EventSubscriber(ObjectType::Page, Page::"Purchase Statistics", 'OnAfterCalculateTotals', '', false, false)]

    local procedure P161_OnAfterCalculateTotals(var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TotalAmt1: Decimal; var TotalAmt2: Decimal)
    var
        TempPurchLine: Record "Purchase Line" temporary;
        PurchPost: Codeunit "Purch.-Post";
        //TODO---check the global decimal variables.. 
        DecGTTCAmount: Decimal;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: decimal;
    begin
        //TODO://  SumPurchLinesTemp has changes in the parameters (when we merge the cod90)
        // PurchPost.SumPurchLinesTemp(
        //  PurchHeader , TempPurchLine, 0, TempPurchLine, TotalPurchLineLCY, VATAmount, VATAmountText,DecGHTAmount,DecGVATAmount,DecGTTCAmount,DecGHTAmountLCY);
        IF PurchHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalPurchLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalPurchLine.Amount;
            TotalAmount2 := TotalPurchLine."Amount Including VAT";
            TotalAmount2 := TotalAmount2 + DecGTTCAmount;

        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Statistics", 'OnAfterUpdateHeaderInfo', '', false, false)]
    local procedure P161_OnAfterUpdateHeaderInfo()
    var
        TempVATAmountLine: Record "VAT Amount Line" temporary;
    //faut savoir comment récupérer des var glob de type decimal
    begin
        //TODO DecGVATAmount := TempVATAmountLine.GetTotalVATDEEEAmount;
        // DecGTTCAmount := TempVATAmountLine.GetTotalAmountDEEEInclVAT;
        // VATAmount := VATAmount + DecGVATAmount;

    end;
    //Page 232
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnAfterOnOpenPage', '', false, false)]
    local procedure P232_OnAfterOnOpenPage(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingCustLedgEntry: Record "Cust. Ledger Entry")
    var
        Cust: Record Customer;
        FctMngt: Codeunit "BC6_Functions Mgt";
        ApplnCurrencyCode: Code[10];
        CalcType: Enum "Customer Apply Calculation Type";
        TextGestTierPayeur001: Label 'There is no ledger entries.', Comment = 'FRA="Approuvé"';

    begin
        IF CalcType = CalcType::Direct THEN BEGIN
            IF NOT Cust.GET(CustLedgerEntry."Customer No.") AND NOT Cust.GET(CustLedgerEntry."BC6_Pay-to Customer No.") THEN ERROR(TextGestTierPayeur001);
            ApplnCurrencyCode := Cust."Currency Code";
            FctMngt.FindApplyingEntry();
        END;

    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnBeforeSetApplyingCustLedgEntry', '', false, false)]
    local procedure P232_OnBeforeSetApplyingCustLedgEntry(var ApplyingCustLedgEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; var CalcType: Enum "Customer Apply Calculation Type"; ServHeader: Record "Service Header")
    var
        TotalSalesLine: Record "Sales Line";
    begin
        // //TODO: changed in cdu 90 SalesPost.SumSalesLines(
        // //   SalesHeader, 0, TotalSalesLine, TotalSalesLineLCY,
        // //   VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY,
        //   //DEEE
        //   TotalSalesLine."BC6_DEEE HT Amount", TotalSalesLine."BC6_DEEE VAT Amount",
        //   TotalSalesLine."BC6_DEEE TTC Amount", TotalSalesLine."BC6_DEEE HT Amount (LCY)";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnBeforeCalcApplnAmount', '', false, false)]
    local procedure P232_OnBeforeCalcApplnAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; var AppliedCustLedgerEntry: Record "Cust. Ledger Entry"; CalculationType: Option; ApplicationType: Option)
    var
        ApplnType: Enum "Customer Apply-to Type";
        CalcType: Enum "Customer Apply Calculation Type";

    begin
        case CalcType of
            ApplnType::"Applies-to ID":
                begin
                    GenJournalLine := GenJournalLine;
                    AppliedCustLedgerEntry.SETCURRENTKEY("BC6_Pay-to Customer No.", Open, Positive);
                    AppliedCustLedgerEntry.SETRANGE("BC6_Pay-to Customer No.", GenJournalLine."Account No.");
                    //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Remplacement du "Customer No." par "Pay-to Customer No."
                    //<<MIGRATION NAV 2013
                    AppliedCustLedgerEntry.SETRANGE(Open, TRUE);
                    AppliedCustLedgerEntry.SETRANGE("Applies-to ID", GenJournalLine."Applies-to ID");
                    //TODO: HandlChosenEntries(1,
                    //   GenJournalLine.Amount,
                    //   GenJournalLine."Currency Code",
                    //   GenJournalLine."Posting Date");
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeInsertExtendedText', '', false, false)]
    local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchOrd: page "Purchase Order Subform";
        Unconditionally: Boolean;
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(PurchaseLine, Unconditionally) then begin
            PurchOrd.SaveRecord;
            TransferExtendedText.InsertPurchExtText(PurchaseLine);
            //TODO:Fct to add in cod378  TransferExtendedText.InsertPurchExtTextSpe(PurchaseLine);
        end;
    end;
    //PAGE 233
    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnAfterCalcApplnAmount', '', false, false)]
    local procedure P233_OnAfterCalcApplnAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal; CalcType: Enum "Vendor Apply Calculation Type"; var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine2: Record "Gen. Journal Line";
        ApplnType: Enum "Vendor Apply-to Type";

    begin
        case CalcType of
            CalcType::"Gen. Jnl. Line":

                case ApplnType of
                    ApplnType::"Applies-to ID":
                        begin
                            GenJnlLine2 := GenJournalLine;
                            AppliedVendLedgEntry.SETCURRENTKEY("BC6_Pay-to Vend. No.", Open, Positive);
                            AppliedVendLedgEntry.SETRANGE("BC6_Pay-to Vend. No.", GenJournalLine."Account No.");
                            AppliedVendLedgEntry.SetRange(Open, true);
                            AppliedVendLedgEntry.SetRange("Applies-to ID", GenJournalLine."Applies-to ID");

                            //TODO:Local Proc // HandleChosenEntries(
                            //     CalcType::"Gen. Jnl. Line", GenJnlLine2.Amount, GenJnlLine2."Currency Code", GenJnlLine2."Posting Date");

                        end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnAfterOpenPage', '', false, false)]
    local procedure P233_OnAfterOpenPage(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplyingVendLedgEntry: Record "Vendor Ledger Entry")
    var
        Vend: Record Vendor;
        FctMngt: Codeunit "BC6_Functions Mgt";
        ApplnCurrencyCode: Code[10];
        CalcType: Enum "Vendor Apply Calculation Type";
        TextGestTierPayeur001: Label 'There is no ledger entries.', comment = 'FRA="Il n''y a pas d''écitures."';

    begin
        if CalcType = CalcType::Direct then begin
            IF NOT Vend.GET(VendorLedgerEntry."Vendor No.") AND NOT Vend.GET(Vend."BC6_Pay-to Vend. No.") THEN ERROR(TextGestTierPayeur001);
            ApplnCurrencyCode := Vend."Currency Code";
            FctMngt.FindApplyingEntry();
        end;

    end;
    //COD 90
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnAfterSetEverythingInvoiced', '', false, false)]
    local procedure COD90_OnPostPurchLineOnAfterSetEverythingInvoiced(PurchaseLine: Record "Purchase Line"; var EverythingInvoiced: Boolean; PurchaseHeader: Record "Purchase Header")
    var
        FctMngt: Codeunit "BC6_Functions Mgt";

    begin
        if PurchaseLine.Quantity <> 0 then
            FctMngt.MntDivisionDEEE(PurchaseLine."Qty. to Invoice", PurchaseLine) //F8
        else
            PurchaseLine.TestField(PurchaseLine.Amount, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnBeforeRoundAmount', '', false, false)]
    local procedure COD90_OnPostPurchLineOnBeforeRoundAmount(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; SrcCode: Code[10])
    var
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        FctMngt.MntInverseDEEE(PurchaseLine);
        FctMngt.MntInverseDEEE(PurchaseLine); //TODO
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnBeforeInsertReceiptLine', '', false, false)]
    local procedure COD90_OnPostPurchLineOnBeforeInsertReceiptLine(PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        GenPostingSetup: Record "General Posting Setup";
        InvoicePostBuffer: Record "Invoice Post. Buffer";
        TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; //TODO: check the temp record
        RecLPayVendor: Record Vendor;
        FctMngt: Codeunit "BC6_Functions Mgt";
        BooLPostingDEEE: Boolean;
    begin
        InvoicePostBuffer.get(InvoicePostBuffer.Type, InvoicePostBuffer."G/L Account", InvoicePostBuffer."Gen. Bus. Posting Group", InvoicePostBuffer."Gen. Prod. Posting Group", InvoicePostBuffer."VAT Bus. Posting Group", InvoicePostBuffer."VAT Prod. Posting Group", InvoicePostBuffer."Tax Area Code", InvoicePostBuffer."Tax Group Code", InvoicePostBuffer."Tax Liable", InvoicePostBuffer."Use Tax", InvoicePostBuffer."Dimension Set ID", InvoicePostBuffer."Job No.", InvoicePostBuffer."Fixed Asset Line No.", InvoicePostBuffer."Deferral Code");
        RecLPayVendor.RESET;
        IF RecLPayVendor.GET(PurchaseLine."Pay-to Vendor No.") THEN
            BooLPostingDEEE := RecLPayVendor."BC6_Posting DEEE"
        ELSE
            BooLPostingDEEE := FALSE;

        IF (PurchaseLine."BC6_DEEE Category Code" <> '') AND (PurchaseLine."Qty. to Invoice" <> 0)
              AND (PurchaseLine."BC6_DEEE HT Amount" <> 0) AND (BooLPostingDEEE) THEN BEGIN
            GenPostingSetup.GET(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group");

            IF (PurchaseLine."Gen. Bus. Posting Group" <> GenPostingSetup."Gen. Bus. Posting Group") OR
                (PurchaseLine."Gen. Prod. Posting Group" <> GenPostingSetup."Gen. Prod. Posting Group")
            THEN;
            CLEAR(InvoicePostBuffer);
            InvoicePostBuffer.Type := PurchaseLine.Type;
            GenPostingSetup.GET('DEEE', PurchaseLine."Gen. Prod. Posting Group");

            IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo" THEN BEGIN
                GenPostingSetup.TESTFIELD("Purch. Credit Memo Account");
                InvoicePostBuffer."G/L Account" := GenPostingSetup."Purch. Credit Memo Account";
            END ELSE BEGIN
                GenPostingSetup.TESTFIELD("Purch. Account");
                InvoicePostBuffer."G/L Account" := GenPostingSetup."Purch. Account";
            END;

            InvoicePostBuffer."System-Created Entry" := TRUE;
            InvoicePostBuffer."Gen. Bus. Posting Group" := 'DEEE';//purchLine."Gen. Bus. Posting Group";
            InvoicePostBuffer."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
            InvoicePostBuffer."VAT Bus. Posting Group" := PurchaseLine."VAT Bus. Posting Group";
            InvoicePostBuffer."VAT Prod. Posting Group" := PurchaseLine."VAT Prod. Posting Group";
            InvoicePostBuffer."VAT Calculation Type" := PurchaseLine."VAT Calculation Type";
            InvoicePostBuffer."Global Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
            InvoicePostBuffer."Global Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
            InvoicePostBuffer."Job No." := PurchaseLine."Job No.";
            InvoicePostBuffer.Amount := PurchaseLine."BC6_DEEE HT Amount";
            InvoicePostBuffer."VAT Base Amount" := PurchaseLine."BC6_DEEE HT Amount";
            InvoicePostBuffer."VAT Amount" := (PurchaseLine."BC6_DEEE TTC Amount" - PurchaseLine."BC6_DEEE HT Amount");
            InvoicePostBuffer."Amount (ACY)" := PurchaseLine."BC6_DEEE HT Amount";//purchLineACY.Montant;
            InvoicePostBuffer."VAT Base Amount (ACY)" := PurchaseLine."BC6_DEEE HT Amount"; //purchLineACY.Montant;
            InvoicePostBuffer."VAT Amount (ACY)" := (PurchaseLine."BC6_DEEE TTC Amount" - PurchaseLine."BC6_DEEE HT Amount");
            InvoicePostBuffer."BC6_Eco partner DEEE" := PurchaseLine."BC6_Eco partner DEEE";
            InvoicePostBuffer."BC6_DEEE Category Code" := PurchaseLine."BC6_DEEE Category Code";
            FctMngt.MntIncrDEEE(PurchaseLine);
            FctMngt.UpdateInvoicePostBuffer(TempInvoicePostBuffer, InvoicePostBuffer);

        END;
    end;
    //ligne718
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostVendorEntry', '', false, false)]
    local procedure COD90_OnAfterPostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        _EcoPartnerDEEE: Code[10];
        _DEEECategoryCode: code[10];
    begin
        GenJnlLine."BC6_DEEE HT Amount" := TotalPurchLine."BC6_DEEE HT Amount";
        GenJnlLine."BC6_DEEE VAT Amount" := TotalPurchLine."BC6_DEEE VAT Amount";
        GenJnlLine."BC6_DEEE TTC Amount" := TotalPurchLine."BC6_DEEE TTC Amount";
        GenJnlLine."BC6_DEEE HT Amount (LCY)" := TotalPurchLine."BC6_DEEE HT Amount (LCY)";
        GenJnlLine."BC6_Eco partner DEEE" := _EcoPartnerDEEE;
        GenJnlLine."BC6_DEEE Category Code" := _DEEECategoryCode;

        GenJnlLine.Amount := GenJnlLine.Amount - GenJnlLine."BC6_GDecMntTTCDEEE";
        GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" - GenJnlLine."BC6_GDecMntTTCDEEE";
        GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - GenJnlLine."BC6_GDecMntTTCDEEE";
        GenJnlLine."Payment Method Code" := GenJnlLine."Payment Method Code";

    end;

    //TAB 43 //CHANGEMENT DE L'ANCIENNE PROC CopyCommentLines
    [EventSubscriber(ObjectType::Table, Database::"Purch. Comment Line", 'OnBeforeCopyComments', '', false, false)]
    local procedure TAB43_OnBeforeCopyComments(var PurchCommentLine: Record "Purch. Comment Line"; ToDocumentType: Integer; var IsHandled: Boolean; FromDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
        PurchCommentLine.SETRANGE("BC6_Is Log", FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeValidatePostingAndDocumentDate', '', false, false)]
    local procedure COD90_OnBeforeValidatePostingAndDocumentDate(var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        RecLNavisetup: Record "BC6_Navi+ Setup";
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        //     IF RecLNavisetup.GET AND RecLNavisetup."Date jour ds date facture Acha" then
        //    FctMngt.SetPostingDate(TRUE, FALSE, WORKDATE);
        //TODO SetPostingDate has been removed
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFinalizePostingOnBeforeUpdateAfterPosting', '', false, false)]
    local procedure COD90_OnFinalizePostingOnBeforeUpdateAfterPosting(var PurchHeader: Record "Purchase Header"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary; var EverythingInvoiced: Boolean; var IsHandled: Boolean; var TempPurchLine: Record "Purchase Line" temporary)
    var
        RecLNavisetup: Record "BC6_Navi+ Setup";
        CduGArchiveManagement: codeunit ArchiveManagement;
    begin
        if not IsHandled then
            IF RecLNavisetup.GET THEN
                IF RecLNavisetup."Filing Purchases Orders" AND (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN
                    CduGArchiveManagement.StorePurchDocument(PurchHeader, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterIncrAmount', '', false, false)]
    local procedure COD90_OnAfterIncrAmount(var TotalPurchLine: Record "Purchase Line"; PurchLine: Record "Purchase Line")
    var
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        FctMngt.Increment(TotalPurchLine."BC6_DEEE HT Amount", PurchLine."BC6_DEEE HT Amount");
        FctMngt.Increment(TotalPurchLine."BC6_DEEE TTC Amount", PurchLine."BC6_DEEE TTC Amount");
        FctMngt.Increment(TotalPurchLine."BC6_DEEE VAT Amount", PurchLine."BC6_DEEE VAT Amount");
        FctMngt.Increment(TotalPurchLine."BC6_DEEE HT Amount (LCY)", PurchLine."BC6_DEEE HT Amount (LCY)");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeSumPurchLines2', '', false, false)]
    local procedure COD90_OnBeforeSumPurchLines2(QtyType: Option; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line"; InsertPurchLine: Boolean; var IsHandled: Boolean)
    var
        //j'ai déclaré ces variables locales car ils sont prises comme des paramétres
        VATAmount: Decimal;
        DecLHTAmount: Decimal;
        DecLVATAmount: Decimal;
        DecLTTCAmount: Decimal;
        DecLHTAmountLCY: Decimal;
        VATAmountText: Text[30];
        VATAmountTxt: Label 'VAT Amount';
        VATRateTxt: Label '%1% VAT', Comment = '%1 = VAT Rate';

    begin
        VATAmount := VATAmount + PurchLine."BC6_DEEE VAT Amount";
        if PurchLine."VAT %" = 0 then
            VATAmountText := VATAmountText
        else
            VATAmountText := StrSubstNo(VATRateTxt, PurchLine."VAT %");
        DecLHTAmount := PurchLine."BC6_DEEE HT Amount";
        DecLVATAmount := PurchLine."BC6_DEEE VAT Amount";
        DecLTTCAmount := PurchLine."BC6_DEEE TTC Amount";
        DecLHTAmountLCY := PurchLine."BC6_DEEE HT Amount (LCY)";
    end;
    //COD91 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure COD91_OnBeforeConfirmPostProcedure(var PurchaseHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
        WITH PurchaseHeader DO BEGIN
            TESTFIELD(Status, Status::Released);
        end;
    end;
    //COD 93 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order (Yes/No)", 'OnBeforePurchQuoteToOrder', '', false, false)]
    local procedure COD93_OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        PurchaseHeader.TESTFIELD(Status, Status::Released);
    end;
    //COD 96 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure COD96_OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        RecGSalesLine: Record "Sales Line";
    begin
        RecGSalesLine.get(RecGSalesLine."Document Type", RecGSalesLine."Document No.", RecGSalesLine."Line No.");
        RecGSalesLine.SETFILTER("Document Type", '%1', PurchQuoteLine."BC6_Sales Document Type");
        RecGSalesLine.SETFILTER("Document No.", PurchQuoteLine."BC6_Sales No.");
        RecGSalesLine.SETFILTER("Line No.", '=%1', PurchQuoteLine."BC6_Sales Line No.");
        IF RecGSalesLine.FindFirst() THEN BEGIN
            RecGSalesLine.VALIDATE("BC6_Purch. Order No.", PurchOrderLine."Document No.");
            RecGSalesLine.VALIDATE("BC6_Purch. Line No.", PurchOrderLine."Line No.");
            RecGSalesLine.VALIDATE("BC6_Purch. Document Type", PurchOrderLine."Document Type");
            RecGSalesLine.MODIFY(TRUE);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnAfterInitFromPurchHeader', '', false, false)]
    local procedure COD96_OnCreatePurchHeaderOnAfterInitFromPurchHeader(var PurchOrderHeader: Record "Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Posting Date" := WORKDATE;
    end;
    //COD 260
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetEmailSubject', '', false, false)]
    local procedure COD260_OnBeforeGetEmailSubject(PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer; var EmailSubject: Text[250]; var IsHandled: Boolean)
    var
        YourReference: Text;
        Subject: Text[250];
        CompanyInformation: Record "Company Information";
        EmailSubjectPluralCapTxt: Label '%1 - %2', Comment = '%1 = Customer Name. %2 = Document Type in plural form';
        EmailSubjectCapTxt: Label '%1 - %2 %3', Comment = '%1 = Customer Name. %2 = Document Type %3 = Invoice No.';

    begin
        if PostedDocNo = '' then
            Subject := CopyStr(
                StrSubstNo(EmailSubjectPluralCapTxt, CompanyInformation.Name, EmailDocumentName), 1, MaxStrLen(Subject))
        else
            Subject := CopyStr(
                StrSubstNo(EmailSubjectCapTxt, CompanyInformation.Name, EmailDocumentName, PostedDocNo), 1, MaxStrLen(Subject));
        IF YourReference <> '' THEN
            Subject := COPYSTR(STRSUBSTNO('%1 - %2', Subject, YourReference), 1, MAXSTRLEN(Subject));
    end;
    //COD311
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeSalesLineCheck', '', false, false)]
    local procedure COD311_OnBeforeSalesLineCheck(SalesLine: Record "Sales Line"; var Rollback: Boolean; var IsHandled: Boolean)
    var
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        LastNotification: Notification;
    begin
        if ItemCheckAvail.SalesLineShowWarning(SalesLine) then
            Rollback := ItemCheckAvail.ShowAndHandleAvailabilityPage(SalesLine.RecordId);
        ItemCheckAvail.ShowNotificationDetails(LastNotification);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeCreateAndSendNotification', '', false, false)]
    local procedure COD311_OnBeforeCreateAndSendNotification(ItemNo: Code[20]; UnitOfMeasureCode: Code[20]; InventoryQty: Decimal; GrossReq: Decimal; ReservedReq: Decimal; SchedRcpt: Decimal; ReservedRcpt: Decimal; CurrentQuantity: Decimal; CurrentReservedQty: Decimal; TotalQuantity: Decimal; EarliestAvailDate: Date; RecordId: RecordID; LocationCode: Code[10]; ContextInfo: Dictionary of [Text, Text]; var Rollback: Boolean; var IsHandled: Boolean)
    var
        ItemAvailabilityCheck: Page "Item Availability Check";
        LastNotification: Notification;
        AvailabilityCheckNotification: Notification;
        VariantCode: code[20];
        DetailsTxt: Label 'Show details';
        NotificationMsg: Label 'The available inventory for item %1 is lower than the entered quantity at this location.', Comment = '%1=Item No.';
        DontShowAgainTxt: Label 'Don''t show again';
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        ItemCheckAvail: Codeunit "Item-Check Avail.";

    begin
        IsHandled := true; //TODO: CHECKME !

        AvailabilityCheckNotification.Id(CreateGuid);
        AvailabilityCheckNotification.Message(StrSubstNo(NotificationMsg, ItemNo));
        AvailabilityCheckNotification.Scope(NOTIFICATIONSCOPE::LocalScope);
        AvailabilityCheckNotification.AddAction(DetailsTxt, CODEUNIT::"Item-Check Avail.", 'ShowNotificationDetails');
        AvailabilityCheckNotification.AddAction(DontShowAgainTxt, CODEUNIT::"Item-Check Avail.", 'DeactivateNotification');
        ItemAvailabilityCheck.PopulateDataOnNotification(AvailabilityCheckNotification, ItemNo, UnitOfMeasureCode,
          InventoryQty, GrossReq, ReservedReq, SchedRcpt, ReservedRcpt, CurrentQuantity, CurrentReservedQty,
          TotalQuantity, EarliestAvailDate, LocationCode);

        LastNotification := AvailabilityCheckNotification;

        ItemAvailabilityCheck.PopulateDataOnNotification(AvailabilityCheckNotification, 'VariantCode', VariantCode);
        NotificationLifecycleMgt.SendNotificationWithAdditionalContext(
          AvailabilityCheckNotification, RecordId, ItemCheckAvail.GetItemAvailabilityNotificationId);
        exit;

    end;

    //COD 312 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust-Check Cr. Limit", 'OnNewCheckRemoveCustomerNotifications', '', false, false)]
    procedure COD312_OnNewCheckRemoveCustomerNotifications(RecId: RecordID; RecallCreditOverdueNotif: Boolean)
    var
        SalesHeader: Record 36;
        InstructionMgt: Codeunit "Instruction Mgt.";
        CustCheckCrLimit: codeunit 312;
        AdditionalContextId: Guid;
        CustCheckCreditLimit: Page "Check Credit Limit";
        LastNotification: Notification;

    begin

        if not CustCheckCreditLimit.SalesHeaderShowWarningAndGetCause(SalesHeader, AdditionalContextId) then
            SalesHeader.CustomerCreditLimitNotExceeded()
        else begin

            //TODO: à voir l'inside de else begin
            CustCheckCrLimit.ShowNotificationDetails(LastNotification);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust-Check Cr. Limit", 'OnBeforeCreateAndSendNotification', '', false, false)]
    local procedure COD312_OnBeforeCreateAndSendNotification(RecordId: RecordID; AdditionalContextId: Guid; Heading: Text[250]; NotificationToSend: Notification; var IsHandled: Boolean; var CustCheckCreditLimit: Page "Check Credit Limit");
    var
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        LastNotification: Notification;
        CreditLimitNotification: Notification;
        GetDetailsTxt: Label 'Show details';

    begin
        NotificationToSend.Message(Heading);
        NotificationToSend.Scope(NOTIFICATIONSCOPE::LocalScope);
        NotificationToSend.AddAction(GetDetailsTxt, CODEUNIT::"Cust-Check Cr. Limit", 'ShowNotificationDetails');
        CustCheckCreditLimit.PopulateDataOnNotification(NotificationToSend);

        LastNotification := CreditLimitNotification; //CODE SPECIFIQUE

        NotificationLifecycleMgt.SendNotificationWithAdditionalContext(NotificationToSend, RecordId, AdditionalContextId);
    END;
    //COD 415
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnAfterCheckPurchaseReleaseRestrictions', '', false, false)]
    local procedure COD415_OnCodeOnAfterCheckPurchaseReleaseRestrictions(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        FctMngt: Codeunit "BC6_Functions Mgt";

    begin
        FctMngt.CheckReturnOrderMandatoryFields(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', false, false)]
    local procedure COD415_OnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        RecLSalesLine: Record "Sales Line";
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
        IF PurchaseLine.FindFirst() THEN BEGIN
            REPEAT
                IF (PurchaseLine."BC6_Sales No." <> '') AND (PurchaseLine."BC6_Sales Line No." <> 0) THEN BEGIN
                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document Type", PurchaseLine."BC6_Sales Document Type");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document No.", PurchaseLine."BC6_Sales No.");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Line No.", PurchaseLine."BC6_Sales Line No.");
                    IF RecLSalesLine.FindFirst() THEN BEGIN
                        //>>PDW : le 04/08/15
                        RecLSalesLine.SuspendStatusCheck(TRUE);
                        //<<PDW : le 04/08/15
                        RecLSalesLine.VALIDATE("BC6_Purchase cost", PurchaseLine."BC6_Discount Direct Unit Cost");
                        RecLSalesLine.MODIFY;
                    END;
                END;
            UNTIL PurchaseLine.NEXT = 0;
        END;
        PurchaseLine.Modify(true);
        Commit();
    end;



}