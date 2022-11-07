page 50028 "Sales History Sell-to FactBox"
{
    Caption = 'Item Sales History';
    PageType = CardPart;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            field(LastPrice; LastPrice)
            {
                Caption = 'DP';
            }
            field(LastMarge; LastMarge)
            {
                Caption = 'DM';
            }
            field(LastRemise; LastRemise)
            {
                Caption = 'DR';
            }
            field("Customer No."; RecGCustomer."No.")
            {
                Caption = 'Customer No.';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("&Quotes"; STRSUBSTNO('(%1)', NoOfQuotes))
            {
                Caption = '&Quotes';

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Quote);
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("&Blanket Orders"; STRSUBSTNO('(%1)', NoOfBlanketOrders))
            {
                Caption = '&Blanket Orders';
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Blanket Order");
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("&Orders"; STRSUBSTNO('(%1)', NoOfOrders))
            {
                Caption = '&Orders';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Order);
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("&Invoices"; STRSUBSTNO('(%1)', NoofInvoices))
            {
                Caption = '&Invoices';
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::Invoice);
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("&Return Orders"; STRSUBSTNO('(%1)', NoOfReturnOrders))
            {
                Caption = '&Return Orders';
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Return Order");
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("Cre&dit Memos"; STRSUBSTNO('(%1)', NoOfCreditMemos))
            {
                Caption = 'Cre&dit Memos';
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGSalesLine.RESET();
                    CLEAR(PagGSalesLinesSubform3);
                    RecGSalesLine.SETRANGE("Document Type", RecGSalesLines."Document Type"::"Credit Memo");
                    RecGSalesLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesLine.SETRANGE("No.", "No.");
                    PagGSalesLinesSubform3.SETTABLEVIEW(RecGSalesLine);
                    PagGSalesLinesSubform3.RUN();
                end;
            }
            field("&Posted Shipments"; STRSUBSTNO('(%1)', NoOfPstdShipments))
            {
                Caption = '&Posted Shipments';
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGSalesShipmentLine.RESET();
                    CLEAR(PagGShipmentLinesSubform3);
                    RecGSalesShipmentLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesShipmentLine.SETRANGE("No.", "No.");
                    PagGShipmentLinesSubform3.SETTABLEVIEW(RecGSalesShipmentLine);
                    PagGShipmentLinesSubform3.RUN();
                end;
            }
            field("Posted I&nvoices"; STRSUBSTNO('(%1)', NoOfPstdInvoices))
            {
                Caption = 'Posted I&nvoices';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGSalesInvoiceLine.RESET();
                    CLEAR(PagGInvoiceLinesSubform3);
                    RecGSalesInvoiceLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesInvoiceLine.SETRANGE("No.", "No.");
                    PagGInvoiceLinesSubform3.SETTABLEVIEW(RecGSalesInvoiceLine);
                    PagGInvoiceLinesSubform3.RUN();
                end;
            }
            field("Posted Ret&urn Receipts"; STRSUBSTNO('(%1)', NoOfPstdReturnReceipts))
            {
                Caption = 'Posted Ret&urn Receipts';
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    RecGReturnReceiptLine.RESET();
                    CLEAR(PagGGReturnRcptLinesSubform2);
                    RecGReturnReceiptLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGReturnReceiptLine.SETRANGE("No.", "No.");
                    PagGGReturnRcptLinesSubform2.SETTABLEVIEW(RecGReturnReceiptLine);
                    PagGGReturnRcptLinesSubform2.RUN();
                end;
            }
            field("Posted Cr. &Memos"; STRSUBSTNO('(%1)', NoOfPstdCreditMemos))
            {
                Caption = 'Posted Cr. &Memos';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGSalesCrMemoLine.RESET();
                    CLEAR(PagGCreditMemoLinesSubform2);
                    RecGSalesCrMemoLine.SETRANGE("Sell-to Customer No.", RecGCustomer."No.");
                    RecGSalesCrMemoLine.SETRANGE("No.", "No.");
                    PagGCreditMemoLinesSubform2.SETTABLEVIEW(RecGSalesCrMemoLine);
                    PagGCreditMemoLinesSubform2.RUN();
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        RecGSalesLine2: Record "Sales Line";
    begin
        //>>MIGRATION 2013
        //RecGCustomer.GET("Sell-to Customer No.");
        IF NOT RecGCustomer.GET("Sell-to Customer No.") THEN
            RecGCustomer.INIT();
        //<<MIGRATION 2013

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

        //>>MIGRATION 2013
        IF "No." = '' THEN
            EXIT;
        //<<MIGRATION 2013

        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Quote);
        RecGSalesLine.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        //END;

        //>>MIGRATION 2013 ALMI
        //IF RecGSalesLine.FIND('-') THEN BEGIN
        IF RecGSalesLine.FINDSET() THEN BEGIN
            //<<
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfQuotes := NoOfQuotes + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;
        END;

        /*
        //Blanket Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Blanket Order");
        RecGSalesLine.SETFILTER("No.","No.");
        
        //IF BooGFilterCust THEN BEGIN
          RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
          RecGSalesLine.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        //END;
        
        
        
        //IF RecGSalesLine.FIND('-') THEN BEGIN
        IF RecGSalesLine.FINDSET THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfBlanketOrders := NoOfBlanketOrders + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;
        */

        //Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Order);
        RecGSalesLine.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        //END;

        //IF RecGSalesLine.FIND('-') THEN BEGIN
        IF RecGSalesLine.FINDSET() THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfOrders := NoOfOrders + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;
        END;

        //Last Order
        RecGSalesLine2.RESET();
        //RecGSalesLine2.SETCURRENTKEY("Document Type","No.");
        //>>TI271161
        //RecGSalesLine2.SETCURRENTKEY("Document Type","Sell-to Customer No.");
        RecGSalesLine2.SETCURRENTKEY("Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
        //<<TI271161
        RecGSalesLine2.SETRANGE("Document Type", RecGSalesLine2."Document Type"::Order);
        RecGSalesLine2.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        RecGSalesLine2.SETRANGE("No.", "No.");

        //RecGSalesLine2.SETRANGE("Document No.",'<>%1',"Document No.");
        //>>TDL.52
        RecGSalesLine2.SETFILTER("Document No.", '<>%1', "Document No.");
        //<<TDL.52
        IF RecGSalesLine2.FINDLAST() THEN BEGIN
            //>>TDL.52
            //IF "Document Type" = "Document Type"::Order THEN
            //  RecGSalesLine2.NEXT(-1);
            //<<TDL.52
            LastPrice := RecGSalesLine2."BC6_Discount unit price";
            LastMarge := RecGSalesLine2."Profit %";
            LastRemise := RecGSalesLine2."Line Discount %";
        END;

        /*
        //Invoices
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::Invoice);
        RecGSalesLine.SETFILTER("No.","No.");
        
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        
        //IF RecGSalesLine.FIND('-')
        IF RecGSalesLine.FINDSET THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoofInvoices := NoofInvoices + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;
        */

        /*
        //Return Order
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Return Order");
        RecGSalesLine.SETFILTER("No.","No.");
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        //IF RecGSalesLine.FIND('-') THEN BEGIN
        IF RecGSalesLine.FINDSET THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfReturnOrders := NoOfReturnOrders + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;
        */

        /*
        //Credit Memo
        CLEAR(CodGDocNo);
        RecGSalesLine.RESET;
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type",RecGSalesLine."Document Type"::"Credit Memo");
        RecGSalesLine.SETFILTER("No.","No.");
        
        RecGSalesLine.SETCURRENTKEY("Document Type",RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        
        //IF RecGSalesLine.FIND('-') THEN BEGIN
        IF RecGSalesLine.FINDSET THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesLine."Document No." THEN
              NoOfCreditMemos := NoOfCreditMemos + 1;
            CodGDocNo := RecGSalesLine."Document No.";
          UNTIL RecGSalesLine.NEXT =0;
        END;
        */

        /*
        //Posted SHipements
        CLEAR(CodGDocNo);
        RecGSalesShipementLine.RESET;
        RecGSalesShipementLine.SETCURRENTKEY("No.");
        RecGSalesShipementLine.SETFILTER("No.","No.");
        
        RecGSalesShipementLine.SETCURRENTKEY(RecGSalesShipementLine."Sell-to Customer No.");
        RecGSalesShipementLine.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        
        //IF RecGSalesShipementLine.FIND('-') THEN BEGIN
        IF RecGSalesShipementLine.FINDSET THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGSalesShipementLine."Document No." THEN
              NoOfPstdShipments:= NoOfPstdShipments + 1;
            CodGDocNo := RecGSalesShipementLine."Document No.";
          UNTIL RecGSalesShipementLine.NEXT =0;
        END;
        */


        // Posted Invoices
        CLEAR(CodGDocNo);
        RecGPostdSalesInvoices.RESET();
        RecGPostdSalesInvoices.SETCURRENTKEY("No.");
        RecGPostdSalesInvoices.SETFILTER("No.", "No.");

        RecGPostdSalesInvoices.SETCURRENTKEY(RecGPostdSalesInvoices."Sell-to Customer No.");
        RecGPostdSalesInvoices.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");

        //IF RecGPostdSalesInvoices.FIND('-') THEN BEGIN
        IF RecGPostdSalesInvoices.FINDSET() THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPostdSalesInvoices."Document No." THEN
                    NoOfPstdInvoices := NoOfPstdInvoices + 1;
                CodGDocNo := RecGPostdSalesInvoices."Document No.";
            UNTIL RecGPostdSalesInvoices.NEXT() = 0;
        END;


        /*
        // Posted Return Receipts
        CLEAR(CodGDocNo);
        RecGPostdReturnSales.RESET;
        RecGPostdReturnSales.SETCURRENTKEY("No.");
        RecGPostdReturnSales.SETFILTER("No.","No.");
        
        RecGPostdReturnSales.SETCURRENTKEY(RecGPostdReturnSales."Sell-to Customer No.");
        RecGPostdReturnSales.SETFILTER("Sell-to Customer No.","Sell-to Customer No.");
        
        IF RecGPostdReturnSales.FINDSET THEN BEGIN
        //IF RecGPostdReturnSales.FIND('-') THEN BEGIN
          REPEAT
            IF  CodGDocNo <> RecGPostdReturnSales."Document No." THEN
              NoOfPstdReturnReceipts:= NoOfPstdReturnReceipts + 1;
            CodGDocNo := RecGPostdReturnSales."Document No.";
          UNTIL RecGPostdReturnSales.NEXT =0;
        END;
        */

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPostdCrdMemo.RESET();
        RecGPostdCrdMemo.SETCURRENTKEY("No.");
        RecGPostdCrdMemo.SETFILTER("No.", "No.");

        RecGPostdCrdMemo.SETCURRENTKEY(RecGPostdCrdMemo."Sell-to Customer No.");
        RecGPostdCrdMemo.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");

        //IF RecGPostdCrdMemo.FIND('-') THEN BEGIN
        IF RecGPostdCrdMemo.FINDSET() THEN
            REPEAT
                IF CodGDocNo <> RecGPostdCrdMemo."Document No." THEN
                    NoOfPstdCreditMemos := NoOfPstdCreditMemos + 1;
                CodGDocNo := RecGPostdCrdMemo."Document No.";
            UNTIL RecGPostdCrdMemo.NEXT() = 0;

    end;

    trigger OnOpenPage()
    begin

        //Quote
    end;

    var
        RecGSalesLine: Record "Sales Line";
        RecGCustomer: Record Customer;
        RecGSalesLines: Record "Sales Line";
        RecGSalesShipementLine: Record "Sales Shipment Line";
        RecGPostdSalesInvoices: Record "Sales Invoice Line";
        RecGPostdReturnSales: Record "Return Receipt Line";
        RecGPostdCrdMemo: Record "Sales Cr.Memo Line";
        RecGSalesShipmentLine: Record "Sales Shipment Line";
        RecGSalesInvoiceLine: Record "Sales Invoice Line";
        RecGReturnReceiptLine: Record "Return Receipt Line";
        RecGSalesCrMemoLine: Record "Sales Cr.Memo Line";
        PagGShipmentLinesSubform3: page "BC6_Shipment Lines Subform 3";
        PagGSalesLinesSubform3: Page "BC6_Sales Lines Subform 3";
        PagGInvoiceLinesSubform3: Page "BC6_Invoice Lines Subform 3";
        PagGCreditMemoLinesSubform2: Page "Credit Memo Lines Subform 2";
        PagGGReturnRcptLinesSubform2: Page "Return Rcpt Lines Subform 2";

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
        "-PRODWARE MIG 2013-": Integer;
        LastPrice: Decimal;
        LastMarge: Decimal;
        LastRemise: Decimal;
        CodGDocNo: Code[20];


    procedure ShowDetails()
    begin

        PAGE.RUN(PAGE::"Customer Card", RecGCustomer);
    end;
}

