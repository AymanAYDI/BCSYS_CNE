page 50029 "BC6_Purch His. By-From FactBox"
{
    Caption = 'Item Purchases History', Comment = 'FRA="Historique des Achats article"';
    PageType = CardPart;
    SourceTable = "Purchase Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field("Vendor No."; RecGVendor."No.")
            {
                Caption = 'Vendor No.', Comment = 'FRA="N°fournisseur"';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("Purch Quote"; STRSUBSTNO(Txt1, NbrOfPurchQuote))
            {
                Caption = 'Purch Quote', Comment = 'FRA="Demandes de prix"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Blanket Order Purchas"; STRSUBSTNO(Txt1, NbrOfPurchBlanketOrder))
            {
                Caption = 'Blanket Order Purchas', Comment = 'FRA="Commandes achat ouvertes"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Blanket Order");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Purchase Order"; STRSUBSTNO(Txt1, NbrOfPurchOrder))
            {
                Caption = 'Purchase Order', Comment = 'FRA="Commandes achat"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Purchase Invoice"; STRSUBSTNO(Txt1, NbrOfPurchInvoice))
            {
                Caption = 'Purchase Invoice', Comment = 'FRA="Factures achat"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Purchase Return"; STRSUBSTNO(Txt1, NbrOfPurchReturn))
            {
                Caption = 'Purchase Return', Comment = 'FRA="Retours achat"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Purchase Credit Memo"; STRSUBSTNO(Txt1, NbrOfPurchCrdMemo))
            {
                Caption = 'Purchase Credit Memo', Comment = 'FRA="Avoirs achat"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchLines.RESET();
                    CLEAR(PagGPurchaseLinesSubform2);
                    RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");
                    RecGPurchLines.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchLines.SETRANGE("No.", Rec."No.");
                    PagGPurchaseLinesSubform2.SETTABLEVIEW(RecGPurchLines);
                    PagGPurchaseLinesSubform2.RUN();
                end;
            }
            field("Posted Purchase Receipt"; STRSUBSTNO(Txt1, NbrOfPurchPostedRcpt))
            {
                Caption = 'Posted Purchase Receipt', Comment = 'FRA="Réceptions achat enregistrées"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchPostedRcpt.RESET();
                    CLEAR(PagGPurchRcpLinesSubform);
                    RecGPurchPostedRcpt.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedRcpt.SETRANGE("No.", Rec."No.");
                    PagGPurchRcpLinesSubform.SETTABLEVIEW(RecGPurchPostedRcpt);
                    PagGPurchRcpLinesSubform.RUN();
                end;
            }
            field("Posted Purchase Invoice"; STRSUBSTNO(Txt1, NbrOfPurchPostedInvoice))
            {
                Caption = 'Posted Purchase Invoice', Comment = 'FRA="Factures achat enregistrées"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    RecGPurchPostedInvoice.RESET();
                    CLEAR(PagGPurchInvLineSubform);
                    RecGPurchPostedInvoice.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedInvoice.SETRANGE("No.", Rec."No.");
                    PagGPurchInvLineSubform.SETTABLEVIEW(RecGPurchPostedInvoice);
                    PagGPurchInvLineSubform.RUN();
                end;
            }
            field("Posted Purchase Return Shipement"; STRSUBSTNO(Txt1, NbrOfPurchPostedReturnShipemen))
            {
                Caption = 'Posted Purchase Return Shipement', Comment = 'FRA="Expéditions retour achat"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin

                    RecGPurchPostedReturnShipement.RESET();
                    CLEAR(PagGReturnShipmentLineSubform);
                    RecGPurchPostedReturnShipement.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedReturnShipement.SETRANGE("No.", Rec."No.");
                    PagGReturnShipmentLineSubform.SETTABLEVIEW(RecGPurchPostedReturnShipement);
                    PagGReturnShipmentLineSubform.RUN();
                end;
            }
            field("Posted Purchase Credit Memo"; STRSUBSTNO(Txt1, NbrOfPurchPostedCrdMemo))
            {
                Caption = 'Posted Purchase Credit Memo', Comment = 'FRA="Avoirs achat enregistrés"';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin

                    RecGPurchPostedCrdMemo.RESET();
                    CLEAR(PagGPurchCrMemoLineSubform);
                    RecGPurchPostedCrdMemo.SETRANGE("Buy-from Vendor No.", RecGVendor."No.");
                    RecGPurchPostedCrdMemo.SETRANGE("No.", Rec."No.");
                    PagGPurchCrMemoLineSubform.SETTABLEVIEW(RecGPurchPostedCrdMemo);
                    PagGPurchCrMemoLineSubform.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT RecGVendor.GET(Rec."Buy-from Vendor No.") THEN
            RecGVendor.INIT();
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

        IF Rec."No." = '' THEN
            EXIT;
        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Quote);

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FindSet() THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchQuote := NbrOfPurchQuote + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Blanket Order");

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchBlanketOrder := NbrOfPurchBlanketOrder + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Order);

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchOrder := NbrOfPurchOrder + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::Invoice);

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchInvoice := NbrOfPurchInvoice + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Return Order");

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchReturn := NbrOfPurchReturn + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchLines.RESET();
        RecGPurchLines.SETCURRENTKEY("Document Type", "No.");
        RecGPurchLines.SETFILTER("No.", Rec."No.");
        RecGPurchLines.SETRANGE("Document Type", RecGPurchLines."Document Type"::"Credit Memo");

        RecGPurchLines.SETCURRENTKEY(RecGPurchLines."Buy-from Vendor No.");
        RecGPurchLines.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        IF RecGPurchLines.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchLines."Document No." THEN
                    NbrOfPurchCrdMemo := NbrOfPurchCrdMemo + 1;
                CodGDocNo := RecGPurchLines."Document No.";
            UNTIL RecGPurchLines.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchPostedRcpt.RESET();
        RecGPurchPostedRcpt.SETCURRENTKEY("No.");
        RecGPurchPostedRcpt.SETFILTER("No.", Rec."No.");
        RecGPurchPostedRcpt.SETCURRENTKEY(RecGPurchPostedRcpt."Buy-from Vendor No.");
        RecGPurchPostedRcpt.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");

        IF RecGPurchPostedRcpt.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedRcpt."Document No." THEN
                    NbrOfPurchPostedRcpt := NbrOfPurchPostedRcpt + 1;
                CodGDocNo := RecGPurchPostedRcpt."Document No.";
            UNTIL RecGPurchPostedRcpt.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchPostedInvoice.RESET();
        RecGPurchPostedInvoice.SETCURRENTKEY("No.");
        RecGPurchPostedInvoice.SETFILTER("No.", Rec."No.");

        RecGPurchPostedInvoice.SETCURRENTKEY(RecGPurchPostedInvoice."Buy-from Vendor No.");
        RecGPurchPostedInvoice.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");

        IF RecGPurchPostedInvoice.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedInvoice."Document No." THEN
                    NbrOfPurchPostedInvoice := NbrOfPurchPostedInvoice + 1;
                CodGDocNo := RecGPurchPostedInvoice."Document No.";
            UNTIL RecGPurchPostedInvoice.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchPostedReturnShipement.RESET();
        RecGPurchPostedReturnShipement.SETCURRENTKEY("No.");
        RecGPurchPostedReturnShipement.SETFILTER("No.", Rec."No.");

        RecGPurchPostedReturnShipement.SETCURRENTKEY(RecGPurchPostedReturnShipement."Buy-from Vendor No.");
        RecGPurchPostedReturnShipement.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");

        IF RecGPurchPostedReturnShipement.FIND('-') THEN
            REPEAT
                IF CodGDocNo <> RecGPurchPostedReturnShipement."Document No." THEN
                    NbrOfPurchPostedReturnShipemen := NbrOfPurchPostedReturnShipemen + 1;
                CodGDocNo := RecGPurchPostedReturnShipement."Document No.";
            UNTIL RecGPurchPostedReturnShipement.NEXT() = 0;

        CLEAR(CodGDocNo);
        RecGPurchPostedCrdMemo.RESET();
        RecGPurchPostedCrdMemo.SETCURRENTKEY("No.");
        RecGPurchPostedCrdMemo.SETFILTER("No.", Rec."No.");

        RecGPurchPostedCrdMemo.SETCURRENTKEY(RecGPurchPostedCrdMemo."Buy-from Vendor No.");
        RecGPurchPostedCrdMemo.SETFILTER("Buy-from Vendor No.", Rec."Buy-from Vendor No.");

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
        RecGPurchPostedReturnShipement: Record "Return Shipment Line";
        RecGVendor: Record Vendor;
        PagGPurchInvLineSubform: Page "BC6_Purch. Inv. Line Subform";
        PagGPurchRcpLinesSubform: Page "BC6_Purch. Rcpt. Lines Subform";
        PagGPurchaseLinesSubform2: Page "BC6_Purchase Lines Subform2";
        PagGReturnShipmentLineSubform: Page "BC6_Return Ship. Line Subform";
        PagGPurchCrMemoLineSubform: Page "Purch. Cr. Memo Line Subform";
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
        Txt1: Label '(%1)';

    procedure ShowDetails()
    begin

        PAGE.RUN(PAGE::"Vendor Card", RecGVendor);
    end;
}
