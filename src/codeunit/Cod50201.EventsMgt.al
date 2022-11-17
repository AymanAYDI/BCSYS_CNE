codeunit 50201 "BC6_EventsMgt"
{
    //TAB111
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    procedure T111_OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine_SalesShipmentLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean; TempSalesLine: Record "Sales Line" temporary; SalesInvHeader: Record "Sales Header")
    var
        RecLSalesShipmentHeader: Record "Sales Shipment Header";
        CstG1000000000: label '%1 of %2 - %3', Comment = 'FRA="%1 du %2 - %3"';
        CstG1000000001: label 'Your Reference : ', Comment = 'FRA="Votre Référence : "';
        CstG1000000002: label '%1 %2', Comment = 'FRA="%1 %2"';
    begin
        RecLSalesShipmentHeader.GET(SalesShptLine."Document No.");
        SalesLine.Description := COPYSTR(
                                   STRSUBSTNO(CstG1000000000,
                                       SalesShptLine."Document No.",
                                         RecLSalesShipmentHeader."Posting Date", SalesShptLine."Order No."
                                        ), 1, 100);
        SalesLine.Insert();
        NextLineNo := NextLineNo + 10000;

        // Line number 2 //
        SalesLine.Init();
        SalesLine."Line No." := NextLineNo;
        SalesLine."Document Type" := TempSalesLine."Document Type";
        SalesLine."Document No." := TempSalesLine."Document No.";

        SalesLine.Description := COPYSTR(
                                   STRSUBSTNO(CstG1000000002,
                                     CstG1000000001,
                                     RecLSalesShipmentHeader."Your Reference"), 1, 100);
        SalesLine.Insert();
        NextLineNo := NextLineNo + 10000;

        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInitFromSalesLine', '', false, false)]
    procedure T111_OnAfterInitFromSalesLine_SalesShipmentLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine."BC6_Ordered Quantity" := SalesLine.Quantity;
        SalesShptLine."BC6_Outstanding Quantity" := SalesLine."Outstanding Quantity" - SalesLine."Qty. to Ship";
        SalesShptLine."BC6_Qty Shipped" := SalesLine."Quantity Shipped" + SalesLine."Qty. to Ship";
    end;

    //TAB290
    //TODO:check code //temp  modification of Rec 123
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchInvLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchInvLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchInvLine: Record "Purch. Inv. Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchInvLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchInvLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchInvLine."BC6_DEEE TTC Amount";
        if PurchInvLine."Allow Invoice Disc." then
            VATAmountLine."Inv. Disc. Base Amount" := VATAmountLine."Inv. Disc. Base Amount" + PurchInvLine."BC6_DEEE HT Amount";
    end;
    //TAB290
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnAfterCopyFromPurchCrMemoLine', '', false, false)]
    procedure T290_OnAfterCopyFromPurchCrMemoLine_VATAmountLine(var VATAmountLine: Record "VAT Amount Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        VATAmountLine."BC6_DEEE HT Amount" := VATAmountLine."BC6_DEEE HT Amount" + PurchCrMemoLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" := VATAmountLine."BC6_DEEE VAT Amount" + PurchCrMemoLine."BC6_DEEE VAT Amount";
        VATAmountLine."BC6_DEEE TTC Amount" := VATAmountLine."BC6_DEEE TTC Amount" + PurchCrMemoLine."BC6_DEEE TTC Amount";

        if PurchCrMemoLine."Allow Invoice Disc." then
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
        if not (UPPERCASE(USERID) in ['CNE\BCSYS']) then
            Rec.TESTFIELD(Rec."Vendor No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Vendor No.', false, false)]
    procedure t27_OnAfterValidateEvent(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        Vend: Record Vendor;
    begin
        Vend.get(Vend."No.");
        if (xRec."Vendor No." <> Rec."Vendor No.") and
           (Rec."Vendor No." <> '')
                then
            if Vend.Get(Rec."Vendor No.") then begin
                Rec."Lead Time Calculation" := Vend."Lead Time Calculation";
                Vend.TESTFIELD(Blocked, 0);
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Blocked', false, false)]
    procedure t27_OnAfterValidateEvent_Item(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        RecLAccessControl: Record "Access Control";
        CstG001: Label 'You are not authorized to perform this operation.', comment = 'FRA="Vous n''avez pas l''autorisation d''effectuer cette opération."';
    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'MODIFART');
        IF NOT RecLAccessControl.FINDFIRST() THEN
            ERROR(CstG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Price/Profit Calculation', false, false)]
    procedure t27_OnAfterValidateEvent_Item1(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        InvSetup: Record "Inventory Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //TODO case Rec."Price/Profit Calculation" of
        //     Rec."Price/Profit Calculation"::"Price=Cost+Profit":
        //         if Rec."Unit Price" <> 0 then
        //             if Rec."Unit Cost" = 0 then
        //                 Rec."Profit %" := 0
        //             else
        //                 Rec."Profit %" :=
        //                   Round(
        //                     100 * (1 - Rec."Unit Cost" /
        //                            (Rec."Unit Price" / (1 + CalcVAT))), 0.00001)
        //         else
        //             Rec."Profit %" := 0;
        //     Rec."Price/Profit Calculation"::"Profit=Price-Cost":
        //         if Rec."Profit %" < 100 then begin
        //             GetGLSetup();
        //             Rec."Unit Price" :=
        //                Round(
        //                  (Rec."Unit Cost" / (1 - Rec."Profit %" / 100)) *
        //                  (1 + CalcVAT),
        //                  GLSetup."Unit-Amount Rounding Precision");
        //         end;
        // end;
        // // CNE4.03
        // IF NOT "Price Includes VAT" THEN
        //     //>>TI287704
        //     IF "VAT Prod. Posting Group" <> '' THEN
        //                                                           BEGIN
        //         "Unit Price Includes VAT" := 0;
        //         GetGLSetup;
        //         InvSetup.GET;
        //         IF InvSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN BEGIN
        //             VATPostingSetup2.GET(InvSetup."VAT Bus. Posting Gr. (Price)", "VAT Prod. Posting Group");
        //             "Unit Price Includes VAT" := ROUND("Unit Price" * (1 + VATPostingSetup2."VAT %" / 100), GLSetup."Unit-Amount Rounding Precision")
        //         END;
        //     END;
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
        G_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
        IsDeleteFromReturnOrder: Boolean;
        TextG003: label 'Warning:This purchase order is linked to a sales order.', Comment = 'FRA="Attention : vous avez déjà passé cette commande en achat."';
    begin
        CompanyInfo.FINDFIRST();
        if CompanyInfo."BC6_Branch Company" then
            if Rec."BC6_Purchase No. Order Lien" <> '' then
                ERROR(TextG003);

        IF NOT IsDeleteFromReturnOrder THEN BEGIN
            G_ReturnOrderMgt.DeleteRelatedDocument(Rec);
            G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(Rec);
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]

    procedure T36_OnAfterCheckSellToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
    begin
        if CurrentFieldNo <> 0 then
            if RecGParamNavi.FIND() then begin
                if RecGParamNavi."Used Post-it" <> '' then begin
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", SalesHeader."Sell-to Customer No.");
                    if RecGCommentLine.FIND('-') then begin
                        FrmGLignesCommentaires.EDITABLE(false);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        if FrmGLignesCommentaires.RUNMODAL() = ACTION::OK then;
                    end;
                end;
                RecGCommentLine.SETRANGE(Code, '');
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    procedure T36_OnAfterCopySellToCustomerAddressFieldsFromCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean)
    begin
        SellToCustomer."BC6_Combine Shipments by Order" := SellToCustomer."BC6_Combine Shipments by Order";
        SellToCustomer."BC6_Pay-to Customer No." := SellToCustomer."BC6_Pay-to Customer No.";

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order:
                SellToCustomer."BC6_Copy Sell-to Address" := SellToCustomer."BC6_Copy Sell-to Address";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]

    procedure T36_OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.UpdateIncoterm();  //procedure specifique
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            SalesHeader."Posting Description" := COPYSTR(FORMAT(SalesHeader."Sell-to Customer Name") + ' : ' + FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No."
                                       , 1, MAXSTRLEN(SalesHeader."Posting Description"));
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestStatusOpen', '', false, false)]

    procedure T36_OnAfterTestStatusOpen_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        SalesHeader.GetCust(Cust."Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, SalesHeader."Document Type", false, false);
        Cust.TESTFIELD("Customer Posting Group");
        SalesHeader.CheckCrLimit;  //procedure spec dans tabExt (dupliquée)
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

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Name', false, false)]
    procedure T36_OnAfterValidateEvent_BillToName(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        IF xRec."Bill-to Customer No." = '' then
            if Rec.ShouldSearchForCustomerByName(Rec."Bill-to Customer No.") then
                Rec.Validate("Bill-to Customer No.", Customer.GetCustNo(Rec."Bill-to Name"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Your Reference', false, false)]
    procedure T36_OnAfterValidateEvent_YourRef(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        UpdateSalesShipment: Codeunit BC6_UpdateSalesShipment;
    begin
        UpdateSalesShipment.UpdateYourRefOnSalesShpt(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Shipment Method Code', false, false)]
    procedure T36_OnAfterValidateEvent_ShipMethCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Bin: Record Bin;
        ShipmentMethodRec: Record "Shipment Method";
        FonctionMgt: codeunit BC6_FctMangt;
        BinCode: Code[20];
    begin
        IF ShipmentMethodRec.GET(Rec."Shipment Method Code") THEN
            IF ShipmentMethodRec."BC6_To Make Available" THEN BEGIN
                IF (Bin.GET(Rec."Location Code", Rec."BC6_Bin Code") AND NOT (Bin."BC6_To Make Available")) OR (Rec."BC6_Bin Code" = '') THEN BEGIN
                    FonctionMgt.GetShipmentBin(Rec."Location Code", BinCode);
                    IF Rec."BC6_Bin Code" <> BinCode THEN
                        Rec.VALIDATE(Rec."BC6_Bin Code", BinCode);
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    procedure T36_OnAfterValidateEvent_CurrencyCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.', Comment = 'FRA=""';

    begin
        IF Rec."Currency Code" <> '' THEN
            MESSAGE(TextG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure T36_OnAfterValidateEvent_ReasonCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        RecLReasonCode: Record "Reason Code";
        RecLSalesLine: Record "Sales Line";
    begin
        IF xRec."Reason Code" <> Rec."Reason Code" THEN BEGIN
            RecLSalesLine.SETRANGE("Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("Document No.", Rec."No.");
            IF RecLSalesLine.FIND('-') THEN
                REPEAT
                    RecLSalesLine."BC6_DEEE Category Code" := RecLSalesLine."BC6_DEEE Category Code";
                    RecLSalesLine.CalculateDEEE(Rec."Reason Code");
                    RecLSalesLine.MODIFY;
                UNTIL RecLSalesLine.NEXT = 0;
        END;
    end;
    //TODO: checkMe
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeShouldSearchForCustomerByName', '', false, false)]
    procedure T36_OnBeforeShouldSearchForCustomerByName_SalesHeader(CustomerNo: Code[20]; var Result: Boolean; var IsHandled: Boolean; var CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer Name', false, false)]
    procedure T36_OnAfterValidateEvent_SellToCustName(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        IF xRec."Sell-to Customer Name" = '' THEN
            if Rec.ShouldSearchForCustomerByName(Rec."Sell-to Customer No.") then
                Rec.VALIDATE("Sell-to Customer No.", Customer.GetCustNo(Rec."Sell-to Customer Name"));
        Rec.GetShippingTime(Rec.FIELDNO(Rec."Sell-to Customer Name"));

        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer Name 2', false, false)]
    procedure T36_OnAfterValidateEvent_SellToCustName2(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Address', false, false)]
    procedure T36_OnAfterValidateEvent_SellToAddress(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Address 2', false, false)]
    procedure T36_OnAfterValidateEvent_SellToAddress2(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to City', false, false)]
    procedure T36_OnAfterValidateEvent_SellToCity(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Contact', false, false)]
    procedure T36_OnAfterValidateEvent_SellToContact(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        RecLContact: Record Contact;
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Post Code', false, false)]
    procedure T36_OnAfterValidateEvent_SellToPostCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to County', false, false)]
    procedure T36_OnAfterValidateEvent_SellToCounty(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Country/Region Code', false, false)]
    procedure T36_OnAfterValidateEvent_SellToCountryRegCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.CopySellToAddress(CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Shipping Agent Code', false, false)]
    procedure T36_OnBeforeValidateEvent_ShippAgentCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        IF (Rec.Status <> Rec.Status::Open) AND (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") AND (Rec."Document Type" = Rec."Document Type"::Order)
        THEN BEGIN
            CDUReleaseDoc.Reopen(Rec);
            BoolReclose := TRUE;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Shipping Agent Code', false, false)]
    procedure T36_OnAfterValidateEvent_ShippAgentCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        IF BoolReclose THEN BEGIN   //TODO: je Dois récuperé la valeur 
            CDUReleaseDoc.RUN(Rec);
            BoolReclose := FALSE;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Shipping Agent Service Code', false, false)]
    procedure T36_OnBeforeValidateEvent_ShippAgentServCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        IF (Rec.Status <> Rec.Status::Open) AND (xRec."Shipping Agent Service Code" <> Rec."Shipping Agent Service Code")
        AND (Rec."Document Type" = Rec."Document Type"::Order)
        THEN BEGIN
            CDUReleaseDoc.Reopen(Rec);
            BoolReclose := TRUE;
        END;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Shipping Agent Service Code', false, false)]
    procedure T36_OnAfterValidateEvent_ShippAgentServCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        IF BoolReclose THEN BEGIN
            CDUReleaseDoc.RUN(Rec);
            BoolReclose := FALSE;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestNoSeries', '', false, false)]

    procedure T36_OnAfterTestNoSeries_SalesHeader(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":

                if SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV then
                    SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."BC6_SAV Return Order Nos.")
                else
                    SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', false, false)]

    procedure T36_OnAfterGetNoSeriesCode_salesHeader(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order":
                begin
                    if SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV then
                        NoSeriesCode := SalesReceivablesSetup."BC6_SAV Return Order Nos."
                    else
                        NoSeriesCode := SalesReceivablesSetup."Return Order Nos.";
                end;

        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSalesLineByChangedFieldName', '', false, false)]

    procedure T36_OnUpdateSalesLineByChangedFieldName_SalesHeader(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldNo of
            SalesLine.FieldNo("Bin Code"):
                if SalesLine."No." <> '' then
                    if (SalesLine."Location Code" = SalesHeader."Location Code") then
                        SalesLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterUpdateSellToCont', '', false, false)]

    procedure T36_OnAfterUpdateSellToCont_SalesHeader(var SalesHeader: Record "Sales Header"; Customer: Record Customer; Contact: Record Contact; HideValidationDialog: Boolean)
    var
        OfficeContact: Record Contact;
        OfficeMgt: Codeunit "Office Management";
    begin
        if OfficeMgt.GetContact(OfficeContact, SalesHeader."Sell-to Customer No.") then
            exit
        else
            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
                SalesHeader.UpdateSellToFax(SalesHeader."Sell-to Contact No.");
                SalesHeader.UpdateSellToMail(SalesHeader."Sell-to Contact No.");
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateSellToCustContact', '', false, false)]
    procedure T36_OnBeforeUpdateSellToCustContact_SalesHeader(var SalesHeader: Record "Sales Header"; Conact: Record Contact; var IsHandled: Boolean)
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Customer: record Customer;
        SalesSetup: record "Sales & Receivables Setup";
        FonctionMgt: Codeunit BC6_FctMangt;
        TextG002: Label 'Update Bill-to address ?';
    begin
        SalesSetup.Get;
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote)
           OR ((SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND SalesSetup."Contact's Address on sales doc") THEN BEGIN
            if Customer.Get(SalesHeader."Sell-to Customer No.") or Customer.Get(ContBusinessRelation."No.") then begin
                if Customer."Copy Sell-to Addr. to Qte From" = Customer."Copy Sell-to Addr. to Qte From"::Company then
                    FonctionMgt.GetContactAsCompany2(Conact, Conact);
            end else
                FonctionMgt.GetContactAsCompany2(Conact, Conact);
            SalesHeader."Sell-to Address" := Conact.Address;
            SalesHeader."Sell-to Address 2" := Conact."Address 2";
            SalesHeader."Sell-to City" := Conact.City;
            SalesHeader."Sell-to Post Code" := Conact."Post Code";
            SalesHeader."Sell-to County" := Conact.County;
            SalesHeader."Sell-to Country/Region Code" := Conact."Country/Region Code";
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                IF CONFIRM(TextG002, FALSE) THEN BEGIN
                    SalesHeader."Bill-to Address" := Conact.Address;
                    SalesHeader."Bill-to Address 2" := Conact."Address 2";
                    SalesHeader."Bill-to City" := Conact.City;
                    SalesHeader."Bill-to Post Code" := Conact."Post Code";
                    SalesHeader."Bill-to County" := Conact.County;
                    SalesHeader."Bill-to Country/Region Code" := Conact."Country/Region Code";
                end;
            end;
        end;
        SalesHeader.UpdateSellToFax(SalesHeader."Sell-to Contact No.");
        SalesHeader.UpdateSellToMail(SalesHeader."Sell-to Contact No.");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateOutboundWhseHandlingTime', '', false, false)]
    procedure T36_OnBeforeUpdateOutboundWhseHandlingTime_SalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
        Location: Record location;
    begin
        IsHandled := true;
        if SalesHeader."Location Code" <> '' then begin
            if Location.Get(SalesHeader."Location Code") then
                SalesHeader."Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            SalesHeader.VALIDATE(SalesHeader."Shipment Method Code");
            if SalesHeader."BC6_Bin Code" = '' then
                SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        end else begin
            if InvtSetup.Get() then
                SalesHeader."Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            SalesHeader."BC6_Bin Code" := '';
        end;
    end;

    //TODO: CheckMe  le code specifique a mis 2 ligne en commentaire 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitFromSalesHeader', '', false, false)]
    procedure T36_OnBeforeInitFromSalesHeader_SalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    begin
        SalesHeader.VALIDATE("Order Date", WORKDATE());
        SalesHeader.VALIDATE("Posting Date", WORKDATE());
        if SalesHeader."Shipment Date" < WORKDATE() then
            SalesHeader.VALIDATE("Shipment Date", WORKDATE())
        else
            SalesHeader."Shipment Date" := SourceSalesHeader."Shipment Date";
        SalesHeader."External Document No." := SourceSalesHeader."External Document No.";
        SalesHeader."BC6_Document description" := SourceSalesHeader."BC6_Document description";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitFromSalesHeader', '', false, false)]
    procedure T36_OnAfterInitFromSalesHeader_SalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    var
        Location: Record Location;
    begin
        if SourceSalesHeader."Location Code" <> '' then begin
            if Location.GET(SalesHeader."Location Code") then
                if SourceSalesHeader."BC6_Bin Code" = '' then
                    SalesHeader."BC6_Bin Code" := Location."Shipment Bin Code";
        end else
            SalesHeader."BC6_Bin Code" := '';
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
        G_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
        TextG003: label 'Warning:This purchase order is linked to a sales order.';
    begin
        CompanyInfo.FINDFIRST();
        if CompanyInfo."BC6_Branch Company" then
            if Rec."BC6_Sales No. Order Lien" <> '' then
                ERROR(TextG003);
        IF Rec."Document Type" = Rec."Document Type"::Order THEN
            G_ReturnOrderMgt.DeleteRelatedPurchOrderNo(Rec)
        ELSE
            IF (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
                G_ReturnOrderMgt.DeleteRelatedPurchReturnOrderNo(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeCheckBlockedVendOnDocs', '', false, false)]
    procedure T38_OnBeforeCheckBlockedVendOnDocs_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; var Vend: Record Vendor; CurrFieldNo: Integer; var IsHandled: Boolean)
    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
    //TODO:To check
    begin

        if CurrFieldNo <> 0 then
            if RecGParamNavi.FIND() then begin
                if RecGParamNavi."Used Post-it" <> '' then begin
                    RecGCommentLine.SETRANGE(Code, RecGParamNavi."Used Post-it");
                    RecGCommentLine.SETRANGE("No.", PurchaseHeader."Buy-from Vendor No.");
                    if RecGCommentLine.FIND('-') then begin
                        FrmGLignesCommentaires.EDITABLE(false);
                        FrmGLignesCommentaires.CAPTION('Post-it');
                        FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                        if FrmGLignesCommentaires.RUNMODAL() = ACTION::OK then;
                    end;
                end;
                RecGCommentLine.SETRANGE(Code, '');
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEmptySellToCustomerAndLocation', '', false, false)]

    procedure T38_OnBeforeValidateEmptySellToCustomerAndLocation_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."BC6_Pay-to Vend. No." := Vendor."BC6_Pay-to Vend. No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]
    procedure T38_OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    begin
        PurchaseHeader.UpdateIncoterm;
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] then
            PurchaseHeader."Posting Description" := COPYSTR(FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' : ' + FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No."
                                       , 1, MAXSTRLEN(PurchaseHeader."Posting Description"));
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    procedure T38_OnAfterValidateEvent_CurrCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';

    begin
        IF Rec."Currency Code" <> '' THEN
            MESSAGE(TextG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure T38_OnAfterValidateEvent_ResCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        RecLPurchLine: Record "Purchase Line";
        RecLReasonCode: Record "Reason Code";
    begin
        IF xRec."Reason Code" <> Rec."Reason Code" THEN begin
            RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
            RecLPurchLine.SETRANGE("Document No.", Rec."No.");
            IF RecLPurchLine.FIND('-') THEN
                REPEAT
                    RecLPurchLine."BC6_DEEE Category Code" := RecLPurchLine."BC6_DEEE Category Code";
                    RecLPurchLine.CalculateDEEE(Rec."Reason Code");
                    RecLPurchLine.MODIFY;
                UNTIL RecLPurchLine.NEXT = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Buy-from Vendor Name', false, false)]
    procedure T38_OnBeforeValidateEvent_BuyfromVendorName(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        Vendor: Record Vendor;
    begin
        IF xRec."Buy-from Vendor Name" = '' THEN
            Rec.VALIDATE("Buy-from Vendor No.", Vendor.GetVendorNo(Rec."Buy-from Vendor Name"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitPostingNoSeries', '', false, false)]
    //TODO: checkMe
    procedure T38_OnAfterInitPostingNoSeries_PurchHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    begin
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Return Order"] THEN BEGIN
            PurchaseHeader."Order Date" := WORKDATE;
            PurchaseHeader."Posting Date" := WORKDATE;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    procedure T38_OnAfterInitRecord_PurchHeader(var PurchHeader: Record "Purchase Header")
    var
        Vend: Record Vendor;   //TODO : check if we need to get vend before , ps: we can use the fct VendGet of the std 
        UserSetupMgt: Codeunit "User Setup Management";

    begin
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Quote THEN
            PurchHeader.VALIDATE("Location Code", UserSetupMgt.GetLocation(1, Vend."Location Code", PurchHeader."Responsibility Center"));

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTestNoSeries', '', false, false)]
    procedure T38_OnAfterTestNoSeries_PurchHeader(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup")
    begin
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::"Return Order":
                BEGIN
                    IF PurchHeader."BC6_Return Order Type" = PurchHeader."BC6_Return Order Type"::SAV THEN
                        PurchSetup.TESTFIELD("BC6_SAV Return Order Nos.")
                    ELSE
                        PurchSetup.TESTFIELD("Return Order Nos.");
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    procedure T38_OnAfterGetNoSeriesCode_PurchHeader(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    begin
        CASE PurchHeader."Document Type" OF

            PurchHeader."Document Type"::"Return Order":
                BEGIN
                    IF PurchHeader."BC6_Return Order Type" = PurchHeader."BC6_Return Order Type"::SAV THEN
                        NoSeriesCode := PurchSetup."BC6_SAV Return Order Nos."
                    ELSE
                        NoSeriesCode := PurchSetup."Return Order Nos.";
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTransferSavedFieldsSpecialOrder', '', false, false)]

    procedure T38_OnBeforeTransferSavedFieldsSpecialOrder_PurchHeader(var DestinationPurchaseLine: Record "Purchase Line"; var SourcePurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
    begin
        IsHandled := true;
        SalesLine.Get(
    SalesLine."Document Type"::Order,
    SourcePurchaseLine."Special Order Sales No.",
    SourcePurchaseLine."Special Order Sales Line No.");
        CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, DestinationPurchaseLine);
        DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
        DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
        DestinationPurchaseLine.Validate("Unit of Measure Code", SourcePurchaseLine."Unit of Measure Code");
        if SourcePurchaseLine.Quantity <> 0 then
            DestinationPurchaseLine.Validate(Quantity, SourcePurchaseLine.Quantity);

        SalesLine.Validate("Unit Cost (LCY)", DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
        SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.Modify();
    end;

    procedure OnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; Contact: Record Contact)
    begin
        PurchaseHeader.UpdateBuyFromFax(PurchaseHeader."Buy-from Contact No.");
        PurchaseHeader.UpdateBuyFromMail(PurchaseHeader."Buy-from Contact No.");
    end;

    procedure OnAfterUpdatePayToCont(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; Contact: Record Contact)
    begin
        PurchaseHeader.UpdateBuyFromFax(PurchaseHeader."Buy-from Contact No.");
        PurchaseHeader.UpdateBuyFromMail(PurchaseHeader."Buy-from Contact No.");
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
        fctMgt: Codeunit "BC6_FctMangt";
        VATRateChangeConv: Codeunit "VAT Rate Change Conversion";
        RecRef: RecordRef;
    begin
        IsHandled := true;
        if VATRateChangeSetup."Item Filter" <> '' then
            Item.SETFILTER("No.", VATRateChangeSetup."Item Filter");
        Item.SETRANGE(Blocked, false);
        if Item.FindSet() then
            repeat
                RecRef.GETTABLE(Item);
                fctMgt.UpdateRec(RecRef, VATRateChangeConv.ConvertVATProdPostGrp(VATRateChangeSetup."Update Items"), VATRateChangeConv.ConvertGenProdPostGrp(VATRateChangeSetup."Update Items"));
            until Item.NEXT() = 0;
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
        if InstructionType = fctMgt.ShowPostedConfirmationMessageCode() then
            Result := false;
    end;
    //COD5063

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]

    procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
        SalesHeader.MODIFY();
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
        PurchLine: Record "Purchase Line";
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";

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
        PurchLine: Record "Purchase Line";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;

        //TODO: à verifier srtt les declarations 

        fctMgt: Codeunit "BC6_FctMangt";
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
        TempWhseJnlLine: Record "Warehouse Journal Line" TEMPORARY;

    begin
        IF NOT TempWhseJnlLine.ISEMPTY THEN
            TempWhseJnlLine.DELETEALL();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]
    procedure COD5815_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(SalesShptLine: Record "Sales Shipment Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        fctMgt: Codeunit "BC6_FctMangt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
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
        Text002: Label 'You cannot undo line %1 because warehouse put-away lines have already been created.';
        Text008: label 'You cannot undo line %1 because warehouse receipt lines have already been posted.';
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
        BoolGCopyLinesExactly: Boolean;
        SalesDocType: enum "Sales Document Type";

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
    //TAB113
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnBeforeCalcVATAmountLines', '', false, false)]

    local procedure TAB13_OnBeforeCalcVATAmountLines(SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin
        TempVATAmountLine."BC6_DEEE HT Amount" := TempVATAmountLine."BC6_DEEE HT Amount" + SalesInvLine."BC6_DEEE HT Amount";
        TempVATAmountLine."BC6_DEEE VAT Amount" := TempVATAmountLine."BC6_DEEE VAT Amount" + SalesInvLine."BC6_DEEE VAT Amount";
        TempVATAmountLine."BC6_DEEE TTC Amount" := TempVATAmountLine."BC6_DEEE TTC Amount" + SalesInvLine."BC6_DEEE TTC Amount";
        IF SalesInvLine."Allow Invoice Disc." THEN
            TempVATAmountLine."Inv. Disc. Base Amount" := TempVATAmountLine."Inv. Disc. Base Amount" + TempVATAmountLine."BC6_DEEE HT Amount";
    end;
    //TAB115 à vérifier l'event
    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnBeforeCalcVATAmountLines', '', false, false)]
    local procedure TAB115_OnBeforeCalcVATAmountLines(SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin

        if SalesCrMemoLine.Find('-') then
            repeat
                TempVATAmountLine.Init();
                TempVATAmountLine.CopyFromSalesCrMemoLine(SalesCrMemoLine);
                TempVATAmountLine."BC6_DEEE HT Amount" := TempVATAmountLine."BC6_DEEE HT Amount" + SalesCrMemoLine."BC6_DEEE HT Amount";
                TempVATAmountLine."BC6_DEEE VAT Amount" := TempVATAmountLine."BC6_DEEE VAT Amount" + SalesCrMemoLine."BC6_DEEE VAT Amount";
                TempVATAmountLine."BC6_DEEE TTC Amount" := TempVATAmountLine."BC6_DEEE TTC Amount" + SalesCrMemoLine."BC6_DEEE TTC Amount";

                TempVATAmountLine.InsertLine();
            until SalesCrMemoLine.Next() = 0;
    end;
    //TAB25
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]

    local procedure TAB25_OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
        VendorLedgerEntry."BC6_Payment Terms Code" := GenJournalLine."Payment Terms Code";
        VendorLedgerEntry."BC6_Pay-to Vend. No." := GenJournalLine."BC6_Pay-to No.";
    end;
    //TAB 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Expected Receipt Date', false, false)]
    procedure T39_OnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        CustomCalendarChange: Array[2] of Record "Customized Calendar Change";
        CalChange: Record "Customized Calendar Change";
        RecLSalesLine: Record "Sales Line";
        PurchHeader: Record "Purchase Header";
    BEGIN
        PurchHeader.get(PurchHeader."Document Type", PurchHeader."No.");
        CalChange.get(CalChange."Source Type", CalChange."Source Code", CalChange."Additional Source Code", CalChange."Base Calendar Code", CalChange."Recurring System", CalChange.Date, CalChange.Day, CalChange."Entry No.");
        if Rec."Expected Receipt Date" <> 0D then begin
            CustomCalendarChange[1].SetSource(CalChange."Source Type"::Location, Rec."Location Code", '', '');
        end else
            Rec.Validate(Rec."Planned Receipt Date", Rec."Expected Receipt Date");
        //>>MIGRATION NAV 2013
        //>>ACHAT-200706-18-A.001:GR
        IF Rec."Expected Receipt Date" <> 0D THEN BEGIN
            RecLSalesLine.RESET;
            //>>CorrectionSOBI
            RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            //<<CorrectionSOBI
            RecLSalesLine.SETRANGE("BC6_Purch. Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("BC6_Purch. Order No.", Rec."Document No.");
            RecLSalesLine.SETRANGE("BC6_Purch. Line No.", Rec."Line No.");
            IF RecLSalesLine.FIND('-') THEN BEGIN
                REPEAT
                    RecLSalesLine.VALIDATE("BC6_Purchase Receipt Date", Rec."Expected Receipt Date");
                    //>> CNE6.01
                    RecLSalesLine."BC6_Promised Purchase Receipt Date" := (PurchHeader."Expected Receipt Date" <> 0D);
                    RecLSalesLine.MODIFY;
                UNTIL RecLSalesLine.NEXT = 0;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateDirectUnitCost', '', false, false)]
    local procedure T39_OnAfterUpdateDirectUnitCost(var PurchLine: Record "Purchase Line"; xPurchLine: Record "Purchase Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    var
        RecGVendor: Record Vendor;
        Currency: Record Currency;
    begin
        PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", 0);
        PurchLine."BC6_DEEE VAT Amount" := 0;
        PurchLine."BC6_DEEE TTC Amount" := 0;
        PurchLine."BC6_DEEE Amount (LCY) for Stat" := 0;
        RecGVendor.GET(PurchLine."Buy-from Vendor No.");
        IF RecGVendor."BC6_Posting DEEE" THEN BEGIN
            PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", PurchLine."BC6_DEEE Unit Price" * PurchLine."Quantity (Base)");
            Currency.get(Currency.Code);
            PurchLine."BC6_DEEE VAT Amount" := ROUND(PurchLine."BC6_DEEE HT Amount" * PurchLine."VAT %" / 100, Currency."Amount Rounding Precision");
            PurchLine."BC6_DEEE TTC Amount" := PurchLine."BC6_DEEE HT Amount" + PurchLine."BC6_DEEE VAT Amount";
            PurchLine."BC6_DEEE Amount (LCY) for Stat" := PurchLine."Quantity (Base)" * PurchLine."BC6_DEEE Unit Price (LCY)";
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    procedure T39_OnAfterValidateEvent_UnitPost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        RecGPurchPrice: record "Purchase Price";
        RecGPurchsetup: Record "Purchases & Payables Setup";
        Tectg003: label 'ENU="Do you want to create a Purchase Price ?"', comment = '"FRA=Voulez-vous creer un prix d''achat négocier ?"';

    begin

        //>>MIGRATION NAV 2013
        //>>FE025/26 FLGR 26/12/06
        IF (xRec."Direct Unit Cost" <> Rec."Direct Unit Cost") AND (xRec."Direct Unit Cost" <> 0) THEN BEGIN
            RecGPurchsetup.GET;
            IF RecGPurchsetup."BC6_Ask custom purch price" THEN BEGIN

                IF CONFIRM(Tectg003, FALSE) THEN BEGIN
                    RecGPurchPrice.RESET;
                    RecGPurchPrice.SETFILTER("Vendor No.", Rec."Buy-from Vendor No.");
                    RecGPurchPrice.SETFILTER("Item No.", Rec."No.");
                    RecGPurchPrice.SETFILTER("Starting Date", '%1', WORKDATE);
                    IF NOT RecGPurchPrice.FIND('-') THEN BEGIN
                        RecGPurchPrice.INIT;
                        RecGPurchPrice.VALIDATE("Item No.", Rec."No.");
                        RecGPurchPrice.VALIDATE("Vendor No.", Rec."Buy-from Vendor No.");
                        RecGPurchPrice.VALIDATE("Starting Date", WORKDATE);
                        RecGPurchPrice.VALIDATE("Direct Unit Cost", Rec."Direct Unit Cost");
                        RecGPurchPrice.INSERT(TRUE);
                    END;
                    RecGPurchPrice.SETFILTER("Starting Date", '');
                    PAGE.RUN(Page::"Purchase Prices", RecGPurchPrice);
                END;
            END;

        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure T39_OnCopyFromItemOnAfterCheck(PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin
        PurchaseLine."BC6_Public Price" := Item."Unit Price";
    end;
    //TAB383
    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure T383_OnAfterCopyFromGenJnlLine(var DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line")
    begin
        DtldCVLedgEntryBuffer."BC6_DEEE HT Amount" := GenJnlLine."BC6_DEEE HT Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE VAT Amount" := GenJnlLine."BC6_DEEE VAT Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE TTC Amount" := GenJnlLine."BC6_DEEE TTC Amount";
        DtldCVLedgEntryBuffer."BC6_DEEE HT Amount (LCY)" := GenJnlLine."BC6_DEEE HT Amount (LCY)";
        DtldCVLedgEntryBuffer."BC6_Eco partner DEEE" := GenJnlLine."BC6_Eco partner DEEE";
    end;

    //TAB167
    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterDeleteEvent', '', false, false)]
    procedure T167_OnAfterDeleteEvent_Job(var Rec: Record Job; RunTrigger: Boolean)
    var
        RecLAffairStep: Record "BC6_Affair Steps";

    begin
        RecLAffairStep.SETRANGE("Affair No.", Rec."No.");
        RecLAffairStep.DELETEALL;

    end;
    //TAB18
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Salesperson Code', false, false)]
    procedure T18_OnAfterValidateEvent_SalespersCode(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        RecLSalespersonAuthorized: Record "BC6_Salesperson authorized";
    begin
        IF Rec."Salesperson Code" <> xRec."Salesperson Code" THEN BEGIN
            RecLSalespersonAuthorized.SETRANGE("Customer No.", Rec."No.");
            IF RecLSalespersonAuthorized.FINDFIRST() THEN BEGIN
                RecLSalespersonAuthorized.MODIFYALL(authorized, FALSE);
                RecLSalespersonAuthorized.SETRANGE("Salesperson code", Rec."Salesperson Code");
                IF RecLSalespersonAuthorized.FINDFIRST() THEN BEGIN
                    RecLSalespersonAuthorized.authorized := TRUE;
                    RecLSalespersonAuthorized.MODIFY();
                END;
            END;
            Rec.VALIDATE("BC6_Salesperson Filter", Rec."Salesperson Code");

        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Combine Shipments', false, false)]
    procedure T18_OnAfterValidateEvent_CombineShip(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        IF Rec."Combine Shipments" = FALSE THEN
            Rec."BC6_Combine Shipments by Order" := FALSE;

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    procedure T18_OnAfterValidateEvent_GenBusPostGrp(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        GenBusPostingGrp: Record "Gen. Business Posting Group";
    begin
        GenBusPostingGrp.GET(Rec."Gen. Bus. Posting Group");
        Rec."BC6_Submitted to DEEE" := GenBusPostingGrp."BC6_Subject to DEEE";

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterOnInsert', '', false, false)]
    procedure T18_OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    var
        NaviSetup: Record "BC6_Navi+ Setup";

    begin
        Customer."BC6_Pay-to Customer No." := Customer."No.";
        NaviSetup.GET;
        NaviSetup.TESTFIELD(NaviSetup."Country Code");
        NaviSetup.TESTFIELD(NaviSetup."Gen. Bus. Posting Group Cust.");
        NaviSetup.TESTFIELD(NaviSetup."VAT Bus. Posting Group Cust.");
        NaviSetup.TESTFIELD(NaviSetup."Customer Posting Group");

        Customer.VALIDATE("Country/Region Code", NaviSetup."Country Code");
        Customer.VALIDATE("Gen. Bus. Posting Group", NaviSetup."Gen. Bus. Posting Group Cust.");
        Customer.VALIDATE("VAT Bus. Posting Group", NaviSetup."VAT Bus. Posting Group Cust.");
        Customer.VALIDATE("Customer Posting Group", NaviSetup."Customer Posting Group");
        Customer.VALIDATE("Allow Line Disc.", NaviSetup."Allow Line Disc.");
        Customer.VALIDATE("Application Method", NaviSetup."Application Method Customer");
        Customer.VALIDATE("Print Statements", NaviSetup."Print Statements");
        Customer.VALIDATE("Combine Shipments", NaviSetup."Combine Shipments");
        Customer.VALIDATE(Reserve, NaviSetup."Reserve Customer");
        Customer.VALIDATE("Shipping Advice", NaviSetup."Shipping Advice");
        Customer.VALIDATE("Invoice Copies", NaviSetup."Invoice Copies");
        Customer.VALIDATE("Shipping Time", NaviSetup."Shipping Time");
        Customer.VALIDATE("Location Code", NaviSetup."Customer Location Code");
        Customer.VALIDATE("BC6_Submitted to DEEE", NaviSetup."Submitted to DEEE");
    end;
    //TAB21

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]

    procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."BC6_DEEE HT Amount" := GenJournalLine."BC6_DEEE HT Amount";
        CustLedgerEntry."BC6_DEEE VAT Amount" := GenJournalLine."BC6_DEEE VAT Amount";
        CustLedgerEntry."BC6_DEEE TTC Amount" := GenJournalLine."BC6_DEEE TTC Amount";
        CustLedgerEntry."BC6_DEEE HT Amount (LCY)" := GenJournalLine."BC6_DEEE HT Amount (LCY)";
        CustLedgerEntry."BC6_Eco partner DEEE" := GenJournalLine."BC6_Eco partner DEEE";
        CustLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
        CustLedgerEntry."BC6_Payment Terms Code" := GenJournalLine."Payment Terms Code";
        CustLedgerEntry."BC6_Pay-to Customer No." := GenJournalLine."BC6_Pay-to No.";

    end;
    //TAB23
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    procedure T23_OnAfterValidateEvent_GenBusPostGrp(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer)
    var
        GenBusPostingGrp: Record "Gen. Business Posting Group";
    begin
        GenBusPostingGrp.GET(Rec."Gen. Bus. Posting Group");
        Rec."BC6_Posting DEEE" := GenBusPostingGrp."BC6_Subject to DEEE";

    end;


    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterOnInsert', '', false, false)]
    procedure T23_OnAfterOnInsert(var Vendor: Record Vendor)
    var
        NaviSetup: Record "BC6_Navi+ Setup";

    begin
        //TODO  je pense que cette section est replacer par ces deux fcts  "UpdateReferencedIds; et SetLastModifiedDateTime"
        //    "Creation Date" := WORKDATE;
        //    User := USERID;
        Vendor."BC6_Pay-to Vend. No." := Vendor."No.";
        NaviSetup.TESTFIELD(NaviSetup."Gen. Bus. Posting Group Vendor");
        NaviSetup.TESTFIELD(NaviSetup."VAT Bus. Posting Group Vendor");
        NaviSetup.TESTFIELD(NaviSetup."Vendor Posting Group");
        NaviSetup.TESTFIELD(NaviSetup."Purchaser Code");
        NaviSetup.TESTFIELD(NaviSetup."Payment Terms Code");
        NaviSetup.TESTFIELD(NaviSetup."Payment Method Code");
        NaviSetup.TESTFIELD(NaviSetup."Base Calendar Code");

        Vendor.VALIDATE("Gen. Bus. Posting Group", NaviSetup."Gen. Bus. Posting Group Vendor");
        Vendor.VALIDATE("VAT Bus. Posting Group", NaviSetup."VAT Bus. Posting Group Vendor");
        Vendor.VALIDATE("Vendor Posting Group", NaviSetup."Vendor Posting Group");
        Vendor.VALIDATE("Lead Time Calculation", NaviSetup."Lead Time Calculation Vendor");
        Vendor.VALIDATE("Purchaser Code", NaviSetup."Purchaser Code");
        Vendor.VALIDATE("Application Method", NaviSetup."Application Method Vendor");
        Vendor.VALIDATE("Payment Terms Code", NaviSetup."Payment Terms Code");
        Vendor.VALIDATE("Payment Method Code", NaviSetup."Payment Method Code");
        Vendor.VALIDATE("Base Calendar Code", NaviSetup."Base Calendar Code");
        Vendor.VALIDATE("Location Code", NaviSetup."Vendor Location Code");
        Vendor.VALIDATE("BC6_Posting DEEE", NaviSetup."Posting DEEE");

    end;
    //246
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterValidateEvent', 'Location Code', false, false)]
    procedure T246_OnAfterValidateEvent_LocationCode(var Rec: Record "Requisition Line"; var xRec: Record "Requisition Line"; CurrFieldNo: Integer)
    var
        Location: Record Location;
        WMSManagement: Codeunit "WMS Management";

    begin
        Location.Get();
        IF Location."Require Put-away" AND NOT (Location."Require Receive") THEN
            Rec."Bin Code" := Location."Receipt Bin Code"
        ELSE
            WMSManagement.GetDefaultBin(Rec."No.", Rec."Variant Code", Rec."Location Code", Rec."Bin Code");

    end;

    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterGetDirectCost', '', false, false)]
    procedure OnAfterGetDirectCost(var RequisitionLine: Record "Requisition Line"; CalledByFieldNo: Integer)
    var
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        //TODO : COD7010 is for removal nd the fct FindVeryBestCostreq doesn't exist 
        // PurchPriceCalcMgt.FindVeryBestCostreq(RequisitionLine);
    end;
    //Tab341
    [EventSubscriber(ObjectType::Table, Database::"Item Discount Group", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T341_OnAfterDeleteEvent(var Rec: Record "Item Discount Group"; RunTrigger: Boolean)
    var
        PurchaseLineDiscount: Record "Purchase Line Discount";  //TODO marked for removal
    begin
        PurchaseLineDiscount.SETRANGE(BC6_Type, PurchaseLineDiscount.BC6_Type::"Item Disc. Group");
        PurchaseLineDiscount.SETRANGE("Item No.", Rec.Code);
        PurchaseLineDiscount.DELETEALL(TRUE);
    end;
    //TAB 10866
    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterSetUpNewLine', '', false, false)]

    local procedure T10866_OnAfterSetUpNewLine(var PaymentLine: Record "Payment Line")
    var
        BottomLine: Boolean;
        PaymentClass: Record "Payment Class";
        NoSeriesMgt: codeunit NoSeriesManagement;
    begin
        if PaymentLine."No." <> '' then begin
            if PaymentClass."Line No. Series" = '' then
                exit
            else
                if PaymentLine."Document No." = '' then
                    IF BottomLine AND (PaymentLine."Line No." <> PaymentLine."Line No.") THEN
                        PaymentLine."Document No." := INCSTR(PaymentLine."Document No.")
                    ELSE
                        IF PaymentLine."Document No." = '' THEN
                            PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", PaymentLine."Posting Date", FALSE)
                        ELSE
                            PaymentLine."Document No." := PaymentLine."Document No.";

        end;
    end;


}
