page 50041 "BC6_Sales Lines Subform 3"
{
    Caption = 'Sales Lines', Comment = 'FRA="Lignes vente"';
    Editable = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Lookup = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Document Date flow"; "BC6_Document Date flow")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = All;
                }
                field("Purchase cost"; "BC6_Purchase cost")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; "BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankNumbers = DontBlank;
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; "BC6_DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Price"; "BC6_DEEE Unit Price")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; "BC6_DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; "BC6_DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; "BC6_DEEE TTC Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Discount unit price"; "BC6_Discount unit price")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; "Qty. to Assign")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; "Qty. Assigned")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
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
                    //>>MIGRATION NAV 2013
                    //CurrForm.PurchRcptline.FORM.GETRECORD(RecGPurchPostedRcpt);
                    IF NOT RecGSalesHeader.GET("Document Type", "Document No.") THEN
                        EXIT;
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN
                        PAGE.RUN(PAGE::"Sales Credit Memo", RecGSalesHeader);
                    IF "Document Type" = "Document Type"::Order THEN
                        PAGE.RUN(PAGE::"Sales Order", RecGSalesHeader);
                    IF "Document Type" = "Document Type"::Quote THEN
                        PAGE.RUN(PAGE::"Sales Quote", RecGSalesHeader);

                    IF "Document Type" = "Document Type"::Invoice THEN
                        PAGE.RUN(PAGE::"Sales Invoice", RecGSalesHeader);

                    IF "Document Type" = "Document Type"::"Blanket Order" THEN
                        PAGE.RUN(PAGE::"Blanket Sales Order", RecGSalesHeader);

                    IF "Document Type" = "Document Type"::"Return Order" THEN
                        PAGE.RUN(PAGE::"Sales Return Order", RecGSalesHeader);

                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    trigger OnOpenPage()
    begin

        CALCFIELDS("BC6_Document Date flow");
        REPEAT
            "BC6_Document Date" := "BC6_Document Date flow";
        UNTIL Rec.NEXT = 0;
        //SETCURRENTKEY("Document Type","No.");
    end;

    var
        RecGSalesHeader: Record "Sales Header";
        TempSalesLine: Record "Sales Line" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        TempSalesLine.RESET;
        TempSalesLine.COPYFILTERS(Rec);
        TempSalesLine.SETRANGE("Document Type", "Document Type");
        TempSalesLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesLine.FIND('-') THEN BEGIN
            SalesLine.COPYFILTERS(Rec);
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "Document No.");
            SalesLine.FIND('-');
            TempSalesLine := SalesLine;
            TempSalesLine.INSERT;
        END;
        IF "Line No." = TempSalesLine."Line No." THEN
            EXIT(TRUE);
    end;

    procedure GetSelectedLine(var FromSalesLine: Record "Sales Line")
    begin
        FromSalesLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}
