page 50017 "BC6_Purch. Rcpt. Lines Subform"
{
    Caption = 'Purch. Rcpt. Line', comment = 'FRA="Reception lignes achats"';
    PageType = List;
    SaveValues = true;
    SourceTable = "Purch. Rcpt. Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
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
                Caption = '&Show', comment = 'FRA="Affic&her"';
                Image = Document;

                trigger OnAction()
                begin

                    IF NOT RecGPurchPostedRcptHeader.GET(Rec."Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Receipt", RecGPurchPostedRcptHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    trigger OnOpenPage()
    begin
        Rec.SETCURRENTKEY("No.");
    end;

    var
        RecGPurchPostedRcptHeader: Record "Purch. Rcpt. Header";
        TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    procedure IsFirstDocLine(): Boolean
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        TempPurchRcptLine.RESET();
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Document No.", Rec."Document No.");

        IF NOT TempPurchRcptLine.FindFirst() THEN BEGIN
            PurchRcptLine.COPYFILTERS(Rec);
            PurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
            PurchRcptLine.FindLast();
            TempPurchRcptLine := PurchRcptLine;
            TempPurchRcptLine.INSERT();
        END;
        IF Rec."Line No." = TempPurchRcptLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Document No." <> '' THEN
            IF IsFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}


