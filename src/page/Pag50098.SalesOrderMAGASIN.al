page 50098 "BC6_Sales Order (MAGASIN)"
{
    ApplicationArea = All;
    Caption = 'Sales Order', Comment = 'FRA="Commande vente"';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        _SelltoCustomerNoOnAfterValidate();
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Post Code/City', Comment = 'FRA="CP/Ville donneur d''ordre"';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Votre référence', Comment = 'FRA="Votre référence"';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate();
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field(ID; Rec.BC6_ID)
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'FRA="Code Utilisateur"';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'FRA="Facturation"';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidate();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Post Code/City', Comment = 'FRA="CP/Ville"';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Advance Payment"; Rec."BC6_Advance Payment")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments by Order"; Rec."BC6_Combine Shipments by Order")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', Comment = 'FRA="Livraison"';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code/City', Comment = 'FRA="CP/Ville destinataire"';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox 1"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox 1"; "Resource Details FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox 2"; "Resource Details FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
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
                    ApplicationArea = All;
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        SalesSetup.GET();
                        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.SalesLines.PAGE.CalcInvDisc();
                            COMMIT()
                        END;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments', Comment = 'FRA="Li&vraisons"';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices', Comment = 'FRA="F&actures"';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions', Comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                separator(Action172)
                {
                }
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines', Comment = 'FRA="Lignes expédition mag."';
                    Image = WarehouseRegisters;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                separator(Action176)
                {
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning', Comment = 'FRA="Pla&nification"';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RUNMODAL();
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising', Comment = 'FRA="Pro&messe de livraison"';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        TempOrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        TempOrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        TempOrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", TempOrderPromisingLine);
                    end;
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment', Comment = 'FRA="Livraison &directe"';
                    Image = Sales;
                    action("BC6_Purchase &Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order', Comment = 'FRA="&Commande achat"';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenPurchOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order', Comment = 'FRA="C&ommande spéciale"';
                    Image = Sales;
                    action("Purchase &Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order', Comment = 'FRA="&Commande achat"';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenSpecialPurchOrderForm();
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
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount', Comment = 'FRA="C&alculer remise facture"';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc();
                    end;
                }
                action("Get Price")
                {
                    ApplicationArea = All;
                    Caption = 'Get Price', Comment = 'FRA="Extraire prix"';
                    Ellipsis = true;
                    Image = SalesPrices;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowPrices()
                    end;
                }
                action("Get Li&ne Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Get Li&ne Discount', Comment = 'FRA="Ex&traire remise ligne"';
                    Ellipsis = true;
                    Image = Discount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowLineDisc()
                    end;
                }
                separator(Avtion177)
                {
                }
                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM', Comment = 'FRA="&Eclater nomenclature"';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ExplodeBOM();
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts', Comment = 'FRA="Insérer textes étend&us"';
                    Image = Text;

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
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes', Comment = 'FRA="Extraire &codes vente client std"';
                    Ellipsis = true;
                    Image = GetStandardJournal;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking', Comment = 'FRA="Chaînage"';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowTracking();
                    end;
                }
                separator(Action195)
                {
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstoc&k Items', Comment = 'FRA="Articles &non stockés"';
                    Image = NonStockItem;

                    trigger OnAction()
                    begin
                        IF NOT UpdateAllowed() THEN
                            EXIT;

                        CurrPage.SalesLines.PAGE.ShowNonstockItems();
                    end;
                }
                separator(Action174)
                {
                }
                action("Copy Document")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document', Comment = 'FRA="Copier &document"';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL();
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document', Comment = 'FRA="Archi&ver document"';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines', Comment = 'FRA="Déplacer lignes né&gatives"';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL();
                        MoveNegSalesLines.ShowDocument();
                    end;
                }
                separator(Action175)
                {
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Shipment', Comment = 'FRA="Créer e&xpédition magasin"';
                    Image = CreateWarehousePick;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    var
                        FunctionMgt: Codeunit "BC6_Functions Mgt";
                    begin
                        FunctionMgt.BC6_CreateInvtPutAwayPick_Sales(rec);
                    end;
                }
                separator(Action178)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease', Comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Sales Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open', Comment = 'FRA="R&ouvrir"';
                    Image = ReOpen;
                    Visible = false;

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
                    ApplicationArea = All;
                    Caption = 'Send IC Sales Order Cnfmn.', Comment = 'FRA="Confirmation envoi commande vente IC"';
                    Image = SendElectronicDocument;

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
                    ApplicationArea = All;
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post (Yes/No)";
                    ShortCutKey = 'F9';
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F11';
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("&Valider Livraison")
                {
                    ApplicationArea = All;
                    Caption = '&Valider Livraison', Comment = 'FRA="&Valider Livraison"';
                    Image = PostedReceipt;
                    RunObject = Codeunit "BC6_FotoWin Management";
                }
                action("&Valider Facture")
                {
                    ApplicationArea = All;
                    Caption = '&Valider Facture', Comment = 'FRA="&Valider Facture"';
                    Image = PostedVendorBill;
                    RunObject = Codeunit "BC6_Reconstitue lettrage CLI";
                }
            }
            group("&Print")
            {
                Caption = '&Print', Comment = 'FRA="Im&primer"';
                action("Order Confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Order Confirmation', Comment = 'FRA="Confirmation de commande"';
                    Image = Print;

                    trigger OnAction()
                    begin
                        CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                            1:
                                DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                            2:
                                EnvoiMail();
                        END;
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order', Comment = 'FRA="Edition Bon Prépa"';
                    Image = Print;

                    trigger OnAction()
                    var
                        RecGSalesHeader: Record "Sales Header";
                    begin
                        RecGSalesHeader.RESET();
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", Rec."Document Type");
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", Rec."No.");
                        RecGSalesHeader.FIND('-');

                        REPORT.RUNMODAL(REPORT::"BC6_Preparation NAVIDIIGEST1", TRUE, TRUE, RecGSalesHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PROCOnAfterGetCurrRecord();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnInit()
    begin
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckCreditMaxBeforeInsert();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        PROCOnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
    end;

    var
        cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        DocPrint: Codeunit "Document-Print";
        Mail: Codeunit Mail;
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        STR3: Label 'Impimer le document', Comment = 'FRA="Impimer le document"';
        STR4: Label 'Envoyer le document par E-Mail', Comment = 'FRA="Envoyer le document par E-Mail"';
        STR5: Label 'Envoyer le document par Fax', Comment = 'FRA="Envoyer le document par Fax"';
        Text000: Label 'Unable to execute this function while in view only mode.', Comment = 'FRA="Impossible d''exécuter cette fonction quand vous êtes en mode visualisation seule."';
        Text001: Label '';
        Usage: Option "Order Confirmation","Work Order";
        nameF: Text[250];

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
        DifferSellToBillTo := Rec."Sell-to Customer No." <> Rec."Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
    end;

    procedure test()
    begin
    end;

    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
    end;

    procedure OpenFile()
    begin
    end;

    local procedure _SelltoCustomerNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PROCOnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
    end;
}
