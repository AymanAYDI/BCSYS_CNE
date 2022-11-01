page 50044 "Credit Memo Lines Subform 4"
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

    Caption = 'Credit Memo Lines Subform';
    Editable = false;
    PageType = List;
    SourceTable = Table115;
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
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                }
                field("Discount unit price"; "Discount unit price")
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
        TempSalesCrMemoLine: Record "115" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesCrMemoLine: Record "115";
    begin
        TempSalesCrMemoLine.RESET;
        TempSalesCrMemoLine.COPYFILTERS(Rec);
        TempSalesCrMemoLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesCrMemoLine.FIND('-') THEN BEGIN
            SalesCrMemoLine.COPYFILTERS(Rec);
            SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
            SalesCrMemoLine.FIND('-');
            TempSalesCrMemoLine := SalesCrMemoLine;
            TempSalesCrMemoLine.INSERT;
        END;
        EXIT("Line No." = TempSalesCrMemoLine."Line No.");
    end;

    [Scope('Internal')]
    procedure GetSelectedLine(var FromSalesCrMemoLine: Record "115")
    begin
        FromSalesCrMemoLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesCrMemoLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

