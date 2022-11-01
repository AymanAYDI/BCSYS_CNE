page 50018 "BC6_Purch. Inv. Line Subform"
{
    Caption = 'Purchase Invoice Lines';
    PageType = List;
    SourceTable = "Purch. Inv. Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field("VAT %"; "VAT %")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
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
                Caption = '&Show';
                Image = Document;

                trigger OnAction()
                begin
                    IF NOT RecGPurchInvHeader.GET("Document No.") THEN
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
        SETCURRENTKEY("No.");
    end;

    var
        RecGPurchInvHeader: Record "Purch. Inv. Header";
        TempPurchInvoice: Record "Purch. Inv. Line";
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        "-MIGNAV2013-": Integer;


    procedure isFirstdocLine(): Boolean
    var
        PurchInvoice: Record "Purch. Inv. Line";
    begin
        TempPurchInvoice.RESET();
        TempPurchInvoice.COPYFILTERS(Rec);
        TempPurchInvoice.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchInvoice.FIND('-') THEN BEGIN
            PurchInvoice.COPYFILTERS(Rec);
            PurchInvoice.SETRANGE("Document No.", "Document No.");
            PurchInvoice.FIND('-');
            TempPurchInvoice := PurchInvoice;
            TempPurchInvoice.INSERT();
        END;
        IF "Line No." = TempPurchInvoice."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF isFirstdocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

