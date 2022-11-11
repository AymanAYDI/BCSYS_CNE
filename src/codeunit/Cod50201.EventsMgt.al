codeunit 50201 "BC6_EventsMgt"
{
    //TAB290
    //TODO:check code
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchInvLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchInvLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchInvLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchInvLine."BC6_DEEE TTC Amount";
        IF PurchInvLine."Allow Invoice Disc." THEN
            VATAmountLine."Inv. Disc. Base Amount" := VATAmountLine."Inv. Disc. Base Amount" + PurchInvLine."BC6_DEEE HT Amount";
    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchCrMemoLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchCrMemoLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchCrMemoLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchCrMemoLine."BC6_DEEE TTC Amount";

        IF PurchCrMemoLine."Allow Invoice Disc." THEN
            VATAmountLine."Inv. Disc. Base Amount" := PurchCrMemoLine."Line Amount";

    end;

    //TAB5765 
    //TODO: check si No. appartient au record commentLine 
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Request", 'OnAfterDeleteRequest', '', false, false)]
    procedure T5765_OnAfterDeleteRequest_WarehouseReq(SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20])
    var
        RecLAffairStep: Record "BC6_Affair Steps";
        CommentLine: Record "Comment Line";

    begin
        RecLAffairStep.SETRANGE("Affair No.", CommentLine."No.");
        RecLAffairStep.DELETEALL();
    end;

    //TAB36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]

    procedure T36_OnAfterOnInsert_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.ID := USERID;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', false, false)]
    procedure OnDeleteOnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        CompanyInfo: Record "Company Information";
        TextG003: Label 'Warning: you have already placed this order purchase.';
    begin
        CompanyInfo.FINDFIRST();
        //TODO: i must have IsDeleteFromReturnOrder ( codeunit 50052 & we need to find G_ReturnOrderMgt )
        // IF CompanyInfo."BC6_Branch Company" THEN
        //     IF SalesHeader."BC6_Purchase No. Order Lien" <> '' THEN
        //         ERROR(TextG003);
        // IF NOT IsDeleteFromReturnOrder THEN BEGIN
        //     G_ReturnOrderMgt.DeleteRelatedDocument(SalesHeader);

        //     G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(SalesHeader);
        // END;
    end;
    //TAB27
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterOnInsert', '', false, false)]

    procedure t27_OnAfterOnInsert_Item(var Item: Record Item; var xItem: Record Item)
    var
        NaviSetup: Record "BC6_Navi+ Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //TODO
        // "Creation Date" := WORKDATE;
        // Item.User := USERID;
        NaviSetup.GET();
        NaviSetup.TESTFIELD(NaviSetup."Base Unit of Measure");
        NaviSetup.TESTFIELD(NaviSetup."Gen. Prod. Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."VAT Prod. Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."Inventory Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."Sales Unit of Measure");

        ItemUnitOfMeasure."Item No." := Item."No.";
        ItemUnitOfMeasure.Code := NaviSetup."Base Unit of Measure";
        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
        ItemUnitOfMeasure.INSERT();
        Item."Base Unit of Measure" := NaviSetup."Base Unit of Measure";
        Item."Purch. Unit of Measure" := NaviSetup."Base Unit of Measure";

        Item."Costing Method" := NaviSetup."Costing Method";
        Item.VALIDATE("Gen. Prod. Posting Group", NaviSetup."Gen. Prod. Posting Group");
        Item.VALIDATE("VAT Prod. Posting Group", NaviSetup."VAT Prod. Posting Group");
        Item.VALIDATE("Inventory Posting Group", NaviSetup."Inventory Posting Group");
        Item.VALIDATE("Sales Unit of Measure", NaviSetup."Sales Unit of Measure");
        Item.VALIDATE("Replenishment System", NaviSetup."Replenishment System");
        Item.VALIDATE("Lead Time Calculation", NaviSetup."Lead Time Calculation Item");
        Item.VALIDATE("Reordering Policy", NaviSetup."Reordering Policy");
        Item.VALIDATE("Include Inventory", NaviSetup."Include Inventory");
        Item.VALIDATE(Reserve, NaviSetup."Reserve Item");
        Item.VALIDATE("Order Tracking Policy", NaviSetup."Order Tracking Policy");
        Item.VALIDATE("Unit Price");
        Item."BC6_Number of Units DEEE" := 1;

    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeModifyEvent', '', false, false)]
    procedure OnBeforeModifyEvent(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    begin
        IF NOT (UPPERCASE(USERID) IN ['CNE\BCSYS']) THEN
            Rec.TESTFIELD(Rec."Vendor No.");

    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeModify', '', false, false)]

    procedure T290_OnInsertLineOnBeforeModify_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + FromVATAmountLine."BC6_DEEE TTC Amount";

    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeInsert', '', false, false)]

    procedure T290_OnInsertLineOnBeforeInsert_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; var FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := FromVATAmountLine."BC6_DEEE TTC Amount";
    end;

    //Tab36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    procedure T36_OnAfterInsertEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    procedure T36_OnAfterDeleteEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record "Company Information";
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
    //TODO:Codeunit // G_ReturnOrderMgt: Codeunit 50052;
    begin
        CompanyInfo.FINDFIRST();
        IF CompanyInfo."BC6_Branch Company" THEN BEGIN
            IF Rec."BC6_Purchase No. Order Lien" <> '' THEN
                ERROR(TextG003);
        END;
        //TODO: codeunint 
        // IF NOT IsDeleteFromReturnOrder THEN BEGIN
        //          G_ReturnOrderMgt.DeleteRelatedDocument(Rec);

        //          G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(Rec);
        //        END;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]

    procedure T36_OnAfterCheckSellToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
    var
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
        RecGParamNavi: Record "BC6_Navi+ Setup";
    begin
        IF CurrentFieldNo <> 0 THEN
            IF RecGParamNavi.FIND() THEN BEGIN
                IF RecGParamNavi."Used Post-it" <> '' THEN BEGIN
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", SalesHeader."Sell-to Customer No.");
                    IF RecGCommentLine.FIND('-') THEN BEGIN
                        FrmGLignesCommentaires.EDITABLE(FALSE);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        IF FrmGLignesCommentaires.RUNMODAL() = ACTION::OK THEN;
                    END;
                END;
                RecGCommentLine.SETRANGE(Code, '');
            END;


    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]

    procedure T36_OnAfterCopySellToCustomerAddressFieldsFromCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean)
    begin
        SellToCustomer."BC6_Combine Shipments by Order" := SellToCustomer."BC6_Combine Shipments by Order";
        SellToCustomer."BC6_Pay-to Customer No." := SellToCustomer."BC6_Pay-to Customer No.";
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order:
                SellToCustomer."BC6_Copy Sell-to Address" := SellToCustomer."BC6_Copy Sell-to Address";
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]

    procedure T36_OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.UpdateIncoterm;  //procedure specifique 
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] THEN
            SalesHeader."Posting Description" := COPYSTR(FORMAT(SalesHeader."Sell-to Customer Name") + ' : ' + FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No."
                                       , 1, MAXSTRLEN(SalesHeader."Posting Description"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestStatusOpen', '', false, false)]

    procedure T36_OnAfterTestStatusOpen_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        SalesHeader.GetCust(Cust."Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", FALSE, FALSE);
        Cust.TESTFIELD("Customer Posting Group");
        //TODO  // SalesHeader.CheckCrLimit;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetSalespersonCode', '', false, false)]

    procedure T36_OnBeforeSetSalespersonCode_SalesHeader(var SalesHeader: Record "Sales Header"; SalesPersonCodeToCheck: Code[20]; var SalesPersonCodeToAssign: Code[20]; var IsHandled: Boolean)
    var
        Cust: Record Customer;
    begin
        Cust.Get();
        SalesHeader."BC6_Salesperson Filter" := Cust."BC6_Salesperson Filter";
        SalesHeader."BC6_Customer Sales Profit Group" := Cust."BC6_Custom. Sales Profit Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeShouldSearchForCustomerByName', '', false, false)]

    procedure T36_OnBeforeShouldSearchForCustomerByName_SalesHeader(CustomerNo: Code[20]; var Result: Boolean; var IsHandled: Boolean; var CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestNoSeries', '', false, false)]

    procedure OnAfterTestNoSeries(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":
                BEGIN
                    IF SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV THEN
                        SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."BC6_SAV Return Order Nos.")
                    ELSE
                        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', false, false)]

    procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":
                //>>BC6
                // OLD STD NoSeriesCode := SalesSetup."Return Order Nos.";
                BEGIN
                    IF SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV THEN
                        NoSeriesCode := SalesReceivablesSetup."BC6_SAV Return Order Nos."
                    ELSE
                        NoSeriesCode := SalesReceivablesSetup."Return Order Nos.";
                END;
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSalesLineByChangedFieldName', '', false, false)]

    procedure OnUpdateSalesLineByChangedFieldName(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldNo of
            SalesLine.FieldNo("Bin Code"):
                if SalesLine."No." <> '' THEN
                    IF (SalesLine."Location Code" = SalesHeader."Location Code") THEN
                        SalesLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCont', '', false, false)]

    procedure OnAfterUpdateSellToCont(var SalesHeader: Record "Sales Header"; Customer: Record Customer; Contact: Record Contact; HideValidationDialog: Boolean)
    begin
        SalesHeader.UpdateSellToFax(SalesHeader."Sell-to Contact No.");
        SalesHeader.UpdateSellToMail(SalesHeader."Sell-to Contact No.");

    end;

    //TODO:not sure 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCust', '', false, false)]
    procedure OnAfterUpdateSellToCust(var SalesHeader: Record "Sales Header"; Contact: Record Contact)
    var
        ContactNo: Code[20];
    begin
        Contact.GET(ContactNo);
        SalesHeader.UpdateSellToFax(ContactNo);
        SalesHeader.UpdateSellToMail(ContactNo);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateOutboundWhseHandlingTime', '', false, false)]
    procedure OnBeforeUpdateOutboundWhseHandlingTime(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Location: Record location;
        InvtSetup: Record "Inventory Setup";
    begin
        IsHandled := true;
        if SalesHeader."Location Code" <> '' then begin
            if Location.Get(SalesHeader."Location Code") then
                SalesHeader."Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            SalesHeader.VALIDATE(SalesHeader."Shipment Method Code");
            IF SalesHeader."BC6_Bin Code" = '' THEN
                SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        end else begin
            if InvtSetup.Get then
                SalesHeader."Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            SalesHeader."BC6_Bin Code" := '';
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitFromSalesHeader', '', false, false)]
    procedure OnBeforeInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    begin
        SalesHeader.VALIDATE("Order Date", WORKDATE);
        SalesHeader.VALIDATE("Posting Date", WORKDATE);
        IF SalesHeader."Shipment Date" < WORKDATE THEN
            SalesHeader.VALIDATE("Shipment Date", WORKDATE)
        ELSE
            SalesHeader."Shipment Date" := SourceSalesHeader."Shipment Date";
        SalesHeader."External Document No." := SourceSalesHeader."External Document No.";
        SalesHeader."BC6_Document description" := SourceSalesHeader."BC6_Document description";
    end;

    procedure OnAfterInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    var
        Location: Record Location;
    begin
        IF SourceSalesHeader."Location Code" <> '' THEN BEGIN
            IF Location.GET(SalesHeader."Location Code") THEN
                IF SourceSalesHeader."BC6_Bin Code" = '' THEN
                    SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        END ELSE BEGIN
            SalesHeader."BC6_Bin Code" := '';
        END;

    end;



    // COD
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Instruction Mgt.", 'OnBeforeIsUnpostedEnabledForRecord', '', false, false)]
    procedure OnBeforeIsUnpostedEnabledForRecord(RecVariant: Variant; var Enabled: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //TAB38
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    procedure T38_OnAfterInsertEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    procedure T38_OnAfterDeleteEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record "Company Information";
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
    //TODO:Codeunit // G_ReturnOrderMgt: Codeunit 50052;
    begin
        CompanyInfo.FINDFIRST();
        IF CompanyInfo."BC6_Branch Company" THEN BEGIN
            IF Rec."BC6_Sales No. Order Lien" <> '' THEN
                ERROR(TextG003);
        END;     //    TODO:Codeunit 
                 // IF Rec."Document Type" = Rec."Document Type"::Order THEN
                 //G_ReturnOrderMgt.DeleteRelatedPurchOrderNo(Rec)
                 // ELSE
                 // IF (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
                 //     G_ReturnOrderMgt.DeleteRelatedPurchReturnOrderNo(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterRecreateLines', '', false, false)]
    procedure OnValidateBuyFromVendorNoOnAfterRecreateLines(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer)
    var
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
        RecGParamNavi: Record "BC6_Navi+ Setup";
    //To check
    begin

        IF CallingFieldNo <> 0 THEN
            IF RecGParamNavi.FIND THEN BEGIN
                IF RecGParamNavi."Used Post-it" <> '' THEN BEGIN
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", PurchaseHeader."Buy-from Vendor No.");
                    IF RecGCommentLine.FIND('-') THEN BEGIN
                        FrmGLignesCommentaires.EDITABLE(FALSE);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        IF FrmGLignesCommentaires.RUNMODAL = ACTION::OK THEN;
                    END;
                END;
                RecGCommentLine.SETRANGE(Code, '');
            END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEmptySellToCustomerAndLocation', '', false, false)]

    procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."BC6_Pay-to Vend. No." := Vendor."BC6_Pay-to Vend. No.";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]

    procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    begin
        //TODO  // UpdateIncoterm;
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] THEN
            PurchaseHeader."Posting Description" := COPYSTR(FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' : ' + FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No."
                                       , 1, MAXSTRLEN(PurchaseHeader."Posting Description"));
    end;

    //cod427
    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICOutBoxSalesHeaderTransferFields', '', false, false)]

    procedure OnAfterICOutBoxSalesHeaderTransferFields(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesHeader: Record "Sales Header")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesHeader."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader', '', false, false)]

    procedure OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesInvHdr: Record "Sales Invoice Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesInvHdr."Ship-to Contact";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader', '', false, false)]

    procedure OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesCrMemoHdr: Record "Sales Cr.Memo Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesCrMemoHdr."Ship-to Contact";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader', '', false, false)]

    procedure OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader(var ICOutboxPurchHeader: Record "IC Outbox Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        ICOutBoxPurchHeader."BC6_Ship-to Contact" := PurchHeader."Ship-to Contact";

    end;


    //TODO: to check if the event is true
    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesDocumentOnBeforeSalesHeaderInsert', '', false, false)]

    procedure OnCreateSalesDocumentOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header"; ICInboxSalesHeader: Record "IC Inbox Sales Header")
    begin
        SalesHeader."Your Reference" := ICInboxSalesHeader."External Document No.";
        SalesHeader."Ship-to Contact" := ICInboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesLinesOnAfterValidateNo', '', false, false)]
    procedure OnCreateSalesLinesOnAfterValidateNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; ICInboxSalesLine: Record "IC Inbox Sales Line")
    begin
        SalesLine."BC6_Purchase No. Order Lien" := ICInboxSalesLine."Document No.";
        SalesLine."BC6_Purchase No. Line Lien" := ICInboxSalesLine."Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreatePurchDocumentOnBeforePurchHeaderInsert', '', false, false)]
    procedure OnCreatePurchDocumentOnBeforePurchHeaderInsert(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    begin
        PurchaseHeader."Ship-to Contact" := ICInboxPurchaseHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxPurchHeaderInsert', '', false, false)]
    procedure OnBeforeICInboxPurchHeaderInsert(var ICInboxPurchaseHeader: Record "IC Inbox Purchase Header"; ICOutboxSalesHeader: Record "IC Outbox Sales Header")
    begin
        ICInboxPurchaseHeader."BC6_Ship-to Contact" := ICOutboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesHeaderInsert', '', false, false)]
    procedure OnBeforeICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."BC6_Ship-to Contact" := ICOutboxPurchaseHeader."BC6_Ship-to Contact";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICInboxSalesHeaderInsert', '', false, false)]

    procedure OnAfterICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."External Document No." := ICOutboxPurchaseHeader."Your Reference";
    end;
    //COD550
    [EventSubscriber(ObjectType::Codeunit, codeunit::"VAT Rate Change Conversion", 'OnBeforeUpdateItem', '', false, false)]

    procedure COD550_OnBeforeUpdateItem(var Item: Record Item; var VATRateChangeSetup: Record "VAT Rate Change Setup"; var IsHandled: Boolean)
    var
        RecRef: RecordRef;
        VATRateChangeConv: Codeunit "VAT Rate Change Conversion";
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IsHandled := true;
        with VATRateChangeSetup do BEGIN
            IF "Item Filter" <> '' THEN
                Item.SETFILTER("No.", "Item Filter");
            Item.SETRANGE(Blocked, FALSE);
            IF Item.FIND('-') THEN
                REPEAT
                    RecRef.GETTABLE(Item);
                    fctMgt.UpdateRec(RecRef, VATRateChangeConv.ConvertVATProdPostGrp("Update Items"), VATRateChangeConv.ConvertGenProdPostGrp("Update Items"));
                UNTIL Item.NEXT = 0;
        end;

    end;

    //COD841  
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Cash Flow Management", 'OnBeforeGetTaxAmountFromSalesOrder', '', false, false)]

    procedure COD841_OnBeforeGetTaxAmountFromSalesOrder(SalesHeader: Record "Sales Header"; var VATAmount: Decimal; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IsHandled := true;
        fctMgt.GetTaxAmountFromSalesOrder_CNE(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Cash Flow Management", 'OnBeforeGetTaxAmountFromPurchaseOrder', '', false, false)]

    procedure OnBeforeGetTaxAmountFromPurchaseOrder(PurchaseHeader: Record "Purchase Header"; var VATAmount: Decimal; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IsHandled := true;
    end;

    //COD1302 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterIsBillToAddressEqualToSellToAddress', '', false, false)]
    procedure OnAfterIsBillToAddressEqualToSellToAddress(SellToSalesHeader: Record "Sales Header"; BillToSalesHeader: Record "Sales Header"; var Result: Boolean)
    begin
        Result := Result and (BillToSalesHeader."Bill-to Name" = SellToSalesHeader."Sell-to Customer Name");
    end;
    //COD1330 

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Instruction Mgt.", 'OnAfterIsEnabled', '', false, false)]

    procedure OnAfterIsEnabled(InstructionType: Code[50]; var Result: Boolean)
    var
        fctMgt: Codeunit "BC6_FctMangt";
    begin
        IF InstructionType = fctMgt.ShowPostedConfirmationMessageCode THEN
            Result := false;
    end;
    //COD5063

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]

    procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
        SalesHeader.MODIFY;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnRestoreSalesDocumentOnAfterSalesHeaderInsert', '', false, false)]
    procedure OnRestoreSalesDocumentOnAfterSalesHeaderInsert(var SalesHeader: Record "Sales Header"; SalesHeaderArchive: Record "Sales Header Archive");
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Warehouse Document-Print", 'OnBeforePrintInvtPickHeader', '', false, false)]

    procedure OnBeforePrintInvtPickHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean; var HideDialog: Boolean)
    var
    //TODO:report   //  WhsePick : Report 50047;
    begin
        IsHandled := true;
        WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
        //TODO:report
        //   WhsePick.SETTABLEVIEW(WarehouseActivityHeader);
        //   WhsePick.InitRequest(1,FALSE,TRUE);
        //   WhsePick.USEREQUESTPAGE(NOT HideDialog);
        //   WhsePick.RUNMODAL;

    end;
    //COD5813
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Purchase Receipt Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]

    procedure COD5813_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(PurchRcptLine: Record "Purch. Rcpt. Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
        PurchLine: Record "Purchase Line";

    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Purch. Rcpt. Header",
  0,
  PurchRcptLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Rcpt.",
  DATABASE::"Purchase Line",
 PurchLine."Document Type"::Order,
  PurchRcptLine."Order No.",
  PurchRcptLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);
    end;

    //COD5814
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Return Shipment Line", 'OnAfterCopyItemJnlLineFromReturnShpt', '', false, false)]
    procedure OnAfterCopyItemJnlLineFromReturnShpt(var ItemJournalLine: Record "Item Journal Line"; ReturnShipmentHeader: Record "Return Shipment Header"; ReturnShipmentLine: Record "Return Shipment Line"; var WhseUndoQty: Codeunit "Whse. Undo Quantity")

    var
        //TODO: à verifier srtt les declarations 
        fctMgt: Codeunit "BC6_FctMangt";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        PurchLine: Record "Purchase Line";
        NextLineNo: Integer;
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJournalLine,
          DATABASE::"Return Shipment Header",
          0,
          PurchLine."Document No.",
          0,
          TempWhseJnlLine."Reference Document"::"Posted Rtrn. Shipment",
          DATABASE::"Purchase Line",
          PurchLine."Document Type"::"Return Order",
          ReturnShipmentLine."Return Order No.",
          ReturnShipmentLine."Return Order Line No.",
          TempWhseJnlLine, NextLineNo);
    end;
    //COD5815
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnCodeOnBeforeUndoLoop', '', false, false)]
    procedure OnCodeOnBeforeUndoLoop(var SalesShptLine: Record "Sales Shipment Line")
    var
        TempWhseJnlLine: Record 7311 TEMPORARY;

    begin
        IF NOT TempWhseJnlLine.ISEMPTY THEN
            TempWhseJnlLine.DELETEALL;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]
    procedure COD5815_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(SalesShptLine: Record "Sales Shipment Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
        SalesLine: Record "Sales Line";
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Sales Shipment Header",
  0,
ItemJnlLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Shipment",
  DATABASE::"Sales Line",
  SalesLine."Document Type"::Order,
  ItemJnlLine."Order No.",
  ItemJnlLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);

    end;
    //COD5817
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestPostedInvtPutAwayLine', '', false, false)]

    procedure OnBeforeTestPostedInvtPutAwayLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean; UndoType: Integer; UndoID: Code[20])
    var
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        Text008: label 'You cannot undo line %1 because warehouse receipt lines have already been posted.';
        Text002: Label 'You cannot undo line %1 because warehouse put-away lines have already been created.';
    begin
        IsHandled := true;
        IF NOT ((SourceType = 39) AND (SourceSubtype = 1)) AND
           NOT ((SourceType = 37) AND (SourceSubtype = 5)) THEN
            //la partie du TestPostedInvtPutAwayLine
            with RegisteredWhseActivityLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, -1, true);
                SetRange("Activity Type", "Activity Type"::"Put-away");
                if not IsEmpty() then
                    Error(Text002, UndoLineNo);
            end;
        //la partie du TestPostedInvtPutAwayLine

        IF NOT ((SourceType = 39) AND (SourceSubtype = 5)) AND NOT ((SourceType = 37) AND (SourceSubtype = 1)) THEN
            //la partie du TestWhseWorksheetLine
            with WhseWorksheetLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, true);
                if not IsEmpty() then
                    Error(Text008, UndoLineNo);
            end;
        //la partie du TestWhseWorksheetLine

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestWhseWorksheetLine', '', false, false)]

    procedure OnBeforeTestWhseWorksheetLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean)
    begin
        //la partie du TestWhseWorksheetLine
        IsHandled := true;
    end;

    //COD6620
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert', '', false, false)]
    procedure OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert(var ToPurchaseHeader: Record "Purchase Header"; FromSalesHeader: Record "Sales Header")
    var
        IsSAVReturnOrder: Boolean;
    begin
        IF (FromSalesHeader."Document Type" = FromSalesHeader."Document Type"::"Return Order") THEN
            IsSAVReturnOrder := TRUE;
        ToPurchaseHeader."BC6_Return Order Type" := FromSalesHeader."BC6_Return Order Type";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeAssignDescriptionsFromSalesLine', '', false, false)]

    procedure OnBeforeAssignDescriptionsFromSalesLine(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    begin
        PurchaseLine."BC6_Return Order Type" := SalesLine."BC6_Return Order Type";
        //TODO: je dois avoir la valeur du IsSAVReturnOrder pour faire le test 
        // IF IsSAVReturnOrder THEN BEGIN
        //   "Solution Code" := FromSalesLine."Solution Code";
        //   "Return Comment" := FromSalesLine."Return Comment";
        //   "Return Order-Shpt Sales Order" := FromSalesLine."Return Order-Shpt Sales Order";
        //   "Series No." := FromSalesLine."Series No.";
        // END;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCheckFromSalesHeader', '', false, false)]

    procedure OnBeforeCheckFromSalesHeader(SalesHeaderFrom: Record "Sales Header"; SalesHeaderTo: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesDocType: enum "Sales Document Type";
        BoolGCopyLinesExactly: Boolean;

    begin
        IsHandled := true;
        CASE SalesHeaderFrom."Document Type" OF
            SalesDocType::Quote,
  SalesDocType::"Blanket Order",
  SalesDocType::Order,
  SalesDocType::Invoice,
  SalesDocType::"Return Order",
  SalesDocType::"Credit Memo":
                IF NOT BoolGCopyLinesExactly THEN BEGIN
                    SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                    SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                END ELSE BEGIN
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                    SalesHeaderFrom."Your Reference" := SalesHeaderTo."Your Reference";
                    SalesHeaderFrom."BC6_Affair No." := SalesHeaderTo."BC6_Affair No.";
                    // IF NOT SalesHeaderFrom.MODIFY THEN;      //TODO:then what ? 
                END;
            ELSE BEGIN
                SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
            END;
        end;
    end;

}