page 50099 "BC6_Purchase Order (MAGASIN)"
{
    Caption = 'Purchase Order', comment = 'FRA="Commande achat"';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    UsageCategory = Tasks;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate();
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City', comment = 'FRA="CP/Ville preneur d''ordre"';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                }
                field("Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
                {
                }
                field("Your Reference"; Rec."Your Reference")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                }
                field(ID; Rec.BC6_ID)
                {
                    Caption = 'User ID', comment = 'FRA="Code Utilisateur"';
                    Editable = false;
                }
                field(Status; Rec.Status)
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
                Caption = 'Invoicing', comment = 'FRA="Facturation"';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City', comment = 'FRA="CP/Ville"';
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterValidate();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterValidate();
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("On Hold"; Rec."On Hold")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValidate();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', comment = 'FRA="Livraison"';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City', comment = 'FRA="CP/Ville destinataire"';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', comment = 'FRA="International"';
                field("Currency Code"; Rec."Currency Code")
                {

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
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Entry Point"; Rec."Entry Point")
                {
                }
                field("Area"; Rec.Area)
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
                Caption = 'O&rder', comment = 'FRA="&Commande"';
                action(Statistics)
                {
                    Caption = 'Statistics', comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        PurchSetup.GET();
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
                            COMMIT();
                        END;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card', comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
                action(Receipts)
                {
                    Caption = 'Receipts', comment = 'FRA="Réception"';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices', comment = 'FRA="F&actures"';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions', comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                separator(Action181)
                {
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines', comment = 'FRA="Lignes réception mag."';
                    Image = WarehouseRegisters;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', comment = 'FRA="Lignes prélévement/rangement stock"';
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
                    Caption = 'Dr&op Shipment', comment = 'FRA="Livraison &directe"';
                    Image = Purchasing;
                    action("BC6_Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order', comment = 'FRA="Ex&traire commande vente"';
                        Image = GetLines;
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }


                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order', comment = 'FRA="C&ommande spéciale"';
                    Image = Purchasing;
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order', comment = 'FRA="Ex&traire commande vente"';
                        Image = GetEntries;

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }


                }
            }
        }
        area(processing)
        {
            action("Affecter commande")
            {
                Caption = 'Affecter commande', comment = 'FRA="Affecter commande"';
                Image = OrderReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF NOT Rec."BC6_From Sales Module" THEN
                        CurrPage.PurchLines.PAGE.ChooseSalesLineOrderToAffect()
                    ELSE
                        MESSAGE(txtg001);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', comment = 'FRA="Fonction&s"';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount', comment = 'FRA="C&alculer remise facture"';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
                    end;
                }
                separator(Action190)
                {
                }
                separator(Action152)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes', comment = 'FRA="Extraire codes &achat fourn. std"';
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
                    Caption = 'Order &Tracking', comment = 'FRA="Chaînage"';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ShowTracking();
                    end;
                }
                separator(Action151)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document', comment = 'FRA="Copier &document"';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document', comment = 'FRA="Archi&ver document"';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines', comment = 'FRA="Déplacer lignes &négatives"';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                separator(Action189)
                {
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt', comment = 'FRA="Créer &réception magasin"';
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
                    Caption = 'Create Inventor&y Put-away / Pick', comment = 'FRA="Créer prélév./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    var
                        FunctionsMgt: codeunit "BC6_Functions Mgt";
                    begin
                        FunctionsMgt.BC6_CreateInvtPutAwayPick_Purchase(rec);
                    end;
                }
                separator(Action74)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease', comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Purchase Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    Caption = 'Re&open', comment = 'FRA="R&ouvrir"';
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
                    Caption = 'Send IC Purchase Order', comment = 'FRA="Envoyer commande achat IC"';
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
                Caption = 'P&osting', comment = 'FRA="&Validation"';
                action("Test Report")
                {
                    Caption = 'Test Report', comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        IF NOT Rec.ControleMinimMNTandQTE() THEN
                            ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost', comment = 'FRA="Valider"';
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
                    Caption = 'Post and &Print', comment = 'FRA="Valider et i&mprimer"';
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
                    Caption = 'Post &Batch', comment = 'FRA="Valider par lot"';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        IF NOT Rec.ControleMinimMNTandQTE() THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
            }
            action("Bc6_&Print")
            {
                Caption = '&Print', comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF Rec.ControleMinimMNTandQTE() THEN
                        EXIT;

                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("&Print")
            {
                Caption = '&Print', comment = 'FRA="&Envoyer/Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                        1:
                            BEGIN
                                DocPrint.PrintPurchHeader(Rec);
                            END;
                        2:
                            EnvoiMail();
                    END;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        PurchSetup: Record "Purchases & Payables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        DocPrint: Codeunit "Document-Print";
        Mail: Codeunit Mail;
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        STR3: Label 'Imprimer le document ?';
        STR4: Label 'Envoyer le document par mail ?';
        STR5: Label 'Envoyer le document par fax ?';
        Text001: Label '';
        txtg001: Label 'This Purchase Order is already linked with a sales document \ You can''t affect a new one', comment = 'FRA="Cette commande d''achat est déjà lié a un document \ Vous ne pouvez pas l''affecter à un autre"';
        nameF: Text[250];


    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FindFirst() THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            Mail.NewMessage(cust."E-Mail", '', '', CurrPage.CAPTION + ' ' + Rec."No.", '', nameF, FALSE);
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
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + Rec."No.";
        HistMail.INSERT(TRUE);
    end;


    procedure OpenFile()
    begin

    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
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
        CurrPage.UPDATE();
    end;
}

