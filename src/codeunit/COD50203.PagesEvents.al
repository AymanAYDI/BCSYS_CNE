
codeunit 50203 "BC6_PagesEvents"
{

    //PAGE 95
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Subform", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure P95_OnAfterValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesQuoteSub: Page "Sales Quote Subform";
    begin
        SalesQuoteSub.UpdateIncreasedFields();
    end;

    //Page 232
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnAfterOnOpenPage', '', true, true)]
    local procedure P232_OnAfterOnOpenPage(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingCustLedgEntry: Record "Cust. Ledger Entry")
    var
        Cust: record customer;
        CalcType: Enum "Customer Apply Calculation Type"; //CHECK ME!
        TextGestTierPayeur001: Label 'There is no ledger entries.; FRA=Il n''y a pas d''écitures.';

    begin
        Cust.get(Cust."No.");
        if CalcType = CalcType::Direct then begin
            IF NOT Cust.GET(CustLedgerEntry."Customer No.") AND NOT Cust.GET(CustLedgerEntry."BC6_Pay-to Customer No.") THEN ERROR(TextGestTierPayeur001);
        end;
    End;

    //Page 5703
    [EventSubscriber(ObjectType::Page, Page::"Location Card", 'OnAfterUpdateEnabled', '', false, false)]
    local procedure P5703_OnAfterUpdateEnabled(Location: Record Location)
    var
        GlobalFunctionMgt: Codeunit "BC6_GlobalFunctionMgt";
    begin

        GlobalFunctionMgt.SetNewReceiptBinCodeEnable((Location."Bin Mandatory" AND Location."Require Receive") OR Location."Directed Put-away and Pick");  //NewReceiptBinCodeEnable
        GlobalFunctionMgt.SetNewShipmentBinCodeEnable((Location."Bin Mandatory" AND Location."Require Shipment") OR Location."Directed Put-away and Pick"); //NewShipmentBinCodeEnable
        GlobalFunctionMgt.SetNewAssemblyShipmentBinCodeEnable(Location."Bin Mandatory" and not GlobalFunctionMgt.GetNewShipmentBinCodeEnable());
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
                        SalesHeader.TESTFIELD(Status, "Sales Document Status"::Released);
                        SalesHeader.RESET();
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesHeader.SETRANGE("No.", SalesHeader."No.");
                        REPORT.RUNMODAL(Report::"BC6_Return Order SAV Conf.", TRUE, FALSE, SalesHeader);
                    END;
                2:
                    BEGIN
                        SalesHeader.TESTFIELD(Status, "Sales Document Status"::Released);
                        "Sales Return Order".EnvoiMail;
                    END;
            end;
    end;
    //PAGE 161 //TODO
    [EventSubscriber(ObjectType::Page, Page::"Purchase Statistics", 'OnAfterCalculateTotals', '', false, false)]
    local procedure P161_OnAfterCalculateTotals(var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TotalAmt1: Decimal; var TotalAmt2: Decimal)
    var
        TempPurchLine: Record "Purchase Line" temporary;
        PurchPost: Codeunit "Purch.-Post";
        //TODO---check the global decimal variables.. 
        DecGTTCAmount: Decimal;
    begin
        //TODO://  SumPurchLinesTemp has changes in the parameters (when we merge the cod90)
        // PurchPost.SumPurchLinesTemp(
        //  PurchHeader , TempPurchLine, 0, TempPurchLine, TotalPurchLineLCY, VATAmount, VATAmountText,DecGHTAmount,DecGVATAmount,DecGTTCAmount,DecGHTAmountLCY);
        IF not PurchHeader."Prices Including VAT" THEN begin
            TotalAmt2 := TotalAmt2 + DecGTTCAmount;
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Statistics", 'OnAfterUpdateHeaderInfo', '', false, false)]
    local procedure P161_OnAfterUpdateHeaderInfo()
    var
        TempVATAmountLine: Record "VAT Amount Line" temporary;
    begin
        //TODO DecGVATAmount := TempVATAmountLine.GetTotalVATDEEEAmount;
        // DecGTTCAmount := TempVATAmountLine.GetTotalAmountDEEEInclVAT;
        // VATAmount := VATAmount + DecGVATAmount;

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
                end;
        end;
    end;
    //PAGE 54
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeInsertExtendedText', '', false, false)]
    local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchOrd: page "Purchase Order Subform";
        Unconditionally: Boolean;
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(PurchaseLine, Unconditionally) then begin
            PurchOrd.SaveRecord;
            TransferExtendedText.InsertPurchExtText(PurchaseLine);
            FctMngt.InsertPurchExtTextSpe(PurchaseLine);
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
                        end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnAfterValidateEvent', 'Vendor No.', false, false)]
    local procedure P233_OnAfterValidateEvent(var Rec: Record "Vendor Ledger Entry"; var xRec: Record "Vendor Ledger Entry")
    var
        GlobalFunctionMgt: Codeunit "BC6_GlobalFunctionMgt";
    begin
        IF Rec."Vendor No." = Rec."BC6_Pay-to Vend. No." THEN
            // BooGVendorNoStyle := TRUE
            GlobalFunctionMgt.SetBooGVendorNoStyle(true)
        ELSE
            //BooGVendorNoStyle := FALSE; // JE PENSE QUE CE TRAITEMENT EST UNITILE
            GlobalFunctionMgt.SetBooGVendorNoStyle(false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnAfterOpenPage', '', false, false)]
    local procedure P233_OnAfterOpenPage(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplyingVendLedgEntry: Record "Vendor Ledger Entry")
    var
        Vend: Record Vendor;
        CalcType: Enum "Vendor Apply Calculation Type";
        TextGestTierPayeur001: Label 'There is no ledger entries.', comment = 'FRA="Il n''y a pas d''écitures."';
    begin
        Vend.GET(VendorLedgerEntry."Entry No."); //CHECK THE GET()
        if CalcType = CalcType::Direct then begin
            IF NOT Vend.GET(VendorLedgerEntry."Vendor No.") AND NOT Vend.GET(Vend."BC6_Pay-to Vend. No.") THEN ERROR(TextGestTierPayeur001);
        end;
    end;


    //COD 90
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnBeforeRoundAmount', '', false, false)]
    local procedure COD90_OnPostPurchLineOnBeforeRoundAmount(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; SrcCode: Code[10])
    var
        FctMngt: Codeunit "BC6_Functions Mgt";

    begin
        if PurchaseLine.Quantity <> 0 then
            FctMngt.MntDivisionDEEE(PurchaseLine."Qty. to Invoice", PurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterReverseAmount', '', false, false)]
    local procedure OnAfterReverseAmount(var PurchLine: Record "Purchase Line")
    var
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        FctMngt.MntInverseDEEE(PurchLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterFillTempLines', '', false, false)]

    local procedure COD90_OnRunOnAfterFillTempLines(var PurchHeader: Record "Purchase Header")
    var
        GlobalFunction: Codeunit "BC6_GlobalFunctionMgt";
    begin
        GlobalFunction.SetGDecMntTTCDEEE(0);
        GlobalFunction.SetGDecMntHTDEEE(0);
    end;

    //ligne718 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostVendorEntry', '', false, false)]
    // procedure COD90_OnAfterPostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnPostLedgerEntryOnAfterGenJnlPostLine', '', false, false)]

    local procedure COD90_OnPostLedgerEntryOnAfterGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        _EcoPartnerDEEE: Code[10];
        _DEEECategoryCode: code[10];
        GlobalFunction: Codeunit "BC6_GlobalFunctionMgt";
    begin

        GenJnlLine."BC6_DEEE HT Amount" := TotalPurchLine."BC6_DEEE HT Amount";
        GenJnlLine."BC6_DEEE VAT Amount" := TotalPurchLine."BC6_DEEE VAT Amount";
        GenJnlLine."BC6_DEEE TTC Amount" := TotalPurchLine."BC6_DEEE TTC Amount";
        GenJnlLine."BC6_DEEE HT Amount (LCY)" := TotalPurchLine."BC6_DEEE HT Amount (LCY)";
        GenJnlLine."BC6_Eco partner DEEE" := _EcoPartnerDEEE;
        GenJnlLine."BC6_DEEE Category Code" := _DEEECategoryCode;

        GenJnlLine.Amount := GenJnlLine.Amount - GlobalFunction.GetGDecMntTTCDEEE();
        GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" - GlobalFunction.GetGDecMntTTCDEEE();
        GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - GlobalFunction.GetGDecMntTTCDEEE();
        GenJnlLine."Payment Method Code" := GenJnlLine."Payment Method Code";

    end;

    //TAB 43 //CHANGEMENT DE L'ANCIENNE PROC CopyCommentLines pour le cod 90
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
        AssemPost: Codeunit "Assembly-Post";
    begin
        IF RecLNavisetup.GET AND RecLNavisetup."Date jour ds date facture Acha" then
            AssemPost.SetPostingDate(TRUE, WORKDATE);
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', false, false)]
    local procedure CU90_OnBeforePostVendorEntry_Purch_Post(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        GlobalFunction: Codeunit "BC6_GlobalFunctionMgt";
    begin
        //>>MIGRATION NAV 2013 - 2017
        GenJnlLine."BC6_DEEE HT Amount" := TotalPurchLine."BC6_DEEE HT Amount";
        GenJnlLine."BC6_DEEE VAT Amount" := TotalPurchLine."BC6_DEEE VAT Amount";
        GenJnlLine."BC6_DEEE TTC Amount" := TotalPurchLine."BC6_DEEE TTC Amount";
        GenJnlLine."BC6_DEEE HT Amount (LCY)" := TotalPurchLine."BC6_DEEE HT Amount (LCY)";
        GenJnlLine."BC6_Eco partner DEEE" := GlobalFunction.Get_PurchEcoPartnerDEEE();
        GenJnlLine."BC6_DEEE Category Code" := GlobalFunction.Get_PurchDEEECategoryCode();

        GenJnlLine.Amount := GenJnlLine.Amount - GlobalFunction.Get_PurchGDecMntTTCDEEE();
        GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" - GlobalFunction.Get_PurchGDecMntTTCDEEE();
        GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - GlobalFunction.Get_PurchGDecMntTTCDEEE();
        //>>DEEE1.00 : DEEE amount management
        GenJnlLine."Payment Method Code" := GenJnlLine."Payment Method Code";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostVendorEntryOnAfterInitNewLine', '', false, false)]
    local procedure CU90_OnPostVendorEntryOnAfterInitNewLine_Purch_Post(var PurchaseHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.Description := PurchaseHeader."Pay-to Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInitNewGenJnlLineFromPostInvoicePostBufferLine', '', false, false)]
    local procedure OnBeforeInitNewGenJnlLineFromPostInvoicePostBufferLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; InvoicePostBuffer: Record "Invoice Post. Buffer"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        GenJnlLine.InitNewLine(
         PurchHeader."Posting Date", PurchHeader."Document Date", PurchHeader."Pay-to Name",
         InvoicePostBuffer."Global Dimension 1 Code", InvoicePostBuffer."Global Dimension 2 Code",
         InvoicePostBuffer."Dimension Set ID", PurchHeader."Reason Code");

    end;

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
        PurchaseHeader.TESTFIELD(Status, "Sales Document Status"::Released);
    end;
    //COD 96 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure COD96_OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        RecGSalesLine: Record "Sales Line";
    begin
        //RecGSalesLine.get(RecGSalesLine."Document Type", RecGSalesLine."Document No.", RecGSalesLine."Line No.");
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

    END;

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
        SalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        CustCheckCrLimit: codeunit "Cust-Check Cr. Limit";
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
        RecLPurchLine2: Record "Purchase Line";
    begin
        RecLPurchLine2.RESET;
        RecLPurchLine2.SETRANGE(RecLPurchLine2."Document Type", PurchaseHeader."Document Type");
        RecLPurchLine2.SETRANGE(RecLPurchLine2."Document No.", PurchaseHeader."No.");
        IF RecLPurchLine2.FindFirst() THEN BEGIN
            REPEAT
                IF (RecLPurchLine2."BC6_Sales No." <> '') AND (RecLPurchLine2."BC6_Sales Line No." <> 0) THEN BEGIN
                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document Type", RecLPurchLine2."BC6_Sales Document Type");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Document No.", RecLPurchLine2."BC6_Sales No.");
                    RecLSalesLine.SETRANGE(RecLSalesLine."Line No.", RecLPurchLine2."BC6_Sales Line No.");
                    IF RecLSalesLine.FindFirst() THEN BEGIN
                        //>>PDW : le 04/08/15
                        RecLSalesLine.SuspendStatusCheck(TRUE);
                        //<<PDW : le 04/08/15
                        RecLSalesLine.VALIDATE("BC6_Purchase cost", RecLPurchLine2."BC6_Discount Direct Unit Cost");
                        RecLSalesLine.MODIFY;
                    END;
                END;
            UNTIL RecLPurchLine2.NEXT = 0;
        END;
        PurchaseLine.Modify(true);
        //////
        Commit();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]

    local procedure COD415_OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        HideValidationDialog: Boolean;
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN BEGIN
            FctMngt.SetHideValidationDialog(HideValidationDialog);
            IF PurchaseHeader.ControleMinimMNTandQTE THEN
                EXIT;
        END;
        //TODO: checkMe ! 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeCheckPurchaseHeaderPendingApproval', '', false, false)]
    local procedure COD415_OnBeforeCheckPurchaseHeaderPendingApproval(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text002: Label 'This document can only be released when the approval process is complete.';

    begin
        IsHandled := true;

        if ApprovalsMgmt.IsPurchaseHeaderPendingApproval(PurchaseHeader) then
            Error(Text002);
        COMMIT;
    end;

}