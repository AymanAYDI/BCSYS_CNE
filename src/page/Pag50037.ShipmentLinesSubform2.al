page 50037 "BC6_Shipment Lines Subform 2"
{
    Caption = 'Shipment Lines Subform', Comment = 'FRA="Sous-formulaire lignes expédition"';
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Sales Shipment Line";
    SourceTableView = SORTING("Bill-to Customer No.");
    UsageCategory = Lists;
    ApplicationArea = All;

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
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; "BC6_Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Purchase Cost"; "BC6_Purchase Cost")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; "BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("Discount Unit Price"; "BC6_Discount Unit Price")
                {
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
#pragma warning disable AL0432
                field("Cross-Reference No."; "Cross-Reference No.")
#pragma warning restore AL0432
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
                    DrillDown = false;
                    Lookup = false;
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
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
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

    var
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesShptLine: Record "Sales Shipment Line";
    begin
        TempSalesShptLine.RESET();
        TempSalesShptLine.COPYFILTERS(Rec);
        TempSalesShptLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesShptLine.FIND('-') THEN BEGIN
            SalesShptLine.COPYFILTERS(Rec);
            SalesShptLine.SETRANGE("Document No.", "Document No.");
            SalesShptLine.FindFirst();
            TempSalesShptLine := SalesShptLine;
            TempSalesShptLine.INSERT();
        END;
        IF "Line No." = TempSalesShptLine."Line No." THEN
            EXIT(TRUE);
    end;


    procedure GetSelectedLine(var FromSalesShptLine: Record "Sales Shipment Line")
    begin
        FromSalesShptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesShptLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

