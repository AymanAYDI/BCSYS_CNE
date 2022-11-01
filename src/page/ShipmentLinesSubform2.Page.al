page 50037 "Shipment Lines Subform 2"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B : MA 19/11/2007 :
    //   - Add fields
    // ------------------------------------------------------------------------

    Caption = 'Shipment Lines Subform';
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = Table111;
    SourceTableView = SORTING (Bill-to Customer No.);

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
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                }
                field("Purchase Cost"; "Purchase Cost")
                {
                }
                field("Public Price"; "Public Price")
                {
                }
                field("Discount Unit Price"; "Discount Unit Price")
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
                field("Currency Code"; "Currency Code")
                {
                    DrillDown = false;
                    Lookup = false;
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
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
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
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    var
        TempSalesShptLine: Record "111" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesShptLine: Record "111";
    begin
        TempSalesShptLine.RESET;
        TempSalesShptLine.COPYFILTERS(Rec);
        TempSalesShptLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesShptLine.FIND('-') THEN BEGIN
            SalesShptLine.COPYFILTERS(Rec);
            SalesShptLine.SETRANGE("Document No.", "Document No.");
            SalesShptLine.FIND('-');
            TempSalesShptLine := SalesShptLine;
            TempSalesShptLine.INSERT;
        END;
        IF "Line No." = TempSalesShptLine."Line No." THEN
            EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure GetSelectedLine(var FromSalesShptLine: Record "111")
    begin
        FromSalesShptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesShptLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

