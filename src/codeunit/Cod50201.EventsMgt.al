codeunit 50201 "BC6_Events Mgt"
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
    procedure T27_OnAfterValidateEvent_Blocked(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        RecLAccessControl: Record "Access Control";
        CstG001: label 'You are not authorized to perform this operation.', comment = 'FRA="Vous n''avez pas l''autorisation d''effectuer cette opération."';
    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'MODIFART');
        if not RecLAccessControl.FINDFIRST() then
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
        Rec.BC6_ID := USERID
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

        if not IsDeleteFromReturnOrder then begin
            G_ReturnOrderMgt.DeleteRelatedDocument(Rec);
            G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(Rec);
        end;
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
        SalesHeader.CheckCrLimit();  //procedure spec dans tabExt (dupliquée)
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetSalespersonCode', '', false, false)]

    procedure T36_OnBeforeSetSalespersonCode_SalesHeader(var SalesHeader: Record "Sales Header"; SalesPersonCodeToCheck: Code[20]; var SalesPersonCodeToAssign: Code[20]; var IsHandled: Boolean)
    var
        Cust: Record Customer;
    begin
        Cust.Get();
        SalesHeader."BC6_Salesperson Filter" := Cust."BC6_Salesperson Filter";
        SalesHeader."BC6_Cust. Sales Profit Group" := Cust."BC6_Custom. Sales Profit Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Name', false, false)]
    procedure T36_OnAfterValidateEvent_BillToName(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if xRec."Bill-to Customer No." = '' then
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
        FonctionMgt: codeunit "BC6_Functions Mgt";
        BinCode: Code[20];
    begin
        if ShipmentMethodRec.GET(Rec."Shipment Method Code") then
            if ShipmentMethodRec."BC6_To Make Available" then begin
                if (Bin.GET(Rec."Location Code", Rec."BC6_Bin Code") and not (Bin."BC6_To Make Available")) or (Rec."BC6_Bin Code" = '') then begin
                    FonctionMgt.GetShipmentBin(Rec."Location Code", BinCode);
                    if Rec."BC6_Bin Code" <> BinCode then
                        Rec.VALIDATE(Rec."BC6_Bin Code", BinCode);
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    procedure T36_OnAfterValidateEvent_CurrencyCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        TextG001: label 'Warning, using foreign currency will generate wrong profit calculation.', Comment = 'FRA="Attention, l''utilisation de devises va provoquer un calcul erronné des marges."';

    begin
        if Rec."Currency Code" <> '' then
            MESSAGE(TextG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure T36_OnAfterValidateEvent_ReasonCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        RecLReasonCode: Record "Reason Code";
        RecLSalesLine: Record "Sales Line";
    begin
        if xRec."Reason Code" <> Rec."Reason Code" then begin
            RecLSalesLine.SETRANGE("Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("Document No.", Rec."No.");
            if RecLSalesLine.FIND('-') then
                repeat
                    RecLSalesLine."BC6_DEEE Category Code" := RecLSalesLine."BC6_DEEE Category Code";
                    RecLSalesLine.CalculateDEEE(Rec."Reason Code");
                    RecLSalesLine.MODIFY();
                until RecLSalesLine.NEXT() = 0;
        end;
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
        if xRec."Sell-to Customer Name" = '' then
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
        if (Rec.Status <> Rec.Status::Open) and (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and (Rec."Document Type" = Rec."Document Type"::Order)
        then begin
            CDUReleaseDoc.Reopen(Rec);
            BoolReclose := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Shipping Agent Code', false, false)]
    procedure T36_OnAfterValidateEvent_ShippAgentCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        if BoolReclose then begin   //TODO: je Dois récuperé la valeur
            CDUReleaseDoc.RUN(Rec);
            BoolReclose := false;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Shipping Agent Service Code', false, false)]
    procedure T36_OnBeforeValidateEvent_ShippAgentServCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        if (Rec.Status <> Rec.Status::Open) and (xRec."Shipping Agent Service Code" <> Rec."Shipping Agent Service Code")
        and (Rec."Document Type" = Rec."Document Type"::Order)
        then begin
            CDUReleaseDoc.Reopen(Rec);
            BoolReclose := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Shipping Agent Service Code', false, false)]
    procedure T36_OnAfterValidateEvent_ShippAgentServCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CDUReleaseDoc: Codeunit "Release Sales Document";
        BoolReclose: Boolean;
    begin
        if BoolReclose then begin
            CDUReleaseDoc.RUN(Rec);
            BoolReclose := false;
        end;
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
        FonctionMgt: Codeunit "BC6_Functions Mgt";
        TextG002: label 'Update Bill-to address ?', Comment = 'FRA="Voulez-vous mettre à jour l''adresse de Facturation ?"';
    begin
        SalesSetup.Get();
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote)
           or ((SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and SalesSetup."Contact's Address on sales doc") then begin
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
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                if CONFIRM(TextG002, false) then begin
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
        Rec.BC6_ID := USERID
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
        if Rec."Document Type" = Rec."Document Type"::Order then
            G_ReturnOrderMgt.DeleteRelatedPurchOrderNo(Rec)
        else
            if (Rec."Document Type" = Rec."Document Type"::"Return Order") then
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
        PurchaseHeader.UpdateIncoterm();
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] then
            PurchaseHeader."Posting Description" := COPYSTR(FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' : ' + FORMAT(PurchaseHeader."Document Type") + ' ' + PurchaseHeader."No."
                                       , 1, MAXSTRLEN(PurchaseHeader."Posting Description"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    procedure T38_OnAfterValidateEvent_CurrCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        TextG001: label 'Warning, using foreign currency will generate wrong profit calculation.', Comment = 'FRA="Attention, l''utilisation de devises va provoquer un calcul erronné des marges."';

    begin
        if Rec."Currency Code" <> '' then
            MESSAGE(TextG001);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Reason Code', false, false)]
    procedure T38_OnAfterValidateEvent_ResCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        RecLPurchLine: Record "Purchase Line";
        RecLReasonCode: Record "Reason Code";
    begin
        if xRec."Reason Code" <> Rec."Reason Code" then begin
            RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
            RecLPurchLine.SETRANGE("Document No.", Rec."No.");
            if RecLPurchLine.FIND('-') then
                repeat
                    RecLPurchLine."BC6_DEEE Category Code" := RecLPurchLine."BC6_DEEE Category Code";
                    RecLPurchLine.CalculateDEEE(Rec."Reason Code");
                    RecLPurchLine.MODIFY();
                until RecLPurchLine.NEXT() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Buy-from Vendor Name', false, false)]
    procedure T38_OnBeforeValidateEvent_BuyfromVendorName(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        Vendor: Record Vendor;
    begin
        if xRec."Buy-from Vendor Name" = '' then
            Rec.VALIDATE("Buy-from Vendor No.", Vendor.GetVendorNo(Rec."Buy-from Vendor Name"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitPostingNoSeries', '', false, false)]
    //TODO: checkMe
    procedure T38_OnAfterInitPostingNoSeries_PurchHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Quote, PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Return Order"] then begin
            PurchaseHeader."Order Date" := WORKDATE();
            PurchaseHeader."Posting Date" := WORKDATE();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    procedure T38_OnAfterInitRecord_PurchHeader(var PurchHeader: Record "Purchase Header")
    var
        Vend: Record Vendor;   //TODO : check if we need to get vend before , ps: we can use the fct VendGet of the std
        UserSetupMgt: Codeunit "User Setup Management";

    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Quote then
            PurchHeader.VALIDATE("Location Code", UserSetupMgt.GetLocation(1, Vend."Location Code", PurchHeader."Responsibility Center"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTestNoSeries', '', false, false)]
    procedure T38_OnAfterTestNoSeries_PurchHeader(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup")
    begin
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::"Return Order":
                begin
                    if PurchHeader."BC6_Return Order Type" = PurchHeader."BC6_Return Order Type"::SAV then
                        PurchSetup.TESTFIELD("BC6_SAV Return Order Nos.")
                    else
                        PurchSetup.TESTFIELD("Return Order Nos.");
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    procedure T38_OnAfterGetNoSeriesCode_PurchHeader(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    begin
        case PurchHeader."Document Type" of

            PurchHeader."Document Type"::"Return Order":
                begin
                    if PurchHeader."BC6_Return Order Type" = PurchHeader."BC6_Return Order Type"::SAV then
                        NoSeriesCode := PurchSetup."BC6_SAV Return Order Nos."
                    else
                        NoSeriesCode := PurchSetup."Return Order Nos.";
                end;
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

    procedure COD427_OnAfterICOutBoxSalesHeaderTransferFields(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesHeader: Record "Sales Header")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesHeader."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader', '', false, false)]

    procedure COD427_OnCreateOutboxSalesInvTransOnAfterTransferFieldsFromSalesInvHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesInvHdr: Record "Sales Invoice Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesInvHdr."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader', '', false, false)]

    procedure COD427_OnCreateOutboxSalesCrMemoTransOnAfterTransferFieldsFromSalesCrMemoHeader(var ICOutboxSalesHeader: Record "IC Outbox Sales Header"; SalesCrMemoHdr: Record "Sales Cr.Memo Header"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutBoxSalesHeader."BC6_Ship-to Contact" := SalesCrMemoHdr."Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader', '', false, false)]

    procedure COD427_OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader(var ICOutboxPurchHeader: Record "IC Outbox Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        ICOutBoxPurchHeader."BC6_Ship-to Contact" := PurchHeader."Ship-to Contact";
    end;

    //TODO: to check this event 
    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesDocumentOnBeforeSalesHeaderInsert', '', false, false)]

    procedure COD427_OnCreateSalesDocumentOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header"; ICInboxSalesHeader: Record "IC Inbox Sales Header")
    begin
        SalesHeader."Your Reference" := ICInboxSalesHeader."External Document No.";
        SalesHeader."Ship-to Contact" := ICInboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateSalesLinesOnAfterValidateNo', '', false, false)]
    procedure COD427_OnCreateSalesLinesOnAfterValidateNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; ICInboxSalesLine: Record "IC Inbox Sales Line")
    begin
        SalesLine."BC6_Purchase No. Order Lien" := ICInboxSalesLine."Document No.";
        SalesLine."BC6_Purchase No. Line Lien" := ICInboxSalesLine."Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreatePurchDocumentOnBeforePurchHeaderInsert', '', false, false)]
    procedure COD427_OnCreatePurchDocumentOnBeforePurchHeaderInsert(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    begin
        PurchaseHeader."Ship-to Contact" := ICInboxPurchaseHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxPurchHeaderInsert', '', false, false)]
    procedure COD427_OnBeforeICInboxPurchHeaderInsert(var ICInboxPurchaseHeader: Record "IC Inbox Purchase Header"; ICOutboxSalesHeader: Record "IC Outbox Sales Header")
    begin
        ICInboxPurchaseHeader."BC6_Ship-to Contact" := ICOutboxSalesHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesHeaderInsert', '', false, false)]
    procedure COD427_OnBeforeICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."BC6_Ship-to Contact" := ICOutboxPurchaseHeader."BC6_Ship-to Contact";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICInboxSalesHeaderInsert', '', false, false)]

    procedure COD427_OnAfterICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."External Document No." := ICOutboxPurchaseHeader."Your Reference";
    end;
    //COD550
    [EventSubscriber(ObjectType::Codeunit, codeunit::"VAT Rate Change Conversion", 'OnBeforeUpdateItem', '', false, false)]
    procedure COD550_OnBeforeUpdateItem(var Item: Record Item; var VATRateChangeSetup: Record "VAT Rate Change Setup"; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_Functions Mgt";
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
        fctMgt: Codeunit "BC6_Functions Mgt";
    begin
        IsHandled := true;
        fctMgt.GetTaxAmountFromSalesOrder_CNE(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Cash Flow Management", 'OnBeforeGetTaxAmountFromPurchaseOrder', '', false, false)]

    procedure COD841_OnBeforeGetTaxAmountFromPurchaseOrder(PurchaseHeader: Record "Purchase Header"; var VATAmount: Decimal; var IsHandled: Boolean)
    var
        fctMgt: Codeunit "BC6_Functions Mgt";
    begin
        IsHandled := true;
    end;

    //COD1302
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterIsBillToAddressEqualToSellToAddress', '', false, false)]
    procedure COD1302_OnAfterIsBillToAddressEqualToSellToAddress(SellToSalesHeader: Record "Sales Header"; BillToSalesHeader: Record "Sales Header"; var Result: Boolean)
    begin
        Result := Result and (BillToSalesHeader."Bill-to Name" = SellToSalesHeader."Sell-to Customer Name");
    end;

    //COD1330
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Instruction Mgt.", 'OnAfterIsEnabled', '', false, false)]
    procedure COD1330_OnAfterIsEnabled(InstructionType: Code[50]; var Result: Boolean)
    var
        fctMgt: Codeunit "BC6_Functions Mgt";
    begin
        if InstructionType = fctMgt.ShowPostedConfirmationMessageCode() then
            Result := false;
    end;
    //COD5063

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]

    procedure COD5063_OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
        SalesHeader.MODIFY();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ArchiveManagement, 'OnRestoreSalesDocumentOnAfterSalesHeaderInsert', '', false, false)]
    procedure COD5063_OnRestoreSalesDocumentOnAfterSalesHeaderInsert(var SalesHeader: Record "Sales Header"; SalesHeaderArchive: Record "Sales Header Archive");
    begin
        SalesHeader."BC6_Prod. Version No." := SalesHeaderArchive."Version No.";
    end;


    //COD5776
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Warehouse Document-Print", 'OnBeforePrintInvtPickHeader', '', false, false)]

    procedure COD5776_OnBeforePrintInvtPickHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var IsHandled: Boolean; var HideDialog: Boolean)
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
        fctMgt: Codeunit "BC6_Functions Mgt";
        WhseUndoQty: Codeunit "Whse. Undo Quantity";

    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Purch. Rcpt. Header",
  0,
  PurchRcptLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Rcpt.",
  DATABASE::"Purchase Line",
 PurchLine."Document Type"::Order.AsInteger(),
  PurchRcptLine."Order No.",
  PurchRcptLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);
    end;

    //COD5814
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Return Shipment Line", 'OnAfterCopyItemJnlLineFromReturnShpt', '', false, false)]
    procedure COD5814_OnAfterCopyItemJnlLineFromReturnShpt(var ItemJournalLine: Record "Item Journal Line"; ReturnShipmentHeader: Record "Return Shipment Header"; ReturnShipmentLine: Record "Return Shipment Line"; var WhseUndoQty: Codeunit "Whse. Undo Quantity")

    var
        PurchLine: Record "Purchase Line";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;

        //TODO: à verifier srtt les declarations

        fctMgt: Codeunit "BC6_Functions Mgt";
        NextLineNo: Integer;
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJournalLine,
          DATABASE::"Return Shipment Header",
          0,
          PurchLine."Document No.",
          0,
          TempWhseJnlLine."Reference Document"::"Posted Rtrn. Shipment",
          DATABASE::"Purchase Line",
          PurchLine."Document Type"::"Return Order".AsInteger(),
          ReturnShipmentLine."Return Order No.",
          ReturnShipmentLine."Return Order Line No.",
          TempWhseJnlLine, NextLineNo);
    end;
    //COD5815
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnCodeOnBeforeUndoLoop', '', false, false)]
    procedure COD5815_OnCodeOnBeforeUndoLoop(var SalesShptLine: Record "Sales Shipment Line")
    var
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
    begin
        if not TempWhseJnlLine.ISEMPTY then
            TempWhseJnlLine.DELETEALL();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Sales Shipment Line", 'OnPostItemJnlLineOnAfterInsertTempWhseJnlLine', '', false, false)]
    procedure COD5815_OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(SalesShptLine: Record "Sales Shipment Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        fctMgt: Codeunit "BC6_Functions Mgt";
    begin
        fctMgt.InsertTempWhseJnlLine2(ItemJnlLine,
  DATABASE::"Sales Shipment Header",
  0,
ItemJnlLine."Document No.",
  0,
  TempWhseJnlLine."Reference Document"::"Posted Shipment",
  DATABASE::"Sales Line",
  SalesLine."Document Type"::Order.AsInteger(),
  ItemJnlLine."Order No.",
  ItemJnlLine."Order Line No.",
  TempWhseJnlLine,
  NextLineNo);
    end;
    //TODO: besoin du var TempWhseJnlLine et le NextLineNo /////
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Return Receipt Line", 'OnAfterCopyItemJnlLineFromReturnRcpt', '', false, false)]
    // procedure OnAfterCopyItemJnlLineFromReturnRcpt(var ItemJournalLine: Record "Item Journal Line"; ReturnReceiptHeader: Record "Return Receipt Header"; ReturnReceiptLine: Record "Return Receipt Line"; var WhseUndoQty: Codeunit "Whse. Undo Quantity")
    //    var
    //         fctMgt: Codeunit "BC6_Functions Mgt";
    //     begin
    //                 fctMgt.InsertTempWhseJnlLine2(ItemJournalLine,
    //           DATABASE::"Return Receipt Header",
    //           0,
    //           "Document No.",
    //           0,
    //           TempWhseJnlLine."Reference Document"::"Posted Rtrn. Rcpt.",
    //           DATABASE::"Sales Line",
    //           SalesLine."Document Type"::"Return Order",
    //           ItemJournalLine."Return Order No.",
    //           ItemJournalLine."Return Order Line No.",
    //           TempWhseJnlLine,
    //           NextLineNo);

    //     end;

    //COD5817
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestPostedInvtPutAwayLine', '', false, false)]
    procedure COD5817_OnBeforeTestPostedInvtPutAwayLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean; UndoType: Integer; UndoID: Code[20])
    var
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        Text002: label 'You cannot undo line %1 because warehouse put-away lines have already been created.', Comment = 'FRA="Vous ne pouvez pas annuler la ligne %1 car des lignes rangement entrepôt ont déjà été créées."';
        Text008: label 'You cannot undo line %1 because warehouse receipt lines have already been posted.', Comment = 'FRA="Vous ne pouvez pas annuler la ligne %1 car des lignes réception entrepôt ont déjà été enregistrées."';
    begin
        IsHandled := true;
        if not ((SourceType = 39) and (SourceSubtype = 1)) and
           not ((SourceType = 37) and (SourceSubtype = 5)) then
            //la partie du TestPostedInvtPutAwayLine
            with RegisteredWhseActivityLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, -1, true);
                SetRange("Activity Type", "Activity Type"::"Put-away");
                if not IsEmpty() then
                    Error(Text002, UndoLineNo);
            end;
        //la partie du TestPostedInvtPutAwayLine

        if not ((SourceType = 39) and (SourceSubtype = 5)) and not ((SourceType = 37) and (SourceSubtype = 1)) then
            //la partie du TestWhseWorksheetLine
            with WhseWorksheetLine do begin
                SetSourceFilter(SourceType, SourceSubtype, SourceID, SourceRefNo, true);
                if not IsEmpty() then
                    Error(Text008, UndoLineNo);
            end;
        //la partie du TestWhseWorksheetLine
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Undo Posting Management", 'OnBeforeTestWhseWorksheetLine', '', false, false)]

    procedure COD5817_OnBeforeTestWhseWorksheetLine(UndoLineNo: Integer; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; var IsHandled: Boolean)
    begin
        //la partie du TestWhseWorksheetLine
        IsHandled := true;
    end;

    //COD6620
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert', '', false, false)]
    procedure COD6620_OnCopyFromSalesToPurchDocOnBeforePurchaseHeaderInsert(var ToPurchaseHeader: Record "Purchase Header"; FromSalesHeader: Record "Sales Header")
    var
        IsSAVReturnOrder: Boolean;
    begin
        if (FromSalesHeader."Document Type" = FromSalesHeader."Document Type"::"Return Order") then
            IsSAVReturnOrder := true;
        ToPurchaseHeader."BC6_Return Order Type" := FromSalesHeader."BC6_Return Order Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnTransfldsFromSalesToPurchLineOnBeforeValidateQuantity', '', false, false)]
    procedure COD6620_OnTransfldsFromSalesToPurchLineOnBeforeValidateQuantity(FromSalesLine: Record "Sales Line"; var ToPurchaseLine: Record "Purchase Line")
    var
        IsSAVReturnOrder: Boolean;
    begin
        ToPurchaseLine."BC6_Return Order Type" := FromSalesLine."BC6_Return Order Type";
        //TODO: je dois recuperer la valeur du IsSAVReturnOrder pour faire le test
        if IsSAVReturnOrder then begin
            ToPurchaseLine."BC6_Solution Code" := FromSalesLine."BC6_Solution Code";
            ToPurchaseLine."BC6_Return Comment" := FromSalesLine."BC6_Return Comment";
            ToPurchaseLine."BC6_Retrn. Sales OrderShpt" := FromSalesLine."BC6_ReturnOrderShpt SalesOrder";
            ToPurchaseLine."BC6_Series No." := FromSalesLine."BC6_Series No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeRecalculateAndApplySalesLine', '', false, false)]

    procedure COD6620_OnBeforeRecalculateAndApplySalesLine(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line"; Currency: Record Currency; var ExactCostRevMandatory: Boolean; var RecalculateAmount: Boolean; var CreateToHeader: Boolean; MoveNegLines: Boolean; var IsHandled: Boolean)
    var
        FunctionMgt: codeunit "BC6_Functions Mgt";
    begin
        IsHandled := true;
        if ExactCostRevMandatory and
   (FromSalesLine.Type = FromSalesLine.Type::Item) and
   (FromSalesLine."Appl.-from Item Entry" <> 0) and
   not MoveNegLines
then begin
            if RecalculateAmount then
                FunctionMgt.RecalculateSalesLineAmounts2(FromSalesLine, ToSalesLine, Currency);
            ToSalesLine.Validate("Appl.-from Item Entry", FromSalesLine."Appl.-from Item Entry");
            if not CreateToHeader then
                if ToSalesLine."Shipment Date" = 0D then
                    FunctionMgt.InitShipmentDateInLine2(ToSalesHeader, ToSalesLine);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesLineExtText', '', false, false)]

    procedure COD6620_OnBeforeCopySalesLineExtText(ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; FromSalesHeader: Record "Sales Header"; FromSalesLine: Record "Sales Line"; DocLineNo: Integer; var NextLineNo: Integer; var IsHandled: Boolean)
    var
        ToSalesLine2: Record "Sales Line";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
    begin
        IsHandled := true;
        if TransferExtendedText.SalesCheckIfAnyExtText(ToSalesLine, false) then begin
            TransferExtendedText.InsertSalesExtText(ToSalesLine);
            ToSalesLine2.SetRange("Document Type", ToSalesLine."Document Type");
            ToSalesLine2.SetRange("Document No.", ToSalesLine."Document No.");
            ToSalesLine2.FindLast();
            NextLineNo := ToSalesLine2."Line No.";
            exit;
        end;

        ToSalesLine."Attached to Line No." :=
          TransferOldExtLines.TransferExtendedText(DocLineNo, NextLineNo, FromSalesLine."Attached to Line No.");

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopyPurchLineExtText', '', false, false)]

    procedure COD6620_OnBeforeCopyPurchLineExtText(ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; FromPurchHeader: Record "Purchase Header"; FromPurchLine: Record "Purchase Line"; DocLineNo: Integer; var NextLineNo: Integer; var IsHandled: Boolean; RecalculateLines: Boolean; CopyExtText: Boolean)
    var
        ToPurchLine2: Record "Purchase Line";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(ToPurchLine, false) then begin
            TransferExtendedText.InsertPurchExtText(ToPurchLine);
            ToPurchLine2.SetRange("Document Type", ToPurchLine."Document Type");
            ToPurchLine2.SetRange("Document No.", ToPurchLine."Document No.");
            ToPurchLine2.FindLast();
            NextLineNo := ToPurchLine2."Line No.";
            exit;
        end;
        ToPurchLine."Attached to Line No." :=
          TransferOldExtLines.TransferExtendedText(DocLineNo, NextLineNo, FromPurchLine."Attached to Line No.");
    end;
    //TODO: A verifier 
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopySalesInvLinesToDocOnAfterCheckFirstLineShipped', '', false, false)]

    procedure COD6620_OnCopySalesInvLinesToDocOnAfterCheckFirstLineShipped(ToSalesHeader: Record "Sales Header"; OldDocType: Integer; ShptDocNo: Code[20]; var OldShptDocNo: Code[20])
    var
        FunctionMgt: codeunit "BC6_Functions Mgt";
        FromSalesInvLine: record "Sales Invoice Line";
        NextLineNo: Integer;
    begin
        FromSalesInvLine.get();
        NextLineNo := FunctionMgt.GetLastToSalesLineNo(ToSalesHeader);
        FunctionMgt.InsertOldOrders(FromSalesInvLine, ToSalesHeader, NextLineNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCheckFromSalesHeader', '', false, false)]

    procedure COD6620_OnBeforeCheckFromSalesHeader(SalesHeaderFrom: Record "Sales Header"; SalesHeaderTo: Record "Sales Header"; var IsHandled: Boolean)
    var
        BoolGCopyLinesExactly: Boolean;
        SalesDocType: enum "Sales Document Type";

    begin
        IsHandled := true;
        case SalesHeaderFrom."Document Type" of
            SalesDocType::Quote,
  SalesDocType::"Blanket Order",
  SalesDocType::Order,
  SalesDocType::Invoice,
  SalesDocType::"Return Order",
  SalesDocType::"Credit Memo":
                if not BoolGCopyLinesExactly then begin
                    SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                    SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                    SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                end else begin
                    SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                    SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
                    SalesHeaderFrom."Your Reference" := SalesHeaderTo."Your Reference";
                    SalesHeaderFrom."BC6_Affair No." := SalesHeaderTo."BC6_Affair No.";
                    // IF NOT SalesHeaderFrom.MODIFY THEN;      //TODO:then what ?
                end;
            else begin
                SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
                SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
                SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
                SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
                SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
            end;
        end;
    end;

    procedure COD6620_OnAfterCheckFromSalesHeader(SalesHeaderFrom: Record "Sales Header"; SalesHeaderTo: Record "Sales Header")
    var
        BoolGCopyLinesExactly: Boolean;
    begin
        if not BoolGCopyLinesExactly then begin
            SalesHeaderFrom.TESTFIELD("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
            SalesHeaderFrom.TESTFIELD("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
            SalesHeaderFrom.TESTFIELD("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
            SalesHeaderFrom.TESTFIELD("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
            SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
            SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
        end else begin
            SalesHeaderFrom.TESTFIELD("Currency Code", SalesHeaderTo."Currency Code");
            SalesHeaderFrom.TESTFIELD("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
            SalesHeaderFrom."Your Reference" := SalesHeaderTo."Your Reference";
            SalesHeaderFrom."BC6_Affair No." := SalesHeaderTo."BC6_Affair No.";

            //   IF NOT MODIFY THEN;     //TODO:then what ?
        end;
    end;
    //TODO  : a voir et a verifier 
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Price Calc. Mgt.", 'OnBeforeFindServLineDisc', '', false, false)]
    procedure OnBeforeFindServLineDisc(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var IsHandled: Boolean)
    var
        SalesPriceCalMgt: codeunit "Sales Price Calc. Mgt.";
        TempSalesLineDisc: Record "Sales Line Discount" temporary;
        Item: record Item;
        Currency: Record Currency;

    begin
        IsHandled := true;
        with ServiceLine do begin
            SalesPriceCalMgt.SetCurrency(ServiceHeader."Currency Code", 0, 0D);
            SalesPriceCalMgt.SetUoM(Abs(Quantity), "Qty. per Unit of Measure");

            TestField("Qty. per Unit of Measure");

            if Type = Type::Item then begin
                Item.Get("No.");
                SalesPriceCalMgt.FindSalesLineDisc(
                  TempSalesLineDisc, "Bill-to Customer No.", ServiceHeader."Contact No.",
                  "Customer Disc. Group", '', "No.", Item."Item Disc. Group", "Variant Code",
                  "Unit of Measure Code", ServiceHeader."Currency Code", ServiceHeader."Order Date", false);
                SalesPriceCalMgt.CalcBestLineDisc(TempSalesLineDisc);
                "Line Discount %" := TempSalesLineDisc."Line Discount %";
            end;
            if Type in [Type::Resource, Type::Cost, Type::"G/L Account"] then begin
                "Line Discount %" := 0;
                "Line Discount Amount" :=
                  Round(
                    Round(CalcChargeableQty * "Unit Price", Currency."Amount Rounding Precision") *
                    "Line Discount %" / 100, Currency."Amount Rounding Precision");
                "Inv. Discount Amount" := 0;
                "Inv. Disc. Amount to Invoice" := 0;
            end;
        end;

    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLineDisc', '', false, false)]

    procedure OnAfterFindSalesLineDisc(var ToSalesLineDisc: Record "Sales Line Discount"; CustNo: Code[20]; ContNo: Code[20]; CustDiscGrCode: Code[20]; CampaignNo: Code[20]; ItemNo: Code[20]; ItemDiscGrCode: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean)

    var
        FromSalesLineDisc: Record "Sales Line Discount";
        SalesPriceCalMgt: codeunit "Sales Price Calc. Mgt.";
        TempCampaignTargetGr: Record "Campaign Target Group" temporary;
        InclCampaigns: Boolean;
    begin
        with FromSalesLineDisc do begin
            for "Sales Type" := "Sales Type"::Customer to "Sales Type"::Campaign do begin
                if ("Sales Type" = "Sales Type"::"All Customers") or
                   (("Sales Type" = "Sales Type"::Customer) and (CustNo <> '')) or
                   (("Sales Type" = "Sales Type"::"Customer Disc. Group") and (CustDiscGrCode <> '')) or
                   (("Sales Type" = "Sales Type"::Campaign) and
                    not ((CustNo = '') and (ContNo = '') and (CampaignNo = '')))
                then begin
                    case "Sales Type" of
                        "Sales Type"::Campaign:
                            InclCampaigns := SalesPriceCalMgt.ActivatedCampaignExists(TempCampaignTargetGr, CustNo, ContNo, CampaignNo);
                    end;
                    repeat
                        IF VendorNo <> '' THEN BEGIN
                            SETRANGE(Type, Type::Vendor);
                            SETRANGE(Code, VendorNo);
                          CopySalesDiscToSalesDisc(FromSalesLineDisc, ToSalesLineDisc);
                        END;

                    until not InclCampaigns;
                end;
            end;
        end;
    end;



    /////////////////////

    //TAB113
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnBeforeCalcVATAmountLines', '', false, false)]

    local procedure TAB13_OnBeforeCalcVATAmountLines(SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin
        TempVATAmountLine."BC6_DEEE HT Amount" := TempVATAmountLine."BC6_DEEE HT Amount" + SalesInvLine."BC6_DEEE HT Amount";
        TempVATAmountLine."BC6_DEEE VAT Amount" := TempVATAmountLine."BC6_DEEE VAT Amount" + SalesInvLine."BC6_DEEE VAT Amount";
        TempVATAmountLine."BC6_DEEE TTC Amount" := TempVATAmountLine."BC6_DEEE TTC Amount" + SalesInvLine."BC6_DEEE TTC Amount";
        if SalesInvLine."Allow Invoice Disc." then
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
        CalChange: Record "Customized Calendar Change";
        CustomCalendarChange: array[2] of Record "Customized Calendar Change";
        PurchHeader: Record "Purchase Header";
        RecLSalesLine: Record "Sales Line";
    begin
        PurchHeader.get(PurchHeader."Document Type", PurchHeader."No.");
        CalChange.get(CalChange."Source Type", CalChange."Source Code", CalChange."Additional Source Code", CalChange."Base Calendar Code", CalChange."Recurring System", CalChange.Date, CalChange.Day, CalChange."Entry No.");
        if Rec."Expected Receipt Date" <> 0D then begin
            CustomCalendarChange[1].SetSource(CalChange."Source Type"::Location, Rec."Location Code", '', '');
        end else
            Rec.Validate(Rec."Planned Receipt Date", Rec."Expected Receipt Date");
        if Rec."Expected Receipt Date" <> 0D then begin
            RecLSalesLine.RESET();
            RecLSalesLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            RecLSalesLine.SETRANGE("BC6_Purch. Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("BC6_Purch. Order No.", Rec."Document No.");
            RecLSalesLine.SETRANGE("BC6_Purch. Line No.", Rec."Line No.");
            if RecLSalesLine.FIND('-') then begin
                repeat
                    RecLSalesLine.VALIDATE("BC6_Purchase Receipt Date", Rec."Expected Receipt Date");
                    RecLSalesLine."BC6_Prom. Purch. Receipt Date" := (PurchHeader."Expected Receipt Date" <> 0D);
                    RecLSalesLine.MODIFY();
                until RecLSalesLine.NEXT() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateDirectUnitCost', '', false, false)]
    local procedure T39_OnAfterUpdateDirectUnitCost(var PurchLine: Record "Purchase Line"; xPurchLine: Record "Purchase Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    var
        Currency: Record Currency;
        RecGVendor: Record Vendor;

    begin
        PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", 0);
        PurchLine."BC6_DEEE VAT Amount" := 0;
        PurchLine."BC6_DEEE TTC Amount" := 0;
        PurchLine."BC6_DEEE Amount (LCY) for Stat" := 0;
        RecGVendor.GET(PurchLine."Buy-from Vendor No.");
        if RecGVendor."BC6_Posting DEEE" then begin
            PurchLine.VALIDATE(PurchLine."BC6_DEEE HT Amount", PurchLine."BC6_DEEE Unit Price" * PurchLine."Quantity (Base)");
            Currency.get(Currency.Code);
            PurchLine."BC6_DEEE VAT Amount" := ROUND(PurchLine."BC6_DEEE HT Amount" * PurchLine."VAT %" / 100, Currency."Amount Rounding Precision");
            PurchLine."BC6_DEEE TTC Amount" := PurchLine."BC6_DEEE HT Amount" + PurchLine."BC6_DEEE VAT Amount";
            PurchLine."BC6_DEEE Amount (LCY) for Stat" := PurchLine."Quantity (Base)" * PurchLine."BC6_DEEE Unit Price (LCY)";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    procedure T39_OnAfterValidateEvent_UnitPost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        RecGPurchPrice: record "Purchase Price";
        RecGPurchsetup: Record "Purchases & Payables Setup";
        Tectg003: label 'ENU="Do you want to create a Purchase Price ?"', comment = '"FRA=Voulez-vous creer un prix d''achat négocier ?"';

    begin
        if (xRec."Direct Unit Cost" <> Rec."Direct Unit Cost") and (xRec."Direct Unit Cost" <> 0) then begin
            RecGPurchsetup.GET();
            if RecGPurchsetup."BC6_Ask custom purch price" then begin

                if CONFIRM(Tectg003, false) then begin
                    RecGPurchPrice.RESET();
                    RecGPurchPrice.SETFILTER("Vendor No.", Rec."Buy-from Vendor No.");
                    RecGPurchPrice.SETFILTER("Item No.", Rec."No.");
                    RecGPurchPrice.SETFILTER("Starting Date", '%1', WORKDATE());
                    if not RecGPurchPrice.FIND('-') then begin
                        RecGPurchPrice.INIT();
                        RecGPurchPrice.VALIDATE("Item No.", Rec."No.");
                        RecGPurchPrice.VALIDATE("Vendor No.", Rec."Buy-from Vendor No.");
                        RecGPurchPrice.VALIDATE("Starting Date", WORKDATE());
                        RecGPurchPrice.VALIDATE("Direct Unit Cost", Rec."Direct Unit Cost");
                        RecGPurchPrice.INSERT(true);
                    end;
                    RecGPurchPrice.SETFILTER("Starting Date", '');
                    PAGE.RUN(Page::"Purchase Prices", RecGPurchPrice);
                end;
            end;
        end;
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
        RecLAffairStep.DELETEALL();
    end;
    //TAB18
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Salesperson Code', false, false)]
    procedure T18_OnAfterValidateEvent_SalespersCode(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        RecLSalespersonAuthorized: Record "BC6_Salesperson authorized";
    begin
        if Rec."Salesperson Code" <> xRec."Salesperson Code" then begin
            RecLSalespersonAuthorized.SETRANGE("Customer No.", Rec."No.");
            if RecLSalespersonAuthorized.FINDFIRST() then begin
                RecLSalespersonAuthorized.MODIFYALL(authorized, false);
                RecLSalespersonAuthorized.SETRANGE("Salesperson code", Rec."Salesperson Code");
                if RecLSalespersonAuthorized.FINDFIRST() then begin
                    RecLSalespersonAuthorized.authorized := true;
                    RecLSalespersonAuthorized.MODIFY();
                end;
            end;
            Rec.VALIDATE("BC6_Salesperson Filter", Rec."Salesperson Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Combine Shipments', false, false)]
    procedure T18_OnAfterValidateEvent_CombineShip(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        if Rec."Combine Shipments" = false then
            Rec."BC6_Combine Shipments by Order" := false;
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
        NaviSetup.GET();
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
        if Location."Require Put-away" and not (Location."Require Receive") then
            Rec."Bin Code" := Location."Receipt Bin Code"
        else
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
        PurchaseLineDiscount.DELETEALL(true);
    end;
    //TAB 10866
    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterSetUpNewLine', '', false, false)]

    local procedure T10866_OnAfterSetUpNewLine(var PaymentLine: Record "Payment Line")
    var
        PaymentClass: Record "Payment Class";
        NoSeriesMgt: codeunit NoSeriesManagement;
        BottomLine: Boolean;
    begin
        if PaymentLine."No." <> '' then begin
            if PaymentClass."Line No. Series" = '' then
                exit
            else
                if PaymentLine."Document No." = '' then
                    if BottomLine and (PaymentLine."Line No." <> PaymentLine."Line No.") then
                        PaymentLine."Document No." := INCSTR(PaymentLine."Document No.")
                    else
                        if PaymentLine."Document No." = '' then
                            PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", PaymentLine."Posting Date", false)
                        else
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
        CstL001: label 'Vous n''êtes pas autorisé à modifier les quantités à traiter', Comment = 'FRA="Vous n''êtes pas autorisé à modifier les quantités à traiter"';
        CstL002: label 'Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée.', Comment = 'FRA="Vous n''êtes pas autorisé à modifier la quantité à traiter, elle est supérieure à la quantité prélevée."';
        Text002: label 'You cannot handle more than the outstanding %1 units.', Comment = 'FRA="Vous ne pouvez pas traiter plus que les %1 unités restantes."';
    begin
        if WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."Qty. Outstanding" then
            Error(Text002, WarehouseActivityLine."Qty. Outstanding");
        if RecLUserSetup.GET(USERID) then begin
            if not RecLUserSetup."BC6_Auth.Qty.to Handle Change" then
                ERROR(CstL001);
            if RecLUserSetup."BC6_Aut.Qty.toHan.TestPickQty" then
                if WarehouseActivityLine."Qty. to Handle" > WarehouseActivityLine."BC6_Qty. Picked" then
                    ERROR(CstL002);
        end else
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
        if Rec.BC6_Type <> Rec.BC6_Type::"All items" then
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
        if Rec.BC6_Type <> Rec.BC6_Type::"All items" then
            Rec.TESTFIELD("Item No.");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bin Content", 'OnBeforeCalcQtyAvailToTake', '', false, false)]
    local procedure T7302_OnBeforeCalcQtyAvailToTake_BinContent(var BinContent: Record "Bin Content"; ExcludeQtyBase: Decimal; var QtyAvailToTake: Decimal; var IsHandled: Boolean)
    var
        Bin: Record Bin;
        FctMangt: Codeunit "BC6_Functions Mgt";
    begin
        FctMangt.GetBin(BinContent."Location Code", BinContent."Bin Code", Bin);
        if Bin."BC6_Exclude Inventory Pick" then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeSendEmailDirectly', '', false, false)]
    local procedure T77_OnBeforeSendEmailDirectly_ReportSelections(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        FctMangt: Codeunit "BC6_Functions Mgt";
    begin
        case ReportUsage of
            ReportUsage::"S.Order", ReportUsage::"S.Quote":
                begin
                    SalesHeader := RecordVariant;
                    FctMangt.SetYourReference(SalesHeader."Your Reference");
                end;
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
        if ((SalesLine."Document Type" in [SalesLine."Document Type"::Invoice]) and (SalesLine.Quantity >= 0)) or
                                                                     ((SalesLine."Document Type" in [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"]) and (SalesLine.Quantity < 0))
                                                                  then
            WMSManagement.FindBinContent(SalesLine."Location Code", SalesLine."Bin Code", SalesLine."No.", SalesLine."Variant Code", '')
        else
            WMSManagement.FindBin(SalesLine."Location Code", SalesLine."Bin Code", '');

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateLineDiscountPercent', '', false, false)]
    local procedure T37_OnAfterValidateLineDiscountPercent_SalesLine(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    var
        L_Item: Record Item;
        L_UserSetup: Record "User Setup";
        L_Vendor: Record Vendor;
        L_IncrProfit: Decimal;
        L_IncrPurchCost: Decimal;
        UpdateProfitErr: label '%1 cannot be less than %2 in %3 %4', Comment = 'FRA="%1 ne peut pas être inférieur à %2 dans %3 %4"';
    begin
        SalesLine.CalcDiscountUnitPrice();
        if ((SalesLine."Document Type" = SalesLine."Document Type"::Quote) or (SalesLine."Document Type" = SalesLine."Document Type"::Order)) and
           not SalesLine.GetSkipPurchCostVerif() then begin
            if L_UserSetup.GET(USERID) and L_UserSetup."BC6_Activ. Mini Margin Control" then begin
                if SalesLine.Type = SalesLine.Type::Item then begin
                    L_Item.GET(SalesLine."No.");
                    if L_Vendor.GET(L_Item."Vendor No.") and (L_Vendor."BC6_% Mini Margin" <> 0) then begin
                        SalesLine.CalcIncreasePurchCost(L_IncrPurchCost);
                        SalesLine.CalcIncreaseProfit(L_IncrProfit, L_IncrPurchCost);
                        if L_IncrProfit < L_Vendor."BC6_% Mini Margin" then
                            ERROR(UpdateProfitErr, SalesLine.FIELDCAPTION(SalesLine."Profit %"), L_Vendor.FIELDCAPTION("BC6_% Mini Margin"), L_Vendor.TABLECAPTION, L_Vendor."No.");
                    end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Profit %', false, false)]
    local procedure T37_OnAfterValidateEvent_SalesLine_Profit(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        Rec.CalcDiscount();
        Rec.CalcDiscountUnitPrice();
        Rec.VALIDATE(Rec."Line Discount %");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQtyToShipAfterInitQty', '', false, false)]
    local procedure T37_OnValidateQtyToShipAfterInitQty_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        Text007: label 'You cannot ship more than %1 units.';
        Text008: label 'You cannot ship more than %1 base units.';
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
        SalesLine."BC6_Cust. Sales Profit Group" := SalesHeader."BC6_Cust. Sales Profit Group";

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
        RecLSalesReceivablesSetup.GET();
        if not RecLSalesReceivablesSetup."BC6_Active Quantity Management" then
            SalesLine.UpdateUnitPrice(SalesLine.FIELDNO(Quantity))
        else
            SalesLine.VALIDATE("Unit Price", SalesLine."Unit Price");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T37_OnAfterValidateEvent_SalesLine(var Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        Currency: Record Currency;
        RecGCustomer: Record Customer;
    begin
        Rec.VALIDATE("BC6_DEEE HT Amount", 0);
        Rec."BC6_DEEE VAT Amount" := 0;
        Rec."BC6_DEEE TTC Amount" := 0;
        Rec."BC6_DEEE Amount (LCY) for Stat" := 0;

        RecGCustomer.GET(Rec."Sell-to Customer No.");
        if RecGCustomer."BC6_Submitted to DEEE" then begin
            Rec.VALIDATE("BC6_DEEE HT Amount", Rec."BC6_DEEE Unit Price" * Rec."Quantity (Base)");
            Rec."BC6_DEEE VAT Amount" := ROUND(Rec."BC6_DEEE HT Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
            Rec."BC6_DEEE TTC Amount" := Rec."BC6_DEEE HT Amount" + Rec."BC6_DEEE VAT Amount";
            Rec."BC6_DEEE Amount (LCY) for Stat" := Rec."Quantity (Base)" * Rec."BC6_DEEE Unit Price (LCY)";
        end;
        Rec."BC6_Qty. To Order" := Rec.Quantity;

        Rec.SetSkipPurchCostVerif(false);
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', false, false)]
    local procedure T37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine.CalcProfit();
        SalesLine.CalcDiscountUnitPrice();
        SalesLine.FctGCalcLineDiscount();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterTestStatusOpen', '', false, false)]
    local procedure T37_OnAfterTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        RecLPurchLine: Record "Purchase Line";
        textg002: label 'You will lost link between Sales document No %1 line %2 \ and purchase document of type %3, No %4 ,  line %5 \ Are you sure?';
    begin
        if (SalesLine."BC6_Purch. Order No." <> '') or (SalesLine."BC6_Purch. Line No." <> 0) then
            if not CONFIRM(textg002, false, SalesLine."Document No.", SalesLine."Line No.", SalesLine."BC6_Purch. Document Type", SalesLine."BC6_Purch. Order No.", SalesLine."BC6_Purch. Line No.") then
                ERROR('')
            else begin
                RecLPurchLine.RESET();
                RecLPurchLine.SETFILTER("BC6_Sales Document Type", '%1', SalesHeader."Document Type");
                RecLPurchLine.SETFILTER("BC6_Sales Line No.", '%1', SalesLine."Line No.");
                RecLPurchLine.SETFILTER("BC6_Sales No.", SalesLine."Document No.");
                if RecLPurchLine.FIND('-') then
                    repeat
                        RecLPurchLine."BC6_Sales No." := '';
                        RecLPurchLine."BC6_Sales Line No." := 0;
                        SalesLine."BC6_Purch. Order No." := '';
                        SalesLine."BC6_Purch. Line No." := 0;
                        RecLPurchLine.MODIFY(true);
                    until RecLPurchLine.NEXT() = 0;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure T37_OnBeforeTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)
    begin
        SalesLine.TestStatusLocked();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T37_OnAfterInsertEvent_SalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        RecLItem: Record Item;
        "---DEEE1.00---": Integer;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if ((Rec.Type = Rec.Type::Item) and (RecLItem.GET(Rec."No."))) then
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");

        Rec.UpdateReturnOrderTypeFromSalesHeader();
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
        RecLItem: Record Item;
        "---DEEE1.00---": Integer;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if ((Rec.Type = Rec.Type::Item) and (RecLItem.GET(Rec."No."))) then
            Rec.VALIDATE(Rec."BC6_DEEE Category Code", RecLItem."BC6_DEEE Category Code");
        Rec.UpdateReturnOrderTypeFromSalesHeader();
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T39_OnAfterModifyEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.CalcDiscountDirectUnitCost();
        ;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure T39_OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
            PurchaseLine.LOCKTABLE();
            SalesOrderLine.LOCKTABLE();
            SalesOrderLine.RESET();
            SalesOrderLine.SETCURRENTKEY("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Document Type", PurchaseLine."Document Type");
            SalesOrderLine.SETRANGE("BC6_Purch. Order No.", PurchaseLine."Document No.");
            SalesOrderLine.SETRANGE("BC6_Purch. Line No.", PurchaseLine."Line No.");
            if SalesOrderLine.FIND('-') then
                repeat
                    SalesOrderLine."BC6_Purch. Document Type" := 0;
                    SalesOrderLine."BC6_Purch. Order No." := '';
                    SalesOrderLine."BC6_Purch. Line No." := 0;
                    SalesOrderLine.MODIFY();
                until SalesOrderLine.NEXT() = 0;
        end;

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
        Rec."BC6_Qty.(Phys. Inv.)" := false;
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
                begin
                    Customer.GET(Rec."Destination No.");
                    case Customer.Blocked of
                        1, 3:
                            Customer.TESTFIELD(Blocked, 0);
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnAfterValidateEvent', 'Sales Code', false, false)]
    local procedure T7002_OnAfterValidateEvent(var Rec: Record "Sales Price"; var xRec: Record "Sales Price")
    var
        Campaign: Record Campaign;
        Cust: Record Customer;
        CustPriceGr: Record "Customer Price Group";
        RecGSalesSetup: Record "Sales & Receivables Setup";
        "-FE25-26.001:SEBC-": Integer;
        Text001: label '%1 must be blank.', Comment = 'FRA="%1 doit être blanc."';
    begin
        RecGSalesSetup.GET();
        if Rec."Sales Code" <> '' then
            case Rec."Sales Type" of
                Rec."Sales Type"::"All Customers":
                    Error(Text001, Rec.FieldCaption(Rec."Sales Code"));
                Rec."Sales Type"::"Customer Price Group":
                    begin
                        CustPriceGr.Get(Rec."Sales Code");
                        Rec."Price Includes VAT" := CustPriceGr."Price Includes VAT";
                        Rec."VAT Bus. Posting Gr. (Price)" := CustPriceGr."VAT Bus. Posting Gr. (Price)";
                        if RecGSalesSetup."BC6_Upd. Price AllowLine disc." then
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
                        if RecGSalesSetup."BC6_Upd. Price AllowLine disc." then
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
        FctMngt: Codeunit "BC6_Functions Mgt";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        FctMngt.FindVeryBestCost(PurchaseLine, PurchHeader);
    end;
    //COD12
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCalcPmtDiscPossible', '', false, false)]

    local procedure COD12_OnBeforeCalcPmtDiscPossible(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var IsHandled: Boolean; RoundingPrecision: Decimal)
    var
        GLSetup: Record "General Ledger Setup";
        FctMngt: Codeunit "BC6_Functions Mgt";
        PaymentDiscountDateWithGracePeriod: Date;

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
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        IsHandled := true;
        with ItemJournalLine do
            if (("Entry Type" <> "Entry Type"::Transfer) or ("Order Type" <> "Order Type"::Transfer)) and
               not Adjustment
            then begin
                FctMngt.CheckInTransitLocation("Location Code");
                Location.TESTFIELD("BC6_Blocked", false);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckPhysInventory', '', false, false)]

    local procedure COD21_OnBeforeCheckPhysInventory(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        Text005: label 'must be %1 or %2 when %3 is %4';
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
            if ("Entry Type" in
              ["Entry Type"::"Positive Adjmt.",
               "Entry Type"::"Negative Adjmt."]) then
                if ItemJournalBatch.GET("Journal Template Name", ItemJnlLine."Journal Batch Name") then
                    ItemJournalBatch.TESTFIELD("BC6_Phys. Inv. Survey", false);
        end;
    end;

    //COD22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure COD22_OnBeforeInsertItemLedgEntry_ItemJnlPostLine(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        RecLDEEEEntry: Record "BC6_DEEE Ledger Entry";
    begin
        if (ItemJournalLine."BC6_DEEE Category Code" <> '') then begin
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
            RecLDEEEEntry.INSERT();
        end;
    end;

    //COD23
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeOpenProgressDialog', '', false, false)]
    local procedure COD23_OnBeforeOpenProgressDialog(var ItemJnlLine: Record "Item Journal Line"; var Window: Dialog; var WindowIsOpen: Boolean; var IsHandled: Boolean)
    var
        InvtSetup: Record "Inventory Setup";  //NOT SUREE
        ItemJnlTemplate: Record "Item Journal Template";
        Text001: label 'Journal Batch Name    #1##########\\';
        Text002: label 'Checking lines        #2######\';
        Text003: label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        Text004: label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text101: label 'ENU=Jnl. Batch #1###\\';
        Text102: label 'ENU=Chec. lines #2###\';
        Text105: label 'ENU=Post. #3### @4@;FRA=Valid.#3### @4@@@';
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
            if (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 1") or
               (ItemJnlTemplate.Name = InvtSetup."BC6_Item Jnl Template Name 2") then
                Window.OPEN(
                  Text101 +
                  Text102 +
                  Text105)
            else
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
        InvtSetup.GET(); //To check this event(InvtSetup is declared as a global variable)
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
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        if SalesHeader.Invoice then begin
            if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
                FctMngt.xUpdateShipmentInvoiced(SalesInvoiceHeader);
            end;
        end;
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
        if not SalesHeader.IsCreditDocType() then begin
            TotalSalesLineLCY."Unit Cost (LCY)" := -TotalSalesLineLCY."Unit Cost (LCY)";
            TotalSalesLineLCY."BC6_Purchase cost" := -TotalSalesLineLCY."BC6_Purchase cost";
        end;
    end; //TO CHECK which is more coherent

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCalcItemJnlAmountsFromQtyToBeShipped', '', false, false)]
    local procedure COD80_OnBeforeCalcItemJnlAmountsFromQtyToBeShipped(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; QtyToBeShipped: Decimal; var IsHandled: Boolean)
    begin
        SalesLine."BC6_DEEE Category Code" := SalesLine."BC6_DEEE Category Code";

        if SalesLine."Qty. to Ship" <> 0 then
            SalesLine."BC6_DEEE HT Amount" :=
              ROUND(
                SalesLine."BC6_DEEE HT Amount" *
                (QtyToBeShipped / SalesLine."Qty. to Ship"));

        if SalesLine."Qty. to Ship" <> 0 then
            SalesLine."BC6_DEEE TTC Amount" :=
              ROUND(
              SalesLine."BC6_DEEE TTC Amount" *
              (QtyToBeShipped / SalesLine."Qty. to Ship"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateWhseDocuments', '', false, false)]
    local procedure COD80_OnAfterUpdateWhseDocuments(SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; EverythingInvoiced: Boolean)
    var
        RecGParmNavi: Record "BC6_Navi+ Setup";
        SalesInvHeader: Record "sales invoice header";
        RecGArchiveManagement: Codeunit ArchiveManagement;
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        SalesInvHeader.get();
        if RecGParmNavi.GET() then
            if RecGParmNavi."Filing Sales Orders" then
                RecGArchiveManagement.StoreSalesDocument(SalesHeader, false);
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
        L_Item: Record Item;
        FctMngt: Codeunit "BC6_Functions Mgt";
        EnableIncrPurchCost: Boolean; //(variable globale que je la déclaré locale, car elle est utilisée slmnt dans cette partie)
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
        FctMngt: Codeunit "BC6_Functions Mgt";

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
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then
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
        if RecLNaviSetup."Date jour en factur/livraison" then
            AssmPost.SetPostingDate(true, WORKDATE());
    end;
    //COD82
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure COD82_OnBeforeConfirmPostProcedure(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLNaviSetup: Record "BC6_Navi+ Setup";
        AsmPost: Codeunit "Assembly-Post";
        FctMngt: Codeunit "BC6_Functions Mgt";
        ConfirmManagement: Codeunit "Confirm Management";
        SalesPostPrint: Codeunit "Sales-Post + Print";
        Selection: Integer;
        ReceiveInvoiceQst: label '&Receive,&Invoice,Receive &and Invoice';
        ShipInvoiceQst: label '&Ship,&Invoice,Ship &and Invoice';
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
                        if Ship then FctMngt.CalcProfit2(SalesHeader);
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(SalesPostPrint.ConfirmationMessage(), "Document Type"), true)
                    then
                        exit;
            end;
            "Print Posted Documents" := true;
            //>>MIGRATION NAV 2013
            //>> NavEasy Correction FRGO 14/03/2007
            if RecLNaviSetup.GET() then begin
                if RecLNaviSetup."Date jour en factur/livraison" then
                    AsmPost.SetPostingDate(true, WORKDATE());
            end;
            //<<NavEasy Correction FRGO 14/03/2007
            //<<MIGRATION NAV 2013
        end;
    end;
    //COD83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeConfirmConvertToOrder', '', false, false)]
    local procedure COD83_OnBeforeConfirmConvertToOrder(SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLItem: Record Item;
        RecLSalesLine: Record "Sales Line";

    begin
        SalesHeader.TESTFIELD("Shipment Method Code", '');
        // on vient v‚rifier si dans le devis les articles ne sont pas bloqu‚s.
        RecLSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        RecLSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        RecLSalesLine.SETRANGE(Type, RecLSalesLine.Type::Item);
        RecLSalesLine.SETFILTER("No.", '<>%1', '');
        if RecLSalesLine.FINDFIRST() then
            repeat
                RecLItem.GET(RecLSalesLine."No.");
                RecLItem.TESTFIELD(Blocked, false);
            until RecLSalesLine.NEXT() = 0;
    end;

    //COD 86
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure COD86_OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        FctMngt: Codeunit "BC6_Functions Mgt";
    begin
        FctMngt.UpdatePurchasedoc(SalesQuoteLine, SalesQuoteLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeTransferQuoteLineToOrderLineLoop', '', false, false)]
    local procedure COD86_OnBeforeTransferQuoteLineToOrderLineLoop(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Location: record location;
    begin
        Location.get(Location.code);
        if not IsHandled then begin
            IF (SalesQuoteLine.Type = SalesQuoteLine.Type::Item) AND (SalesQuoteLine."No." <> '') THEN
                SalesQuoteLine.TESTFIELD("Purchasing Code");
            CLEAR(Location);
            IF (SalesQuoteLine."Location Code" <> '') THEN BEGIN
                Location.GET(SalesQuoteLine."Location Code");
                //TODO Location.TESTFIELD(Blocked, FALSE); //blocked is a global var ! 
                IF Location."Bin Mandatory" THEN
                    SalesQuoteLine.TESTFIELD("Bin Code");
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeTransferQuoteLineToOrderLineLoop', '', false, false)]
    local procedure COD86_OnAfterInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        if SalesOrderHeader."Posting Date" <> 0D then
            SalesOrderHeader."BC6_Bin Code" := SalesOrderHeader."BC6_Bin Code";
        SalesOrderHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]

    local procedure COD86_OnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesQuoteLine: Record "Sales Line")
    var
        RecGParmNavi: Record "BC6_Navi+ Setup";
        SalesCommentLine: Record "Sales Comment Line";

        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecGArchiveManagement: Codeunit ArchiveManagement;

    begin

        if not IsHandled then begin
            ApprovalsMgmt.DeleteApprovalEntries(QuoteSalesHeader.RecordId);
            SalesCommentLine.DeleteComments(QuoteSalesHeader."Document Type".AsInteger(), QuoteSalesHeader."No.");
            //>>MIGRATION NAV 2013
            IF RecGParmNavi.GET THEN
                IF RecGParmNavi."Filing Sales Quotes" THEN BEGIN
                    QuoteSalesHeader."BC6_Cause filing" := QuoteSalesHeader."BC6_Cause filing"::"Change in Order";
                    QuoteSalesHeader.MODIFY;
                    RecGArchiveManagement.StoreSalesDocument(QuoteSalesHeader, FALSE);
                END;
            //<<MIGRATION NAV 2013
            QuoteSalesHeader.DeleteLinks;
            QuoteSalesHeader.Delete;
            SalesQuoteLine.DeleteAll();
        end;
    end;


    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure P344_OnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    var
        GRecEntry: Record "BC6_DEEE Ledger Entry";
        Navigate: Page Navigate;
    begin
        if GRecEntry.READPERMISSION then begin
            GRecEntry.RESET;
            GRecEntry.SETCURRENTKEY("Document No.", "Posting Date");
            GRecEntry.SETFILTER("Document No.", DocNoFilter);
            GRecEntry.SETFILTER("Posting Date", PostingDateFilter);
            Navigate.InsertIntoDocEntry(DocumentEntry, DATABASE::"BC6_DEEE Ledger Entry", 0, GRecEntry.TABLECAPTION, GRecEntry.COUNT);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure P344_OnAfterNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        GRecEntry: Record "BC6_DEEE Ledger Entry";
    begin
        GRecEntry.RESET;
        GRecEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GRecEntry.SETFILTER("Document No.", DocNoFilter);
        GRecEntry.SETFILTER("Posting Date", PostingDateFilter);
        if TableID = DATABASE::"BC6_DEEE Ledger Entry" then
            PAGE.RUN(0, GRecEntry);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Invoice Statistics", 'OnCalculateTotalsOnAfterAddLineTotals', '', false, false)]
    local procedure P400_OnCalculateTotalsOnAfterAddLineTotals(var PurchInvLine: Record "Purch. Inv. Line"; var VendAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var VATPercentage: Decimal; PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchInvStat: Page "Purchase Invoice Statistics";
    begin
        PurchInvStat.IncrementDecGMntHTDEEE(PurchInvLine."BC6_DEEE HT Amount");
        PurchInvStat.IncrementDecGMntTTCDEEE(PurchInvLine."BC6_DEEE TTC Amount");
        AmountInclVAT := AmountInclVAT + PurchInvLine."BC6_DEEE TTC Amount";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purch. Credit Memo Statistics", 'OnCalculateTotalsOnAfterAddLineTotals', '', false, false)]
    local procedure P401_OnCalculateTotalsOnAfterAddLineTotals(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var VendAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var VATPercentage: Decimal; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        PurchCreditMemoStat: Page "Purch. Credit Memo Statistics";
    begin
        PurchCreditMemoStat.Increment_MntHTDEEE(PurchCrMemoLine."BC6_DEEE HT Amount");
        AmountInclVAT := AmountInclVAT + PurchCrMemoLine."BC6_DEEE TTC Amount";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Return Order Subform", 'OnBeforeUpdateTypeText', '', false, false)]
    local procedure P6641_OnBeforeUpdateTypeText(var PurchaseLine: Record "Purchase Line")
    var
        PurchHeader: Record "Purchase Header";
        PurRetOrdSubf: Page "Purchase Return Order Subform";
    begin
        PurchHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        PurRetOrdSubf.SetBooGSAVVisible(PurchHeader."BC6_Return Order Type" = PurchHeader."BC6_Return Order Type"::SAV);
    end;


    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order List", 'OnAfterActionEvent', '&Print', false, false)]
    local procedure P9304_OnAfterActionEvent_Print(var Rec: Record "Sales Header")
    var
        SalesHeader: Record "Sales Header";
        DocPrint: Codeunit "Document-Print";
    begin
        if Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::Location then
            DocPrint.PrintSalesHeader(Rec)
        else begin
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Document Type", Rec."Document Type");
            SalesHeader.SETRANGE("No.", Rec."No.");
            // REPORT.RUNMODAL(50060, TRUE, FALSE, SalesHeader); TODO: missing report
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order List", 'OnBeforeActionEvent', 'Print Confirmation', false, false)]
    local procedure P9304_OnBeforeActionEvent_PrintConfirmation(var Rec: Record "Sales Header")
    var
        SalesOrderList: Page "Sales Order List";
    begin
        SalesOrderList.CheckIfReleased();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure P46_OnAfterValidateEvent_No()
    var
        SalOrdSub: Page "Sales Order Subform";
    begin
        SalOrdSub.UpdateIncreasedFields();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice Statistics", 'OnBeforeCalculateTotals', '', false, false)]
    local procedure OnBeforeCalculateTotals(SalesInvoiceHeader: Record "Sales Invoice Header"; var CustAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var CostLCY: Decimal; var TotalAdjCostLCY: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var IsHandled: Boolean; var VATPercentage: Decimal)
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvStat: Page "Sales Invoice Statistics";
        CostCalcMgt: Codeunit "Cost Calculation Management";
    begin
        SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesInvLine.Find('-') then
            repeat
                CustAmount += SalesInvLine.Amount;
                AmountInclVAT += SalesInvLine."Amount Including VAT";
                //<<DEEE1.00 : Update DEEE amount (F9 without clic)
                SalesInvStat.IncrementDecGMntTTCDEEE(SalesInvLine."BC6_DEEE TTC Amount");
                SalesInvStat.IncrementDecGMntHTDEEE(SalesInvLine."BC6_DEEE HT Amount");
                AmountInclVAT := AmountInclVAT + SalesInvLine."BC6_DEEE TTC Amount";
                //>>DEEE1.00 : Update DEEE amount (F9 without clic)
                if SalesInvoiceHeader."Prices Including VAT" then
                    InvDiscAmount += SalesInvLine."Inv. Discount Amount" / (1 + SalesInvLine."VAT %" / 100)
                else
                    InvDiscAmount += SalesInvLine."Inv. Discount Amount";
                CostLCY += SalesInvLine.Quantity * SalesInvLine."BC6_Purchase Cost";
                LineQty += SalesInvLine.Quantity;
                TotalNetWeight += SalesInvLine.Quantity * SalesInvLine."Net Weight";
                TotalGrossWeight += SalesInvLine.Quantity * SalesInvLine."Gross Weight";
                TotalVolume += SalesInvLine.Quantity * SalesInvLine."Unit Volume";
                if SalesInvLine."Units per Parcel" > 0 then
                    TotalParcels += Round(SalesInvLine.Quantity / SalesInvLine."Units per Parcel", 1, '>');
                if SalesInvLine."VAT %" <> VATPercentage then
                    if VATPercentage = 0 then
                        VATPercentage := SalesInvLine."VAT %"
                    else
                        VATPercentage := -1;
                TotalAdjCostLCY +=
                  CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvLine) + CostCalcMgt.CalcSalesInvLineNonInvtblCostAmt(SalesInvLine);


            until SalesInvLine.Next() = 0;
        SalesInvStat.SetNewCustAmount(CustAmount);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Credit Memo Statistics", 'OnBeforeCalculateTotals', '', false, false)]
    local procedure P398_OnBeforeCalculateTotals(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var CustAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var CostLCY: Decimal; var TotalAdjCostLCY: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var IsHandled: Boolean; var VATpercentage: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesCreditMemoStat: Page "Sales Credit Memo Statistics";
        CostCalcMgt: Codeunit "Cost Calculation Management";
    begin
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.Find('-') then
            repeat
                CustAmount += SalesCrMemoLine.Amount;
                AmountInclVAT += SalesCrMemoLine."Amount Including VAT";
                //<<DEEE1.00 : Update DEEE amount (F9 without clic)
                SalesCreditMemoStat.IncremntDecGMntHTDEEE(SalesCrMemoLine."BC6_DEEE HT Amount");
                //>>DEEE1.00 : Update DEEE amount (F9 without clic)
                if SalesCrMemoHeader."Prices Including VAT" then
                    InvDiscAmount += SalesCrMemoLine."Inv. Discount Amount" / (1 + SalesCrMemoLine."VAT %" / 100)
                else
                    InvDiscAmount += SalesCrMemoLine."Inv. Discount Amount";
                CostLCY += SalesCrMemoLine.Quantity * SalesCrMemoLine."BC6_Purchase cost";
                LineQty += SalesCrMemoLine.Quantity;
                TotalNetWeight += SalesCrMemoLine.Quantity * SalesCrMemoLine."Net Weight";
                TotalGrossWeight += SalesCrMemoLine.Quantity * SalesCrMemoLine."Gross Weight";
                TotalVolume += SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Volume";
                if SalesCrMemoLine."Units per Parcel" > 0 then
                    TotalParcels += Round(SalesCrMemoLine.Quantity / SalesCrMemoLine."Units per Parcel", 1, '>');
                if SalesCrMemoLine."VAT %" <> VATpercentage then
                    if VATpercentage = 0 then
                        VATpercentage := SalesCrMemoLine."VAT %"
                    else
                        VATpercentage := -1;
                TotalAdjCostLCY +=
                  CostCalcMgt.CalcSalesCrMemoLineCostLCY(SalesCrMemoLine) + CostCalcMgt.CalcSalesCrMemoLineNonInvtblCostAmt(SalesCrMemoLine);


            until SalesCrMemoLine.Next() = 0;

        SalesCreditMemoStat.SetNewCustAmount(CustAmount);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Statistics", 'OnRefreshOnAfterGetRecordOnAfterGetSalesLines', '', false, false)]
    local procedure P402_OnRefreshOnAfterGetRecordOnAfterGetSalesLines(SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        // SalesPost.GetSalesLinesspec(Rec, TempSalesLine, i - 1); TODO: fonctio specifique dans la codeunit "Sales-Post"
    end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Statistics", 'OnUpdateHeaderInfoOnBeforeSetAmount', '', false, false)] TODO:
    // local procedure P402_OnUpdateHeaderInfoOnBeforeSetAmount(IndexNo: Integer)
    // var
    //     Salesheader: Record "Sales Header";
    //     VATAmountLine: Record "VAT Amount Line";
    //     RecGCustomer: Record Customer;
    //     SalesOrderStat: page "Sales Order Statistics";
    // begin
    //   SalesOrderStat.GetRecord(Salesheader); TODO:
    //   RecGCustomer.GET(Salesheader."Sell-to Customer No.");
    //   IF RecGCustomer."BC6_Submitted to DEEE" THEN BEGIN
    //     DecGVATAmount[IndexNo]:=VATAmountLine.GetTotalVATDEEEAmount ;
    //     DecGTTCAmount[IndexNo]:=VATAmountLine.GetTotalAmountDEEEInclVAT ;
    //     VATAmount[IndexNo]:=VATAmount[IndexNo]+DecGVATAmount[IndexNo] ;
    //   END ELSE BEGIN
    //     TotalSalesLineLCY[IndexNo]."DEEE HT Amount (LCY)" := 0;
    //     TotalSalesLine[IndexNo]."DEEE HT Amount":= 0;
    //     DecGVATAmount[IndexNo] := 0;
    //     DecGTTCAmount[IndexNo] := 0;
    //   END;



    // if not Salesheader."Prices Including VAT" then begin TODO:
    //     TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];
    //     TotalAmount2[IndexNo] := TotalAmount2[IndexNo] + DecGTTCAmount[IndexNo] - DecGVATAmount[IndexNo];
    // END;
    // end;


    [EventSubscriber(ObjectType::Page, Page::"Sales Line Discounts", 'OnLookupCodeFilterCaseElse', '', false, false)]
    local procedure OnLookupCodeFilterCaseElse(SalesLineDiscount: Record "Sales Line Discount"; var Text: Text; var Result: Boolean)
    var
        VendorList: Page "Vendor List";
    begin
        if SalesLineDiscount.Type = SalesLineDiscount.Type::Vendor then begin
            VendorList.LOOKUPMODE := true;
            if VendorList.RUNMODAL = ACTION::LookupOK then
                Text := VendorList.GetSelectionFilter
            else
                Result := false;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Vendor Card", 'OnBeforeActivateFields', '', false, false)]
    local procedure OnBeforeActivateFields(var IsCountyVisible: Boolean; var FormatAddress: Codeunit "Format Address"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        VendorCard: Page "Vendor Card";
    begin
        if UserSetup.GET(USERID) and UserSetup."BC6_Aut. Real Sales Profit %" then
            VendorCard.SetShowMiniMargin(true)
        else
            VendorCard.SetShowMiniMargin(false);
    end;




    //////////////////////////////////// page42

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Print Confirmation', false, false)]
    procedure P42_OnBeforeActionEvent(var Rec: Record "Sales Header")
    var
        salesOrder: Page "Sales Order";
    begin
        salesOrder.CheckIfReleased();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToAddressToShipToAddress', '', false, false)]
    procedure P36_OnAfterCopySellToAddressToShipToAddress(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Ship-to Name" := SalesHeader."Sell-to Customer Name";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterValidateEvent', 'BillToOptions', false, false)]
    procedure P42_OnAfterValidateEvent(var Rec: Record "Sales Header")
    begin
        Rec."Bill-to Name" := Rec."Sell-to Customer Name";
    end;


    //Page 41
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnAfterValidateEvent', 'Sell-to Customer Name', false, false)]
    procedure P41_OnAfterValidateEvent(var Rec: Record "Sales Header")
    begin
        Rec.verifyquotestatus;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnAfterInitControls', '', true, false)]
    procedure OnAfterInitControls()
    var
        UpdateICPartnerItemsEnabled: Boolean;
    begin
        if STRPOS(COMPANYNAME, 'CNE') = 0 then
            UpdateICPartnerItemsEnabled := false
        else
            UpdateICPartnerItemsEnabled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnAfterOnOpenPage', '', true, false)]

    procedure OnAfterOnOpenPage()
    var
        RecGAccessControl: Record "Access Control";
        BooGBlocked: Boolean;
    begin
        RecGAccessControl.RESET;
        RecGAccessControl.SETRANGE("User Security ID", USERSECURITYID);
        RecGAccessControl.SETRANGE("Role ID", 'MODIFART');
        if RecGAccessControl.FINDFIRST then begin
            BooGBlocked := true;
        end
        else begin
            BooGBlocked := false;
        end;
    end;


}
