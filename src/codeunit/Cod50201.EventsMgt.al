codeunit 50201 "BC6_EventsMgt"
{
    //TAB290
    //TODO:check code
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    local procedure T290_OnAfterCopyFromPurchInvLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchInvLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchInvLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchInvLine."BC6_DEEE TTC Amount";
        IF PurchInvLine."Allow Invoice Disc." THEN
            VATAmountLine."Inv. Disc. Base Amount" := VATAmountLine."Inv. Disc. Base Amount" + PurchInvLine."BC6_DEEE HT Amount";
    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    local procedure T290_OnAfterCopyFromPurchCrMemoLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
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
    local procedure T5765_OnAfterDeleteRequest_WarehouseReq(SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20])
    var
        RecLAffairStep: Record "BC6_Affair Steps";
        CommentLine: Record "Comment Line";

    begin
        RecLAffairStep.SETRANGE("Affair No.", CommentLine."No.");
        RecLAffairStep.DELETEALL();
    end;

    //TAB36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]

    local procedure T36_OnAfterOnInsert_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.ID := USERID;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', false, false)]
    local procedure OnDeleteOnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
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

    local procedure t27_OnAfterOnInsert_Item(var Item: Record Item; var xItem: Record Item)
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
    local procedure OnBeforeModifyEvent(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    begin
        IF NOT (UPPERCASE(USERID) IN ['CNE\BCSYS']) THEN
            Rec.TESTFIELD(Rec."Vendor No.");

    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeModify', '', false, false)]

    local procedure T290_OnInsertLineOnBeforeModify_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + FromVATAmountLine."BC6_DEEE TTC Amount";

    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLineOnBeforeInsert', '', false, false)]

    local procedure T290_OnInsertLineOnBeforeInsert_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; var FromVATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := FromVATAmountLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := FromVATAmountLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := FromVATAmountLine."BC6_DEEE TTC Amount";
    end;

    //Tab36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure T36_OnAfterInsertEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T36_OnAfterDeleteEvent_SalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record 79;
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

    local procedure T36_OnAfterCheckSellToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
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

    local procedure T36_OnAfterCopySellToCustomerAddressFieldsFromCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean)
    begin
        SellToCustomer."BC6_Combine Shipments by Order" := SellToCustomer."BC6_Combine Shipments by Order";
        SellToCustomer."BC6_Pay-to Customer No." := SellToCustomer."BC6_Pay-to Customer No.";
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order:
                SellToCustomer."BC6_Copy Sell-to Address" := SellToCustomer."BC6_Copy Sell-to Address";
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]

    local procedure T36_OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.UpdateIncoterm;  //procedure specifique 
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] THEN
            SalesHeader."Posting Description" := COPYSTR(FORMAT(SalesHeader."Sell-to Customer Name") + ' : ' + FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No."
                                       , 1, MAXSTRLEN(SalesHeader."Posting Description"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestStatusOpen', '', false, false)]

    local procedure T36_OnAfterTestStatusOpen_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        SalesHeader.GetCust(Cust."Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", FALSE, FALSE);
        Cust.TESTFIELD("Customer Posting Group");
        //TODO  // SalesHeader.CheckCrLimit;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetSalespersonCode', '', false, false)]

    local procedure T36_OnBeforeSetSalespersonCode_SalesHeader(var SalesHeader: Record "Sales Header"; SalesPersonCodeToCheck: Code[20]; var SalesPersonCodeToAssign: Code[20]; var IsHandled: Boolean)
    var
        Cust: Record Customer;
    begin
        Cust.Get();
        SalesHeader."BC6_Salesperson Filter" := Cust."BC6_Salesperson Filter";
        SalesHeader."BC6_Customer Sales Profit Group" := Cust."BC6_Custom. Sales Profit Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeShouldSearchForCustomerByName', '', false, false)]

    local procedure T36_OnBeforeShouldSearchForCustomerByName_SalesHeader(CustomerNo: Code[20]; var Result: Boolean; var IsHandled: Boolean; var CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestNoSeries', '', false, false)]

    local procedure OnAfterTestNoSeries(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
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

    local procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
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

    local procedure OnUpdateSalesLineByChangedFieldName(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldNo of
            SalesLine.FieldNo("Bin Code"):
                if SalesLine."No." <> '' THEN
                    IF (SalesLine."Location Code" = SalesHeader."Location Code") THEN
                        SalesLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCont', '', false, false)]

    local procedure OnAfterUpdateSellToCont(var SalesHeader: Record "Sales Header"; Customer: Record Customer; Contact: Record Contact; HideValidationDialog: Boolean)
    begin
        SalesHeader.UpdateSellToFax(SalesHeader."Sell-to Contact No.");
        SalesHeader.UpdateSellToMail(SalesHeader."Sell-to Contact No.");

    end;

    //TODO:not sure 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCust', '', false, false)]
    local procedure OnAfterUpdateSellToCust(var SalesHeader: Record "Sales Header"; Contact: Record Contact)
    var
        ContactNo: Code[20];
    begin
        Contact.GET(ContactNo);
        SalesHeader.UpdateSellToFax(ContactNo);
        SalesHeader.UpdateSellToMail(ContactNo);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateOutboundWhseHandlingTime', '', false, false)]
    local procedure OnBeforeUpdateOutboundWhseHandlingTime(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
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
    local procedure OnBeforeInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
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

    local procedure OnAfterInitFromSalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
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
    local procedure OnBeforeIsUnpostedEnabledForRecord(RecVariant: Variant; var Enabled: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //TAB38
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure T38_OnAfterInsertEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        Rec.ID := USERID
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T38_OnAfterDeleteEvent_PurchHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        CompanyInfo: Record 79;
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
    local procedure OnValidateBuyFromVendorNoOnAfterRecreateLines(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer)
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

    local procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."BC6_Pay-to Vend. No." := Vendor."BC6_Pay-to Vend. No.";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]

    local procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    begin
        //TODO  // UpdateIncoterm;
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] THEN
            PurchaseHeader."Posting Description" := COPYSTR(FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' : ' + FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No."
                                       , 1, MAXSTRLEN(PurchaseHeader."Posting Description"));

    end;
}