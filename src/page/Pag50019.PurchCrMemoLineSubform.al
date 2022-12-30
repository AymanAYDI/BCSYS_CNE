page 50019 "Purch. Cr. Memo Line Subform"
{
    Caption = 'Purch. Credit Memo Lines', comment = 'FRA="Lignes avoirs achat"';
    PageType = List;
    SourceTable = "Purch. Cr. Memo Line";

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
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
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
                    IF NOT RecGPurchCrMemoHdr.GET("Document No.") THEN
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
        SETCURRENTKEY("No.");
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
        TempPurchCrdMemo.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchCrdMemo.FindFirst() THEN BEGIN
            PurchCrdMemo.COPYFILTERS(Rec);
            PurchCrdMemo.SETRANGE("Document No.", "Document No.");
            PurchCrdMemo.FindLast();
            TempPurchCrdMemo := PurchCrdMemo;
            TempPurchCrdMemo.INSERT();
        END;
        IF "Line No." = TempPurchCrdMemo."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF isFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

