page 50028 "BC6_Sales Hist. Sellto FactBox"
{
    Caption = 'Item Sales History', Comment = 'FRA="Historique vente article"';
    PageType = CardPart;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            field(LastPrice; LastPrice)
            {
                Caption = 'DP';
                ApplicationArea = All;
            }
            field(LastMarge; LastMarge)
            {
                Caption = 'DM';
                ApplicationArea = All;
            }
            field(LastRemise; LastRemise)
            {
                Caption = 'DR';
                ApplicationArea = All;
            }
            field("Customer No."; RecGCustomer."No.")
            {
                Caption = 'Customer No.', Comment = 'FRA="N° client"';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("&Quotes"; STRSUBSTNO(Txt1, NoOfQuotes))
            {
                Caption = '&Quotes', Comment = 'FRA="&Devis"';
                ApplicationArea = All;

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
            field("&Blanket Orders"; STRSUBSTNO(Txt1, NoOfBlanketOrders))
            {
                Caption = '&Blanket Orders', Comment = 'FRA="&Commandes ouvertes"';
                Visible = false;
                ApplicationArea = All;

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
            field("&Orders"; STRSUBSTNO(Txt1, NoOfOrders))
            {
                Caption = '&Orders', Comment = 'FRA="C&ommandes"';
                Editable = false;
                ApplicationArea = All;

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
            field("&Invoices"; STRSUBSTNO(Txt1, NoofInvoices))
            {
                Caption = '&Invoices', Comment = 'FRA="&Factures"';
                Editable = false;
                Visible = false;
                ApplicationArea = All;

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
            field("&Return Orders"; STRSUBSTNO(Txt1, NoOfReturnOrders))
            {
                Caption = '&Return Orders', Comment = 'FRA="&Retours"';
                Editable = false;
                Visible = false;
                ApplicationArea = All;

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
            field("Cre&dit Memos"; STRSUBSTNO(Txt1, NoOfCreditMemos))
            {
                Caption = 'Cre&dit Memos', Comment = 'FRA="A&voirs"';
                Editable = false;
                Visible = false;
                ApplicationArea = All;

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
            field("&Posted Shipments"; STRSUBSTNO(Txt1, NoOfPstdShipments))
            {
                Caption = '&Posted Shipments', Comment = 'FRA="Ex&péditions enregistrées"';
                Editable = false;
                Visible = false;
                ApplicationArea = All;

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
            field("Posted I&nvoices"; STRSUBSTNO(Txt1, NoOfPstdInvoices))
            {
                Caption = 'Posted I&nvoices', Comment = 'FRA="Factures e&nregistrées"';
                Editable = false;
                ApplicationArea = All;

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
            field("Posted Ret&urn Receipts"; STRSUBSTNO(Txt1, NoOfPstdReturnReceipts))
            {
                Caption = 'Posted Ret&urn Receipts', Comment = 'FRA="Réceptions reto&ur enregistrées"';
                Editable = false;
                Visible = false;
                ApplicationArea = All;

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
            field("Posted Cr. &Memos"; STRSUBSTNO(Txt1, NoOfPstdCreditMemos))
            {
                Caption = 'Posted Cr. &Memos', Comment = 'FRA="&Avoirs enregistrés"';
                Editable = false;
                ApplicationArea = All;

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
        IF NOT RecGCustomer.GET("Sell-to Customer No.") THEN
            RecGCustomer.INIT();
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
        IF "No." = '' THEN
            EXIT;
        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Quote);
        RecGSalesLine.SETFILTER("No.", "No.");
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        IF RecGSalesLine.FINDSET() THEN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfQuotes := NoOfQuotes + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGSalesLine.RESET();
        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."No.");
        RecGSalesLine.SETRANGE("Document Type", RecGSalesLine."Document Type"::Order);
        RecGSalesLine.SETFILTER("No.", "No.");

        RecGSalesLine.SETCURRENTKEY("Document Type", RecGSalesLine."Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        IF RecGSalesLine.FINDSET() THEN
            REPEAT
                IF CodGDocNo <> RecGSalesLine."Document No." THEN
                    NoOfOrders := NoOfOrders + 1;
                CodGDocNo := RecGSalesLine."Document No.";
            UNTIL RecGSalesLine.NEXT() = 0;


        RecGSalesLine2.RESET();
        RecGSalesLine2.SETCURRENTKEY("Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
        RecGSalesLine2.SETRANGE("Document Type", RecGSalesLine2."Document Type"::Order);
        RecGSalesLine2.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        RecGSalesLine2.SETRANGE("No.", "No.");
        RecGSalesLine2.SETFILTER("Document No.", '<>%1', "Document No.");
        IF RecGSalesLine2.FINDLAST() THEN BEGIN
            LastPrice := RecGSalesLine2."BC6_Discount unit price";
            LastMarge := RecGSalesLine2."Profit %";
            LastRemise := RecGSalesLine2."Line Discount %";
        END;

        CLEAR(CodGDocNo);
        RecGPostdSalesInvoices.RESET();
        RecGPostdSalesInvoices.SETCURRENTKEY("No.");
        RecGPostdSalesInvoices.SETFILTER("No.", "No.");

        RecGPostdSalesInvoices.SETCURRENTKEY(RecGPostdSalesInvoices."Sell-to Customer No.");
        RecGPostdSalesInvoices.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");

        IF RecGPostdSalesInvoices.FINDSET() THEN
            REPEAT
                IF CodGDocNo <> RecGPostdSalesInvoices."Document No." THEN
                    NoOfPstdInvoices := NoOfPstdInvoices + 1;
                CodGDocNo := RecGPostdSalesInvoices."Document No.";
            UNTIL RecGPostdSalesInvoices.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPostdCrdMemo.RESET();
        RecGPostdCrdMemo.SETCURRENTKEY("No.");
        RecGPostdCrdMemo.SETFILTER("No.", "No.");

        RecGPostdCrdMemo.SETCURRENTKEY(RecGPostdCrdMemo."Sell-to Customer No.");
        RecGPostdCrdMemo.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");

        IF RecGPostdCrdMemo.FINDSET() THEN
            REPEAT
                IF CodGDocNo <> RecGPostdCrdMemo."Document No." THEN
                    NoOfPstdCreditMemos := NoOfPstdCreditMemos + 1;
                CodGDocNo := RecGPostdCrdMemo."Document No.";
            UNTIL RecGPostdCrdMemo.NEXT() = 0;
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        RecGCustomer: Record Customer;
        RecGPostdReturnSales: Record "Return Receipt Line";
        RecGReturnReceiptLine: Record "Return Receipt Line";
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
        PagGSalesLinesSubform3: Page "BC6_Sales Lines Subform 3";
        PagGShipmentLinesSubform3: page "BC6_Shipment Lines Subform 3";
        PagGGReturnRcptLinesSubform2: Page "Return Rcpt Lines Subform 2";
        CodGDocNo: Code[20];
        LastMarge: Decimal;
        LastPrice: Decimal;
        LastRemise: Decimal;

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
        Txt1: Label '(%1)';

    procedure ShowDetails()
    begin

        PAGE.RUN(PAGE::"Customer Card", RecGCustomer);
    end;
}
