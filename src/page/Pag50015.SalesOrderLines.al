page 50015 "BC6_Sales Order Lines"
{
    Caption = 'Sales Order Lines', comment = 'FRA="Lignes commandes vente"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("Document Type" = FILTER(Order),
                            Type = FILTER(Item),
                            "Outstanding Quantity" = FILTER(> 0));
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group("Filters :")
            {
                Caption = 'Filters :', comment = 'FRA="Filtres"';
                field(OptGSort; OptGSort)
                {
                    Caption = 'Sorting', comment = 'FRA="Tri par"';
                    OptionCaption = 'Document No. - Line No.,Vendor No. - Shipment Date,Vendor No. - No. - Shipment Date';

                    trigger OnValidate()
                    begin
                        OptGSortOnAfterValidate();
                    end;
                }
                field(BooGExcDropShipFilter; BooGExcDropShipFilter)
                {
                    Caption = 'Exclude Drop Shipments', comment = 'FRA="Exclure livraisons directes"';

                    trigger OnValidate()
                    begin
                        BooGExcDropShipFilterOnAfterVa();
                    end;
                }
                field(BooGExcQuoteFilter; BooGExcQuoteFilter)
                {
                    Caption = 'Exclude Sales Quotes', comment = 'FRA="Exclure commandes en demande de prix"';

                    trigger OnValidate()
                    begin
                        BooGExcQuoteFilterOnAfterValid();
                    end;
                }
                field(BooGOneTimeOrdering; BooGOneTimeOrdering)
                {
                    Caption = 'Exclude Orders Already Send', comment = 'FRA="Exclure commandes déjà traitées"';

                    trigger OnValidate()
                    begin
                        BooGOneTimeOrderingOnAfterVali();
                    end;
                }
                field(BooGNegForecastInv; BooGNegForecastInv)
                {
                    Caption = 'Negative Forecast Inventory', comment = 'FRA="Stock prévisionnel négatif"';

                    trigger OnValidate()
                    begin
                        BooGNegForecastInvOnAfterValid();
                    end;
                }
                field(CodGVendorFilter; CodGVendorFilter)
                {
                    Caption = 'Vendor No. Filter', comment = 'FRA="Filtre N° fournisseur"';
                    TableRelation = Vendor."No.";

                    trigger OnValidate()
                    begin
                        CodGVendorFilterOnAfterValidat();
                    end;
                }
                field(BooGExcShipOrders; BooGExcShipOrders)
                {
                    Caption = 'Exclude Shipment Orders', comment = 'FRA="Exclure commandes en préparation"';

                    trigger OnValidate()
                    begin
                        BooGExcShipOrdersOnAfterValida();
                    end;
                }
                field(TxtGShipmentDateFilter; TxtGShipmentDateFilter)
                {
                    Caption = 'ShipmentDateFilter', comment = 'FRA="Filtre date préparation"';

                    trigger OnValidate()
                    begin
                        TxtGShipmentDateFilterOnAfterV();
                    end;
                }
                field(BooGNotGroupByItem; BooGNotGroupByItem)
                {
                    Caption = 'Not group by Item', comment = 'FRA="Ne pas regrouper par article"';
                }
            }
            repeater(Control1000000000)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Editable = false;
                }
                field("Pick Qty."; Rec."BC6_Pick Qty.")
                {
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Receipt Date', comment = 'FRA="Date réception demandée"';
                    Editable = false;
                }
                field("RecGSalesHeader.ID"; RecGSalesHeader.ID)
                {
                    Caption = 'CNE Spokesman Name', comment = 'FRA="Nom interlocuteur CNE"';
                    Editable = false;
                }
                field("Purchaser Comments";
                RecGSalesHeader."BC6_Purchaser Comments")
                {
                    Caption = 'Purchaser Comments', comment = 'FRA="Commentaires acheteur"';
                }
                field("Warehouse Comments";
                RecGSalesHeader."BC6_Warehouse Comments")
                {
                    Caption = 'Warehouse Comments', comment = 'FRA="Commentaires magasins"';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                }
                field("Shipping Advice"; FORMAT(RecGSalesHeader."Shipping Advice"))
                {
                    Caption = 'Shipping Advice', Comment = 'FRA="Option d''expédition"';
                    Editable = false;
                }
                field("Purch. Order No."; Rec."BC6_Purch. Order No.")
                {
                    Editable = false;
                }
                field("Purchase cost"; Rec."BC6_Purchase cost")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."BC6_Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.', comment = 'FRA="N° fournisseur"';
                }
                field("RecGVendor.Name"; RecGVendor.Name)
                {
                    Caption = 'Vendor Name', comment = 'FRA="Nom fournisseur"';
                    Editable = false;
                }
                field("Mini Amount";
                RecGVendor."BC6_Mini Amount")
                {
                    Caption = 'Mini Amount', comment = 'FRA="Montant mini franco"';
                    Editable = false;
                }
                field("RecGItem.Inventory"; RecGItem.Inventory)
                {
                    Caption = 'Qty In Inventory', comment = 'FRA="Qté en stock"';
                    Editable = false;
                }
                field("Qty. on Sales Order";
                RecGItem."Qty. on Sales Order")
                {
                    Caption = 'Qty. on Sales Order', comment = 'FRA="Quantité sur commande vente"';
                    Editable = false;
                    Visible = false;
                }
                field("Qty. on Purch. Order";
                RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Qty. on Purchase Order', comment = 'FRA="Quantité sur commande achat"';
                    Editable = false;
                    Visible = false;
                }
                field("Stock prévisionnel";
                RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Stock prévisionnel', comment = 'FRA="Stock prévisionnel"';
                    Editable = false;
                    Visible = false;
                }
                field("Sell-to Customer Name";
                RecGSalesHeader."Sell-to Customer Name")
                {
                    Caption = 'Customer Name', comment = 'FRA=""Nom du client ""';
                    Editable = false;
                    Visible = true;
                }
                field("To Prepare"; Rec."BC6_To Prepare")
                {
                }
                field("Qty. To Order"; Rec."BC6_Qty. To Order")
                {
                }
                field("To Order"; Rec."BC6_To Order")
                {
                    Caption = 'To Order', comment = 'FRA="A commander"';
                }
                field("Purch. Document Type"; Rec."BC6_Purch. Document Type")
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
                Caption = 'Functions', comment = 'FRA="Fonctions"';
                action("Create Purchase Orders")
                {
                    Caption = 'Create Purchase Orders', comment = 'FRA="Créer commandes achat"';
                    Image = Purchasing;
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
                        // Apply Filters

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
                                IF NOT Rec.RECORDLEVELLOCKING THEN
                                    RecLPurchHeader.LOCKTABLE(TRUE, TRUE); // Only version check
                                RecLSalesLines.LOCKTABLE();
                                REPEAT
                                    DiaGWindow.UPDATE(1, STRSUBSTNO('%1 %2', RecLSalesLines."Document Type",
                                                                           RecLSalesLines."Document No."));
                                    DiaGWindow.UPDATE(2, RecLSalesLines."No.");
                                    IF CodLVendorNo <> RecLSalesLines."BC6_Buy-from Vendor No." THEN BEGIN
                                        // Create Purchase Header
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

                                        // Insert Line
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

                                        // If Multi Sales Lines : No Link
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
                                    RecLSalesLines."BC6_Purchase Receipt Date" := RecLPurchLine."Expected Receipt Date";
                                    RecLSalesLines."BC6_Qty. To Order" := 0;
                                    RecLSalesLines."BC6_To Order" := FALSE;
                                    TempRecLSalesLine.TRANSFERFIELDS(RecLSalesLines);
                                    TempRecLSalesLine.INSERT(FALSE);
                                    RecLSalesLines.MODIFY(FALSE);

                                UNTIL RecLSalesLines.NEXT() = 0;
                                // Insert extended text


                                TempRecLSalesLine.RESET();
                                IF TempRecLSalesLine.FIND('-') THEN
                                    REPEAT
                                        RecLPurchLine2.RESET();
                                        RecLPurchLine2.SETRANGE("Document Type", TempRecLSalesLine."BC6_Purch. Document Type"::Order);
                                        RecLPurchLine2.SETRANGE("Document No.", TempRecLSalesLine."BC6_Purch. Order No.");
                                        RecLPurchLine2.SETRANGE("Line No.", TempRecLSalesLine."BC6_Purch. Line No.");
                                        IF RecLPurchLine2.FIND('-') THEN
                                            REPEAT
                                                InsertExtendedText(TRUE, RecLPurchLine2);
                                                RecLPurchLine2.MODIFY(FALSE);
                                            UNTIL RecLPurchLine2.NEXT() = 0;
                                    UNTIL TempRecLSalesLine.NEXT() = 0;
                            END;

                            DiaGWindow.CLOSE();


                        END;

                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action(RAZ)
            {
                Caption = 'RAZ', comment = 'FRA="RAZ"';
                Promoted = true;
                PromotedCategory = Process;
                image = UpdateDescription;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    IF Rec.FIND('-') THEN BEGIN
                        REPEAT
                            CurrPage.UPDATE(FALSE);
                            Rec."BC6_Qty. To Order" := 0;
                            CurrPage.UPDATE(TRUE);
                        UNTIL Rec.NEXT() = 0;
                        Rec.FIND('-');
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecGSalesHeader.RESET();
        IF RecGSalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN;

        RecGItem.RESET();
        IF RecGItem.GET(Rec."No.") THEN
            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);


        RecGVendor.RESET();
        RecGVendor.INIT();
        IF RecGVendor.GET(Rec."BC6_Buy-from Vendor No.") THEN;

        // voir si c'est une commande en demande de prix  (Quote Order)
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

        TempRecLSalesLine: Record "Sales Line" temporary;
        RecGVendor: Record Vendor;
        BooGExcDropShipFilter: Boolean;
        BooGExcQuoteFilter: Boolean;
        BooGExcShipOrders: Boolean;
        BooGNegForecastInv: Boolean;
        BooGNotGroupByItem: Boolean;
        BooGOneTimeOrdering: Boolean;
        CodGVendorFilter: Code[20];
        GPurchCost: Decimal;
        DiaGWindow: Dialog;
        CstGText50001: Label 'Item No.          #2##########\', comment = 'FRA="N° article traité           #2###########\"';
        CstGText50002: Label 'Purchase Header          #2##########\', comment = 'FRA="En-tête achat               #3###########\"';
        CstGText50003: Label 'Purchase Lines             #3###########\', comment = 'FRA="Lignes achat                #4###########\"';
        CstGText50006: Label 'Created lines                 #1##########\', comment = 'FRA="Traitement des lignes       #1###########\"';
        OptGSort: Option;
        TxtGShipmentDateFilter: Text[50];

    procedure SetRecFilters()
    var
        RecLSalesSetup: Record "Sales & Receivables Setup";
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("BC6_Purcha. Code Grouping Line");
        Rec.SETRANGE("Purchasing Code", RecLSalesSetup."BC6_Purcha. Code Grouping Line");

        // Exclude Orders Already Send
        IF BooGOneTimeOrdering THEN BEGIN
            //SETFILTER("Purch. Order No.",'%1',''); //TODO 39 21/01/08
            Rec.SETFILTER("BC6_Purch. Document Type", '<>%1', Rec."BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            Rec.SETRANGE("BC6_Purch. Order No.");
            Rec.SETRANGE("BC6_Purch. Document Type");
        END;

        // Exclude Sales Quotes
        IF BooGExcQuoteFilter THEN BEGIN
            Rec.SETFILTER("BC6_Purch. Document Type", '%1', Rec."BC6_Purch. Document Type"::Quote);            //TODO 39 21/01/08
            Rec.SETFILTER("BC6_Purch. Order No.", '%1', '');                                           //TODO 39 21/01/08
        END ELSE BEGIN
            IF NOT BooGOneTimeOrdering THEN BEGIN
                Rec.SETRANGE("BC6_Purch. Document Type");
                Rec.SETRANGE("BC6_Purch. Order No.");
            END;
        END;


        // Exclude Drop Shipment
        IF BooGExcDropShipFilter THEN
            Rec.SETRANGE("Drop Shipment", FALSE)
        ELSE
            Rec.SETRANGE("Drop Shipment");

        // Negative Forecast Inventory (Stock prévisionnel négatif)
        IF CodGVendorFilter <> '' THEN
            Rec.SETRANGE("BC6_Buy-from Vendor No.", CodGVendorFilter)
        ELSE
            Rec.SETRANGE("BC6_Buy-from Vendor No.");

        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
            Rec.SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            Rec.SETRANGE("BC6_To Prepare");

        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
            Rec.SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            Rec.SETRANGE("Shipment Date");

        Rec.CLEARMARKS();
        IF BooGNegForecastInv THEN BEGIN
            IF NOT Rec.ISEMPTY THEN BEGIN
                IF Rec.FINDSET() THEN
                    REPEAT
                        IF RecGItem.GET(Rec."No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            Rec.MARK(TRUE);
                    UNTIL Rec.NEXT() = 0;
                Rec.MARKEDONLY(TRUE);
                Rec.FINDFIRST();
            END;

        END ELSE
            Rec.MARKEDONLY(FALSE);

        CurrPage.UPDATE(FALSE);

    end;



    procedure InsertExtendedText(Unconditionally: Boolean; var RecLPurch: Record "Purchase Line")
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(RecLPurch, Unconditionally) THEN BEGIN
            COMMIT();
            TransferExtendedText.InsertPurchExtText(RecLPurch);
            FunctionMgt.InsertPurchExtTextSpe(RecLPurch);
        END;
    end;

    local procedure BooGExcDropShipFilterOnAfterVa()
    begin
        OptGSortOnAfterValidate();
        IF BooGExcDropShipFilter THEN
            Rec.SETRANGE("Drop Shipment", FALSE)
        ELSE
            Rec.SETRANGE("Drop Shipment");
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BooGExcQuoteFilterOnAfterValid()
    begin
        IF BooGExcQuoteFilter THEN BEGIN
            Rec.SETFILTER("BC6_Purch. Document Type", '%1', Rec."BC6_Purch. Document Type"::Quote);
            Rec.SETFILTER("BC6_Purch. Order No.", '%1', '');
        END ELSE BEGIN
            IF NOT BooGOneTimeOrdering THEN BEGIN
                Rec.SETRANGE("BC6_Purch. Document Type");
                Rec.SETRANGE("BC6_Purch. Order No.");
            END;
        END;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BooGNegForecastInvOnAfterValid()
    begin
        Rec.CLEARMARKS();
        IF BooGNegForecastInv THEN BEGIN
            IF NOT Rec.ISEMPTY THEN BEGIN
                IF Rec.FINDSET() THEN
                    REPEAT
                        IF RecGItem.GET(Rec."No.") THEN
                            RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order", RecGItem."Qty. on Sales Order", RecGItem.Inventory);
                        IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                            Rec.MARK(TRUE);
                    UNTIL Rec.NEXT() = 0;
                Rec.MARKEDONLY(TRUE);
                Rec.FINDFIRST();
            END;

        END ELSE
            Rec.MARKEDONLY(FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CodGVendorFilterOnAfterValidat()
    begin
        IF CodGVendorFilter <> '' THEN
            Rec.SETRANGE("BC6_Buy-from Vendor No.", CodGVendorFilter)
        ELSE
            Rec.SETRANGE("BC6_Buy-from Vendor No.");
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BooGExcShipOrdersOnAfterValida()
    begin
        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
            Rec.SETRANGE("BC6_To Prepare", FALSE)
        ELSE
            Rec.SETRANGE("BC6_To Prepare");
        CurrPage.UPDATE(FALSE);
    end;

    local procedure TxtGShipmentDateFilterOnAfterV()
    begin
        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
            Rec.SETFILTER("Shipment Date", TxtGShipmentDateFilter)
        ELSE
            Rec.SETRANGE("Shipment Date");

        CurrPage.UPDATE(FALSE);
    end;

    local procedure OptGSortOnAfterValidate()
    begin
        IF BooGExcDropShipFilter THEN BEGIN
            CASE OptGSort OF
                0:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment");
                1:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "BC6_Buy-from Vendor No.", "Shipment Date");
                2:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "Drop Shipment", "BC6_Buy-from Vendor No.", "No.", "Shipment Date");
            END;
        END ELSE BEGIN
            CASE OptGSort OF
                0:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code");
                1:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "BC6_Buy-from Vendor No.", "Shipment Date");
                2:
                    Rec.SETCURRENTKEY("Document Type", Type, "Outstanding Quantity", "Purchasing Code", "BC6_Buy-from Vendor No.", "No.", "Shipment Date");
            END;
        END;


    end;

    local procedure BooGOneTimeOrderingOnAfterVali()
    begin
        // Exclude Orders Already Send
        IF BooGOneTimeOrdering THEN BEGIN
            Rec.SETFILTER("BC6_Purch. Document Type", '<>%1', Rec."BC6_Purch. Document Type"::Order);
        END ELSE BEGIN
            Rec.SETRANGE("BC6_Purch. Order No.");
            Rec.SETRANGE("BC6_Purch. Document Type");
        END;

        CurrPage.UPDATE(FALSE);
    end;
}

