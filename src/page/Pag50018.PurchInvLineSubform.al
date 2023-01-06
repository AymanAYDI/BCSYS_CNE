page 50018 "BC6_Purch. Inv. Line Subform"
{
    Caption = 'Purchase Invoice Lines', comment = 'FRA="Lignes Facture Achat"';
    PageType = ListPart;
    SourceTable = "Purch. Inv. Line";
    UsageCategory = None;
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
                field("Line Discount Amount"; Rec."Line Discount Amount")
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
                    IF NOT RecGPurchInvHeader.GET(Rec."Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", RecGPurchInvHeader);
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
        RecGPurchInvHeader: Record "Purch. Inv. Header";
        TempPurchInvoice: Record "Purch. Inv. Line" temporary;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;


    procedure isFirstdocLine(): Boolean
    var
        PurchInvoice: Record "Purch. Inv. Line";
    begin
        TempPurchInvoice.RESET();
        TempPurchInvoice.COPYFILTERS(Rec);
        TempPurchInvoice.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempPurchInvoice.FindFirst() THEN BEGIN
            PurchInvoice.COPYFILTERS(Rec);
            PurchInvoice.SETRANGE("Document No.", Rec."Document No.");
            PurchInvoice.FindLast();
            TempPurchInvoice := PurchInvoice;
            TempPurchInvoice.INSERT();
        END;
        IF Rec."Line No." = TempPurchInvoice."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Document No." <> '' THEN
            IF isFirstdocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

