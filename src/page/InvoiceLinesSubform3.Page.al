page 50043 "Invoice Lines Subform 3"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B : MA 19/11/2007 :
    //   - Add fields
    // 
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change size
    // 
    // ------------------------------------------------------------------------

    Caption = 'Sales Invoice Lines';
    Editable = false;
    PageType = List;
    SourceTable = Table113;
    SourceTableView = SORTING (No.);

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
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Discount Unit Price"; "Discount Unit Price")
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Line Amount"; "Line Amount")
                {
                }
                field("Public Price"; "Public Price")
                {
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
                    BlankZero = true;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
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
                field("Posting Date"; "Posting Date")
                {
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
                    IF NOT RecGSalesInvoiceHeader.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Sales Invoice", RecGSalesInvoiceHeader);
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

    var
        TempSalesInvLine: Record "113" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        RecGSalesInvoiceHeader: Record "112";

    local procedure IsFirstDocLine(): Boolean
    var
        SalesInvLine: Record "113";
    begin
        TempSalesInvLine.RESET;
        TempSalesInvLine.COPYFILTERS(Rec);
        TempSalesInvLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesInvLine.FIND('-') THEN BEGIN
            SalesInvLine.COPYFILTERS(Rec);
            SalesInvLine.SETRANGE("Document No.", "Document No.");
            SalesInvLine.FIND('-');
            TempSalesInvLine := SalesInvLine;
            TempSalesInvLine.INSERT;
        END;
        EXIT("Line No." = TempSalesInvLine."Line No.");
    end;

    [Scope('Internal')]
    procedure GetSelectedLine(var FromSalesInvLine: Record "113")
    begin
        FromSalesInvLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesInvLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

