page 50014 "BC6_Item Sales/Purch. History"
{
    Caption = 'Item Sales/Purch. History';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field(CurrentMenuTypeValue; CurrentMenuType)
            {
                Visible = false;
            }
            group("Sales History")
            {
                Caption = 'Sales History';
                field(QuotesBtn; CurrentMenuTypeOpt)
                {
                    OptionCaption = 'Quotes,Blanket Orders,Orders,Invoices,Return Orders,Credit Memos,Posted Shipments,Posted Invoices,Posted Return Receipts,Posted Cr. Memos';

                    trigger OnValidate()
                    begin
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x9 THEN
                            x9CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x8 THEN
                            x8CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x7 THEN
                            x7CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x6 THEN
                            x6CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x3 THEN
                            x3CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x5 THEN
                            x5CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x2 THEN
                            x2CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x1 THEN
                            x1CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x4 THEN
                            x4CurrentMenuTypeOptOnValidate;
                        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x0 THEN
                            x0CurrentMenuTypeOptOnValidate;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfQuotes);STRSUBSTNO('(%1)',NoOfQuotes))
                {
                    Caption = '&Quotes';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfBlanketOrders);STRSUBSTNO('(%1)',NoOfBlanketOrders))
                {
                    Caption = '&Blanket Orders';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfOrders);STRSUBSTNO('(%1)',NoOfOrders))
                {
                    Caption = '&Orders';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoofInvoices);STRSUBSTNO('(%1)',NoofInvoices))
                {
                    Caption = '&Invoices';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfReturnOrders);STRSUBSTNO('(%1)',NoOfReturnOrders))
                {
                    Caption = '&Return Orders';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfCreditMemos);STRSUBSTNO('(%1)',NoOfCreditMemos))
                {
                    Caption = 'Cre&dit Memos';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdShipments);STRSUBSTNO('(%1)',NoOfPstdShipments))
                {
                    Caption = '&Posted Shipments';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdInvoices);STRSUBSTNO('(%1)',NoOfPstdInvoices))
                {
                    Caption = 'Posted I&nvoices';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdReturnReceipts);STRSUBSTNO('(%1)',NoOfPstdReturnReceipts))
                {
                    Caption = 'Posted Ret&urn Receipts';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdCreditMemos);STRSUBSTNO('(%1)',NoOfPstdCreditMemos))
                {
                    Caption = 'Posted Cr. &Memos';
                    Editable = false;
                }
            }
            group("Purchase History")
            {
                Caption = 'Purchase History';
                field(PurchLineBtn; CurrentMenuTypeOpt)
                {

                    trigger OnValidate()
                    begin
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchQuote);STRSUBSTNO('(%1)',NbrOfPurchQuote))
                {
                    Caption = 'Purch Quote';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchBlanketOrder);STRSUBSTNO('(%1)',NbrOfPurchBlanketOrder))
                {
                    Caption = 'Blanket Order Purchas ';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchOrder);STRSUBSTNO('(%1)',NbrOfPurchOrder))
                {
                    Caption = 'Purchase Order';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchInvoice);STRSUBSTNO('(%1)',NbrOfPurchInvoice))
                {
                    Caption = 'Purchase Invoice';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchReturn);STRSUBSTNO('(%1)',NbrOfPurchReturn))
                {
                    Caption = 'Purchase Return';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchCrdMemo);STRSUBSTNO('(%1)',NbrOfPurchCrdMemo))
                {
                    Caption = 'Purchase Credit Memo';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedRcpt);STRSUBSTNO('(%1)',NbrOfPurchPostedRcpt))
                {
                    Caption = 'Posted Purchase Receipt';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedInvoice);STRSUBSTNO('(%1)',NbrOfPurchPostedInvoice))
                {
                    Caption = 'Posted Purchase Invoice';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedReturnShipemen);STRSUBSTNO('(%1)',NbrOfPurchPostedReturnShipemen))
                {
                    Caption = 'Posted Purchase Return Shipement';
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedCrdMemo);STRSUBSTNO('(%1)',NbrOfPurchPostedCrdMemo))
                {
                    Caption = 'Posted Purchase Credit Memo';
                    Editable = false;
                }
            }
            part(PurchReturnShipement; "Return Shipment Line Subform")
            {
                SubPageLink = No.=FIELD(No.);
                Visible = PurchReturnShipementVisible;
            }
            part(PurchCrMemoLine; "Purch. Cr. Memo Line Subform")
            {
                SubPageLink = No.=FIELD(No.);
                Visible = PurchCrMemoLineVisible;
            }
            part(PostedReturnRcpts; "Return Rcpt Lines Subform 2")
            {
                SubPageLink = No.=FIELD(No.);
                SubPageView = SORTING(No.);
                Visible = PostedReturnRcptsVisible;
            }
            part(PostedCrMemos; 50039)
            {
                SubPageLink = No.=FIELD(No.);
                SubPageView = SORTING(No.);
                Visible = PostedCrMemosVisible;
            }
            part(SalesLines; 50041)
            {
                SubPageLink = No.=FIELD(No.);
                Visible = SalesLinesVisible;
            }
            part(PostedShpts; 50042)
            {
                SubPageLink = No.=FIELD(No.);
                SubPageView = SORTING(No.);
                Visible = PostedShptsVisible;
            }
            part(PostedInvoices; 50043)
            {
                SubPageLink = No.=FIELD(No.);
                SubPageView = SORTING(No.);
                Visible = PostedInvoicesVisible;
            }
            part(PurchInvLine; 50018)
            {
                SubPageLink = No.=FIELD(No.);
                Visible = PurchInvLineVisible;
            }
            part(PurchRcptline; 50017)
            {
                SubPageLink = No.=FIELD(No.);
                Visible = PurchRcptlineVisible;
            }
            part(PurchLine;50016)
            {
                SubPageLink = No.=FIELD(No.);
                Visible = PurchLineVisible;
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show")
            {
                Caption = '&Show';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    SalesShptHeader: Record 110;
                    SalesShptLine: Record 111
                    SalesInvHeader: Record 112;
                    SalesInvLine: Record 113;
                    SalesCrMemoHeader: Record 114;
                    SalesCrMemoLine: Record 115;
                    ReturnRcptHeader: Record 6660;
                    ReturnRcptLine: Record 6661;
                    "--FEP-ADVE-200706_18_B--": Integer;
                    RecGPurchHeader: Record "38";
                    RecGPurchPostedRcptHeader: Record 120;
                    RecLPurchpostedInvoiceHeader: Record 122;
                    RecLPurchReturnShipementHeader: Record 6650;
                    RecLPurchPostedCrdMemoHeader: Record 124;
                begin
                    CASE CurrentMenuType OF
                      0..5:
                        BEGIN
                            CurrPage.SalesLines.PAGE.GETRECORD(SalesLine);
                          IF NOT SalesHeader.GET(SalesLine."Document Type",SalesLine."Document No.") THEN
                            EXIT;
                          CASE CurrentMenuType OF
                            0:
                              PAGE.RUN(PAGE::"Sales Quote",SalesHeader);
                            1:
                              PAGE.RUN(PAGE::"Sales Order",SalesHeader);
                            2:
                              PAGE.RUN(PAGE::"Sales Invoice",SalesHeader);
                            3:
                              PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader);
                            4:
                              PAGE.RUN(PAGE::"Blanket Sales Order",SalesHeader);
                            5:
                              PAGE.RUN(PAGE::"Sales Return Order",SalesHeader);
                          END;
                        END;
                      6:
                        BEGIN
                            CurrPage.PostedShpts.PAGE.GETRECORD(SalesShptLine);
                          IF NOT SalesShptHeader.GET(SalesShptLine."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Sales Shipment",SalesShptHeader);
                        END;
                      7:
                        BEGIN
                            CurrPage.PostedInvoices.PAGE.GETRECORD(SalesInvLine);
                          IF NOT SalesInvHeader.GET(SalesInvLine."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvHeader);
                        END;
                      8:
                        BEGIN
                            CurrPage.PostedReturnRcpts.PAGE.GETRECORD(ReturnRcptLine);
                          IF NOT ReturnRcptHeader.GET(ReturnRcptLine."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Return Receipt",ReturnRcptHeader);
                        END;
                      9:
                        BEGIN
                            CurrPage.PostedCrMemos.PAGE.GETRECORD(SalesCrMemoLine);
                          IF NOT SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader);
                        END;
                      10..15:
                        BEGIN
                           CurrPage.PurchLine.PAGE.GETRECORD(RecGPurchLines);
                          IF NOT RecGPurchHeader.GET(RecGPurchLines."Document Type",RecGPurchLines."Document No.") THEN
                            EXIT;
                          CASE CurrentMenuType OF
                            10:
                              PAGE.RUN(PAGE::"Purchase Quote",RecGPurchHeader);
                            11:
                              PAGE.RUN(PAGE::"Purchase Order",RecGPurchHeader);
                            12:
                              PAGE.RUN(PAGE::"Purchase Invoice",RecGPurchHeader);
                            13:
                              PAGE.RUN(PAGE::"Purchase Credit Memo",RecGPurchHeader);
                            14:
                              PAGE.RUN(PAGE::"Blanket Purchase Order",RecGPurchHeader);
                            15:
                              PAGE.RUN(PAGE::"Purchase Return Order",RecGPurchHeader);
                          END;
                        END;
                      16:
                        BEGIN
                          CurrPage.PurchRcptline.PAGE.GETRECORD(RecGPurchPostedRcpt);
                          IF NOT RecGPurchPostedRcptHeader.GET(RecGPurchPostedRcpt."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Purchase Receipt",RecGPurchPostedRcptHeader);
                        END;
                      17:
                        BEGIN
                          CurrPage.PurchInvLine.PAGE.GETRECORD(RecGPurchPostedInvoice);
                          IF NOT RecLPurchpostedInvoiceHeader.GET(RecGPurchPostedInvoice."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Purchase Invoice",RecLPurchpostedInvoiceHeader);
                        END;
                      18:
                        BEGIN
                          CurrPage.PurchReturnShipement.PAGE.GETRECORD(RecGPurchPostedReturnShipement);
                          IF NOT RecLPurchReturnShipementHeader.GET(RecGPurchPostedReturnShipement."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Return Shipment",RecLPurchReturnShipementHeader);
                        END;
                      19:
                        BEGIN
                          CurrPage.PurchCrMemoLine.PAGE.GETRECORD(RecGPurchPostedCrdMemo);
                          IF NOT RecLPurchPostedCrdMemoHeader.GET(RecGPurchPostedCrdMemo."Document No.") THEN
                            EXIT;
                          PAGE.RUN(PAGE::"Posted Purchase Credit Memo",RecLPurchPostedCrdMemoHeader);
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        NoOfQuotes := 0;
        NoOfBlanketOrders := 0;
        NoOfOrders  := 0;
        NoofInvoices := 0;
        NoOfReturnOrders :=0;
        NoOfCreditMemos :=0;
        NoOfPstdShipments := 0;
        NoOfPstdInvoices := 0;
        NoOfPstdReturnReceipts := 0;
        NoOfPstdCreditMemos := 0;
        NbrOfPurchQuote := 0;
        NbrOfPurchBlanketOrder := 0;
        NbrOfPurchOrder := 0;
        NbrOfPurchInvoice := 0;
        NbrOfPurchReturn := 0;
        NbrOfPurchCrdMemo := 0;
        NbrOfPurchPostedRcpt := 0;
        NbrOfPurchPostedInvoice := 0;
        NbrOfPurchPostedReturnShipemen :=0;
        NbrOfPurchPostedCrdMemo := 0;

        //Quote
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::Quote);
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfQuotes := NoOfQuotes + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Blanket Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Blanket Order");
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;


        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfBlanketOrders := NoOfBlanketOrders + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::Order);
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfOrders := NoOfOrders + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Invoices
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::Invoice);
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoofInvoices := NoofInvoices + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Return Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Return Order");
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfReturnOrders := NoOfReturnOrders + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Credit Memo
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Credit Memo");
        RecGSalesLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfCreditMemos := NoOfCreditMemos + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;

        //Posted SHipements
        CLEAR(CodGDocNo);
        RecGSalesShipementLine.RESET;
        RecGSalesShipementLine.SETCURRENTKEY("No.");
        RecGSalesShipementLine.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGSalesShipementLine.SETCURRENTKEY(RecGSalesShipementLine."Sell-to Customer No.");
          RecGSalesShipementLine.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGSalesShipementLine.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesShipementLine."Document No." THEN
              NoOfPstdShipments:= NoOfPstdShipments + 1;
            CodGDocNo := RecGSalesShipementLine."Document No.";
          UNTIL RecGSalesShipementLine.NEXT =0;
        END;

        // Posted Invoices
        CLEAR(CodGDocNo);
        RecGPostdSalesInvoices.RESET;
        RecGPostdSalesInvoices.SETCURRENTKEY("No.");
        RecGPostdSalesInvoices.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPostdSalesInvoices.SETCURRENTKEY(RecGPostdSalesInvoices."Sell-to Customer No.");
          RecGPostdSalesInvoices.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGPostdSalesInvoices.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPostdSalesInvoices."Document No." THEN
              NoOfPstdInvoices:= NoOfPstdInvoices + 1;
            CodGDocNo := RecGPostdSalesInvoices."Document No.";
          UNTIL RecGPostdSalesInvoices.NEXT =0;
        END;

        // Posted Return Receipts
        CLEAR(CodGDocNo);
        RecGPostdReturnSales.RESET;
        RecGPostdReturnSales.SETCURRENTKEY("No.");
        RecGPostdReturnSales.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPostdReturnSales.SETCURRENTKEY(RecGPostdReturnSales."Sell-to Customer No.");
          RecGPostdReturnSales.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGPostdReturnSales.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPostdReturnSales."Document No." THEN
              NoOfPstdReturnReceipts:= NoOfPstdReturnReceipts + 1;
            CodGDocNo := RecGPostdReturnSales."Document No.";
          UNTIL RecGPostdReturnSales.NEXT =0;
        END;

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPostdCrdMemo.RESET;
        RecGPostdCrdMemo.SETCURRENTKEY("No.");
        RecGPostdCrdMemo.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPostdCrdMemo.SETCURRENTKEY(RecGPostdCrdMemo."Sell-to Customer No.");
          RecGPostdCrdMemo.SETFILTER("Sell-to Customer No.",CodGCustNo);
        END;

        IF RecGPostdCrdMemo.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPostdCrdMemo."Document No." THEN
              NoOfPstdCreditMemos:= NoOfPstdCreditMemos + 1;
            CodGDocNo := RecGPostdCrdMemo."Document No.";
          UNTIL RecGPostdCrdMemo.NEXT =0;
        END;

        //Purchase quote
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Quote);

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchQuote := NbrOfPurchQuote +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase blanket order
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Blanket Order");

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchBlanketOrder := NbrOfPurchBlanketOrder +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase order
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Order);

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchOrder := NbrOfPurchOrder +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Invoice);

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchInvoice := NbrOfPurchInvoice +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase return
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Return Order");

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchReturn := NbrOfPurchReturn +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase credit memo
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Credit Memo");

        IF BooGFilterCust THEN BEGIN
          RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
          RecGPurchLines.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchLines."Document No." THEN
              NbrOfPurchCrdMemo := NbrOfPurchCrdMemo +1;
            CodGDocNo := RecGPurchLines."Document No.";
          UNTIL RecGPurchLines.NEXT = 0;
        END;

        // Posted Purchase Receipt
        CLEAR(CodGDocNo);
        RecGPurchPostedRcpt.RESET;
        RecGPurchPostedRcpt.SETCURRENTKEY("No.");
        RecGPurchPostedRcpt.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPurchPostedRcpt.SETCURRENTKEY(RecGPurchPostedRcpt."Buy-from Vendor No.");
          RecGPurchPostedRcpt.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;

        IF RecGPurchPostedRcpt.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchPostedRcpt."Document No." THEN
              NbrOfPurchPostedRcpt:= NbrOfPurchPostedRcpt + 1;
            CodGDocNo := RecGPurchPostedRcpt."Document No.";
          UNTIL RecGPurchPostedRcpt.NEXT =0;
        END;

        // Posted Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchPostedInvoice.RESET;
        RecGPurchPostedInvoice.SETCURRENTKEY("No.");
        RecGPurchPostedInvoice.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPurchPostedInvoice.SETCURRENTKEY(RecGPurchPostedInvoice."Buy-from Vendor No.");
          RecGPurchPostedInvoice.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;

        IF RecGPurchPostedInvoice.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchPostedInvoice."Document No." THEN
              NbrOfPurchPostedInvoice:= NbrOfPurchPostedInvoice + 1;
            CodGDocNo := RecGPurchPostedInvoice."Document No.";
          UNTIL RecGPurchPostedInvoice.NEXT =0;
        END;

        // Posted Purchase Return Shipement
        CLEAR(CodGDocNo);
        RecGPurchPostedReturnShipement.RESET;
        RecGPurchPostedReturnShipement.SETCURRENTKEY("No.");
        RecGPurchPostedReturnShipement.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPurchPostedReturnShipement.SETCURRENTKEY(RecGPurchPostedReturnShipement."Buy-from Vendor No.");
          RecGPurchPostedReturnShipement.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;

        IF RecGPurchPostedReturnShipement.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchPostedReturnShipement."Document No." THEN
              NbrOfPurchPostedReturnShipemen:= NbrOfPurchPostedReturnShipemen + 1;
            CodGDocNo := RecGPurchPostedReturnShipement."Document No.";
          UNTIL RecGPurchPostedReturnShipement.NEXT =0;
        END;

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPurchPostedCrdMemo.RESET;
        RecGPurchPostedCrdMemo.SETCURRENTKEY("No.");
        RecGPurchPostedCrdMemo.SETFILTER("No.","No.");

        IF BooGFilterCust THEN BEGIN
          RecGPurchPostedCrdMemo.SETCURRENTKEY(RecGPurchPostedCrdMemo."Buy-from Vendor No.");
          RecGPurchPostedCrdMemo.SETFILTER("Buy-from Vendor No.",CodGCustNo);
        END;

        IF RecGPurchPostedCrdMemo.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchPostedCrdMemo."Document No." THEN
              NbrOfPurchPostedCrdMemo:= NbrOfPurchPostedCrdMemo + 1;
            CodGDocNo := RecGPurchPostedCrdMemo."Document No.";
          UNTIL RecGPurchPostedCrdMemo.NEXT =0;
        END;
        CurrentMenuTypeOpt := CurrentMenuType;
        CurrentMenuTypeOpt := CurrentMenuType;
    end;

    trigger OnOpenPage()
    begin
        ChangeSubMenu(CurrentMenuType);
        CASE CurrentMenuType OF
          0:;
          1:;
          2:;
          3:;
          4:;
          5:;
          6:;
          7:;
          8:;
          9:;
          10:;
          11:;
          12:;
          13:;
          14:;
          15:;
          16:;
          17:;
          18:;
          19:;
        END;
        SETRANGE("No.","No.");
    end;

    var
        ToSalesHeader: Record 36;
        SalesInfoPaneMgt: Codeunit 7171;
        SalesHistCopyLineMgt: Codeunit 7171;
        OldMenuType: Integer;
        CurrentMenuType: Integer;
        BillTo: Boolean;
        NoOfQuotes: Integer;
        NoOfBlanketOrders: Integer;
        NoOfOrders: Integer;
        NoofInvoices: Integer;
        NoOfReturnOrders: Integer;
        NoOfCreditMemos: Integer;
        NoOfPstdShipments: Integer;
        NoOfPstdInvoices: Integer;
        NoOfPstdReturnReceipts: Integer;
        NoOfPstdCreditMemos: Integer;
        "--FEP-ADVE-200706_18_B--": Integer;
        BooGFilterCust: Boolean;
        CuGItemHistoryMgt: Codeunit 50009;
        RecGSalesShipementLine: Record 111;
        RecGPostdSalesInvoices: Record 113;
        RecGPostdReturnSales: Record 6661;
        RecGPostdCrdMemo: Record 115;
        RecGSalesLine: Record 37;
        CodGDocNo: Code[20];
        CodGCustNo: Code[20];
        NbrOfPurchQuote: Integer;
        NbrOfPurchBlanketOrder: Integer;
        NbrOfPurchOrder: Integer;
        NbrOfPurchInvoice: Integer;
        NbrOfPurchReturn: Integer;
        NbrOfPurchCrdMemo: Integer;
        NbrOfPurchPostedRcpt: Integer;
        NbrOfPurchPostedInvoice: Integer;
        NbrOfPurchPostedReturnShipemen: Integer;
        NbrOfPurchPostedCrdMemo: Integer;
        RecGPurchLines: Record 39;
        RecGPurchPostedRcpt: Record 121;
        RecGPurchPostedInvoice: Record 123;
        RecGPurchPostedReturnShipement: Record 6651;
        RecGPurchPostedCrdMemo: Record 125;
        [InDataSet]
        SalesLinesVisible: Boolean;
        [InDataSet]
        PostedShptsVisible: Boolean;
        [InDataSet]
        PostedInvoicesVisible: Boolean;
        [InDataSet]
        PostedReturnRcptsVisible: Boolean;
        [InDataSet]
        PostedCrMemosVisible: Boolean;
        [InDataSet]
        PurchLineVisible: Boolean;
        [InDataSet]
        PurchRcptlineVisible: Boolean;
        [InDataSet]
        PurchInvLineVisible: Boolean;
        [InDataSet]
        PurchReturnShipementVisible: Boolean;
        [InDataSet]
        PurchCrMemoLineVisible: Boolean;
        CurrentMenuTypeOpt: Option x0,x4,x1,x2,x5,x3,x6,x7,x8,x9,x10,x14,x11,x12,x15,x13,x16,x17,x18,x19;

    local procedure ChangeSubMenu(NewMenuType: Integer)
    begin
        IF OldMenuType <> NewMenuType THEN
          SetSubMenu(OldMenuType,FALSE);
        SetSubMenu(NewMenuType,TRUE);
        OldMenuType := NewMenuType;
        CurrentMenuType := NewMenuType;
    end;

    local procedure SetSubMenu(MenuType: Integer;Visible: Boolean)
    var
        SalesLine: Record "Sales Line";
        RecGSalesHeader: Record "Sales Header";
    begin
        CASE MenuType OF
          0..5:
            BEGIN
             SalesLine.SETCURRENTKEY("Document Type","No.");
              IF Visible THEN BEGIN
                  //SalesLine.SETCURRENTKEY("Document Type","Sell-to Customer No.");
                  SalesLine.SETCURRENTKEY("Document Type","No.");
                  SalesLine.SETRANGE("Document Type",MenuType);
                  IF BooGFilterCust THEN BEGIN
                    SalesLine.SETCURRENTKEY("Document Type","Sell-to Customer No.","No.");
                    SalesLine.SETFILTER(SalesLine."Sell-to Customer No.",CodGCustNo);
                  END;
                  CurrPage.SalesLines.PAGE.SETTABLEVIEW(SalesLine);
              END;
                SalesLinesVisible := Visible;
            END;
          6:
            BEGIN
              IF Visible THEN BEGIN
                  IF BooGFilterCust THEN BEGIN
                    RecGSalesShipementLine.RESET;
                    RecGSalesShipementLine.SETCURRENTKEY("Sell-to Customer No.");
                    RecGSalesShipementLine.SETFILTER(RecGSalesShipementLine."Sell-to Customer No.",CodGCustNo);
                    CurrPage.PostedShpts.PAGE.SETTABLEVIEW(RecGSalesShipementLine);
                  END;
                END;
                PostedShptsVisible := Visible;
              END;
          7:
            BEGIN
              IF Visible THEN BEGIN

                  IF BooGFilterCust THEN BEGIN
                    RecGPostdSalesInvoices.RESET;
                    RecGPostdSalesInvoices.SETCURRENTKEY("Sell-to Customer No.");
                    RecGPostdSalesInvoices.SETFILTER(RecGPostdSalesInvoices."Sell-to Customer No.",CodGCustNo);
                    CurrPage.PostedInvoices.PAGE.SETTABLEVIEW(RecGPostdSalesInvoices);
                  END;
                END;
                PostedInvoicesVisible := Visible;
            END;
          8:
            BEGIN
              IF Visible THEN BEGIN
                IF BooGFilterCust THEN BEGIN
                  RecGPostdReturnSales.RESET;
                  RecGPostdReturnSales.SETCURRENTKEY("Sell-to Customer No.");
                  RecGPostdReturnSales.SETFILTER(RecGPostdReturnSales."Sell-to Customer No.",CodGCustNo);
                  CurrPage.PostedReturnRcpts.PAGE.SETTABLEVIEW(RecGPostdReturnSales);
                END;
              END;

                PostedReturnRcptsVisible := Visible;
            END;
          9:
            BEGIN
              IF Visible THEN BEGIN
                IF BooGFilterCust THEN BEGIN
                  RecGPostdCrdMemo.RESET;
                  RecGPostdCrdMemo.SETCURRENTKEY("Sell-to Customer No.");
                  RecGPostdCrdMemo.SETFILTER(RecGPostdCrdMemo."Sell-to Customer No.",CodGCustNo);
                  CurrPage.PostedCrMemos.PAGE.SETTABLEVIEW(RecGPostdCrdMemo);
                END;
              END;
                PostedCrMemosVisible := Visible;
            END;
         10..15:
            BEGIN
              IF Visible THEN BEGIN
                  RecGPurchLines.RESET;
                  RecGPurchLines.SETCURRENTKEY("Document Type","No.");
                  //RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Quote);
                  RecGPurchLines.SETRANGE("Document Type",MenuType MOD 10);
                  IF BooGFilterCust THEN BEGIN
                   RecGPurchLines.SETCURRENTKEY("Document Type",RecGPurchLines."Buy-from Vendor No.","No.");
                   RecGPurchLines.SETFILTER(RecGPurchLines."Buy-from Vendor No.",CodGCustNo);
                  END;
                  CurrPage.PurchLine.PAGE.SETTABLEVIEW(RecGPurchLines);
              END;
              PurchLineVisible := Visible;
            END;
         16:
           BEGIN
             IF Visible THEN BEGIN
               IF BooGFilterCust THEN BEGIN
                 RecGPurchPostedRcpt.RESET;
                 RecGPurchPostedRcpt.SETCURRENTKEY("Buy-from Vendor No.");
                 RecGPurchPostedRcpt.SETFILTER("Buy-from Vendor No.",CodGCustNo);
                 CurrPage.PurchRcptline.PAGE.SETTABLEVIEW(RecGPurchPostedRcpt);
               END;
             END;
            PurchRcptlineVisible := Visible;
           END;
         17:
           BEGIN
             IF Visible THEN BEGIN
               IF BooGFilterCust THEN BEGIN
                 RecGPurchPostedInvoice.RESET;
                 RecGPurchPostedInvoice.SETCURRENTKEY("Buy-from Vendor No.");
                 RecGPurchPostedInvoice.SETFILTER("Buy-from Vendor No.",CodGCustNo);
                 CurrPage.PurchInvLine.PAGE.SETTABLEVIEW(RecGPurchPostedInvoice);
               END;
             END;
             PurchInvLineVisible := Visible;
           END;
         18:
           BEGIN
             IF Visible THEN BEGIN
               IF BooGFilterCust THEN BEGIN
                 RecGPurchPostedReturnShipement.RESET;
                 RecGPurchPostedReturnShipement.SETCURRENTKEY("Buy-from Vendor No.");
                 RecGPurchPostedReturnShipement.SETFILTER("Buy-from Vendor No.",CodGCustNo);
                 CurrPage.PurchReturnShipement.PAGE.SETTABLEVIEW(RecGPurchPostedReturnShipement);
               END;
             END;
             PurchReturnShipementVisible := Visible;
           END;
         19:
           BEGIN
             IF Visible THEN BEGIN
               IF BooGFilterCust THEN BEGIN
                 RecGPurchPostedCrdMemo.RESET;
                 RecGPurchPostedCrdMemo.SETCURRENTKEY("Buy-from Vendor No.");
                 RecGPurchPostedCrdMemo.SETFILTER("Buy-from Vendor No.",CodGCustNo);
                 CurrPage.PurchCrMemoLine.PAGE.SETTABLEVIEW(RecGPurchPostedCrdMemo);
               END;
             END;
             PurchCrMemoLineVisible := Visible;
           END;

        END;
    end;

    procedure "---- FEP-ADVE-200706_18_B ----"()
    begin
    end;

    procedure SetToSalesHeader(NewToSalesLines: Record "Sales Line" ;FilterCust: Boolean)
    var
        RecGSalesHeader: Record "Sales Header";
    begin
        ToSalesHeader.GET(NewToSalesLines."Document Type",NewToSalesLines."Document No.");
        CodGCustNo := NewToSalesLines."Sell-to Customer No.";
        BooGFilterCust := TRUE;
    end;

    procedure SetToPurchHeader(RecPurchLines: Record 39)
    begin
        CodGCustNo := RecPurchLines."Buy-from Vendor No.";
        BooGFilterCust := TRUE;
    end;

    local procedure x0CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(0);
    end;

    local procedure x0CurrentMenuTypeOptOnValidate()
    begin
        x0CurrentMenuTypeOptOnPush;
    end;

    local procedure x4CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(4);
    end;

    local procedure x4CurrentMenuTypeOptOnValidate()
    begin
        x4CurrentMenuTypeOptOnPush;
    end;

    local procedure x1CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(1);
    end;

    local procedure x1CurrentMenuTypeOptOnValidate()
    begin
        x1CurrentMenuTypeOptOnPush;
    end;

    local procedure x2CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(2);
    end;

    local procedure x2CurrentMenuTypeOptOnValidate()
    begin
        x2CurrentMenuTypeOptOnPush;
    end;

    local procedure x5CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(5);
    end;

    local procedure x5CurrentMenuTypeOptOnValidate()
    begin
        x5CurrentMenuTypeOptOnPush;
    end;

    local procedure x3CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(3);
    end;

    local procedure x3CurrentMenuTypeOptOnValidate()
    begin
        x3CurrentMenuTypeOptOnPush;
    end;

    local procedure x6CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(6);
    end;

    local procedure x6CurrentMenuTypeOptOnValidate()
    begin
        x6CurrentMenuTypeOptOnPush;
    end;

    local procedure x7CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(7);
    end;

    local procedure x7CurrentMenuTypeOptOnValidate()
    begin
        x7CurrentMenuTypeOptOnPush;
    end;

    local procedure x8CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(8);
    end;

    local procedure x8CurrentMenuTypeOptOnValidate()
    begin
        x8CurrentMenuTypeOptOnPush;
    end;

    local procedure x9CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(9);
    end;

    local procedure x9CurrentMenuTypeOptOnValidate()
    begin
        x9CurrentMenuTypeOptOnPush;
    end;

    local procedure x10CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(10);
    end;

    local procedure x10CurrentMenuTypeOptOnValidat()
    begin
        x10CurrentMenuTypeOptOnPush;
    end;

    local procedure x14CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(14);
    end;

    local procedure x14CurrentMenuTypeOptOnValidat()
    begin
        x14CurrentMenuTypeOptOnPush;
    end;

    local procedure x11CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(11);
    end;

    local procedure x11CurrentMenuTypeOptOnValidat()
    begin
        x11CurrentMenuTypeOptOnPush;
    end;

    local procedure x12CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(12);
    end;

    local procedure x12CurrentMenuTypeOptOnValidat()
    begin
        x12CurrentMenuTypeOptOnPush;
    end;

    local procedure x15CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(15);
    end;

    local procedure x15CurrentMenuTypeOptOnValidat()
    begin
        x15CurrentMenuTypeOptOnPush;
    end;

    local procedure x13CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(13);
    end;

    local procedure x13CurrentMenuTypeOptOnValidat()
    begin
        x13CurrentMenuTypeOptOnPush;
    end;

    local procedure x16CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(16);
    end;

    local procedure x16CurrentMenuTypeOptOnValidat()
    begin
        x16CurrentMenuTypeOptOnPush;
    end;

    local procedure x17CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(17);
    end;

    local procedure x17CurrentMenuTypeOptOnValidat()
    begin
        x17CurrentMenuTypeOptOnPush;
    end;

    local procedure x18CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(18);
    end;

    local procedure x18CurrentMenuTypeOptOnValidat()
    begin
        x18CurrentMenuTypeOptOnPush;
    end;

    local procedure x19CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(19);
    end;

    local procedure x19CurrentMenuTypeOptOnValidat()
    begin
        x19CurrentMenuTypeOptOnPush;
    end;
}

