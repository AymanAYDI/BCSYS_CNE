page 50085 "BC6_Sales Order Lines Test"
{
    Caption = 'Sales Order Lines', Comment = 'FRA="Lignes commandes vente"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("Document Type" = FILTER(Order),
                            Type = FILTER(Item),
                            "Outstanding Quantity" = FILTER(> 0));

    layout
    {
        area(content)
        {
            group("Filters :")
            {
                Caption = 'Filters :', Comment = 'FRA="Filtres :"';
                field(OptGSort; OptGSort)
                {
                    Caption = 'Sorting', Comment = 'FRA="Tri par"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        OptGSortOnAfterValidate();
                    end;
                }
                field(BooGExcDropShipFilter; BooGExcDropShipFilter)
                {
                    Caption = 'Exclude Drop Shipments', Comment = 'FRA="Exclure livraisons directes"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BooGExcDropShipFilterOnAfterVa();
                    end;
                }
                field(BooGExcQuoteFilter; BooGExcQuoteFilter)
                {
                    Caption = 'Exclude Sales Quotes', Comment = 'FRA="Exclure commandes en demande de prix"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BooGExcQuoteFilterOnAfterValid();
                    end;
                }
                field(BooGOneTimeOrdering; BooGOneTimeOrdering)
                {
                    Caption = 'Exclude Orders Already Send', Comment = 'FRA="Exclure commandes déjà traitées"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BooGOneTimeOrderingOnAfterVali();
                    end;
                }
                field(BooGNegForecastInv; BooGNegForecastInv)
                {
                    Caption = 'Negative Forecast Inventory', Comment = 'FRA="Stock prévisionnel négatif"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BooGNegForecastInvOnAfterValid();
                    end;
                }
                field(BooGExcShipOrders; BooGExcShipOrders)
                {
                    Caption = 'Exclude Shipment Orders', Comment = 'FRA="Exclure commandes en préparation"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BooGExcShipOrdersOnAfterValida();
                    end;
                }
                field(TxtGShipmentDateFilter; TxtGShipmentDateFilter)
                {
                    Caption = 'ShipmentDateFilter', Comment = 'FRA="Filtre date préparation"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TxtGShipmentDateFilterOnAfterV();
                    end;
                }
                field(BooGNotGroupByItem; BooGNotGroupByItem)
                {
                    Caption = 'Not group by Item', Comment = 'FRA="Ne pas regrouper par article"';
                    ApplicationArea = All;
                }
            }
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pick Qty."; "BC6_Pick Qty.")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    Caption = 'Requested Receipt Date', Comment = 'FRA="Date réception demandée"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CNE Spokesman Name";
                RecGSalesHeader.ID)
                {
                    Caption = 'CNE Spokesman Name', Comment = 'FRA="Nom interlocuteur CNE"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchaser Comments";
                RecGSalesHeader."BC6_Purchaser Comments")
                {
                    Caption = 'Purchaser Comments', Comment = 'FRA="Commentaires acheteur"';
                    ApplicationArea = All;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; FORMAT(RecGSalesHeader."Shipping Advice"))
                {
                    Caption = 'Shipping Advice', Comment = 'FRA="Option d''expédition"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purch. Order No."; "BC6_Purch. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase cost"; "BC6_Purchase cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty In Inventory";
                RecGItem.Inventory)
                {
                    Caption = 'Qty In Inventory', Comment = 'FRA="Qté en stock"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order";
                RecGItem."Qty. on Sales Order")
                {
                    Caption = 'Qty. on Sales Order', Comment = 'FRA="Quantité sur commande vente"';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Order";
                RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Qty. on Purchase Order', Comment = 'FRA="Quantité sur commande achat"';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Stock prévisionnel";
                RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Stock prévisionnel', Comment = 'FRA="Stock prévisionnel"';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Name";
                RecGSalesHeader."Sell-to Customer Name")
                {
                    Caption = 'Customer Name', Comment = 'FRA="Nom du client "';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("To Prepare"; "BC6_To Prepare")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Order"; "BC6_Qty. To Order")
                {
                    ApplicationArea = All;
                }
                field("To Order"; "BC6_To Order")
                {
                    Caption = 'To Order', Comment = 'FRA="A commander"';
                    ApplicationArea = All;
                }
                field("Purch. Document Type"; "BC6_Purch. Document Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions', Comment = 'FRA="Fonctions"';
                action("Create Purchase Orders")
                {
                    Caption = 'Create Purchase Orders', Comment = 'FRA="Créer commandes achat"';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecLPurchHeader: Record "Purchase Header";
                        RecLPurchLine: Record "Purchase Line";
                        RecLPurchLine2: Record "Purchase Line";
                        RecLSalesSetup: Record "Sales & Receivables Setup";
                        RecLSalesLines: Record "Sales Line";
                        CodLCustomer: Code[20];
                        CodLItemNo: Code[20];
                        CodLVendorNo: Code[20];
                        DecLQuantity: Decimal;
                        "<<<PRODWARE>>>": Integer;
                        IntLLineNo: Integer;
                    begin
                        IF BooGNotGroupByItem THEN
                            CODEUNIT.RUN(Codeunit::"BC6_Create Pur. Ord From Sales", Rec)
                        ELSE BEGIN
                            DiaGWindow.OPEN(
                                  CstGText50006 + CstGText50001 +
                                  CstGText50002 + CstGText50003);

                            RecLSalesSetup.GET();
                            CodLVendorNo := '';
                            GPurchCost := 0;

                            RecLSalesLines.COPYFILTERS(Rec);
                            RecLSalesLines.SETCURRENTKEY("BC6_To Order", "BC6_Buy-from Vendor No.", "No.", "BC6_Purchase cost", "BC6_Qty. To Order");

                            RecLSalesLines.SETFILTER(RecLSalesLines."BC6_Buy-from Vendor No.", '<>%1', '');
                            RecLSalesLines.SETFILTER(RecLSalesLines."BC6_Qty. To Order", '<>%1', 0);
                            RecLSalesLines.SETRANGE(RecLSalesLines."BC6_To Order", TRUE);

                            IF RecLSalesLines.FINDSET() THEN BEGIN
                                RecLPurchLine.LOCKTABLE();
                                IF NOT RECORDLEVELLOCKING THEN
                                    RecLPurchHeader.LOCKTABLE(TRUE, TRUE);
                                RecLSalesLines.LOCKTABLE();
                                REPEAT
                                    DiaGWindow.UPDATE(1, STRSUBSTNO('%1 %2', RecLSalesLines."Document Type",
                                                                           RecLSalesLines."Document No."));
                                    DiaGWindow.UPDATE(2, RecLSalesLines."No.");
                                    IF CodLVendorNo <> RecLSalesLines."BC6_Buy-from Vendor No." THEN BEGIN

                                        RecLPurchHeader.INIT();
                                        RecLPurchHeader.VALIDATE("No.", '');
                                        RecLPurchHeader.VALIDATE("Document Type", RecLSalesLines."Document Type");
                                        RecLPurchHeader.INSERT(TRUE);
                                        RecLPurchHeader.VALIDATE("Document Date", WORKDATE());
                                        RecLPurchHeader.VALIDATE("Buy-from Vendor No.", RecLSalesLines."BC6_Buy-from Vendor No.");
                                        RecLPurchHeader.MODIFY(TRUE);
                                        DiaGWindow.UPDATE(3, RecLPurchHeader."No.");

                                        CodLVendorNo := RecLSalesLines."BC6_Buy-from Vendor No.";
                                        IntLLineNo := 10000;
                                        CodLItemNo := '';
                                        DecLQuantity := 0;
                                    END;

                                    IF (CodLItemNo <> RecLSalesLines."No.") OR ((GPurchCost <> RecLSalesLines."BC6_Purchase cost") AND (
                                       CodLItemNo = RecLSalesLines."No."))
                                      THEN BEGIN

                                        RecLPurchLine.INIT();
                                        RecLPurchLine.VALIDATE("Document Type", RecLPurchLine."Document Type"::Order);
                                        RecLPurchLine.VALIDATE("Document No.", RecLPurchHeader."No.");
                                        RecLPurchLine.VALIDATE("Line No.", IntLLineNo);
                                        RecLPurchLine.VALIDATE(Type, RecLSalesLines.Type);
                                        RecLPurchLine.VALIDATE("No.", RecLSalesLines."No.");
                                        RecLPurchLine.VALIDATE("Variant Code", RecLSalesLines."Variant Code");
                                        RecLPurchLine.VALIDATE("Location Code", RecLSalesLines."Location Code");
                                        RecLPurchLine.VALIDATE("Unit of Measure Code", RecLSalesLines."Unit of Measure Code");
                                        IF (RecLPurchLine.Type = RecLPurchLine.Type::Item) AND (RecLPurchLine."No." <> '') THEN
                                            RecLPurchLine.UpdateUOMQtyPerStockQty();
                                        RecLPurchLine.VALIDATE("Expected Receipt Date", RecLSalesLines."Shipment Date");
                                        RecLPurchLine.VALIDATE(Quantity, RecLSalesLines."BC6_Qty. To Order");
                                        RecLPurchLine.VALIDATE("Return Reason Code", RecLSalesLines."Return Reason Code");
                                        RecLPurchLine.VALIDATE("Direct Unit Cost", RecLSalesLines."BC6_Purchase cost");
                                        RecLPurchLine.VALIDATE("Purchasing Code", RecLSalesLines."Purchasing Code");

                                        RecLPurchLine.VALIDATE("BC6_Sales No.", RecLSalesLines."Document No.");
                                        RecLPurchLine.VALIDATE("BC6_Sales Line No.", RecLSalesLines."Line No.");
                                        RecLPurchLine.VALIDATE("BC6_Sales Document Type", RecLSalesLines."Document Type");

                                        RecLPurchLine.VALIDATE("Line Discount %", 0);

                                        RecLPurchLine.INSERT(TRUE);
                                        CodLItemNo := RecLSalesLines."No.";
                                        IntLLineNo += 10000;
                                        DecLQuantity := RecLSalesLines."BC6_Qty. To Order";
                                        GPurchCost := RecLSalesLines."BC6_Purchase cost";
                                    END ELSE BEGIN
                                        DecLQuantity += RecLSalesLines."BC6_Qty. To Order";

                                        RecLPurchLine.VALIDATE("BC6_Sales No.", '');
                                        RecLPurchLine.VALIDATE("BC6_Sales Line No.", 0);
                                        RecLPurchLine.VALIDATE(Quantity, DecLQuantity);
                                        RecLPurchLine.VALIDATE("Direct Unit Cost", RecLSalesLines."BC6_Purchase cost");
                                        RecLPurchLine.MODIFY(TRUE);

                                        DiaGWindow.UPDATE(4, RecLSalesLines."No.");

                                    END;

                                    RecLSalesLines."BC6_Purch. Document Type" := RecLSalesLines."BC6_Purch. Document Type"::Order;
                                    RecLSalesLines."BC6_Purch. Order No." := RecLPurchLine."Document No.";
                                    RecLSalesLines."BC6_Purch. Line No." := RecLPurchLine."Line No.";
                                    RecLSalesLines."BC6_Purchase Receipt Date" := RecLPurchLine."Expected Receipt Date";
                                    RecLSalesLines."BC6_Qty. To Order" := 0;
                                    RecLSalesLines."BC6_To Order" := FALSE;
                                    RecLSalesLineTmp.TRANSFERFIELDS(RecLSalesLines);
                                    RecLSalesLineTmp.INSERT(FALSE);
                                    RecLSalesLines.MODIFY(FALSE);

                                UNTIL RecLSalesLines.NEXT() = 0;
                                RecLSalesLineTmp.RESET();
                                IF RecLSalesLineTmp.FIND('-') THEN
                                    REPEAT
                                        RecLPurchLine2.RESET();
                                        RecLPurchLine2.SETRANGE("Document Type", RecLSalesLineTmp."BC6_Purch. Document Type"::Order);
                                        RecLPurchLine2.SETRANGE("Document No.", RecLSalesLineTmp."BC6_Purch. Order No.");
                                        RecLPurchLine2.SETRANGE("Line No.", RecLSalesLineTmp."BC6_Purch. Line No.");
                                        IF RecLPurchLine2.FIND('-') THEN
                                            REPEAT
                                                InsertExtendedText(TRUE, RecLPurchLine2);
                                                RecLPurchLine2.MODIFY(FALSE);
                                            UNTIL RecLPurchLine2.NEXT() = 0;
                                    UNTIL RecLSalesLineTmp.NEXT() = 0;
                            END;

                            DiaGWindow.CLOSE();


                        END;

                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action(RAZ)
            {
                Caption = 'RAZ', Comment = 'FRA="RAZ"';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF FIND('-') THEN BEGIN
                        REPEAT
                            CurrPage.UPDATE(FALSE);
                            "BC6_Qty. To Order" := 0;
                            CurrPage.UPDATE(TRUE);
                        UNTIL NEXT() = 0;
                        FIND('-');
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecGSalesHeader.RESET();
        IF RecGSalesHeader.GET("Document Type", "Document No.") THEN;

        RecGItem.RESET();
        IF RecGItem.GET("No.") THEN
            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);


    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ERROR('Non Non Non');
    end;

    trigger OnOpenPage()
    begin
        BooGOneTimeOrdering := TRUE;

        BooGExcDropShipFilter := TRUE;
        BooGExcQuoteFilter := FALSE;
        BooGNotGroupByItem := FALSE;

        SetRecFilters();
    end;

    var
        RecGItem: Record Item;
        RecGPurchasing: Record Purchasing;
        RecGSalesHeader: Record "Sales Header";
        RecLSalesLineTmp: Record "Sales Line" temporary;
        BooGExcDropShipFilter: Boolean;
        BooGExcQuoteFilter: Boolean;
        BooGExcShipOrders: Boolean;
        BooGNegForecastInv: Boolean;
        BooGNotGroupByItem: Boolean;
        BooGOneTimeOrdering: Boolean;
        CodGVendorFilter_Code20: Boolean;
        RecGVendor_Record: Boolean;
        GPurchCost: Decimal;
        DiaGWindow: Dialog;
        OptGSort: Enum BC6_OptGSort;
        "-FEP-ACHAT-200706_18_A-": Integer;
        "-OPTIMISATION": Integer;
        "<<<PRODWARE>>>": Integer;
        CstGText50001: Label 'Item No.          #2##########\', Comment = 'FRA="#2###########\"';
        CstGText50002: Label 'Purchase Header          #2##########\', Comment = 'FRA=" #3###########\"';
        CstGText50003: Label 'Purchase Lines             #3###########\', Comment = 'FRA="#4###########\"';

        CstGText50006: Label 'Created lines                 #1##########\', Comment = 'FRA=" #1###########\"';
        TxtGShipmentDateFilter: Text[50];


    procedure SetRecFilters()
    var
        RecLSalesSetup: Record "Sales & Receivables Setup";
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
        SETRANGE("Purchasing Code", RecLSalesSetup."BC6_Purcha. Code Grouping Line");


        IF BooGOneTimeOrdering THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '<>%1', "BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            SETRANGE("BC6_Purch. Order No.");
            SETRANGE("BC6_Purch. Document Type");
        END;

        IF BooGExcQuoteFilter THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '%1', "BC6_Purch. Document Type"::Quote);
            SETFILTER("BC6_Purch. Order No.", '%1', '');
        END ELSE BEGIN
            IF NOT BooGOneTimeOrdering THEN BEGIN
                SETRANGE("BC6_Purch. Document Type");
                SETRANGE("BC6_Purch. Order No.");
            END;
        END;

        IF BooGExcDropShipFilter THEN
            SETRANGE("Drop Shipment", FALSE)
        ELSE
            SETRANGE("Drop Shipment");


        IF BooGExcShipOrders THEN
            SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            SETRANGE("BC6_To Prepare");


        IF TxtGShipmentDateFilter <> '' THEN
            SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            SETRANGE("Shipment Date");


        CLEARMARKS();
        IF BooGNegForecastInv THEN BEGIN
            IF NOT ISEMPTY THEN BEGIN
                IF FINDSET() THEN
                    REPEAT
                        IF RecGItem.GET("No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            MARK(TRUE);
                    UNTIL NEXT() = 0;
                MARKEDONLY(TRUE);
                FINDFIRST();
            END;

        END ELSE
            MARKEDONLY(FALSE);

        CurrPage.UPDATE(FALSE);

    end;


    procedure "<<<PRODWARE FUNCTIONS>>>"()
    begin
    end;


    procedure InsertExtendedText(Unconditionally: Boolean; var RecLPurch: Record "Purchase Line")
    var
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(RecLPurch, Unconditionally) THEN BEGIN
            COMMIT();
            TransferExtendedText.InsertPurchExtText(RecLPurch);
            FunctionsMgt.InsertPurchExtTextSpe(RecLPurch);
        END;
    end;

    local procedure BooGExcDropShipFilterOnAfterVa()
    begin
        OptGSortOnAfterValidate();
        IF BooGExcDropShipFilter THEN
            SETRANGE("Drop Shipment", FALSE)
        ELSE
            SETRANGE("Drop Shipment");
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BooGExcQuoteFilterOnAfterValid()
    begin
        IF BooGExcQuoteFilter THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '%1', "BC6_Purch. Document Type"::Quote);
            SETFILTER("BC6_Purch. Order No.", '%1', '');
        END ELSE BEGIN
            IF NOT BooGOneTimeOrdering THEN BEGIN
                SETRANGE("BC6_Purch. Document Type");
                SETRANGE("BC6_Purch. Order No.");
            END;
        END;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BooGNegForecastInvOnAfterValid()
    begin
        CLEARMARKS();
        IF BooGNegForecastInv THEN BEGIN
            IF NOT ISEMPTY THEN BEGIN
                IF FINDSET() THEN
                    REPEAT
                        IF RecGItem.GET("No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            MARK(TRUE);
                    UNTIL NEXT() = 0;
                MARKEDONLY(TRUE);
                FINDFIRST();
            END;

        END ELSE
            MARKEDONLY(FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CodGVendorFilterOnAfterValidat()
    begin
        //OPTIMISATION
        /*
        //>>TI301087
        //SetRecFilters;
        // Vendor No. Filter
        IF CodGVendorFilter <> '' THEN
          SETRANGE("Buy-from Vendor No.",CodGVendorFilter)
        ELSE
          SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE(FALSE);
        //<<TI301087
        */

    end;

    local procedure BooGExcShipOrdersOnAfterValida()
    begin
        IF BooGExcShipOrders THEN
            SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            SETRANGE("BC6_To Prepare");
        CurrPage.UPDATE(FALSE);
    end;

    local procedure TxtGShipmentDateFilterOnAfterV()
    begin
        IF TxtGShipmentDateFilter <> '' THEN
            SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            SETRANGE("Shipment Date");

        CurrPage.UPDATE(FALSE);
    end;

    local procedure OptGSortOnAfterValidate()
    begin
        IF BooGExcDropShipFilter THEN BEGIN
            CASE OptGSort OF
                0:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment");
                1:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "BC6_Buy-from Vendor No.", "Shipment Date");
                2:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "BC6_Buy-from Vendor No.", "No.", "Shipment Date");
            END;
        END ELSE BEGIN
            CASE OptGSort OF
                0:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code");
                1:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "BC6_Buy-from Vendor No.", "Shipment Date");
                2:
                    SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "BC6_Buy-from Vendor No.", "No.", "Shipment Date");
            END;
        END;
    end;

    local procedure BooGOneTimeOrderingOnAfterVali()
    begin
        IF BooGOneTimeOrdering THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '<>%1', "BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            SETRANGE("BC6_Purch. Order No.");
            SETRANGE("BC6_Purch. Document Type");
        END;

        CurrPage.UPDATE(FALSE);
    end;
}

