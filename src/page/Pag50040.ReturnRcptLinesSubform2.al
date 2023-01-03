page 50040 "Return Rcpt Lines Subform 2"
{
    Caption = 'Return Rcpt Lines', Comment = 'FRA="Lignes réception retour"';
    Editable = false;
    PageType = List;
    SourceTable = "Return Receipt Line";
    SourceTableView = SORTING("Sell-to Customer No.");
    UsageCategory = Lists;
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
                field("Shipment Date"; "Shipment Date")
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
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; "BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; "Item Reference No.")
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
                    IF NOT RecGReturnReceiptHeader.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Return Receipt", RecGReturnReceiptHeader);
                    //<<MIGRATION NAV 2013
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
        RecGReturnReceiptHeader: Record "Return Receipt Header";
        TempReturnRcptLine: Record "Return Receipt Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        ReturnRcptLine: Record "Return Receipt Line";
    begin
        TempReturnRcptLine.RESET();
        TempReturnRcptLine.COPYFILTERS(Rec);
        TempReturnRcptLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempReturnRcptLine.FIND('-') THEN BEGIN
            ReturnRcptLine.COPYFILTERS(Rec);
            ReturnRcptLine.SETRANGE("Document No.", "Document No.");
#pragma warning disable AA0181
            ReturnRcptLine.FindFirst();
#pragma warning restore AA0181
            TempReturnRcptLine := ReturnRcptLine;
            TempReturnRcptLine.INSERT();
        END;
        IF "Line No." = TempReturnRcptLine."Line No." THEN
            EXIT(TRUE);
    end;


    procedure GetSelectedLine(var FromReturnRcptLine: Record "Return Receipt Line")
    begin
        FromReturnRcptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromReturnRcptLine);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

