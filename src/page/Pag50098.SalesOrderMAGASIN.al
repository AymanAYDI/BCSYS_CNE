page 50098 "BC6_Sales Order (MAGASIN)"
{
    Caption = 'Sales Order';
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
                Caption = 'General';
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidate;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                }
                field("Sell-to Fax No."; "BC6_Sell-to Fax No.")
                {
                }
                field("Sell-to City"; "Sell-to City")
                {
                }
                field("Your Reference"; "Your Reference")
                {
                    Caption = 'Votre référence';
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Salesperson Code"; "Salesperson Code")
                {

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                }
                field(ID; ID)
                {
                    Caption = 'User ID';
                    Editable = false;
                }
                field(Status; Status)
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidate;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                }
                field("Bill-to City"; "Bill-to City")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Due Date"; "Due Date")
                {
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("Advance Payment"; "BC6_Advance Payment")
                {
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                }
                field("Combine Shipments by Order"; "BC6_Combine Shipments by Order")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; "Ship-to Code")
                {
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                }
                field("Ship-to City"; "Ship-to City")
                {
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                }
                field("Shipping Time"; "Shipping Time")
                {
                }
                field("Late Order Shipping"; "Late Order Shipping")
                {
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {

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
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Exit Point"; "Exit Point")
                {
                }
                field("Area"; Area)
                {
                }
            }
        }
        area(factboxes)
        {
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox 1"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox 2"; "Customer Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Approval FactBox"; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox 1"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Resource Details FactBox 2"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
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
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

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
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

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
                    Caption = 'Whse. Shipment Lines';
                    Image = WarehouseRegisters;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
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
                    Caption = 'Pla&nning';
                    Image = Planning;

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
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

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
                    Caption = 'Dr&op Shipment';
                    Image = Sales;
                    action("BC6_Purchase &Order")
                    {
                        Caption = 'Purchase &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = Sales;
                    action("Purchase &Order")
                    {
                        Caption = 'Purchase &Order';
                        Image = Document;

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
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action("Get Price")
                {
                    Caption = 'Get Price';
                    Ellipsis = true;
                    Image = SalesPrices;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = Discount;

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
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
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
                    Caption = 'Get St&d. Cust. Sales Codes';
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
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

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
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;

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
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

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
                    Caption = 'Create &Whse. Shipment';
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
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                separator(Action178)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Sales Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
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
                    Caption = 'Send IC Sales Order Cnfmn.';
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
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
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
                    Caption = 'Post and &Print';
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
                    Caption = 'Post &Batch';
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
                    Caption = '&Valider Livraison';
                    Image = PostedReceipt;
                    RunObject = Codeunit 50001;
                }
                action("&Valider Facture")
                {
                    Caption = '&Valider Facture';
                    Image = PostedVendorBill;
                    RunObject = Codeunit 50002;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation';
                    Image = Print;

                    trigger OnAction()
                    begin

                        //EMAIL SOBH NSC1.01 [005] Envoi document
                        //DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
                        CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                            1:
                                DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                            2:
                                EnvoiMail;
                        END;
                        //Fin EMAIL SOBH NSC1.01 [005] Envoi document
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Image = Print;

                    trigger OnAction()
                    var
                        RecGSalesHeader: Record "Sales Header";
                    begin
                        RecGSalesHeader.RESET;
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                        RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "No.");
                        RecGSalesHeader.FIND('-');

                        REPORT.RUNMODAL(REPORT::"Preparation NAVIDIIGEST1", TRUE, TRUE, RecGSalesHeader);
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
        Text000: Label 'Unable to execute this function while in view only mode.';
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
        //TODO PreparationNAVIDIIGEST: Report 50097;
        STR3: Label 'Impimer le document';
        STR4: Label 'Envoyer le document par E-Mail';
        STR5: Label 'Envoyer le document par Fax';
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        SalesHistoryStnVisible: Boolean;
        Text19070588: Label 'Sell-to Customer';
        Text19069283: Label 'Bill-to Customer';
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
        //SalesHistoryStnVisible := SalesInfoPaneMgt.DocExist(Rec,"Sell-to Customer No.");
        // IF DifferSellToBillTo THEN //TODO: check
        //SalesHistoryBtnVisible := SalesInfoPaneMgt.DocExist(Rec,"Bill-to Customer No.")
    end;


    procedure "**NSC1.01**"()
    begin
    end;


    procedure test()
    begin
    end;


    procedure EnvoiMail()
    begin
        //EMAIL NSC00.01 SBH [005] Envoi document
        cust.SETRANGE(cust."No.", "Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile;
        IF nameF <> '' THEN BEGIN
            //MIG2017
            //Mail.NewMessage(cust."E-Mail",'',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + "No.", '', nameF, FALSE);
            //MIG2017
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
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

    local procedure SelltoCustomerNoOnAfterValidate()
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

