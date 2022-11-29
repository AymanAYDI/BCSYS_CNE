
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


}