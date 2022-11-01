page 50015 "Sales Order Lines"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 09/11/2007 : Achats groupés
    // 
    //                                          - Creation
    // 
    // //>>CNE2.05
    // FEP-ACHAT-200706_18_A.002:LY 09/01/2008 : - Add Field "Purch. Document Type"
    //                                           - Filter Sales Line on Purchasing Code
    // FEP-ACHAT-200706_18_A.003:LY 28/01/2008 : - Fix Filter bug correction
    // FEP-ACHAT-200706_18_A.004:LY 19/02/2008 : - Optmize
    // FEP-ACHAT-200706_18_A.005:LY 12/03/2008 : - DeleteAllowed -> No
    // 
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Do not calculate line discount
    // 
    // //>>MODIF HL1.06
    // I011762.001 DO.ALMI 22/06/09 : - Add extended text when create order
    //                                      >> Onpush() Créer commandes achat
    //                                      New function InsertExtendedText
    // 
    // //>>MODIF HL1.07
    // I012437.001 DO.ALMI 26/06/09 : - Add condition Group lines with same items
    //                                      >> Onpush() Créer commandes achat
    // //>> MODIF HL 28/01/2010 SU-LALE cf appel I016274
    //                          Modif C/AL Code dans trigger Onpush() Créer commandes achat
    // 
    // //>> CNE6.01
    // TDL:EC11 12.12.2014 : Not Group By Item
    //                       New Check Box : BooGNotGroupByItem
    //                       Action : Run Codeunit 50006
    // 
    // //>>TI301087 : RO : 08/12/2015
    //                     Change SORTING in property SourceTableView
    //                     Add C/AL Code in triggers
    //                                         BooGExcDropShipFilterOnAfterVa
    //                                         BooGExcQuoteFilterOnAfterValid
    //                                         BooGNegForecastInvOnAfterValid
    //                                         CodGVendorFilterOnAfterValidat
    //                                         BooGExcShipOrdersOnAfterValida
    //                                         TxtGShipmentDateFilterOnAfterV
    //                                         OptGSortOnAfterValidate
    //                                         BooGOneTimeOrderingOnAfterVali
    //                     Visible = FALSE for Columns
    //                                         RecGItem.Inventory
    //                                         RecGItem."Qty. on Sales Order"
    //                                         RecGItem."Qty. on Purch. Order"
    //                                         RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order"
    // 
    // ------------------------------------------------------------------------

    Caption = 'Sales Order Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table37;
    SourceTableView = SORTING (Document Type, Document No., Line No.)
                      WHERE (Document Type=FILTER(Order),
                            Type=FILTER(Item),
                            Outstanding Quantity=FILTER(>0));

    layout
    {
        area(content)
        {
            group("Filters :")
            {
                Caption = 'Filters :';
                field(OptGSort;OptGSort)
                {
                    Caption = 'Sorting';
                    OptionCaption = 'Document No. - Line No.,Vendor No. - Shipment Date,Vendor No. - No. - Shipment Date';

                    trigger OnValidate()
                    begin
                        OptGSortOnAfterValidate;
                    end;
                }
                field(BooGExcDropShipFilter;BooGExcDropShipFilter)
                {
                    Caption = 'Exclude Drop Shipments';

                    trigger OnValidate()
                    begin
                        BooGExcDropShipFilterOnAfterVa;
                    end;
                }
                field(BooGExcQuoteFilter;BooGExcQuoteFilter)
                {
                    Caption = 'Exclude Sales Quotes';

                    trigger OnValidate()
                    begin
                        BooGExcQuoteFilterOnAfterValid;
                    end;
                }
                field(BooGOneTimeOrdering;BooGOneTimeOrdering)
                {
                    Caption = 'Exclude Orders Already Send';

                    trigger OnValidate()
                    begin
                        BooGOneTimeOrderingOnAfterVali;
                    end;
                }
                field(BooGNegForecastInv;BooGNegForecastInv)
                {
                    Caption = 'Negative Forecast Inventory';

                    trigger OnValidate()
                    begin
                        BooGNegForecastInvOnAfterValid;
                    end;
                }
                field(CodGVendorFilter;CodGVendorFilter)
                {
                    Caption = 'Vendor No. Filter';
                    TableRelation = Vendor.No.;

                    trigger OnValidate()
                    begin
                        CodGVendorFilterOnAfterValidat;
                    end;
                }
                field(BooGExcShipOrders;BooGExcShipOrders)
                {
                    Caption = 'Exclude Shipment Orders';

                    trigger OnValidate()
                    begin
                        BooGExcShipOrdersOnAfterValida;
                    end;
                }
                field(TxtGShipmentDateFilter;TxtGShipmentDateFilter)
                {
                    Caption = 'ShipmentDateFilter';

                    trigger OnValidate()
                    begin
                        TxtGShipmentDateFilterOnAfterV;
                    end;
                }
                field(BooGNotGroupByItem;BooGNotGroupByItem)
                {
                    Caption = 'Not group by Item';
                }
            }
            repeater()
            {
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Outstanding Quantity";"Outstanding Quantity")
                {
                    Editable = false;
                }
                field("Pick Qty.";"Pick Qty.")
                {
                }
                field("Quantity Shipped";"Quantity Shipped")
                {
                    Editable = false;
                }
                field("Location Code";"Location Code")
                {
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                    Caption = 'Requested Receipt Date';
                    Editable = false;
                }
                field(RecGSalesHeader.ID;RecGSalesHeader.ID)
                {
                    Caption = 'CNE Spokesman Name';
                    Editable = false;
                }
                field(RecGSalesHeader."Purchaser Comments";RecGSalesHeader."Purchaser Comments")
                {
                    Caption = 'Purchaser Comments';
                }
                field(RecGSalesHeader."Warehouse Comments";RecGSalesHeader."Warehouse Comments")
                {
                    Caption = 'Warehouse Comments';
                }
                field("Drop Shipment";"Drop Shipment")
                {
                    Editable = false;
                }
                field("Document Type";"Document Type")
                {
                    Editable = false;
                }
                field("Document No.";"Document No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Shipment Date";"Shipment Date")
                {
                    Editable = false;
                }
                field(FORMAT(RecGSalesHeader."Shipping Advice");FORMAT(RecGSalesHeader."Shipping Advice"))
                {
                    Caption = 'Shipping Advice';
                    Editable = false;
                }
                field("Purch. Order No.";"Purch. Order No.")
                {
                    Editable = false;
                }
                field("Purchase cost";"Purchase cost")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(RecGVendor.Name;RecGVendor.Name)
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field(RecGVendor."Mini Amount";RecGVendor."Mini Amount")
                {
                    Caption = 'Mini Amount';
                    Editable = false;
                }
                field(RecGItem.Inventory;RecGItem.Inventory)
                {
                    Caption = 'Qty In Inventory';
                    Editable = false;
                }
                field(RecGItem."Qty. on Sales Order";RecGItem."Qty. on Sales Order")
                {
                    Caption = 'Qty. on Sales Order';
                    Editable = false;
                    Visible = false;
                }
                field(RecGItem."Qty. on Purch. Order";RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Qty. on Purchase Order';
                    Editable = false;
                    Visible = false;
                }
                field(RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order";RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order")
                {
                    Caption = 'Stock prévisionnel';
                    Editable = false;
                    Visible = false;
                }
                field(RecGSalesHeader."Sell-to Customer Name";RecGSalesHeader."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                    Visible = true;
                }
                field("To Prepare";"To Prepare")
                {
                }
                field("Qty. To Order";"Qty. To Order")
                {
                }
                field("To Order";"To Order")
                {
                    Caption = 'To Order';
                }
                field("Purch. Document Type";"Purch. Document Type")
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
                        RecLSalesLines: Record "37";
                        RecLSalesSetup: Record "311";
                        RecLPurchLine: Record "39";
                        RecLPurchHeader: Record "38";
                        CodLVendorNo: Code[20];
                        CodLItemNo: Code[20];
                        CodLCustomer: Code[20];
                        IntLLineNo: Integer;
                        DecLQuantity: Decimal;
                        "<<<PRODWARE>>>": Integer;
                        RecLPurchLine2: Record "39";
                    begin
                        // Apply Filters

                        IF BooGNotGroupByItem THEN
                          CODEUNIT.RUN(50006,Rec)
                        ELSE
                          BEGIN

                        //>>FEP-ACHAT-200706_18_A.002:GR
                        DiaGWindow.OPEN(
                              CstGText50006 + CstGText50001 +
                              CstGText50002 + CstGText50003 );

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
                        RecLSalesLines.SETCURRENTKEY("To Order","Buy-from Vendor No.","No.","Purchase cost","Qty. To Order");
                        //<< MODIF HL 28/01/2010 SU-LALE cf appel I016274
                        //<<FEP-ACHAT-200706_18_A.004
                        RecLSalesLines.SETFILTER(RecLSalesLines."Buy-from Vendor No.",'<>%1','');
                        RecLSalesLines.SETFILTER(RecLSalesLines."Qty. To Order",'<>%1',0);
                        RecLSalesLines.SETRANGE(RecLSalesLines."To Order",TRUE);

                        //>>FEP-ACHAT-200706_18_A.004
                        //IF RecLSalesLines.FIND('-') THEN BEGIN
                        IF RecLSalesLines.FINDSET THEN BEGIN
                        //<<FEP-ACHAT-200706_18_A.004
                          RecLPurchLine.LOCKTABLE;
                          IF NOT RECORDLEVELLOCKING THEN
                            RecLPurchHeader.LOCKTABLE(TRUE,TRUE); // Only version check
                          RecLSalesLines.LOCKTABLE;
                          REPEAT
                            DiaGWindow.UPDATE(1,STRSUBSTNO('%1 %2',RecLSalesLines."Document Type",
                                                                   RecLSalesLines."Document No."));
                            DiaGWindow.UPDATE(2,RecLSalesLines."No.");
                            IF CodLVendorNo <> RecLSalesLines."Buy-from Vendor No." THEN BEGIN
                              // Create Purchase Header
                              RecLPurchHeader.INIT;
                              RecLPurchHeader.VALIDATE("No.",'');
                              RecLPurchHeader.VALIDATE("Document Type",RecLSalesLines."Document Type");
                              RecLPurchHeader.INSERT(TRUE);
                              RecLPurchHeader.VALIDATE("Document Date",WORKDATE);
                              RecLPurchHeader.VALIDATE("Buy-from Vendor No.",RecLSalesLines."Buy-from Vendor No.");
                              RecLPurchHeader.MODIFY(TRUE);
                              DiaGWindow.UPDATE(3,RecLPurchHeader."No.");

                              CodLVendorNo := RecLSalesLines."Buy-from Vendor No.";
                              IntLLineNo := 10000;
                              CodLItemNo := '';
                              DecLQuantity := 0;
                            END;

                            // Group lines with same items
                        //>>I012437.001
                            //IF (CodLItemNo <> RecLSalesLines."No.")
                            IF (CodLItemNo <> RecLSalesLines."No.") OR ((GPurchCost <> RecLSalesLines."Purchase cost") AND (
                               CodLItemNo = RecLSalesLines."No."))
                        //<<I012437.001
                              THEN BEGIN

                              // Insert Line
                              RecLPurchLine.INIT;
                              RecLPurchLine.VALIDATE("Document Type" ,RecLPurchLine."Document Type"::Order);
                              RecLPurchLine.VALIDATE("Document No." ,RecLPurchHeader."No.");
                              RecLPurchLine.VALIDATE("Line No.",IntLLineNo);
                              RecLPurchLine.VALIDATE(Type,RecLSalesLines.Type);
                              RecLPurchLine.VALIDATE("No.",RecLSalesLines."No.");
                              RecLPurchLine.VALIDATE("Variant Code",RecLSalesLines."Variant Code");
                              RecLPurchLine.VALIDATE("Location Code",RecLSalesLines."Location Code");
                              RecLPurchLine.VALIDATE("Unit of Measure Code",RecLSalesLines."Unit of Measure Code");
                              IF (RecLPurchLine.Type = RecLPurchLine.Type::Item) AND (RecLPurchLine."No." <> '') THEN
                                RecLPurchLine.UpdateUOMQtyPerStockQty;
                              RecLPurchLine.VALIDATE("Expected Receipt Date",RecLSalesLines."Shipment Date");
                              // RecLPurchLine.VALIDATE("Bin Code",RecLSalesLines."Bin Code");
                              RecLPurchLine.VALIDATE(Quantity,RecLSalesLines."Qty. To Order");
                              RecLPurchLine.VALIDATE("Return Reason Code",RecLSalesLines."Return Reason Code");
                              RecLPurchLine.VALIDATE("Direct Unit Cost",RecLSalesLines."Purchase cost");
                              RecLPurchLine.VALIDATE("Purchasing Code",RecLSalesLines."Purchasing Code");

                              // If Multi Sales Lines : No Link
                              RecLPurchLine.VALIDATE("Sales No.",RecLSalesLines."Document No.");
                              RecLPurchLine.VALIDATE("Sales Line No.",RecLSalesLines."Line No.");
                              RecLPurchLine.VALIDATE("Sales Document Type",RecLSalesLines."Document Type");

                              //>>CorrectionSOBI
                              RecLPurchLine.VALIDATE("Line Discount %",0);
                              //<<CorrectionSOBI

                              RecLPurchLine.INSERT(TRUE);
                              CodLItemNo := RecLSalesLines."No.";
                              IntLLineNo += 10000;
                              DecLQuantity := RecLSalesLines."Qty. To Order";
                         //>>I012437.001
                              GPurchCost := RecLSalesLines."Purchase cost";
                         //<<I012437.001
                            END ELSE BEGIN
                              DecLQuantity += RecLSalesLines."Qty. To Order";

                              // If Multi Sales Lines : No Link
                              RecLPurchLine.VALIDATE("Sales No.",'');
                              RecLPurchLine.VALIDATE("Sales Line No.",0);
                              RecLPurchLine.VALIDATE(Quantity,DecLQuantity);
                              //almi
                              RecLPurchLine.VALIDATE("Direct Unit Cost",RecLSalesLines."Purchase cost");
                              RecLPurchLine.MODIFY(TRUE);

                              DiaGWindow.UPDATE(4,RecLSalesLines."No.");

                            END;

                            RecLSalesLines."Purch. Document Type" := RecLSalesLines."Purch. Document Type"::Order;
                            RecLSalesLines."Purch. Order No." := RecLPurchLine."Document No.";
                            RecLSalesLines."Purch. Line No." := RecLPurchLine."Line No.";
                            //>>
                            RecLSalesLines."Purchase Receipt Date" := RecLPurchLine."Expected Receipt Date";
                            //<<
                            RecLSalesLines."Qty. To Order" := 0;
                            RecLSalesLines."To Order" := FALSE;
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
                          IF RecLSalesLineTmp.FIND('-') THEN REPEAT
                            RecLPurchLine2.RESET;
                            RecLPurchLine2.SETRANGE("Document Type",RecLSalesLineTmp."Purch. Document Type"::Order);
                            RecLPurchLine2.SETRANGE("Document No.",RecLSalesLineTmp."Purch. Order No.");
                            RecLPurchLine2.SETRANGE("Line No.",RecLSalesLineTmp."Purch. Line No.");
                            IF RecLPurchLine2.FIND('-') THEN REPEAT
                              InsertExtendedText(TRUE,RecLPurchLine2);
                              RecLPurchLine2.MODIFY(FALSE);
                            UNTIL RecLPurchLine2.NEXT=0;
                          UNTIL RecLSalesLineTmp.NEXT=0;
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
                    IF FIND('-') THEN
                      BEGIN
                      REPEAT
                        CurrPage.UPDATE(FALSE);
                        "Qty. To Order" := 0;
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
        IF RecGSalesHeader.GET("Document Type","Document No.") THEN;

        RecGItem.RESET;
        IF RecGItem.GET("No.") THEN
          RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order",RecGItem."Qty. on Sales Order",RecGItem.Inventory);


        RecGVendor.RESET;
        RecGVendor.INIT;
        IF RecGVendor.GET("Buy-from Vendor No.") THEN;

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
        RecGSalesHeader: Record "36";
        RecGItem: Record "27";
        RecGVendor: Record "23";
        BooGExcDropShipFilter: Boolean;
        RecGPurchasing: Record "5721";
        BooGExcQuoteFilter: Boolean;
        BooGNegForecastInv: Boolean;
        BooGExcShipOrders: Boolean;
        BooGOneTimeOrdering: Boolean;
        CodGVendorFilter: Code[20];
        TxtGShipmentDateFilter: Text[50];
        OptGSort: Option;
        DiaGWindow: Dialog;
        "--Var Txt--": ;
        CstGText50006: Label 'Created lines                 #1##########\';
        CstGText50001: Label 'Item No.          #2##########\';
        CstGText50002: Label 'Purchase Header          #2##########\';
        CstGText50003: Label 'Purchase Lines             #3###########\';
        "<<<PRODWARE>>>": Integer;
        RecLSalesLineTmp: Record "37" temporary;
        GPurchCost: Decimal;
        BooGNotGroupByItem: Boolean;

    [Scope('Internal')]
    procedure SetRecFilters()
    var
        RecLSalesSetup: Record "311";
    begin
        //>>FEP-ACHAT-200706_18_A.002:GR
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("Purchasing Code Grouping Line");
        SETRANGE("Purchasing Code",RecLSalesSetup."Purchasing Code Grouping Line");
        
        // Exclude Orders Already Send
        IF BooGOneTimeOrdering THEN BEGIN
          //SETFILTER("Purch. Order No.",'%1',''); //TODO 39 21/01/08
          SETFILTER("Purch. Document Type",'<>%1',"Purch. Document Type"::Order);
        END ELSE BEGIN
          SETRANGE("Purch. Order No.");
          SETRANGE("Purch. Document Type");
        END;
        
        // Exclude Sales Quotes
        IF BooGExcQuoteFilter THEN BEGIN
          SETFILTER("Purch. Document Type",'%1',"Purch. Document Type"::Quote);            //TODO 39 21/01/08
          SETFILTER("Purch. Order No.",'%1','');                                           //TODO 39 21/01/08
        END ELSE BEGIN
          IF NOT BooGOneTimeOrdering THEN BEGIN
            SETRANGE("Purch. Document Type");
            SETRANGE("Purch. Order No.");
          END;
        END;
        
        //<<FEP-ACHAT-200706_18_A.002:GR
        
        // Exclude Drop Shipment
        IF BooGExcDropShipFilter THEN
          SETRANGE("Drop Shipment",FALSE)
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
        
        // Vendor No. Filter
        IF CodGVendorFilter <> '' THEN
          SETRANGE("Buy-from Vendor No.",CodGVendorFilter)
        ELSE
          SETRANGE("Buy-from Vendor No.");
        
        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
          SETRANGE("To Prepare",FALSE)
        ELSE
          SETRANGE("To Prepare");
        
        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
          SETFILTER("Shipment Date",TxtGShipmentDateFilter)
        ELSE
          SETRANGE("Shipment Date");
        
        //>FEP-ACHAT-200706_18_A.003
        CLEARMARKS;
        IF BooGNegForecastInv THEN BEGIN
          IF NOT ISEMPTY THEN BEGIN
            IF FINDSET THEN
            REPEAT
              IF RecGItem.GET("No.") THEN
                RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order",RecGItem."Qty. on Sales Order",RecGItem.Inventory);
              IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                MARK(TRUE);
            UNTIL NEXT =0;
            MARKEDONLY(TRUE);
            FINDFIRST;
          END;
        
        END ELSE
          MARKEDONLY(FALSE);
        //<FEP-ACHAT-200706_18_A.003
        
        CurrPage.UPDATE(FALSE);

    end;

    [Scope('Internal')]
    procedure "<<<PRODWARE FUNCTIONS>>>"()
    begin
    end;

    [Scope('Internal')]
    procedure InsertExtendedText(Unconditionally: Boolean;var RecLPurch: Record "39")
    var
        TransferExtendedText: Codeunit "378";
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(RecLPurch,Unconditionally) THEN BEGIN
          COMMIT;
          TransferExtendedText.InsertPurchExtText(RecLPurch);
          TransferExtendedText.InsertPurchExtTextSpe(RecLPurch);
        END;
    end;

    local procedure BooGExcDropShipFilterOnAfterVa()
    begin
        //>>TI301087
        //SetRecFilters;
        // Exclude Drop Shipment
        OptGSortOnAfterValidate;
        IF BooGExcDropShipFilter THEN
          SETRANGE("Drop Shipment",FALSE)
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
          SETFILTER("Purch. Document Type",'%1',"Purch. Document Type"::Quote);
          SETFILTER("Purch. Order No.",'%1','');
        END ELSE BEGIN
          IF NOT BooGOneTimeOrdering THEN BEGIN
            SETRANGE("Purch. Document Type");
            SETRANGE("Purch. Order No.");
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
                RecGItem.CALCFIELDS(RecGItem."Qty. on Purch. Order",RecGItem."Qty. on Sales Order",RecGItem.Inventory);
              IF 0 > (RecGItem.Inventory - RecGItem."Qty. on Sales Order" + RecGItem."Qty. on Purch. Order") THEN
                MARK(TRUE);
            UNTIL NEXT =0;
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
        //>>TI301087
        //SetRecFilters;
        // Vendor No. Filter
        IF CodGVendorFilter <> '' THEN
          SETRANGE("Buy-from Vendor No.",CodGVendorFilter)
        ELSE
          SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;

    local procedure BooGExcShipOrdersOnAfterValida()
    begin
        //>>TI301087
        //SetRecFilters;
        // Exclude Shipment Orders
        IF BooGExcShipOrders THEN
          SETRANGE("To Prepare",FALSE)
        ELSE
          SETRANGE("To Prepare");
        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;

    local procedure TxtGShipmentDateFilterOnAfterV()
    begin
        //>>TI301087
        //SetRecFilters;

        // Shipment Date Filter
        IF TxtGShipmentDateFilter <> '' THEN
          SETFILTER("Shipment Date",TxtGShipmentDateFilter)
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
        IF BooGExcDropShipFilter THEN
        BEGIN
           CASE OptGSort OF
              0 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment");
              1 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment","Buy-from Vendor No.","Shipment Date");
              2 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code","Drop Shipment","Buy-from Vendor No.","No.","Shipment Date");
           END;
        END ELSE
        BEGIN
           CASE OptGSort OF
              0 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code");
              1 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code","Buy-from Vendor No.","Shipment Date");
              2 : SETCURRENTKEY("Document Type",Type,"Outstanding Quantity","Purchasing Code","Buy-from Vendor No.","No.","Shipment Date");
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
          SETFILTER("Purch. Document Type",'<>%1',"Purch. Document Type"::Order);
        END ELSE BEGIN
          SETRANGE("Purch. Order No.");
          SETRANGE("Purch. Document Type");
        END;

        CurrPage.UPDATE(FALSE);
        //<<TI301087
    end;
}

