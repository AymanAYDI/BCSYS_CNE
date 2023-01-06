page 50041 "BC6_Sales Lines Subform 3"
{
    Caption = 'Sales Lines', Comment = 'FRA="Lignes vente"';
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Lookup = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Document Date flow"; Rec."BC6_Document Date flow")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Purchase cost"; Rec."BC6_Purchase cost")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; Rec."BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankNumbers = DontBlank;
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; Rec."BC6_DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Discount unit price"; Rec."BC6_Discount unit price")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Show)
            {
                Caption = 'Show', Comment = 'FRA="Afficher"';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF NOT RecGSalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN
                        EXIT;
                    IF Rec."Document Type" = Rec."Document Type"::"Credit Memo" THEN
                        PAGE.RUN(PAGE::"Sales Credit Memo", RecGSalesHeader);
                    IF Rec."Document Type" = Rec."Document Type"::Order THEN
                        PAGE.RUN(PAGE::"Sales Order", RecGSalesHeader);
                    IF Rec."Document Type" = Rec."Document Type"::Quote THEN
                        PAGE.RUN(PAGE::"Sales Quote", RecGSalesHeader);

                    IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
                        PAGE.RUN(PAGE::"Sales Invoice", RecGSalesHeader);

                    IF Rec."Document Type" = Rec."Document Type"::"Blanket Order" THEN
                        PAGE.RUN(PAGE::"Blanket Sales Order", RecGSalesHeader);

                    IF Rec."Document Type" = Rec."Document Type"::"Return Order" THEN
                        PAGE.RUN(PAGE::"Sales Return Order", RecGSalesHeader);

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    trigger OnOpenPage()
    begin

        Rec.CALCFIELDS("BC6_Document Date flow");
        REPEAT
            Rec."BC6_Document Date" := Rec."BC6_Document Date flow";
        UNTIL Rec.NEXT() = 0;
        //SETCURRENTKEY("Document Type","No.");
    end;

    var
        RecGSalesHeader: Record "Sales Header";
        TempSalesLine: Record "Sales Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        TempSalesLine.RESET();
        TempSalesLine.COPYFILTERS(Rec);
        TempSalesLine.SETRANGE("Document Type", Rec."Document Type");
        TempSalesLine.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempSalesLine.FIND('-') THEN BEGIN
            SalesLine.COPYFILTERS(Rec);
            SalesLine.SETRANGE("Document Type", Rec."Document Type");
            SalesLine.SETRANGE("Document No.", Rec."Document No.");
            SalesLine.FindFirst();
            TempSalesLine := SalesLine;
            TempSalesLine.INSERT();
        END;
        IF Rec."Line No." = TempSalesLine."Line No." THEN
            EXIT(TRUE);
    end;

    procedure GetSelectedLine(var FromSalesLine: Record "Sales Line")
    begin
        FromSalesLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

