page 50041 "Sales Lines Subform 3"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    // 
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B : MA 19/11/2007 :
    //   - Add fields
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change size
    // 
    // //>>MODIF HL
    // TI271161 DO.GEPO 24/03/2015 : change Key on this page
    // 
    // ------------------------------------------------------------------------

    Caption = 'Sales Lines';
    Editable = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = Table37;
    SourceTableView = SORTING (Shipment Date, Document Type, Sell-to Customer No., Document No., Line No.);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No."; "Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Lookup = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Document Date flow"; "Document Date flow")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Profit %"; "Profit %")
                {
                }
                field("Purchase cost"; "Purchase cost")
                {
                }
                field("Public Price"; "Public Price")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                }
                field(Nonstock; Nonstock)
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankNumbers = DontBlank;
                    BlankZero = true;
                }
                field("DEEE Category Code"; "DEEE Category Code")
                {
                }
                field("DEEE Unit Price"; "DEEE Unit Price")
                {
                }
                field("DEEE HT Amount"; "DEEE HT Amount")
                {
                }
                field("DEEE VAT Amount"; "DEEE VAT Amount")
                {
                }
                field("DEEE TTC Amount"; "DEEE TTC Amount")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                }
                field("Discount unit price"; "Discount unit price")
                {
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                }
                field("Qty. to Assign"; "Qty. to Assign")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Qty. Assigned"; "Qty. Assigned")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                }
                field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
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
                Caption = '&Show';
                Image = Document;

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

        CALCFIELDS("Document Date flow");
        REPEAT
            "Document Date" := "Document Date flow";
        UNTIL Rec.NEXT = 0;
        //SETCURRENTKEY("Document Type","No.");
    end;

    var
        TempSalesLine: Record "37" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        RecGSalesHeader: Record "36";

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "37";
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

    [Scope('Internal')]
    procedure GetSelectedLine(var FromSalesLine: Record "37")
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
