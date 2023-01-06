page 50039 "BC6_Cred. Memo Lines Subform 2"
{
    Caption = 'Credit Memo Purachase Lines', Comment = 'FRA="Lignes avoir vente"';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";
    SourceTableView = SORTING("Bill-to Customer No.");
    UsageCategory = Lists;
    ApplicationArea = All;
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
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
                field("Public Price"; Rec."BC6_Public Price")
                {
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
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
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
                Caption = '&Show', Comment = 'FRA="Affic&her"';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF NOT RecGSalesCrMemoHeader.GET(Rec."Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Sales Credit Memo", RecGSalesCrMemoHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    var
        RecGSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        TempSalesCrMemoLine.RESET();
        TempSalesCrMemoLine.COPYFILTERS(Rec);
        TempSalesCrMemoLine.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempSalesCrMemoLine.FindSet() THEN BEGIN
            SalesCrMemoLine.COPYFILTERS(Rec);
            SalesCrMemoLine.SETRANGE("Document No.", Rec."Document No.");
            SalesCrMemoLine.Find('-');
            TempSalesCrMemoLine := SalesCrMemoLine;
            TempSalesCrMemoLine.INSERT();
        END;
        EXIT(Rec."Line No." = TempSalesCrMemoLine."Line No.");
    end;


    procedure GetSelectedLine(var FromSalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        FromSalesCrMemoLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromSalesCrMemoLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

