page 50099 "BC6_Purchase Order (MAGASIN)"
{
    Caption = 'Purchase Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
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
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; "Buy-from Contact No.")
                {
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                }
                field("Buy-from City"; "Buy-from City")
                {
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                }
                field("Buy-from Fax No."; "BC6_Buy-from Fax No.")
                {
                }
                field("Your Reference"; "Your Reference")
                {
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
                field("Vendor Order No."; "Vendor Order No.")
                {
                }
                field("Vendor Shipment No."; "Vendor Shipment No.")
                {
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                }
                field("Order Address Code"; "Order Address Code")
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
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
            part(PurchLines; "Purchase Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; "Pay-to Contact No.")
                {
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                }
                field("Pay-to Address"; "Pay-to Address")
                {
                }
                field("Pay-to Address 2"; "Pay-to Address 2")
                {
                }
                field("Pay-to Post Code"; "Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                }
                field("Pay-to City"; "Pay-to City")
                {
                }
                field("Pay-to Contact"; "Pay-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterValidate;
                    end;
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
                field("On Hold"; "On Hold")
                {
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValidate;
                    end;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
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
                field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
                {
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                }
                field("Promised Receipt Date"; "Promised Receipt Date")
                {
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Ship-to Code"; "Ship-to Code")
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
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Entry Point"; "Entry Point")
                {
                }
                field("Area"; Area)
                {
                }
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
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            //MIG 2017 >>
                            //CurrPage.PurchLines.PAGE.CalcInvDisc;
                            CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                            //MIG 2017 <<
                            COMMIT;
                        END;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
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
                separator(Action181)
                {
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = WarehouseRegisters;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = Warehouse;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                separator(Action182)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Purchasing;
                    action("BC6_Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = GetLines;
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                    action("BC6_Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //MIG 2017 >>
                            //n'existe plus sur entete en 2017
                            //CurrPage.PurchLines.PAGE.OpenSalesOrderForm;
                            //MIG 2017 <<
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = Purchasing;
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = GetEntries;

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //MIG 2017 >>
                            //n'existe plus sur entete en 2017
                            //CurrPage.PurchLines.PAGE.OpenSpecOrderSalesOrderForm;
                            //MIG 2017 <<
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            action("Affecter commande")
            {
                Caption = 'Affecter commande';
                Image = OrderReminder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // IF NOT "BC6_From Sales Module" THEN
                    //     CurrPage.PurchLines.PAGE.ChooseSalesLineOrderToAffect TODO:
                    // ELSE
                    //     MESSAGE(txtg001);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                separator(Action190)
                {
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //MIG 2017 >>
                        //n'existe plus sur entete en 2017
                        //CurrPage.PurchLines.PAGE.ExplodeBOM;
                        //MIG 2017 >>
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //MIG 2017 >>
                        //n'existe plus sur entete en 2017
                        //CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
                        //MIG 2017 <<
                    end;
                }
                separator(Action152)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = GetStandardJournal;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action178)
                {
                }
                action("Order &Tracking")
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ShowTracking;
                    end;
                }
                separator(Action151)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
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
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(Action189)
                {
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    Image = WarehouseRegisters;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);
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
                separator(Action74)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Purchase Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }
                separator(Action73)
                {
                }
                action("Send IC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order';
                    Image = SendElectronicDocument;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
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
                        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Contrôle Minima MNT
                        IF NOT ControleMinimMNTandQTE THEN
                            ReportPrint.PrintPurchHeader(Rec);
                        //FIN CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02]  Contrôle Minima MNT
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
                    RunObject = Codeunit "Purch.-Post (Yes/No)";
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
                    RunObject = Codeunit "Purch.-Post + Print";
                    ShortCutKey = 'Shift+F11';
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02]  Contrôle Minima MNT
                        IF NOT ControleMinimMNTandQTE THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                        //FIN CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02]  Contrôle Minima MNT
                    end;
                }
            }
            action("Bc6_&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //>>FE002.2
                    IF ControleMinimMNTandQTE THEN
                        EXIT;
                    //<<FE002.2

                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //EMAIL NSC00.01  SBH [005] Envoi document Par Email
                    //DocPrint.PrintSalesHeader(Rec);
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        //1:DocPrint.PrintSalesHeader(Rec);
                        1:
                            BEGIN
                                DocPrint.PrintPurchHeader(Rec);
                            END;
                        2:
                            EnvoiMail;
                    END;
                    //Fin EMAIL NSC00.01 SBH [005] Envoi document Par Email
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            FILTERGROUP(0);
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        nameF: Text[250];
        Mail: Codeunit Mail;
        SalesSetup: Record "Sales & Receivables Setup";
        Excel: Boolean;
        STR1: Label 'Archiver Devis';
        STR2: Label 'Créer Commande';
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text004: Label 'Fichiers Pdf (*.pdf)|*.pdf|Tous les fichiers (*.*)|*.*';
        Text001: Label '';
        txtg001: Label 'This Purchase Order is already linked with a sales document \ You can''t affect a new one';
        ChangeExchangeRate: Page "Change Exchange Rate";


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
        END
        ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + "No.";
        HistMail.INSERT(TRUE);
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

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

