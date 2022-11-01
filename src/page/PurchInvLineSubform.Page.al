page 50018 "Purch. Inv. Line Subform"
{
    //  ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 10/11/2007 : suivi historique
    //             - Form Created
    // ------------------------------------------------------------------------

    Caption = 'Purchase Invoice Lines';
    PageType = List;
    SourceTable = Table123;

    layout
    {
        area(content)
        {
            repeater()
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

                    //>>MIGRATION NAV 2013
                    IF NOT RecGPurchInvHeader.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", RecGPurchInvHeader);
                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("No.");
    end;

    var
        TempPurchInvoice: Record "123";
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        "-MIGNAV2013-": Integer;
        RecGPurchInvHeader: Record "122";

    [Scope('Internal')]
    procedure isFirstdocLine(): Boolean
    var
        PurchInvoice: Record "123";
    begin
        TempPurchInvoice.RESET;
        TempPurchInvoice.COPYFILTERS(Rec);
        TempPurchInvoice.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchInvoice.FIND('-') THEN BEGIN
            PurchInvoice.COPYFILTERS(Rec);
            PurchInvoice.SETRANGE("Document No.", "Document No.");
            PurchInvoice.FIND('-');
            TempPurchInvoice := PurchInvoice;
            TempPurchInvoice.INSERT;
        END;
        IF "Line No." = TempPurchInvoice."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF isFirstdocLine THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

