page 50029 "Purch History By-From FactBox"
{
    Caption = 'Item Purchases History';
    PageType = CardPart;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            field("Vendor No."; RecGVendor."No.")
            {
                Caption = 'Vendor No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field("Purch Quote"; STRSUBSTNO('(%1)', NbrOfPurchQuote))
            {
                Caption = 'Purch Quote';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Blanket Order Purchas"; STRSUBSTNO('(%1)', NbrOfPurchBlanketOrder))
            {
                Caption = 'Blanket Order Purchas';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Blanket Order");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Purchase Order"; STRSUBSTNO('(%1)', NbrOfPurchOrder))
            {
                Caption = 'Purchase Order';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Purchase Invoice"; STRSUBSTNO('(%1)', NbrOfPurchInvoice))
            {
                Caption = 'Purchase Invoice';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Purchase Return"; STRSUBSTNO('(%1)', NbrOfPurchReturn))
            {
                Caption = 'Purchase Return';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Purchase Credit Memo"; STRSUBSTNO('(%1)', NbrOfPurchCrdMemo))
            {
                Caption = 'Purchase Credit Memo';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET;
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", "No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN;
                end;
            }
            field("Posted Purchase Receipt"; STRSUBSTNO('(%1)', NbrOfPurchPostedRcpt))
            {
                Caption = 'Posted Purchase Receipt';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchPostedRcpt.RESET;
                    CLEAR(PagGPurchRcpLinesSubform);
                    RecGPurchPostedRcpt.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedRcpt.SETRANGE("No.", "No.");
                    PagGPurchRcpLinesSubform.SETTABLEVIEW(RecGPurchPostedRcpt);
                    PagGPurchRcpLinesSubform.RUN;
                end;
            }
            field("Posted Purchase Invoice"; STRSUBSTNO('(%1)', NbrOfPurchPostedInvoice))
            {
                Caption = 'Posted Purchase Invoice';
                Editable = false;

                trigger OnDrillDown()
                begin
                    RecGPurchPostedInvoice.RESET;
                    CLEAR(PagGPurchInvLineSubform);
                    RecGPurchPostedInvoice.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedInvoice.SETRANGE("No.", "No.");
                    PagGPurchInvLineSubform.SETTABLEVIEW(RecGPurchPostedInvoice);
                    PagGPurchInvLineSubform.RUN;
                end;
            }
            field("Posted Purchase Return Shipement"; STRSUBSTNO('(%1)', NbrOfPurchPostedReturnShipemen))
            {
                Caption = 'Posted Purchase Return Shipement';
                Editable = false;

                trigger OnDrillDown()
                begin

                    RecGPurchPostedReturnShipement.RESET;
                    CLEAR(PagGReturnShipmentLineSubform);
                    RecGPurchPostedReturnShipement.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedReturnShipement.SETRANGE("No.", "No.");
                    PagGReturnShipmentLineSubform.SETTABLEVIEW(RecGPurchPostedReturnShipement);
                    PagGReturnShipmentLineSubform.RUN;
                end;
            }
            field("Posted Purchase Credit Memo"; STRSUBSTNO('(%1)', NbrOfPurchPostedCrdMemo))
            {
                Caption = 'Posted Purchase Credit Memo';
                Editable = false;

                trigger OnDrillDown()
                begin

                    RecGPurchPostedCrdMemo.RESET;
                    CLEAR(PagGPurchCrMemoLineSubform);
                    RecGPurchPostedCrdMemo.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedCrdMemo.SETRANGE("No.", "No.");
                    PagGPurchCrMemoLineSubform.SETTABLEVIEW(RecGPurchPostedCrdMemo);
                    PagGPurchCrMemoLineSubform.RUN;
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //>>MIGRATION 2013
        //RecGVendor.GET("Buy-from Vendor No.");
        IF NOT RecGVendor.GET("Buy-from Vendor No.") THEN
            RecGVendor.INIT;

        //<<MIGRATIONS 2013
        CLEAR(CodGDocNo);
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

        //>>MIGRATION 2013
        IF "No." = '' THEN
            EXIT;
        //<<MIGRATION 2013

        //Purchase quote
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchQuote := NbrOfPurchQuote + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase blanket order
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Blanket Order");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchBlanketOrder := NbrOfPurchBlanketOrder + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase order
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchOrder := NbrOfPurchOrder + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchInvoice := NbrOfPurchInvoice + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase return
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchReturn := NbrOfPurchReturn + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        //Purchase credit memo
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET;
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", "No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;
        IF RecGPurchLines.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchCrdMemo := NbrOfPurchCrdMemo + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT = 0;
        END;

        // Posted Purchase Receipt
        CLEAR(CodGDocNo);
        RecGPurchPostedRcpt.RESET;
        RecGPurchPostedRcpt.SETCURRENTKEY("No.");
        RecGPurchPostedRcpt.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchPostedRcpt.SETCURRENTKEY(RecGPurchPostedRcpt."Buy-from Vendor No.");
        RecGPurchPostedRcpt.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;

        IF RecGPurchPostedRcpt.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedRcpt."Document No." THEN
                    NbrOfPurchPostedRcpt := NbrOfPurchPostedRcpt + 1;
                CodGDocNo := RecGPurchPostedRcpt."Document No.";
            UNTIL RecGPurchPostedRcpt.NEXT = 0;
        END;

        // Posted Purchase invoice
        CLEAR(CodGDocNo);
        RecGPurchPostedInvoice.RESET;
        RecGPurchPostedInvoice.SETCURRENTKEY("No.");
        RecGPurchPostedInvoice.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchPostedInvoice.SETCURRENTKEY(RecGPurchPostedInvoice."Buy-from Vendor No.");
        RecGPurchPostedInvoice.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;

        IF RecGPurchPostedInvoice.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedInvoice."Document No." THEN
                    NbrOfPurchPostedInvoice := NbrOfPurchPostedInvoice + 1;
                CodGDocNo := RecGPurchPostedInvoice."Document No.";
            UNTIL RecGPurchPostedInvoice.NEXT = 0;
        END;

        // Posted Purchase Return Shipement
        CLEAR(CodGDocNo);
        RecGPurchPostedReturnShipement.RESET;
        RecGPurchPostedReturnShipement.SETCURRENTKEY("No.");
        RecGPurchPostedReturnShipement.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchPostedReturnShipement.SETCURRENTKEY(RecGPurchPostedReturnShipement."Buy-from Vendor No.");
        RecGPurchPostedReturnShipement.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;

        IF RecGPurchPostedReturnShipement.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedReturnShipement."Document No." THEN
                    NbrOfPurchPostedReturnShipemen := NbrOfPurchPostedReturnShipemen + 1;
                CodGDocNo := RecGPurchPostedReturnShipement."Document No.";
            UNTIL RecGPurchPostedReturnShipement.NEXT = 0;
        END;

        // Posted Credit Memo
        CLEAR(CodGDocNo);
        RecGPurchPostedCrdMemo.RESET;
        RecGPurchPostedCrdMemo.SETCURRENTKEY("No.");
        RecGPurchPostedCrdMemo.SETFILTER("No.", "No.");

        //IF BooGFilterCust THEN BEGIN
        RecGPurchPostedCrdMemo.SETCURRENTKEY(RecGPurchPostedCrdMemo."Buy-from Vendor No.");
        RecGPurchPostedCrdMemo.SETFILTER("Buy-from Vendor No.", "Buy-from Vendor No.");
        //END;

        IF RecGPurchPostedCrdMemo.FIND('-') THEN BEGIN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedCrdMemo."Document No." THEN
                    NbrOfPurchPostedCrdMemo := NbrOfPurchPostedCrdMemo + 1;
                CodGDocNo := RecGPurchPostedCrdMemo."Document No.";
            UNTIL RecGPurchPostedCrdMemo.NEXT = 0;
        END;
    end;

    var
        RecGVendor: Record Vendor;
        RecGPurchLines: Record "Purchase Line";
        RecGPurchPostedRcpt: Record "Purch. Rcpt. Line";
        RecGPurchPostedInvoice: Record "Purch. Inv. Line";
        RecGPurchPostedReturnShipement: Record "Return Shipment Line";
        RecGPurchPostedCrdMemo: Record "Purch. Cr. Memo Line";
        PagGPurchaseLinesSubform2: Page "BC6_Purchase Lines Subform2";
        PagGPurchRcpLinesSubform: Page "BC6_Purch. Rcpt. Lines Subform";
        PagGPurchInvLineSubform: Page "BC6_Purch. Inv. Line Subform";
        PagGReturnShipmentLineSubform: Page "Return Shipment Line Subform";
        PagGPurchCrMemoLineSubform: Page "Purch. Cr. Memo Line Subform";
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
        CodGDocNo: Code[20];


    procedure ShowDetails()
    begin

        PAGE.RUN(PAGE::"Vendor Card", RecGVendor);
    end;
}
