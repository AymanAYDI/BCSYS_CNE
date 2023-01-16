page 50019 "BC6_Purch. Cr. Memo Line Sub"
{
    Caption = 'Purch. Credit Memo Lines', comment = 'FRA="Lignes avoirs achat"';
    PageType = ListPart;
    SourceTable = "Purch. Cr. Memo Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    HideValue = "Document No.HideValue";
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
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
                ApplicationArea = All;
                Caption = '&Show', comment = 'FRA="Affic&her"';
                Image = Document;

                trigger OnAction()
                begin
                    IF NOT RecGPurchCrMemoHdr.GET(Rec."Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", RecGPurchCrMemoHdr);
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
        RecGPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TempPurchCrdMemo: Record "Purch. Cr. Memo Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    procedure isFirstDocLine(): Boolean
    var
        PurchCrdMemo: Record "Purch. Cr. Memo Line";
    begin
        TempPurchCrdMemo.RESET();
        TempPurchCrdMemo.COPYFILTERS(Rec);
        TempPurchCrdMemo.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempPurchCrdMemo.FindFirst() THEN BEGIN
            PurchCrdMemo.COPYFILTERS(Rec);
            PurchCrdMemo.SETRANGE("Document No.", Rec."Document No.");
            PurchCrdMemo.FindLast();
            TempPurchCrdMemo := PurchCrdMemo;
            TempPurchCrdMemo.INSERT();
        END;
        IF Rec."Line No." = TempPurchCrdMemo."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Document No." <> '' THEN
            IF isFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}
