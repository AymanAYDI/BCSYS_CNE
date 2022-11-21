page 50085 "BC6_Sales Order Lines Test"
{
    Caption = 'Sales Order Lines';
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
                Caption = 'Filters :';
                field(OptGSort; OptGSort)
                {
                    Caption = 'Sorting';
                    OptionCaption = 'Document No. - Line No.,Vendor No. - Shipment Date,Vendor No. - No. - Shipment Date';

                    trigger OnValidate()
                    begin
                        OptGSortOnAfterValidate;
                    end;
                }
                field(BooGExcDropShipFilter; BooGExcDropShipFilter)
                {
                    Caption = 'Exclude Drop Shipments';

                    trigger OnValidate()
                    begin
                        BooGExcDropShipFilterOnAfterVa;
                    end;
                }
                field(BooGExcQuoteFilter; BooGExcQuoteFilter)
                {
                    Caption = 'Exclude Sales Quotes';

                    trigger OnValidate()
                    begin
                        BooGExcQuoteFilterOnAfterValid;
                    end;
                }
                field(BooGOneTimeOrdering; BooGOneTimeOrdering)
                {
                    Caption = 'Exclude Orders Already Send';

                    trigger OnValidate()
                    begin
                        BooGOneTimeOrderingOnAfterVali;
                    end;
                }
                field(BooGNegForecastInv; BooGNegForecastInv)
                {
                    Caption = 'Negative Forecast Inventory';

                    trigger OnValidate()
                    begin
                        BooGNegForecastInvOnAfterValid;
                    end;
                }
                field(BooGExcShipOrders; BooGExcShipOrders)
                {
                    Caption = 'Exclude Shipment Orders';

                    trigger OnValidate()
                    begin
                        BooGExcShipOrdersOnAfterValida;
                    end;
                }
                field(TxtGShipmentDateFilter; TxtGShipmentDateFilter)
                {
                    Caption = 'ShipmentDateFilter';

                    trigger OnValidate()
                    begin
                        TxtGShipmentDateFilterOnAfterV;
                    end;
                }
                field(BooGNotGroupByItem; BooGNotGroupByItem)
                {
                    Caption = 'Not group by Item';
                }
            }
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    Editable = false;
                }
                field("Pick Qty."; "BC6_Pick Qty.")
                {
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    Editable = false;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    Caption = 'Requested Receipt Date';
                    Editable = false;
                }
                field("CNE Spokesman Name";
                RecGSalesHeader.ID)
                {
                    Caption = 'CNE Spokesman Name';
                    Editable = false;
                }
                field("Purchaser Comments";
                RecGSalesHeader."BC6_Purchaser Comments")
                {
                    Caption = 'Purchaser Comments';
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
                field("Shipping Advice"; FORMAT(RecGSalesHeader."Shipping Advice"))
                {
                    Caption = 'Shipping Advice';
                    Editable = false;
                }
                field("Purch. Order No."; "BC6_Purch. Order No.")
                {
                    Editable = false;
                }
                field("Purchase cost"; "BC6_Purchase cost")
                {
                    Editable = false;
                }
                field("Qty In Inventory";
                RecGItem.Inventory)
                {
                    Caption = 'Qty In Inventory';
                    Editable = false;
                }
                field("Qty. on Sales Order";
                RecGItem."Qty. on Sales Order")
                {
                    Caption = 'Qty. on Sales Order';
                    Editable = false;
                    Visible = false;
                }
                field("Qty. on Purch. Order";
                RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Qty. on Purchase Order';
                    Editable = false;
                    Visible = false;
                }
                field("Stock prévisionnel";
                RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Stock prévisionnel';
                    Editable = false;
                    Visible = false;
                }
                field("Customer Name";
                RecGSalesHeader."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                    Visible = true;
                }
                field("To Prepare"; "BC6_To Prepare")
                {
                }
                field("Qty. To Order"; "BC6_Qty. To Order")
                {
                }
                field("To Order"; "BC6_To Order")
                {
                    Caption = 'To Order';
                }
                field("Purch. Document Type"; "BC6_Purch. Document Type")
                {
                    Visible = false;
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
                Caption = 'Functions';
                action("Create Purchase Orders")
                {
                    Caption = 'Create Purchase Orders';

                    trigger OnAction()
                    var
                        RecLSalesLines: Record "Sales Line";
                        RecLSalesSetup: Record "Sales & Receivables Setup";
                        RecLPurchLine: Record "Purchase Line";
                        RecLPurchHeader: Record "Purchase Header";
                        CodLVendorNo: Code[20];
                        CodLItemNo: Code[20];
                        CodLCustomer: Code[20];
                        IntLLineNo: Integer;
                        DecLQuantity: Decimal;
                        "<<<PRODWARE>>>": Integer;
                        RecLPurchLine2: Record "Purchase Line";
                    begin
                        // Apply Filters

                        IF BooGNotGroupByItem THEN
                            CODEUNIT.RUN(50006, Rec)
                        ELSE BEGIN

                            //>>FEP-ACHAT-200706_18_A.002:GR
                            DiaGWindow.OPEN(
                                  CstGText50006 + CstGText50001 +
                                  CstGText50002 + CstGText50003);

                            RecLSalesSetup.GET;
                            CodLVendorNo := '';
                            //>>I012437.001
                            GPurchCost := 0;
                            //<<I012437.001

                            RecLSalesLines.COPYFILTERS(Rec);
                            //>>FEP-ACHAT-200706_18_A.004
                            //RecLSalesLines.SETCURRENTKEY("Buy-from Vendor No.","No.");
                            //>> MODIF HL 28/01/2010 SU-LALE cf appel I016274
                            //RecLSalesLines.SETCURRENTKEY("Buy-from Vendor No.","Qty. To Order","To Order");
                            RecLSalesLines.SETCURRENTKEY("BC6_To Order", "BC6_Buy-from Vendor No.", "No.", "BC6_Purchase cost", "BC6_Qty. To Order");
                            //<< MODIF HL 28/01/2010 SU-LALE cf appel I016274
                            //<<FEP-ACHAT-200706_18_A.004
                            RecLSalesLines.SETFILTER(RecLSalesLines."BC6_Buy-from Vendor No.", '<>%1', '');
                            RecLSalesLines.SETFILTER(RecLSalesLines."BC6_Qty. To Order", '<>%1', 0);
                            RecLSalesLines.SETRANGE(RecLSalesLines."BC6_To Order", TRUE);

                            //>>FEP-ACHAT-200706_18_A.004
                            //IF RecLSalesLines.FIND('-') THEN BEGIN
                            IF RecLSalesLines.FINDSET THEN BEGIN
                                //<<FEP-ACHAT-200706_18_A.004
                                RecLPurchLine.LOCKTABLE;
                                IF NOT RECORDLEVELLOCKING THEN
                                    RecLPurchHeader.LOCKTABLE(TRUE, TRUE); // Only version check
                                RecLSalesLines.LOCKTABLE;
                                REPEAT
                                    DiaGWindow.UPDATE(1, STRSUBSTNO('%1 %2', RecLSalesLines."Document Type",
                                                                           RecLSalesLines."Document No."));
                                    DiaGWindow.UPDATE(2, RecLSalesLines."No.");
                                    IF CodLVendorNo <> RecLSalesLines."BC6_Buy-from Vendor No." THEN BEGIN
                                        // Create Purchase Header
                                        RecLPurchHeader.INIT;
                                        RecLPurchHeader.VALIDATE("No.", '');
                                        RecLPurchHeader.VALIDATE("Document Type", RecLSalesLines."Document Type");
                                        RecLPurchHeader.INSERT(TRUE);
                                        RecLPurchHeader.VALIDATE("Document Date", WORKDATE);
                                        RecLPurchHeader.VALIDATE("Buy-from Vendor No.", RecLSalesLines."BC6_Buy-from Vendor No.");
                                        RecLPurchHeader.MODIFY(TRUE);
                                        DiaGWindow.UPDATE(3, RecLPurchHeader."No.");

                                        CodLVendorNo := RecLSalesLines."BC6_Buy-from Vendor No.";
                                        IntLLineNo := 10000;
                                        CodLItemNo := '';
                                        DecLQuantity := 0;
                                    END;

                                    // Group lines with same items
                                    //>>I012437.001
                                    //IF (CodLItemNo <> RecLSalesLines."No.")
                                    IF (CodLItemNo <> RecLSalesLines."No.") OR ((GPurchCost <> RecLSalesLines."BC6_Purchase cost") AND (
                                       CodLItemNo = RecLSalesLines."No."))
                                      //<<I012437.001
                                      THEN BEGIN

                                        // Insert Line
                                        RecLPurchLine.INIT;
                                        RecLPurchLine.VALIDATE("Document Type", RecLPurchLine."Document Type"::Order);
                                        RecLPurchLine.VALIDATE("Document No.", RecLPurchHeader."No.");
                                        RecLPurchLine.VALIDATE("Line No.", IntLLineNo);
                                        RecLPurchLine.VALIDATE(Type, RecLSalesLines.Type);
                                        RecLPurchLine.VALIDATE("No.", RecLSalesLines."No.");
                                        RecLPurchLine.VALIDATE("Variant Code", RecLSalesLines."Variant Code");
                                        RecLPurchLine.VALIDATE("Location Code", RecLSalesLines."Location Code");
                                        RecLPurchLine.VALIDATE("Unit of Measure Code", RecLSalesLines."Unit of Measure Code");
                                        IF (RecLPurchLine.Type = RecLPurchLine.Type::Item) AND (RecLPurchLine."No." <> '') THEN
                                            RecLPurchLine.UpdateUOMQtyPerStockQty;
                                        RecLPurchLine.VALIDATE("Expected Receipt Date", RecLSalesLines."Shipment Date");
                                        // RecLPurchLine.VALIDATE("Bin Code",RecLSalesLines."Bin Code");
                                        RecLPurchLine.VALIDATE(Quantity, RecLSalesLines."BC6_Qty. To Order");
                                        RecLPurchLine.VALIDATE("Return Reason Code", RecLSalesLines."Return Reason Code");
                                        RecLPurchLine.VALIDATE("Direct Unit Cost", RecLSalesLines."BC6_Purchase cost");
                                        RecLPurchLine.VALIDATE("Purchasing Code", RecLSalesLines."Purchasing Code");

                                        // If Multi Sales Lines : No Link
                                        RecLPurchLine.VALIDATE("BC6_Sales No.", RecLSalesLines."Document No.");
                                        RecLPurchLine.VALIDATE("BC6_Sales Line No.", RecLSalesLines."Line No.");
                                        RecLPurchLine.VALIDATE("BC6_Sales Document Type", RecLSalesLines."Document Type".AsInteger()); // TODO: check

                                        //>>CorrectionSOBI
                                        RecLPurchLine.VALIDATE("Line Discount %", 0);
                                        //<<CorrectionSOBI

                                        RecLPurchLine.INSERT(TRUE);
                                        CodLItemNo := RecLSalesLines."No.";
                                        IntLLineNo += 10000;
                                        DecLQuantity := RecLSalesLines."BC6_Qty. To Order";
                                        //>>I012437.001
                                        GPurchCost := RecLSalesLines."BC6_Purchase cost";
                                        //<<I012437.001
                                    END ELSE BEGIN
                                        DecLQuantity += RecLSalesLines."BC6_Qty. To Order";

                                        // If Multi Sales Lines : No Link
                                        RecLPurchLine.VALIDATE("BC6_Sales No.", '');
                                        RecLPurchLine.VALIDATE("BC6_Sales Line No.", 0);
                                        RecLPurchLine.VALIDATE(Quantity, DecLQuantity);
                                        //almi
                                        RecLPurchLine.VALIDATE("Direct Unit Cost", RecLSalesLines."BC6_Purchase cost");
                                        RecLPurchLine.MODIFY(TRUE);

                                        DiaGWindow.UPDATE(4, RecLSalesLines."No.");

                                    END;

                                    RecLSalesLines."BC6_Purch. Document Type" := RecLSalesLines."BC6_Purch. Document Type"::Order;
                                    RecLSalesLines."BC6_Purch. Order No." := RecLPurchLine."Document No.";
                                    RecLSalesLines."BC6_Purch. Line No." := RecLPurchLine."Line No.";
                                    //>>
                                    RecLSalesLines."BC6_Purchase Receipt Date" := RecLPurchLine."Expected Receipt Date";
                                    //<<
                                    RecLSalesLines."BC6_Qty. To Order" := 0;
                                    RecLSalesLines."BC6_To Order" := FALSE;
                                    //>>I011762.001
                                    //>> Insert Temp table
                                    RecLSalesLineTmp.TRANSFERFIELDS(RecLSalesLines);
                                    RecLSalesLineTmp.INSERT(FALSE);
                                    //<<I011762.001
                                    RecLSalesLines.MODIFY(FALSE);

                                UNTIL RecLSalesLines.NEXT = 0;
                                //>>I011762.001
                                // Insert extended text
                                RecLSalesLineTmp.RESET;
                                IF RecLSalesLineTmp.FIND('-') THEN
                                    REPEAT
                                        RecLPurchLine2.RESET;
                                        RecLPurchLine2.SETRANGE("Document Type", RecLSalesLineTmp."BC6_Purch. Document Type"::Order);
                                        RecLPurchLine2.SETRANGE("Document No.", RecLSalesLineTmp."BC6_Purch. Order No.");
                                        RecLPurchLine2.SETRANGE("Line No.", RecLSalesLineTmp."BC6_Purch. Line No.");
                                        IF RecLPurchLine2.FIND('-') THEN
                                            REPEAT
                                                InsertExtendedText(TRUE, RecLPurchLine2);
                                                RecLPurchLine2.MODIFY(FALSE);
                                            UNTIL RecLPurchLine2.NEXT = 0;
                                    UNTIL RecLSalesLineTmp.NEXT = 0;
                                //<<I011762.001
                            END;

                            DiaGWindow.CLOSE;

                            //<<FEP-ACHAT-200706_18_A.002:GR

                        END;

                        //>>FEP-ACHAT-200706_18_A.004
                        CurrPage.UPDATE(FALSE);
                        //<<FEP-ACHAT-200706_18_A.004
                    end;
                }
            }
            action(RAZ)
            {
                Caption = 'RAZ';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF FIND('-') THEN BEGIN
                        REPEAT
                            CurrPage.UPDATE(FALSE);
                            "BC6_Qty. To Order" := 0;
                            CurrPage.UPDATE(TRUE);
                        UNTIL NEXT = 0;
                        FIND('-');
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecGSalesHeader.RESET;
        IF RecGSalesHeader.GET("Document Type", "Document No.") THEN;

        RecGItem.RESET;
        IF RecGItem.GET("No.") THEN
            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);


        //OPTIMISATION
        /*
        RecGVendor.RESET;
        RecGVendor.INIT;
        IF RecGVendor.GET("Buy-from Vendor No.") THEN;
        */

        // voir si c'est une commande en demande de prix  (Quote Order)
        //IF ("Document Type" = 0) THEN // and ("Purchase Order No." <>'') then
        //  "Forecast Inventory" := FALSE
        //ELSE
        //  "Forecast Inventory" := FALSE;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ERROR('Non Non Non');
    end;

    trigger OnOpenPage()
    begin
        //>>FEP-ACHAT-200706_18_A.002:GR
        BooGOneTimeOrdering := TRUE;
        //<<FEP-ACHAT-200706_18_A.002:GR

        BooGExcDropShipFilter := TRUE;
        BooGExcQuoteFilter := FALSE;
        //>> CNE6.01
        BooGNotGroupByItem := FALSE;

        SetRecFilters;
    end;

    var
        "-FEP-ACHAT-200706_18_A-": Integer;
        RecGSalesHeader: Record "Sales Header";
        RecGItem: Record Item;
        BooGExcDropShipFilter: Boolean;
        RecGPurchasing: Record Purchasing;
        BooGExcQuoteFilter: Boolean;
        BooGNegForecastInv: Boolean;
        BooGExcShipOrders: Boolean;
        BooGOneTimeOrdering: Boolean;
        TxtGShipmentDateFilter: Text[50];
        OptGSort: Option;
        DiaGWindow: Dialog;
        // "--Var Txt--": ; TODO:
        CstGText50006: Label 'Created lines                 #1##########\';
        CstGText50001: Label 'Item No.          #2##########\';
        CstGText50002: Label 'Purchase Header          #2##########\';
        CstGText50003: Label 'Purchase Lines             #3###########\';
        "<<<PRODWARE>>>": Integer;
        RecLSalesLineTmp: Record "Sales Line" temporary;
        GPurchCost: Decimal;
        BooGNotGroupByItem: Boolean;
        "-OPTIMISATION": Integer;
        RecGVendor_Record: Boolean;
        CodGVendorFilter_Code20: Boolean;


    procedure SetRecFilters()
    var
        RecLSalesSetup: Record "Sales & Receivables Setup";
    begin
        //>>FEP-ACHAT-200706_18_A.002:GR
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
        SETRANGE("Purchasing Code", RecLSalesSetup."BC6_Purcha. Code Grouping Line");

        // Exclude Orders Already Send
        IF BooGOneTimeOrdering THEN BEGIN
            //SETFILTER("Purch. Order No.",'%1',''); //TODO 39 21/01/08
            SETFILTER("BC6_Purch. Document Type", '<>%1', "BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            SETRANGE("BC6_Purch. Order No.");
            SETRANGE("BC6_Purch. Document Type");
        END;

        // Exclude Sales Quotes
        IF BooGExcQuoteFilter THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '%1', "BC6_Purch. Document Type"::Quote);            //TODO 39 21/01/08
            SETFILTER("BC6_Purch. Order No.", '%1', '');                                           //TODO 39 21/01/08
        END ELSE BEGIN
            IF NOT BooGOneTimeOrdering THEN BEGIN
                SETRANGE("BC6_Purch. Document Type");
                SETRANGE("BC6_Purch. Order No.");
            END;
        END;

        //<<FEP-ACHAT-200706_18_A.002:GR

        // Exclude Drop Shipment
        IF BooGExcDropShipFilter THEN
            SETRANGE("Drop Shipment", FALSE)
        ELSE
            SETRANGE("Drop Shipment");

        // Negative Forecast Inventory (Stock prévisionnel négatif)
        //>FEP-ACHAT-200706_18_A.003
        /*
        IF BooGNegForecastInv THEN
          SETFILTER("Forecast Inventory",'<%1',0)
        ELSE
          SETRANGE("Forecast Inventory");
        */
        //<FEP-ACHAT-200706_18_A.003

        //OPTIMISATION
        /*
        // Vendor No. Filter
        IF CodGVendorFilter <> '' THEN
          SETRANGE("Buy-from Vendor No.",CodGVendorFilter)
        ELSE
          SETRANGE("Buy-from Vendor No.");
        */

        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
            SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            SETRANGE("BC6_To Prepare");

        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
            SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            SETRANGE("Shipment Date");

        //>FEP-ACHAT-200706_18_A.003
        CLEARMARKS;
        IF BooGNegForecastInv THEN BEGIN
            IF NOT ISEMPTY THEN BEGIN
                IF FINDSET THEN
                    REPEAT
                        IF RecGItem.GET("No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            MARK(TRUE);
                    UNTIL NEXT = 0;
                MARKEDONLY(TRUE);
                FINDFIRST;
            END;

        END ELSE
            MARKEDONLY(FALSE);
        //<FEP-ACHAT-200706_18_A.003

        CurrPage.UPDATE(FALSE);

    end;


    procedure "<<<PRODWARE FUNCTIONS>>>"()
    begin
    end;


    procedure InsertExtendedText(Unconditionally: Boolean; var RecLPurch: Record "Purchase Line")
    var
    // TransferExtendedText: Codeunit "Transfer Extended Text"; TODO: 
    begin
        // IF TransferExtendedText.PurchCheckIfAnyExtText(RecLPurch, Unconditionally) THEN BEGIN TODO:
        //     COMMIT;
        //     TransferExtendedText.InsertPurchExtText(RecLPurch);
        //     TransferExtendedText.InsertPurchExtTextSpe(RecLPurch);
        // END;
    end;

    local procedure BooGExcDropShipFilterOnAfterVa()
    begin
        //>>TI301087
        //SetRecFilters;
        // Exclude Drop Shipment
        OptGSortOnAfterValidate;
        IF BooGExcDropShipFilter THEN
            SETRANGE("Drop Shipment", FALSE)
        ELSE
            SETRANGE("Drop Shipment");
        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;

    local procedure BooGExcQuoteFilterOnAfterValid()
    begin
        //>>TI301087
        //SetRecFilters;
        // Exclude Sales Quotes
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
        //<<TI301087
    end;

    local procedure BooGNegForecastInvOnAfterValid()
    begin
        //>>TI301087
        //SetRecFilters;
        CLEARMARKS;
        IF BooGNegForecastInv THEN BEGIN
            IF NOT ISEMPTY THEN BEGIN
                IF FINDSET THEN
                    REPEAT
                        IF RecGItem.GET("No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            MARK(TRUE);
                    UNTIL NEXT = 0;
                MARKEDONLY(TRUE);
                FINDFIRST;
            END;

        END ELSE
            MARKEDONLY(FALSE);
        CurrPage.UPDATE(FALSE);
        //<<TI301087
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
        //>>TI301087
        //SetRecFilters;
        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
            SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            SETRANGE("BC6_To Prepare");
        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;

    local procedure TxtGShipmentDateFilterOnAfterV()
    begin
        //>>TI301087
        //SetRecFilters;

        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
            SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            SETRANGE("Shipment Date");

        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;

    local procedure OptGSortOnAfterValidate()
    begin
        //>>TI301087
        /*
        CASE OptGSort OF
        
          0 : SETCURRENTKEY("Document Type","Document No.","Line No.");
          1 : SETCURRENTKEY("Buy-from Vendor No.","Shipment Date");
          2 : SETCURRENTKEY("Buy-from Vendor No.","No.","Shipment Date");
        */
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

        //SetRecFilters;
        //<<TI301087

    end;

    local procedure BooGOneTimeOrderingOnAfterVali()
    begin
        //>>TI301087
        //SetRecFilters;

        // Exclude Orders Already Send
        IF BooGOneTimeOrdering THEN BEGIN
            SETFILTER("BC6_Purch. Document Type", '<>%1', "BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            SETRANGE("BC6_Purch. Order No.");
            SETRANGE("BC6_Purch. Document Type");
        END;

        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;
}

