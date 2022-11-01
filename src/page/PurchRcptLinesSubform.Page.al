page 50017 "Purch. Rcpt. Lines Subform"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 10/11/2007 : suivi historique
    //             - Form Created
    // ------------------------------------------------------------------------

    Caption = 'Purch. Rcpt. Line';
    PageType = List;
    SaveValues = true;
    SourceTable = Table121;

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
                field("Unit of Measure"; "Unit of Measure")
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
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                }
                field("Promised Receipt Date"; "Promised Receipt Date")
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
                    //CurrForm.PurchRcptline.FORM.GETRECORD(RecGPurchPostedRcpt);
                    IF NOT RecGPurchPostedRcptHeader.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Receipt", RecGPurchPostedRcptHeader);
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
        TempPurchRcptLine: Record "121";
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        "-MIGNAV2013-": Integer;
        RecGPurchPostedRcptHeader: Record "120";

    [Scope('Internal')]
    procedure IsFirstDocLine(): Boolean
    var
        PurchRcptLine: Record "121";
    begin
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchRcptLine.FIND('-') THEN BEGIN
            PurchRcptLine.COPYFILTERS(Rec);
            PurchRcptLine.SETRANGE("Document No.", "Document No.");
            PurchRcptLine.FIND('-');
            TempPurchRcptLine := PurchRcptLine;
            TempPurchRcptLine.INSERT;
        END;
        IF "Line No." = TempPurchRcptLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF IsFirstDocLine THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

