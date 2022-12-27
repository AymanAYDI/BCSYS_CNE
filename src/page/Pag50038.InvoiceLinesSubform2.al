page 50038 "BC6_Invoice Lines Subform 2"
{
    Caption = 'Invoice Lines Subform', Comment = 'FRA="Sous-formulaire lignes facture"';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
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
                field("Discount Unit Price"; "BC6_Discount Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; "BC6_Public Price")
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
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
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
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    var
        TempSalesInvLine: Record "Sales Invoice Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        TempSalesInvLine.RESET();
        TempSalesInvLine.COPYFILTERS(Rec);
        TempSalesInvLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempSalesInvLine.FIND('-') THEN BEGIN
            SalesInvLine.COPYFILTERS(Rec);
            SalesInvLine.SETRANGE("Document No.", "Document No.");
            SalesInvLine.FindFirst();
            TempSalesInvLine := SalesInvLine;
            TempSalesInvLine.INSERT();
        END;
        EXIT("Line No." = TempSalesInvLine."Line No.");
    end;


    procedure GetSelectedLine(var FromSalesInvLine: Record "Sales Invoice Line")
    begin
        FromSalesInvLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesInvLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

