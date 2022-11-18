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
    procedure T27_OnBeforeModifyEvent_Item(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    begin
        if not (UPPERCASE(USERID) in ['CNE\BCSYS']) then
            Rec.TESTFIELD(Rec."Vendor No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Vendor No.', false, false)]
    procedure t27_OnAfterValidateEvent_Item(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
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
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.', Comment = 'FRA="Attention, l''utilisation de devises va provoquer un calcul erronné des marges."';

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
        TextG002: Label 'Update Bill-to address ?', Comment = 'FRA="Voulez-vous mettre à jour l''adresse de Facturation ?"';
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
        TextG003: label 'Warning:This purchase order is linked to a sales order.', Comment = 'FRA="Attention : vous avez déjà passé cette commande en achat. "';
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
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.', Comment = 'FRA="Attention, l''utilisation de devises va provoquer un calcul erronné des marges."';

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
        Text002: Label 'You cannot undo line %1 because warehouse put-away lines have already been created.', Comment = 'FRA=""';
        Text008: label 'You cannot undo line %1 because warehouse receipt lines have already been posted.', Comment = 'FRA=""';
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



    //CodeunitCNEEvent 
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnCreateCustomerOnBeforeCustomerModify', '', false, false)]
    local procedure T5050_OnCreateCustomerOnBeforeCustomerModify_Contact(var Customer: Record Customer; Contact: Record Contact)
    var
        CustTemplate: Record "Customer Template";
    begin
        Customer."BC6_Submitted to DEEE" := CustTemplate."BC6_Submitted to DEEE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnBeforeValidateQtyToHandle', '', false, false)]
    local procedure T5767_OnBeforeValidateQtyToHandle_WarehouseActivityLine(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        RecLUserSetup: Record "User Setup";
        CstL001: Label 'Vous n''êtes pas autorisé à modifier les quantités à traiter', Comment = 'FRA=""';
        CstL002: Label 'Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée.', Comment = 'FRA=""';
        Text002: Label 'You cannot handle more than the outstanding %1 units.', Comment = 'FRA="Vous ne pouvez pas traiter plus que les %1 unités restantes."';
    begin
        if WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."Qty. Outstanding" then
            Error(Text002, WarehouseActivityLine."Qty. Outstanding");
        IF RecLUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecLUserSetup."BC6_Autorize Qty. to Handle Change" THEN
                ERROR(CstL001);
            IF RecLUserSetup."BC6_Aut. Qty. to Han. Test PickQty" THEN
                IF WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."BC6_Qty. Picked" THEN
                    ERROR(CstL002);

        END ELSE
            ERROR(CstL001);

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line Discount", 'OnAfterInsertEvent', '', false, false)]
    local procedure T7014_OnAfterInsertEvent_PurchaseLineDiscount(var Rec: Record "Purchase Line Discount"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec.BC6_Type <> Rec.BC6_Type::"All items" THEN
            Rec.TESTFIELD("Item No.");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line Discount", 'OnAfterRenameEvent', '', false, false)]
    local procedure T7014_OnAfterRenameEvent_PurchaseLineDiscount(var Rec: Record "Purchase Line Discount"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec.BC6_Type <> Rec.BC6_Type::"All items" THEN
            Rec.TESTFIELD("Item No.");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bin Content", 'OnBeforeCalcQtyAvailToTake', '', false, false)]
    local procedure T7302_OnBeforeCalcQtyAvailToTake_BinContent(var BinContent: Record "Bin Content"; ExcludeQtyBase: Decimal; var QtyAvailToTake: Decimal; var IsHandled: Boolean)
    var
        Bin: Record Bin;
        FctMangt: Codeunit BC6_FctMangt;
    begin
        FctMangt.GetBin(BinContent."Location Code", BinContent."Bin Code", Bin);
        IF Bin."BC6_Exclude Inventory Pick" THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeSendEmailDirectly', '', false, false)]
    local procedure T77_OnBeforeSendEmailDirectly_ReportSelections(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        FctMangt: Codeunit BC6_FctMangt;
    begin
        CASE ReportUsage OF
            ReportUsage::"S.Order", ReportUsage::"S.Quote":
                BEGIN
                    SalesHeader := RecordVariant;
                    FctMangt.SetYourReference(SalesHeader."Your Reference");
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnSendEmailDirectlyOnBeforeSaveReportAsPDFInTempBlob', '', false, false)]
    local procedure T77_OnSendEmailDirectlyOnBeforeSaveReportAsPDFInTempBlob_ReportSelection(ReportSelection: Record "Report Selections"; RecordVariant: Variant; ReportUsage: Enum "Report Selection Usage"; var TempBlob: Codeunit "Temp Blob"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        // IF ReportUsage IN [ReportUsage::"S.Order", ReportUsage::"S.Quote"] THEN BEGIN   TODO:
        //       SalesHeader := RecordVariant;
        //       IF SalesHeader."BC6_Sell-to E-Mail Address" <> '' THEN
        //         EmailAddress := SalesHeader."BC6_Sell-to E-Mail Address";
        //     END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure T81_OnAfterCopyGenJnlLineFromPurchHeader_GenJournalLine(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."BC6_Pay-to No." := PurchaseHeader."BC6_Pay-to Vend. No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure TAB81_OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Payment Method Code" := GenJournalLine."Payment Method Code";
        GenJournalLine."BC6_Pay-to No." := SalesHeader."BC6_Pay-to Customer No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Payment Method Code" := SalesHeader."Payment Method Code";
        GenJournalLine."BC6_Pay-to No." := SalesHeader."BC6_Pay-to Customer No."; // TODO:
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure T83_OnAfterCopyItemJnlLineFromSalesLine_ItemJournalLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."BC6_DEEE Category Code" := SalesLine."BC6_DEEE Category Code";
        ItemJnlLine."BC6_DEEE Unit Price" := SalesLine."BC6_DEEE Unit Price";
        ItemJnlLine."BC6_DEEE HT Amount" := SalesLine."BC6_DEEE HT Amount";
        ItemJnlLine."BC6_DEEE VAT Amount" := SalesLine."BC6_DEEE VAT Amount";
        ItemJnlLine."BC6_DEEE TTC Amount" := SalesLine."BC6_DEEE TTC Amount";
        ItemJnlLine."BC6_Eco partner DEEE" := SalesLine."BC6_Eco partner DEEE";
        ItemJnlLine."BC6_DEEE HT Amount (LCY)" := SalesLine."BC6_DEEE HT Amount (LCY)";
        ItemJnlLine."BC6_DEEE Unit Price (LCY)" := SalesLine."BC6_DEEE Unit Price (LCY)";
        ItemJnlLine."BC6_DEEE Amount (LCY) for Stat" := SalesLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnValidateItemNoOnBeforeSetDescription', '', false, false)]
    local procedure T83_OnValidateItemNoOnBeforeSetDescription_ItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    begin
        ItemJournalLine."BC6_DEEE Category Code" := Item."BC6_DEEE Category Code";
        ItemJournalLine."BC6_Eco partner DEEE" := Item."BC6_Eco partner DEEE";
        ItemJournalLine.CalculateDEEE('');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnBeforeCheckReservedQtyBase', '', false, false)]
    local procedure T83_OnBeforeCheckReservedQtyBase_ItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; var Item: Record Item; var IsHandled: Boolean)
    begin
        ItemJournalLine.CalculateDEEE('');
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCalcVATAmountLinesOnBeforeQtyTypeGeneralCase', '', false, false)]
    local procedure T37_OnCalcVATAmountLinesOnBeforeQtyTypeGeneralCase_SalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line"; IncludePrepayments: Boolean; QtyType: Option; var QtyToHandle: Decimal; var AmtToHandle: Decimal)
    var
        Currency: Record Currency;
    begin
        VATAmountLine."BC6_DEEE HT Amount" += SalesLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" += ROUND(SalesLine."BC6_DEEE VAT Amount"
              , Currency."Amount Rounding Precision");
        VATAmountLine."Bc6_DEEE TTC Amount" += ROUND(SalesLine."BC6_DEEE TTC Amount"
              , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE Amount (LCY) for Stat" += SalesLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmounts', '', false, false)]
    local procedure T37_OnAfterUpdateAmounts_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine.CalcDiscountUnitPrice();
        SalesLine.CalcProfit();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceOnBeforeFindPrice', '', false, false)]
    local procedure T37_OnUpdateUnitPriceOnBeforeFindPrice_SalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        PriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
        PriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, CalledByFieldNo);
        // PriceCalcMgt.FindVeryBestPrice(SalesLine, SalesHeader);  TODO:
        SalesLine.FctGCalcLineDiscount();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckBinCodeRelation', '', false, false)]
    local procedure T37_OnBeforeCheckBinCodeRelation_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        WMSManagement: Codeunit "WMS Management";
    begin
        if ((SalesLine."Document Type" IN [SalesLine."Document Type"::Invoice]) AND (SalesLine.Quantity >= 0)) or
                                                                     ((SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"]) AND (SalesLine.Quantity < 0))
                                                                  THEN
            WMSManagement.FindBinContent(SalesLine."Location Code", SalesLine."Bin Code", SalesLine."No.", SalesLine."Variant Code", '')
        else
            WMSManagement.FindBin(SalesLine."Location Code", SalesLine."Bin Code", '');

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateLineDiscountPercent', '', false, false)]
    local procedure T37_OnAfterValidateLineDiscountPercent_SalesLine(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    var
        L_Item: Record Item;
        L_Vendor: Record Vendor;
        L_UserSetup: Record "User Setup";
        L_IncrPurchCost: Decimal;
        L_IncrProfit: Decimal;
        UpdateProfitErr: Label '%1 cannot be less than %2 in %3 %4', Comment = 'FRA="%1 ne peut pas être inférieur à %2 dans %3 %4"';
    begin
        SalesLine.CalcDiscountUnitPrice();
        IF ((SalesLine."Document Type" = SalesLine."Document Type"::Quote) OR (SalesLine."Document Type" = SalesLine."Document Type"::Order)) AND
           NOT SalesLine.GetSkipPurchCostVerif THEN BEGIN
            IF L_UserSetup.GET(USERID) AND L_UserSetup."BC6_Activ. Mini Margin Control" THEN BEGIN
                IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                    L_Item.GET(SalesLine."No.");
                    IF L_Vendor.GET(L_Item."Vendor No.") AND (L_Vendor."BC6_% Mini Margin" <> 0) THEN BEGIN
                        SalesLine.CalcIncreasePurchCost(L_IncrPurchCost);
                        SalesLine.CalcIncreaseProfit(L_IncrProfit, L_IncrPurchCost);
                        IF L_IncrProfit < L_Vendor."BC6_% Mini Margin" THEN
                            ERROR(UpdateProfitErr, SalesLine.FIELDCAPTION(SalesLine."Profit %"), L_Vendor.FIELDCAPTION("BC6_% Mini Margin"), L_Vendor.TABLECAPTION, L_Vendor."No.");
                    END;
                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Profit %', false, false)]
    local procedure T37_OnAfterValidateEvent_SalesLine_Profit(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        Rec.CalcDiscount;
        Rec.CalcDiscountUnitPrice;
        Rec.VALIDATE(Rec."Line Discount %");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQtyToShipAfterInitQty', '', false, false)]
    local procedure T37_OnValidateQtyToShipAfterInitQty_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        Text007: Label 'You cannot ship more than %1 units.';
        Text008: Label 'You cannot ship more than %1 base units.';
    begin
        if (((SalesLine."Qty. to Ship" < 0) xor (SalesLine.Quantity < 0)) and (SalesLine.Quantity <> 0) and (SalesLine."Qty. to Ship" <> 0)) or
                      (Abs(SalesLine."Qty. to Ship") > Abs(SalesLine."Outstanding Quantity")) or
                      (((SalesLine.Quantity < 0) xor (SalesLine."Outstanding Quantity" < 0)) and (SalesLine.Quantity <> 0) and (SalesLine."Outstanding Quantity" <> 0))
                   then
            Error(Text007, SalesLine."Outstanding Quantity");
        if (((SalesLine."Qty. to Ship (Base)" < 0) xor (SalesLine."Quantity (Base)" < 0)) and (SalesLine."Qty. to Ship (Base)" <> 0) and (SalesLine."Quantity (Base)" <> 0)) or
           (Abs(SalesLine."Qty. to Ship (Base)") > Abs(SalesLine."Outstanding Qty. (Base)")) or
           (((SalesLine."Quantity (Base)" < 0) xor (SalesLine."Outstanding Qty. (Base)" < 0)) and (SalesLine."Quantity (Base)" <> 0) and (SalesLine."Outstanding Qty. (Base)" <> 0))
        then
            Error(Text008, SalesLine."Outstanding Qty. (Base)");

        SalesLine."BC6_Qty. To Order" := SalesLine."Qty. to Ship";

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateLocationCodeOnBeforeSetShipmentDate', '', false, false)]
    local procedure T37_OnValidateLocationCodeOnBeforeSetShipmentDate_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesLine."BC6_Invoiced Date (Expected)" := SalesLine."Shipment Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeUpdateDates', '', false, false)]
    local procedure T37_OnValidateNoOnBeforeUpdateDates_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CallingFieldNo: Integer; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."BC6_Customer Sales Profit Group" := SalesHeader."BC6_Customer Sales Profit Group";

        SalesLine."BC6_External Document No." := SalesHeader."External Document No.";

        SalesLine."BC6_Invoiced Date (Expected)" := SalesLine."Shipment Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterHasTypeToFillMandatoryFields', '', false, false)]
    local procedure T37_OnAfterHasTypeToFillMandatoryFields_SalesLine(var SalesLine: Record "Sales Line"; var ReturnValue: Boolean)
    begin
        if ReturnValue then
            SalesLine.SetSkipPurchCostVerif(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeCheckAssocPurchOrder', '', false, false)]
    local procedure OnValidateQuantityOnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line")
    begin
        SalesLine.SetSkipPurchCostVerif(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeValidateQtyToAssembleToOrder', '', false, false)]
    local procedure OnValidateQuantityOnBeforeValidateQtyToAssembleToOrder(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean);
    var
        RecLSalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        RecLSalesReceivablesSetup.GET;
        IF NOT RecLSalesReceivablesSetup."BC6_Active Quantity Management" THEN
            SalesLine.UpdateUnitPrice(SalesLine.FIELDNO(Quantity))
        ELSE
            SalesLine.VALIDATE("Unit Price", SalesLine."Unit Price");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T37_OnAfterValidateEvent_SalesLine(var Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        RecGCustomer: Record Customer;
        Currency: Record Currency;
    begin
        Rec.VALIDATE("BC6_DEEE HT Amount", 0);
        Rec."BC6_DEEE VAT Amount" := 0;
        Rec."BC6_DEEE TTC Amount" := 0;
        Rec."BC6_DEEE Amount (LCY) for Stat" := 0;

        RecGCustomer.GET(Rec."Sell-to Customer No.");
        IF RecGCustomer."BC6_Submitted to DEEE" THEN BEGIN
            Rec.VALIDATE("BC6_DEEE HT Amount", Rec."BC6_DEEE Unit Price" * Rec."Quantity (Base)");
            Rec."BC6_DEEE VAT Amount" := ROUND(Rec."BC6_DEEE HT Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
            Rec."BC6_DEEE TTC Amount" := Rec."BC6_DEEE HT Amount" + Rec."BC6_DEEE VAT Amount";
            Rec."BC6_DEEE Amount (LCY) for Stat" := Rec."Quantity (Base)" * Rec."BC6_DEEE Unit Price (LCY)";
        END;
        Rec."BC6_Qty. To Order" := Rec.Quantity;

        Rec.SetSkipPurchCostVerif(false);
        Rec.Modify();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', false, false)]
    local procedure T37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine.CalcProfit;
        SalesLine.CalcDiscountUnitPrice;
        SalesLine.FctGCalcLineDiscount();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterTestStatusOpen', '', false, false)]
    local procedure T37_OnAfterTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        RecLPurchLine: Record "Purchase Line";
        textg002: Label 'You will lost link between Sales document No %1 line %2 \ and purchase document of type %3, No %4 ,  line %5 \ Are you sure?';
    begin
        IF (SalesLine."BC6_Purch. Order No." <> '') OR (SalesLine."BC6_Purch. Line No." <> 0) THEN
            IF NOT CONFIRM(textg002, FALSE, SalesLine."Document No.", SalesLine."Line No.", SalesLine."BC6_Purch. Document Type", SalesLine."BC6_Purch. Order No.", SalesLine."BC6_Purch. Line No.") THEN
                ERROR('')
            ELSE BEGIN
                RecLPurchLine.RESET;
                RecLPurchLine.SETFILTER("BC6_Sales Document Type", '%1', SalesHeader."Document Type");
                RecLPurchLine.SETFILTER("BC6_Sales Line No.", '%1', SalesLine."Line No.");
                RecLPurchLine.SETFILTER("BC6_Sales No.", SalesLine."Document No.");
                IF RecLPurchLine.FIND('-') THEN
                    REPEAT
                        RecLPurchLine."BC6_Sales No." := '';
                        RecLPurchLine."BC6_Sales Line No." := 0;
                        SalesLine."BC6_Purch. Order No." := '';
                        SalesLine."BC6_Purch. Line No." := 0;
                        RecLPurchLine.MODIFY(TRUE);
                    UNTIL RecLPurchLine.NEXT = 0;
            END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure T37_OnBeforeTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)
    begin
        SalesLine.TestStatusLocked;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T37_OnAfterInsertEvent_SalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        "---DEEE1.00---": Integer;
        RecLItem: Record Item;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF ((Rec.Type = Rec.Type::Item) AND (RecLItem.GET(Rec."No."))) THEN
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");

        Rec.UpdateReturnOrderTypeFromSalesHeader;
        Rec.Modify();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine.CalcDiscountUnitPrice();
        SalesLine.CalcProfit();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T39_OnAfterInsertEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        "---DEEE1.00---": Integer;
        RecLItem: Record Item;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF ((Rec.Type = Rec.Type::Item) AND (RecLItem.GET(Rec."No."))) THEN
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");
        Rec.UpdateReturnOrderTypeFromSalesHeader;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T39_OnAfterModifyEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.CalcDiscountDirectUnitCost;
        ;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure T39_OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order THEN BEGIN
            PurchaseLine.LOCKTABLE;
            SalesOrderLine.LOCKTABLE;
            SalesOrderLine.RESET;
            SalesOrderLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Document Type", PurchaseLine."Document Type");
            SalesOrderLine.SETRANGE("BC6_Purch. Order No.", PurchaseLine."Document No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Line No.", PurchaseLine."Line No.");
            IF SalesOrderLine.FIND('-') THEN
                REPEAT
                    SalesOrderLine."BC6_Purch. Document Type" := 0;
                    SalesOrderLine."BC6_Purch. Order No." := '';
                    SalesOrderLine."BC6_Purch. Line No." := 0;
                    SalesOrderLine.MODIFY();
                UNTIL SalesOrderLine.NEXT = 0;
        END;

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    begin
        PurchLine.VALIDATE("BC6_DEEE Category Code", Item."BC6_DEEE Category Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure T39_OnAfterUpdateAmountsDone_PurchLine(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        PurchLine.CalcDiscountDirectUnitCost();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine', '', false, false)]
    local procedure OnCalcVATAmountLinesOnBeforeVATAmountLineSumLine(PurchaseLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line"; QtyType: Option General,Invoicing,Shipping; var PurchaseLine2: Record "Purchase Line")
    var
        Currency: Record Currency;
    begin
        VATAmountLine."BC6_DEEE HT Amount" += PurchaseLine."BC6_DEEE HT Amount";
        VATAmountLine."BC6_DEEE VAT Amount" += ROUND(PurchaseLine."BC6_DEEE VAT Amount"
            , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE TTC Amount" += ROUND(PurchaseLine."BC6_DEEE TTC Amount"
            , Currency."Amount Rounding Precision");
        VATAmountLine."BC6_DEEE Amount (LCY) for Stat" += PurchaseLine."BC6_DEEE Amount (LCY) for Stat";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Qty. (Phys. Inventory)', false, false)]
    local procedure T83_OnAfterValidateEvent(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    begin
        Rec."BC6_Qty. Refreshed (Phys. Inv.)" := FALSE;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Shipment Date', false, false)]
    local procedure T37_OnAfterValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        Rec."BC6_Invoiced Date (Expected)" := Rec."Shipment Date";
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Header", 'OnAfterValidateEvent', 'Destination No.', false, false)]
    local procedure T5766_OnAfterValidate(var Rec: Record "Warehouse Activity Header"; var xRec: Record "Warehouse Activity Header")
    var
        Customer: Record Customer;
    begin
        case Rec."Destination Type" of
            Rec."Destination Type"::Customer:
                BEGIN
                    Customer.GET(Rec."Destination No.");
                    case Customer.Blocked of
                        1, 3:
                            Customer.TESTFIELD(Blocked, 0);
                    end;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnAfterValidateEvent', 'Sales Code', false, false)]
    local procedure T7002_OnAfterValidateEvent(var Rec: Record "Sales Price"; var xRec: Record "Sales Price")
    var
        "-FE25-26.001:SEBC-": Integer;
        RecGSalesSetup: Record "Sales & Receivables Setup";
        CustPriceGr: Record "Customer Price Group";
        Cust: Record Customer;
        Campaign: Record Campaign;
        Text001: Label '%1 must be blank.', Comment = 'FRA="%1 doit être blanc."';
    begin
        RecGSalesSetup.GET;
        if Rec."Sales Code" <> '' then
            case Rec."Sales Type" of
                Rec."Sales Type"::"All Customers":
                    Error(Text001, Rec.FieldCaption(Rec."Sales Code"));
                Rec."Sales Type"::"Customer Price Group":
                    begin
                        CustPriceGr.Get(Rec."Sales Code");
                        Rec."Price Includes VAT" := CustPriceGr."Price Includes VAT";
                        Rec."VAT Bus. Posting Gr. (Price)" := CustPriceGr."VAT Bus. Posting Gr. (Price)";
                        IF RecGSalesSetup."BC6_Upd. Price AllowLine disc." THEN
                            Rec."Allow Line Disc." := CustPriceGr."Allow Line Disc."
                        else
                            Rec."Allow Line Disc." := xRec."Allow Line Disc.";
                        Rec."Allow Invoice Disc." := CustPriceGr."Allow Invoice Disc.";
                    end;
                Rec."Sales Type"::Customer:
                    begin
                        Cust.Get(Rec."Sales Code");
                        Rec."Currency Code" := Cust."Currency Code";
                        Rec."Price Includes VAT" := Cust."Prices Including VAT";
                        Rec."VAT Bus. Posting Gr. (Price)" := Cust."VAT Bus. Posting Group";
                        IF RecGSalesSetup."BC6_Upd. Price AllowLine disc." THEN
                            Rec."Allow Line Disc." := Cust."Allow Line Disc."
                        else
                            Rec."Allow Line Disc." := xRec."Allow Line Disc.";
                    end;
                Rec."Sales Type"::Campaign:
                    begin
                        Campaign.Get(Rec."Sales Code");
                        Rec."Starting Date" := Campaign."Starting Date";
                        Rec."Ending Date" := Campaign."Ending Date";
                    end;
            end;
        Rec.Modify();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", 'OnPurchaseReferenceNoLookupOnBeforeValidateDirectUnitCost', '', false, false)]
    local procedure OnPurchaseReferenceNoLookupOnBeforeValidateDirectUnitCost(var PurchaseLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    var
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        FctMngt: Codeunit BC6_FctMangt;
    begin
        FctMngt.FindVeryBestCost(PurchaseLine, PurchHeader);
    end;
    //COD12
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCalcPmtDiscPossible', '', false, false)]

    local procedure COD12_OnBeforeCalcPmtDiscPossible(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var IsHandled: Boolean; RoundingPrecision: Decimal)
    var
        PaymentDiscountDateWithGracePeriod: Date;
        GLSetup: Record "General Ledger Setup";
        FctMngt: Codeunit BC6_FctMangt;

    begin
        IsHandled := true;
        with GenJnlLine do
            if "Amount (LCY)" <> 0 then begin
                PaymentDiscountDateWithGracePeriod := CVLedgEntryBuf."Pmt. Discount Date";
                GLSetup.GetRecordOnce();
                if PaymentDiscountDateWithGracePeriod <> 0D then
                    PaymentDiscountDateWithGracePeriod :=
                      CalcDate(GLSetup."Payment Discount Grace Period", PaymentDiscountDateWithGracePeriod);
                if (PaymentDiscountDateWithGracePeriod >= CVLedgEntryBuf."Posting Date") or
                   (PaymentDiscountDateWithGracePeriod = 0D)
                then begin
                    if GLSetup."Pmt. Disc. Excl. VAT" then begin
                        if "Sales/Purch. (LCY)" = 0 then
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" := ("Amount (LCY)" + FctMngt.TotalVATAmountOnJnlLines(GenJnlLine)) * (Amount - "BC6_DEEE HT Amount") / ("Amount (LCY)" - "BC6_DEEE HT Amount (LCY)")
                        else
                            CVLedgEntryBuf."Original Pmt. Disc. Possible" := "Sales/Purch. (LCY)" * (Amount - "BC6_DEEE HT Amount") / ("Amount (LCY)" - "BC6_DEEE HT Amount (LCY)")
                    end else
                        CVLedgEntryBuf."Original Pmt. Disc. Possible" := (Amount - "BC6_DEEE HT Amount");
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure COD12_OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."BC6_Pay-to Customer No." := GenJournalLine."BC6_Pay-to No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure COD12_OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldVendLedgEntry."BC6_Pay-to Vend. No." := GenJournalLine."BC6_Pay-to No.";
    end;

    //COD21
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckInTransitLocations', '', false, false)]

    local procedure COD21_OnBeforeCheckInTransitLocations(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        Location: Record Location;
        FctMngt: Codeunit BC6_FctMangt;
    begin
        IsHandled := true;
        with ItemJournalLine do
            if (("Entry Type" <> "Entry Type"::Transfer) or ("Order Type" <> "Order Type"::Transfer)) and
               not Adjustment
            then begin
                FctMngt.CheckInTransitLocation("Location Code");
                Location.TESTFIELD("BC6_Blocked", FALSE);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckPhysInventory', '', false, false)]

    local procedure COD21_OnBeforeCheckPhysInventory(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        Text005: Label 'must be %1 or %2 when %3 is %4';
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        IsHandled := true;
        with ItemJnlLine do begin
            if not
               ("Entry Type" in
                ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."])
            then begin
                ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
                ItemJnlLine3."Entry Type" := ItemJnlLine3."Entry Type"::"Negative Adjmt.";
                FieldError(
                    "Entry Type",
                    ErrorInfo.Create(
                        StrSubstNo(
                            Text005, ItemJnlLine2."Entry Type", ItemJnlLine3."Entry Type", FieldCaption("Phys. Inventory"), true),
                        true));
            end;
            IF ("Entry Type" IN
              ["Entry Type"::"Positive Adjmt.",
               "Entry Type"::"Negative Adjmt."]) THEN
                IF ItemJournalBatch.GET("Journal Template Name", ItemJnlLine."Journal Batch Name") THEN
                    ItemJournalBatch.TESTFIELD("BC6_Phys. Inv. Survey", FALSE);

        end;
    end;

    //COD22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure COD22_OnBeforeInsertItemLedgEntry_ItemJnlPostLine(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        RecLDEEEEntry: Record "BC6_DEEE Ledger Entry";
    begin
        IF (ItemJournalLine."BC6_DEEE Category Code" <> '') THEN BEGIN
            RecLDEEEEntry.TRANSFERFIELDS(ItemJournalLine);
            RecLDEEEEntry."DEEE Category Code" := ItemJournalLine."BC6_DEEE Category Code";
            RecLDEEEEntry."DEEE Unit Tax" := ItemJournalLine."BC6_DEEE Unit Price";
            RecLDEEEEntry."DEEE HT Amount" := ItemJournalLine."BC6_DEEE HT Amount";
            RecLDEEEEntry."DEEE VAT Amount" := ItemJournalLine."BC6_DEEE VAT Amount";
            RecLDEEEEntry."DEEE TTC Amount" := ItemJournalLine."BC6_DEEE TTC Amount";
            RecLDEEEEntry."Eco partner DEEE" := ItemJournalLine."BC6_Eco partner DEEE";
            RecLDEEEEntry."DEEE HT Amount (LCY)" := ItemJournalLine."BC6_DEEE HT Amount (LCY)";
            RecLDEEEEntry."DEEE Unit Price (LCY)" := ItemJournalLine."BC6_DEEE Unit Price (LCY)";
            RecLDEEEEntry."Gen. Bus. Posting Group" := ItemJournalLine."Gen. Bus. Posting Group";
            RecLDEEEEntry."DEEE Amount (LCY) for Stat" := ItemJournalLine."BC6_DEEE Amount (LCY) for Stat";
            RecLDEEEEntry.INSERT;
        END;
    end;

    //COD23
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeOpenProgressDialog', '', false, false)]
    local procedure COD23_OnBeforeOpenProgressDialog(var ItemJnlLine: Record "Item Journal Line"; var Window: Dialog; var WindowIsOpen: Boolean; var IsHandled: Boolean)
    var
        ItemJnlTemplate: Record "Item Journal Template";
        Text001: Label 'Journal Batch Name    #1##########\\';
        Text002: Label 'Checking lines        #2######\';
        Text003: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        Text004: Label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text101: Label 'ENU=Jnl. Batch #1###\\';
        Text102: Label 'ENU=Chec. lines #2###\';
        Text105: label 'ENU=Post. #3### @4@;FRA=Valid.#3### @4@@@';
        InvtSetup: Record "Inventory Setup";  //NOT SUREE
    begin
        IsHandled := true;
        ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");

        if ItemJnlTemplate.Recurring then
            Window.Open(
              Text001 +
              Text002 +
              Text003 +
              Text004)
        else
            IF (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 1") OR
               (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 2") THEN
                Window.OPEN(
                  Text101 +
                  Text102 +
                  Text105)
            ELSE
                Window.Open(
                  Text001 +
                  Text002 +
                  Text005);
        Window.Update(1, ItemJnlLine."Journal Batch Name");
        WindowIsOpen := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnItemJnlPostSumLineOnAfterGetItem', '', false, false)]
    //TODO: not sure of it(ItemJournalLine was ItemJournalLine4 in the old code)
    local procedure COD23_OnItemJnlPostSumLineOnAfterGetItem(var Item: Record Item; ItemJournalLine: Record "Item Journal Line")
    var
        IncludeExpectedCost: Boolean;
    begin
        IncludeExpectedCost :=
    (Item."Costing Method" = Item."Costing Method"::Average) and
    (ItemJournalLine."Inventory Value Per" <> ItemJournalLine."Inventory Value Per"::" ");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeWhseJnlPostLineRun', '', false, false)]
    local procedure COD23_OnBeforeWhseJnlPostLineRun(ItemJournalLine: Record "Item Journal Line"; var TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary; var IsHandled: Boolean)
    var
        InvtToReclass: Codeunit "BC6_Invt. Pick To Reclass.";
    begin
        InvtToReclass.RUN(TempWarehouseJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeCheckItemAvailabilityHandled', '', false, false)]
    local procedure COD23_OnBeforeCheckItemAvailabilityHandled(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
    begin
        InvtSetup.GET; //To check this event(InvtSetup is declared as a global variable)
    end;

    //COD 57 to be continued .. 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterSalesLineSetFilters', '', false, false)]
    local procedure COD57_OnAfterSalesLineSetFilters(var TotalSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line")
    begin
        TotalSalesLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", TotalSalesLine."BC6_DEEE HT Amount", TotalSalesLine."BC6_DEEE VAT Amount", TotalSalesLine."BC6_DEEE TTC Amount", TotalSalesLine."BC6_DEEE HT Amount (LCY)");
        TotalSalesLine."Amount Including VAT" := TotalSalesLine."Amount Including VAT" + TotalSalesLine."BC6_DEEE TTC Amount";
        TotalSalesLine.Amount := TotalSalesLine.Amount + TotalSalesLine."BC6_DEEE HT Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterPurchaseLineSetFilters', '', false, false)]
    local procedure COD57_OnAfterPurchaseLineSetFilters(var TotalPurchaseLine: Record "Purchase Line"; PurchaseLine: Record "Purchase Line")
    begin
        //BC6>>
        TotalPurchaseLine.CALCSUMS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", TotalPurchaseLine."BC6_DEEE HT Amount", TotalPurchaseLine."BC6_DEEE VAT Amount", TotalPurchaseLine."BC6_DEEE TTC Amount", TotalPurchaseLine."BC6_DEEE HT Amount (LCY)");
        TotalPurchaseLine."Amount Including VAT" := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."BC6_DEEE TTC Amount";
        TotalPurchaseLine.Amount := TotalPurchaseLine.Amount + TotalPurchaseLine."BC6_DEEE HT Amount";
        //BC6<<
    end;

    //COD80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure COD80_OnAfterPostSalesLines(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        FctMngt: Codeunit BC6_FctMangt;
    begin
        IF SalesHeader.Invoice THEN BEGIN
            IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] THEN BEGIN
                FctMngt.xUpdateShipmentInvoiced(SalesInvoiceHeader);
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterReverseAmount', '', false, false)]
    local procedure COD80_OnAfterReverseAmount(var SalesLine: Record "Sales Line")
    begin
        SalesLine."BC6_Purchase cost" := -SalesLine."BC6_Purchase cost";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostDropOrderShipment', '', false, false)]
    local procedure COD80_OnBeforePostDropOrderShipment(var SalesHeader: Record "Sales Header"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary)
    var
        TotalSalesLineLCY: Record "sales line";
    begin
        TotalSalesLineLCY.get(TotalSalesLineLCY."Document Type", TotalSalesLineLCY."Document No.", TotalSalesLineLCY."Line No.");
        if not SalesHeader.IsCreditDocType then begin
            TotalSalesLineLCY."Unit Cost (LCY)" := -TotalSalesLineLCY."Unit Cost (LCY)";
            TotalSalesLineLCY."BC6_Purchase cost" := -TotalSalesLineLCY."BC6_Purchase cost";
        end;
    end; //TO CHECK which is more coherent 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCalcItemJnlAmountsFromQtyToBeShipped', '', false, false)]
    local procedure COD80_OnBeforeCalcItemJnlAmountsFromQtyToBeShipped(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; QtyToBeShipped: Decimal; var IsHandled: Boolean)
    begin
        SalesLine."BC6_DEEE Category Code" := SalesLine."BC6_DEEE Category Code";

        IF SalesLine."Qty. to Ship" <> 0 THEN
            SalesLine."BC6_DEEE HT Amount" :=
              ROUND(
                SalesLine."BC6_DEEE HT Amount" *
                (QtyToBeShipped / SalesLine."Qty. to Ship"));

        IF SalesLine."Qty. to Ship" <> 0 THEN
            SalesLine."BC6_DEEE TTC Amount" :=
              ROUND(
              SalesLine."BC6_DEEE TTC Amount" *
              (QtyToBeShipped / SalesLine."Qty. to Ship"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateWhseDocuments', '', false, false)]
    local procedure COD80_OnAfterUpdateWhseDocuments(SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; EverythingInvoiced: Boolean)
    var
        FctMngt: Codeunit BC6_FctMangt;
        RecGParmNavi: Record "BC6_Navi+ Setup";
        RecGArchiveManagement: Codeunit ArchiveManagement;
        SalesInvHeader: Record "sales invoice header";
    begin
        SalesInvHeader.get();
        IF RecGParmNavi.GET THEN
            IF RecGParmNavi."Filing Sales Orders" THEN
                RecGArchiveManagement.StoreSalesDocument(SalesHeader, FALSE);
        FctMngt.xUpdateShipmentInvoiced(SalesInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeRoundAmount', '', false, false)]
    local procedure COD80_OnBeforeRoundAmount(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesLineQty: Decimal; var CurrExchRate: Record "Currency Exchange Rate")
    begin

        if SalesHeader."Currency Code" <> '' then begin
            //>>MIGRATION NAV 2013 - 2017
            SalesLine."BC6_DEEE Unit Price" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                   SalesHeader.GetUseDate(), SalesHeader."Currency Code",
                  SalesLine."BC6_DEEE Unit Price", SalesHeader."Currency Factor")) -
                    SalesLine."BC6_DEEE Unit Price";
            //<<MIGRATION NAV 2013 - 2017
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRoundAmountOnBeforeIncrAmount', '', false, false)]
    local procedure COD80_OnRoundAmountOnBeforeIncrAmount(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesLineQty: Decimal; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    var
        FctMngt: Codeunit BC6_FctMangt;
        EnableIncrPurchCost: Boolean; //(variable globale que je la déclaré locale, car elle est utilisée slmnt dans cette partie)
        L_Item: Record Item;
    begin

        // FctMngt.Increment(TotalSalesLine."BC6_Purchase cost",ROUND(SalesLineQty * TotalSalesLine."BC6_Purchase cost"));
        // IF EnableIncrPurchCost THEN
        //   IF L_Item.Type = L_Item.Type::Item THEN BEGIN
        //     L_Item.GET("No.");
        //     FctMngt.Increment(SalesLine."BC6_Purchase cost", ROUND(TotalSalesLine."BC6_Purchase cost" * L_Item."BC6_Cost Increase Coeff %" / 100) * SalesLineQty);
        //   END; //TODO: Item n'existe plus dans la liste des options de l'enum Type
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterIncrAmount', '', false, false)]
    local procedure COD80_OnAfterIncrAmount(var TotalSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        FctMngt: Codeunit BC6_FctMangt;

    begin
        FctMngt.Increment(TotalSalesLine."BC6_DEEE HT Amount", TotalSalesLine."BC6_DEEE HT Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE TTC Amount", TotalSalesLine."BC6_DEEE TTC Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE VAT Amount", TotalSalesLine."BC6_DEEE VAT Amount");
        FctMngt.Increment(TotalSalesLine."BC6_DEEE HT Amount (LCY)", TotalSalesLine."BC6_DEEE HT Amount (LCY)");
    end;


    //COD81
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnConfirmPostOnBeforeSetSelection', '', false, false)]
    local procedure COD81_OnConfirmPostOnBeforeSetSelection(var SalesHeader: Record "Sales Header")
    begin
        //>>MIGRATION NAV 2013
        //FG
        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice THEN
            SalesHeader.TESTFIELD(SalesHeader.Status, SalesHeader.Status::Released);
        //<<MIGRATION NAV 2013
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]

    local procedure COD81_OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLNaviSetup: Record "BC6_Navi+ Setup";
        AssmPost: Codeunit "Assembly-Post"; // Procedure moved from CDU80 to CDU900 and changed arguments .. 
    begin
        RecLNaviSetup.GET();
        IF RecLNaviSetup."Date jour en factur/livraison" THEN
            AssmPost.SetPostingDate(TRUE, WORKDATE);
    end;
    //COD82
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure COD82_OnBeforeConfirmPostProcedure(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        FctMngt: Codeunit BC6_FctMangt;
        ConfirmManagement: Codeunit "Confirm Management";
        SalesPostPrint: Codeunit "Sales-Post + Print";
        RecLNaviSetup: Record "BC6_Navi+ Setup";
        AsmPost: Codeunit "Assembly-Post";
    begin
        IsHandled := true;
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;
        with SalesHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := StrMenu(ShipInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit;
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
                        if Selection = 0 then
                            exit;
                        Receive := Selection in [1, 3];
                        IF Ship THEN FctMngt.CalcProfit2(SalesHeader);
                        Invoice := Selection in [2, 3];

                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(SalesPostPrint.ConfirmationMessage, "Document Type"), true)
                    then
                        exit;

            end;
            "Print Posted Documents" := true;
            //>>MIGRATION NAV 2013
            //>> NavEasy Correction FRGO 14/03/2007
            IF RecLNaviSetup.GET THEN BEGIN
                IF RecLNaviSetup."Date jour en factur/livraison" THEN
                    AsmPost.SetPostingDate(TRUE, WORKDATE);
            END;
            //<<NavEasy Correction FRGO 14/03/2007
            //<<MIGRATION NAV 2013

        end;
    end;
    //COD83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeConfirmConvertToOrder', '', false, false)]
    local procedure COD83_OnBeforeConfirmConvertToOrder(SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLSalesLine: Record "Sales Line";
        RecLItem: Record Item;

    begin
        //>>MIGRATION NAV 2013
        SalesHeader.TESTFIELD("Shipment Method Code", '');
        //>> MODIF HL 17/05/2011 SU-LALE cf appel TI046353
        // on vient v‚rifier si dans le devis les articles ne sont pas bloqu‚s.
        RecLSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        RecLSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        RecLSalesLine.SETRANGE(Type, RecLSalesLine.Type::Item);
        RecLSalesLine.SETFILTER("No.", '<>%1', '');
        IF RecLSalesLine.FINDFIRST THEN
            REPEAT
                RecLItem.GET(RecLSalesLine."No.");
                RecLItem.TESTFIELD(Blocked, FALSE);
            UNTIL RecLSalesLine.NEXT = 0;
        //<< MODIF HL 17/05/2011 SU-LALE cf appel TI046353
        //<<MIGRATION NAV 2013
    end;

    //COD 86
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure COD86_OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        FctMngt: Codeunit BC6_FctMangt;
    begin
        FctMngt.UpdatePurchasedoc(SalesQuoteLine, SalesQuoteLine);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeTransferQuoteLineToOrderLineLoop', '', false, false)]
    local procedure OnBeforeTransferQuoteLineToOrderLineLoop(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin

        // IF (SalesQuoteLine.Type = SalesQuoteLine.Type::Item) AND (SalesQuoteLine."No." <> '') THEN
        //     SalesQuoteLine.TESTFIELD("Purchasing Code");
        // CLEAR(Location);
        // IF (SalesQuoteLine."Location Code" <> '') THEN BEGIN
        //     Location.GET(SalesQuoteLine."Location Code");
        //     Location.TESTFIELD(Blocked, FALSE);
        //     IF Location."Bin Mandatory" THEN
        //         SalesQuoteLine.TESTFIELD("Bin Code");
        // END; //TODO Blocked & location are globales variables
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeTransferQuoteLineToOrderLineLoop', '', false, false)]
    local procedure COD86_OnAfterInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader."BC6_Bin Code" := SalesOrderHeader."BC6_Bin Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]

    local procedure COD86_OnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesQuoteLine: Record "Sales Line")
    var
        RecGParmNavi: Record "BC6_Navi+ Setup";
        RecGArchiveManagement: Codeunit ArchiveManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        //TODO if not IsHandled then begin
        //     ApprovalsMgmt.DeleteApprovalEntries(RecordId);
        //     SalesCommentLine.DeleteComments(QuoteSalesHeader."Document Type".AsInteger(), QuoteSalesHeader."No.");
        //     QuoteSalesHeader.DeleteLinks;
        //     QuoteSalesHeader.Delete;
        //     SalesQuoteLine.DeleteAll();
        // end;

    end;

}
