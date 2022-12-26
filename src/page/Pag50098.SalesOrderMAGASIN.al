page 50098 "BC6_Sales Order (MAGASIN)"
{
    Caption = 'Sales Order', Comment = 'FRA="Commande vente"';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        _SelltoCustomerNoOnAfterValidate();
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City', Comment = 'FRA="CP/Ville donneur d''ordre"';
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Fax No."; "BC6_Sell-to Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; "Your Reference")
                {
                    Caption = 'Votre référence', Comment = 'FRA="Votre référence"';
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field(ID; ID)
                {
                    Caption = 'User ID', Comment = 'FRA="Code Utilisateur"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'FRA="Facturation"';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidate;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City', Comment = 'FRA="CP/Ville"';
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Advance Payment"; "BC6_Advance Payment")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments by Order"; "BC6_Combine Shipments by Order")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', Comment = 'FRA="Livraison"';
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City', Comment = 'FRA="CP/Ville destinataire"';
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; "Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; "Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Customer Details FactBox 1"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
                ApplicationArea = All;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Resource Details FactBox 1"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Resource Details FactBox 2"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder', Comment = 'FRA="&Commande"';
                action(Statistics)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SalesSetup.GET;
                        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.SalesLines.PAGE.CalcInvDisc;
                            COMMIT
                        END;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments', Comment = 'FRA="Li&vraisons"';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices', Comment = 'FRA="F&actures"';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions', Comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                separator(Action172)
                {
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines', Comment = 'FRA="Lignes expédition mag."';
                    Image = WarehouseRegisters;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                separator(Action176)
                {
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning', Comment = 'FRA="Pla&nification"';
                    Image = Planning;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder("No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising', Comment = 'FRA="Pro&messe de livraison"';
                    Image = OrderPromising;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", "Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", "No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment', Comment = 'FRA="Livraison &directe"';
                    Image = Sales;
                    action("BC6_Purchase &Order")
                    {
                        Caption = 'Purchase &Order', Comment = 'FRA="&Commande achat"';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order', Comment = 'FRA="C&ommande spéciale"';
                    Image = Sales;
                    action("Purchase &Order")
                    {
                        Caption = 'Purchase &Order', Comment = 'FRA="&Commande achat"';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenSpecialPurchOrderForm;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount', Comment = 'FRA="C&alculer remise facture"';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action("Get Price")
                {
                    Caption = 'Get Price', Comment = 'FRA="Extraire prix"';
                    Ellipsis = true;
                    Image = SalesPrices;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount', Comment = 'FRA="Ex&traire remise ligne"';
                    Ellipsis = true;
                    Image = Discount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowLineDisc
                    end;
                }
                separator(Avtion177)
                {
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM', Comment = 'FRA="&Eclater nomenclature"';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts', Comment = 'FRA="Insérer textes étend&us"';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator(Action192)
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes', Comment = 'FRA="Extraire &codes vente client std"';
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking', Comment = 'FRA="Chaînage"';
                    Image = OrderTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowTracking;
                    end;
                }
                separator(Action195)
                {
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items', Comment = 'FRA="Articles &non stockés"';
                    Image = NonStockItem;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT UpdateAllowed THEN
                            EXIT;

                        CurrPage.SalesLines.PAGE.ShowNonstockItems;
                    end;
                }
                separator(Action174)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document', Comment = 'FRA="Copier &document"';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document', Comment = 'FRA="Archi&ver document"';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines', Comment = 'FRA="Déplacer lignes né&gatives"';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator(Action175)
                {
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment', Comment = 'FRA="Créer e&xpédition magasin"';
                    Image = CreateWarehousePick;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FunctionMgt: Codeunit "BC6_Functions Mgt";
                    begin
                        FunctionMgt.BC6_CreateInvtPutAwayPick();
                    end;
                }
                separator(Action178)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease', Comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Sales Document";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Re&open")
                {
                    Caption = 'Re&open', Comment = 'FRA="R&ouvrir"';
                    Image = ReOpen;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.Reopen(Rec);
                    end;
                }
                separator(Action180)
                {
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    Caption = 'Send IC Sales Order Cnfmn.', Comment = 'FRA="Confirmation envoi commande vente IC"';
                    Image = SendElectronicDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                action("Test Report")
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post (Yes/No)";
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("&Valider Livraison")
                {
                    Caption = '&Valider Livraison', Comment = 'FRA="&Valider Livraison"';
                    Image = PostedReceipt;
                    RunObject = Codeunit "BC6_FotoWin Management";
                    ApplicationArea = All;
                }
                action("&Valider Facture")
                {
                    Caption = '&Valider Facture', Comment = 'FRA="&Valider Facture"';
                    Image = PostedVendorBill;
                    RunObject = Codeunit "BC6_Reconstitue lettrage CLI";
                    ApplicationArea = All;
                }
            }
            group("&Print")
            {
                Caption = '&Print', Comment = 'FRA="Im&primer"';
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation', Comment = 'FRA="Confirmation de commande"';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                            1:
                                DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                            2:
                                EnvoiMail;
                        END;
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order', Comment = 'FRA="Edition Bon Prépa"';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecGSalesHeader: Record "Sales Header";
                    begin
                        RecGSalesHeader.RESET;
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "No.");
                        RecGSalesHeader.FIND('-');

                        REPORT.RUNMODAL(REPORT::"BC6_Preparation NAVIDIIGEST1", TRUE, TRUE, RecGSalesHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnVisible := TRUE;
        BillToCommentBtnVisible := TRUE;
        BillToCommentPictVisible := TRUE;
        SalesHistoryBtnVisible := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            FILTERGROUP(0);
        END;

        SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.', Comment = 'FRA="Impossible d''exécuter cette fonction quand vous êtes en mode visualisation seule."';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order";
        "-NSC1.01-": Integer;
        Livraison: Record "Shipment Method";
        Frais: Record "Item Charge";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        cust: Record Customer;
        nameF: Text[250];
        Mail: Codeunit Mail;
        "Sales & Receivables Setup": Record "Sales & Receivables Setup";
        Excel: Boolean;
        PreparationNAVIDIIGEST: Report 50097;
        STR3: Label 'Impimer le document', Comment = 'FRA="Impimer le document"';
        STR4: Label 'Envoyer le document par E-Mail', Comment = 'FRA="Envoyer le document par E-Mail"';
        STR5: Label 'Envoyer le document par Fax', Comment = 'FRA="Envoyer le document par Fax"';
        Text001: Label '';
        Text004: Label '';
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        SalesHistoryStnVisible: Boolean;
        Text19070588: Label 'Sell-to Customer', Comment = 'FRA="Donneur d''ordre"';
        Text19069283: Label 'Bill-to Customer', Comment = 'FRA="Client facturé"';
        ChangeExchangeRate: Page "Change Exchange Rate";

    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := "Sell-to Customer No." <> "Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
    end;





    procedure test()
    begin
    end;


    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile;
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
    end;


    procedure OpenFile()
    begin
        /*//EMAIL NSC00.01 SBH [005] Envoi document
        FileDialog.DialogTitle('Envoi'+' '+CurrForm.CAPTION);
        FileDialog.Filter := Text004;
        SalesSetup.GET;
        FileDialog.FileName := '';
        FileDialog.InitDir(SalesSetup.Repertoire);
        FileDialog.Flags := 4096 + 2048; // vérification de l'existence du fichier, code qui suit inutile.
        FileDialog.ShowOpen;
        nameF:=FileDialog.FileName;
        IF nameF='' THEN
          BEGIN
            Excel := FALSE;
            EXIT;
          END;
          //Fin EMAIL NSC00.01 SBH [005] Envoi document
        */

    end;

    local procedure _SelltoCustomerNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;
}

