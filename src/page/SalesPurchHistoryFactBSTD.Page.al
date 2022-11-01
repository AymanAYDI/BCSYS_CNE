page 60045 "Sales/Purch. History FactB STD"
{
    Caption = 'Item Sales/Purchase History';
    PageType = CardPart;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            group(Sales)
            {
                Caption = 'Sales';
                field(STRSUBSTNO('(%1)',NoOfQuotes);STRSUBSTNO('(%1)',NoOfQuotes))
                {
                    Caption = '&Quotes';

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::Quote);
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfBlanketOrders);STRSUBSTNO('(%1)',NoOfBlanketOrders))
                {
                    Caption = '&Blanket Orders';

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::"Blanket Order");
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfOrders);STRSUBSTNO('(%1)',NoOfOrders))
                {
                    Caption = '&Orders';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::Order);
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoofInvoices);STRSUBSTNO('(%1)',NoofInvoices))
                {
                    Caption = '&Invoices';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::Invoice);
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfReturnOrders);STRSUBSTNO('(%1)',NoOfReturnOrders))
                {
                    Caption = '&Return Orders';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::"Return Order");
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfCreditMemos);STRSUBSTNO('(%1)',NoOfCreditMemos))
                {
                    Caption = 'Cre&dit Memos';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesLine.RESET;
                        CLEAR(PagGSalesLinesSubform3);
                        RecGSalesLine.SETRANGE("Document Type",RecGSalesLines."Document Type"::"Credit Memo");
                        RecGSalesLine.SETRANGE("No." ,"No.");
                        PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                        PagGSalesLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdShipments);STRSUBSTNO('(%1)',NoOfPstdShipments))
                {
                    Caption = '&Posted Shipments';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesShipmentLine.RESET;
                        CLEAR(PagGShipmentLinesSubform3);
                        RecGSalesShipmentLine.SETRANGE("No." ,"No.");
                        PagGShipmentLinesSubform3.SETTABLEVIEW(RecGSalesShipmentLine);
                        PagGShipmentLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdInvoices);STRSUBSTNO('(%1)',NoOfPstdInvoices))
                {
                    Caption = 'Posted I&nvoices';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesInvoiceLine.RESET;
                        CLEAR(PagGInvoiceLinesSubform3);
                        RecGSalesInvoiceLine.SETRANGE("No." ,"No.");
                        PagGInvoiceLinesSubform3.SETTABLEVIEW(RecGSalesInvoiceLine);
                        PagGInvoiceLinesSubform3.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdReturnReceipts);STRSUBSTNO('(%1)',NoOfPstdReturnReceipts))
                {
                    Caption = 'Posted Ret&urn Receipts';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGReturnReceiptLine.RESET;
                        CLEAR(PagGGReturnRcptLinesSubform2);
                        RecGReturnReceiptLine.SETRANGE("No." ,"No.");
                        PagGGReturnRcptLinesSubform2.SETTABLEVIEW(RecGReturnReceiptLine);
                        PagGGReturnRcptLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NoOfPstdCreditMemos);STRSUBSTNO('(%1)',NoOfPstdCreditMemos))
                {
                    Caption = 'Posted Cr. &Memos';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGSalesCrMemoLine.RESET;
                        CLEAR(PagGCreditMemoLinesSubform2);
                        RecGSalesCrMemoLine.SETRANGE("No." ,"No.");
                        PagGCreditMemoLinesSubform2.SETTABLEVIEW(RecGSalesCrMemoLine);
                        PagGCreditMemoLinesSubform2.RUN;
                    end;
                }
            }
            group(Purchases)
            {
                Caption = 'Purchases';
                field(STRSUBSTNO('(%1)',NbrOfPurchQuote);STRSUBSTNO('(%1)',NbrOfPurchQuote))
                {
                    Caption = 'Purch Quote';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Quote);
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchBlanketOrder);STRSUBSTNO('(%1)',NbrOfPurchBlanketOrder))
                {
                    Caption = 'Blanket Order Purchas ';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Blanket Order");
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchOrder);STRSUBSTNO('(%1)',NbrOfPurchOrder))
                {
                    Caption = 'Purchase Order';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Order);
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchInvoice);STRSUBSTNO('(%1)',NbrOfPurchInvoice))
                {
                    Caption = 'Purchase Invoice';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Invoice);
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchReturn);STRSUBSTNO('(%1)',NbrOfPurchReturn))
                {
                    Caption = 'Purchase Return';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Return Order");
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchCrdMemo);STRSUBSTNO('(%1)',NbrOfPurchCrdMemo))
                {
                    Caption = 'Purchase Credit Memo';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchLines.RESET;
                        CLEAR(PagGPurchaseLinesSubform2);
                        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::"Credit Memo");
                        RecGPurchLines.SETRANGE("No." ,"No.");
                        PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                        PagGPurchaseLinesSubform2.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedRcpt);STRSUBSTNO('(%1)',NbrOfPurchPostedRcpt))
                {
                    Caption = 'Posted Purchase Receipt';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchPostedRcpt.RESET;
                        CLEAR(PagGPurchRcpLinesSubform);
                        RecGPurchPostedRcpt.SETRANGE("No." ,"No.");
                        PagGPurchRcpLinesSubform.SETTABLEVIEW(RecGPurchPostedRcpt);
                        PagGPurchRcpLinesSubform.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedInvoice);STRSUBSTNO('(%1)',NbrOfPurchPostedInvoice))
                {
                    Caption = 'Posted Purchase Invoice';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        RecGPurchPostedInvoice.RESET;
                        CLEAR(PagGPurchInvLineSubform);
                        RecGPurchPostedInvoice.SETRANGE("No." ,"No.");
                        PagGPurchInvLineSubform.SETTABLEVIEW(RecGPurchPostedInvoice);
                        PagGPurchInvLineSubform.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedReturnShipemen);STRSUBSTNO('(%1)',NbrOfPurchPostedReturnShipemen))
                {
                    Caption = 'Posted Purchase Return Shipement';
                    Editable = false;

                    trigger OnDrillDown()
                    begin

                        RecGPurchPostedReturnShipement.RESET;
                        CLEAR(PagGReturnShipmentLineSubform);
                        RecGPurchPostedReturnShipement.SETRANGE("No." ,"No.");
                        PagGReturnShipmentLineSubform.SETTABLEVIEW(RecGPurchPostedReturnShipement);
                        PagGReturnShipmentLineSubform.RUN;
                    end;
                }
                field(STRSUBSTNO('(%1)',NbrOfPurchPostedCrdMemo);STRSUBSTNO('(%1)',NbrOfPurchPostedCrdMemo))
                {
                    Caption = 'Posted Purchase Credit Memo';
                    Editable = false;

                    trigger OnDrillDown()
                    begin

                        RecGPurchPostedCrdMemo.RESET;
                        CLEAR(PagGPurchCrMemoLineSubform);
                        RecGPurchPostedCrdMemo.SETRANGE("No." ,"No.");
                        PagGPurchCrMemoLineSubform.SETTABLEVIEW(RecGPurchPostedCrdMemo);
                        PagGPurchCrMemoLineSubform.RUN;
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
        NoOfQuotes:=0;
        NoOfBlanketOrders:=0;
        NoOfOrders:=0;
        NoofInvoices:=0;
        NoOfReturnOrders:=0;
        NoOfCreditMemos:=0;
        NoOfPstdShipments:=0;
        NoOfPstdInvoices:=0;
        NoOfPstdReturnReceipts:=0;
        NoOfPstdCreditMemos:=0;
        ///
        NbrOfPurchQuote:=0;
        NbrOfPurchBlanketOrder:=0;
        NbrOfPurchOrder:=0;
        NbrOfPurchInvoice:=0;
        NbrOfPurchReturn:=0;
        NbrOfPurchCrdMemo:=0;
        NbrOfPurchPostedRcpt:=0;
        NbrOfPurchPostedInvoice:=0;
        NbrOfPurchPostedReturnShipemen:=0;
        NbrOfPurchPostedCrdMemo:=0;



        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::Quote);
        RecGSalesLine.SETFILTER("No.","No.");


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

        IF RecGPostdCrdMemo.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPostdCrdMemo."Document No." THEN
              NoOfPstdCreditMemos:= NoOfPstdCreditMemos + 1;
            CodGDocNo := RecGPostdCrdMemo."Document No.";
          UNTIL RecGPostdCrdMemo.NEXT =0;
        END;
        ////
        //Purchase quote
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type","No.");
        RecGPurchLines.SETFILTER("No.","No.");
        RecGPurchLines.SETRANGE("Document Type",RecGPurchLines."Document Type"::Quote);

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

        IF RecGPurchPostedCrdMemo.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPurchPostedCrdMemo."Document No." THEN
              NbrOfPurchPostedCrdMemo:= NbrOfPurchPostedCrdMemo + 1;
            CodGDocNo := RecGPurchPostedCrdMemo."Document No.";
          UNTIL RecGPurchPostedCrdMemo.NEXT =0;
        END;
    end;

    trigger OnOpenPage()
    begin

        //Quote
    end;

    var
        RecGSalesLine: Record "37";
        CodGDocNo: Code[20];
        PagGSalesLinesSubform3: Page "50041";
                                    RecGSalesLines: Record "37";
                                    NoOfBlanketOrders: Integer;
                                    NoOfOrders: Integer;
                                    NoOfQuotes: Integer;
                                    NoofInvoices: Integer;
                                    NoOfReturnOrders: Integer;
                                    NoOfCreditMemos: Integer;
                                    NoOfPstdShipments: Integer;
                                    NoOfPstdInvoices: Integer;
                                    NoOfPstdReturnReceipts: Integer;
                                    NoOfPstdCreditMemos: Integer;
                                    RecGSalesShipementLine: Record "111";
                                    RecGPostdSalesInvoices: Record "113";
                                    RecGPostdReturnSales: Record "6661";
                                    RecGPostdCrdMemo: Record "115";
                                    PagGShipmentLinesSubform3: Page "50042";
                                    RecGSalesShipmentLine: Record "111";
                                    RecGSalesInvoiceLine: Record "113";
                                    PagGInvoiceLinesSubform3: Page "50043";
                                    RecGSalesCrMemoLine: Record "115";
                                    PagGCreditMemoLinesSubform2: Page "50039";
                                    PagGGReturnRcptLinesSubform2: Page "50040";
                                    RecGReturnReceiptLine: Record "6661";
                                    "---------": Integer;
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
                                    RecGPurchLines: Record "39";
                                    RecGPurchPostedRcpt: Record "121";
                                    RecGPurchPostedInvoice: Record "123";
                                    RecGPurchPostedReturnShipement: Record "6651";
                                    RecGPurchPostedCrdMemo: Record "125";
                                    PagGPurchaseLinesSubform2: Page "50016";
                                    PagGPurchRcpLinesSubform: Page "50017";
                                    PagGPurchInvLineSubform: Page "50018";
                                    PagGReturnShipmentLineSubform: Page "50030";
                                    PagGPurchCrMemoLineSubform: Page "50019";
}

