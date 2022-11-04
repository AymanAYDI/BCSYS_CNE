page 50036 "BC6_Sales Lines Subform 2"
{
    Caption = 'Sales Lines Subform';
    Editable = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Bill-to Customer No.", "Currency Code");

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
                }
                field("Document Date flow"; "BC6_Document Date flow")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Profit %"; "Profit %")
                {
                }
                field("Purchase cost"; "BC6_Purchase cost")
                {
                }
                field("Public Price"; "BC6_Public Price")
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
                field("DEEE Category Code"; "BC6_DEEE Category Code")
                {
                }
                field("DEEE Unit Price"; "BC6_DEEE Unit Price")
                {
                }
                field("DEEE HT Amount"; "BC6_DEEE HT Amount")
                {
                }
                field("DEEE VAT Amount"; "BC6_DEEE VAT Amount")
                {
                }
                field("DEEE TTC Amount"; "BC6_DEEE TTC Amount")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                }
                field("Discount unit price"; "BC6_Discount unit price")
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
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    trigger OnOpenPage()
    begin

        CALCFIELDS("BC6_Document Date flow");
        REPEAT
            "BC6_Document Date" := "BC6_Document Date flow";
        UNTIL Rec.NEXT() = 0;
        //SETCURRENTKEY("Document Type","No.");
    end;

    var
        TempSalesLine: Record "Sales Line" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        TempSalesLine.RESET();
        TempSalesLine.COPYFILTERS(Rec);
        TempSalesLine.SETRANGE("Document Type", "Document Type");
        TempSalesLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesLine.FIND('-') THEN BEGIN
            SalesLine.COPYFILTERS(Rec);
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "Document No.");
            SalesLine.FIND('-');
            TempSalesLine := SalesLine;
            TempSalesLine.INSERT();
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
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

