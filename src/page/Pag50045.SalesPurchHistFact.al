page 50045 "BC6_Sales/Purch. Hist Fact"
{
    Caption = 'Item Sales/Purchase History', Comment = 'FRA="Historique vente/achat article"';
    PageType = CardPart;
    SourceTable = Item;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(Sales)
            {
                Caption = 'Sales', Comment = 'FRA="Ventes"';
                field("&Quotes"; STRSUBSTNO(txtlbl1, NoOfQuotes))
                {
                    ApplicationArea = All;
                    Caption = '&Quotes', Comment = 'FRA="&Devis"';

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Quote);
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("&Blanket Orders"; STRSUBSTNO(txtlbl1, NoOfBlanketOrders))
                {
                    ApplicationArea = All;
                    Caption = '&Blanket Orders', Comment = 'FRA="&Commandes ouvertes"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Blanket Order");
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("&Orders"; STRSUBSTNO(txtlbl1, NoOfOrders))
                {
                    ApplicationArea = All;
                    Caption = '&Orders', Comment = 'FRA="C&ommandes"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Order);
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("&Invoices"; STRSUBSTNO(txtlbl1, NoofInvoices))
                {
                    ApplicationArea = All;
                    Caption = '&Invoices', Comment = 'FRA="&Factures"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Invoice);
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("&Return Orders"; STRSUBSTNO(txtlbl1, NoOfReturnOrders))
                {
                    ApplicationArea = All;
                    Caption = '&Return Orders', Comment = 'FRA="&Retours"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Return Order");
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("Cre&dit Memos"; STRSUBSTNO(txtlbl1, NoOfCreditMemos))
                {
                    ApplicationArea = All;
                    Caption = 'Cre&dit Memos', Comment = 'FRA="A&voirs"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET();
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Credit Memo");
                        RecGSalesLine.SETRANGE("No.", Rec."No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN();
                    end;
                }
                field("&Posted Shipments"; STRSUBSTNO(txtlbl1, NoOfPstdShipments))
                {
                    ApplicationArea = All;
                    Caption = '&Posted Shipments', Comment = 'FRA="Ex&péditions enregistrées"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesShipmentLine.RESET();
                        CLEAR(PagGShipmentLinesSubform3);
                        RecGSalesShipmentLine.SETRANGE("No.", Rec."No.");
                        PagGShipmentLinesSubform3.SETTABLEVIEW(RecGSalesShipmentLine);
                        PagGShipmentLinesSubform3.RUN();
                    end;
                }
                field("Posted I&nvoices"; STRSUBSTNO(txtlbl1, NoOfPstdInvoices))
                {
                    ApplicationArea = All;
                    Caption = 'Posted I&nvoices', Comment = 'FRA="Factures e&nregistrées"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesInvoiceLine.RESET();
                        CLEAR(PagGInvoiceLinesSubform3);
                        RecGSalesInvoiceLine.SETRANGE("No.", Rec."No.");
                        PagGInvoiceLinesSubform3.SETTABLEVIEW(RecGSalesInvoiceLine);
                        PagGInvoiceLinesSubform3.RUN();
                    end;
                }
                field("Posted Ret&urn Receipts"; STRSUBSTNO(txtlbl1, NoOfPstdReturnReceipts))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Ret&urn Receipts', Comment = 'FRA="Réceptions reto&ur enregistrées"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGReturnReceiptLine.RESET();
                        CLEAR(PagGGReturnRcptLinesSubform2);
                        RecGReturnReceiptLine.SETRANGE("No.", Rec."No.");
                        PagGGReturnRcptLinesSubform2.SETTABLEVIEW(RecGReturnReceiptLine);
                        PagGGReturnRcptLinesSubform2.RUN();
                    end;
                }
                field("Posted Cr. &Memos"; STRSUBSTNO(txtlbl1, NoOfPstdCreditMemos))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Cr. &Memos', Comment = 'FRA="&Avoirs enregistrés"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesCrMemoLine.RESET();
                        CLEAR(PagGCreditMemoLinesSubform2);
                        RecGSalesCrMemoLine.SETRANGE("No.", Rec."No.");
                        PagGCreditMemoLinesSubform2.SETTABLEVIEW(RecGSalesCrMemoLine);
                        PagGCreditMemoLinesSubform2.RUN();
                    end;
                }
            }
            group(Purchases)
            {
                Caption = 'Purchases', Comment = 'FRA="Achats"';
                field("Purch Quote"; STRSUBSTNO(txtlbl1, NbrOfPurchQuote))
                {
                    ApplicationArea = All;
                    Caption = 'Purch Quote', Comment = 'FRA="Demandes de prix"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Blanket Order Purchas"; STRSUBSTNO(txtlbl1, NbrOfPurchBlanketOrder))
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Order Purchas ', Comment = 'FRA="Commandes achat ouvertes"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Blanket Order");
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Purchase Order"; STRSUBSTNO(txtlbl1, NbrOfPurchOrder))
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order', Comment = 'FRA="Commandes achat"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Purchase Invoice"; STRSUBSTNO(txtlbl1, NbrOfPurchInvoice))
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoice', Comment = 'FRA="Factures achat"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Purchase Return"; STRSUBSTNO(txtlbl1, NbrOfPurchReturn))
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Return', Comment = 'FRA="Retours achat"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Purchase Credit Memo"; STRSUBSTNO(txtlbl1, NbrOfPurchCrdMemo))
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memo', Comment = 'FRA="Avoirs achat"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET();
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");
                        RecGPurchLines.SETRANGE("No.", Rec."No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN();
                    end;
                }
                field("Posted Purchase Receipt"; STRSUBSTNO(txtlbl1, NbrOfPurchPostedRcpt))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipt', Comment = 'FRA="Réceptions achat enregistrées"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchPostedRcpt.RESET();
                        CLEAR(PagGPurchRcpLinesSubform);
                        RecGPurchPostedRcpt.SETRANGE("No.", Rec."No.");
                        PagGPurchRcpLinesSubform.SETTABLEVIEW(RecGPurchPostedRcpt);
                        PagGPurchRcpLinesSubform.RUN();
                    end;
                }
                field("Posted Purchase Invoice"; STRSUBSTNO(txtlbl1, NbrOfPurchPostedInvoice))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoice', Comment = 'FRA="Factures achat enregistrées"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchPostedInvoice.RESET();
                        CLEAR(PagGPurchInvLineSubform);
                        RecGPurchPostedInvoice.SETRANGE("No.", Rec."No.");
                        PagGPurchInvLineSubform.SETTABLEVIEW(RecGPurchPostedInvoice);
                        PagGPurchInvLineSubform.RUN();
                    end;
                }
                field("Posted Purchase Return Shipement"; STRSUBSTNO(txtlbl1, NbrOfPurchPostedReturnShipemen))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Return Shipement', Comment = 'FRA="Expéditions retour achat"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin

                        RecGPurchPostedReturnShipement.RESET();
                        CLEAR(PagGReturnShipmentLineSubform);
                        RecGPurchPostedReturnShipement.SETRANGE("No.", Rec."No.");
                        PagGReturnShipmentLineSubform.SETTABLEVIEW(RecGPurchPostedReturnShipement);
                        PagGReturnShipmentLineSubform.RUN();
                    end;
                }
                field("Posted Purchase Credit Memo"; STRSUBSTNO(txtlbl1, NbrOfPurchPostedCrdMemo))
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memo', Comment = 'FRA="Avoirs achat enregistrés"';
                    Editable = false;

                    trigger OnDrillDown()
                    begin

                        RecGPurchPostedCrdMemo.RESET();
                        CLEAR(PagGPurchCrMemoLineSubform);
                        RecGPurchPostedCrdMemo.SETRANGE("No.", Rec."No.");
                        PagGPurchCrMemoLineSubform.SETTABLEVIEW(RecGPurchPostedCrdMemo);
                        PagGPurchCrMemoLineSubform.RUN();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        CLEAR(CodGDocNo);
        NoOfQuotes := 0;
        NoOfBlanketOrders := 0;
        NoOfOrders := 0;
        NoofInvoices := 0;
        NoOfReturnOrders := 0;
        NoOfCreditMemos := 0;
        NoOfPstdShipments := 0;
        NoOfPstdInvoices := 0;
        NoOfPstdReturnReceipts := 0;
        NoOfPstdCreditMemos := 0;
        ///
        NbrOfPurchQuote := 0;
        NbrOfPurchBlanketOrder := 0;
        NbrOfPurchOrder := 0;
        NbrOfPurchInvoice := 0;
        NbrOfPurchReturn := 0;
        NbrOfPurchCrdMemo := 0;
        NbrOfPurchPostedRcpt := 0;
        NbrOfPurchPostedInvoice := 0;
        NbrOfPurchPostedReturnShipemen := 0;
        NbrOfPurchPostedCrdMemo := 0;

        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Quote);
        RecGSalesLine.SETFILTER("No.", Rec."No.");

        IF RecGSalesLine.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfQuotes := NoOfQuotes + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;

        //Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Order);
        RecGSalesLine.SETFILTER("No.", Rec."No.");

        IF RecGSalesLine.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfOrders := NoOfOrders + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;

        //Return Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::"Return Order");
        RecGSalesLine.SETFILTER("No.", Rec."No.");
        IF RecGSalesLine.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfReturnOrders := NoOfReturnOrders + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;

        //Posted SHipements
        CLEAR(CodGDocNo);
        RecGSalesShipementLine.RESET();
        RecGSalesShipementLine.SETCURRENTKEY("No.");
        RecGSalesShipementLine.SETFILTER("No.", Rec."No.");

        IF RecGSalesShipementLine.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGSalesShipementLine."Document No." THEN
                    NoOfPstdShipments := NoOfPstdShipments + 1;
                CodGDocNo := RecGSalesShipementLine."Document No.";
            UNTIL RecGSalesShipementLine.NEXT() = 0;

        // Posted Invoices
        CLEAR(CodGDocNo);
        RecGPostdSalesInvoices.RESET();
        RecGPostdSalesInvoices.SETCURRENTKEY("No.");
        RecGPostdSalesInvoices.SETFILTER("No.", Rec."No.");

        IF RecGPostdSalesInvoices.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPostdSalesInvoices."Document No." THEN
                    NoOfPstdInvoices := NoOfPstdInvoices + 1;
                CodGDocNo := RecGPostdSalesInvoices."Document No.";
            UNTIL RecGPostdSalesInvoices.NEXT() = 0;

        // Posted Return Receipts
        CLEAR(CodGDocNo);
        RecGPostdReturnSales.RESET();
        RecGPostdReturnSales.SETCURRENTKEY("No.");
        RecGPostdReturnSales.SETFILTER("No.", Rec."No.");

        IF RecGPostdReturnSales.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPostdReturnSales."Document No." THEN
                    NoOfPstdReturnReceipts := NoOfPstdReturnReceipts + 1;
                CodGDocNo := RecGPostdReturnSales."Document No.";
            UNTIL RecGPostdReturnSales.NEXT() = 0;

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPostdCrdMemo.RESET();
        RecGPostdCrdMemo.SETCURRENTKEY("No.");
        RecGPostdCrdMemo.SETFILTER("No.", Rec."No.");

        IF RecGPostdCrdMemo.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPostdCrdMemo."Document No." THEN
                    NoOfPstdCreditMemos := NoOfPstdCreditMemos + 1;
                CodGDocNo := RecGPostdCrdMemo."Document No.";
            UNTIL RecGPostdCrdMemo.NEXT() = 0;
        ////
        //Purchase quote
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);

        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchQuote := NbrOfPurchQuote + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        //Purchase order
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);

        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchOrder := NbrOfPurchOrder + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        //Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);

        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchInvoice := NbrOfPurchInvoice + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        //Purchase return
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");

        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchReturn := NbrOfPurchReturn + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        //Purchase credit memo
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");

        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchCrdMemo := NbrOfPurchCrdMemo + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        // Posted Purchase Receipt
        CLEAR(CodGDocNo);
        RecGPurchPostedRcpt.RESET();
        RecGPurchPostedRcpt.SETCURRENTKEY("No.");
        RecGPurchPostedRcpt.SETFILTER("No.", Rec."No.");

        IF RecGPurchPostedRcpt.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedRcpt."Document No." THEN
                    NbrOfPurchPostedRcpt := NbrOfPurchPostedRcpt + 1;
                CodGDocNo := RecGPurchPostedRcpt."Document No.";
            UNTIL RecGPurchPostedRcpt.NEXT() = 0;

        // Posted Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchPostedInvoice.RESET();
        RecGPurchPostedInvoice.SETCURRENTKEY("No.");
        RecGPurchPostedInvoice.SETFILTER("No.", Rec."No.");

        IF RecGPurchPostedInvoice.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedInvoice."Document No." THEN
                    NbrOfPurchPostedInvoice := NbrOfPurchPostedInvoice + 1;
                CodGDocNo := RecGPurchPostedInvoice."Document No.";
            UNTIL RecGPurchPostedInvoice.NEXT() = 0;

        // Posted Purchase Return Shipement
        CLEAR(CodGDocNo);
        RecGPurchPostedReturnShipement.RESET();
        RecGPurchPostedReturnShipement.SETCURRENTKEY("No.");
        RecGPurchPostedReturnShipement.SETFILTER("No.", Rec."No.");

        IF RecGPurchPostedReturnShipement.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedReturnShipement."Document No." THEN
                    NbrOfPurchPostedReturnShipemen := NbrOfPurchPostedReturnShipemen + 1;
                CodGDocNo := RecGPurchPostedReturnShipement."Document No.";
            UNTIL RecGPurchPostedReturnShipement.NEXT() = 0;

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPurchPostedCrdMemo.RESET();
        RecGPurchPostedCrdMemo.SETCURRENTKEY("No.");
        RecGPurchPostedCrdMemo.SETFILTER("No.", Rec."No.");

        IF RecGPurchPostedCrdMemo.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedCrdMemo."Document No." THEN
                    NbrOfPurchPostedCrdMemo := NbrOfPurchPostedCrdMemo + 1;
                CodGDocNo := RecGPurchPostedCrdMemo."Document No.";
            UNTIL RecGPurchPostedCrdMemo.NEXT() = 0;
    end;

    var
        RecGPurchPostedCrdMemo: Record "Purch. Cr. Memo Line";
        RecGPurchPostedInvoice: Record "Purch. Inv. Line";
        RecGPurchPostedRcpt: Record "Purch. Rcpt. Line";
        RecGPurchLines: Record "Purchase Line";
        RecGPostdReturnSales: Record "Return Receipt Line";
        RecGReturnReceiptLine: Record "Return Receipt Line";
        RecGPurchPostedReturnShipement: Record "Return Shipment Line";
        RecGPostdCrdMemo: Record "Sales Cr.Memo Line";
        RecGSalesCrMemoLine: Record "Sales Cr.Memo Line";
        RecGPostdSalesInvoices: Record "Sales Invoice Line";
        RecGSalesInvoiceLine: Record "Sales Invoice Line";
        RecGSalesLine: Record "Sales Line";
        RecGSalesLines: Record "Sales Line";
        RecGSalesShipementLine: Record "Sales Shipment Line";
        RecGSalesShipmentLine: Record "Sales Shipment Line";
        PagGCreditMemoLinesSubform2: Page "BC6_Cred. Memo Lines Subform 2";
        PagGInvoiceLinesSubform3: Page "BC6_Invoice Lines Subform 3";
        PagGPurchInvLineSubform: Page "BC6_Purch. Inv. Line Subform";
        PagGPurchRcpLinesSubform: Page "BC6_Purch. Rcpt. Lines Subform";
        PagGPurchaseLinesSubform2: Page "BC6_Purchase Lines Subform2";
        PagGReturnShipmentLineSubform: Page "BC6_Return Ship. Line Subform";
        PagGSalesLinesSubform3: Page "BC6_Sales Lines Subform 3";
        PagGShipmentLinesSubform3: Page "BC6_Shipment Lines Subform 3";
        PagGPurchCrMemoLineSubform: Page "BC6_Purch. Cr. Memo Line Sub";
        PagGGReturnRcptLinesSubform2: Page "BC6_Return Rcpt Lines Sub2";
        CodGDocNo: Code[20];
        NbrOfPurchBlanketOrder: Integer;
        NbrOfPurchCrdMemo: Integer;
        NbrOfPurchInvoice: Integer;
        NbrOfPurchOrder: Integer;
        NbrOfPurchPostedCrdMemo: Integer;
        NbrOfPurchPostedInvoice: Integer;
        NbrOfPurchPostedRcpt: Integer;
        NbrOfPurchPostedReturnShipemen: Integer;
        NbrOfPurchQuote: Integer;
        NbrOfPurchReturn: Integer;
        NoOfBlanketOrders: Integer;
        NoOfCreditMemos: Integer;
        NoofInvoices: Integer;
        NoOfOrders: Integer;
        NoOfPstdCreditMemos: Integer;
        NoOfPstdInvoices: Integer;
        NoOfPstdReturnReceipts: Integer;
        NoOfPstdShipments: Integer;
        NoOfQuotes: Integer;
        NoOfReturnOrders: Integer;
        txtlbl1: label '(%1)';
}
